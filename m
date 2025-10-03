Return-Path: <linux-kernel+bounces-841325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF27BB7093
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B2D19E262A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0931F75A6;
	Fri,  3 Oct 2025 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQ1WSkI7"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF71DC994
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498742; cv=none; b=Yn8cdjEz954TRHzKH9bzeTe2yxe0HrIEmCWgplMsH1AWRTp3KT1uhXDc7WxKTMbOdMYZpLM4umcbu424KF4PIIntxE4BxCXTBD9OX8n0fzIrY7EnV9Up/AK0pK3Rasm7MELikrs+V/97sxBMWoDnXNJAOK6oEITia4vpHw+EFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498742; c=relaxed/simple;
	bh=Axj9ASylM0oaMpSPEZroxhw8H/MRLAYh+XigJLXbiIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qMC8lS4V9RuXUVH6Bz17+9lV8wkBWnZNTkHHa3RV1ahxNCTIZfA2+D79SwYu3FlbzjpQ4MmIeuKcUaJHjpL3D743ol2AwfGZ4v11HRdRB+GMQuGTsSYNkZMAI9WQCyFdSDuLI6rlda5yMSPh+LwXSV9iT3k4lAsPYKgVpaRVT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQ1WSkI7; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3f44000639fso1382583f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498739; x=1760103539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bc6LimOXID+Bku1FEoRJ/EirmTeTKYklVJFEb8YK50Y=;
        b=EQ1WSkI76iMHAlNQe54SNrwp4z6XB7qf9T1+pwmGNkQTQL18oHoqlRH69FH7np1rtb
         ZWEEXQpNlktuFamKnAOImcwWC5I72DJ48TfoxKtjVBumayOZyqQILBjG+nWzZj7kM0YG
         0r8a19FI5Adv0uRkzBxJcsVue+Ox2/cLyBx1AGXZ3ajdH0eb3mpTf5PD/6oMgyR/NEeA
         eZGMqy/wUyJfSz5v3cZO31sczXSzf2pwUIjT5PXz+unFOpTBkU1nklgQZANX5KPazNCs
         MwooH1VEv7cUK900BAbu+VyCHQpLeLXtff/3+GN39JA+KPP2TfwgJZKj7iAXJZHIVtsw
         aDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498739; x=1760103539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bc6LimOXID+Bku1FEoRJ/EirmTeTKYklVJFEb8YK50Y=;
        b=PizIq20pOYD9kFhW6mBdMp7nU8bDTHcxIZsHp6gfvM2c+A31YUGjjI6ojoc3ebsaZB
         gH/sUsFoDr34n2p4rTiaHudXMEkNyp+Qm/nPS6FamfDdTxetpbX9BIs46ap5qCMGG7aj
         u+2jXlxJK3bLs8MT3o+1TlkZKIUAb3q1wrNUlmCui7AYFj6hmq2ihugpm3z8mYitdlyZ
         xllsKbXklcL+bXi8DHPB4pnap+02oJA8PQalT9ui0oo+/lPO+CGePUTnzKIFx45jBTD/
         7qvKb7EbEDryG5XYVjnD6XPG/GlH2LLYMilQjJ5dxHOI+jkgN1Pvh8Wi/cH22nSU4zid
         AKLg==
X-Forwarded-Encrypted: i=1; AJvYcCX0c7kv7ybhH4L4rDapr2yBhgPzR4vOroNn4yjsP+70ixH6gzWtCrvy6jRwuPoz1otXuXXho65rlj2meBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJgY314BJYEri+9ShMPzGgUmKeAAGLDPjimppSt3pYyLn77jvL
	/z+PmKRL5m7aIb8RFXAOlO5q3QgXMr9LgDKhg6T18t9KlEgTg4xyce2GwE2Cn1Y2Jb3+ghMm8om
	vqunf/2f50DowgXahCRwf0Q==
X-Google-Smtp-Source: AGHT+IFA6VPDBbC1e+6gIWe9mwwubSc0dOt0/SMKjx4g1e9RJBwOm822bx7bReAGfXOd+prKSqJyKXuvGPwSOwjw
X-Received: from wmbjv25.prod.google.com ([2002:a05:600c:5719:b0:46e:2640:aa83])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc8:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-46e7110adfcmr22140975e9.12.1759498738728;
 Fri, 03 Oct 2025 06:38:58 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:37:59 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-3-vdonnefort@google.com>
Subject: [PATCH v7 02/28] ring-buffer: Store bpage pointers into subbuf_ids
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
index 2c157cb86989..e5846f8f3c07 100644
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
2.51.0.618.g983fd99d29-goog


