Return-Path: <linux-kernel+bounces-740697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C681B0D80E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E203AA748
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B182E3361;
	Tue, 22 Jul 2025 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="TZ6myj7n"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925E288524
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183307; cv=pass; b=O8L9pLrD3rm6UuAqofy5CtScdYO/JPJn5BEK+IqHwve4BaLnfLizkfuFNV4ko7KCxgLunRn6JVpYUTJ/Z1eyVB3AJWHdjZD4YbKQ6FcUHmJ2Oaa5t1JwtVi7K6KBP0wnTEYkFLFdGSutgvCQLZGsRa4AV99jh7l2WU4bQBzWb7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183307; c=relaxed/simple;
	bh=IOe/omysrzOZBfroVlR5LysntqapPOAEaNMogJ0WCo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYtD54OKMwZiyo2MzuuBOeAH6jplY3GHMOn4P75lmuE/i8ZF7OAG/sjecpGmGE5nhDNNV/5pRxUSKHtjHWZZ2FWf8GjWrwbCYD3h82xH7vxdQSEoccf9Lhgd53qjoEBeeGcDZUw2DM6ZncbyrEOzd1aF9znTrCwf3lvD/BnjnXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=TZ6myj7n; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1753183273; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gv9oGH68zKdRkIgjVM1zHmhUNikzYByusvfpbbSI3qQrbR6dy7qMYYwdrP+vfVtzjqSY3lUQygV2QTV/Hu1Ti5IJpeQ8rKdG22+0BAYZr0tNvlz9JqyAZ2y3T+rbZe50Mi4MhWEO14deO3OcSdCjzpt1BDVU2sZDspacWWB7heg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753183273; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FmEk2snejcbJWJ/01YuvjfvZovqB2NJooCH4yUHlJEc=; 
	b=B24BUEmKFJAz5yfFZeg5er2Np9zSmQYtrHTHcIqcQYsKrwpBi9jthCB1aH6NLfP4KhDQaCqUOCBndWWI7Dqq5GoTehMGhU3aQGETCOCjahgK9BGvZqk+P3460BfoA1nGGNLGBB1p1KTuBTHVTozOORhc6563ExzGPRN1d9cc5tk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753183273;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FmEk2snejcbJWJ/01YuvjfvZovqB2NJooCH4yUHlJEc=;
	b=TZ6myj7noYo/vloSK0+qJn14TElPvDkOLnV5/7kic+HAO8Qdthw7GMjZEZUJJdFi
	qJJkpLbCew9GtF4j3OBAD/EGxtlgqClS9ltt3MBSM9G9vlJOXqXdZEUOM2DANShjwF7
	wibTDBRYgilWN6uiJ9RDRtQDh91rdmrG/UzFcbEC/+Un8X5Pc+VkmXnuTB3OCZtF2o7
	xFQkdSYwDrlaT63t9a0R+dH5TenGOie2A50uNZl56lSj7hRUScy78fNMR5wSyFOHkDV
	sQZ4bnGxMt9GxW22cVKDGfEaUAHnPcE/EuIio2MJ9gjZavtajc7SNeF70S8TpHczmwY
	sjw4Lxro0g==
Received: by mx.zohomail.com with SMTPS id 1753183268062183.51689612735777;
	Tue, 22 Jul 2025 04:21:08 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Han Gao <rabenda.cn@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Inochi Amaoto <inochiama@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] drm/ttm: add pgprot handling for RISC-V
Date: Tue, 22 Jul 2025 19:20:50 +0800
Message-ID: <20250722112050.909616-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The RISC-V Svpbmt privileged extension provides support for overriding
page memory coherency attributes, and, along with vendor extensions like
Xtheadmae, supports pgprot_{writecombine,noncached} on RISC-V.

Adapt the codepath that maps ttm_write_combined to pgprot_writecombine
and ttm_noncached to pgprot_noncached to RISC-V, to allow proper page
access attributes.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/gpu/drm/ttm/ttm_module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
index b3fffe7b5062..aa137ead5cc5 100644
--- a/drivers/gpu/drm/ttm/ttm_module.c
+++ b/drivers/gpu/drm/ttm/ttm_module.c
@@ -74,7 +74,8 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
 #endif /* CONFIG_UML */
 #endif /* __i386__ || __x86_64__ */
 #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
-	defined(__powerpc__) || defined(__mips__) || defined(__loongarch__)
+	defined(__powerpc__) || defined(__mips__) || defined(__loongarch__) || \
+	defined(__riscv)
 	if (caching == ttm_write_combined)
 		tmp = pgprot_writecombine(tmp);
 	else
-- 
2.50.1


