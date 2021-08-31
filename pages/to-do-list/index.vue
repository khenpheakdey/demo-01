<template>
  <main class="flex flex-col items-center">
    <h1 class="text-3xl font-black p-10">To Do List</h1>
    <form @submit.prevent="addToList">
      <div class="flex flex-col">
        <input
          type="text"
          name="addItem"
          id="addItem"
          class="
            border
            focus:outline-none
            focus:ring-2 focus:ring-green-300
            focus:border-transparent
            mt-10
            mb-10
          "
          v-model="addItem"
        />
        <button class="bg-green-500 mb-10" type="submit">Add To Do List</button>
      </div>
    </form>
    <div class="border">
      <i class="fas fa-search"></i>
      <input
        type="text"
        name="searchbar"
        id="searchbar"
        placeholder="search"
        class="h-10"
        v-model="search"
      />
    </div>
    <!-- edit -->
    <div class="container">
      <table class="text-center">
        <thead>
          <tr>
            <th class="p-5"></th>
            <th class="w-1/2 border-collapse border border-green-800">
              Task Name
            </th>
            <th class="w-1/4 border-collapse border border-green-800">Edit</th>
            <th class="w-1/4 border-collapse border border-green-800">
              Remove
            </th>
          </tr>
        </thead>
        <tbody v-for="(item, idx) in filterLists" :key="`item-${idx}`">
          <tr class="border-b bg-red-100" v-if="item.check">
            <td class="p-5">
              <input class="" type="checkbox" id="idx" @click="onCheck(idx)" />
            </td>
            <td class="">
              <div v-if="!item.edit">
                <label class="m-10" v-if="!item.check">{{ item.title }}</label>
                <label class="m-10 line-through" v-else>{{ item.title }}</label>
              </div>
              <input
                type="text"
                v-if="item.edit"
                class="
                  focus:outline-none
                  focus:ring-2 focus:ring-green-300
                  focus:border-transparent
                  text-center
                "
                v-model="item.temp"
              />
            </td>
            <td class="">
              <i v-if="!item.edit" class="far fa-edit" @click="onEdit(idx)"></i>
              <i v-else class="far fa-save" @click="onUpdate(idx)"></i>
            </td>
            <td class="">
              <i class="far fa-trash-alt" @click="onRemove(idx)"></i>
            </td>
          </tr>
          <tr v-else-if="item.edit" class="border-b bg-yellow-100">
            <td class="p-5">
              <input class="" type="checkbox" id="idx" @click="onCheck(idx)" />
            </td>
            <td class="">
              <div v-if="!item.edit">
                <label class="m-10" v-if="!item.check">{{ item.title }}</label>
                <label class="m-10 line-through" v-else>{{ item.title }}</label>
              </div>
              <input
                type="text"
                v-if="item.edit"
                class="
                  focus:outline-none
                  focus:ring-2 focus:ring-green-300
                  focus:border-transparent
                  text-center
                "
                v-model="item.temp"
              />
              <label for="cancel" @click="onCancel(idx)">Cancel</label>
            </td>
            <td class="">
              <i v-if="!item.edit" class="far fa-edit" @click="onEdit(idx)"></i>
              <i v-else class="far fa-save" @click="onUpdate(idx)"></i>
            </td>
            <td class="">
              <i class="far fa-trash-alt" @click="onRemove(idx)"></i>
            </td>
          </tr>
          <!-- on edit -->
          <tr class="border-b bg-green-100" v-else>
            <td class="p-5">
              <input type="checkbox" id="idx" @click="onCheck(idx)" />
            </td>
            <td class="">
              <div v-if="!item.edit">
                <label class="m-10" v-if="!item.check">{{ item.title }}</label>
                <label class="m-10 line-through" v-else>{{ item.title }}</label>
              </div>
              <input
                type="text"
                v-if="item.edit"
                class="
                  focus:outline-none
                  focus:ring-2 focus:ring-green-300
                  focus:border-transparent
                  text-center
                "
                v-model="item.temp"
              />
            </td>
            <td class="">
              <i v-if="!item.edit" class="far fa-edit" @click="onEdit(idx)"></i>
              <i v-else class="far fa-save" @click="onUpdate(idx)"></i>
            </td>
            <td class="">
              <i class="far fa-trash-alt" @click="onRemove(idx)"></i>
            </td>
          </tr>
          <!-- end of edit -->
          <!-- on check -->

          <!-- end of check -->
        </tbody>
      </table>
      <div v-if="filterLists.length === 0">
        <h1 class="text-center pt-10">Item not found</h1>
      </div>
    </div>
    <!-- end of edit -->
  </main>
</template>

<script>
export default {
  data() {
    return {
      search: "",
      addItem: "",
      lists: [
        { title: "Task 1", check: false, edit: false, temp: "" },
        { title: "Task 2", check: false, edit: false, temp: "" },
      ],
    };
  },
  mounted() {},
  computed: {
    filterLists() {
      return this.lists.filter((list) => {
        return list.title.toLowerCase().includes(this.search.toLowerCase());
      });
    },
  },

  methods: {
    addToList() {
      if (this.addItem != "") {
        this.lists.push({
          title: this.addItem,
          check: false,
          edit: false,
          temp: "",
        });
      }
      this.addItem = "";
    },

    onCheck(index) {
      this.lists[index].check = !this.lists[index].check;
    },
    onEdit(index) {
      this.lists[index].temp = this.lists[index].title;
      this.lists[index].edit = !this.lists[index].edit;
    },
    onUpdate(index) {
      this.lists[index].title = this.lists[index].temp;
      this.lists[index].edit = !this.lists[index].edit;
    },
    onRemove(index) {
      this.lists.splice(index, 1);
    },
    onCancel(index) {
      this.lists[index].edit = !this.lists[index].edit;
    },
  },
};
</script>
