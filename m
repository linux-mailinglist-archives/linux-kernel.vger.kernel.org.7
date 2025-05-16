Return-Path: <linux-kernel+bounces-651354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B347AB9DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5BD5012D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8AB154423;
	Fri, 16 May 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="26Ksl5sZ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32878F5D
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402842; cv=none; b=l8HhKV5iwhouIoVfgV1UvhD3t2L5yU+EEVVOAGZrTzg+mKJCmhA96r/hFo4zPiCjvtjvon5/y3O7IAC6rROEz7Do/3vOvZtnW94biCGw3iiuzQ5b6F14xL31ZvEJ0McaKB23PzMhANtcuEDglY6n/yTY10DA3JNae/33eIv8qI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402842; c=relaxed/simple;
	bh=3hmKkp2UgfqgnwTiKvAiGsCHnDyPlN4V6hi7KlRMG10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TU/cLxbd7CLcotYIWpGuW/w0sNEIumKo9mS4eKyAIFul5FdGSnHs7J+EXEja91dAhXFZ0xDTLaZgXDvFtUFa0C9Fc+a8/e3s4riW478V1sXKXv9q58eAR+NvmgIADUmCWX9Xv9GF86XLzF5RRQuDuhytFUzy2w8x8q+7LTrWMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=26Ksl5sZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-441d438a9b7so15371945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402838; x=1748007638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/fr1f9e6qq6KOt2ipnnFv7ET96gdal0UIvW/7YYX10=;
        b=26Ksl5sZHkf/kg08WRgBXA5BhndYNnIWFgZW4ucG+4OhBdUOcE7WF/fAJ/3eSZLAHa
         Lv7YgfTJRIR4jA2C972C6xBu8NmBi0/aWjly4S2GqnKhjMihHDLoAtHR/ha0Pn2mk4b/
         f5Zgfz3ahi4R/gUi48q/g7zrlg8ZxT7dj+l4SF2Sco4Sp6er6u63EiStDZyyxzl1+bDb
         KzFKRx9XaRyW8otRjfQmv7aZGJMl2ZkfsG8ZdJakEACPtVdRMRlT7rYkpaMkOwytEBYp
         P6G3QcFjimO4J40SAwA4A5vU6wp+zIuvsSbb/245kCgqQiUk3jlF6l9666sX49sxnHgF
         JVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402838; x=1748007638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/fr1f9e6qq6KOt2ipnnFv7ET96gdal0UIvW/7YYX10=;
        b=MR/rygblgX4LKNy5AVOaAna3hyay/RT8lL7BgiUwwCHzvG8l5fXRNUzMrFDwqiqJ+M
         BpMwj5t/E2BSC95ukx74geeSBV5dRDPinBlO8KyJe6Hk4oNkKE2PaGJVekIqLe1BDOlF
         oU3A1lvXoAdqurK5IZzLZv31M6KbeQYjxBqVXFin3HpywYhGP6zJVNoO4li/QNLghX5j
         /bC7bMDpDvUJN/llDKHUjzQyJ2dFrie/WVjU740qSShZ9az/ZgYdK1m8bfe6RE0vN1GX
         Zez/XP9ACu3ChtmlBQh5o8Jc5KMAWbw9UAVLH3xroRB/1IWwN2KQ2P2qZXIZZLqX2yiN
         hNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjwWr5vwVkoGo8t5+duKrCGwMzoAWHC1yZS4+Lt//PDBS7RkvcwGm+V0GX8t+noFztMP1nocULNbHiZLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVbx2pHkUhYNByy1F+ZOCWjMeEj0U1+XMX+xaF6AghHpet2a8
	Pd+/xOUBJWqQP1Lf+xz1+3rzvm+nTAeH1fi3ozg+WTMHv07gNFbLwQpqBEqSCEhriPXwKKYXswb
	c2PP+E/jWxv2IguZhkYS2+Q==
X-Google-Smtp-Source: AGHT+IGL2JPoE9KWzwk6BYmweqU7MZ7cG39MgrscMJcq3R8ttQBvNl9VSDKYGYABmyByLvSLPwOllRJedbm5cT2a
X-Received: from wmbfp26.prod.google.com ([2002:a05:600c:699a:b0:440:6830:ae64])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154c:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-442fd93d4fcmr28921035e9.5.1747402838271;
 Fri, 16 May 2025 06:40:38 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:08 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-3-vdonnefort@google.com>
Subject: [PATCH v5 02/25] ring-buffer: Introduce ring-buffer remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

A ring-buffer remote is an entity outside of the kernel (most likely a
firmware or a hypervisor) capable of writing events in a ring-buffer
following the same format as the tracefs ring-buffer.

To setup the ring-buffer on the kernel side, a description of the pages
forming the ring-buffer (struct trace_buffer_desc) must be given.
Callbacks (swap_reader_page and reset) must also be provided.

It is expected from the remote to keep the meta-page updated.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 56e27263acf8..e8c9571d7f6b 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -248,4 +248,62 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma);
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
+
+struct ring_buffer_desc {
+	int		cpu;
+	unsigned int	nr_page_va; /* excludes the meta page */
+	unsigned long	meta_va;
+	unsigned long	page_va[] __counted_by(nr_page_va);
+};
+
+struct trace_buffer_desc {
+	int		nr_cpus;
+	size_t		struct_len;
+	char		__data[]; /* list of ring_buffer_desc */
+};
+
+static inline struct ring_buffer_desc *__next_ring_buffer_desc(struct ring_buffer_desc *desc)
+{
+	size_t len = struct_size(desc, page_va, desc->nr_page_va);
+
+	return (struct ring_buffer_desc *)((void *)desc + len);
+}
+
+static inline struct ring_buffer_desc *__first_ring_buffer_desc(struct trace_buffer_desc *desc)
+{
+	return (struct ring_buffer_desc *)(&desc->__data[0]);
+}
+
+static inline size_t trace_buffer_desc_size(size_t buffer_size, unsigned int nr_cpus)
+{
+	unsigned int nr_pages = (buffer_size + PAGE_SIZE - 1) / PAGE_SIZE;
+	struct ring_buffer_desc *rbdesc;
+
+	return size_add(offsetof(struct trace_buffer_desc, __data),
+			size_mul(nr_cpus, struct_size(rbdesc, page_va, nr_pages)));
+}
+
+#define for_each_ring_buffer_desc(__pdesc, __cpu, __trace_pdesc)		\
+	for (__pdesc = __first_ring_buffer_desc(__trace_pdesc), __cpu = 0;	\
+	     (__cpu) < (__trace_pdesc)->nr_cpus;				\
+	     (__cpu)++, __pdesc = __next_ring_buffer_desc(__pdesc))
+
+struct ring_buffer_remote {
+	struct trace_buffer_desc	*desc;
+	int				(*swap_reader_page)(unsigned int cpu, void *priv);
+	int				(*reset)(unsigned int cpu, void *priv);
+	void				*priv;
+};
+
+int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu);
+
+struct trace_buffer *
+__ring_buffer_alloc_remote(struct ring_buffer_remote *remote,
+			   struct lock_class_key *key);
+
+#define ring_buffer_remote(remote)				\
+({								\
+	static struct lock_class_key __key;			\
+	__ring_buffer_alloc_remote(remote, &__key);		\
+})
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 06214588c05a..2aa7f77bdba0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -523,6 +523,8 @@ struct ring_buffer_per_cpu {
 	struct trace_buffer_meta	*meta_page;
 	struct ring_buffer_cpu_meta	*ring_meta;
 
+	struct ring_buffer_remote	*remote;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -545,6 +547,8 @@ struct trace_buffer {
 
 	struct ring_buffer_per_cpu	**buffers;
 
+	struct ring_buffer_remote	*remote;
+
 	struct hlist_node		node;
 	u64				(*clock)(void);
 
@@ -2198,6 +2202,40 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	return -ENOMEM;
 }
 
+static struct ring_buffer_desc *ring_buffer_desc(struct trace_buffer_desc *trace_desc, int cpu)
+{
+	struct ring_buffer_desc *desc, *end;
+	size_t len;
+	int i;
+
+	if (!trace_desc)
+		return NULL;
+
+	if (cpu >= trace_desc->nr_cpus)
+		return NULL;
+
+	end = (struct ring_buffer_desc *)((void *)trace_desc + trace_desc->struct_len);
+	desc = __first_ring_buffer_desc(trace_desc);
+	len = struct_size(desc, page_va, desc->nr_page_va);
+	desc = (struct ring_buffer_desc *)((void *)desc + (len * cpu));
+
+	if (desc < end && desc->cpu == cpu)
+		return desc;
+
+	/* Missing CPUs, need to linear search */
+	for_each_ring_buffer_desc(desc, i, trace_desc) {
+		if (desc->cpu == cpu)
+			return desc;
+	}
+
+	return NULL;
+}
+
+static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, int page_id)
+{
+	return page_id > desc->nr_page_va ? NULL : (void *)desc->page_va[page_id];
+}
+
 static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			     unsigned long nr_pages)
 {
@@ -2258,6 +2296,32 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
+	if (buffer->remote) {
+		struct ring_buffer_desc *desc = ring_buffer_desc(buffer->remote->desc, cpu);
+
+		if (!desc)
+			goto fail_free_reader;
+
+		cpu_buffer->remote = buffer->remote;
+		cpu_buffer->meta_page = (struct trace_buffer_meta *)(void *)desc->meta_va;
+		cpu_buffer->subbuf_ids = desc->page_va;
+		cpu_buffer->nr_pages = desc->nr_page_va - 1;
+
+		/* Remote buffers are read-only and immutable */
+		atomic_inc(&cpu_buffer->record_disabled);
+		atomic_inc(&cpu_buffer->resize_disabled);
+
+		bpage->page = ring_buffer_desc_page(desc, cpu_buffer->meta_page->reader.id);
+		if (!bpage->page)
+			goto fail_free_reader;
+		/*
+		 * The meta-page can only describe which of the ring-buffer page
+		 * is the reader. There is no need to init the rest of the
+		 * ring-buffer.
+		 */
+		return cpu_buffer;
+	}
+
 	if (buffer->range_addr_start) {
 		/*
 		 * Range mapped buffers have the same restrictions as memory
@@ -2335,6 +2399,10 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 
 	irq_work_sync(&cpu_buffer->irq_work.work);
 
+	/* remote ring-buffer. We do not own the data pages */
+	if (cpu_buffer->remote)
+		cpu_buffer->reader_page->page = NULL;
+
 	free_buffer_page(cpu_buffer->reader_page);
 
 	if (head) {
@@ -2357,7 +2425,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
 					 unsigned long scratch_size,
-					 struct lock_class_key *key)
+					 struct lock_class_key *key,
+					 struct ring_buffer_remote *remote)
 {
 	struct trace_buffer *buffer;
 	long nr_pages;
@@ -2385,6 +2454,11 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
+	if (remote) {
+		buffer->remote = remote;
+		/* The writer is remote. This ring-buffer is read-only */
+		atomic_inc(&buffer->record_disabled);
+	}
 
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
@@ -2504,7 +2578,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 					struct lock_class_key *key)
 {
 	/* Default buffer page size - one system page */
-	return alloc_buffer(size, flags, 0, 0, 0, 0, key);
+	return alloc_buffer(size, flags, 0, 0, 0, 0, key, NULL);
 
 }
 EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
@@ -2531,7 +2605,18 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 					       struct lock_class_key *key)
 {
 	return alloc_buffer(size, flags, order, start, start + range_size,
-			    scratch_size, key);
+			    scratch_size, key, NULL);
+}
+
+/**
+ * __ring_buffer_alloc_remote - allocate a new ring_buffer from a remote
+ * @remote: Contains a description of the ring-buffer pages and remote callbacks.
+ * @key: ring buffer reader_lock_key.
+ */
+struct trace_buffer *__ring_buffer_alloc_remote(struct ring_buffer_remote *remote,
+						struct lock_class_key *key)
+{
+	return alloc_buffer(0, 0, 0, 0, 0, 0, key, remote);
 }
 
 void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size)
@@ -5280,8 +5365,57 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 	}
 }
 
+static bool rb_read_remote_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	local_set(&cpu_buffer->entries, READ_ONCE(cpu_buffer->meta_page->entries));
+	local_set(&cpu_buffer->overrun, READ_ONCE(cpu_buffer->meta_page->overrun));
+	local_set(&cpu_buffer->pages_touched, READ_ONCE(cpu_buffer->meta_page->pages_touched));
+	local_set(&cpu_buffer->pages_lost, READ_ONCE(cpu_buffer->meta_page->pages_lost));
+	/*
+	 * No need to get the "read" field, it can be tracked here as any
+	 * reader will have to go through a rign_buffer_per_cpu.
+	 */
+
+	return rb_num_of_entries(cpu_buffer);
+}
+
 static struct buffer_page *
-rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
+__rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	u32 prev_reader;
+
+	if (!rb_read_remote_meta_page(cpu_buffer))
+		return NULL;
+
+	/* More to read on the reader page */
+	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_page)) {
+		if (!cpu_buffer->reader_page->read)
+			cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
+		return cpu_buffer->reader_page;
+	}
+
+	prev_reader = cpu_buffer->meta_page->reader.id;
+
+	WARN_ON_ONCE(cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
+							  cpu_buffer->remote->priv));
+	/* nr_pages doesn't include the reader page */
+	if (WARN_ON_ONCE(cpu_buffer->meta_page->reader.id > cpu_buffer->nr_pages))
+		return NULL;
+
+	cpu_buffer->reader_page->page =
+		(void *)cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
+	cpu_buffer->reader_page->id = cpu_buffer->meta_page->reader.id;
+	cpu_buffer->reader_page->read = 0;
+	cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
+	cpu_buffer->lost_events = cpu_buffer->meta_page->reader.lost_events;
+
+	WARN_ON_ONCE(prev_reader == cpu_buffer->meta_page->reader.id);
+
+	return rb_page_size(cpu_buffer->reader_page) ? cpu_buffer->reader_page : NULL;
+}
+
+static struct buffer_page *
+__rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct buffer_page *reader = NULL;
 	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
@@ -5452,6 +5586,13 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	return reader;
 }
 
+static struct buffer_page *
+rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return cpu_buffer->remote ? __rb_get_reader_page_from_remote(cpu_buffer) :
+				    __rb_get_reader_page(cpu_buffer);
+}
+
 static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct ring_buffer_event *event;
@@ -5856,7 +5997,7 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_iter *iter;
 
-	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+	if (!cpumask_test_cpu(cpu, buffer->cpumask) || buffer->remote)
 		return NULL;
 
 	iter = kzalloc(sizeof(*iter), flags);
@@ -6028,6 +6169,23 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct buffer_page *page;
 
+	if (cpu_buffer->remote) {
+		if (!cpu_buffer->remote->reset)
+			return;
+
+		cpu_buffer->remote->reset(cpu_buffer->cpu, cpu_buffer->remote->priv);
+		rb_read_remote_meta_page(cpu_buffer);
+
+		/* Read related values, not covered by the meta-page */
+		local_set(&cpu_buffer->pages_read, 0);
+		cpu_buffer->read = 0;
+		cpu_buffer->read_bytes = 0;
+		cpu_buffer->last_overrun = 0;
+		cpu_buffer->reader_page->read = 0;
+
+		return;
+	}
+
 	rb_head_page_deactivate(cpu_buffer);
 
 	cpu_buffer->head_page
@@ -6263,6 +6421,49 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_empty_cpu);
 
+int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags;
+
+	if (cpu != RING_BUFFER_ALL_CPUS) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			return -EINVAL;
+
+		cpu_buffer = buffer->buffers[cpu];
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		if (rb_read_remote_meta_page(cpu_buffer))
+			rb_wakeups(buffer, cpu_buffer);
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+		return 0;
+	}
+
+	/*
+	 * Make sure all the ring buffers are up to date before we start reading
+	 * them.
+	 */
+	for_each_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		rb_read_remote_meta_page(buffer->buffers[cpu]);
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+
+	for_each_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		if (rb_num_of_entries(cpu_buffer))
+			rb_wakeups(buffer, buffer->buffers[cpu]);
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_RING_BUFFER_ALLOW_SWAP
 /**
  * ring_buffer_swap_cpu - swap a CPU buffer between two ring buffers
@@ -6514,6 +6715,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	unsigned int commit;
 	unsigned int read;
 	u64 save_timestamp;
+	bool force_memcpy;
 	int ret = -1;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -6551,6 +6753,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
 
+	force_memcpy = cpu_buffer->mapped || cpu_buffer->remote;
+
 	/*
 	 * If this page has been partially read or
 	 * if len is not big enough to read the rest of the page or
@@ -6560,7 +6764,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 */
 	if (read || (len < (commit - read)) ||
 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
-	    cpu_buffer->mapped) {
+	    force_memcpy) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -7142,7 +7346,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	unsigned long flags, *subbuf_ids;
 	int err = 0;
 
-	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+	if (!cpumask_test_cpu(cpu, buffer->cpumask) || buffer->remote)
 		return -EINVAL;
 
 	cpu_buffer = buffer->buffers[cpu];
-- 
2.49.0.1101.gccaa498523-goog


