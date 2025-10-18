Return-Path: <linux-kernel+bounces-859403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4EBBED87B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 21:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42F7427782
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57F27B4FA;
	Sat, 18 Oct 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh0DnTYv"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131277263B
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814750; cv=none; b=lTtJdeh/6h+sjT27gWV6KmMpWlDb8mIKMKvvGwCOZukYnpIOcDfl2NbmIwkHlusFvOIxUz6Pt4UM/V+UoJ0ZrQk88qoNZ2QQR8PpgnnufBshDR7ZEp4rP2/9Q1zBybEhfZ0g859WnVNvfwoTTFf6KqfD03BEoyORJiZLGEJ5VUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814750; c=relaxed/simple;
	bh=Cpgrt5SbcQFH2dEyWj8y2+kKTm0J/7DumNlggph2KeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nk89j5yVpxwqdQqHK5wl2FacuIGt5kWCt69DRvWuXGvnpNYxhJ9cAZrtVS7MyPxQg8Qp1Lso8m6xsfDkgxyJasPxktyLWBwuPmUJyGWjoI3Pcp6TJImC8II35tA9kzRCiNMRGaRih/pdal2csOp11bEevlpC/yAseHQfqttp+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh0DnTYv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e610dc064so641245e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760814747; x=1761419547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uenq9zUN4jnOACfiis104z+6oR/uGp0g0fP3KoqPQzk=;
        b=fh0DnTYvZsc2Z0JSBo8/cuXdVKen3WABf0wpyfUhY8MdrvN9+s22t4h94MpL/KupHK
         xql5tdOyPmBJw24ATXuHk+bkuznKQf01777oW2m6I5+T4iUPYeMt05mYHIlpLg+LHQT/
         Xuz+rStQsGU4MxXAg7MjsxU1Ybq/2gZx7rMCxyH93823XjzGxNkVE3etRVWaxMKYes1k
         9iEtoNyFgdbi02hVVlLH0vFSqvs4sqOePH1Fv05ckzAv10Mizfky3/EACxwJRUIpYoGG
         q6Y6Y8cCKLKWwkHB/az1U+h5PTEtE2XQlbjF0FfYcY0s8UJYPpwCD14DfUjIvDParDkD
         bOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760814747; x=1761419547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uenq9zUN4jnOACfiis104z+6oR/uGp0g0fP3KoqPQzk=;
        b=OngvudJ2is5s5VEnEWdVIQpf+6fSrS6URsitNbsRWPsiplDBnOgDBS6+hzWxvF44i1
         L9nLRnTdnHu8iIrUCSph9hh3o9QvWIunWxb5CN9viWidd+rhDJZA2tyeKTvMsWiUtdM+
         I4oBkM+y7nVWml88s2jx/ZBqD+vvr14RJs2dYzobxKQHRAgZl+MVHXrBs2FccT/8OX0g
         iDejljAdJFw9mRCCc2wHDtPBJPYeLLWgSy+i4JV8ZnI2/lR3N0vPEHXgC0kLkugRaqAQ
         JUo/PO7kHUNce9eq6cUI97Omiq2U2yJSxrYz2MoE0woCBG6MYcPlmp3OWyS9AHj9Mwmg
         BH2w==
X-Forwarded-Encrypted: i=1; AJvYcCVdtodvDoB0pIG1u22SzXf5uBctl2MiWpP6dK83oTvSaquB06AA3Fc3VnC8Plrg0pItvIcQT9N++Cg0keo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUGPcv45SQQGuWIvy64diDbAeXlvfuljUH4cqZUqqILpdA7ig
	ympA0cM4i1p+JXQVU8lw5ZtM6agOnmyGvydMBO10K4CP8PIEBEQhDz8u
X-Gm-Gg: ASbGnctJPCHe7ZwxBMPl+z7dZ00u2y444N8jExYSQoZ8QFiZeovGCCsngF4DHMQsTfk
	Saf8GGbPsoyrkqBW1xsZDFc/bo7/yMb/3o8cJeWbmwlxYD9WVMuKc9wjO07BM1HvTLqxnzkUGAI
	SCjuUKeNFsccQQT0zlL48VIWyF6P8emazkE6fY/pFhXlyhFG95vpC+5YX5HMMdh+Lu6zLzkTeFr
	Nz0NDmI1dYt3Xvs0/FCs4G6Um7lKXT11G5TWSPVEb+d4ltcPHdBYzlWymcnOgGRfurP8ofR9A+H
	fv/fo6MU75g6MhxUj68UbcUMrouebecKqYG2To7A0HnddciTSwGceZ398lHSIlj74/C2LbEjpra
	WjcRGcfj0ztW/P70doITigD7EGiy9fKiygmtntfDPdFjJnfaSaxtEcePzdaR8Kq0bYA04TfZMXu
	8loQcY
X-Google-Smtp-Source: AGHT+IFeotg3SOqozCDeGAvqxPUt+glB8XDCNwLIM43/UO8gAjt8ouXK8ko6Vt+aDxAZJHhJtcwrow==
X-Received: by 2002:a05:600c:3515:b0:471:152a:e57d with SMTP id 5b1f17b1804b1-47117914193mr32306685e9.3.1760814747218;
        Sat, 18 Oct 2025 12:12:27 -0700 (PDT)
Received: from bhk ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3acfsm6406354f8f.14.2025.10.18.12.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 12:12:26 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: akpm@linux-foundation.org,
	urezki@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	khalid@kernel.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] mm/vmalloc: Use kmalloc_array() instead of kmalloc()
Date: Sat, 18 Oct 2025 21:11:48 +0100
Message-ID: <20251018201207.27441-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of NUMA nodes (nr_node_ids) is bounded, so overflow is not a
practical concern here. However, using kmalloc_array() better reflects the
intent to allocate an array of unsigned ints, and improves consistency with
other NUMA-related allocations.

No functional change intended.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 798b2ed21e46..697bc171b013 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -5055,7 +5055,7 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 	unsigned int *counters;
 
 	if (IS_ENABLED(CONFIG_NUMA))
-		counters = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
+		counters = kmalloc_array(nr_node_ids, sizeof(unsigned int), GFP_KERNEL);
 
 	for_each_vmap_node(vn) {
 		spin_lock(&vn->busy.lock);
-- 
2.51.1.dirty


