Return-Path: <linux-kernel+bounces-809153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68BB5094B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B211B27EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7B28B4FE;
	Tue,  9 Sep 2025 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LL2Jixij"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718F2B9B9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460860; cv=none; b=cRHn5MWimMbN67Ar0C6lsq0DCc8L1tRTXFVWBZRB5qSnXojBRiAHOtyXEZD3kw4u+7Ur45xf43CUfQXeCspF7yF3orvMmQJ56/i3O9lJDOqs8ZVA1Cm0rilqgsTNm86ljZvNYYeN4YQpwhKtgJlmj/PHmLTRsXxhK0dk8P+7PPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460860; c=relaxed/simple;
	bh=VRVXvdyBXu+l8eN5OmWMKeoSEG/KMU7MEJ8tdydrdIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mRhGzAR35hH2QY7LbJ9dTBC91WPdoGRO9iOT5rkIgEYq6iD3yjIIEFVrxiZ7P+ZHiK3V0jqLEJ2RhWmdVc+5QKXk7so3BACq4djhpzCz48OgN4hlZu7ETD+DbXxM3VDE/XiDI9+7rANSCX9TB6LlcMpULeIri4ITSthZNDsqo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LL2Jixij; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7724877cd7cso6940662b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 16:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757460858; x=1758065658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6OH97ZpoRzs/QnK0sVtwK1+CTMH7EfEmnF9tlYLf0g=;
        b=LL2JixijHp4p1q/v1EkyCc3FzMk/nZ4MiZtAKu1dmoWb5CJS7cu0DrsGRwxF7pPqWL
         CPn5NFgs7KpWMwO0inANqTiZE/pj8UnZJ/gdryEjO3AhkFcu4kzrtuI2DhPkLT1R6Vku
         7XZrJVx8YGl9nhoAI00X7rn9K4pkzYV9uOb4nDSKHlagN6DqOlPs2DGW19t5Hr5PacS4
         mQriNQrL5Tl4A/gEkuSocRdWzqhOguOF/ItnOr8xDVhi1qzPYgsCfz1ziYdrIcw2DRVk
         S6pperryh9m+WJrATXD4TgRISM0Shq8WRJ0HNXqpXTCuln/C6+0GBZnzAtOtuo2NhK65
         c7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460858; x=1758065658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6OH97ZpoRzs/QnK0sVtwK1+CTMH7EfEmnF9tlYLf0g=;
        b=RwtWKvkgKdHkDPB73BJgZMdIqhdriR7MZKFrvVkieZJTBhVNnq4KiFbSWmRRJUVsgH
         RM2faiuJYmACJlPMs7mL9BgcQ2if9g3HLY+VpkiNeUOH2wcw6nwJfE0w1zfKvK0c7Ii7
         bCCHIAG62MsVbxxS+yw5Ycncj/uv1OFOhnH19lgbIejO1fsuQtvgE3IbPUZth98VBT25
         gZKeGWzJNCct50Y+y+BmNb6igHoau0S0B8KkygbMh4QIAgxGSzXk7JrCC7L7RQTBhA7v
         6OmUheLN4fMb0kzleIzV34LINJiwYwTj59L9FJFLKm5MuYRFAisvlS2qiA69UUAUv6s8
         EVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxmeTf1MwlNlBnGILMiCiUY/Cke/nX21+BbLHZ4J+NRZURtatBfoOb45T4lnnUJQrm6W6lWJi1w8C7IMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHJeQFvH9htFkX0NQlnb2WRdYH79JFFPkCegb1b16PZ2p0+Sy
	rtqzMAfvv1nFjsG2dk8Z9WPsk3/dF5Ze1x99BM7KuRCJdtyJIdY1VRyJ+XKK+yK0Hhe/h1lSffB
	KzMbe+A==
X-Google-Smtp-Source: AGHT+IFIst4jd2D334Y2PkPuCO/Ean4Ij3IT9elqE1huVfZrndSK+83KyXPa67AggUAs4pMR4FIui+Zixgs=
X-Received: from pfmm1.prod.google.com ([2002:a05:6a00:2481:b0:746:3244:f1e6])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e14:b0:771:d7b0:6944
 with SMTP id d2e1a72fcca58-7742dca536dmr15166038b3a.3.1757460857845; Tue, 09
 Sep 2025 16:34:17 -0700 (PDT)
Date: Tue,  9 Sep 2025 16:34:08 -0700
In-Reply-To: <20250909233409.1013367-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909233409.1013367-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909233409.1013367-3-surenb@google.com>
Subject: [PATCH 2/3] alloc_tag: prevent enabling memory profiling if it was
 shut down
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Memory profiling can be shut down due to reasons like a failure during
initialization. When this happens, the user should not be able to
re-enable it. Current sysctrl interface does not handle this properly
and will allow re-enabling memory profiling. Fix this by checking for
this condition during sysctrl write operation.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/alloc_tag.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 95688c4cba7a..79891528e7b6 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -767,6 +767,16 @@ struct page_ext_operations page_alloc_tagging_ops = {
 EXPORT_SYMBOL(page_alloc_tagging_ops);
 
 #ifdef CONFIG_SYSCTL
+static int proc_mem_profiling_handler(const struct ctl_table *table, int write,
+				      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (!mem_profiling_support && write)
+		return -EINVAL;
+
+	return proc_do_static_key(table, write, buffer, lenp, ppos);
+}
+
+
 static struct ctl_table memory_allocation_profiling_sysctls[] = {
 	{
 		.procname	= "mem_profiling",
@@ -776,7 +786,7 @@ static struct ctl_table memory_allocation_profiling_sysctls[] = {
 #else
 		.mode		= 0644,
 #endif
-		.proc_handler	= proc_do_static_key,
+		.proc_handler	= proc_mem_profiling_handler,
 	},
 };
 
-- 
2.51.0.384.g4c02a37b29-goog


