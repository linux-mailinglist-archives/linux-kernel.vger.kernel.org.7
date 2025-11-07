Return-Path: <linux-kernel+bounces-890071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B8FC3F31D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E966A34CA31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2B302166;
	Fri,  7 Nov 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqQV60Md"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981121578F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508333; cv=none; b=hVD9KC9kkzDNTyfvaWODABHgWyrjYLCzWudx56uz5gCp8yf0aiDfqqLxxLxOQKx9RGWmK76N0y66TXcW98von5K4qTdYNvub7toyqZsqIqR6l2zmax0EoEnNC1BGn8vNq5cuB6tn27lbKbh3wOCw9bmrL+HaQNtG+VIUpSlOetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508333; c=relaxed/simple;
	bh=sj8G0CUoartcPxXFAdQJrVtMlCMU5/QlpoX3U8XHqGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOi5KTONBBstJKJUMKG/00Qa3P1atoOB0FLQq6MiPwAnVoFmHpf/CPDqLDc9/5WCiacoNb0SB28eHxvlY5dGIBfvIe8MsCvgZ40iHaMVlButgJDBfHzbMPu4T8sZcLk+fMUyWP24KxiZdzKY8tJrMMD3COhFklYrvuPpwt1p078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TqQV60Md; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4773e108333so3068145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508330; x=1763113130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dE9bbheCp9V2aFuRlDh4WDEP/Ei7sW5/5LGgdkpufdc=;
        b=TqQV60Md5nBw5TlQDHMV6FZrFU+LKzKXNlnwgP0Hf7SDtvyP7p7Zmm8+2QebmcU/D3
         RSjbN1ixaDqy7iO3XQ/I4aVm3hMut2V/BpEuGKqI/t+qnGFc2pWB4IM0WGn5VYqewSBa
         ibWqwnTldQc/m+iq4EXn/d0IxV0CedkOlVObNMKb9RosW+CMrNT9L6ZTTklLLuEPCZEf
         4fjfud7PMfH3gWSHc27qJ51KjQ+Ugp1z6OfL6lNnbfUuWP2gH+wXVCdqbda0JcdV+oU/
         Cp0bO5K9OwtNW/vqXzrbGoS6+yLVpQ1RhSBrB2IIYZzocc/a4gck5/6RtpePweKbeH06
         sAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508330; x=1763113130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dE9bbheCp9V2aFuRlDh4WDEP/Ei7sW5/5LGgdkpufdc=;
        b=phwFV3AWwvcC92hORJFnItiwNghmbNi45X6xqn03QbiBtRqtmFKrFRQOBhek9O9Kjy
         RlUtS7lp74Py/bicolRCMljk6iJIlaLvvLPPJf2HtJqvxN7q1017npTK58nF5WpnPfF2
         X3EGv5/JiozLF5KffOKvO/N/DgYA3fgWdIJmKecsPkMeBPcS6lqo82ae4rwBfKEggDnl
         /JreXPt9D5dzxPZJgV04URHnmhvhy7jnj1rChrR7v/JQsUfnSl7pL2fhCtv352lxDchJ
         A1HehZpe4GSywOk2RGl3aHYjue3FjoSPBEMlmS0RnxGeTtS0mqOpXSLEJCcz3lGWje4h
         5Gdw==
X-Forwarded-Encrypted: i=1; AJvYcCX85F//IG6mkGv/M11muKpjQ3bBDVPqKEXGuiblVUZFlRqEJeJwfV4m2ea4gqWIAv4YjTdoYDdn6a4I4dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoW5jLFs589K/MyBM4VYcP20/baHgkz8+VUNPlyHnIQXY7liw
	sGRLfJkZ5w5VmdR9A+RIl5KAGWlM+w0xr5pdJvXwz4uXkC378p5Va3ceEUr+WwdPXu6PvJFb5C0
	zHnno187AF8dV61z8QsuZaQ==
X-Google-Smtp-Source: AGHT+IHJKQcuTuHVy5lW9/pddPtXEWrJkUHRKDzcCdWDYQlwal5t/VwhJiu80ev0kYlXjbKdm3HJXTGh6pg8IuqO
X-Received: from wmim9.prod.google.com ([2002:a7b:cb89:0:b0:46e:1f26:9212])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4512:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-4776bce1ae8mr18497205e9.25.1762508330429;
 Fri, 07 Nov 2025 01:38:50 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:14 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-3-vdonnefort@google.com>
Subject: [PATCH v8 02/28] ring-buffer: Store bpage pointers into subbuf_ids
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The subbuf_ids field allows to point to a specific page from the
ring-buffer based on its ID. As a preparation or the upcoming
ring-buffer remote support, point this array to the buffer_page instead
of the buffer_data_page.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6e912527e44f..80099a8b2495 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -519,7 +519,7 @@ struct ring_buffer_per_cpu {
 	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
-	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
 	struct ring_buffer_cpu_meta	*ring_meta;
 
@@ -7002,7 +7002,7 @@ static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 }
 
 static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
-				   unsigned long *subbuf_ids)
+				   struct buffer_page **subbuf_ids)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
@@ -7011,7 +7011,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	int id = 0;
 
 	id = rb_page_id(cpu_buffer, cpu_buffer->reader_page, id);
-	subbuf_ids[id++] = (unsigned long)cpu_buffer->reader_page->page;
+	subbuf_ids[id++] = cpu_buffer->reader_page;
 	cnt++;
 
 	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
@@ -7021,7 +7021,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 		if (WARN_ON(id >= nr_subbufs))
 			break;
 
-		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf_ids[id] = subbuf;
 
 		rb_inc_page(&subbuf);
 		id++;
@@ -7030,7 +7030,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(cnt != nr_subbufs);
 
-	/* install subbuf ID to kern VA translation */
+	/* install subbuf ID to bpage translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
 	meta->meta_struct_len = sizeof(*meta);
@@ -7186,13 +7186,15 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
+		struct buffer_page *subbuf;
 		struct page *page;
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs))
 			return -EINVAL;
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		subbuf = cpu_buffer->subbuf_ids[s];
+		page = virt_to_page((void *)subbuf->page);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
@@ -7219,7 +7221,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long flags, *subbuf_ids;
+	struct buffer_page **subbuf_ids;
+	unsigned long flags;
 	int err;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -7243,7 +7246,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (err)
 		return err;
 
-	/* subbuf_ids include the reader while nr_pages does not */
+	/* subbuf_ids includes the reader while nr_pages does not */
 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
-- 
2.51.2.1041.gc1ab5b90ca-goog


