Return-Path: <linux-kernel+bounces-782093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4864FB31AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253CCB0227E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2ED3043D7;
	Fri, 22 Aug 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cFgt+Y6+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="RGs6IhMO"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB32F066B;
	Fri, 22 Aug 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871707; cv=none; b=XV5b2MuzEwX+ERBR3bOu9m9JP7703YdoMvR/hpY6MQhBiU3FHZv+iNJ+cbsIzxkfpIgMCybmcDwALsog6VzmdZLF/LY/FPEfJ0u6XJETDbzowD3xi2PCalTE4sqzceBPcdr5QJNVJGaEle/CbJClJdbgvRjg8FV4EJthVZcS5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871707; c=relaxed/simple;
	bh=dnNU8jPjjkJZUhbpXRRCzvNilR/RjhmQxT+1QfkQ3Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rba8gysr6vwPHXGu4J/TpyD3jlYj9EJf+4ANFeiKFdM1c4ZDC+gg8d1AhVkJNft3GdUqv2F4ZMcn5ctvNZ47MO/a2zVIxyUnwKc7Tii+Pat+dy+cCvyMYvDNJftigKIGpMJhVrc8UasMhB9COPufxdBbNOzRrjHKbUCdGHasU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cFgt+Y6+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=RGs6IhMO reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1755871703; x=1787407703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tS+nBEv9oHEaSNtYsqRT1ZFZCy7e2jnR6M1qWnJYb6E=;
  b=cFgt+Y6+/r6SZWhfnH2rDTnw2/DjqTr2kF5IMhmkDPh2CJXN3ACroRF6
   Dv7ElfQGCZqp39FOHAAIYzU3gVDdgh0dsJIDgRBVO6cjnWtHtHjw2vgxV
   CNsoSOjj6FlJq1Mgzws5g9eeoJkKgXZO7pzb4qUJNdZAHKoXyBtjb9ejG
   W6zdE1EbJNHaENHywMzzGulEVu4GuBr4Sy8+DeqxX1clM7aoSU5v8KxvP
   KmNEG9Dy03AE+hjugiDWq3DVH6m91Ot4jH8l5Kf5LyDAfkJqn+3kCsNRV
   GYAx+/p5M18eqopNkoCakzJgZ5O7lPt7xNd0lPBrYiNLPubHSki5BsXkO
   Q==;
X-CSE-ConnectionGUID: 3ZLGV4isTLWShCVsOBQdQQ==
X-CSE-MsgGUID: rHg/Oii3Rm6+VFvGcAxEMA==
X-IronPort-AV: E=Sophos;i="6.17,309,1747692000"; 
   d="scan'208";a="45868597"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 Aug 2025 16:08:20 +0200
X-CheckPoint: {68A879D3-25-299FBAB0-EF52EDE7}
X-MAIL-CPID: EC49AC01D376B20CFDD65F635FA6CFBE_5
X-Control-Analysis: str=0001.0A002118.68A87981.0009,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0B011610C9;
	Fri, 22 Aug 2025 16:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1755871695; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=tS+nBEv9oHEaSNtYsqRT1ZFZCy7e2jnR6M1qWnJYb6E=;
	b=RGs6IhMOEYWJprTa7nM2CmRinCHM8JGAerJJi5tEldNMyxDk1NoBYf64N3YsibLSabJkyM
	24DYKjSJYpfVO0dX3jXkyZfeRiaX++Oy6jkvhhbvp1G4v31x0ICl0CJKJRPexp+JTv7+IR
	Y6TGZ3rWmGGbSphthP7cRNx/tpU7IG4FGzcxEEG+OosqHJWbkr09FVE3qxksXPsHBGkn7c
	XYTykrFUnArphmBsycFunw6tg0mp/kpZWy5ASFPaLlCOlw8lfuwVceVIEaONWUO5LLuxIu
	1YaBRGo+o+aCAbKubEzZmP+RrmE0MrBudW/vlqSwVHtFtDPVFPfbgRe+h5zMkg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: tqma8mpql-mba8mpxl: Add MicIn routing
Date: Fri, 22 Aug 2025 16:07:41 +0200
Message-ID: <20250822140742.3352401-1-alexander.stein@ew.tq-group.com>
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
 .../arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
index 2d4eaf9c02b88..1924d51bcbcd8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
@@ -245,6 +245,13 @@ sound {
 		audio-asrc = <&easrc>;
 		audio-cpu = <&sai3>;
 		audio-codec = <&tlv320aic3x04>;
+		audio-routing =
+			"IN3_L", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"IN1_L", "Line In Jack",
+			"IN1_R", "Line In Jack",
+			"Line Out Jack", "LOL",
+			"Line Out Jack", "LOR";
 	};
 
 	sound-xcvr {
-- 
2.43.0


