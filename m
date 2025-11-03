Return-Path: <linux-kernel+bounces-882319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC93C2A2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 791A04E8C26
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED790295516;
	Mon,  3 Nov 2025 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpRKMnas"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46821578D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151234; cv=none; b=CVOAX+qJ98re/D0/YwlTOzG880snmHJjH23uc1Pn7/XeqCHl3NuFbIJ9uFj0M9BzK0UMmFLqVCgL76HuZITSAMbdn6F2ebBeuaKpufNH3Rf4FnHbrJmPrrgYGPmyr23szMJMafcACNh8S4vqc2B3GNO6PMY+y3upQQfXKEQ3T1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151234; c=relaxed/simple;
	bh=0rL5TGBY7q8nvzECU6bSXlUF+B8hh6WFBDcQ55vZL94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nciyv8rnnSau/L1OnqkunA+rsU3/zY4mDJpCa7L5ad9OCFMEZCitlSlU6ReX2PzmVBWrL4OUc0oRywm8Iqoz4Nu6ac7nyU5ku4vhTizRXLTxzrtV54Zqrg7bMmAw+G58Jhrq3HBbOg12sP7a58JzsHtsh4bgFG8kdgvQuS/HBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpRKMnas; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so3665970a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151232; x=1762756032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGKLj9IuGGzKXJR4eozTFqH7zWJUpUm6z/EiTyDGmsU=;
        b=KpRKMnas6jIAuyHC6odBnJM9Z+950EXimE4fz0tHvQ3Q/ic3XXf4gSgs6xwTjtmjgB
         Yrp/RCZjLJGkqZb+/E9uTJIa/H98YWEVmYVvT9J2i44hvEKnHras6BSwhLo2dzcw2JL2
         MH4bG54zWpEIoLZZVj3ZuHtqcv05Znr/P0yRfK2LhaGrXMeeNWOJ4GbGh4mouIKW8Jz1
         Htig0HLHLeXM8xtxmee0eG4ESrh4J9WdD7bS5fTMTbEseJTKLPF2OUSYtYi/PXZSsief
         3QvjffRSg92ZodtGCEkvilbxQKyA+XL9D7OK8XcKJWGJm7cvToqgBQtLrA570cY3HGxI
         dZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151232; x=1762756032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGKLj9IuGGzKXJR4eozTFqH7zWJUpUm6z/EiTyDGmsU=;
        b=hVfZkGbLVFxuGiuegcyBXrcL6DwPT/84leMmkq2BLAHL5eP4rslXgD3xcgLK9NGihw
         miwfFOWIb6B1Ggi24p+N28SzB+CDc8YpNuaPk/JxgL2mpyQpfIwIgQgHhNp7Fjk9ndYy
         8mbqG8YwLvSbHwlsE17QNqhYyCGkNxmRNGtOHm5XA3MmtAR6v0lEep0Kvr29Tw6opxWh
         d25+1E7kZ4hFwXWaa4sX2W/sq0EfQwfnC3JrYkgv0rf8u5CyAzQf1gKrZMp83ywQpZRi
         NCCBX8gCw1JWccgA/CX5V0jqWq1kbpfQBUiiAgQHnktflodqObuLD+LMi0LyEt6jdXOo
         EZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCXOLr2e6CGX4WgngFQdlC5UVMsY5UQedn1BbSDjPYhvIDuo+QEQ8sxAbS2c9BS4kxwlXG+F7TToC5SCNno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbL9rL/jFHrFpmrNoLTNqz+nJClHlA7yTQTLENJxNyflCGn6C
	wQjbg9ZjNgE6BwWPguDEX97PbINf1j0defKSpmeARYPMCqSYBfm5D4mz
X-Gm-Gg: ASbGnctiFpC1JnMZwPiV09R1u9t7SIMrejEZN7rOB49gdHFKpNLzo5pinS6ykZoPNO4
	XnZMmqmSEOhgn6rikjGkoqCVN3Ks3Ei2ja11rU19e2x9KfH/gWuy5jY84dZMKsiqlFN1/XHibIh
	NSQcR0pZiRKmxZJWicnX/2nbWbL6LWnUt/ysPhD9UgJWCAwgULlRNlHCtQ3haF5iLBNfSaKak4O
	T+RG+mUuhgZlArbZBaAmrGageruOPzHoM0pddzHlPWjrr+mEjXcOxQLC43RT9XFthWUy8lvSZJF
	9gqN3IVKOf+CRDuSF7XtToUtjJNcf1Ni72LFZW/fhpDyxaKHFwF88M0c+wdOmwMceNKHZTX3eLG
	BWSMCE/at+pcfQJr6w9NiVlADRVCpOCMDVjebK8H4ZK0rPEO8VR5WhotEgbj/Gice91bxF2xgJw
	==
X-Google-Smtp-Source: AGHT+IEEHJ5cKAo4s66Rvzv1t4feR0vnrItpNEwvY8alRc3/7dD6RTg/7i7hmvK6LD5XGWQ6H0YDoA==
X-Received: by 2002:a17:902:ce8c:b0:295:9d7f:9294 with SMTP id d9443c01a7336-2959d7f9455mr43290485ad.21.1762151232219;
        Sun, 02 Nov 2025 22:27:12 -0800 (PST)
Received: from geday ([2804:7f2:800b:fff9::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ef4c592sm4512294a91.1.2025.11.02.22.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:27:11 -0800 (PST)
Date: Mon, 3 Nov 2025 03:27:05 -0300
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
Subject: [RFC PATCH 1/2] arm64: dts: rockchip: drop PCIe 3v3 always-on/boot-on
Message-ID: <1c1cb7f94cf41142c55561ce8f2a2579021d4818.1762150971.git.geraldogabriel@gmail.com>
References: <cover.1762150971.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762150971.git.geraldogabriel@gmail.com>

Example commit of needed dropping of regulator always-on/boot-on
declarations to make sure quirky devices known to not be working on
RK3399 are able to enumerate on the PCI bus.

One example only, tested on my ROCK PI N10 board, to avoid patch-bomb

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index aa70776e898a..ad99a8558bf0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -25,8 +25,6 @@ vcc3v3_pcie: regulator-vcc-pcie {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pcie_pwr>;
 		regulator-name = "vcc3v3_pcie";
-		regulator-always-on;
-		regulator-boot-on;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-- 
2.49.0


