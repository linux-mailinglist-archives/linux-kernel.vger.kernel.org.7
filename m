Return-Path: <linux-kernel+bounces-876303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB01C1B4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15ADB5A1B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF535772B;
	Wed, 29 Oct 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgLu4PU5"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A143570BF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746182; cv=none; b=McKWdPwyzBCE25lQS4IieMP/PlX+EdPaqbGnHpTQLDllmMVPZBC8PEz6wQPobLrXHIlKXcicEzzBZ/0uYt2DTGEBFMGbUHomNur5wKHbnIo/x3WQ9mNOBKHjBZ0xTe2YxIA/vnRmPw+1cNPijJ+YvDrti2LeRx+yWTNpNkSzKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746182; c=relaxed/simple;
	bh=1SwFiJpxAb50wR90lDV9GpdBP4ZnluzVr2Oqr/5Sic0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rp4EPuvUIwY055SK1grF3erxLqm7IQC6fJrg68Jrl2bHUwN8ixkq8zRxPihL3pintxGpLuCOSZoZUY877FdxxM3QbfrKsYxDYjPtR3YFS3ynWLuVY9Zr6PGyBb1SH/eIskBffK+3C0E3+2IKK7GD1CFffMTh4zNN+t5jp7whcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgLu4PU5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d5e04e0d3so449994466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746178; x=1762350978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0cpIgxLTVdTLX0iNNMuhpQhnr9g2pYoxLx5ardGUNs=;
        b=hgLu4PU5YBghE+Bva5VnUOvc5VBOgH+VZGzwdK0exUJACfOFNEArxwR9T7Nj7JAr9e
         BdCNvEyOJ2EEqj27dz1vS1ONW91GtVrbRlKBuXvAKG3M04vh8Bte5+3d837FsrTc9hVf
         sZc1fLDVwucMViW6r+YeUw5JuoPTBAaOrZPXH9ZItn9qfBLrl2FcfZiLrvKDUZC7/cX3
         UiCMnMFEWZJLn6kC8ufkhyQqZ7w5zMq/HICTesCGYWD+ZeUywDvL5hWk1JgScbVm1moE
         ynbuytIcHNVKeAP7LVLBeqRxALjNrG5GC+HLO0p5t8IGHb8riLIjrtBL+3Hw6hfAyxvR
         feyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746178; x=1762350978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0cpIgxLTVdTLX0iNNMuhpQhnr9g2pYoxLx5ardGUNs=;
        b=NJrBPR+AhbSyUqiZO91sEse5CLaPePfGelo7tdBUpgJ1oT9n+mnunE2YgzgZdP7sys
         TdISSGlYGGh6KbzeOUMaKpPOoO+ZMWiwYlpv7Lv2gKoeLVbHImrTAmECWk3WNzhsMvNK
         FDbOfOOWbOMThEqLfsgQm3wsAahKXJqB1CvIht8WtwYYINiQxyzjNelZDFytDKf90dhN
         vxotOsYFKb0ZsQLtzCVoJAROfvqF54XbECsaKV/bPpBYxpMno64wOqsqPWxecs0S8gwj
         6SqAgfo2rZY7SFJDdzLch44qIKVhmzIO/+GBUfYTpVt662P79xsJKbkPJQ9sYShOO1Uo
         nvHA==
X-Forwarded-Encrypted: i=1; AJvYcCX9y9Z2pe0IY/iSVAYDoNuaZrpVPI1X+kKNn+9vrB045LLog4HLsmX8ISZroO3y5zfcXEREw8svVMeaLPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypaqZKoYMfU219yTKKSfs5wjpx0OAiTOYHti+/3NmJtymYVnGm
	VYmPjJh7P7v/nZ9ZU+oOtmJ2WUAiMXMnQujYv+3r+NMtMXEMzJy96gXR
X-Gm-Gg: ASbGnct/gexZ1yD5Mtvqjujeq9cEBZIxgCbG5MMhHhCtswibXroYfeV5ZxZTupEfBFa
	RvchIktPtm6g/mK+QUd0Zn5c3dZLBJQVaIUKTrKtV/JXnJucwXpYHbTQfoq/1M0FeRxBPezJ4MI
	pRHhf2o8k/RY8ZbjPyN7eNV+DJPK9m+vzS4lGGt60oSU7g1I2N7muNinLWFu+/4w0V4VH91I6i3
	a87vhBMZJjgQC0HzcGk72FIDkyPKCz0FJoIq6NcFEIyC8xqNaR8xBErCGipjK0aW+CSyzUZnroc
	NLMXrIVDRJwCF4bqp8HLIkO94Qqjq+xiC4erY3etRmoOFqGlD1n9RCCIDP/GfREXtM8Gt6ebssc
	h7lJ5dCKf4pMheWN/SN8KL8GSzwHMRkaNaD+moaYwFc1t0Eo1hddZf09Y12bYDvRw7bB4aAN25o
	mHCaf+61tvx3eDkA0MxiSam3jcgQ==
X-Google-Smtp-Source: AGHT+IHh8OQ9HuceV0x8UwkKlSqVAt2/vQfWGgDAkzGZJb3jVpWZ2ATrrXxIPTpiHa8TEAAPPuvBtg==
X-Received: by 2002:a17:907:ea8:b0:b6d:55ce:fd29 with SMTP id a640c23a62f3a-b703d4d6347mr263106466b.34.1761746178397;
        Wed, 29 Oct 2025 06:56:18 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8534d99dsm1444960766b.21.2025.10.29.06.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:56:18 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 8/8] arm64: dts: imx8ulp: add sim lpav node
Date: Wed, 29 Oct 2025 06:52:29 -0700
Message-ID: <20251029135229.890-9-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add DT node for the SIM LPAV module.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 13b01f3aa2a4..9b5d98766512 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -776,6 +776,23 @@ edma2: dma-controller@2d800000 {
 						"ch28", "ch29", "ch30", "ch31";
 			};
 
+			sim_lpav: clock-controller@2da50000 {
+				compatible = "fsl,imx8ulp-sim-lpav";
+				reg = <0x2da50000 0x10000>;
+				clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
+					 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
+					 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
+				clock-names = "bus", "core", "plat";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+
+				sim_lpav_mux: mux-controller {
+					compatible = "reg-mux";
+					#mux-control-cells = <1>;
+					mux-reg-masks = <0x8 0x00000200>;
+				};
+			};
+
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-- 
2.43.0


