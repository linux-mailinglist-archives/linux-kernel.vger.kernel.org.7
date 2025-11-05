Return-Path: <linux-kernel+bounces-887367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035A6C3808D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF3A462FCF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C92E7650;
	Wed,  5 Nov 2025 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9e+3DCJ"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA02E7623
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377736; cv=none; b=OiFak4sWmU/g4Uq3xC0swPvKcFgIC8ouIVKEMfyHQxnca7qplIEC5H+SCWrcq5Rfg6DmQO6FWvlyxhiRLKUFnBAjtTegTFYcQ3RPDSLd1oJNDOQpgw9uBZEQkzrUfBEWimUQUiF2RnJMH933qfgwv2NMSNb9/jVVkEk0fJbc+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377736; c=relaxed/simple;
	bh=Lafdol5XjqXTtVc0qIPRZEgOnZ0fzaAxiat2QX2gQzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXG2+mR8siGV8D4lN5n+v8s1ss83RlxGPsyLHORLChiXJ4NGuej6pCVZIt3LnzMRBpmVOqHqN6YQYQ7SQSYebw6JCTCbDi/0dOI1PLKtXb0xmh4RODT6y8Cn1Gf9ndJi3bwkj1wcea4K+Nvut5GjiGhGk5GFU3uKOjhZdCgQ4Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9e+3DCJ; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3c9991e6ad1so221642fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762377733; x=1762982533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/FBmebtO0Vkrgh/mrFAUBv/BWvq5VVY9yGcMnDDP8s=;
        b=E9e+3DCJ0j5sfxz499Vg7oEXRwgD6fQAAyNuumlwkbVIkJk6WLW4evKbElH+pG+Z9x
         OTsXGP1EVRQKemKgVfTCOla+zxG/thdtf1Rh1rqxRgMyqRlrew6tr2oOFHM+o3CDik5+
         rk+sc2XcwQ4YapCE7NC9ZcbR347xZHaSMijpxotGPvid3RZwgqvyx44djkMHOTP7TXA/
         YZNMiUBmxSwDvupSrRxnFGwSvrhj7bc1KUKah7ZIW+rEGLhaH1ZsaixodVu/3eNZOznA
         phq4xuWAbpzIH+Ac+HBvFubaj2BXYYAystNgPfYd8YU9muNWgzo3a5dGfx/ptDWM70o3
         Y8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377733; x=1762982533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/FBmebtO0Vkrgh/mrFAUBv/BWvq5VVY9yGcMnDDP8s=;
        b=FxmoeRe6Uc5v6fkvpM/CtpVHFK3a9uXrO0XrSJShEtzWd+fsEJ9OIhngFUQ+isPqqt
         zgYk7N89dW7TEevVJzPjO+P6MUYNgxJYM1v0ir3QoyLIgHrLal8SHX5X3vwzD5igb7Lp
         qCCaCVrUBtCwoGNJS3KqkoEzT6a59sS8V8fOjY8VVz1Z5EuVlpN2gGYa96zvPc7eSXb6
         YLjS8UjneDiHhsRLAb6uHwXaT5wRZU7rx10oqOJ7ORnA/8+7ujf0+5JmFvn0J5HXlXzl
         bns7zs01o/F0NU7TcXKBChi/DnVem5EiZoYsDezHckpynC2gCfEIhk8HXh3nrr+cQggn
         a8og==
X-Forwarded-Encrypted: i=1; AJvYcCURehj6YXB/Tqn5SUrxCvlIelVShJ/q5+gFvMuvCsQk3+u8UikfZYCVseTLEapPE5lmHUJn6GWy+vwNYeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BKPat9OeTWtxweOvfc6f6/B4C3tt9hjNN/JK4LneKYR+ihFs
	GsKT72lxL19ISIdomyalP+6JIFMdn9BN2WYcWCfaTikADBziLRSrhT8Y
X-Gm-Gg: ASbGncttX9SKEU++3kIF5NLFDwpF9gmbG5KOE535ZVYf1uTEGe6mhsWfoNHO/BQuF9O
	CNmPI1PiIYtlKTgC+MT/B3t/8DK+CkzHW2CkccLeXPyY0+BW1p+i31MOMF/wl764tRNsIxXl8iY
	zRzK2n2ZnE8Nzy1xbtgb5d7spYTJUOQGvwNYxY7FrHsLvxdwU5PgsTbv09MXGknVwdZqRY4XWSf
	D94dflPCZ30Wj0X3g4nVqmRSBnDxLnENKfGm5R1gIxLRdWnhnLYYgZn0E2x1GMqzOtvTZ+71tJw
	OdF0+C4XvUKrplxdqqSe7OPEMJLmVDRojVxo0OzCfJOB36eCmdxJMB+sAL8aETt/sii9VX0GngJ
	xMSebDz3L0/vaRMdRCF3R9++egFj3BqTNbpMuaZMAC51qUNnKYvchfBQ3htLjBsp30c19isBeqw
	PYJ+Z3tdCT
X-Google-Smtp-Source: AGHT+IH6bmLILBlZkClZJKGGVOQMJ8uDofSrhNGHs3xLSaav5plph/1k0YKtCJFMX/UFHGhYB7B7Sg==
X-Received: by 2002:a05:6870:1484:b0:3d2:e6a7:e938 with SMTP id 586e51a60fabf-3e2e3d8c98amr572130fac.15.1762377732693;
        Wed, 05 Nov 2025 13:22:12 -0800 (PST)
Received: from geday ([2804:7f2:800b:2ebb::dead:c001])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e30847fe83sm153392fac.6.2025.11.05.13.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:22:12 -0800 (PST)
Date: Wed, 5 Nov 2025 18:22:00 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: Re: [RFC PATCH 2/2] PCI: rockchip-host: drop wait on PERST# toggle
Message-ID: <aQu_-JDy7qqeviUm@geday>
References: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com>
 <20251103181038.GA1814635@bhelgaas>
 <aQrKtFT0ldc70gKj@geday>
 <DE0N4LA8MOJD.236O12UZ3I3C4@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE0N4LA8MOJD.236O12UZ3I3C4@cknow-tech.com>

On Wed, Nov 05, 2025 at 10:06:53AM +0100, Diederik de Haas wrote:
> I have a Samsung PM981 (without the 'a') and AFAICT it works fine.
> I had noticed that the PERST# (pinctrl) was missing, but 'ep-gpios'
> was/is new to me and I hadn't had time to research that properly yet.
> Good to see you already found it yourself :-)
> 
> Cheers,
>   Diederik

Hello Diederik,

Thanks for the heads up!

Would you mind testing the following DT change to make sure your PM981
continues to work fine?

Thank you,
Geraldo Nascimento

---

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index aa70776e898a..b3d19dce539f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -383,7 +383,7 @@ &pcie_phy {
 };
 
 &pcie0 {
-	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_SINGLE_ENDED)>;
 	num-lanes = <4>;
 	pinctrl-0 = <&pcie_clkreqnb_cpm>;
 	pinctrl-names = "default";

