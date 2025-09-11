Return-Path: <linux-kernel+bounces-812319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF6B5362E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0927D188BAA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076A34DCDB;
	Thu, 11 Sep 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="So7B1T1C"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6B34AAF8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601972; cv=none; b=PeNlNabJ8ik0VLjC9mRCI2ddve8QHHAv5mWqqGsx8VYPIs7F/KJal4vk5ojdsadptEEZa0GCOH6qKWVaWPbrJc4X6xoR3GppxPEB95kx64CtAs4ZIf8z6G74umlv0yple/cqNkq18v/V9mqXkrqfuo9hvmCo2YTvrOVv/9QxfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601972; c=relaxed/simple;
	bh=VKSX47Aju/DzSJYwp5bYidhSzFn8zeiXLyG/eQpEZMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAWkZ9+4Zw4tezHPOISFmQn+K/SbfSVZkknWNmQ+SK2ZJWjYgnbdpzx1J0lOBos7dO52FgRYiFaaGNGeOHt1ngrlebCNWElHbfrr98zblq/TXECHngU9aAF2xr1y09sN6nXA23r26u6MRzpqX2Mk0qRTXrKbOkHYmqYKmrBmL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=So7B1T1C; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e96dc26dfa2so633403276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757601968; x=1758206768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HG5KODUu0GjbUdNiiv9Xwk+9exlrDUpck0LIesxLbE4=;
        b=So7B1T1CKaqLnhHiPP/+1FWFEu/6R4m7Mbj5/xzn1SE6S1xslf7Jhr9oBemetkknbf
         mUV3o0erG1SIkW5Y/MHYT37UHVGW3TE8CRVYfHVeXOwP7SUKwqDjqaF1dYNVNvSWf/UK
         nOtD5PhR0U4xC4G9+92USMeC3V1YD4gVCmT607p+HM1gVGaVv8wXB1lXiJtpLF/8CfrP
         Pu6Ppe0MHyPMWyzVa42Wq2h31rTVK8pl4mAtAiBNaHZ7BGqo3YE54ygZOfTRArfKMoXS
         bKZhZWJqVKRFIpJG4wYe0kGjldN4WcENcRo+No/axwP/KWnYRLnZAC1J/7GbpdJWi7MG
         znvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601968; x=1758206768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HG5KODUu0GjbUdNiiv9Xwk+9exlrDUpck0LIesxLbE4=;
        b=YDxihtFljUnrKe+lIEEHjSbjVmJw8B1zD18WmnluPkyVdeG8dZpcpcvbVUIj9x5QGR
         00JS6ZoqK2DnVQRJIz6ZkTT9x9F0fw6oZyrnnir94U65JxDWbcJmpPg6KuUxzxbIOLuo
         MzvsjHcTtbK6xmiVPTlUQ9ElSTMi7VJIkTS8t2Nh82JlGkCSgHxl5gCmeqv8KxTSbGMP
         asribsiO7R0dSQoEWjYmQ3SAKghJIKkCk2RuE9lZ38YtEhOFGk8srtgm9LoDXCH3dY1l
         NflgzE/ZaJwin9OS5z4UDCKbcfWQV2eFpRNS0LdImws59kevwQ1ugQHs2ZN+QPEvNp0Y
         x6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7y+WJPR/Wh2ki16pjkhYCpkRgjypicAiQ7/rkx9YVoCL5b1b9XZCvrFbFsxLfUG7SCHVNa6AE7caDo+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlBcCKKl412LYune/dHT3AO0gpOnR0KWJ7U4F4GvJDsB+8V2X1
	fjT89EPAbxu0+7dThaDIssWfA+bC4R5615XdzQBsxc0iZ7e7RYwfQJIzNg5fHndpq2WSrEcmEFx
	+n0xrnHaRFpm6UIG5a2cpSh/OdjEwOuiBpPH0EJV4hw==
X-Gm-Gg: ASbGncvYfUkYeg0G9vwP1jCgmM/oict0Ndu/Pl6OKjtSaurgFVMUs4P96+0pxGLEDEM
	Uvk6jAwcM9FMprFPttN/5hwbBmxPRM6BTC4ysxXwpBWj7b6BeGE+klYDmYw/3S3baqyLkU1zah2
	YFVcUxobZNWqezlwg9kimPTVCZ5ZKGo6xJQ7HbF8CmtXr3STCFAy+TxAYhKTeC0JKFegy5eOZDl
	CEiaCCDfDEUvabqms5ZnlgP4HcSXA==
X-Google-Smtp-Source: AGHT+IGA14KLSVMCK2zV6p8As0+Jn95rbWVq+KPV+CqkNJxyiiFOFLcSxRvo/0exdQaaGDHMXMlIe6ixp4mKa1e9IQY=
X-Received: by 2002:a05:6902:1892:b0:ea3:d40a:2563 with SMTP id
 3f1490d57ef6-ea3d40a2737mr1177746276.41.1757601967783; Thu, 11 Sep 2025
 07:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
In-Reply-To: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Sep 2025 16:45:31 +0200
X-Gm-Features: Ac12FXy4zlU7KeT4OFE-vyI1bqh6ZB1528BpXJl_SwXQzUbCOw7DO0NcEvUZLJA
Message-ID: <CAPDyKFqBJQ92HH1tSq1rfbXV1OwbyvgChyHfv7ykJqf2A6qYpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] pmdomain: core: Introduce device_set/get_out_band_wakeup
 and use it in usb
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 05:33, Peng Fan <peng.fan@nxp.com> wrote:
>
> This is pick up of [1] which does not have response in about 5 months.

Sorry, I have planned to have a look at this, but just never got to it.

> This V2 patchset
> - includes usb driver changes(patch 2,3) to give people a full picture on how it is used.
> - Rebased next-20250729 to resolve conflicts
>
> To i.MX95, USB2 and USB3 are in HSIOMIX, but there is always on logic
> to make USB2 and USB3 has wakeup capability when HSIOMIX power domain
> is in off state. Otherwise the HSIOMIX will be kept on when
> USB2 and USB3 are configured to be wakeup source and Linux suspended.
> With this patchset, HSIOMIX could be powered off and Linux could still
> be woke up by USB hotplug event.
>
> Patch 1 introduces device_set/get_out_band_wakeup
> Patch 2 and 3 are drivers changes to use device_set_out_band_wakeup
>
> [1]https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/
>
> More old discussions:
> https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Overall I think the series looks nice, but I will make some more
thinking of this in the next few days and come back with some proper
comments, at latest in the middle of next week.

Kind regards
Uffe

> ---
> Changes in v3:
> - Add a new patch from Xu Yang to detach power domain for ci hdrc
> - Add A-b for patch 4
> - Link to v2: https://lore.kernel.org/r/20250801-pm-v2-0-97c8fb2a433c@nxp.com
>
> ---
> Peng Fan (3):
>       pmdomain: core: Introduce device_set/get_out_band_wakeup()
>       usb: chipidea: ci_hdrc_imx: Set out of band wakeup for i.MX95
>       usb: dwc3: imx8mp: Set out of band wakeup for i.MX95
>
> Xu Yang (1):
>       usb: chipidea: core: detach power domain for ci_hdrc platform device
>
>  drivers/pmdomain/core.c            |  6 ++++--
>  drivers/usb/chipidea/ci_hdrc_imx.c |  8 ++++++++
>  drivers/usb/chipidea/core.c        |  3 +++
>  drivers/usb/dwc3/dwc3-imx8mp.c     |  4 ++++
>  include/linux/pm.h                 |  1 +
>  include/linux/pm_wakeup.h          | 17 +++++++++++++++++
>  include/linux/usb/chipidea.h       |  1 +
>  7 files changed, 38 insertions(+), 2 deletions(-)
> ---
> base-commit: 1b09efec32046a9c78cfecc46a26b1b139a3e8a8
> change-id: 20250729-pm-243ff7097e44
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>

