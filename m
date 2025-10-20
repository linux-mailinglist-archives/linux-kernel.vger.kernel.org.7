Return-Path: <linux-kernel+bounces-860128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FADBEF5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E400D3AAAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAE2C21DA;
	Mon, 20 Oct 2025 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="dQsa4Vv1"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036A1B808
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760938595; cv=pass; b=LTa74MgVq0h0L403fRBj93t60SJeGLWGIarNrIpgN7nwK+Q48aKCBSuufcE6SB32iapzCR3i0UMIZbfRoxPtO35SFP+50DByrObNkoB0Xwl2xEpHenjR3OG729evShByaXFtlKV7rliKdBeCx+bMoFHl4mPNYP6UCoRKhqJTgGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760938595; c=relaxed/simple;
	bh=LsKPC72L1qa9G6Jo7PNy2G0RM2UZjFfL/IW3cia2YAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rudoqV7qaJSgtolLq8/7/22sYanJn83T9GWMhupal3unK6EhRDr4H65bZ9OFSkLbdyANVKxxKqpSkxmjQu985Il9VqBwH9iQZoscrO136AKsGanbRejew2Ztlj9A8tjq51cIlmY2reTvyqKjHQ5DZ6PBKA6C3p8PtPinE7waMoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=dQsa4Vv1; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1760938551; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g4FzZx1aEUrBK7K003fUF8PgjPlQJxGYbbJI24vXc7jYiNIjNhoQ/Oa86cJ0lYdO27mPOE3AMIUm3pUjmgnjjDDwGV3QvcciIC0K+nlBTorvFamCDKxQ4CUSJetsR63+SM8q2OMP3ohhdPuooi3bfqbQrzOHm+C6Gyj2Rba7bhA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760938551; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0YW2HMr2DUsmn8ceqO8yT15Oj+U8v3tq38CvBsexo1g=; 
	b=OtSAdLQxoXCrhsHnf06YpGKNAN4mnbuFW2R+Sy3ShPncxRnUWJJhRje5umqbKba2fi7Ba2hrNvtFaVFgE/ejP5dtz2dRVnV0ot3FJ2WECIfjr25rg5P2cMRgVDEZsUCdIIR+LG97kEdsBJBFnn+86p0q3IsV7TgwiaOw6Rrx+io=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760938551;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0YW2HMr2DUsmn8ceqO8yT15Oj+U8v3tq38CvBsexo1g=;
	b=dQsa4Vv1mXp1rYp/bkxqvxGadouSynDbPaWhNBMiE6UbhRfDLKpSNUPKniz55VTP
	Xv4qb8Vfn/tHf+k8i9cB9EQl+nEkL/icsRv+EoT33NvvQJ1Hqe26rfKzSuCSjdvVloI
	McaDMpDF1dk90+9gd+qIy9WK5BUFEukfBVXBrNYpIKoBgwgTbwlNPG+qSxXp93V9kGI
	hFtR+nFe5GwT/9w8TbLpa5aigEeKhQrsy5SBEqNZ/G8/4S9xVLTGZM3U6zrCbHLg/Kh
	E0oRbfUSYCqEHev8p8ijP1Rl+dduFKyenT1w/55J0z5MY9TeMwkSdsDg6yeTWJY9Jpx
	mJfS9F6/eg==
Received: by mx.zohomail.com with SMTPS id 1760938548786142.3683573948715;
	Sun, 19 Oct 2025 22:35:48 -0700 (PDT)
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
Subject: [PATCH v2] drm/ttm: add pgprot handling for RISC-V
Date: Mon, 20 Oct 2025 13:35:23 +0800
Message-ID: <20251020053523.731353-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
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
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
Changes in v2:
- Added Han Gao's test tag.

 drivers/gpu/drm/ttm/ttm_module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
index b3fffe7b5062a..aa137ead5cc59 100644
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
2.51.0


