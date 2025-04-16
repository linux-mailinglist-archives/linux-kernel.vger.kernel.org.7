Return-Path: <linux-kernel+bounces-607449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EB5A9065E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 16:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43E9166371
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A191E9B06;
	Wed, 16 Apr 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="eBPNbebM"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC51B4140;
	Wed, 16 Apr 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813692; cv=none; b=cXzZnkaDsT5zVTtlKLk3c0QdLyQqJm+89YlVvV1fRcTMBvTft0PjKvtB1SrC89jCy8mtmBmvwRd49trWlVCg7MebwHnnBZM95cAWzCKnmiC5HYHr4MPfTF0ZJRSX5LnY62Jg37PaRQEF0pglNZCkakbJajAZtYQ84He2xgGhB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813692; c=relaxed/simple;
	bh=vQAH1jkfZEcBipxTdFXayRe3MocIsI8jltVupOf83GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMEVKnfhA1zu8+yTOUC7KZagTjZoe+83NAQJzlUrn7KKgp4kOW5TW2FavNroQJu2MnCGFbkhN9wNTc+gnoA/2JMvwkhNC2K4w04D8fDo4TxHVD67TyZ+uPrGmqUYEKkmcGsYjtXqEi86/pfXqbEKEIl4d905cz2NhyNdG6caKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=eBPNbebM; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DD5BC9757;
	Wed, 16 Apr 2025 16:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1744813688; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=VTVKYFoj1jaoNBJBsD0WujEyvI4IfuhmvFWnnCOeCTc=;
	b=eBPNbebM8LiTuWnpVtxwPDJRYk42p+WSiauqDuj5Y+Eif0imNfb+yaCX/5KjrtAxvHr5AY
	zk+qQLX7726CBHMNzF4NvQkWjnWW1v1wO/w8VwZKlXhtSn8bYPq4RLt9jrWsFtFvg4ebNE
	JcB2Wcxy+mul3bMUfyaVQfFH11axnp5Q4A/YtXgHcZrmHIxkVnbzQpl7azmHjlUFOxOked
	zV7hOaNTMKmscW2RBgnDSiTUTXAvFp9d0UEo17yzYiaDgJ8FKP4mYSAqO2koJbQ+bbBjGI
	XUpWXWsHJfZnCIOhD9nhfMnRuSW2doQuBn60slbdhb1gsZ2RD8PLXKQ1ZSMWmw==
From: Frieder Schrempf <frieder@fris.de>
To: Peng Fan <peng.fan@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Carlos Song <carlos.song@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [RFC PATCH 4/5] arm64: dts: imx93: Add node for OCOTP S400 NVMEM driver
Date: Wed, 16 Apr 2025 16:26:23 +0200
Message-ID: <20250416142715.1042363-5-frieder@fris.de>
In-Reply-To: <20250416142715.1042363-1-frieder@fris.de>
References: <20250416142715.1042363-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This adds a node for the OCOTP NVMEM driver that uses the
ELE S400 API to access the fuse registers.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 122519648d1b..12463cf6c214 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -228,6 +228,11 @@ hsm0: secure-enclave {
 		mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
 	};
 
+	ocotp-s400 {
+		compatible = "fsl,imx93-ocotp-s400";
+		secure-enclave = <&hsm0>;
+	};
+
 	mqs1: mqs1 {
 		compatible = "fsl,imx93-mqs";
 		gpr = <&aonmix_ns_gpr>;
-- 
2.49.0


