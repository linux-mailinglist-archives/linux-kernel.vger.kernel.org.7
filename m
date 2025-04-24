Return-Path: <linux-kernel+bounces-617715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F9A9A4B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 09:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8571117A33E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE11F3BAB;
	Thu, 24 Apr 2025 07:48:51 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37E1F3D44;
	Thu, 24 Apr 2025 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480930; cv=none; b=UKfharKhIco8lHalgbAWzcoUexiWTHm8qX1fk+TDNZddPxf1fW59exQi1IOcAX1sPpyoDD9tIZDPGFxMSbeAuHvR8doAOttEHLYpVn3IDmXnRzc8W5HThGLFM/PT/ub7MO1S1GznChmtLaW07VxFlRWqeVmEK29wNXXLvebJeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480930; c=relaxed/simple;
	bh=h8qyXCPlBe/4wFwBbCk4SfrjsMZ6UKaZRbul5coxB50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJphuMf+HDgrfhNLm4w6+dG6p7AETW06brBHEKTMtQsFhyuClt7zsfAeR/9rxmGmSi6BYstuSMfuP4BpklF9nu6R6NIKX4mVoV5C/F9OeMjfx7a+fylf9wUAgoQSYr0/+rg4rp5gVaHLrGGMGYolS4YiFbYvwyzxXc6KDarAzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6C78C343030;
	Thu, 24 Apr 2025 07:48:42 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 24 Apr 2025 15:48:08 +0800
Subject: [PATCH v2 1/2] riscv: dts: spacemit: Acquire clocks for pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-05-dts-clock-v2-1-17d83a705c4c@gentoo.org>
References: <20250424-05-dts-clock-v2-0-17d83a705c4c@gentoo.org>
In-Reply-To: <20250424-05-dts-clock-v2-0-17d83a705c4c@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=h8qyXCPlBe/4wFwBbCk4SfrjsMZ6UKaZRbul5coxB50=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCezOOopeiC4gA5F1SvxOgpKStOhuUDoFDQZj2
 h02c1imA/qJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAnszl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277UajD/9tfu0OAGMk9gZtFA
 vLMX70/AkgG7K/hM2PQMjy6cVgXuWgCn4MI7sLenRfvNQCLitfvxAGfQnHodP71fjON2lr/Pu+s
 cAfsfAk/L7583BiUSpUflYbtsyalAaR2cQWdHqLIhPkt5EASMBgBawtW2a45tPieggoj3f/res7
 tK0ZyTMgHaAUithRz8FtVjhQChKw80JGgDslqFW5aBzEZn5gTiMExbJZFPpRD8wp9x6X5fWzm0F
 Lt3azzqVn50DWkAqtNivUWCMA45Sy6f3Y88p0swJocX7OFmY5WIsouwvSsjbml9tmwnlnUm1U1e
 zd36My3Bc3xQDciGWF7RHKq/Gqz3R8DlOlrpMbLtwOKE2aDWIsE3akQ7S5Tzm4MiEwQb3MBVJOc
 RYvkYID9R4CNkemyb/bVC7AtYFTvwQayxXTs/do6BWC6jZx4/an41grvqTWqPiHAmtwXg1UGwgl
 /rDMzltm7i14kQ6hls0u7pyfzFNVOYsD0mZ5Qb4RdIgW0f6FanJygQBDLCDamnpbHTpbCgYCWNn
 nGtf7vodnh3pyNL0E0BjqpihQknSIfN8zJ+qmxjAvoVDANGCyGI2QOa2JvyVbIIkH6QJKzdX/Cr
 0ZJECD/PozLC/BT7vf369rCp1sgdZCjO4b/UNCn/qrMrKUyP7+cOvx9hqZRQDEdwnJzA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Pinctrl of K1 SoC need two clocks, so explicitly acquire them.

Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 584f0dbc60f5b0d078c7127cc4021ad6022cb182..153fd1160182b42fe1a2f7f042c9c1da90f63b0c 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -450,6 +450,9 @@ uart9: serial@d4017800 {
 		pinctrl: pinctrl@d401e000 {
 			compatible = "spacemit,k1-pinctrl";
 			reg = <0x0 0xd401e000 0x0 0x400>;
+			clocks = <&syscon_apbc CLK_AIB>,
+				 <&syscon_apbc CLK_AIB_BUS>;
+			clock-names = "func", "bus";
 		};
 
 		syscon_mpmu: system-controller@d4050000 {

-- 
2.49.0


