Return-Path: <linux-kernel+bounces-898405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F3EC55372
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 139003455E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209F158545;
	Thu, 13 Nov 2025 01:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su1epdLT"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CA91946C8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996157; cv=none; b=UPMoEQBS8DBCYY5S5Z+s8xoieoOrPjMbrZb28ltx04mKpK9wdnKFsSaVxj791HJUoIXgOKmDvzBQKeB5E0eDJvgoIWYfDrUrXsktw9b1hu2Na3YBO+jPz+rSAbEAaFYOPyCRYYq8ZB7Y6zyz7AezKEEogDdDBw8/P0dx6VNFAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996157; c=relaxed/simple;
	bh=2MIM4SOE2aXVCsyeWH0rZQhLjKK+RGyznQHrldLD4fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTWFkiDwpFZFBKMepjKEWLgPVR/Co/k3E0hFoumtPuUE2XXU9RbKFoy5cCBfWtaT7A1LapdSrkxv5LvK/qUQ5/u633eKAAK4zD8r/ejfBF7/EAiACQN1kEjr106seaLpoKZXaoHW3jWrOLt5dDR3uSuBWvXxPvdJAqNTmzFSR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su1epdLT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso186467b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762996155; x=1763600955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUp9XSelBvHam5yKb7kd4Uyi0l9skDUn0FSAP36J340=;
        b=Su1epdLTawvl+O5gu/fALQTsoIE8br9nkOLJtdGrCmegI8m+dxM4XSX+4mRf7/rR7J
         Yvxk2vL9ePPBboV4gvFE4tG35zlc0eyuKyI2I8fv7rhp42d76BWcQ5VHSSOejjayj+f8
         ARz02w4SfgqM8H5lHm6SwG7OEx2FLA9OvEE63/3gpBZqFFqWcuu45houAAKkD1BgdNxp
         L+v/RjiAiZ9p444IpXfXUDd2GiJMXKCDQWix9aorOJORNhg/3eIxRBQ5Y1lt9nBw64Zt
         Z3Rm+UZZJgyls58EvI+s2oj1Et9El0k5UtmNYaZr0fKKyZdlCrGas+P5JuBrNELMMEAc
         759A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762996155; x=1763600955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUp9XSelBvHam5yKb7kd4Uyi0l9skDUn0FSAP36J340=;
        b=lnYOimaPHHWYQFd8URYLltB2Fwr+I+uOqSYJUM8NW7mySi/Lj1hogFZcyjlt9tmY5o
         Y5feUMZ5E5mVvXjpRqUwtH8Fa9beaIHGLEKCORxaSVm+dlqEF+iIyD24Ws6+v2z55Up+
         d3SLpCflXiL7HnVGiXpevgcUAj4mdhGJESCos3abgZCKrFPTjD2OubZirwWEiRIdfduY
         fbZoCVDFTt695t+2tF9aKswFg7/azYW1fngzXZoA1wDIdhWRh6FCPw5HlqLQrsl4jW0Q
         3yGBsE/Q55qpl6ml/e/dVo/S6tiH8rR2jrS4Y86K8m2t4Hahj7JKpwuNHuwzmM4YNzF9
         jkRw==
X-Forwarded-Encrypted: i=1; AJvYcCV7Mx1bZi87K44ATHl0/ggOKJ+c8m5DLmZpBaFABjeFFhgKxnXfmX+Do0WV9B3+UBQh3BUc0r04jZnKfdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+wtYtdNgEIUwM2An8JPZ5isC+gaQ/5wxFrroy7OP6RmrZAxW
	4De8Ao+l2gi7C0M8iko0koIIZFydtlzY8cpGAIRmIElTbdUQLKzdnum0
X-Gm-Gg: ASbGncv73x7F/z48MeLy0JUDAolD7pCkCOKPl5JE4UpldIrprt//0U/o3wQNrMDPBhz
	pEBOpi99989UABI2nkhJsWJ1Q3Piymgny0LfTfwTqM9lbZYD6BTR1ySy6dRjCtl76ki8uzlk/ke
	xMYg9MC4xi12DM9sfLGU9ABcdoxu568Txgnx5lV+HVsxXH2NX845cO1GvyFIydXFj7iYtRsXOy1
	6snOojj1aO4+bEQCH+DcnxErDwkZvF/G9bN5r5yFAAUGGPKMmxmprmrY3MwJ11BGWC7KGs5SZx3
	gCVN1mtG2ZmwtrQ1TA3LqXmljB2DSE8BaWAohzHmPvnq7deSr4BiJzeuScX/o/KU1orTPeOO4vo
	T+7mOWJRfG9ydQpPckQDT16cPmLlueiWgr4cI7FdBmpqRik8+vUjU
X-Google-Smtp-Source: AGHT+IG6mp0E78VSvu/3qqFMgI1T8YiQOF856a+2bF57H7GUKPTtbD8FuO+l8D99yBgWDvvJxeroug==
X-Received: by 2002:a05:6a20:7f92:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-3590bb147d7mr5734286637.54.1762996154814;
        Wed, 12 Nov 2025 17:09:14 -0800 (PST)
Received: from geday ([2804:7f2:8082:3106::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927826dc9sm303318b3a.53.2025.11.12.17.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:09:14 -0800 (PST)
Date: Wed, 12 Nov 2025 22:09:03 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: =?utf-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aRUvr0UggTYkkCZ_@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
 <aRQ_R90S8T82th45@geday>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRQ_R90S8T82th45@geday>

On Wed, Nov 12, 2025 at 05:03:32AM -0300, Geraldo Nascimento wrote:
> On Tue, Nov 11, 2025 at 03:47:04PM +0800, 张烨 wrote:
> > Hi Geraldo,
> > 
> > In standard GPIO operations, the typical practice is to set the output level first before configuring the direction as output. This approach helps avoid outputting an uncertain voltage level at the instant when the direction switches from input to output.
> 
> Thanks for the explanation Ye Zhang, it makes sense to me. It avoids the
> pin to not be floating so to speak. I kept hammering at this problem, by
> the way is PCIe PERST# side-band signal refusing to co-operate and
> failing PCIe initial link-training.
> 
> You're not going to like this:
> 
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 47174eb3ba76..fea2c55992e8 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -183,11 +183,13 @@ static int rockchip_gpio_set(struct gpio_chip *gc, unsigned int offset,
>  	struct rockchip_pin_bank *bank = gpiochip_get_data(gc);
>  	unsigned long flags;
>  
> +	rockchip_gpio_set_direction(gc, offset, true);
> +
>  	raw_spin_lock_irqsave(&bank->slock, flags);
>  	rockchip_gpio_writel_bit(bank, offset, value, bank->gpio_regs->port_dr);
>  	raw_spin_unlock_irqrestore(&bank->slock, flags);
>  
> -	return 0;
> +	return rockchip_gpio_set_direction(gc, offset, false);
>  }
>  
>  static int rockchip_gpio_get(struct gpio_chip *gc, unsigned int offset)
> 
> By setting direction INPUT, then writing out, then setting OUTPUT again
> miraculously it doesn't fail initial link training, with no other
> changes that already have been rejected by PCI folks and Shawn Lin.

Hi Ye, Shawn,

Here's more contained workaround without resorting to clearing DDR to
INPUT for every GPIO:

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..1d89131ec6ac 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -315,7 +315,8 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 			    PCIE_CLIENT_CONFIG);
 
 	msleep(PCIE_T_PVPERL_MS);
-	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
+	gpiod_direction_input(rockchip->perst_gpio);
+	gpiod_direction_output(rockchip->perst_gpio, 1);
 
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
This results in working PCIe for me, pass initial link training.

I think I need to provide more details:

GPIO in question is GPIO0-12 / GPIO0-PB4. On RK3399PRO VMARC schematic
it's called PCIE_PERST#_3.3V and it's in the PMUIO1 domain.

Without workaround I have about 6 milliseconds, from driver probe and
parsing of DT that sets initial value 0 for GPIO, to deassert PERST#
by setting it high. Which is why just removing msleep(PCIE_T_PVPERL_MS)
produced working PCIe for me.

After the ~6 ms it becomes necessary to hack direction to input then
setting direction to output to properly deassert PERST# and proceed
with initial link training - which is why, again, hacking PERST# as
either open-drain with pull-up or open-source with pull-down worked:
gpiolib hacks that by setting direction INPUT.

Thanks,
Geraldo Nascimento

