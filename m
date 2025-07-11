Return-Path: <linux-kernel+bounces-728393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3BB027DB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731EBA48343
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8372253EC;
	Fri, 11 Jul 2025 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lTOSy/LX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55C21A451
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277771; cv=none; b=C5cH2UftiEyo8cvaLq6KL8lqEhUIpflcADdtpcA621K64/Tl6a4bom/j3eajint/qP1Ytdb/yoVeOalM/dzBpKoZDpZaXz2q7tmWwNvzk6cfm75i0kV/amUcuw/vVdH6t9BKhUZvZBjgS/mPN2/In+zHDRPGFWmtE1zQiikRo54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277771; c=relaxed/simple;
	bh=MrjFFSLrixtNQISgNSoqC6by9asCMdinuhdIGBG/7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TomAcq8BOHgy2EzUsLMHnEJf12+F3lCcsWmWS1UdAzcHUC9P7jS7lrCz8npxhvBzOKP13C6JieSJmIJjjh7s+8cxoosp+TO0ongDJBB2Bt2hOdoSWaOH3bkLVOpzsWfjT6+dmVXFD0n0rt/ZWIMTEj8Rk11WLjcTP0LUBmtOBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lTOSy/LX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2352400344aso24903185ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752277769; x=1752882569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KC1CYY+XS/EVReWHxILsWiPjh9LJPfU94snv8/jX79c=;
        b=lTOSy/LXZfKubczJI7oKZlrg+rRwJWas7qtj0Zis/Gn1QcHcjtdj8V2e0ltGLqWQn/
         LlsJINN01ieselFSj4LLKiZCL5AcJtX1pULZT35Ng5NsGTD3tecUWaW3B7sqc9bIhspF
         tfmHpaMGtlkjbc8boHF8eqD5lRHS+11XmaMTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752277769; x=1752882569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC1CYY+XS/EVReWHxILsWiPjh9LJPfU94snv8/jX79c=;
        b=RZC9gpYCGFbyP5obO5nHymDb9/XC5lPOU+d48UuVFsL5h0zUeqZ3V417MEMPiADiYa
         0CyU+wTiSEXbtv8rQlr6/PhPwMGN9ZeEDmrGVgBDh8/STeqp2QUf3HPXC12qSDfoEtIb
         9GGqJA0KUAFO0L3wSvq3gfJUTiD+mZOLNNby4r91747pDJ2CxDkv9MQHB+0zoSptIcWa
         Y9+pppE9sdCT6e+8PwO676y6CTH5yd7aaF7iwjFIeoeY/WiVlBwGDU9vXVogI7COZeQN
         nBhUx8CVKOblKmPAMiy40DyxpA7I/bhCM8qZeozfgoVDuOZCcdthfHeQA8bPAHPZhvIP
         bC0A==
X-Forwarded-Encrypted: i=1; AJvYcCW0l3HDpx5GHGZYnUikF9D2vEnKpXF4yHft0lsn8aeI9qap1Srjho0zjEV4PXZjxJ/svIF5AKMwZyVbqA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzvW14OYWIu2yxDbbwodpbiDU6IPr98LtBcIIyyN5FOrfjKAb
	skxaN+xTwPEhxSzhMu9nznjXH8799JVNBW+Iq4Hg0K3a9GOBxbfZF12phXuDKRGy2w==
X-Gm-Gg: ASbGnctH+TFDxh8ufmQPxG1R7mfm8l+GWxSeD2+yr+kImRfrbnjtkOLA/y/XB1fl85b
	yEGFYsFWmWsxn8IdFh0LizccuGX0G6exKdN3q5iNmk/kfhE01usRKvjj+9Rxaw2v+zSisZc4b+X
	c7R5S5lKIKFJEE+yyuxWJ0ZeNuDGRUm9boRiuKhkJLT/UdozvFDd97mAriTXPqdavBPNWqGcnvu
	cu5b14OQgzOVeSIPJx9Y/NpXIK3zPuvd47XTmTCYuUpmdQSPrkNu6Vtgk2WjHV1+JdC5PFdFPa1
	3pusfXNAw6LMsw2DFY3IDtFuHYhlf7dPYYJGfn8zKH96mr+fhLRzKdMkxTvH8lAAprYFC6D9vQn
	bdBA+8E6vjbf3drb03mTdJfbC4QIDEvWB+bf1+POkTjp3ORL3s0RAqwQxXz0b
X-Google-Smtp-Source: AGHT+IEZEOkHg2JDnPVscnsdRLHkXkD8TwYVqpEi0tinyurqooXEUZWQu4K9HvxpNjbOnoSzMA4FEg==
X-Received: by 2002:a17:903:46cb:b0:23d:dd04:28e5 with SMTP id d9443c01a7336-23df08e1bd4mr68820345ad.34.1752277769541;
        Fri, 11 Jul 2025 16:49:29 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2386:8bd3:333b:b774])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4322f15sm53994305ad.130.2025.07.11.16.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 16:49:29 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:49:27 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 2/3] PCI/pwrctrl: Allow pwrctrl core to control
 PERST# GPIO if available
Message-ID: <aHGjBxKYJCkhXcbo@google.com>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
 <aG3e26yjO4I1WSnG@google.com>
 <kl5rsst6p2lgnepopxij5o6vyca4abrjlktsirfac3v7cnm33l@svrcm7v4gasr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl5rsst6p2lgnepopxij5o6vyca4abrjlktsirfac3v7cnm33l@svrcm7v4gasr>

On Wed, Jul 09, 2025 at 01:35:08PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 08, 2025 at 08:15:39PM GMT, Brian Norris wrote:
> > On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> > > --- a/drivers/pci/pwrctrl/core.c
> > > +++ b/drivers/pci/pwrctrl/core.c
> > > +static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
> > > +{
> > > +	/* Bail out early to avoid the delay if PERST# is not available */
> > > +	if (!pwrctrl->perst)
> > > +		return;
> > > +
> > > +	msleep(PCIE_T_PVPERL_MS);
> > > +	gpiod_set_value_cansleep(pwrctrl->perst, 0);
> > 
> > What if PERST# was already deasserted? On one hand, we're wasting time
> > here if so. On the other, you're not accomplishing your spec-compliance
> > goal if it was.
> > 
> 
> If controller drivers populate 'pci_host_bridge::perst', then they should not
> deassert PERST# as they don't control the supplies. I've mentioned it in the
> cover letter, but I will mention it in commit message also.

Sorry, I think I partially read that, but didn't really grasp how it fit
in here.

I commented on patch 3 where you try to implement this. IIUC, you're
making excessive assumptions about the use of pwrctrl.

Brian

