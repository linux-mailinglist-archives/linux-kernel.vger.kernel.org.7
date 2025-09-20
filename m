Return-Path: <linux-kernel+bounces-825760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB80B8CC33
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5B87C3D9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E12264BD;
	Sat, 20 Sep 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q7d69AEI"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2C20FAA4
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383591; cv=none; b=VJMy4qaX+FF4UwhLHEoCKdQap4BzYPHaGM/d39qgSJxQsEkHJVkgcY2Ht/0I/Ifz1AjhnxLXguD6IHuuiPZMYk6JWWcxfc3eFIHlN7onV5OFMAjWEteVszb3mHD4dnPzVPgGgNONunZO2OzQlMzwvWHfNnbpqVUqmdJC8+5KgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383591; c=relaxed/simple;
	bh=10wXKQjRgv4bAqybPHYpNVsmkfWFTimeoJ+nehp1Kok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4P3TE5+W+hbszia0ovaIN2kGV2LWt66BhUxvSdym3cW7bqRlGe6wI1Fqz82H3r7k9KpQXOsOpzGxbtHgKJ20DiejjwGapTYGyZUyLrOEDE5fJzv+uM+fMZjdU+psS0k6mB+y9OfKLJmzDcanGFdUDpxt0DW22B3sffwFl070Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q7d69AEI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758383585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4R+LNPPHVqiPUhplnTH4YzkMqe1DPP5aQsQ3/OAm22g=;
	b=q7d69AEI+zI541k6/c6jA50SCYDZL2CO0gfR+j4/Cqfm7v0Bl2zDnH283tGNmksCy43qng
	WNMfChYLde7ouf84Lu41BWEY7hsIKSgqRvwt5zRcp8VJfGqqP1dfsfwFIH1zAGQfGwlhZe
	LWP4x2lWp7/J/DsBKdb1U18d8ayGHXk=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v3 1/2] bpf: Add lookup_and_delete_elem for BPF_MAP_STACK_TRACE
Date: Sat, 20 Sep 2025 23:52:10 +0800
Message-ID: <20250920155211.1354348-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The stacktrace map can be easily full, which will lead to failure in
obtaining the stack. In addition to increasing the size of the map,
another solution is to delete the stack_id after looking it up from
the user, so extend the existing bpf_map_lookup_and_delete_elem()
functionality to stacktrace map types.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/stackmap.c | 16 ++++++++++++++--
 kernel/bpf/syscall.c  |  8 +++++---
 3 files changed, 20 insertions(+), 6 deletions(-)

Change list:
 v1 -> v2:
  - typo s/detele/delete/.(Jiri)
  - make sure following lookup fails after deleting the stack_id with NOENT.(Jiri)
  - use '&key' directly as the update value.(Jiri)
  v1: https://lore.kernel.org/bpf/20250908113622.810652-1-chen.dylane@linux.dev
 v2 -> v3:
  - rename bpf_stackmap_copy_and_delete with bpf_stackmap_extract.(Andrii)
  v2: https://lore.kernel.org/bpf/20250909163223.864120-1-chen.dylane@linux.dev

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a..9d6f7671ba1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2703,7 +2703,7 @@ int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 			    u64 flags);
 
-int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value);
+int bpf_stackmap_extract(struct bpf_map *map, void *key, void *value, bool delete);
 
 int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 				 void *key, void *value, u64 map_flags);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7df..2e182a3ac4c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -646,7 +646,15 @@ static void *stack_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 /* Called from syscall */
-int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
+static int stack_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
+					    void *value, u64 flags)
+{
+	return bpf_stackmap_extract(map, key, value, true);
+}
+
+/* Called from syscall */
+int bpf_stackmap_extract(struct bpf_map *map, void *key, void *value,
+			 bool delete)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *old_bucket;
@@ -663,7 +671,10 @@ int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	memcpy(value, bucket->data, trace_len);
 	memset(value + trace_len, 0, map->value_size - trace_len);
 
-	old_bucket = xchg(&smap->buckets[id], bucket);
+	if (delete)
+		old_bucket = bucket;
+	else
+		old_bucket = xchg(&smap->buckets[id], bucket);
 	if (old_bucket)
 		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
 	return 0;
@@ -754,6 +765,7 @@ const struct bpf_map_ops stack_trace_map_ops = {
 	.map_free = stack_map_free,
 	.map_get_next_key = stack_map_get_next_key,
 	.map_lookup_elem = stack_map_lookup_elem,
+	.map_lookup_and_delete_elem = stack_map_lookup_and_delete_elem,
 	.map_update_elem = stack_map_update_elem,
 	.map_delete_elem = stack_map_delete_elem,
 	.map_check_btf = map_check_no_btf,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c3..c380a2576fc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -318,7 +318,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
-		err = bpf_stackmap_copy(map, key, value);
+		err = bpf_stackmap_extract(map, key, value, false);
 	} else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
 		err = bpf_fd_array_map_lookup_elem(map, key, value);
 	} else if (IS_FD_HASH(map)) {
@@ -1627,7 +1627,8 @@ struct bpf_map *bpf_map_inc_not_zero(struct bpf_map *map)
 }
 EXPORT_SYMBOL_GPL(bpf_map_inc_not_zero);
 
-int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
+int __weak bpf_stackmap_extract(struct bpf_map *map, void *key, void *value,
+				bool delete)
 {
 	return -ENOTSUPP;
 }
@@ -2158,7 +2159,8 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
 		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
-		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
+		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		if (!bpf_map_is_offloaded(map)) {
 			bpf_disable_instrumentation();
 			rcu_read_lock();
-- 
2.48.1


