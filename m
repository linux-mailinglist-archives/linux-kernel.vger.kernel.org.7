Return-Path: <linux-kernel+bounces-771785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608F9B28B89
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB8CAA7A4C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E262229B2E;
	Sat, 16 Aug 2025 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="T+Ewstl5"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864C21E091
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330544; cv=pass; b=TYoUaKqzCDSxq1l5pJju3dtvOh8/hWm8AIafAWV/8Vw743CX/O+QrTSFJqLv/nTurR5lVNOYiKhyorRZn00yzQ2U72Gq0hWsmlLJf6p2KjE+Yw5xpTA5uOY+pJQja77xumbXxwHqDfdusbpXX0T5qnQy3+96Fh41HyL2WlNyK1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330544; c=relaxed/simple;
	bh=rsw/E8fkYiLSxKYzk1YYNZY2UAf5vCmiUnz9JCFM29I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoTwoWoOU7NA9PQ2qeQ3v8p0+ZpOYP7yO0rLsRVJsEjFMUyU2Q3KxN6rFJY4mhM3eUC/fjsI9a/MnMSTHmq52sjh42SgtKjxPsFAeMHREbS3m84XHpaHghwPANNcM2QrdxOjji+AigI13uWtPTZh9+K7datgTWVjqgPzB8jA97Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=T+Ewstl5; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755330525; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VJuCYtbP8mrUQI9T1j4bi2711bcd1Ushr3otFT0qX9HfnUBl2yyrca5PiG8z2/j2LUn2yaOLEZQEw5bpGF4soUPnK6OrWeQmranSaxj/it98JH47ji/zQ8nCJr2LFWuWBfqd1C1v6caNqpSTHy/oLOMiNrYqs0c2RdUpF6SWmXU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755330525; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cN9lFebZvsPmUPzA51YhqeWIG+6E3sTLNVCRnql52zU=; 
	b=lsN3UfO1JlPm8BG0r2TtNGoDnKMfDwmIJ3BcTgo9A6rlKgLtsaLSlZ4whakDVutmWOkH7aIGToeh+hDmFA5jPtl/tyz6EK9MiCMJMCvhcYXj6H+9/EQfw1JjpcSUqaX1arzoSDQNte3xI5WWrDB7yOmDir8Wimw8/Cf7DVXtwbM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755330525;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cN9lFebZvsPmUPzA51YhqeWIG+6E3sTLNVCRnql52zU=;
	b=T+Ewstl5U9bHCOwOiew8z7hoW8vCH01/LbakLU+sxXKDLII9KDCemLjAerWcZtUa
	TtbWv1JhHUp04mJ3yG9XbCE7PVokb7U9UMYp+qUE9XhEk5Qb3jX3jo26aplbEXz6iKE
	KnDyJlrKejHjw09N8Yq7IsEBAuExfB3fvUoDvUV6quPKp3PVrwUcvnNZs3HnJLD5cxV
	QHW/u8qzmZUb2yIl9C8zLEVVYbj11qpNrg5ySI7BiCvX0ugMQbSeerG0sTaDHKeUdPN
	af2LNR8on3TeSmsd9J6rP3kJ5dbkEAa6LanGb8L5yOzfTcoDk39qzNaW4dOZZLkSEq4
	5CZP32aLPg==
Received: by mx.zohomail.com with SMTPS id 175533052326799.97496694678875;
	Sat, 16 Aug 2025 00:48:43 -0700 (PDT)
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
Subject: [PATCH 1/7] drm/etnaviv: add HWDB entry for GC620 r5552 c20b
Date: Sat, 16 Aug 2025 15:47:51 +0800
Message-ID: <20250816074757.2559055-2-uwu@icenowy.me>
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

This is the 2D GPU found on the T-Head TH1520 SoC. Feature bits taken
from the downstream kernel driver 6.4.6.9.354872.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
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
2.50.1


