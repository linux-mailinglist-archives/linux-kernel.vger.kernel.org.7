Return-Path: <linux-kernel+bounces-771787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8EB28B92
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E132A826A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8620D230BEC;
	Sat, 16 Aug 2025 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="lL0bvAeD"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A283233D85
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330555; cv=pass; b=miaJgc9MF9b2ea1X+ywaXeCFcclrZ+ovgzBXsn2PAxNILu4ICRGgF6cLCCvNR8ZTQHmnq7qgmhZy04MiGFNMKjGhQhpJy9DvvluYWn1Qlgazy8BXGXy6ULYJqCqmCg9J0r4sk4r79QJfIGKU5+mgRlPvTeLohIc88mXin1NZ0V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330555; c=relaxed/simple;
	bh=5HXFA6s5YsxqEJ6WaeXQLZ8o4ACR1KJzM8oA3nLe3UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZU3NjeflTqQKUBEkfCTd+Ykocmc/R2q79KB2cs24Os4qN0CNnbKh/tiQJkEfz8J//e7E/NI6J3DqLygDLYdDpntm0gQ1ek69bHRo6hFwAxteixpI91yEHmG2GWVIOCwCSfHS8UrS0h0Ye4f04nrMPX4CAIdirMSLwlLoEumTwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=lL0bvAeD; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755330537; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QrGGBxLbY7j0af7Z/MtfX8YwtrA4ZAbdmEkt7Lh9BpooB/rk1Bqyf1c7/UKu6SYYyBNxJjLm+FBLftOASEYSUENqIofa9tLPw4JGdTmDkDtAxsEZsfc7FuwFfibov8Prs4mSIz4JGO7hAhLhLT7BtxlzZ7rrAj/bTHx/Zlj7nVc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755330537; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e7Ngx6Rt/JpIvo0R+kAwIonCUQ/vaWPqz6Ke56ZQkT4=; 
	b=PY/0ctaNQ30JiKmPvDZmdLQBayxyYpFuxB08IMAHspmnH+JCxYotVeicwV2EVnsi0cZlu0rXRD/RlZ7PnGeflqYRen289qwC9bQCRWMjldp53g8kXgJY5W4i8GHtkDSjp9pDfY7eWrWZ0P9o4oWqCW0OGgcjiLkQWjDDUstp1Ok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755330537;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=e7Ngx6Rt/JpIvo0R+kAwIonCUQ/vaWPqz6Ke56ZQkT4=;
	b=lL0bvAeDZfX7fEYqdGfkrtBSvD2+IDHQLz0TwEMaQhSQRQE1+zOG2LL2Lvf9+fQ3
	xK5xF+z9vIPyPsCb/2+kJBKormNUcWmP6mxE9ETl12k6dNFqJA9fhhEQEhib0a+0BU3
	N4FVkZcfpEmD/Id3iFDYKPBac+u9y5mj4c5Uv7h+U7pWOyNP5Uq3CLbgSLpUkGtHg5c
	U7zVSKk5HKYHk23cg+gUqUuvNmXxLIAeRE3oKhwR6zCkcB1dhk16R3hJpQ9c4KyN7uN
	JCMaf0wqt1U1y2jM0wzrIzAQhnqk1AaEKZEQgPNwMdHTcqn0NaOPKvPluS+g8o/a7V4
	p4RUkXSdEA==
Received: by mx.zohomail.com with SMTPS id 1755330536462939.8814640628641;
	Sat, 16 Aug 2025 00:48:56 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/7] drm/etnaviv: add handle for GPUs with only SECURITY_AHB flag
Date: Sat, 16 Aug 2025 15:47:52 +0800
Message-ID: <20250816074757.2559055-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816074757.2559055-1-uwu@icenowy.me>
References: <20250816074757.2559055-1-uwu@icenowy.me>
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
2.50.1


