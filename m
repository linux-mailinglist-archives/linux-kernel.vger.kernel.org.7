Return-Path: <linux-kernel+bounces-730659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7CBB047CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422907AD208
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC01277C90;
	Mon, 14 Jul 2025 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTR7KAVX"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB669277035
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520441; cv=none; b=uUxODwu4i05HZtcBBSG6mqETN79Yba+0XuNXM1gBvUC0X40JayGL7lX3idY1Aul55tZ8t023JkTdC2AtCUYiZBy4BgE5XsssSY29DW1cwBt3Z2G0WleTVZstSdmAfV/bobYfVscV9w0A3+4YAs+t/yMEV2/cILIv48bUx2IR548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520441; c=relaxed/simple;
	bh=aWSA0NeB2N8SKMfIQkj++0xm9IpdgexztD+pfuz+xao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVmxq7DTxrLNfeokkgPIDc5ajPkYhEZVf3c0E0VHZsso2Gy73gN62y1yR6mdRO+SCl01JyPHTbB/zueOWUykn4dPjuZ4MgnaKSKxaN8yWwsxB2jgR1X1ep2039oCJJFYlw6DDj74Ac0SuNO8HqlxK8xS2ErEVuHdsasTAs2ww0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CTR7KAVX; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40a4bf1ebb7so2367080b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752520438; x=1753125238; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/UVaYjGM1v55Zie9CqXx+YSNagSNn6vwPpEb5of7g80=;
        b=CTR7KAVXBYq0M5GGNfmzNan5xSSN8E0B0EbBALerk57MpZ9azOv3McEftFIg7Ripy/
         tWSje2/eFWDYNYoyiu1y9yJWSbcTOMNw/J5LvbCQ13a6jqbKAXxzyzmw6UMLUE5tf4NG
         Mj/MiujMf/5sM5fFSIhw3Fb1UgS2hX2PmhrGnmRKMosZ5OTSXFCFpml6zID/j5jOzbjV
         a3SEvYnOIhCaaTguLroZBzLaXDEs4NlZL99gKk2c+EycMkIWZz7dFtgoqqzDgkSISwCI
         0zqSoDYfK2BsHzb/zDvylEEaoy2HTqSa7Fph+TYDYCYhat7oN300pZYndJT72GtEAOGk
         aSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752520438; x=1753125238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UVaYjGM1v55Zie9CqXx+YSNagSNn6vwPpEb5of7g80=;
        b=tSqDWeyvw2eaMVaHG/EXunUdUPGxYAPtn8z/EPX0uOg14Lf5W3BXjOcIYck2gc5yv8
         dn1tg2G1mVABsDmzXNhNS+7nxu1CpcfXPZCeP3T06RGPhDY76mdUQxYgEYdXw6OfLNpZ
         ZOF0p8pC6tf28W77z70M1J8ydhne7Kjmg9IUgxwg91H4Nr8pvhZoKj1Ko/faqkorr+7T
         l6YQplBOh59Dcm/SLkDyzoQUC9T0om5pYVSdUzlrObwkrtHd5osPPuQdcgmFhl2jQkrB
         ClZ59q1gFi9DteyCuqxN3cQgGouYS4z3/a7yPXWUVedmKE5cNC4O7jsYuQWwOKSRDjH7
         Skvw==
X-Forwarded-Encrypted: i=1; AJvYcCWbtDLkfK6Ms6ho8tO+ELGWu5XVMZhHZn/3SY13LjNRphySXSEUQH45lHyemUEDFgYdbPmT92/e0kCrEoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlNlFuQ3umyTY8ED7+mW35hrLVL78l7vf1JUK+6PrSvy8ETgDM
	+XaiEDM7qPVGcVDOEYNlyjFj43GnXpXkVW8x+DV9qqzlmUcSyXcIrCeUQu5Ra/n6A6g=
X-Gm-Gg: ASbGncuvY3PJwn/Tq71fC3lrjWb2f2Ruw0pWg0b6jmVm+cQAnPui3iblRs/Fpc8K2+B
	qAg5hd6cRjpgb0PCtwCEkBI0UN58f6hj0D52q5g0zol4Uavmyo7PL5yj85q5sQSLKk5tiboyBn/
	Oiuk8ZqEqr0JPxhoAAFTeEfY5NBwQ7l2jzE90L2FehTZUe3g06Y4tZNtdr7eBo0EPzJR9cBZaJL
	bSHXtFTV+9UIkWFzn0WjHHEAkFdNxnF0x1t0B/lotzgFgaXMZIjzSwlk5d7BL/ykgR+3yMVwOrP
	lOj0xpBqypRw57RpFYXFSnDe8NN6LQzE3pcNW+PgmSADp9onh5GJqzB/M3uPPcuZXUvC7vFI4xU
	646mQ2IdaOuA2yZ/C2611Ck9DlkJW8k0+zFUPV0iL
X-Google-Smtp-Source: AGHT+IFH25xfCXqy4HNmWhH2hdq7v13qGSG5LkuyX6YKupHH2sypWxOCMXdK0skrCkcbTnCc9rgkLQ==
X-Received: by 2002:a05:6808:15a4:b0:40c:5b58:c9f9 with SMTP id 5614622812f47-415393d693bmr10038069b6e.22.1752520437869;
        Mon, 14 Jul 2025 12:13:57 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-414161e2b74sm1622747b6e.0.2025.07.14.12.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:13:57 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:13:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, mchehab@kernel.org,
	sakari.ailus@linux.intel.org, andy@kernel.org,
	gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH 1/2] staging: media: atomisp: return early on
 hmm_bo_device_init() failure
Message-ID: <8372cba0-61da-468d-97b2-85deb8bd4129@suswa.mountain>
References: <20250707140923.58935-1-abdelrahmanfekry375@gmail.com>
 <20250707140923.58935-2-abdelrahmanfekry375@gmail.com>
 <00673c30-8233-417a-9f8b-2ab91381fa4d@kernel.org>
 <CAGn2d8PjT+gE2EH0+YT_-ivfcXBuBM1OxTLEAvy+sFctpc66Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGn2d8PjT+gE2EH0+YT_-ivfcXBuBM1OxTLEAvy+sFctpc66Aw@mail.gmail.com>

On Mon, Jul 07, 2025 at 05:15:20PM +0300, Abdelrahman Fekry wrote:
> Hi Hans.
> On Mon, Jul 7, 2025 at 5:12 PM Hans de Goede <hansg@kernel.org> wrote:
> >
> > Hi Abdelrahman,
> >
> > On 7-Jul-25 16:09, Abdelrahman Fekry wrote:
> > > hmm_init() would continue execution even if hmm_bo_device_init() failed,
> > > potentially leading to bad behaviour when calling hmm_alloc().
> > >
> > > - returns the error immediately if hmm_bo_device_init() fails.
> > >
> > > Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> > > ---
> > >  drivers/staging/media/atomisp/pci/hmm/hmm.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > > index f998b57f90c4..c2ee9d2ec0d5 100644
> > > --- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > > +++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > > @@ -36,6 +36,7 @@ int hmm_init(void)
> > >                                ISP_VM_START, ISP_VM_SIZE);
> > >       if (ret)
> > >               dev_err(atomisp_dev, "hmm_bo_device_init failed.\n");
> > > +             return ret;
> >
> > You need to add { } here otherwise the "return ret;" will
> > always get executed since it is not part of the code block
> > guarded by the if (despite the indentation).
> >
> Yes , sorry for this dumb mistake. I will send v2.
> 

Smatch has a check for this.

~/smatch/smatch_scripts/kchecker drivers/staging/media/atomisp/pci/hmm/hmm.c

regards,
dan carpenter


