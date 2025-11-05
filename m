Return-Path: <linux-kernel+bounces-885842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C077FC3405C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053DC428892
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B4628488F;
	Wed,  5 Nov 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4gylcHA"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63727FB21
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762322127; cv=none; b=Q7N3yX7NmSBerh88kQ34lqoVHJboqyB/p1tHQaWn2/IZZ9hg+fD7fO1ZI6EDNgSeyJlKpsygXhnjbXbImBtfvTDkCtUdYrZ/0v2udeY2uos5RWp+sWen5husIDVf6AbOICG+dXJt9BJO+jvtW0jZSnH7r0qjikgmpir732pyfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762322127; c=relaxed/simple;
	bh=e6KW0tVVBZqqo+yCeocl+kVIywhldeYMYDweLh5i3ag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oeL2ffTNhEUM1B9j/77soXoicZ4gmXGTiyyTQ1rodMhszCSF1EvK8Jo/NEOdEmGBWHZnlWUfN9JdUjvKqdBCEdZSsFP1TTLvwB0cIdimXHXbdbFP/pD5qz2U0pj8f1bnNQX1Ota81TTk2HJWtZMi7j4wxM1P00jdChEvVfFxhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4gylcHA; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c284d4867eso1768980a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 21:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762322124; x=1762926924; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fwi0DrEUoNTIOaZJZRTu2PMBRWvJKCPWH2oh77N1gps=;
        b=S4gylcHA/mBnaGO9HJN4RM31KWMQG58fQgvZtWX1t15DREJc0kWIAsuobkKk4ppsn7
         Lkm5s3tgWeYILeakLYup/6pFrQg7g92YuvOxI4CjIeJ7sRtgA9vyjzOL+95VQfzjnbhf
         4hrKH4ZZNh++CR9I3XLKTYbQGIgnMB4optKopJdlBfdVNC5zyB53ErcPA0eKB2ZalkKh
         jKpwe0JPfBqdpVlf+vPkRxjGcs3G0Fh1ndppHzN6KzgNN78gE6xTjc4P/tJ7Iv6DPOFH
         zQe/vfgfEqFQYbLLz37hZowLS0LxF0XzzvjkTty4ak7GmGRRzGs36mpBzSdJYlhoNg9H
         w8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762322124; x=1762926924;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwi0DrEUoNTIOaZJZRTu2PMBRWvJKCPWH2oh77N1gps=;
        b=GmIpV0PDtpL7uTow11Iabg0OAdkmxwPZTiyOCoZzX7k5nl0FL5pLI6Yqm3wiCzSJWh
         0Gd1dCWYtJ81ZOUMmndYmKvqTU6/NftieMgFaUU9uhnvg/9zcih2pKXXKPEq5m0ZpWZs
         B3vravVy3sjRfh7/m8TTTndxD1qeXp/Fxs2iwdkMWM7Lzp6J0d3nIQx1eNMIx7VeMSFH
         osDEdqDTmsx09kVALWUE3a+Yr9CJB75NLUQ+kD8ZhiRY74lWBJWv6EPRpLkMgPM7T7OE
         yAXmK56Z+NawNJ71RVntssMfox1POd0ebzuW/7VBmtT/PRnS40XRe+Q8+CvUk9hPiSFL
         mhGw==
X-Forwarded-Encrypted: i=1; AJvYcCVQAka8iZTUt+E7MGn/qr5lt36Sf4bhHjtnfpFJ6LJyn/jQd3WxfooK2a+6niNb+B1ZpPPATKaNxpq/7Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VFpQQG+Zk6+/PNI0UfSQSAMOzn2tDCL6SdDd3ZR9/Jbmt1/+
	LRMSptw9KUS5V6ciT+jTmVUvOWQ+Q5pob9wXn3xNFgT2fpQqRi+1E6Cr
X-Gm-Gg: ASbGncvtywrR4bG2BQ2Un9nOVt9sDgdZIxNqB1FNBTjxGZPtpAKkHQBO6iPej//GJxO
	DU8kO+RwgXBsC2HQmgClveR9xAUSmv/ljtC9W0gFFjlFsvOrUedMn1Vd0WLs1TbHqe4ZpcXzigh
	7eef/RBACzV2O5zALNVU6xIgH0gozwRNqDAqO+HIiDNMUD07OTkTIx2CN7/cMCmhiOmlhlPnso+
	qmdfegtFBrEfDLtZ3a5N4D7haqgCoiHU07zG5bBVrrxeCupChCQJF04WDhkVsAotje/Sf/pbrtk
	NJyXWs8Qwjb1pR/1JJFsqbCwhfVQ5tgQZWLsJpCAPJOrRW/PBBt7dnlKctMpGDW3U5vaiIJbfxi
	ekmBpkRwZnWBifsE5yy1KCnFFy/mlVdrzQ8VMo5VRXShjQMyvKqTOizAkGxTNm7I=
X-Google-Smtp-Source: AGHT+IFEVR0qbygzze5iBfiTi1hOIxTOUWBa+aFthKdgTb9tcWOqhz0feyJ/iBoBrEyZdPQs0msfOg==
X-Received: by 2002:a05:6830:63cb:b0:79e:69fa:6bcb with SMTP id 46e09a7af769-7c6d140f2e0mr1585902a34.13.1762322124566;
        Tue, 04 Nov 2025 21:55:24 -0800 (PST)
Received: from geday ([2804:7f2:800b:2cb7::dead:c001])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c2448c76sm1714476a34.2.2025.11.04.21.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 21:55:23 -0800 (PST)
Date: Wed, 5 Nov 2025 02:55:10 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The PERST# side-band signal is defined by PCIe spec as an open-drain
active-low signal that depends on a pull-up resistor to keep the
signal high when deasserted. Align bindings to the spec.

Note that the relevant driver hacks the active-low signal as
active-high and switches the normal polarity of PERST#
assertion/deassertion, 1 and 0 in that order, and instead uses
0 to signal low (assertion) and 1 to signal deassertion.

Incidentally, this change makes hardware that refused to work
with the Rockchip-IP PCIe core working for me, which was the
object of many fool's errands.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index aa70776e898a..8dcb03708145 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -383,9 +383,9 @@ &pcie_phy {
 };
 
 &pcie0 {
-	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	num-lanes = <4>;
-	pinctrl-0 = <&pcie_clkreqnb_cpm>;
+	pinctrl-0 = <&pcie_clkreqnb_cpm>, <&pcie_perst>;
 	pinctrl-names = "default";
 	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
 	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
@@ -408,6 +408,10 @@ pcie {
 		pcie_pwr: pcie-pwr {
 			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
+		pcie_perst: pcie-perst {
+			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
 	};
 
 	pmic {
-- 
2.49.0


