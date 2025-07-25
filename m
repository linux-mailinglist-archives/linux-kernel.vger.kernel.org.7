Return-Path: <linux-kernel+bounces-745314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23387B11849
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4482B1CE286B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB34728853C;
	Fri, 25 Jul 2025 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OdMZAfJw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="c9N+iIZ6"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30028852D;
	Fri, 25 Jul 2025 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424059; cv=none; b=l//by6DEtI9vMIiEb9dPaO2IpaM16xtmIcIb2S7za14UVMdNgM4w1l+rc+kdu+gsaRjllt8l+LBNkz0rMy6TYfXfFp6vjDFLeefifIrueHB445c+Xhcb8Zaj4FIn+jVEfVo3KoNiWcBHeMb4of6qTFMnXjTZO1FMGHHBQDOreck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424059; c=relaxed/simple;
	bh=ux4YFWAdyEss2nlpXap8mgGa2cGRK5sIbyzjEBUzGIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf6jpjBV3xp6UbsaLwWa9W1wKQitCAe/rluagbGB+cVOCejLY63dSypH5XU4tpJyf4SHhAAbQJHgwEw8C8P+U+nOZaRnyrq/BowdbksFNYQCq4CIVI+ZL99H2fJ9M9/6yi6oeMvgJ2bboMaWCjs/h3dwa4OZOc792FdkeuhO8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OdMZAfJw; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=c9N+iIZ6 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424057; x=1784960057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMho35ByK4WFlFJsFIVK8lEJOSFzjAi8I/P8vZM+HZE=;
  b=OdMZAfJwk1WlmP1tlhceGb06rFdj7j0woYewXbPzEjCTXUmWJJQbu+5r
   5ZOBdfBHF/yFq2SyjUDtnNNP5nT8/F+xXK/DF4Hk8UbG08KJWrXdm3krm
   zcSSVMFkR3VTYNpcKEhbYgI06fOFJpNC+uHJFSm4W+tIipAwLCCVKIL79
   dkJiWpBgYgeQtpM8IeQg/cBkvMkddi2WcPLTzWzAhSH1RtK4LqWNLSoUP
   xEgHT0D1oa2Ml10DF3n6L9VXdBlLDu1yPuGUFqXlq8S17GNFFsg9Ua60P
   VpAUFrXZ69JB7UqgztNEoJJStDM8lYfsLJnmMNR7ipRXO2E9s7nGRUeHh
   g==;
X-CSE-ConnectionGUID: n1deL2OQQgSI6ZZZUofROw==
X-CSE-MsgGUID: kOboCL03Rs2UkMpi1GihmQ==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413029"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:14:16 +0200
X-CheckPoint: {688320B8-3-8CC3CD70-C1DBF452}
X-MAIL-CPID: FB3B08457DD236C33772BED2F00BFFED_1
X-Control-Analysis: str=0001.0A002116.688320E6.0062,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92A39173651;
	Fri, 25 Jul 2025 08:14:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMho35ByK4WFlFJsFIVK8lEJOSFzjAi8I/P8vZM+HZE=;
	b=c9N+iIZ6gRtBEpFDCJRiOa5ms2BJPeuX+5S9pz+aqkX74ICX9zOfHt+O202wvtqRQIre1o
	MvRwRpiUQYrsJ4rxfRmStXUsyGyPmjQNVgGLiEx88jgE6SQan2tsbB3XT6+XNwxCtCuN6Y
	evHMX/XyiSHS89wTT2+xVIoXzpj7ONaMPFSnWNTohLYjIMWrWc940QCTnOF7zdL8an2F7g
	s/uPXiDPKsw8+HDPeOi3x8HIODP2gk0nnEYOJg64Gwssk+TI9mW2ICERT0TMwVP5qUX4mx
	Bga+PwvO9llfbwYfP801iue5jnmAZQ0cau74ViFxvm43y61Sr1QC/6wZs3Mbxw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] ARM: dts: ls1021a: Remove superfluous address and size cells for queue-group
Date: Fri, 25 Jul 2025 08:13:31 +0200
Message-ID: <20250725061339.266125-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
References: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

queue-group nodes don't need them anyway as they are inherited from
the corresponding ethernet nodes. Fixes the dtbs_check warning:
  ethernet@2d10000 (fsl,etsec2): queue-group@2d10000: '#address-cells', '#size-cells' do not match any of the regexes: '^pinctrl-[0-9]+$'

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 2f4c0e468952c..3fbc3254d06a3 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -718,8 +718,6 @@ enet0: ethernet@2d10000 {
 			dma-coherent;
 
 			queue-group@2d10000 {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d10000 0x0 0x1000>;
 				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
@@ -727,8 +725,6 @@ queue-group@2d10000 {
 			};
 
 			queue-group@2d14000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d14000 0x0 0x1000>;
 				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
@@ -748,8 +744,6 @@ enet1: ethernet@2d50000 {
 			dma-coherent;
 
 			queue-group@2d50000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d50000 0x0 0x1000>;
 				interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
@@ -757,8 +751,6 @@ queue-group@2d50000  {
 			};
 
 			queue-group@2d54000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d54000 0x0 0x1000>;
 				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
@@ -778,8 +770,6 @@ enet2: ethernet@2d90000 {
 			dma-coherent;
 
 			queue-group@2d90000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d90000 0x0 0x1000>;
 				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
@@ -787,8 +777,6 @@ queue-group@2d90000  {
 			};
 
 			queue-group@2d94000  {
-				#address-cells = <2>;
-				#size-cells = <2>;
 				reg = <0x0 0x2d94000 0x0 0x1000>;
 				interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


