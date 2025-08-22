Return-Path: <linux-kernel+bounces-782048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D479B31A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B47AC256C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6664307AC4;
	Fri, 22 Aug 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QgGX7ZhP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="s+1VBDk+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C5305056;
	Fri, 22 Aug 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870618; cv=none; b=fGNcvdOI8iltir8elc4GxRJkEAa4+AUPuGN+7EwMj3RBIZUlH4OIJlVu9ifNAGWy7fv2dU3LHY4avmQUxhfcHxh7J4hmo3qkswj7Uhz8sRlU2maq8atMBWgn/ju3ab9O1vdeaiicmMKcYjZ41kTdWbFnZMVBuF3h5823FOkINoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870618; c=relaxed/simple;
	bh=O+jSnGaHmKUiGj/WIWuyxFIkp8DW2wFsMApt4aRCWk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDRUDWT5IC7AnpD/3l0hZgN89oBhFb2wy0vCx9ZUBod50e/m3lInmXa/Kilq4d3hU+tk7pE7qGMrD03ZlpsyIlQIoywGSbH8VXrIurr7HLQF0SDzE+yQu2Vm3FM10bzubZ96sVrlI0LxX4OQNoFz3NzVhcwYHBDrqaWWY7AYQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QgGX7ZhP; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=s+1VBDk+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1755870615; x=1787406615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i8SzWexuyxV3a/gZZD74upExkExDhyw1A7Y1hYQSeJQ=;
  b=QgGX7ZhP/qsjNITTnIeOJm/Z0tJcrWt4uLrPb+EU0lDt0wOGKnwjiTqr
   jUAp6bGQV/ANp8cUmNTOEAEXbGsrgmrR5cxbZU+gUupc2wCdKm9guwM4p
   MpS/BbFgG5jOmAZdyAA3CJIVA+TM9B528yvhZlkVsNu57/dfXLOjPC4ur
   pAiUdU+v1aWH/q2LgVPEtcMPGCCr6268SPHsvJeK6tiFQRUI87ayn97Jn
   YA6OwmRm65cBknDoVpobfoHlAyibt+7TtIWCejXybRYvySc301n20zK8s
   7jGR2fkogF/f5lJvD6j1jmqHjVas94KycAwUfjrZlXdwIrfErrCYVz9pt
   w==;
X-CSE-ConnectionGUID: RK9H41DpTCS3CByLwAY3rQ==
X-CSE-MsgGUID: skqb6SrqRDSeFAom8mYn5A==
X-IronPort-AV: E=Sophos;i="6.17,309,1747692000"; 
   d="scan'208";a="45868362"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 Aug 2025 15:50:12 +0200
X-CheckPoint: {68A87593-22-20CAA7DA-EC9DC758}
X-MAIL-CPID: D0CC8B2240F01A85C119B8645B255DF3_0
X-Control-Analysis: str=0001.0A002119.68A875CC.0049,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 626E3160B0F;
	Fri, 22 Aug 2025 15:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1755870607; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=i8SzWexuyxV3a/gZZD74upExkExDhyw1A7Y1hYQSeJQ=;
	b=s+1VBDk+fgy9gxQMAjPdNyt098wOeiyJM/96Fa9To++aaoDGuGvZhl03gt1aOqHeZUfrB1
	ArdVeUUUoVzwcwfmAegOUzfppZgiPNXiFBuyZyiwN3bXNohJBcpiBNT7SgrRpv45BwaEFn
	aRA3A7gu+R6nBseyw4TnWdFt1RH4UlqxBnS+HNIvEmS+0ZILdwhsu6on3PP8sCTStO1p20
	EZj57KM7ckqM9BVz+muI/Ez6XlIK48KtBOqdjHnXusyLLWTG9eZIJvwYHJcOF2oII7OTl1
	8VW/1l+r7sEv5OV0eOIu1VNwovmcUjoR0DSNIxUmJkGbNSMw8p5+5RIZs+4Dsw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: mba6ul: Add MicIn routing
Date: Fri, 22 Aug 2025 15:49:54 +0200
Message-ID: <20250822134955.3321137-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MicIn is connected to IN3_L. Add routing including the Mic Bias.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
index 67a3d484bc9f1..65fde4f52587c 100644
--- a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
@@ -146,6 +146,13 @@ sound {
 		ssi-controller = <&sai1>;
 		audio-codec = <&tlv320aic32x4>;
 		audio-asrc = <&asrc>;
+		audio-routing =
+			"IN3_L", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"IN1_L", "Line In Jack",
+			"IN1_R", "Line In Jack",
+			"Line Out Jack", "LOL",
+			"Line Out Jack", "LOR";
 	};
 };
 
-- 
2.43.0


