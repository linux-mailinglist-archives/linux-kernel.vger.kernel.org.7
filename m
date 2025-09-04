Return-Path: <linux-kernel+bounces-800151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2AB43410
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09173A5DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF26629E10B;
	Thu,  4 Sep 2025 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="AbcNWFp2"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603B29E0E6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971185; cv=pass; b=pRiftOwS/Wt7SdJfodkSOmz8i5axy2phFsHB86zJanT3H1PvN8LikEHBcxfV5LXJEzauXwl0f8bnHIrRsfMsTrSzYIzSWwgF99WY/MyBQjXquLEsVbgdTer0DQXHHD+0sK3KJHAyqtdsEbpuWTcdHlq14xga9w/hpw+tFZqF+BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971185; c=relaxed/simple;
	bh=tGKBKbhkMk+1DImhTC9Ibgp7UPhtIqCx0yp2t7RzQlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4MyeYalpVYAUeqy/NG9s6V6zepzOm7e4xMl9IhopnSdXkYM4lzLU2Hyv5om4WqmsgLd7ZrjGYWCON/dx7wwmAcdaZIXpytRFzx2ywj3h3i0MINdxOSR+wRDGegUM7U6HpublsvjAKf6P8kmz5+Uxcm13AtDTF9aeBg01/4MKsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=AbcNWFp2; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1756971165; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kN2cnCNlMmCO7J3kgWi82dSr4XxxkJUgwcypQubVToKc9qmmFmAhohJKDygrwua6QHl7MWAAjq6ceOgfXMkMnKhX23dY/o571zsT1HeVaBOaVRcD4+B0BIUKdxrhnfsZCGXpFXwQrKK0TEYjOy+Crjjm/m0CF0RO72CQxrv8VGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756971165; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=APBHIVuMwAIZar0wx0NjyAkMbwfWyquvwS1vjmbzGo8=; 
	b=i7gu/L0Ys5XVPuUKeroW+HQrI0cz21oxNC+up7MgVvMRQag/U0gFz2d34ove86sxHaZsSyHnhzBM+HDklMz93jNSlFWIoY3/2oPUSrVqSljDbpW4QqhDPuyGV0B71YdKeXf7NLzBI5GzwME9ozC7mZ0/U+W9R4EHBoEeoB0tqBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756971165;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=APBHIVuMwAIZar0wx0NjyAkMbwfWyquvwS1vjmbzGo8=;
	b=AbcNWFp2phw2nPuLuTOnnESdiKQvJJH1v3ieBRgG+au5qwoNRVa16YkzckT1FVA7
	FvCwDcHAjkWNB/VM0tD5zdbtLI2ycF5yVPjM9CeETVO+tfWvo7JlQayN/nyAtCyhhB8
	Zmzm5uP9osNbdA3ez8imA7dvbTsLqcN7GweYuLv2YM9eY9r4zJ0UUP3bVroydGwteMf
	4+ZXHpmzklMe8MtW6lCCDrClT/nbCd2QylW6lVhJqQqjye0TLKMQ1gvByIclm0hBc5u
	A9fPfIHPRDH5mWBXKLUE3B52sxIIKfd9lSA4U9T9X+XhX8SgXXy8jUwW6E97qjy4g43
	IJafOXn3FA==
Received: by mx.zohomail.com with SMTPS id 1756971163447251.9203872666401;
	Thu, 4 Sep 2025 00:32:43 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 2/7] drm/etnaviv: add handle for GPUs with only SECURITY_AHB flag
Date: Thu,  4 Sep 2025 15:31:46 +0800
Message-ID: <20250904073151.686227-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904073151.686227-1-uwu@icenowy.me>
References: <20250904073151.686227-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

In the GC620 on T-Head TH1520 SoC, the SECURITY feature flag isn't set
but the SECURITY_AHB feature flag is set.

In this situation, the VIVS_MMUv2_AHB_CONTROL register isn't available,
but the GPU otherwise behave like secure ones and require commands to
load PTA.

The 6.4.6.9.354872 driver from T-Head asserts SECURITY_AHB feature flag
is set when SECURITY one is set, so it could be assumed that the
situation that only SECURITY is set do not exist.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes in v2.

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index cf0d9049bcf1e..7431e180b3ae4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -559,7 +559,7 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
 		control |= VIVS_HI_CLOCK_CONTROL_ISOLATE_GPU;
 		gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, control);
 
-		if (gpu->sec_mode == ETNA_SEC_KERNEL) {
+		if (gpu->identity.minor_features7 & chipMinorFeatures7_BIT_SECURITY) {
 			gpu_write(gpu, VIVS_MMUv2_AHB_CONTROL,
 			          VIVS_MMUv2_AHB_CONTROL_RESET);
 		} else {
@@ -797,7 +797,7 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
 		gpu_write(gpu, VIVS_MC_BUS_CONFIG, bus_config);
 	}
 
-	if (gpu->sec_mode == ETNA_SEC_KERNEL) {
+	if (gpu->identity.minor_features7 & chipMinorFeatures7_BIT_SECURITY) {
 		u32 val = gpu_read(gpu, VIVS_MMUv2_AHB_CONTROL);
 		val |= VIVS_MMUv2_AHB_CONTROL_NONSEC_ACCESS;
 		gpu_write(gpu, VIVS_MMUv2_AHB_CONTROL, val);
@@ -853,7 +853,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	 * On cores with security features supported, we claim control over the
 	 * security states.
 	 */
-	if ((gpu->identity.minor_features7 & chipMinorFeatures7_BIT_SECURITY) &&
+	if ((gpu->identity.minor_features7 & chipMinorFeatures7_BIT_SECURITY) ||
 	    (gpu->identity.minor_features10 & chipMinorFeatures10_SECURITY_AHB))
 		gpu->sec_mode = ETNA_SEC_KERNEL;
 
-- 
2.51.0


