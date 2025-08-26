Return-Path: <linux-kernel+bounces-787036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7CB370A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B5E7AFC82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B482D191C;
	Tue, 26 Aug 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JInviKDf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47136C087
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226302; cv=none; b=Xp9XucKYWk43Wfz1Zwqsf5PHY4BlmQiNkHVMss0Hxt3Yxg+3I03YiipEILpIRy5EfJKTjVBAmDkEXnfTwYUCuI8ytv4IChOxjLcGVwGZPdYG6SQqKmUDsxQdrc+MMEvO+CEIjY28TUpu+d6Ucigca60Gf/2lz4LqxPQzRvpGmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226302; c=relaxed/simple;
	bh=809NI1CN0NNuV9uuoAaLx43aJ5mdVRKJJ2h/czEopkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQeMA70u8MuNfeueVrzWRVmhy/+zw2jqrzGtUS4eMVMVh0Yo3fdhsGeT3cGp8EPPuvEwujScD/T8qUV4ug3BlGdvRCSBFbrp1vfAJyFYDjswM/TWVj7tUVEbVG/LYpzE39e504s1jc3YvKK88/6qR2uvRaNZ5HYhZ3WcrsDSBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JInviKDf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b6b5ccad6so595255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756226299; x=1756831099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gd5/9IeQ4uKOEKZif/xbCKEyzAUuhNyeB7aYV5jW8jw=;
        b=JInviKDfwUhUh2NhWaStd6vyiYori4QfVywMHWF127KH1kP7fUqV96wrDNFMTDtnmL
         eV+XsXbYTsr27jbmBZnrY32HIa2gFluVvfZJiLjWt/xkpMELW/M0rErp55H1PDlGYgHl
         O+vdOWgKgRfywe9N26nMTznAGHmUEcKuCnWjNdpWz6couBISl4zJ+GAQVxplWuHq4xtw
         v667X1Bm7Nf7PqbfR4CK84Ot/fYvAnZqkSkCQx3WZVr1Ob/yWQUFfqzSfsfJOM6QbWyV
         kXb2jxpctmIH3IcmG1qLLubdVyQIKpZu+90Y+a2g2T9Gq10yfWulfAY7ka1B/LGii7iQ
         zyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226299; x=1756831099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd5/9IeQ4uKOEKZif/xbCKEyzAUuhNyeB7aYV5jW8jw=;
        b=ZKwdp1hKwnO9o3vLhYPHOwRmOlEDg2ZGDrG+uB5wp2Fl95PIE55T2z/LkQp1CxE1aC
         3zuI7v2KsBdqnDonANjfYRS5wA97+HEg9rRZQWIo+GIaEL9sIaHs8aRb3gP4NUgA7gx0
         lhEDnLzbAIdgOR436gRqOxbL7C7xm8FTAQqvGtr+H2zBOVmhadCaLkuWt8W1feJVD+lP
         mETEOMh90xKRwsETyqGhQmzn9fq2OSerE9IBbHaK01x0rIt8EBi50tFqu1SZttexFAn3
         zF+YIJCjv3KJ8UlwzZafdee7NJjtPmZPLb//nnqLXIjmk4/eCCAGq9iU7MwPhoM8nP9I
         qxVw==
X-Forwarded-Encrypted: i=1; AJvYcCXC/8Fy7LDfFHrm/1BbrmqHZuKlo0U9cNDH2qXtm2BBh75Qs//ihRgCrQKCCgV8BBW25QrdVm/4/nsp8xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEUe2sto+o4h1hutETxr++Or2Vl748rCFZNlHvTbvZUdojfgrT
	z4zV2XnfHleRfPcfotrl13NMnurDTwZymuJd9ireA/AEt/pdtbG4mwxBOohrdhv94GQ=
X-Gm-Gg: ASbGncvKJ7HkJo/WmRRvDrvVOqkpNNSUfjtbhqXd/OQGu963lDrTG0jNCPOAHMpTd2A
	6Oyjzbnvl7rVpUzqcauW5SPiUQCxwgkVS6WEsQfy6pSnWCnL1vF2qDBFUjVC9fpDMAt4PJNOTnI
	6TeqdVIO36LTHsdBaLBNrFoCdnY/N3xoNa5W09UQmez9R5pnanbnwyNbAHrUuMkeFHvIIyn5EvC
	sM21PzMb0kOkeVy5uw1rMZV66w5Tli9xlvvjJ0wb4vuRHZFG7HGhhSvHgKcdra+8lYz7SPpiMDn
	BX96sRXAtK1CcFEnYuswLIhQa8sCbbjNPHlDHI/StN7lFpqdtLGpGkTPhO4EQAMqbUHpj6rpQa0
	cOv5EP6iaAW4TbkQGeqoBSOGFXoM=
X-Google-Smtp-Source: AGHT+IEfMOhKNGsk41+Pcjyd5bE18lIO9+Ehqp0eXFZ34jr9cFr/SUU8ndr/Fb7qeTETY3P4lllXjQ==
X-Received: by 2002:a05:600c:1c13:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-45b6baf1aadmr1321925e9.0.1756226298932;
        Tue, 26 Aug 2025 09:38:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6c53e210sm34705e9.20.2025.08.26.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:38:18 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:38:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org
Subject: [PATCH V2 3/3] arm64: dts: s32g: Add device tree information for the
 OCOTP driver
Message-ID: <ebb194fc26ee6aa7816f07ea891469ecb780d106.1756219848.git.dan.carpenter@linaro.org>
References: <cover.1756219848.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756219848.git.dan.carpenter@linaro.org>

Add the device tree information for the S32G On Chip One-Time
Programmable Controller (OCOTP) chip.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: change "ocotp: ocotp@400a4000 {" to "ocotp: nvmem@400a4000 {"

 arch/arm64/boot/dts/freescale/s32g2.dtsi | 7 +++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 6a7cc7b33754..e8cfddabfc24 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -701,5 +701,12 @@ gic: interrupt-controller@50800000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 		};
+
+		ocotp: nvmem@400a4000 {
+			compatible = "nxp,s32g2-ocotp";
+			reg = <0x400a4000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 61ee08f0cfdc..8fe1fa35e9ac 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -765,6 +765,13 @@ gic: interrupt-controller@50800000 {
 			      <0x50420000 0x2000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ocotp: nvmem@400a4000 {
+			compatible = "nxp,s32g3-ocotp", "nxp,s32g2-ocotp";
+			reg = <0x400a4000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.47.2


