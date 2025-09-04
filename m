Return-Path: <linux-kernel+bounces-800150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1AEB4340C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D045852F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A012529BDA6;
	Thu,  4 Sep 2025 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="md8MrtZ/"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6939928A1F1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971175; cv=pass; b=oot13XsgK/TYFN4+1/3zHS/FvW3QCaqsq0ElByfEfNqjdB2zAEE/VoC3OCm3PsVSJnI+8ZXpsNhMUkN51v7FaeWmCgdV/FkaRLLOVrMZJipnamjlXaAAVZs0aDUNcL4wIv9C1IelAeW73TSiQDWc5+pts1ApkQV080KN574qS9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971175; c=relaxed/simple;
	bh=cHdy9k1LRZd0qthZ/f13X/xzKN7i2AGyPe4chcKH28E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dozlnBqxqAsXkjMGhYkOz9KRgZSy+VdxdSKWUfVhJeDRlOSze5LCeDlEoELkNmEkxZwg+Pt5UIyM7Qksgsj+2Rf+sWJu1R13WMXn2zPLzPST3NO/jNpzMraBHRfZZ6LlwNIjfZyuQ+9u+qlHZWo5Nqwat8StOJJOtS4Qeba14x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=md8MrtZ/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1756971156; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PDtkBbrQP67DLJK1tUaSkndCHxlHgp018lVKYCP/0v0oHiGqRFSzi9JDmtUVwk3c5w2CZxLQHOcuFks3tOSMS4o2uvMa+tHyyJwws1NdnaCPgN24AYLyJXaBbBqdS0nDmm6/axTHyKtkfmmNjmRFZFyD9oVtIC/bnCNsy4rcd5s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756971156; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pGOtwpWAaJdT+GipksIOXm3viEyCHLpm9n12DMU0+8E=; 
	b=gVI/yRgvVZkw6b52L/6b47hAio/riXqrtDGHT2YZVTym0w5H6FaOShq8dg9DRfDuzMHm6Ca1li9ZFtMjbKUEcvEH7xDrIZIBl5KmT3KAKMOYevJ9KjNDDbB/0Hj0FowrBD3PabskFLlNZUwjespdHq1VIL2FN0sNGr/36mpGTY4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756971155;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pGOtwpWAaJdT+GipksIOXm3viEyCHLpm9n12DMU0+8E=;
	b=md8MrtZ/RtRPcNhasxRSGp9SelkBRsMJNu2B3yj595f1EFXLAq/7KAdAVXyqXMP4
	+1g5sq4zhUWJP7Rn5OW6DqrYm4k6ouqgczWKEeh4iEyCaeaiOOqP+wn0Kngk0uZiIgi
	RFSbRAiYodsgIDiRz9N2j5+S0KNwD2syJHLLfST8sNlEbEmzITbvG0YcFDTJAcA/14O
	PVS1qFscbtl1hdAz0x2OFkga5Qa2/6yFJCTCNFB955Zl6ionDoamaJDQlraWhFz45eD
	XgL9XBxqRbg9UycTDzxTKOhc6RBbH63xiMFsBfCM3wGWCvNjvcPZFQkbX+fYHqkHKqb
	1ZlWvwrYQQ==
Received: by mx.zohomail.com with SMTPS id 175697115302280.71846743294384;
	Thu, 4 Sep 2025 00:32:33 -0700 (PDT)
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
Subject: [PATCH v2 1/7] drm/etnaviv: add HWDB entry for GC620 r5552 c20b
Date: Thu,  4 Sep 2025 15:31:45 +0800
Message-ID: <20250904073151.686227-2-uwu@icenowy.me>
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

This is the 2D GPU found on the T-Head TH1520 SoC. Feature bits taken
from the downstream kernel driver 6.4.6.9.354872.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes in v2.

 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 8665f2658d51b..6a56f1ab44449 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -69,6 +69,37 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.minor_features10 = 0x00000000,
 		.minor_features11 = 0x00000000,
 	},
+	{
+		.model = 0x620,
+		.revision = 0x5552,
+		.product_id = 0x6200,
+		.customer_id = 0x20b,
+		.eco_id = 0,
+		.stream_count = 1,
+		.register_max = 64,
+		.thread_count = 256,
+		.shader_core_count = 1,
+		.vertex_cache_size = 8,
+		.vertex_output_buffer_size = 512,
+		.pixel_pipes = 1,
+		.instruction_count = 256,
+		.num_constants = 168,
+		.buffer_size = 0,
+		.varyings_count = 8,
+		.features = 0x001b4a40,
+		.minor_features0 = 0xa0600080,
+		.minor_features1 = 0x18050000,
+		.minor_features2 = 0x04f30000,
+		.minor_features3 = 0x00060005,
+		.minor_features4 = 0x20629000,
+		.minor_features5 = 0x0003380c,
+		.minor_features6 = 0x00000000,
+		.minor_features7 = 0x00001000,
+		.minor_features8 = 0x00000000,
+		.minor_features9 = 0x00000180,
+		.minor_features10 = 0x00004000,
+		.minor_features11 = 0x00000000,
+	},
 	{
 		.model = 0x7000,
 		.revision = 0x6202,
-- 
2.51.0


