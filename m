Return-Path: <linux-kernel+bounces-763413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60531B21444
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3671A23311
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4314A2E174B;
	Mon, 11 Aug 2025 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrqR2T6B"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70272E093C;
	Mon, 11 Aug 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936658; cv=none; b=KQj7vJWVXveiNk1/fQQfXmPBoaD4dcsbfEURhSbn43EuGwTcNdQWbvMM42nUGbTdgg94Mn7Tcoqnjrl1L2VexDG8HSwkmo4npiu8JENlWJuhayT+Nj0YQdFk6wOYiR82QWjmmOUlP6QrJdd/dTn73yDOv11mv85YKVxUfaBF1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936658; c=relaxed/simple;
	bh=eoincyoK3XVw5SZWAL09GLB9GcpLHMIrUCNieqviHcY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P9FcYErb/zL8o3o3ydnZ3GH+Pr9ErqyXUtweb2Y4rVX8AtCIu1SSZZHPrZmlAx3PqHqS+isabW7EK1+xyqVQ6zZqhUupeqeQ/Cr7NArMHe9IC++Q/dOa9AdrkRLw/klrtNdzGl7pHMj+C8mO2wYJwgDpfCK9z8niPzAH88kCKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrqR2T6B; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b423036a317so2931594a12.3;
        Mon, 11 Aug 2025 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754936656; x=1755541456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d/BYSlI48P8Nb03HBAZm4OMfQQPLVUCFN2VqcKKE/5o=;
        b=NrqR2T6BNLWhTF21m9e4aLbgqYbGcvm4+49cjOesgZTcYBQms3as+P8e4HQnYUCGL/
         kD94yLzanTQxvOq5zDuiKzR4qE+RGPQdeLeI4CZo1fNHXwaaYW+GG5q+6q1sNftgooXT
         ashziChPNxwBFJXrX49di1BtH6yN01x2Zl0zm+oMAb2czR7UTQhT83TkP85qRAgrDIsC
         /zdQSDY3POWXTyktSvPifARv5TlNax1NRbDq6wicsvZ/YMUazAwC6/gbwANIDR06EYdz
         sQLqUbsu8130R6B+lyINg2bvGdhsR6LTHv2PM7ZLNSgstToRG0vkNiNV7XwotmUOHF75
         IWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936656; x=1755541456;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/BYSlI48P8Nb03HBAZm4OMfQQPLVUCFN2VqcKKE/5o=;
        b=VfCaIuzpwNuQSY+H5LEXscSNs5bMBkRA9BeBjDOtFOTEjdjLf9DkDd1QDiB2/YTIMe
         eKzWNa4k4T08WYe6NXBWCksnYZXyZZGFM+3aCe0gGU4aJi8n9/jg8uxolxJTidCJhlAx
         ZXqGovndv99NrJJtCx1ci6W5aOzhq3yNRI4th2LKUcKHKUud7SIaGRFtDKltjfmXOL4n
         /UJjWshWtoKMBdB/UFZByPX0LPGg72ojL+aQ7ZjoUANGg55t9WlGbY8C8h4z+b33Yv0Q
         7J/QbvBLOuZxOxVsyY4i0queJhxP3iajH3J3+xKjVoBuxDqsGDmldaU5ve1dxErIXb2X
         eiNQ==
X-Gm-Message-State: AOJu0YwenaM37wUk6hdkZDCQp4x1L+AhiJBmgv6akNRGymG6CCcDnDkA
	nf+kspETPiEhhjaXyr9tvpEm3uviBxKFVwNUxy+ilCNUd4T3sobElTHCN+V25PlZ
X-Gm-Gg: ASbGncsCE/r2m21X9HdCKxlK9avcsl4Yh0/OY1gAEJmY7Ya/lCvHwfYBYQTSuIPcuow
	hZIahRQWIks/TH637EwJ3tWq2CsyUzqHIKubvb8PuHBvTLAGV0bOW0lcukGpE0hNzo0liObaLuc
	HYkYIlJxLnACv1ODyhEUSbVf+sg7DunsJIkULl9YchnI6Er34eHSQ8tYmcpzGH9mY9n5lXCHvhL
	pg+VENR5bB9+T74dpYOnvbDP3Nm4YSofcyo6+3VEBxqvKxkoF8FE13Ce/zQCrt/mtIAtV0QuYaF
	p/JWsUz2t8+0l28kQWY0U5LXlwNDihoi49uT18RWQuvHUMgoU2T9V2j6ydbSywf7250+QoGbcvB
	juutLcuoRvdnTDaKE7pcBfFezDj0D+HIAnFEVUvo30Wqte71QUJHUnyXtXdxz8MS59Noy2A+z
X-Google-Smtp-Source: AGHT+IHo6FctEUcjPn2KrmdXGUeOut5S7prT9FmUzm6kMGygaDyHisucD/VcusLBFQJD2CHLUNMlTQ==
X-Received: by 2002:a17:903:187:b0:240:e9d:6c43 with SMTP id d9443c01a7336-242fc3b52b9mr7381265ad.51.1754936655665;
        Mon, 11 Aug 2025 11:24:15 -0700 (PDT)
Received: from ?IPV6:2804:14c:de86:8d34:add1:b1bb:ed29:6539? ([2804:14c:de86:8d34:add1:b1bb:ed29:6539])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f603sm279795445ad.48.2025.08.11.11.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 11:24:15 -0700 (PDT)
Message-ID: <a7c2ee4a-e9d8-40e9-8695-4bb777d42812@gmail.com>
Date: Mon, 11 Aug 2025 15:24:12 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Rust: kernel patch series
From: AI Talking about AI <aitalkingai@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <79821f85-9e95-4426-8b1f-8752f8683dc9@gmail.com>
 <42c3fc0c-46a8-4502-ad53-d3b886fad5e8@gmail.com>
Content-Language: en-US
In-Reply-To: <42c3fc0c-46a8-4502-ad53-d3b886fad5e8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From d66384514f12bf7607fbb45185bc66699e6cbf48 Mon Sep 17 00:00:00 2001
From: AI talking about AI <aitalkingai@gmail.com>
Date: Thu, 7 Aug 2025 07:54:00 -0700
Subject: [PATCH 2/2] rust: clarify safety comments in workqueue.rs

Replace placeholder `SAFETY: TODO` comments in rust/kernel/workqueue.rs with detailed explanations of safety invariants for RawWorkItem and WorkItemPointer, following rust kernel guidelines.

Signed-off-by: AI talking about AI <aitalkingai@gmail.com>
---
 rust/kernel/workqueue.rs | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index b9343d5..4a34651 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -881,7 +881,19 @@ where
 {
 }
 
-// SAFETY: TODO.
+    // SAFETY:
+    //
+    // The [`run`](WorkItemPointer::run) function pointer stored in the `work_struct` always
+    // originates from a prior call to [`__enqueue`](RawWorkItem::__enqueue) on a
+    // `Pin<KBox<T>>`.  A `Pin<KBox<T>>` owns its heap allocation and, by virtue of being
+    // pinned, guarantees that its contents will not be moved.  When the C side of the
+    // workqueue invokes the function pointer, it passes back the same `work_struct`
+    // pointer that was produced by `__enqueue`.  This implementation computes the
+    // original `KBox` from that pointer via `work_container_of` and converts it back
+    // into a pinned box, which is safe because ownership is transferred back from the
+    // kernel.  Therefore, the pointer passed to `run` is always valid for the
+    // duration of the call, and dereferencing it is sound.
+
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<KBox<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
@@ -901,7 +913,20 @@ where
     }
 }
 
-// SAFETY: TODO.
+    // SAFETY:
+    //
+    // The implementation of [`RawWorkItem::__enqueue`] for `Pin<KBox<T>>` allocates a
+    // new `Work<T, ID>` and obtains a raw pointer to its embedded `work_struct` via
+    // [`raw_get_work`](Work::raw_get).  It then passes that pointer to the provided
+    // closure.  The `Pin<KBox<T>>` is freshly allocated and by type invariants cannot
+    // already be enqueued, so the closure must return `true`.  If it were to return
+    // `false`, the implementation invokes `unreachable_unchecked()`, which is never
+    // reached in valid usage.  When the closure returns `true` the C workqueue
+    // subsystem takes ownership of the `work_struct` and will eventually call back
+    // into [`WorkItemPointer::run`], at which point the box is recovered and
+    // dropped.  Throughout this process the raw pointer passed to the closure
+    // remains valid for the duration specified in [`RawWorkItem`]'s safety contract.
+
 unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<KBox<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
-- 
2.39.5


