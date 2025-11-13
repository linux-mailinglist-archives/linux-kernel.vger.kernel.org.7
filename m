Return-Path: <linux-kernel+bounces-899183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03733C5704E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D606C356A09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1869D33509B;
	Thu, 13 Nov 2025 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZwVjQ6uX"
Received: from mx-relay98-hz2.antispameurope.com (mx-relay98-hz2.antispameurope.com [94.100.136.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42339332EDE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.198
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031006; cv=pass; b=mtrB7n4xMjxu3Qoh6OSd90OiIMApkiEUHlcOW+EYaQnLyfVzl+kdN+1WEhxnKFjUmwLkHnrTHuJhpJfIu8gKxLyTdMXeMUWQAwU2XBC7+AeMIDQomEDa9UtPMk7JV9XEBDMJdNOF3I14fg4L3t192StWAdwLlpexhPf6gP1A+NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031006; c=relaxed/simple;
	bh=HLL0IAJP64dP85RN0m4fxffw6mQ9TrEM/iZVC1SJfQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVylgv8TrJCQhMIrqkxaS/ESmSjUgTiHwwv6ZfKB7bmARkX8Fatm1G+4D6sm52lyStRGOUS708oIdcIt23ymNdYRE2WKKjm3ZSyUtY4hlyG/dz1p4HMuiMyOgnP6JooF9iyGjmiAame2AF3m8lLXtvejmBuZq4nDqBQ+zhWTQHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZwVjQ6uX; arc=pass smtp.client-ip=94.100.136.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate98-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=20x6bk/6ulOfgyNrjZnFw6yDdlvk5X5c9JtUmQUUw5I=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763030960;
 b=jdPapjkQpE/LMNttgQTbc3xq/YhmbKBU0sf3o94WOkfI75KhRHnIjHCLFl6U+7/c8ovWzydf
 ofm+MUtELdzv8hdERKEdKHoBfQFkr9Eu9sF9f6FZqXhEp+VeS/nTCKre9A7wO94aGhacpAxo5Jb
 bzk73GSSN+4pHv7daIPYblo1PtHVg0yGXrUGCNXVeOW5dDB0nICiNtAS62xCxdv153KqC/8oFx8
 mEebBjl/zyophnaoqoEpZxtif3GOUQdjn6MNFV6XZrQW9E00eQi3zwO/YXcN+v9gJIkKzLBFzG6
 /67MSpcdoQV+tYar/1UJ1VyCTPn7rn0Jl1alBmbBr8c8w==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763030960;
 b=S3tESirUv6loRAHUZG2DEhQhBEg3L2/OhBOJMY7aNdBJlOY45h5BvLvSxdrrYKqUJa+fRoIQ
 wAmaUrs/FKpFtBNwIooI9cjna6d8VGdKMVv/EGy+kiwEJOdUviCU8vZkhtXxzUCL2X4qai4HjDs
 ZCVx5q4jcH2FSlmKegq2jYQ7YEPV0VdHWPKaFheUv1s1NNYsnQ6uMjTl++Fx5a86G5+R+r3fOiF
 RAGGta6rAiC8YEbKZc0t/5VWlhvEclcuZuB2nphGSYJJCx7E4V1oSPTySZGhSsSUjjzoXBW5V6G
 IUjpMgCz1dwdCEBFa4adZZeAIp1QroeIRT7y8y1olcaMQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay98-hz2.antispameurope.com;
 Thu, 13 Nov 2025 11:49:20 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 3838D5A0ED4;
	Thu, 13 Nov 2025 11:49:04 +0100 (CET)
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
Subject: [PATCH 1/3] arm64: dts: mba8mx: Add MicIn routing
Date: Thu, 13 Nov 2025 11:48:54 +0100
Message-ID: <20251113104859.1354420-1-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay98-hz2.antispameurope.com with 4d6cTD74cSzJT7J
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:572a54ff1f0833590d00b461732b97c6
X-cloud-security:scantime:2.040
DKIM-Signature: a=rsa-sha256;
 bh=20x6bk/6ulOfgyNrjZnFw6yDdlvk5X5c9JtUmQUUw5I=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763030960; v=1;
 b=ZwVjQ6uXar+vs0VIfATmbF11XaSSYTj7tae/Ezn4mZH12pO3nAIBNR5qQZgOcGs7OYM8sZ1v
 HwINe5UkEbpPXy77ZUvmfO7SIjX39pxNMHeY0Bqeux72lr1gmL0F9Q0GuGRn+vo2D82S0zwvHjb
 kIFpOfMRtkw8jHOsmGnKm4nWA9FBNiq6Sev2IioPJVOIww2BxqbGas0Oh/4bKNxWC7JlyVRCm9k
 XOSj43MvcgOk7J0Qb+zjhxsc58PK0xbAOlv8YEZO3pablrp0msOjnH51uOrUacpNsWQoeI1x7Y5
 YywTXBngaAbH9YDyxlk1OPiNLI2JSnhvZnHzdJw3hxgjg==

MicIn is connected to IN3_L. Add routing including the Mic Bias.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/mba8mx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index 79daba930ad64..225cd2f1220bf 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -141,6 +141,13 @@ sound: sound {
 		model = "tqm-tlv320aic32";
 		ssi-controller = <&sai3>;
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


