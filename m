Return-Path: <linux-kernel+bounces-832774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C7BA047E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520F17BB03A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB222E229E;
	Thu, 25 Sep 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jh7rPgUO"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1442E0922
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813934; cv=none; b=gEqg+9K8GEKAuupRzSKS3dCQxmF2gJ4HLsPktoMB2qJ0HWjN8azdh0qElha/8XpzYXlUKEiO3F5aWaWlakXTOxcUABT8hJhb1NXC8MJF8atEwIpaM2ASnE6OuWKYNyystbM2x1YhdaCg1BjKFK1D/qJngIHSfnrQCN8geeoZHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813934; c=relaxed/simple;
	bh=Sfnu02sWQqqJf145CrIFLmP+gKZbUM6UT9GMZg+gyLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ9Dr8/5eUlgGuYQMiOnw07yrgOrx9Fd6eLTua0LpulwIPxEZsRm2uyU2zNcVpSMvHPTwvSNrRX7lgJ4id27Ck85J05M+JWLA9psxpZ+Q12Nu7kmeZUaUxp6vG/C1E/aPqE5/UM1oBWK/fExflJhj6xnFcwzuMlTQ3ud1hLqPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jh7rPgUO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27ee41e074dso4497985ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758813932; x=1759418732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfAVQsJMCa+08II6sZx8nLAvAG7+m2m1wBLI5CKcaxE=;
        b=jh7rPgUOlXeCa8LZlCgifXnIrDWM7wHLotwLy81jP4GAN7rF0YCOvrvtjyp6gwYJzC
         C8QxIyaI3/jitsbR1IkCKO1BxA06m6ylQb5EAYtM/kGnkTf/dKU/d35R+B939ugfn6mT
         hyyXTVcpk3BRv0mkZqLh7aCqZko1Mf4LdEzHu+oQ09nVPkaSZqQeaXCwQ/lyOBAWfWFa
         /4ppII+2vZjpJCu18DDMasG05CI7xbq0FYXYtTCSp/8EiQlvyYLRNQw/cZvwTpbAyZux
         WScC49PNIgwSdz5Kem/Ouc6f++LaZTFHXwmN5HclD7lyxZx2STfdcRUgoanB6e1NJmpY
         iUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813932; x=1759418732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfAVQsJMCa+08II6sZx8nLAvAG7+m2m1wBLI5CKcaxE=;
        b=ccHLhOJJlvhVI08uGrvhgeDKBubcqmcVv6FqPbYFIMjFcl7e143AkBuRkK1TCzNrDR
         /N1I2PnXnZ5sUN81wE7RiEE8i4+rXZ5RKJ2cxCc76wOz458CMxot/xz57JXsPEIpBTPd
         9jfDTF0VDVJcFdwHWs7TteKtxd6zjQH8/jC7KfESaELdXeVyHanRoYvyWt5qMMS7+IWF
         /NUPBTtNvyWVCdvIvT/yzZGBwMPTENSi6ZXedNU1qaVWsSKr+fQvPg2KRSHY7SWa9qvI
         Q7iyJizVPQthiRN3Om6IiJAdCMXfHoyABTcONYXxkuxduyf8NRl//8weKshrML/ZspZ4
         50xg==
X-Forwarded-Encrypted: i=1; AJvYcCU9qqbEwB+4CkU18Zbt1plC8PnUnzJn8rwXxX3t26fMi0SM6U+xZJa4vQlT4E221DUWh/PwMYtEb7xqKao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSp4S6UBRAcnL4dw4yoq3KXQ/K+M2ND1l4z4ayRABsfrPcVcCs
	2rsrQVrW4LEUSyk344kqJccig9/03orJWeOEgTa3p/5/8LV0ANrXGRn9SOIm2iWj9NY=
X-Gm-Gg: ASbGnct/O20vccmYj1WGOuGN5KGzFUpxRiLhdmJPv+yCOC4SZTo8QsQlUGfcEJlTaRL
	xyKrHC2+WWlm8V9HN9n9UT3zXvhAZPHkQDWkqzBKeHsGZHwnEzQqr2e8/kiXgifk5528Hi/PWsn
	dqoZTzPNinjR4ddsYs40t3m90uEvUwX3alRo3XAe3bV3rwZcTPa1yh6DsQP5Ev0W79BTdH9EmDV
	8aN1hL+tF+GbpL+s8vcfSKTNriyyBt7pj4HgsZblkYah0gweNdSlhxmigCsIWM5TxhPMvsugHYP
	DBuappV32LVlmUxY62tM3hmICd+vwM2xcbDrnpS9UvrGujrp57ZeR0L2LOdaTmwy+NeLJdLbQPe
	cVy8eFsRv93SpUS6SnHWOBwVxQZUTqHpol6UbLALCs0fQkA5gxpj2/9d8l32ZW+elJMb1K3Z2QX
	UQFMOHwM9BkxzaEwwZ8IyRqeg=
X-Google-Smtp-Source: AGHT+IFaUWm0IMFuhwxwZ6ZVuoRzGDUplyarDIAkk4+v9ajtIq9wSLIjRgUT3UbBtMTnindWS3TDDQ==
X-Received: by 2002:a17:903:19ef:b0:274:3db8:e755 with SMTP id d9443c01a7336-27ed4a7ec49mr43070925ad.30.1758813931703;
        Thu, 25 Sep 2025 08:25:31 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:491a:5e5:2a2d:1b96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d37casm28336435ad.8.2025.09.25.08.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:25:31 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:25:28 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 0/6] remoteproc: imx_rproc: Use device managed API to
 clean up the driver
Message-ID: <aNVe6MG2HiWNJZQP@p14s>
References: <20250923-imx_rproc_c2-v2-0-d31c437507e5@nxp.com>
 <20250924164650.GA2711@nxa18884-linux.ap.freescale.net>
 <CANLsYkzWQEWKM-_iff7wY-sk_OERFiAMSrXP6Cyf8vJfXqunjg@mail.gmail.com>
 <20250924203115.GB2711@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924203115.GB2711@nxa18884-linux.ap.freescale.net>

On Thu, Sep 25, 2025 at 04:31:15AM +0800, Peng Fan wrote:
> On Wed, Sep 24, 2025 at 11:10:33AM -0600, Mathieu Poirier wrote:
> >On Wed, 24 Sept 2025 at 09:35, Peng Fan <peng.fan@oss.nxp.com> wrote:
> >>
> ...
> >> Sorry for early ping - I just wanted to check if there's any chance for this
> >> patchset to be included in 6.18, along with the other cleanup patchset [1].
> >
> >It seems very unlikely.  I am currently looking into how the PM
> >runtime framework behaves to address my own questions about this patch
> >[1].  Furthermore, I am worried about the usage of the device
> >management framework when it comes to freeing memory.  I will get back
> >to you with comments on that front when I know we are doing the right
> >thing with the PM runtime framework.
> 
> I see. Not sure Ulf could help clarify or review, then you might take less
> time.
>

It is fortunate that time was taken to understand the problem and fix it
correctly.  Otherwise we'd still have a problem and more patches, possibly
wrong as well, would have been needed.
 
> >
> >I dropped the 3rd cleanup patchset.  More than once I asked you to
> >submit only one patchset at a time and you still refuse to take notice
> >of my request.
> 
> I apologize - I now recall your earlier request to hold off on submitting
> further patches until the table_sz clearing patch was clarified. I
> misunderstood and appreciate your patience.
> 
> Could you please clarify whether there's a general rule in remoteproc that
> developers should only have one patchset or patch under review at a time? If
> so, would it be possible to document this guideline in the kernel documentation?
> That would help avoid confusion for contributors.
>

Most people tend to address one problem at a time, especially when subsequent
patchsets have dependencies on the previous ones.  I'm not sure there is a need
to document something like that.
 
> I ask because I have other patches queued that are independent of the current
> series, such as:
>  - Reintroducing the table_sz clearing
>  - Misc cleanup in remoteproc core

I'm fine with those, as long as you address just one proble at any given time.

> 
> I understand you may be busy and have limited bandwidth. Would it be feasible
> to offload part of the review work to Bjorn? I rarely see Bjorn reviewing i.MX
> patches. Alternatively, could we consider bringing in a third maintainer to
> help accelerate the review process?
>

How fast do you want to go?  By and large, I reply to patchsets within a week,
sometimes two when things are busy.  And when I can't meet those standards, I
send out an email to the mailing list with the review order of the patches in
my queue.  What else are you expecting?

Bjorn is maintaining over a dozen subsystems - I stepped forward to maintain
remoteproc/rpmsg to help with the volume.

 
> Thanks again for your time and guidance.
> 
> Thanks,
> Peng
> 
> >
> >Mathieu
> >
> >[1]. "remoteproc: imx_rproc: Fix runtime PM cleanup order and error handling"
> >
> >>
> >> Both patchsets have received Reviewed-by tags, have been tested, and
> >> successfully passed builds (arm64 gcc) with each patch applied incrementally.
> >>
> >> [1] https://lore.kernel.org/linux-remoteproc/20250920-imx_rproc_c2-v2-0-3351c4c96df5@nxp.com/T/#ma16bb8a38300f6eb333ee04f00d57805aee3c114
> >>
> >> Thanks
> >> Peng
> >>
> >> >
> >> > drivers/remoteproc/imx_rproc.c | 128 ++++++++++++++++++-----------------------
> >> > 1 file changed, 57 insertions(+), 71 deletions(-)
> >> >---
> >> >base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
> >> >change-id: 20250916-imx_rproc_c2-2b9ad7882f4d
> >> >
> >> >Best regards,
> >> >--
> >> >Peng Fan <peng.fan@nxp.com>
> >> >
> >

