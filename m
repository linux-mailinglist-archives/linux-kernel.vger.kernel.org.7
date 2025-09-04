Return-Path: <linux-kernel+bounces-800153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B587FB43416
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9E77A3DA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBBF2BD580;
	Thu,  4 Sep 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="iJRsZ5Ka"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90129E10C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971192; cv=pass; b=OSGgj39W+aH4YQA4vVR6Rq3y1vr9uQmHv9ap6RAOXC6dQLeXD1cud4wIgaWIcq93z2OTWmbf0T0/VOknvnI+Y7LPVlCOG0upFR60YFT1Mw4yzjJhW/zFk3M/u1rQH+2NOSWI7romg0hRUBsoyxTARmQ7jC67VB2LwPCwo9Jn8e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971192; c=relaxed/simple;
	bh=M4Ts9Tgr36uviZHojuFSXvN3aCrg3kT06HPPj2FLqns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xc9slkVueDd0wwTSbNelB1hNN1bCItoI8vzPwDFTjgEdOZGwwn4Q+pGCVBBxH9KDEPid21XY1zxb9bF4LPydjf/5uER1assY3EpkIt0ir/bPkhOCopREdH7q7SlGqNYkNVC0nFMGGcXP7PcpRBUyU5P6miPGUpxiZzJrvoyziBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=iJRsZ5Ka; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1756971173; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N830F5wCRmvGHXVmsXdayID+KtpY2o6AJO2tdC0f/MH1zdB1usLtXMzO6ttVurh9YjURoo37Ub/Xeh932XUgp72R0QxWNr6lhhQYf2LfhCalx7BAZnpIz3meRa69wbSqjh48nBN3ViCOkgeQ40jzbi64IBHHOkvc2tB1i7oGbr8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756971173; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p9rz+uqQBiZe0UfpVbdcyvqjvC0WRMUSRqowV8Z/90g=; 
	b=Phi3WAXsrZHdA+DfeIi7LkCkmOTlCTmWg5araHSQb5tZBmjMZCDJyUENygcoq9WoX7Qf5MFPDsPSVlkPPN32jEWJ+VgrjiuQE3+sZFU6atnebIwSR55kUBLSP7cgapQI8CA5kxcVP/KELsFbbYpcQYKcKO6NhquBXUhjdHvbqos=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756971173;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=p9rz+uqQBiZe0UfpVbdcyvqjvC0WRMUSRqowV8Z/90g=;
	b=iJRsZ5KaFmvFZsr/OqKS1U0LB+C82w9uTKq2gw3yjnGuhrqWdirmTddpGoSKJNGa
	jPBKusVIlHBZD3zBs3grmOEaCUD5YysN3xzP2pNJnRttlBOWsYMgksP+hAdjwUZw6CS
	0DdpHnb5uB/+TK5e3sAWvqrTkFvrtgTYvj+oTec/NGxsYGZINyLb0TgQDLgiXOyz/tG
	VleSIqFbtAQ8eSGxQmlCH/tbqLNBjDGW+dqUKWRtHy243kZ3TViprgaIZQA1ekX5raY
	Tfj2Opj/IfykXHK+i5Y+lpjkNyIaZfcX6DbP2ZeIjoZiZ/kHqtXDaYWMEUjgohx08M3
	EuuTn1LlnA==
Received: by mx.zohomail.com with SMTPS id 1756971172084895.5447141221532;
	Thu, 4 Sep 2025 00:32:52 -0700 (PDT)
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
Subject: [PATCH v2 3/7] drm/etnaviv: setup DEC400EX on GC620 r5552
Date: Thu,  4 Sep 2025 15:31:47 +0800
Message-ID: <20250904073151.686227-4-uwu@icenowy.me>
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

The GC620 r5552 GPU found on T-Head TH1520 features (and requires) a
DEC400EX buffer compressor that needs to be set up. In addition, some
quirk exist for the DEC400 part that needs to be handled during GPU
reset, otherwise the reset will not happen.

Set the DEC400EX up and add the quirk code to the GPU reset codepath.

Currently the DEC400EX setup is gated by this specific GPU identity,
however in future we should add a feature flag for it.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes in v2.

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
2.51.0


