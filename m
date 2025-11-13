Return-Path: <linux-kernel+bounces-899182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A64C57075
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB3F3AE8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A61A2E093B;
	Thu, 13 Nov 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cQcZt6a5"
Received: from mx-relay47-hz3.antispameurope.com (mx-relay47-hz3.antispameurope.com [94.100.134.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC72D5C6C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.236
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031005; cv=pass; b=fzPtaQdJXRk5S7wWqe/4eZ+M0NFErUo951IyZRGpvv2Kvd/U8Op+1GxVBeEUE6pbxHAqTGxjwajNxLi/a4516OgRKJjWa5I/tTkzAssWdUKydKfpZlN1+s16Xp3KJkOxe+UHLRMDQXjrM2fNFmnW3a+or256Tx5PsM3qXEzjY38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031005; c=relaxed/simple;
	bh=mXl6UpWBiKHfYNnaiMBr2mKsHAe4lVsCCB+hpvDbOyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQLPC/zi3F7PR9JdF6hNFsFKkBysw7eJLeAZhfkqmlU390sNZnxKC+6ku/D3vbpUr9zQTKaAHrgEXcZM+TbA7J6828xyu0eJXxW0Gv8LulAIL2+HWE47FQsqKenbZyAvQqdnJbeTxWfMePOSQyJApkUO3ILdY21+4DW+QNiLcWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cQcZt6a5; arc=pass smtp.client-ip=94.100.134.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate47-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=e0hk/9oKjZpX3yolBpPlN0u54kAbbIh38AdbzQ0+tRw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763030964;
 b=XwhV9qinCJfjgmqNafnCGxeB2cTSIY0GMnvfu16CnHEv9JVGXiwOHyqPQtxNcTwdYNr7VPjY
 d7UnLVuYARxSlDn2Byp2OUh1e/BWFTEMOAqHJcVntUcTOzP/4FNU8yO4LLvoHz2r/2yIPG56w73
 xRiwG2/JV3hnXFrLsjSGAbXsj2+ftJy3eYr/ip8DGWVoNcfe+5JxRvqxBpctGJdKnhFsdX48ThH
 ExLSP29r3lyCCLvg6iOEBITOx+qlUj8M7gGvKObEKR4cKffDSDa7sK+Ui/wgYvTpmWUGFpqoCSY
 asDM/8A6B3IKPJHt5rnmpsA7UeaxikWmmtBbJINaKmMSA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763030964;
 b=KgZU8XUsRBfuGkqkQH8PIsa3QnNd3S5it/l+gqLIZJXVchyorv8vRXFUaxr2oRl37Jhn+DwX
 Lrgo9MPt1F1/UassZ3a7JqJ0K6vMGEtQ6MxfLQdPpCuCCAq468f0tVXoNBV7PQ08TVkh9l2taXf
 38U+A6lHu9UW5IO6mf9I3/eiwYP2Pixnct5+ttbpXQ5ErwLKOjLBO6GO3chAy1AMfVngp5nz1J4
 Es3amrbKjW8HALUEQyNORC+3qa0dovGO1xKv7hM+RU1NBxqjfOiInpQ1UALMwOc4h1xRCUGbsgA
 2ON3M81qb4IpK1sRJeuTnxVppuVG1XKLUg7mRI54PMOEg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay47-hz3.antispameurope.com;
 Thu, 13 Nov 2025 11:49:24 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 7DEC75A0FB5;
	Thu, 13 Nov 2025 11:49:05 +0100 (CET)
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
Subject: [PATCH 2/3] arm64: dts: mba8xx: Add MicIn routing
Date: Thu, 13 Nov 2025 11:48:55 +0100
Message-ID: <20251113104859.1354420-2-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay47-hz3.antispameurope.com with 4d6cTG256Zz4MJ2w
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:38de7fd8ba10c26054d70621dd57a3ee
X-cloud-security:scantime:2.335
DKIM-Signature: a=rsa-sha256;
 bh=e0hk/9oKjZpX3yolBpPlN0u54kAbbIh38AdbzQ0+tRw=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763030963; v=1;
 b=cQcZt6a57LDQ4ChYHn0gppc9Z+ng5r9aTnZO7kmxfi9MINotWlvUS38HExr2jKBfruy1pxMl
 y5EE7klN+auspz5yUoB1/3L3PsBLiz68rxpV2/hcpUOvoZogvIZakSiC+urY7oY07ha+o3671gD
 Aqaji+bqe8WDhx0g0jg9woQ9MaSW/1hsXec0mtlm2KflRBeNUEcYwXcDXg6SDElL41riiT+9rCt
 3yjufhMSrBcu+m2rcdBLtR/tcFhDi2VbFoBpCIjYxBbb2fXzQFa8UrWe1qQdqaaV3thJmx2fKKQ
 XRkFDFuy7FCtBA3AndbaZrrs747EobMehKW7pw2yQtX+Q==

MicIn is connected to IN3_L. Add routing including the Mic Bias.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/mba8xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
index c4b5663949ade..f534dab44e8ed 100644
--- a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
@@ -128,6 +128,13 @@ sound {
 		model = "tqm-tlv320aic32";
 		audio-codec = <&tlv320aic3x04>;
 		ssi-controller = <&sai1>;
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


