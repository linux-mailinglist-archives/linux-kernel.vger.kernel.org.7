Return-Path: <linux-kernel+bounces-830751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26499B9A728
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101864C6A24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024A730E0E4;
	Wed, 24 Sep 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnCeeov7"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFC30C60B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726019; cv=none; b=CRmhhOdBMwjHZ1IXKs2jZADsjabDrC5vzv6rRdDr0KeNPdeOvFqMB+ya+AMOw3WsDlEttoqa5+fz9xwvvQ0f9DHyUZRwYVuI+/VtCLTyQ7Q5evT0A0NuiQjQX9/HadRY06p5WRIm0mfrIgu2l5nuw/VWikkEx+86K4eGJgSJIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726019; c=relaxed/simple;
	bh=L1VgNfoC71xNyfRLvBsWv8HKOJkfszOB/L2DYbQfD+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AFKc9Vv3waHQxwP1D2RYrI28eBpruqbqk/dAUDDfK2tIL1L+8x7B3d1Tz8gReqLiSCehAYkI32C8s9AG6u+vBlkO5rY0/EiVIePtqxmXG/Hvyok+cGAToYJh2FUffk4lh4KUbRcWB0M48f4J1a3ay76rg2EljMfctmANBFuCK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnCeeov7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46cde0b2226so16296655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726014; x=1759330814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CX5Q5YH/plIL1ST5QoPko2JUmjdnIY0LBvORLR/qltw=;
        b=JnCeeov7+l02sCp1bnxwwkvYRbmLI6MSvypGUtX+3+JxbQLKd5KPf/pGMdxTWGgjXw
         MXAKDySriu+snT6NpKMuuTEJ1XcYoOuZVoTgnCeV05xzoC0e7xD8uMVNyw98nVnTG5Fo
         X/h1AFMe39VWpFFo6PVded0B+EznsReytc8kPH8u/JJzhx3Vr+NJorwmOSh9eu4d0sF4
         Ktd9w1lu4okjy1ROBljkLMttIlTs4wOhIIZUH1OQWzY0AOrkpeDsDYnFEhtwXMXa8T0x
         vMaHuF+Y5mLhJgyD7vDspfPlzBJPuFXohy/X95FN3M/NIlcgMjJh5jBU60i/1vMQmz0K
         talA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726014; x=1759330814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CX5Q5YH/plIL1ST5QoPko2JUmjdnIY0LBvORLR/qltw=;
        b=HaEeaY3DuFwMZ4164kySPS4fhsrYh+v0ZiHjWJAIHLLO0EZ9XzWSIVIGUbIoCQGDDi
         0I0JZNFlvwAyNDf4s3XFzp8t0xFCzwE2K/eL4JDBFtIlC/zlBlAfRkdztcMoAqUD+Hj/
         clBUenRc6p9fOF8RaZAZgdGeMzbhoJM5IzZx1nYyggJU5oYIh3cVd4MYv06D1Ya982YY
         GGwIcY1V/qAQkewyuJZP7anhtN5THgob3Msmz44jRhajYwKkB06rYyCI/xA6RmZWRehH
         Qzn+zeGf/WnW4MUVwOlJ/WIFSVJ+PrwiPoTTQhodtHTTk0d7IjAZp+zgK24aHGRCKXYy
         HrEA==
X-Forwarded-Encrypted: i=1; AJvYcCUiIGceLQzWqqrIOj8lyKwJ0aPIXyLmY5ZAyl4ioH6twtvjTy/HszqdLGHGXo9B8v8XZZOHtXGim/TeU40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3u1rN0fjkfoSQW5SNVthZg44DnV9A8v96QwxQ9KHgGanGzrV
	UKD4xNx6gFbju6KmhS6iTFgNKeXUlrH6E0xqtEH9pWEEK9Ay4cFgFsp2ggmOaeqUUNDOLE8i8Ax
	sywPsMXaOXY4VgQ==
X-Google-Smtp-Source: AGHT+IH1z5403qKBJ7o7GKoFaP/RUEDwuiU+FQ2BI25kf1Pv6Ap4eL3k4PLg1ZIY6q/Lrj8v/DOCur38GOqArA==
X-Received: from wmbdr13.prod.google.com ([2002:a05:600c:608d:b0:45c:b682:883b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:17d0:b0:45c:b53f:ad9 with SMTP id 5b1f17b1804b1-46e32a1919dmr978105e9.33.1758726013525;
 Wed, 24 Sep 2025 08:00:13 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:41 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-6-2d861768041f@google.com>
Subject: [PATCH 06/21] mm/page_alloc: add __GFP_SENSITIVE and always set it
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

__GFP_SENSITIVE represents that a page should not be mapped into the
ASI restricted address space.

This is added as a GFP flag instead of via some contextual hint, because
its presence is not ultimately expected to correspond to any such
existing context. If necessary, it should be possible to instead achieve
this optionality with something like __alloc_pages_sensitive(), but
this would be much more invasive to the overall kernel.

On startup, all pages are sensitive. Since there is currently no way to
create nonsensitive pages, temporarily set the flag unconditionally at
the top of the allocator.

__GFP_SENSITIVE is also added to GFP_USER since that's the most
important data that ASI needs to protect.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp_types.h      | 15 ++++++++++++++-
 include/trace/events/mmflags.h |  1 +
 mm/page_alloc.c                |  7 +++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f9053c701e24bdcf1dfe6afbf1278a2d..5147dbd53eafdccc32cfd506569b04d5c082d1b2 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -58,6 +58,7 @@ enum {
 #ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
 #endif
+	___GFP_SENSITIVE_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -103,6 +104,11 @@ enum {
 #else
 #define ___GFP_NO_OBJ_EXT       0
 #endif
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+#define ___GFP_SENSITIVE	BIT(___GFP_SENSITIVE_BIT)
+#else
+#define ___GFP_SENSITIVE 0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -299,6 +305,12 @@ enum {
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
+/*
+ * Allocate sensitive memory, i.e. do not map it into ASI's restricted address
+ * space.
+ */
+#define __GFP_SENSITIVE	((__force gfp_t)___GFP_SENSITIVE)
+
 /* Room for N __GFP_FOO bits */
 #define __GFP_BITS_SHIFT ___GFP_LAST_BIT
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -380,7 +392,8 @@ enum {
 #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
 #define GFP_NOIO	(__GFP_RECLAIM)
 #define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
-#define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
+#define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | \
+			 __GFP_HARDWALL | __GFP_SENSITIVE)
 #define GFP_DMA		__GFP_DMA
 #define GFP_DMA32	__GFP_DMA32
 #define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index aa441f593e9a6b537d02189add91eb77bebc6a97..425385b7f073d05e9d660ad19cb7497f045adfb7 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -100,6 +100,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	gfpflag_string(GFP_DMA),		\
 	gfpflag_string(GFP_DMA32),		\
 	gfpflag_string(__GFP_RECLAIM),		\
+	gfpflag_string(__GFP_SENSITIVE),	\
 	TRACE_GFP_FLAGS				\
 	{ 0, NULL }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23d75fdd4aec118e34f3f49d3de2e0..0d1c28decd57b4a5e250acc0efc41669b7f67f5b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5152,6 +5152,13 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
+	/*
+	 * Temporary hack: Allocation of nonsensitive pages is not possible yet,
+	 * allocate everything sensitive. The restricted address space is never
+	 * actually entered yet so this is fine.
+	 */
+	gfp |= __GFP_SENSITIVE;
+
 	/*
 	 * There are several places where we assume that the order value is sane
 	 * so bail out early if the request is out of bound.

-- 
2.50.1


