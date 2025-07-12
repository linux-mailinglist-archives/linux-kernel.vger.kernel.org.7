Return-Path: <linux-kernel+bounces-728453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2895B02859
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FCF1C25B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492A32F43;
	Sat, 12 Jul 2025 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nHeaM7ke"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB339ACC
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280700; cv=none; b=LOamcFWLRlcQaafL7FDTP8PhdgRLRTR1ha9gnZ+4z1cmtJlYzoQcypNpcpRxElj1YmFYUtptdPjjCtHaMmu0XMFDTMSKqwd0ysEMt0uEGDzLG/dztxkg+rPaEHOeJksex3+OYQZzhAs4l2IOcSsGZX1J9R1aPrpXDLP7bw6bsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280700; c=relaxed/simple;
	bh=UkFyYdb6Iv006IVH2XSxgBssHRSlceqPI9zmw0qg5XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHHYsGaYYwjohs+bO3xiz4qmglgAPFgsf/xV7gEwNJ+1pd/QyvqNdEkegUoPsNG1hyG0uhexLJ15Ue5KF5Xx1xXUf07sOCVgrt5U3BUzqRP3uwdDgdkA1J7XKNBRWcPBjZAniyrR4j2k2i3Enl/716UZj7U5omLqqEfK6SHNNFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nHeaM7ke; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-749068b9b63so1866551b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752280698; x=1752885498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai5C0aZGzWah4ZFBuTYCZpMrf26VMhYKg7WxsS6cFuk=;
        b=nHeaM7keph5DJFO6L1PCa0jjZlgXQPER8qH55smAi+V0Y98ncyo45swyReedMZkVG6
         OBRgXUiQMnl0XXzWCMb52ldxIRAfBSy+55pCMFO+AMOHcYwUVUPROYN9ikXNOmoAHJm8
         9BxDlsGL+ZiiJ9TXJSFlxzDvvwDJ5/BcGWsJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752280698; x=1752885498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai5C0aZGzWah4ZFBuTYCZpMrf26VMhYKg7WxsS6cFuk=;
        b=iostTUNiNjHFOPABUmaTxXGn2FXSUqhwXYgpvK2rAsrZjVSxwJGzvuuM3uIVLCCeEQ
         onQ4Q7oY4uLshS5t6Ob6EvfdrCCcB0gCrpXAu3dMjYIMfZTGDJTWSuiufluZV57Eal7m
         8hZPQY6tPa9WvrQpM1yvfARk9/NlFK+51w3aK6n00lSscd0R9lFIrOtVWQpHkA4S0lf6
         1ohA3YxpYmUfiiBQKxT2ESvwugJBxBNhekY4kPpjkzxpO4HnzSIQtmMU1L/fjpdiQbH4
         0GQ0sk0xv5h9OCFHbpj7gu+NyLBUdw1AtK6ROfSRh8mykAqo+IXlHb+II7EDPPSlHixa
         8zIA==
X-Forwarded-Encrypted: i=1; AJvYcCVsqa1uRy8lh7u9Pc1zg/cR+TkH8Hh89cWPBGMJyZXeS8kjQRoyq+C6Xun6pZjQDR0SGdfiCUD9af5UOtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/ylNiusyPhyHSyjlwcBfsLKjNCMLUwCCUIimEFg+c4bPbyNA
	Z7CtUJ5/v2HhGkr7SV18e+pSmPF+73HtyaZ0ZJ7BYb728SXU6lZODFhf+pGqeqMmMg==
X-Gm-Gg: ASbGncu+v6+Sk2NZ8EigWqKn8fj86/kBbsP1r4h1He8AfdKaEMOse+oeBYqL6I2CofQ
	/YmI0sYISoVRk9cdMDq2ZALn7G219KPWNnnjYaiPnBlltNEJJ2CJ26aLSSzn3IFzaMbf2XfQvJP
	AWB1WD5MQjMrTUbkQrYHw2kaljlTcUIzMxqA4ce+uBqmFazjYvvgefFxn2ngrn6/8QO2UFlrZcg
	beKiDoWEk8zQxS7144CwpTvoe6Tlfut9i95bDEMjq8a9pczbJCSZIe1PQ+xpiapgg5VMW9URWpK
	Gh7iQJdhDcJ/l6x4S5Hh9hDl09hpSL5xQhibnCoiHwoy/qWIUdlUW4xHbKtrgEQZXkKDRenXH6N
	Si2UBhHvVOVheCBhvUMx9lCCUKucUw8JEGxxSBjFWHYz4bBO43cZsuLBnU8Wc
X-Google-Smtp-Source: AGHT+IH7cTn36pVPXMTL1GrAJZlMQg6zx4a7aTWAnpBBYd+bO+7yRb9iKsSRX8MmnkAtmBgMMU/W8g==
X-Received: by 2002:a05:6a21:ae09:b0:232:36e3:9a4e with SMTP id adf61e73a8af0-23236e39bc8mr2668926637.40.1752280698443;
        Fri, 11 Jul 2025 17:38:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2386:8bd3:333b:b774])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f8bd3bsm6429988b3a.149.2025.07.11.17.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 17:38:17 -0700 (PDT)
Date: Fri, 11 Jul 2025 17:38:16 -0700
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
Message-ID: <aHGueAD70abjw8D_@google.com>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>

Sorry for so many individual reviews, but I've passed over this a few
times and had new questions/comments several times:

On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> PERST# is an (optional) auxiliary signal provided by the PCIe host to
> components for signalling 'Fundamental Reset' as per the PCIe spec r6.0,
> sec 6.6.1.

>  void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
>  {
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dev->parent);
> +	int devfn;
> +
>  	pwrctrl->dev = dev;
>  	INIT_WORK(&pwrctrl->work, rescan_work_func);
> +
> +	if (!host_bridge->perst)
> +		return;
> +
> +	devfn = of_pci_get_devfn(dev_of_node(dev));
> +	if (devfn >= 0 && host_bridge->perst[PCI_SLOT(devfn)])

This seems to imply a 1:1 correlation between slots and pwrctrl devices,
almost as if you expect everyone is using drivers/pci/pwrctrl/slot.c.
But there is also endpoint-specific pwrctrl support, and there's quite
a bit of flexibility around what these hierarchies can look like.

How do you account for that?

For example, couldn't you have both a "port" and an "endpoint" pwrctrl? Would
they both grab the same PERST# GPIO here? And might that incur excessive
resets, possibly even clobbering each other?

Or what if multiple slots are governed by a single GPIO? Do you expect
the bridge perst[] array to contain redundant GPIOs?

Brian

> +		pwrctrl->perst = host_bridge->perst[PCI_SLOT(devfn)];
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);

