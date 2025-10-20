Return-Path: <linux-kernel+bounces-861010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD97BF1931
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 837A14F54D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE5531E0EB;
	Mon, 20 Oct 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ie/m1/Mi"
Received: from mx-relay19-hz2.antispameurope.com (mx-relay19-hz2.antispameurope.com [83.246.65.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775231D758
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967546; cv=pass; b=CPkvh2ojVz2BxXksxRhq/xid3u3q7AoT6Bw/gVXiSsGpGkJU2ZZtweBFDC/9VdYvFCVQEyVSm0eO/p4gxPRIC26BIMWwcjim6P8D4aRKa2HJ379xvdEK1gmHONmYqO7XLvAPuCEKWSoAxBDU5VzmCe7w54EOggQoTrtBpZT++Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967546; c=relaxed/simple;
	bh=gtCPPewMEBC8D7JOzdiBWDfrypJ2zDljjzYYOx3Ruuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZ2AIhIAxB9nyHJS+iZTQhRJteqrkbFKRTfYRukPfAyrPE+RlwDyg+pscpU1YgiY6XKGEX4YUiGLHBW25SaAxxJ+yik8h/HskiI9MeWkIgiV+b2iXtzwGgaMNkeMfn6bhBCnI3onxuZzNvTH3dBg4Ej+aXjSHc+I3+dcGj8yr6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ie/m1/Mi; arc=pass smtp.client-ip=83.246.65.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate19-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=iMew/cU0hjBoxwBz0iB+7LijsCZyiMyr5SL5xMs8+vU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760967488;
 b=kri0Ga7lSZywPjX7jIh/u3yuFP+l0ffEEtOfumE0499DeIahpgVTu3b7or45slZGpZpIo1bV
 kA5Dg4VmfG5fiWD+uq2DG7AC0kmX3q7U6q9z01BcwUIJgkxyWPSEWyh0fJfLAN7ZUVyKE1JeJ3H
 uvWrOntB2EeoMFMaw1YI8fYiqs6t1dM5lxhkueYTwy+587RuvFK1H4oN+rdMgUo2Cg1vkg7VivN
 FaYL0B6FvLKCp8urFApUdoUCTcL7CjZP9Cd98wDz8EO/RowoOaYJZ+drBTZaa1Wb1uz6asdRcww
 N1huGtNSLmpBqAMYzNm/U1D3A+rKxvz+UVSJrC0DZfJiA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760967488;
 b=HycnuTkC5+s38ROJ6IjPBUyJFTb4mmnTMqdLUoYo1/dfLxXdBSE9+L7RcRuXmIjVZ5EAF5AP
 he2v+1qv91EsrVLy63B9zuQovm7UBt/Od5EPIxusLQImGebocQc5ZG8Cud9Ev6lDudO6ge9vxdi
 j0gU0i9M/BDrgA1bgkWPHnoaAoXILTTVc3loDW72YTr+TA3DyMQ+GQ8KAZ7sSv9EGd6qiq6WsVq
 Fqwgmfg+o9/xykwnxOyQrGMuH+Ww8BU/GPS9/KEQ/aamabDq6MaKao8xxIURyKenwGkskQsRxVa
 eIK//EGCX2Skt0oUD4qhvLze/AZOkxQ3xoJt93vqhfyQw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay19-hz2.antispameurope.com;
 Mon, 20 Oct 2025 15:38:08 +0200
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 325B1220C57;
	Mon, 20 Oct 2025 15:37:56 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: fsl-ls1028a: fix USB node compatible
Date: Mon, 20 Oct 2025 15:37:53 +0200
Message-ID: <20251020133754.304387-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay19-hz2.antispameurope.com with 4cqxM85HsCz2Gk5X
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:a9ced658393900b1efa503262e27cae1
X-cloud-security:scantime:2.178
DKIM-Signature: a=rsa-sha256;
 bh=iMew/cU0hjBoxwBz0iB+7LijsCZyiMyr5SL5xMs8+vU=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760967488; v=1;
 b=Ie/m1/MiYffkq00SChVBDn0TYQHGIl372Zq9eOPiY4loeiHVOXCrr99o9INvdZAuiYQwfpHV
 d4jUMFY0PXArHhjsI0JqRcg2aevOpdwiYvC6GGWcZ4SuZxzf0Y5fiUQSii9xBp/dzeRSjYtea4H
 UJEnfYOLCR74Uhsl+2Vs/npPEeK2Hxm/RPNeZMMMEG3IeHbE9xkMbtzQFMvr6fljSD2/wgg5xyI
 KwLDtE8kuJZ6xdtn3PQ1pXxy1zdsMqyaWWFJ1OOr8J9axy/IdWJJSSWfa01nEI3SuxpN499dagb
 q8kkFVffF0UcnAPM2a3zAvzGU2yYu8v+bf4+2ejK6/bnA==

usb/fsl,ls1028a.yaml says the compatible is just a simple
'fsl,ls1028a-dwc3'

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7d172d7e5737c..ddfb007dda920 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -613,7 +613,7 @@ gpio3: gpio@2320000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			compatible = "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			snps,dis_rxdet_inp3_quirk;
@@ -623,7 +623,7 @@ usb0: usb@3100000 {
 		};
 
 		usb1: usb@3110000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			compatible = "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			snps,dis_rxdet_inp3_quirk;
-- 
2.43.0


