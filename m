Return-Path: <linux-kernel+bounces-878364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4CC2065F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AB7B4EE0B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED5024A047;
	Thu, 30 Oct 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dat8dBk2"
Received: from mx-relay50-hz3.antispameurope.com (mx-relay50-hz3.antispameurope.com [94.100.134.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70628226CF0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.239
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832436; cv=pass; b=fCxx4w7/RRh9gdg+BpP/KG4Rn5UJAGjMH6/2kwwRF9B7aeTDkJOyiGbKOFSBbq3hYBuZ3ci9l0UCYCYDZ+B/KOc2qEF1I9ttjT26+QmRhYCLR1v50c0so5+hL4Qt186TN+Ka+Ctmtt0SYVZp7Nq5tNzIOtgxWfRJvEVWw1SF25I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832436; c=relaxed/simple;
	bh=a0hUOLlXKcl9dQnZySZ63Qhf3hUcavWQoWIZINB11V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAKWe60z7RDgWbAY2JmpuCxSuEW0bmhzCrYBeD5/bjv1I4ABoWnifVXCGPkIPJisKEjgwI6T3/O3ZzIcXdHTKDBQU9v3n4kGdCgYq0GRxETnXJHXzlsn4AKL1PEkrl1WaRTCMzpGwXU28IMtL+qXzMsZiLKDS2FJLyBsGelkAe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dat8dBk2; arc=pass smtp.client-ip=94.100.134.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate50-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=AnIuiwyqQKsNxaCMen44jTAA0px2zVCsntf2UHUmosQ=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761832427;
 b=s2nR/9wkxzV56uP9VzPU0TWlGkNsSE8/VqNZRj0lv7qjW3i46rEd6i66WHa9Z/U/fmCL5Agq
 WoN2bfBkZ28gaeLK46FYBkleJPR5lCP3Tt3osqDQFoW3DRL0tLRcPNcRLysAyGeYaK+Mh/iL9bM
 g8pTE5y9So707ir8sLIaZDEG4VEmFMRLWEyIpaPrrLyh1/yTErRQXNJewsDAAzRbWV9RwgZIvf0
 O5r4IIzmKVuy4tpJgtQKiwuuF8/VpVIc57bNIetkGjcQmnva72q68nLkRcq+n4gfAk7NyV0QDCa
 sO/Gj1j3aGXvQMfyMUYR1KrOZsjVAkSYy29tTFGxNwnQA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761832427;
 b=Y4SuQMmiujxtYKWDmDUN7M33a2Ndy9R8iyo2fX5ciGIk76D65bz9CL8rGLygdIZJpsc2QhGB
 z6pu3Q8VblkIr+tbJYqso68BAFvN4oFunVy+E3+ctAswctVIpYxwF5b5QNpYUk3xOpIyCMGdPUN
 nay4xUa5FHP7YX0WSSTyiHWYzJSFfy0XS13FnL1O/1JfbjWUc6vGtxxdsHUu8QpllxH3CIhwud+
 oA/+Q5YpS9TI3wFtHEJ8nrc2eFvurKiuOkhNx314S9FzQ74qQ2rSWUgctEp8+x1625UgiklLJgp
 ErdToHBJF2rMyM3gmnwH2U+jgucPkrV7s2gKeYqVcVd3A==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay50-hz3.antispameurope.com;
 Thu, 30 Oct 2025 14:53:47 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 95FA65A0A3E;
	Thu, 30 Oct 2025 14:53:16 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] arm64: dts: imx95-tqma9596sa-mb-smarc-2: Add MicIn routing
Date: Thu, 30 Oct 2025 14:52:58 +0100
Message-ID: <20251030135306.1421154-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
 <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay50-hz3.antispameurope.com with 4cy5DV2mnCz2nGl0
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:af15caf252ad1b03706cb5988fd6514c
X-cloud-security:scantime:1.978
DKIM-Signature: a=rsa-sha256;
 bh=AnIuiwyqQKsNxaCMen44jTAA0px2zVCsntf2UHUmosQ=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761832427; v=1;
 b=dat8dBk28D0aQE/dTQvCwiTs1H5d+4A4UScMQyr2tFSzf06K8MePPMxXgvqWNV+R2UeEkm5p
 o/vltyvg8rHAPsUA82SWD91Hbi1yjoA33H01HzrQ9WFEHYCaYM1tx6WrCCWmjxRjUrClfuOsbtL
 NqhjjmFFUHSbAli6isRTBSDhxvmGuAZTRuFobasg9dPiistHVgh/806Wdjey7aBv/PvaWgqsS1r
 9hdjPjT1HpUUdIFs0Rk+o1+rr0Cf8B3JObYgdDBAwLJgoFdI8a1foEEZifdY6UsJdJNLFydheDl
 z3lhDeoagGr5yT1QTmm4Ap1HgqcH3s9wTMcgiymCSEjWg==

MicIn is connected to IN3_L. Add routing including the Mic Bias.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
index 8caf0c68ba9fc..d1c3d55b14469 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
@@ -144,6 +144,13 @@ sound {
 		model = "tqm-tlv320aic32";
 		audio-codec = <&tlv320aic3x04>;
 		audio-cpu = <&sai3>;
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


