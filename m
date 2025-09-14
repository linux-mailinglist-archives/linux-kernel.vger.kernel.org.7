Return-Path: <linux-kernel+bounces-815593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DDB568AF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897293B62B0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8091EEA31;
	Sun, 14 Sep 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2tfi+L4"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841E1922DD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853386; cv=none; b=kpkmqGs1eVT4ZQ8xuMX96qLHi0mgbx41ZOzfLaYiJ5Z0ZdBNfcyQne136lIP4jrhhK5R5CpYa6bXbyFooQkAjQmswL4EtpVclfBve7ahyje3ZgF4/QC1WUvpV3cDDhtH9u6t20ewaZKMFDmMrnBb3BTh3wyfwbehiDVndogYp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853386; c=relaxed/simple;
	bh=z5cXpDMyuJ+Ht6r3/PhJmTnt5q2Pgn8JuraH6UOXQks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3K4LlH6vaBxusdqICXdXCcaEmX+78nAGm8wDprbgsrFkvmdlikReKXiZFF4a9jplzjdopP9e/zPcsLE03t7C1snzg/OdbOTHAIBGOUCYMCvs16cU+OB6I0ao0Bc9KyZC6KuBqCkjVTYvm0F2CHgq8jWemM2NADUmzSFk49h9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2tfi+L4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f1eb1abb9so1103532a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757853382; x=1758458182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XzitEMhuyn3awzPo2ebuyIpUU8Id0dDSX6YSKZOv+ZU=;
        b=L2tfi+L45Q4ArYvTDKAG+/aw3/V0DGGZGDakemCBzIEGGszvfinIsdNBdgvWL6/+1k
         zuUSAJvZbtaGLUUdaU4+7+3s+rTkI4om4L9rCfLhD+SWOXXfuMKX7/bL2NfBUSlS+8+6
         +peN1CDmRYP/GTSU5xFR0zoirEt2REFSAQQJ9zqst3zkDtAr4HCRAeRnCBrbk9oOa+nU
         DSzWMTNCL32L5lEXNovAmWe4QO6zuUMobNly6VHRRmhb3+AE+RR9+W8bjc/VqbtasyxV
         qX/J+0ygNf3v9Kx0jk4HfjtHqxk4A2F3/W+0CwX/u5wllyMVTcqhLnZZa7vaxr1oKRMf
         5AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853382; x=1758458182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzitEMhuyn3awzPo2ebuyIpUU8Id0dDSX6YSKZOv+ZU=;
        b=L+nekTvS7IsNZd9qLOHU33xH+4BOLGRwfsJbqdKYoFD4KQsFMENhykX2515mQV+fsT
         Tj8zSFKr3HyHWTUeog6Rmw8zkZQiwb2bqsN6vBPAn9+lOhANIibAVCvYxN1+JQgDe/Kf
         IuxVSZCyI0XkH9E+i+CYiFWDVjgodHT2AhPXyHeqlIrdJ65Egesme/LCkZlBaIkE9pSj
         1GMRy6D+IxCdha7y55cBIQvUqlAkiH0t25ILZhUbuNHAKszOVysmLKkG1LFs44gqdWTd
         8u/+XVKOIun7mcWf1mBzUF6iJevRLEdB9BLDCigA3p1kBw2WdEbhJ9HD3KwOuw6XM9aa
         R/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjVRDKb+ab9eoPIa6sdLmtX8TJOlZjh8KZjZdO0hcvTNME1yWStnvGnhyMF4pyLCTzOArId1PmG1L1O34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysx2G8xn7ybbJY8vas3WPD4R+NvH9nGK3UzlTbsrB1ivOoWaUs
	dXLIG7HfcKCjXD2oumca41ZN0Djv6My5epCacPplPlIGU3oBdZRPVKF2mEC8Jn/PkGyLz0XQMew
	s3vga1Aolz6qgR7ruaveay06w+I35oJ+cOKL1ldGn9w==
X-Gm-Gg: ASbGncuRkSX8KDVFsbZdx8X66PzBc2XxN4wcW7dml5YoCZlQjlNKUjXIZsmb4Xf9tv3
	Un6fPAxsX0gLXuFkTXSZl61QZsjEQZIL+4Sp5Jjxs0aM6Pm22Lzxs3VPIz8izCNLdN+ZxB1baB1
	I4beAH7RNqAM9bLVk3c30CaykC2iD9MVFwH4KysRHqgqSB9wt0/hT6IgK1h4/D/DQn8ThxcdL2O
	EA2JcTVqJA7029HNkOD9HIK3ZG4r5hRynQ0iPnZ6QOi76KzWFmbMLMLXQ==
X-Google-Smtp-Source: AGHT+IGLgebxMOwJM71zc3D3ToXnk7YnVzCirJGRT8ZrnA27mi4s1untjNEF1bLojbZ0S1PNlaf1GTIT/qLxGso+faQ=
X-Received: by 2002:a05:6402:84c:b0:625:ec92:9cb9 with SMTP id
 4fb4d7f45d1cf-62ed97f056amr9211931a12.6.1757853382608; Sun, 14 Sep 2025
 05:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-3-vincent.guittot@linaro.org> <20250912221817.GA1650405@bhelgaas>
In-Reply-To: <20250912221817.GA1650405@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Sep 2025 14:36:11 +0200
X-Gm-Features: Ac12FXyJQFQuZhjlTZQnQvt2nz8ZamVHOj5HVBPrh9aJUXB8J86pKRnbeO0Lw-0
Message-ID: <CAKfTPtCm8QLrMv6CF9KWRf__39bRnx7VOA=rf6M5zJmHL-ekgQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] pcie: s32g: Add Phy clock definition
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Sept 2025 at 00:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Sep 12, 2025 at 04:14:34PM +0200, Vincent Guittot wrote:
> > From: Ciprian Costea <ciprianmarian.costea@nxp.com>
> >
> > Define the list of Clock mode supported by PCIe
> >
> > Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  include/linux/pcie/nxp-s32g-pcie-phy-submode.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> >
> > diff --git a/include/linux/pcie/nxp-s32g-pcie-phy-submode.h b/include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> > new file mode 100644
> > index 000000000000..2b96b5fd68c0
> > --- /dev/null
> > +++ b/include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/**
> > + * Copyright 2021, 2025 NXP
> > + */
> > +#ifndef NXP_S32G_PCIE_PHY_SUBMODE_H
> > +#define NXP_S32G_PCIE_PHY_SUBMODE_H
> > +
> > +enum pcie_phy_mode {
> > +     CRNS = 0, /* Common Reference Clock, No Spread Spectrum */
> > +     CRSS = 1, /* Common Reference Clock, Spread Spectrum */
> > +     SRNS = 2, /* Separate Reference Clock, No Spread Spectrum */
> > +     SRIS = 3  /* Separate Reference Clock, Independent Spread Spectrum */
> > +};
> > +
> > +#endif
>
> I doubt this belongs in include/linux/.  It looks like it should be in
> pci-s32g.c since that's the only use.

The header will be used by other driver so I didn't want to manage the
transition and a patchset which would includes drivers from different
areas

