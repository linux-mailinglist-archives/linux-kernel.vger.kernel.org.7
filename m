Return-Path: <linux-kernel+bounces-771788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1D2B28B93
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE5AA7D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6704D231836;
	Sat, 16 Aug 2025 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="jUmOF3tp"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB623183B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330570; cv=pass; b=PQmsel48r5ZpTcajfTqs+WyivQFdNpe2oBVLyuoF3oMlJzB7laov7cX1XIOre1Zs7wCvBbhA4cQVJ8Jz8KiHIEgNhE+FhlLJpK9WR4rvo/dJqxSZ48b7WyCYl+0LkWJXOAOr8PgSz2N7SCYiAOuMfV5zuuRo5JP+6+oEusgYsJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330570; c=relaxed/simple;
	bh=4h5SEZKxipwerxJY+MPENwlzwNQMS8EFhHT9fVAZ+nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyeylcfHpfDPwtGcZkTHKWym617RzKdDYRG0p+XmoXYlz6o3xfXqHN27rS4oYYnrRLSukzpntK+/WHNW35nXWUiqwYYJ6nwUJnSZLSVtgc62meP+c9oL1/HO3Lc1vVhNLpJBOh3QwXTtFCg3/SjIh/2xMWgeTLPOD9+R3fEtXVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=jUmOF3tp; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755330551; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GGx/y22vt2n1+VvXqcL2yWNISLQy4SswC3PcUorScO2WXW70gvIjkkcb8kSaKdDQIafkgPuRGr+/0gGiNJzSTDqYog+q4VV5Fh3NDjxibz04TKFC+yV3xCD1q+FQ+I5bbOPaqrOG49zq14gmMQGL56ZoE0l9zfBP/YEA9WDq08I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755330551; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cUbeoz3eH2Lp/NXawnV6Nuu9wKEOZRT4VvJUTFslJ1M=; 
	b=JE6YfCJ4AaU1Dwlvhzd60dYfZzy+C8zMgltuqNXSaanwAkTwnumHETf/QIzxB3j1xvY3ssIOVFbi5yHv1Aw6P6u3o5lYlk8anlTwGoc/v3vRsnsbXnZLtA1yXEmYMjCK9iukawYr1n225tfNiOHzu4hl4Gh1sgEaQ8JB7Y/D3Mg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755330551;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cUbeoz3eH2Lp/NXawnV6Nuu9wKEOZRT4VvJUTFslJ1M=;
	b=jUmOF3tpWt6gG0OC6wxeq1XDIjFVEXlKRh3WkQCtROEYE4OJRzhrgRmBQ9RS7hrv
	Bwrzmv/CfFWEkfgZhfnt5pUMQb1l1eVEiQEwU/q3vfiSfXMbxxrIskYN/HX7NsFGouY
	z6Jm8m2OqtHSX3SS2biCDxFynVBSPGyN2BSleC6rwMi6JR1tQdppG9fLq19CgP4VbDN
	HYnOooly7hRmXUdvxN7DJg9Ljiz77t2shehAFugY5xf8jgXQEmWsiDdC3RRH7U4rWp7
	i9y8UCgCnn9I9vS4TvzA1e5fttjypXdYfvmZaaNQzusw7tbK1MgdnqzeKhv8K7jr9/C
	evok/aeJTQ==
Received: by mx.zohomail.com with SMTPS id 1755330548740860.1574521157502;
	Sat, 16 Aug 2025 00:49:08 -0700 (PDT)
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
Subject: [PATCH 3/7] drm/etnaviv: setup DEC400EX on GC620 r5552
Date: Sat, 16 Aug 2025 15:47:53 +0800
Message-ID: <20250816074757.2559055-4-uwu@icenowy.me>
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

The GC620 r5552 GPU found on T-Head TH1520 features (and requires) a
DEC400EX buffer compressor that needs to be set up. In addition, some
quirk exist for the DEC400 part that needs to be handled during GPU
reset, otherwise the reset will not happen.

Set the DEC400EX up and add the quirk code to the GPU reset codepath.

Currently the DEC400EX setup is gated by this specific GPU identity,
however in future we should add a feature flag for it.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 7431e180b3ae4..a8d4394c8f637 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -559,6 +559,10 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
 		control |= VIVS_HI_CLOCK_CONTROL_ISOLATE_GPU;
 		gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, control);
 
+		if (etnaviv_is_model_rev(gpu, 0x620, 0x5552)) {
+			gpu_write(gpu, VIVS_DEC400EX_UNK00800, 0x10);
+		}
+
 		if (gpu->identity.minor_features7 & chipMinorFeatures7_BIT_SECURITY) {
 			gpu_write(gpu, VIVS_MMUv2_AHB_CONTROL,
 			          VIVS_MMUv2_AHB_CONTROL_RESET);
@@ -797,6 +801,15 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
 		gpu_write(gpu, VIVS_MC_BUS_CONFIG, bus_config);
 	}
 
+	/*
+	 * FIXME: Required by GC620 r5552 as a bug workaround, but might be
+	 * useful on other GPUs with G2D_DEC400EX feature too.
+	 */
+	if (etnaviv_is_model_rev(gpu, 0x620, 0x5552)) {
+		gpu_write(gpu, VIVS_DEC400EX_UNK00800, 0x2010188);
+		gpu_write(gpu, VIVS_DEC400EX_UNK00808, 0x3fc104);
+	}
+
 	if (gpu->identity.minor_features7 & chipMinorFeatures7_BIT_SECURITY) {
 		u32 val = gpu_read(gpu, VIVS_MMUv2_AHB_CONTROL);
 		val |= VIVS_MMUv2_AHB_CONTROL_NONSEC_ACCESS;
-- 
2.50.1


