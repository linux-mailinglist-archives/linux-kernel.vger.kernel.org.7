Return-Path: <linux-kernel+bounces-859537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF92BEDEB5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E276B4E360B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47823C17;
	Sun, 19 Oct 2025 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyx8jvE7"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBEAF9E8
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760853641; cv=none; b=hwI8xk3HkKtWY3x0Jtb5xuOcSGOON/YBqOZEls8qZVeTOG3jAmypE8Ge9aq9JdbAW9MI2gYtzJTZAGh3wT1gCV422pSESDHRJdPibnU6RrgklxrihfjJGfsf9h5ddqHT7Dh8BfxOegM8E/c9UckrJq3hYMzpOplub3npV2LJXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760853641; c=relaxed/simple;
	bh=+FmVBSQvGYziWTCd8nap5gWQD+747UUq/SV2tX+pf9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6hCqTa+4QvT/JkYT9472N854DdOCCTt1iCOA8Wj2q79pBZIS6N7Kzt7vl16hi8J+JNz9AWyDhl/+pprEWU/UySBMkJoosjb1fOxrKfMszgl9pBOdvbfSpMtqpkte0t0Bh/bgQQun0mZ/KLAdqkyWFCVTHPByG0NPLNvVsP4yJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyx8jvE7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b4aed12cea3so562170666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760853638; x=1761458438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDRUSkhiE/XFv7OW4RSw91eps1PHNhul5pJctkyAuh0=;
        b=kyx8jvE7CcO5RDTXwF1VKzxZpj89umkgHdcyS5IgRPRQj7UFOv+tB/Yo73VBvPzRkL
         n8ya5dhgFmIhttynbU1uYG57WZYlzFgb9Q0WPmDl+zlkX4oN1GxnF/q3J13mFvfEYYfv
         z1RU4EQODW5V5DholblzezLonqs8GwsFOz8wpbwvtkfQ+klQ45LI7OUcCwLDP4uzFMFW
         JV3Dvo/ScYIHsdoffpYobiUbWXAD3Yu2uYtyibE/mQB4dxSb7PRddKLfuKmBWcJ23GxI
         ooeOQ9p3Qobmz5Zjml3mTcWj4GCVy/Q/NV2HMT//XF64tAQdSivifSTtJ4WXCAHCWTkZ
         fYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760853638; x=1761458438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDRUSkhiE/XFv7OW4RSw91eps1PHNhul5pJctkyAuh0=;
        b=tkfGGc9B08U4hw9UjYMelfiPCsdzgcJ0C3OuM3WogBf0X/slZdGXKUiiMVMog9JGwG
         lF2RG4/J73tFIIe0rWXFOEAPcjDhJDU3uDxF5Qrjhi+1DsswXSB/CmO5QSRW5LqOXsC+
         XLmLnKhgpQdtrMBL9HmJXyeOdcCxqXelVcKg0tFdKKh+qNgfgKh2UCjZQ9rJDsTiU3uF
         XxRYozWMfyLy+MQunAnhh0JuPPJGTN8d6Vgqc1oTEbEHcaJDiKqVSGdy2SRHvezyWidb
         tm5I0C9eaGfD/97xo68F8vjImfC+Ck6NongNgU+o5TFMxQsLooLJgxuv7KOAO7zaLje/
         2M4A==
X-Forwarded-Encrypted: i=1; AJvYcCWBvan1vJwIVeyZZmco//BsqDp/IpW5M6n2WMGPhnyaRpqwkp2rvXYElQusMstsiV79d64JRRQW3aSa87g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOQ2Zh3cMwT8SZE1Nz9M8IH36jyIZOCUplKVlnK5amRVl2PmY
	NOciszvtqew41r1Zn9ZQqvoZObk2YSTW/eUXtuY57LUPYeYlNg1FC7qoJtgFzbe5x3hAjM1EfR3
	+d2xw1dZnauR6/8h370mdiJ6tK4hYVB8=
X-Gm-Gg: ASbGnctJIik46r5z0Fmvg565eCnl4kpl2KGqNvH5ftL2AwHOgpkliAd+Oz/yg0qU/wG
	zxau6pk2s1uV0MhMbOTm/cGGgkv/84X4yAO/BUCENksHqc5q+dy47ViZZzIfXgH1oqRcTaspH/e
	+6ZmEa/wNCd/HTAw9HnBQeCxqFfriA6tYSlgkv4lJzv+IrYf7Z7qdi6fyP+WSc1OD7PZH9NSMJR
	Pn7jlPdXBosG/biNKI9antpYiEhvgyEuymiCBL+3GwPsU1P2Ofd5QqrzA4bm1Vh3hikVQ==
X-Google-Smtp-Source: AGHT+IFouXM66dWGoME6chpnuaQA5AhGJ3XBtWEQPmJjkQDMbd8DEH4sRrB+vsmFy93A7mrCfiSnE5e4aC5FUlXjYmc=
X-Received: by 2002:a17:907:7b8c:b0:b04:b446:355 with SMTP id
 a640c23a62f3a-b6475706d77mr890751766b.59.1760853637425; Sat, 18 Oct 2025
 23:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014113234.44418-1-linux.amoon@gmail.com> <20251014113234.44418-2-linux.amoon@gmail.com>
 <aPNiW8QzsLv4R0E6@stanley.mountain>
In-Reply-To: <aPNiW8QzsLv4R0E6@stanley.mountain>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 19 Oct 2025 11:30:22 +0530
X-Gm-Features: AS18NWDuyNsNiWxQmtkRHjc2M2PlmVH_Wd0KhK-4VAGV-r5GP86AOOEs_7Ea5Qw
Message-ID: <CANAwSgRchOvNPShUZOsUzdS0jaBOtFmpPLpJZEv7NNqOohWo3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PCI: j721e: Propagate dev_err_probe return value
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>, 
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Dan

On Sat, 18 Oct 2025 at 15:18, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Tue, Oct 14, 2025 at 05:02:27PM +0530, Anand Moon wrote:
> > Ensure that the return value from dev_err_probe() is consistently assigned
> > back to ret in all error paths within j721e_pcie_probe(). This ensures
> > the original error code are propagation for debugging.
> >
> > Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v1: new patch in this series
> > ---
> >  drivers/pci/controller/cadence/pci-j721e.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index 5bc5ab20aa6d..9c7bfa77a66e 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -569,20 +569,20 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >       pm_runtime_enable(dev);
> >       ret = pm_runtime_get_sync(dev);
> >       if (ret < 0) {
> > -             dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
> > +             ret = dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
> >               goto err_get_sync;
>
> Wait, no, this doesn't make sense.  It's just assigning ret to itself.
> That's just confusing and pointless.
>
Ok, Thanks for clarifying.
> regards,
> dan carpenter
>
Thanks
-Anand

