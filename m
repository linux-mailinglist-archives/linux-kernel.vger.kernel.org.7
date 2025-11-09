Return-Path: <linux-kernel+bounces-892230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB44C44A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667FD3AE024
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A62A274B27;
	Sun,  9 Nov 2025 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUDTdBoT"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E2238166
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762732686; cv=none; b=VsxlKp0ufcZp0mRpWr+nH3oSd7ZPrH+ffkgl+E8DL7amGR7nhY0CB2aJrC0e/JrVIhjy6UM9qJtZ5NyElLUfiv2lTJoNq3XXeBp5JbX5XHMYICLKLojmA+4BCc68NnSVAfN4565Pfk4J4C3E7fx2GSiAfp3O81oAcqdXCzxodGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762732686; c=relaxed/simple;
	bh=VYPoW3UY0CELQy8XzPDSdrI2ABoXchU20b+SMwMONAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulGvMr5ok5nLFTiE0PHrOcjKE+7VEDgI0yNkh9zka2uihFD39h1SwyAHxiP7RHh8hrskIHu0M8MgQDpjhQw7KaifyjGrADi678pKkiI5TtL+W8vcOjPHvy6DHLzXsfFJPSFBlbFmt+jLq4jZ+Nb7/bw7s2ArvjYZqGatQZ7nOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUDTdBoT; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-932e6d498b2so1441881241.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762732682; x=1763337482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ciGXNa1z8OLW1upm7VDcuKg7m+mkewvk1om1QMnHPzA=;
        b=bUDTdBoTIr6XCmxW6aMvQNwbXKzjE13//r4WFAOJ5pFDX6E0imd5bvPzHrTasbosFr
         w85qy0bUoMy+MTme1RB2dgptUh2e8nPkyAYTzKPpgHEv1iS430jvoMu8xQQkUlvBq1dc
         TcN7o9O8EAc5Kss436g9N2WL3sl0q23GRaIlC+f+Aaqr9xPjGVVrL9lhAnX6OU1+RXdE
         Uzfu1+HlgaSXAW6ThN4BOuLrwYtzGgJamvnyPYsl1s0bdoihyaNG0Zfc58FJIcX78k17
         m95P0jv5s8GrMiyqDTs+yRV4UL6VY9JaME+788PVIgBW4aJS9eCKL0kRqcKWu4652rNJ
         8FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762732682; x=1763337482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciGXNa1z8OLW1upm7VDcuKg7m+mkewvk1om1QMnHPzA=;
        b=BmFbP4AjXYe1gcAuu+CabM5kbAN2s2kruBguNKq3q7YuKtXQlcUIJwTHSkLRkWlmq+
         yqDY5HewTXCXos4Mlyxm3rKtCStQnlxhMeywevMUfyvV6tNvdOREH9qZpOf1gQPpNo6c
         ZQLMME40kWYKlDYglQoUH6RXsMyfya6VvCWjJrmKFvLWndCRB51TefoDfwm5tJOJ+SG6
         A5rjNFmgmYAD86oNMKv8AZ3XC71NgT39hXZW/HAtZUXW+RuK9P06goMpvcxYGnlA2+Eo
         g+5X105EobUD3jQ94xV0lh5ifNM5cTzDJZUQTuDXbs1p9QbL66zCHynvtbYOL2b5lteQ
         1Sog==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZQGTrExF09YjH9K++DzQBsY0Cta9JYQdrjd2kg6NfMIWeXvI5DJ2bFn6H8hH/U2P2eM3z3Kdl/PDUmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPUDrwgO8gt68BOG1XqlKhTlZDqgYtPDuGYvQsyVWyP4IbcB+
	siAzG9vaRX5WcJc6ETBX+mQMb/ofl7mo8eZpzLFjQfbYd8nWMv8IA+hg
X-Gm-Gg: ASbGncuAiqiIEcBptkyiowRFySw6fZjsEsIcCfvlWDUXf+rCjN1DEZfE9IPMVlA2Kfd
	d/GDNOQDi6ccAWTk1466kPEEO/V3HqmlCzIcYRA0K3hOiRfmb9ggpC2SAw72uuwlyVag8C65ASY
	IubUfRlYavaEiq3dkbp+qVJrW+EHyf7SMOnPKgj0aR6+MJlD7R7fMIGfs7caL8uz2dnqDwPajTf
	Wp3Evg/+lO0nn2HC97LXVpRRTb5wqaf0Czzjlr1LVfkfeVl7zalu6VX7/BUWQgmc1TaR0rZnQYL
	FU/Ean8YFmv2PLX+VryY3Nfy5kaA7FRgWZyejmoObC6dRr4BJ6SQe1ZACTQ/Epf0PP9tOt3vSex
	bwFV/Ok5EzTSf1pO4bWcQU5ZaVblX+pKO4ebiJFazyNskizNVETDhshsTE287auVG4/g6QtmXIX
	mLDfinyq3j
X-Google-Smtp-Source: AGHT+IHkEshzMykihoxZN8xwmOnrJz2pDDGH7SWMAzmcaEUtc/A4N6Xa3uJOm+m//4yVDMfdlbkPlw==
X-Received: by 2002:a05:6102:3049:b0:5db:f031:84c4 with SMTP id ada2fe7eead31-5ddc475a644mr2405338137.28.1762732682621;
        Sun, 09 Nov 2025 15:58:02 -0800 (PST)
Received: from geday ([2804:7f2:800b:6140::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559958320aasm6388204e0c.20.2025.11.09.15.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 15:58:00 -0800 (PST)
Date: Sun, 9 Nov 2025 20:57:52 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
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
Message-ID: <aREqgL8JVYUcKO7R@geday>
References: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com>
 <20251103181038.GA1814635@bhelgaas>
 <aQrKtFT0ldc70gKj@geday>
 <17220ae9-9e0e-cb0b-63bd-eaf9a6ed6411@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17220ae9-9e0e-cb0b-63bd-eaf9a6ed6411@manjaro.org>

On Mon, Nov 10, 2025 at 12:51:49AM +0100, Dragan Simic wrote:
> Hello Geraldo,
> 
> On Wednesday, November 05, 2025 04:55 CET, Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> > I did some more testing, intrigued by why would a delay of more than
> > 5 ms after the enablement of the power rails trigger failure in
> > initial link-training.
> > 
> > Something in my intuition kept telling me this was PERST# related,
> > and so I followed that rabbit-hole.
> > 
> > It seems the following change will allow the SSD to work with the
> > Rockchip-IP PCIe core without any other changes. So it is purely
> > a DT change and we are able to keep the mandatory 100ms delay
> > after driving PERST# low, as well as the always-on/boot-on
> > properties of the 3v3 power regulator.
> > 
> > This time everything is within the PCIe spec AFAICT, PERST# indeed
> > is an Open Drain signal, and indeed it does requires pull-up resistor
> > to maintain the drive after driving it high.
> > 
> > I'm still testing the overall stability of this, let's hope for the
> > best!
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > index aa70776e898a..1c5afc0413bc 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > @@ -383,13 +383,14 @@ &pcie_phy {
> >  };
> >  
> >  &pcie0 {
> > -	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> > +	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> >  	num-lanes = <4>;
> > -	pinctrl-0 = <&pcie_clkreqnb_cpm>;
> > +	pinctrl-0 = <&pcie_clkreqnb_cpm>, <&pcie_perst>;
> >  	pinctrl-names = "default";
> >  	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
> >  	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
> >  	vpcie3v3-supply = <&vcc3v3_pcie>;
> > +	max-link-speed = <2>;
> 
> FWIW, we shouldn't be enabling PCIe Gen2 here, because it's been
> already disabled for the RK3399 due to unknown errata in the commit
> 712fa1777207 ("arm64: dts: rockchip: add max-link-speed for rk3399",
> 2016-12-16).  It's perfectly reasonable to assume the same for the
> RK3399Pro, which is basically RK3399 packaged together with RK1808,
> AFAIK with no on-package interconnects.

Hi Dragan!

Thanks for the catch, you are correct. But in this case it was just
for my tests and it crept in in the git diff. I wasn't really proposing
to make that change.

Thanks,
Geraldo Nascimento


