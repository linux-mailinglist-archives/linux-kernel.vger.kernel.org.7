Return-Path: <linux-kernel+bounces-899181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9201C5706F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC29C3B9F33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769E22E093B;
	Thu, 13 Nov 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VAsPvDUt"
Received: from mx-relay48-hz3.antispameurope.com (mx-relay48-hz3.antispameurope.com [94.100.134.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37C2D979C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030979; cv=pass; b=ga6mPpXrd1rHUrv8lUrPUUxTIFlBzKXyyFy+00kYtrdbviMo7+lybsPXdDn/+mU+6wSVBCRua1wl6Au34e+6sM24W45szJrkjxMMB66SK2EClT5mra4TQl11/dfrU72TuXpmVcLZPRDFVs89xZQJQhTYFtUAiAKUnLd5r4j6U4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030979; c=relaxed/simple;
	bh=J6BsqTCmOrFFiAQAx5pEd4B6YJ3Nlg5q4umEShFXHAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B08JDtF7OhSn9owVJoJMM/yQtfRjQRz+qts2RGKp9IwHuscSJGW25qofQWe+zpAWFY5rPMjrPIVHfF4Nu8MIi+R90aSH5A4EFgEsfKeNiS8e1UxKKdNZZSjavaUcYc0aGoxZdmmClamWC7H3Am6ai04IieNoLfFfr4agft0qSf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VAsPvDUt; arc=pass smtp.client-ip=94.100.134.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=HwZpnlL5PSUjD1ekyFYHL+mEFm8pXGu4Iwrph47h1b8=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763030963;
 b=sAWpkZUMXRswL3x3xJve3P+ax7TbAeZ6ggdElHzfT9EN2PmqpCnmLqMBE39h0IIYVylwLhax
 jVG/ADAjQVO4WX3oHuqKbV722ssOzsenJhMckFwNzdoyB85zTVLKo0U3tUQncgK9aRKskVJJdsT
 K2CoXXdLshAE+1Sqi7SSwGEIS9ifTgnyDfdHOvoTCgKl6jc1sqHbtU0nA9T/YZ5jyZpZwNtZYOQ
 QL9aUMiubZxyy6k9N3UMD3QDGnWQzeu5s3QSnFuX6Xpoh0FN87vyeEhu9YtYuAKSv9MrkisAcFh
 ngDPNTekSfxsjQsGYzCfQKsB63/p8zyGwRr76pSOkopfg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763030963;
 b=ghs8U2tHTvJDCseE+Y7WBBSrZnRhndevv78rpR6sx8JVuGV66BjG1yYZMipBVqc20kl+eiXb
 8LG1jSQimH62co0c/03IixY8YdicjoWl9IQeWWpMWLv1peJkiMxF6ouHVv3TgOFF0S5dOvPMGUH
 QOZT9ATrZPIEpDfp8zDmr7s6sChaL3lLEP7n705aYFGo2PrEhQDWqYB7HChLP53AWA8Ixw485xN
 WqEdxI0kPA3W43RNsNRh1GqlTpvbnM/txt5V9E3uz0GW3jYnMEpGbxZgQRLHzWNqwrZDqmPdeCY
 gndLJ5DKJTep1P1MsSn79+8n5E65DL2JyOE52+ibUl/bw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay48-hz3.antispameurope.com;
 Thu, 13 Nov 2025 11:49:23 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id C3B245A063D;
	Thu, 13 Nov 2025 11:49:06 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: mb-smarc-2: Add MicIn routing
Date: Thu, 13 Nov 2025 11:48:56 +0100
Message-ID: <20251113104859.1354420-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113104859.1354420-1-alexander.stein@ew.tq-group.com>
References: <20251113104859.1354420-1-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay48-hz3.antispameurope.com with 4d6cTH3cvgz1kPGJ0
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:ed014fac5779153bf3b07ca053158c71
X-cloud-security:scantime:1.897
DKIM-Signature: a=rsa-sha256;
 bh=HwZpnlL5PSUjD1ekyFYHL+mEFm8pXGu4Iwrph47h1b8=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763030962; v=1;
 b=VAsPvDUtJwDxOB66H5h7TEVrPamucgAhKjmRPbKF0XBl53hyyGPqSkTe7c1KIxtfzmXAlsjJ
 Yh8ichZ7gM8LDBdLKznXA/Kx19/2DOQmp+DuOazJqH7feBOqNiIdwGgzli0dYTgOpqKop39URCU
 NYSGH4e8oqjMnTBjYQLod+fVj/29cMJQA69Ra72Nl83tf6ZqsVtmqu3RtQ4jr6iHq9gqBP/NvXs
 FwQSdq9dbDVnOYyqF72EGJvYuftkrhDmcgPctMOGKUxeM8tTo//OVd0W5yYUSUHCdoitwum+oMK
 0CrrTIrIMAn49+qtCKw2WxDDItuFBhQRrZINyYhp7VnsQ==

MicIn is connected to IN3_L. Add routing including the Mic Bias.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/tqma8xxs-mb-smarc-2.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/tqma8xxs-mb-smarc-2.dtsi b/arch/arm64/boot/dts/freescale/tqma8xxs-mb-smarc-2.dtsi
index 478cc8ede05ef..3d20e3bf32ce7 100644
--- a/arch/arm64/boot/dts/freescale/tqma8xxs-mb-smarc-2.dtsi
+++ b/arch/arm64/boot/dts/freescale/tqma8xxs-mb-smarc-2.dtsi
@@ -98,6 +98,13 @@ sound {
 		model = "tqm-tlv320aic32";
 		ssi-controller = <&sai1>;
 		audio-codec = <&tlv320aic3x04>;
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


