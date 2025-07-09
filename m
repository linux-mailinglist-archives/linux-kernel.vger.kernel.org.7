Return-Path: <linux-kernel+bounces-722707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05F7AFDE04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BF15625DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AF72613;
	Wed,  9 Jul 2025 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LZKS7cgl"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5D35897
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030944; cv=none; b=uHmoEqi0BSRRHOo2crKtZ0V6AAKaHLHNKGCmOwUbqEKb+WhH3ebAxpGFwfyBcn4UigaNhT9jNN8mTpNily4eIjyriZhvlY+qs3+kKDbieOlprrgjk10HoqWdOre1fC//luL6BFAiThO0RZgIa5mfkzVRjjh/U4VCg0F2PUc1vOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030944; c=relaxed/simple;
	bh=aNeDzIXQhqcdG04TNSugRMdSVq8zXoX2GXlhihdlsNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVL9pdb+dfIAWuWFnW/Hrzo4qUaFfzdzuXf6FYJhZOwf9bBj/VzcfQw6z6t3b7844w6d5qElGeKbgJBXPqZLdOpa4A8pGSZwyWjD9k+Ga3N9HxynbBIgIFT6xvUPqyCJ7LzXi6Xvwo8xS8bdkXH6KscBNZqO+XLBbwQcbMCgVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LZKS7cgl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2763907b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 20:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752030942; x=1752635742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GnIvUvHcXYxKur3IY8TNR+7Jn3H/WOdcBI69S+hJek=;
        b=LZKS7cglVilgS2BvgZJtgaPVrTwE5NsdRRURZhbvIAEHP+aHsaPKz42Pbn6PRr10hV
         t73hEGuePDiIOU0N+KDvXZ7FEBNe8KMJczEBTu3RtKE10WlwS3art1ESNv7Y9FxnOaLU
         YuPjOkkbmE4v1adCDUBmUC82cHBdGHJQgnGl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752030942; x=1752635742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GnIvUvHcXYxKur3IY8TNR+7Jn3H/WOdcBI69S+hJek=;
        b=IxH7hGwa7rABxmnY1ZpJT1Y5xvXX/TVFfBQRpy94k4DEcljWm9lddfv5OX1ngM6NYG
         m+0WaQKlCLMiIoMQFFtm3LUN2ZBJ/hOaeDxgaIvaBDnR0QZF2juuW6oVs3DOogcgM5Wo
         2nVDWiL78eAzWVWrcQG+puD/PdLxLyJP8XVkk4SnJ/hGlqlBiN0WTL/9nESYU/+K9+Q3
         5ZiKMZjbiefwKcSgGxT8httcPvDQigvRZEdStef7smUPkvfngIE9cqnqIsGII2hGS8iw
         d2jxIoVQAc/53iymjVKsHH2GO/qveDN9hbdYAWMVCxKSZ20tKXc32TC06tigliHYc0KK
         tO1g==
X-Forwarded-Encrypted: i=1; AJvYcCUHhnCFy2uv7qHARxYkypHLbxNLY0LnbrivLL3o+yZmO/2PY14qI/fScQXxcGgM+9qgW+41Us+r8la2vqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8BfV7yDhMnSGDu6gl2mmmAYBVq4VFzS6tjcDCftQ5ehH+5xT2
	lUp+TqiqiZW6SE5z/kcOET8tSJmnneVrudj9Tjm2gxBieNmGA4pjkrGJraWTFbE5PQ==
X-Gm-Gg: ASbGncunX30IQJp1a4bFi5y5F91oWyWSGmwfzTHY3b4cQf3NcGl03loDNefZlEve/0y
	NxjVur4xaqNNgBb0knVK6jtaxnASwQwDUKjVUQIFdD8JzCXzi0Pxv1idGjNJNJ+kbOcc+T18RQD
	HQNzLzKKqP5w7rkgJ0cp5m94a4Qdot/UcJRXqD2/j4XPSn8o0fKRP9crfr57jS/z5MCN3cqtZ0C
	P3ah+WVLxngh5PTw/P9op1hxn6IOZvc5C6CheI28siRa8oILbkVCF/8p8we7tQQT6EKtGSJkmG4
	K4D2vMFokKJ3m4UXelFXIeKQB7/Wha4wyiShbRWXW4L8CzzKcSTeeJDQcZwNIR+IEwgrDPS+rwx
	rkvJZxWvaHDy1d9FCkkj4PZzVOFLtXEgSJBQ=
X-Google-Smtp-Source: AGHT+IF1IFBUq+Vel6guXYxM+TJKgbZ/8d6R08Gbz0ZBjIlhPPomcVT1urw9RBD+q+rcrCl+MmPq8A==
X-Received: by 2002:a05:6a00:139a:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74ea60b5ffbmr1559833b3a.0.1752030942102;
        Tue, 08 Jul 2025 20:15:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9b88:4872:11ac:8ccb])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce4299c3dsm13178481b3a.116.2025.07.08.20.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 20:15:41 -0700 (PDT)
Date: Tue, 8 Jul 2025 20:15:39 -0700
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
Message-ID: <aG3e26yjO4I1WSnG@google.com>
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

Hi Manivannan,

On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> PERST# is an (optional) auxiliary signal provided by the PCIe host to
> components for signalling 'Fundamental Reset' as per the PCIe spec r6.0,
> sec 6.6.1.
> 
> If PERST# is available, it's state will be toggled during the component
> power-up and power-down scenarios as per the PCI Express Card
> Electromechanical Spec v4.0, sec 2.2.
> 
> Historically, the PCIe controller drivers were directly controlling the
> PERST# signal together with the power supplies. But with the advent of the
> pwrctrl framework, the power supply control is now moved to the pwrctrl,
> but controller drivers still ended up toggling the PERST# signal.

[reflowed:]
> This only happens on Qcom platforms where pwrctrl framework is being
> used.

What do you mean by this sentence? That this problem only occurs on Qcom
platforms? (I believe that's false.) Or that the problem doesn't occur
if the platform is not using pwrctrl? (i.e., it maintained power in some
other way, before the controller driver gets involved. I believe this
variation is correct.)

> But
> nevertheseless, it is wrong to toggle PERST# (especially deassert) without
> controlling the power supplies.
> 
> So allow the pwrctrl core to control the PERST# GPIO is available. The

s/is/if/

?

> controller drivers still need to parse them and populate the
> 'host_bridge->perst' GPIO descriptor array based on the available slots.
> Unfortunately, we cannot just move the PERST# handling from controller
> drivers as most of the controller drivers need to assert PERST# during the
> controller initialization.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/pwrctrl/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-pwrctrl.h |  2 ++
>  include/linux/pci.h         |  2 ++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..abdb46399a96c8281916f971329d5460fcff3f6e 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c

>  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>  			      void *data)
>  {
> @@ -56,11 +61,42 @@ static void rescan_work_func(struct work_struct *work)
>   */
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
> +		pwrctrl->perst = host_bridge->perst[PCI_SLOT(devfn)];

It seems a little suspect that we trust the device tree slot
specification to not overflow the perst[] array. I think we can
reasonably mitigate that in the controller driver (so, patch 3 in this
series), but I want to call that out, in case there's something we can
do here too.

>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
>  
> +static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
> +{
> +	/* Bail out early to avoid the delay if PERST# is not available */
> +	if (!pwrctrl->perst)
> +		return;
> +
> +	msleep(PCIE_T_PVPERL_MS);
> +	gpiod_set_value_cansleep(pwrctrl->perst, 0);

What if PERST# was already deasserted? On one hand, we're wasting time
here if so. On the other, you're not accomplishing your spec-compliance
goal if it was.

> +	/*
> +	 * FIXME: The following delay is only required for downstream ports not
> +	 * supporting link speed greater than 5.0 GT/s.
> +	 */
> +	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);

Should this be PCIE_RESET_CONFIG_DEVICE_WAIT_MS or PCIE_T_RRS_READY_MS?
Or are those describing the same thing? It seems like they were added
within a month or two of each other, so maybe they're just duplicates.

BTW, I see you have a FIXME here, but anyway, I wonder if both of the
msleep() delays in this function will need some kind of override (e.g.,
via Device Tree), since there's room for implementation or form factor
differences, if I'm reading the spec correctly. Maybe that's a question
for another time, with actual proof / use case.

> +}
> +

Brian

