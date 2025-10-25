Return-Path: <linux-kernel+bounces-869854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA97C08DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D443AEE00
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AA9273D9A;
	Sat, 25 Oct 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpChKIl3"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A722B8A6
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761381482; cv=none; b=bYXouvasV7+aHeCokrmu4042PbOC6bsPWSIgaz+A+wTkDlERj0vO/i+n56gkSbx/JddKGaExNwPfvJVVCoS5bM29kxQPARCUuXQnozem2kIcIwC+oq65BVK8t4ncNFGRgh/E8jbP5D4iybHLyDstVhZgJvRSB7h89FIEKUKydT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761381482; c=relaxed/simple;
	bh=811uHJZ37wZfACPU1YGuEeWKbSyaapCx8BFKBu79UWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVWatVxkreXhJctgUc2wGgdkPD2oA+xNeG/90a0P5pjmI2tTYRSKpuS2FaR7m/v07c5LHfdhKogKV8bZReMqWs8xWpw2R1lbqcGGHHLR7TRzkRx3eTkeh8TYQ7CCijbQggKwcvcN3xETeRRckVCDoeawcOe9lRq1mX0QWC0VUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpChKIl3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b50206773adso431938166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761381479; x=1761986279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rt1zvt28at9xm8W3hs03xIo0raGpVE0ymzecLcbUr+c=;
        b=fpChKIl32RIl6MSzup/XREwSeOThdjqxXmB3RkXUywMmLUK62PsiwOtivjYW+WsgYD
         sSjRHrPRhPyabrJaEnPx81NaSTEzXFlie4QjoOadn+BMY0kyb4qYXw/Hn8sa7ctLmWxa
         X64MUREv15cikIdMGo9QAoatwKllxvIARzI0IbnEyeaPxihTbcDzZVQXSs1ZCgUkyve8
         cqwGOK8FsutPJqWpCNeM/mHd9nKTM/4oA60yKA0b0OXOv7HWdwf6YVqHze0FFjeQjQdt
         kQ466yaP1NgbBrE3e7tlr/UnC6wJWH/lh6eRXyHtYIMNRJfLQK1oqcTzSjpR8M6T25GS
         cq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761381479; x=1761986279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt1zvt28at9xm8W3hs03xIo0raGpVE0ymzecLcbUr+c=;
        b=lomY8kp+ouHOzsliBzI7tBdeYzH104vQU9j35mJgPZPhO0sMresIA24OsQUM2sG8nr
         lrKtSbqLzmNJBwtR8i7MOcgQr4issVFQCHi7BVHgE2CwbhgYHlQwp1YH62LOTlPKSiwf
         EF/TSayBWgqA/+NaKdj0EHUtEZcZ0FqLgg455wErX1xKm0rJ7fgikFuxhFMX6dMVxLtu
         CQlL07UoIWiRb6KBvb6n6QfqI+7iUMDicUQvRBCAJkyx3tOxpM48G1zvCUIY8Ft/p8Od
         LFeVclGVQNcD9BMHg+lTw1gHsqmiX0jiWjEGPl4FUvFcvzVKOCmkuze9DFSkyCVYbW06
         S0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVle/PVy63WEfcEUM7oZDzFzzkAwIJUeskFOv+kD3+LhcyrLZybEZX3Y7oOmlukxCf+pyress2qb206GB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzriM0xhwnZ7S/qu8LF6eAQAzqJZBgmERiIudJosvdEc17qEC
	3Nzm44qLfxW+LTBakT/bHjgzFf9BNRoQlWY8sM+t4YnnzCYpF1DrMmCPCvhcIDX3M77yrUY+gwA
	yyz6LTV3QlUBBzlamY5mkUGes/kaSFRk=
X-Gm-Gg: ASbGncuU+lVUvwAE7A8r/3dbzspocuJALJV2sPyIwVwldNqbcfGdPw/habyw7wUC369
	16Xx/DgZuAOTiG6NnwRADXiOpGwMHECJ8tSQKvetejKeyErJqAV//6Ev1QfBNInKSZY+QokUZIV
	aGaBZRSqLyUUWzIxxLpoevdEbY5s9YVPO3OwED6ibInrJD5t5MkQft5IJ4VIHMhZd0eZdPtedMX
	QYR8yc0KkcZ6e/PgT+YAXsyHfNbtuZmzm67JEDN+X3tlQ8TjKjsdWWYey4AN3HWkOJvJA==
X-Google-Smtp-Source: AGHT+IFuGX6oiN+VZCvXlLc+k6tnFhyAvGLZQt/w/4MWDH5uLaa7YRkpj3wZ7I30zF9rslJZeftdwUUg96dShS04FjM=
X-Received: by 2002:a17:906:c10a:b0:b57:2c75:cc8d with SMTP id
 a640c23a62f3a-b6d6bb109d8mr624666366b.14.1761381478518; Sat, 25 Oct 2025
 01:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025074336.26743-1-linux.amoon@gmail.com> <20251025074336.26743-2-linux.amoon@gmail.com>
 <e6f4f3c93cfc2f18c36da10d3f86c1a50ab2bbf5.camel@ti.com>
In-Reply-To: <e6f4f3c93cfc2f18c36da10d3f86c1a50ab2bbf5.camel@ti.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 25 Oct 2025 14:07:42 +0530
X-Gm-Features: AWmQ_bmQGviTXIcOd0mClyWfGzAI1T_FFNMyLfzBY5L8A_7DMNQFG7wRa3DtwXw
Message-ID: <CANAwSgQ2PH1TJLEBVPFJ-RdaNFxn=eTzRYfEmbjx=EYq_YOeQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to
 get the clock
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>, 
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Markus Elfring <Markus.Elfring@web.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Siddharth,

Thanks for your review comments,

On Sat, 25 Oct 2025 at 13:20, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>
> On Sat, 2025-10-25 at 13:13 +0530, Anand Moon wrote:
> > Use devm_clk_get_optional_enabled() helper instead of calling
> > devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> > the clk_prepare_enable() and clk_disable_unprepare() with proper error
> > handling and makes the code more compact.
> > The result of devm_clk_get_optional_enabled() is now assigned directly
> > to pcie->refclk. This removes a superfluous local clk variable,
> > improving code readability and compactness. The functionality
> > remains unchanged, but the code is now more streamlined.
> >
> > Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2: Rephase the commit message and use proper error pointer
> >     PTR_ERR(pcie->refclk) to return error.
> > v1: Drop explicit clk_disable_unprepare as it handled by
> >     devm_clk_get_optional_enabled, Since devm_clk_get_optional_enabled
> >     internally manages clk_prepare_enable and clk_disable_unprepare
> >     as part of its lifecycle, the explicit call to clk_disable_unprepare
> >     is redundant and can be safely removed.
> > ---
> >  drivers/pci/controller/cadence/pci-j721e.c | 21 +++++----------------
> >  1 file changed, 5 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index 5bc5ab20aa6d..b678f7d48206 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
>
> [TRIMMED]
>
> > @@ -692,7 +682,6 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
> >
> >       if (pcie->mode == PCI_MODE_RC) {
> >               gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > -             clk_disable_unprepare(pcie->refclk);
>
> j721e_pcie_resume_noirq() contains clk_enable_prepare().
Ok I will drop the clk_prepare_enable and clk_disable_unprepare in
this function?
>
> >       }
> >
> >       cdns_pcie_disable_phy(pcie->cdns_pcie);
>
> Regards,
> Siddharth.

Thanks
-Anand

