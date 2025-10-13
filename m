Return-Path: <linux-kernel+bounces-850403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B77BD2B57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A2A189CB00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AA8266595;
	Mon, 13 Oct 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2YLj55d"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42204C85
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353392; cv=none; b=m065QR288Wv9P8gIUfDfZcu4xTGlDDf6lnAC7fJ0xx8XXOmGpuovR6t89qVT3ltbSs9mJeYyYViUWPSbuHwUo00Db+0yExnOkNe/RlPph/d0rO6ENw2DIsSKng7G2yfqHGb1mAjQxPj8f9dBmUEJldCwwOMxnVrdf7nDTGpOP9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353392; c=relaxed/simple;
	bh=MEZMPp0/6x2Hj8xdnea+WEkAGujy3+yoVNtutOdRFkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHPRUIIEKeExOiq2aBN9lWsP/VESM8IEMmcGnzbBiJ/+faWlxO8MF1eyMwvfHWclr89T+QpRRgj2pFwDAFRZmxVf7f339DHpCkgAe02Fm+mIfBMVFqdwS/L6V/Qh5ML0rlMSpxuoEnWr39WzQ2R6NE6qvXLipr4fKQ5RU/Qqvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2YLj55d; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso30530945e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760353388; x=1760958188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R36zhEWTXjAMC9qqqcZ2hDhZQoe9rT+tHqvTTsomPIU=;
        b=A2YLj55deF4TCBKe9p+vmHUs9alL8vckEeQFVT97fPO0Li4GRwjp7Z/oVIzHk2pEIQ
         8WwL8ORHPmsvK2Rk1ahTuZvBhByztboY8eRIQbRmVTz/YZVTY0fnvbmOZA9s8+mYTida
         U4HAAzZulll9iE7wsno1mcdXMwccKSPMAs87pcFuwH2hNVronw1szVc01GvoCgmF0WEh
         BKV6S8SA75eRKJgRkHg8vkWALxn4RNHAMx0quTRRQcvoE8u2VwN1hXCBppvqG9mzsyZK
         qUGYWcac9jInSCy7N4EsUTrP+mXXGom41yb76EctGXm5T5wxkX/+Md3se9BHrZP+AELI
         vcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760353388; x=1760958188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R36zhEWTXjAMC9qqqcZ2hDhZQoe9rT+tHqvTTsomPIU=;
        b=v9z7aEK51sxqWQRyeAADTex8mGeS8GXvbGXvOMVc9fKC4Jo8rfTiGlxum63J23zP8n
         sQD/D19DPVqTZ3tveqV767y5D92kWHROL+ks1V2okz0ozK7AF9xM5wtvSUovkSmDcDq8
         EooYagrfYcPt/e+siVl/h4DR2rbrAzsA5heUkoyYHavhIBx9wNBFRabmTeKpC14H96Dv
         j1QzW4xqEKTO9dHWC4hBizufMCtSud+BcyltASs+CQ/SXzoKjgZzgNiK2uP0o0SmmHog
         e+li518cxJ5/Cn9KVrCDhExuzdpwy1ewaXn2Gu9lBVtYnIJC2aTm52+3Jnz80aBZWtau
         lzsA==
X-Forwarded-Encrypted: i=1; AJvYcCVhi9AZ6o5aXH3iSlNlvfSnx6LoI4QMvYaGPkBydMDxnxnCDtWiO3tTebBw9zfNBaafOAwFXicmW1uu5wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxnxEP4K/hvJgF99oC60u98wDiNJFeOyfp7RW6ilEbTnS2pVN
	tjueu0E+kMewtRaH3LEFTc7Os47kI/gQNA91YinNopD0/0TyZf/sumXi
X-Gm-Gg: ASbGncvRdIXANryPkb+NISZMSHVc42pBTse5YEyyWqJcMsisxofcxqExhf18yLFPlM/
	StNgQQy55IVRqmb9cwGPFC08mASxgkAkBztDAMpeQPN/gITB/aINjd3N0FUkhLopDPBWXuVKrdf
	7DEUpKxBGXPjsxTYnEkv2AFweUWXF4hOvh99xRl7DiPAVZkj+BQNBtiHTdeAOaGupJNnK0QhINR
	4RdTgYpbgmG2WC2kehT5M6kcRkTlVsddaMauKjhO5AkHmpiF5JUzZ/FpVH2nxr3XXlGfOkeNzim
	QpgjaE+cBT8d7G6/x0VwoBDJvfRVmDa6wZqV/W0wBwX+FKsWKif95M3yS/Fgkx764ThWF+BbH2n
	z52BjdtLR8FOdNRwyTu6TbxGvx3T0YpbKNiwEmZ2w3WNZTHgr1xYAaqbh158h6HvA
X-Google-Smtp-Source: AGHT+IHJe9CvuwCz6Q5PoEQTTbl6WyMaH7Au5Vw7APlwtIacyj2OmqpNIAkZPtVvi18U13DZly66uA==
X-Received: by 2002:a05:600c:3e1a:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-46fa9af9842mr127699785e9.20.1760353387911;
        Mon, 13 Oct 2025 04:03:07 -0700 (PDT)
Received: from gmail.com ([51.154.249.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4f3b07sm127656955e9.2.2025.10.13.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:03:07 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:03:06 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Michael =?utf-8?B?QsO8c2No?= <mb@bues.ch>,
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver: gpio-bt8xx: use generic PCI PM
Message-ID: <aOzcasDutRtw6JP9@gmail.com>
References: <20251010105338.664564-1-vaibhavgupta40@gmail.com>
 <202510110924.dUQeeRV6-lkp@intel.com>
 <20251011122612.4fa7c97a@barney>
 <aOpAO7j0Uyo6FPcu@gmail.com>
 <CAMRc=Me2ABQUXVeHyfsDR-etyT9mdX-kqxfQDnh3msfZiS6ccQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me2ABQUXVeHyfsDR-etyT9mdX-kqxfQDnh3msfZiS6ccQ@mail.gmail.com>

On Mon, Oct 13, 2025 at 11:41:43AM +0200, Bartosz Golaszewski wrote:
> On Sat, Oct 11, 2025 at 1:32 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> >
> >
> > Hello Michael,
> >
> > Ah yes, this macro somehow got overlooked by me. I will send a v2.
> > Thanks for the review!
> >
> > Regards,
> > Vaibhav
> 
> While at it: the subject should be: "gpio: bt8xx: ..."
> 
> Bart

Done in v4.

Vaibhav

