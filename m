Return-Path: <linux-kernel+bounces-870918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A4FC0BFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8321C34AA34
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674723EAA5;
	Mon, 27 Oct 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqvMEY1U"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8452D5937
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547338; cv=none; b=e2JCGRtUCni1RtvyQxoLECcu9FoeECVlPjgW2GN5VVrP/K6tRaf615jFEbQVak+YiPwbiU7CgUbltVwjmRvi9WNehxRqkKL30yu23eakGRPOorjPhn15amdoLlsw4ES8p72a7lZ9JElFuzr+YNrVVZvWBg7AzdoEVbj6Nr39lMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547338; c=relaxed/simple;
	bh=oreL+ACETkIuRzK2D2r0xoY5Bjsmctzbdbz0anwCcIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWoJlyc9PYMFN6yL0NpAqCNajZpqUvn6iYutWR63dnI7wNG6L8SaDgI54EEa0k6YAQd/2wGdlGweFLAOFxITt9ev7ocZLkrU3r2Xdaux6Ma4FvAxaZD8rqIeW/P7cp/gtLFVxr7VLSqTdgpC9Lx5M+R16rxWtSRaKWXkLulj+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqvMEY1U; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c3d913b3bso7226909a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761547335; x=1762152135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tID2O9rtuhA1HdKtwWUF8mN/hhDrcp/NLBhknx3DjcA=;
        b=cqvMEY1UN9AnTQnHTfUr1TJOPuYkbzDgTNCG8/jhuVLNh/NQD0UoJ5qrgQ8VLacRmf
         FEOitkfsT9yk0u1fF9Hzo6UtyoAiftygLxr/hyojgfFn1LTSxAYqkxy6FZfNteOYZzZm
         4BgsHt51yg7Ffl0f++m9FRdHVuLZRtXTwIJEx0J3BZvu1N0bG91eZJNAqbkzIttTriPr
         DmjtF4Ov2D0DKnzjRzalBmNuRVKOsWMguF7HNrYdDfw1GcAupXFQuUdUzCA9+Byrv9SU
         ekPHk022TkCjS3D0yuv0BzFVGHsz0Ld1G9TctW9IDdMASDr367Sic3Kbh+HcoolOiHbg
         QGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761547335; x=1762152135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tID2O9rtuhA1HdKtwWUF8mN/hhDrcp/NLBhknx3DjcA=;
        b=fp+gdeuGxASeLa214LZoy6H72jg37aicMrfuWGye3DVhttoISqCfjUcNiH4Imi92zN
         bZo77CC2N2BGVREuu4Y8NGBHLoTg9wwxBCDCgmyzxLSI3B6D6Z6jeil/6g8mJQVXCmvC
         YQO72rgR+s1B6ztmiYU1mVp6pzVqyT0m4XQM1F0WMy5vJx7mBUeofDQBcGUza4yMQvyk
         TaRR+xa0LIEZageP+YycnKbqFz5hBPYIitLivQIthZoOySTyWv5J+S4u0O3FbB3/VCgk
         oW+rvObeEpgPVdbcKHRvtoTdJk5bxULDqRqReIxmTFsTU7S1Ejo6qni/rkhcn2E6q6FZ
         L8kg==
X-Forwarded-Encrypted: i=1; AJvYcCWCqq7hmoc1omItutej6EiILTlY8D8pD9St5ZbL0bVoszM4PPYOxpUmjGmgyAqqihhs+5g3iw3iirbmWFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdguZpm6bFSeICtAkmT/OqqDh7Y3YWdpESlI4P1aKH+Ncw85nC
	rsqS7U+DjhnCPd6wqwy5mWdxFUa9EBJhKTIjrrEJXW+AlvF8NhsCj9q5TsZ7zyM2wVa+Yet/xpU
	rrfi6kzlFnsfz+8J1dTNHgtkpfqoZcBo=
X-Gm-Gg: ASbGncugn8AJnl1knfwnsWGCN/nvpWWybjicIFF+sXPWmKMpG7OEapRv1+1NMB8LYU6
	tFZkn5OuEDnxDvKkha+JTcRwPpN5a9uBzecVBAJCUPmBTvBcHswonMXb1Dg9gkzFq1G+qDCXK+F
	j+G+aHXh5hqok9TByyK5Nvu44KNS1UmRU0atMBETjkskgFUe/SZoyfyX7IcUPL6wpC6/nGk69Bq
	1B8W/JvY/Bj4OCXhDySAfZD36PH6xXmEJDC5C8NPnwP5G48OEnuJ/bQ6Uc=
X-Google-Smtp-Source: AGHT+IFYyZXaxe+78PDzeedHWs3RAFG6tJ/BOlzbjZKOPUVztXY1AhNbupmOsYKoQaqvdewKBvyACvqak2464exO6W0=
X-Received: by 2002:a05:6402:40c8:b0:63e:1354:d9ab with SMTP id
 4fb4d7f45d1cf-63e3dff6f32mr13460304a12.8.1761547334887; Sun, 26 Oct 2025
 23:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025074336.26743-1-linux.amoon@gmail.com> <20251025074336.26743-2-linux.amoon@gmail.com>
 <e6f4f3c93cfc2f18c36da10d3f86c1a50ab2bbf5.camel@ti.com> <CANAwSgQ2PH1TJLEBVPFJ-RdaNFxn=eTzRYfEmbjx=EYq_YOeQw@mail.gmail.com>
 <bef3d7015012c4004d21cd829892ca942496a6dd.camel@ti.com>
In-Reply-To: <bef3d7015012c4004d21cd829892ca942496a6dd.camel@ti.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 27 Oct 2025 12:11:57 +0530
X-Gm-Features: AWmQ_blmB6e4uKlIUktX-y8N5PH8rT71hGdHJ3kVMKE8HEWamdNJJ_ocuOBGSVs
Message-ID: <CANAwSgSTncwug+nUpm1pc2H8L0Abvumh8x09AW5p0nr8ufz-Yw@mail.gmail.com>
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

On Mon, 27 Oct 2025 at 10:42, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>
> On Sat, 2025-10-25 at 14:07 +0530, Anand Moon wrote:
> > Hi Siddharth,
> >
> > Thanks for your review comments,
> >
> > On Sat, 25 Oct 2025 at 13:20, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> > >
> > > On Sat, 2025-10-25 at 13:13 +0530, Anand Moon wrote:
> > > > Use devm_clk_get_optional_enabled() helper instead of calling
> > > > devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> > > > the clk_prepare_enable() and clk_disable_unprepare() with proper error
> > > > handling and makes the code more compact.
> > > > The result of devm_clk_get_optional_enabled() is now assigned directly
> > > > to pcie->refclk. This removes a superfluous local clk variable,
> > > > improving code readability and compactness. The functionality
> > > > remains unchanged, but the code is now more streamlined.
> > > >
> > > > Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > v2: Rephase the commit message and use proper error pointer
> > > >     PTR_ERR(pcie->refclk) to return error.
> > > > v1: Drop explicit clk_disable_unprepare as it handled by
> > > >     devm_clk_get_optional_enabled, Since devm_clk_get_optional_enabled
> > > >     internally manages clk_prepare_enable and clk_disable_unprepare
> > > >     as part of its lifecycle, the explicit call to clk_disable_unprepare
> > > >     is redundant and can be safely removed.
> > > > ---
> > > >  drivers/pci/controller/cadence/pci-j721e.c | 21 +++++----------------
> > > >  1 file changed, 5 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > > > index 5bc5ab20aa6d..b678f7d48206 100644
> > > > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > >
> > > [TRIMMED]
> > >
> > > > @@ -692,7 +682,6 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
> > > >
> > > >       if (pcie->mode == PCI_MODE_RC) {
> > > >               gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > > > -             clk_disable_unprepare(pcie->refclk);
> > >
> > > j721e_pcie_resume_noirq() contains clk_enable_prepare().
> > Ok I will drop the clk_prepare_enable and clk_disable_unprepare in
> > this function?
>
> The clock needs to be disabled on Suspend and enabled on Resume.
>
> The reasoning behind replacing:
> devm_clk_get_optional()  + clk_prepare_enable()
> with:
> devm_clk_get_optional_enabled()
> is clear to me, but the removal of the 'clk_disable_unprepare()' on the
> Suspend path isn't.
>
> Removing 'clk_disable_unprepare()' in the driver's remove path makes sense
> because the
> devm() API will automatically disable and unprepare the clock when the
> device is "unbound".
> However, to the best of my understanding, the device is not "unbound"
> during Suspend.
Thanks for clarifying my doubt. That part makes sense.
> Can you clarify why 'clk_disable_unprepare()' should be removed in
> j721e_pcie_suspend_noirq()?
It happened by mistake.
> Regards,
> Siddharth.
Thanks
-Anand

