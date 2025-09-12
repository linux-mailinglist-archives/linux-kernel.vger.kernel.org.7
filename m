Return-Path: <linux-kernel+bounces-814339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3300FB5529B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DFA3A70A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA646212B0A;
	Fri, 12 Sep 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwLfVH7J"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B320E6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689411; cv=none; b=Ga/lJjgtIpOnAzvpJn0PE3OGwUYr5FSUfdk+LMJmO/VKtvljQKhpNUZjWq402g4QULbEg3Tz2D5ecGMyY+Gr8tQVi6Y5LBJqCBBsPTaGNuHW+HDleuGiyLTvDWq+HtBIPCMH0L7AqH5+9+eaII9DynFEYcYAdO1ikbPDUtyeRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689411; c=relaxed/simple;
	bh=/Ylbt4Hgov7SuNxJ3P9gKkIyD2OkbW71YkYFjNuHbKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxIzz3BRjytQzdOk3DLUgThHRQlyVtsyvui0tgrzIzpqjr/ucy7sSpkvG4eGgKnvuD34fAWxhj/wWqoZmNqHPEX8Z7PMWeOtHMMu59XFh65B2CJ4R8i7jfRLST5Yq35VBDMwUhMKivc5HwAj/BTCKL3A04yBi6u8k1bUNcShXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EwLfVH7J; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so19074085e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689406; x=1758294206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq1J637xCjsK3a1jRXJ0Uurp60mNSuIOaSzaWarRAoI=;
        b=EwLfVH7J+J8hr24JMcZA2kzQaCH/e7LLYopDBif5z/sb0XSRkgIdI56oiDxdAC+SQG
         Zl1zBf07JZeEdpsYezwczlXoWKeTK2mxWupVFkQTgPiALi21pXwI3nNgQynIqHVgxzoT
         6WNShO1iJ9uQ+9mjyFJxtVZ/ge/sEciuy7rDqUOKfDnBCNLJly4LOb11LUP+WdcccfSd
         WNSgJ+rTsYsdaxIQ2G3Jk2j3ymaILOW3FZA2Qq89Ff0VlKdT1VG2FCmqiLbUhKI5bxTn
         nrMAhO5+KNitiSkelgUMX0fMvE7QKTBUPeIdVZTcscWsvm6Tg6Ih0Ye0Rz/kTyEpkkuy
         r2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689406; x=1758294206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq1J637xCjsK3a1jRXJ0Uurp60mNSuIOaSzaWarRAoI=;
        b=ImyW+1jgiNwHGwlKc8JzpV60mhxl9qg3+uBzJLsKkJQkRVrSG7IeMZ2B5yW0VRY2bj
         /FGb8h03bnxXXTGjAxoaW4NcFjrAXzT19rOVpEHpA/vl79Vy28X2XjIyNNeTBSr0asA+
         NktsXpmzLSszgvysBVossM+NElb+3sJb3qNBB162mNrEulfkL20Blyds+HG0qGSoKuMJ
         Mtio+nVAp+WMhb4bkeCNlwNAk+mVqw4Ih9n3RUhyCvapYwdywElfmQvCFNtm05hjSf4e
         wbdgq7OYieAmZNJ9VqZYWYiu1DKAKLi4tRSi3xqP1fnkSu9ltLvRE8pBUW7kl5wO+8DK
         bdDw==
X-Forwarded-Encrypted: i=1; AJvYcCXZk8JrtW/nc4YcubGenammpKKcsE4nU5OLq1iGasVhQfRtC5h8N3iYeHr6eZ23bXI5IN65RspC9pj1UWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB01Q1f5IIcZyfnecmbxWj1tDqAD4rkdlXRhZR6pXzDFqOnlqw
	OInrlIhadoepffRsV0PXInxoCYCla+5G4UdMwiDgW9I9dmueSwIu8SzREJPVMM99jEs=
X-Gm-Gg: ASbGncuYSwMSQGj5vMOGmMGYDPr5eRRj0xF7RNnM+DnOZYj6WLz65/gAyLPiWDAm5fa
	njk0mTbg0qh4BHO8/5WJ2mYE1H+OzdPpuQ3cAnYO1y3gtOOTkwFd230HyrJTNkaVkQ6dntjwmKg
	a9PMB2qL5lPahgp4OUotLr/RdtALfmQ3yiJ48b0KnLVLS3UDOSZsWPP66uydebs7XXMbfbdseMb
	KAe7b+klAPJwAsRjMdzx7Czu/4+ZzVTCYkF2Uk1bN32c7QGAME8kCCLOCC+i+1mXSIfCrqF1Wsm
	rEV8LZUYem9j2uJ4mx2hosV1pvqN4lmxJgHUAU48IYrzrGFCkxkf7apsjEYbPAXSEfMXBr+ZYK4
	1sF3OmNjg5fUPwr9KqpHfPyDR1lc=
X-Google-Smtp-Source: AGHT+IGJXVmJrfU4VspkXVUL2QLcSNv5Pv+0FQFjRdVM0w+zljPzezrhfzIQOaENjXatzp2p/nhztQ==
X-Received: by 2002:a05:600c:3ba9:b0:45d:d9d1:80a3 with SMTP id 5b1f17b1804b1-45f21225cd7mr33416595e9.37.1757689406190;
        Fri, 12 Sep 2025 08:03:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e015784c3sm72663525e9.10.2025.09.12.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:03:25 -0700 (PDT)
Date: Fri, 12 Sep 2025 18:03:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm64: dts: s32g: Add device tree information for the
 OCOTP driver
Message-ID: <6ea7fede9642dad10a6270a07e052f7a726f9bd6.1757689031.git.dan.carpenter@linaro.org>
References: <cover.1757689031.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757689031.git.dan.carpenter@linaro.org>

Add the device tree information for the S32G On Chip One-Time
Programmable Controller (OCOTP) chip.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The other patches in this patch set were applied but this one needed to
be rebased.

v4: rebase on imx/dt64
v3: Add the device tree entry in the correct location based on
    the 0x400a4000 address.
v2: change "ocotp: ocotp@400a4000 {" to "ocotp: nvmem@400a4000 {"

 arch/arm64/boot/dts/freescale/s32g2.dtsi | 7 +++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 3ff3b2ff09be..d167624d1f0c 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -325,6 +325,13 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		ocotp: nvmem@400a4000 {
+			compatible = "nxp,s32g2-ocotp";
+			reg = <0x400a4000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		swt0: watchdog@40100000 {
 			compatible = "nxp,s32g2-swt";
 			reg = <0x40100000 0x1000>;
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 6292ae99883a..be3a582ebc1b 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -383,6 +383,13 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		ocotp: nvmem@400a4000 {
+			compatible = "nxp,s32g3-ocotp", "nxp,s32g2-ocotp";
+			reg = <0x400a4000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		swt0: watchdog@40100000 {
 			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
 			reg = <0x40100000 0x1000>;
-- 
2.51.0


