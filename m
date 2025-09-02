Return-Path: <linux-kernel+bounces-796023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A4B3FB05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3C71A8834D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0649F2EDD4B;
	Tue,  2 Sep 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBEbusgE"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54F2EDD48
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806484; cv=none; b=rIj65Ukn9K4ifcqE5VFIgigbH19xemYBySCnr7DFNc6xS2oturCRPn2ybt/UlBfFSkMYfYsxd8Nz6Lru/G7uGf+4WwBSYIrj6/uq5gwaKcmc7XbHjXtjeijEKWq1Q2+oyVW46yd8i9XTmIHGi4KfMtZlJtWzu+arXgWjVxonQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806484; c=relaxed/simple;
	bh=yuhYbpTjEHtc2K9Yfd0cA0AiG7uR95InZUdVYtUB94A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHrklZkgrO2APrpRifjtkJ0AFwbcIVGi0nWiyNRkeh7WM+fDScCsXrosMGIlHuqBt3CDATn/4icF8N4bBd24n+hU+NN7JnLzmcFfhZwZQR+n5BADgR4kRbGUAqwiUhpT9DHLMRfRp218fqBULWqWVGH0dnaBusgD+nhbLoJzh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eBEbusgE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so12653475e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756806481; x=1757411281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AE+C1WgV7UwNd3pLh9lQDj1/1l/Oj2ofxSGM6ePL1Q=;
        b=eBEbusgEODYp40Ykfx/W0Hga8NEE5Kc2ZHhnF6cWmjwjwD7XImHBZfz8pxF5jStp04
         oElJYGWD84+a2bNjtDbLE9s80C+M5N57Dq6dlOl0/IxCAyjgIEi+ELBuvuR2yI73NeH2
         JkYxc1Jar4W6qKgUxuN8CiKQEXgWadRnmH7BX/36MWGVT0JZtNwo+l+S/f1zY3TiPcNd
         gE+U3uAl2OHxLYxym7EX0fBSjhj3AXDZwF/QKsdAN4ivH/zqGqoofZPAbNfsaGOwaNUp
         tgc+QY0PcMvDkpmzv9/sl3iJo4YE3nisOvNmX5lXPRYYxAvZrotr9D9tRWyTe5XZX7xZ
         8MoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806481; x=1757411281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AE+C1WgV7UwNd3pLh9lQDj1/1l/Oj2ofxSGM6ePL1Q=;
        b=FDJzmBjz/8K083km1vLDEFm6eKfva7SV4IsqTUnbS3nL8EKU+m2oRdV+6BxWerhWsG
         /KIXgMFQIVSFxCP5ySzsW50P359JZIJ6/E5+EHYTfd7Tpnib28EbJe56d++61df5rjna
         umHVP0l/+xbZsCclr1hX83zTkqBBoC26Jpvj9EuF/jqKtNGCIf4KS+0r/4fjFAUOfJjy
         aaJreKfBbwOSYmgsOyQXmdTBZr7uye50xYQ8QFCG7DFowGxewRx7Kbd2oArRasm3Frg5
         G1cnBgiNpuxgD38sDE7yvYZHsIOKOko1E87RxyiRrhhDsYo91J4dN6luk2QXvSJTGhcO
         LByQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5VqtfPfsG6s4QvPmDnMmzB/QwsU4r7nIjMt8abYoX3VmioE3iye3rfyRWwK3YMn9XCZJdRCZOUQNYuCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlyi/LSAgBYTMiGeY+fHsCupckBUMWCFaEzu3tuG6BFLoZPkyC
	ND/Oq5qOKqri4bJ1FJRKZWaR7NllmwjAdd5YqH61cYuYpIoLjK4ctpNaUzIydxKOMuA=
X-Gm-Gg: ASbGncuHW1fOfQDkwEA1/n2w7D939nlWdcvxPekjXFhLjkxIi+bl0b98d3esQVl3ID/
	6+G68WDlWDny6Bc7qaT16ljHQOWLFoiVtZCPqmFbGZ8M5osZmzYkVFqKBvvrBSpCDAQBwZW2vaE
	F3IBDpB4kqz0UhUMbz8+FZXNck1Ma+b3cHh5ch7d8lvHfBoI6rZGh90JIYoRs5qwWDGhVqCjAqq
	nKhznsxJ25D8QiaAG2Se6mI9f8JPx6Dx4s9hnXpwfyRBLKjwSapJszg0UBKVRxrl10YlTERvXN3
	Rk7ngPBKV++SwE/zF1AqZj1Zueu29dPDcy/iOXgdqa+MchEJBTeCEbwTZEYmKMd7esfgs9mhEQw
	ULSjU+zuxeXn7ttkZEAtcMI7yKsw=
X-Google-Smtp-Source: AGHT+IHkum6MUnPnlTSyYdYK5PmduwrE+Bc7PlnDr2fgc28ulaODsmsfkztByA9uDZd9M5QRVY6Ofw==
X-Received: by 2002:a05:600c:3153:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-45b8557047amr89974305e9.18.1756806480844;
        Tue, 02 Sep 2025 02:48:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f0d32a2sm294964805e9.9.2025.09.02.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:48:00 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:47:57 +0300
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
Subject: [PATCH v3 3/3] arm64: dts: s32g: Add device tree information for the
 OCOTP driver
Message-ID: <7877e1958fa92df92b2b5229365c86493c620c8c.1756800543.git.dan.carpenter@linaro.org>
References: <cover.1756800543.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756800543.git.dan.carpenter@linaro.org>

Add the device tree information for the S32G On Chip One-Time
Programmable Controller (OCOTP) chip.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v3: Add the device tree entry in the correct location based on
    the 0x400a4000 address.
v2: change "ocotp: ocotp@400a4000 {" to "ocotp: nvmem@400a4000 {"
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 7 +++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 6a7cc7b33754..d6a9f61394d3 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -355,6 +355,13 @@ serdes_presence: serdes-presence@100 {
 			};
 		};
 
+		ocotp: nvmem@400a4000 {
+			compatible = "nxp,s32g2-ocotp";
+			reg = <0x400a4000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		edma0: dma-controller@40144000 {
 			compatible = "nxp,s32g2-edma";
 			reg = <0x40144000 0x24000>,
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 61ee08f0cfdc..f0e2a2907431 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -408,6 +408,13 @@ serdes_presence: serdes-presence@100 {
 			};
 		};
 
+		ocotp: nvmem@400a4000 {
+			compatible = "nxp,s32g3-ocotp", "nxp,s32g2-ocotp";
+			reg = <0x400a4000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		edma0: dma-controller@40144000 {
 			compatible = "nxp,s32g3-edma", "nxp,s32g2-edma";
 			reg = <0x40144000 0x24000>,
-- 
2.47.2


