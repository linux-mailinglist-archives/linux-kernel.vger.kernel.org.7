Return-Path: <linux-kernel+bounces-760437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0642BB1EB0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4C4163BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75728469A;
	Fri,  8 Aug 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ln0yeuhN"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCB281378
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665078; cv=none; b=Hgx/4CUw/ztqdh7ePN32mo9NWCy8TEyiexvLv3aBzXNoYuu+YQWrITbcLEtTWhRsthFAwGd2q7Q9WukPwy0C8kV19wZEdgkzT9SUWoG5ILZsy0A4MZ3CjBvyND70vJYfqWpnSmez6uQdMOQ7+IKYzk8jFbvvAcIAyEOYh/EME6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665078; c=relaxed/simple;
	bh=A8STBaxx9I+xMUgXfkDUz2kVzumz6DLLK6zFy4gCZ28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=arv0ZH/2n8dCzPKhpqt6dFL02sDb+F9Eh7XYHB0I5VhZVRHTWMq8NqnXb1wds+ZhbjblpQPHV7EgktMuq7PIW6jzh9L9sE/FqzkXh9OSIPyWg1AX1ELEMGz+EtpilInErm/LHQjrXi9dwzEsgf7AVeNfGrWloXMWlgS+zZ3jsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ln0yeuhN; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250808145754epoutp04706a4b12d02e4fe0b807a8fc71a5d0e3~Z0pbHinkI1907819078epoutp04-
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:57:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250808145754epoutp04706a4b12d02e4fe0b807a8fc71a5d0e3~Z0pbHinkI1907819078epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754665074;
	bh=PvWZRkwj5ZFZifDJB7KBU3E1y8XyQBPZTs6Fs+MO30M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ln0yeuhNhJmjA+BqOSFETAoCJ85N/qKBQUaVTOnsJJDpiIwYBU5com9fG+E1wLZLF
	 AY9gdTiTYZIxmPeDEPO7Os3af/oyBUNvdKYkzsGaZzhuXMMS252zP3cwO9tfd4TAmZ
	 AfWCYut9LeGVE5cTNdgGXvk94M2UOlpgSu0xJ7co=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250808145753epcas5p25377633d375e26f9b62410f583ebe42b~Z0pZ5oK2z0558305583epcas5p2h;
	Fri,  8 Aug 2025 14:57:53 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bz6b44b1Bz6B9m5; Fri,  8 Aug
	2025 14:57:52 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250808141247epcas5p2c254f35146a6ea35b5c49c4316ba30a3~Z0CBUhhgv2375723757epcas5p21;
	Fri,  8 Aug 2025 14:12:47 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250808141244epsmtip25ab7207ae5593881a426a7b3625b1e65~Z0B-BJN4D1615716157epsmtip2O;
	Fri,  8 Aug 2025 14:12:44 +0000 (GMT)
From: Raghav Sharma <raghav.s@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, sunyeal.hong@samsung.com, shin.son@samsung.com,
	alim.akhtar@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, dev.tailor@samsung.com,
	chandan.vn@samsung.com, karthik.sun@samsung.com, raghav.s@samsung.com
Subject: [PATCH v1 3/3] arm64: dts: exynosautov920: add CMU_M2M clock DT
 nodes
Date: Fri,  8 Aug 2025 19:51:46 +0530
Message-Id: <20250808142146.3181062-4-raghav.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808142146.3181062-1-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250808141247epcas5p2c254f35146a6ea35b5c49c4316ba30a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250808141247epcas5p2c254f35146a6ea35b5c49c4316ba30a3
References: <20250808142146.3181062-1-raghav.s@samsung.com>
	<CGME20250808141247epcas5p2c254f35146a6ea35b5c49c4316ba30a3@epcas5p2.samsung.com>

Add required dt node for CMU_M2M block, which provides
clocks for M2M IP

Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynosautov920.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
index 0fdf2062930a..086d6bbc18b8 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
@@ -1454,6 +1454,19 @@ pinctrl_aud: pinctrl@1a460000 {
 			reg = <0x1a460000 0x10000>;
 		};
 
+		cmu_m2m: clock-controller@0x1a800000 {
+			compatible = "samsung,exynosautov920-cmu-m2m";
+			reg = <0x1a800000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&xtcxo>,
+				 <&cmu_top DOUT_CLKCMU_M2M_NOC>,
+				 <&cmu_top DOUT_CLKCMU_M2M_JPEG>;
+			clock-names = "oscclk",
+				      "noc",
+				      "jpeg";
+		};
+
 		cmu_cpucl0: clock-controller@1ec00000 {
 			compatible = "samsung,exynosautov920-cmu-cpucl0";
 			reg = <0x1ec00000 0x8000>;
-- 
2.34.1


