Return-Path: <linux-kernel+bounces-896718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBBFC510B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7F6189DC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1287D2F3C2C;
	Wed, 12 Nov 2025 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVZ42ao4"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511F2F2603
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934614; cv=none; b=KcuWu/Cx2WKXKD3nnuUTQIpu7QFqKW3YCUGNnIx46FAo0s2cuMT2H0axTvoOGXLXt25DmFzQrrvBziRWyUHVIufvHX+0Zpg16J0jGWVjtOSJQtp8UIH8ckmWrcBXuivm/6gFKPdk4r54ewNvh+C5CHGLDGU5vCxHm1u5hqM0tzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934614; c=relaxed/simple;
	bh=zPGu40RBS+rv+lA9IJtOCrLM35WUPLbmW8rMipxE56o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKeIKtWdcZz0Gp9EZTCACWodsUS9x6xK89jOnNYnfTktl/asWlNKEmIiOxB8/0uOD2ClKAq9XGItrzpYrTuv8kSvMkfVLUI0ZthGR3KRedFP+A4PxAGlXLdPJ0op/yVqszWEnSTscWRvy7+/hbNFI28emMwLOBY8qZvKOXFmmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVZ42ao4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29845b06dd2so5021685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762934612; x=1763539412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IOQ8gbWYR/8pIKJHHt25CkEHl+HOhDt/PI+YYG3jAcU=;
        b=QVZ42ao4mMs2CpSTRfVM3TADYwdgVveukUPeJiFkT0zZyeU1C745UJmB+LNccHAs4w
         6OfI7wK7cm/5iPhzt8HwZQjUBeQZzHCXy/u1nRNJ4I92q/q/jTmlAKk12TPG9jOxj3ow
         Cq41QXcXAH7ukzFK2ddDqNjOIvXhL2zgMkGLaGC4J9E9yVHMMrm2dM8xjIOnhByTV74E
         1jiOj4nhvFJXEsbGixflauc1r2QgSgglutwMi/FP1ZEl3bIydaTBV+PVFgaKAncxhs1g
         etoO4XUL6xXbVFn2lQ9nZfoQgxGrh0j+ykYkz9xKRqytcummxrSF61Ev47qetGTXAmuZ
         KTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762934612; x=1763539412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOQ8gbWYR/8pIKJHHt25CkEHl+HOhDt/PI+YYG3jAcU=;
        b=VEXGEvqEg0emAC0fbVENUe2JhXQvL8plFJF+Poj9nSFiXnaUjarOhNYr9gF2L7KbBa
         G5wgXJgSjWoGsAtQLNiXM+JZTIjtybJidj1/pWgZV/EUC2al9neTipI4I6xgkFLSIvhO
         TCi10l7U0P3nHuaRjXdJ9ET5GwPZE/ax+OvboIxVYSsVF2cQ2sBtEvddLF+9L/knICs7
         sULLNB4OB6Uu3rLx8BDlpsgroWrviUVdOoMs+ZtHYke2HmdwaOLPWkqV58h3QB3/wRf5
         DRQ4dr6yrMdPg6D5c2mZSa4jhgcjCnYtNRhgMu8SNvVJrUdrAp+L0S+2qkBFmgTpLJUi
         WrDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOa2J7B8yCmDIoWotvk/56is5FpMiS/1sJ3Qe7y241drRW1pajd65Q+GRX8wK309a/qe5CcHZbhe6JYIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0DbLiHWA+xqri3DQavZoQMl+deG7L6L+gblqtLG3d3DW0GNs
	cL4dYQ1lEnCdMH8krw1tJVRsIre1Fkwfcy4sgcS9muksWJQCp1+7IADt
X-Gm-Gg: ASbGncsmISNiu09TNEIN/QkFdoXJTmMj/1vq1LYU4dhlPREn8zBRKLxfnp2r8ZyKL2L
	1TzqTjTZbLynZPfw/Ekbc4re1g9TKJhwddCqkEGo94EpKcCi7DBKx4PJaEll62oNbaeIoUursYR
	1Yi15GWSLtgDuamr8pQtW9bpUxG6AWva42MzPdBOxulB4EzYZmdX7SkX6AHjMfTqPaoEYgLHNl+
	iXfzkVftm40/ePY+FeGKk73T5ObvpgY/E0uHcNDVlyGZFtqOd7Wklr/3qJlwIf+nzywmMCT2Z97
	EaAJ2Y8R/PPaJvZPHRUWUZw4KX1bloXeMnQeGLFFwKt8/VVNVRkpsRg78THQKdlHs1+pIWv5xae
	aAngcETv48m4HO6kEbvbw+LWF950t/igYZ9R8Owix0LXDrgQkV3Yz84m1bO2LSAqTNYpFB2ulFw
	==
X-Google-Smtp-Source: AGHT+IH+DPJMbQNSOGKgtCR72ZONR0AxugfjM0MLXwjdzOTvsq+YFq9t1EqGEJ/mZYCDIKH8bOXU0g==
X-Received: by 2002:a17:902:e78b:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-2984ed2b619mr28705965ad.12.1762934611984;
        Wed, 12 Nov 2025 00:03:31 -0800 (PST)
Received: from geday ([2804:7f2:800b:7c80::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbdac10sm21286815ad.22.2025.11.12.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:03:31 -0800 (PST)
Date: Wed, 12 Nov 2025 05:03:19 -0300
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
Message-ID: <aRQ_R90S8T82th45@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>

On Tue, Nov 11, 2025 at 03:47:04PM +0800, 张烨 wrote:
> Hi Geraldo,
> 
> In standard GPIO operations, the typical practice is to set the output level first before configuring the direction as output. This approach helps avoid outputting an uncertain voltage level at the instant when the direction switches from input to output.

Thanks for the explanation Ye Zhang, it makes sense to me. It avoids the
pin to not be floating so to speak. I kept hammering at this problem, by
the way is PCIe PERST# side-band signal refusing to co-operate and
failing PCIe initial link-training.

You're not going to like this:

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 47174eb3ba76..fea2c55992e8 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -183,11 +183,13 @@ static int rockchip_gpio_set(struct gpio_chip *gc, unsigned int offset,
 	struct rockchip_pin_bank *bank = gpiochip_get_data(gc);
 	unsigned long flags;
 
+	rockchip_gpio_set_direction(gc, offset, true);
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 	rockchip_gpio_writel_bit(bank, offset, value, bank->gpio_regs->port_dr);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
-	return 0;
+	return rockchip_gpio_set_direction(gc, offset, false);
 }
 
 static int rockchip_gpio_get(struct gpio_chip *gc, unsigned int offset)

By setting direction INPUT, then writing out, then setting OUTPUT again
miraculously it doesn't fail initial link training, with no other
changes that already have been rejected by PCI folks and Shawn Lin.

Everything works as expected. Is this an explainable behaviour by
Rockchip GPIO core?

The problem I am observing is that once I set PERST# it becomes
unsettable again. So that's why those open-drain/open-source hacks
worked (gpiolib will hack the pull polarity to INPUT).

Thanks,
Geraldo Nascimento

> 
> Additionally, for Rockchip's GPIO controller specifically, setting the level value should not be affected by the direction setting - the data register write should be effective regardless of whether the pin is configured as input or output.

