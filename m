Return-Path: <linux-kernel+bounces-578345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E6A72E55
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 12:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478BF189E125
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955F211477;
	Thu, 27 Mar 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Vxn96Ruy"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE032101BD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073227; cv=none; b=gN8hdikxBblvb2I/Er4c2i1v+et2dxdhR/TJWkwE4vUzjxPYFRoP5uY7Yzu7vAkZEiK+yPT/MebW2Seiu/xavyL+65sqsejtkWJeiEFXl9HSsRNH3N/Rcavg/MWJ0x5DIyFkTlKQtyFK6lwaHw/GjroVDvRjwZWTHHPOw2ySiy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073227; c=relaxed/simple;
	bh=PYINQnKycbXh8ZEgV82L19kwunYBNxMMAcYZj3hrdYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2WriZKN8T5HRj0dDH+2DG6esU2wcnwSMZxk5CSgZGjR4U072AOEKyeyYXiuOQx5hn+Lsx+4mqBZCNiMoxxkhGq7dQ1VpqQF1o4YTYrY0yrJek4zxi6VanwbYyRTpWdJ9AO7ZFppOTay2IJNv3uieo+MywGCWmpx8Gd+ub9XvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Vxn96Ruy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22409077c06so26626445ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1743073225; x=1743678025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+3oYLEdjTqzY7ue0pi7WI8oniaxoWaW2vaMHk//k+o=;
        b=Vxn96Ruy1IXYHQbfans8tmw+NGXbXMFOMQK01lK+cPN9xW4CkU+3eElOy8XHia1JIZ
         +GA2h5B6P8gTHrJr1A+ropBRKsbN1YJMdvBcqCtfBBQpfOvB7+eu7itHwIphEpGzJLdE
         9jaNQQh7YMHGX65uTY23wC5kWs07Cbx0cmA6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743073225; x=1743678025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+3oYLEdjTqzY7ue0pi7WI8oniaxoWaW2vaMHk//k+o=;
        b=Yr7gUtZzUjVrCaKTrungnzFrMyncCXkESaFkqh4GO4zi5hXjeMZECSDe9At1q2bl/X
         6PWoIR3iCQeQuZpKHsvVN2IGvyHaUZBGF2t1chwmHSIEwtzSwjs8VtpX5gkMYlAlJbVl
         OksV9j55aytDZwZ2iKYaeS0HMrAX+UiVYS4s9Pzp95NQ7WXDRuJQ5ZsGtF1zi7TEXXV7
         +tRvy2HHfizwKN3wZouQeN9hRzDn2r/RcSfT6ZigAoldF0g6l+M5X8zUObfsk8m0MUMP
         DDT/6f5d6KTUgqHgr0E8848BouZGfZaV//3RH/X4meb91zh2sipLZfSqTm5/JGgkhzPR
         dL9w==
X-Forwarded-Encrypted: i=1; AJvYcCVPks4XDFsyRL0+/fUx+FjvxLXZzXUY0TryXTF4j3FVfMldx5ddvLoHuIw0Ml8q9XSWbmNWK6+8h9ny+LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyS13MHCZTYBelzMjjq/gFy9SW27TcFjvajRKhurtP4ToyAja8
	MBJO5gcrEYP52Nk8tYZWIxm5Y8Aoq2HXL5ZvARJVZ0o9Oklbs00MrqMT/QPHuk0=
X-Gm-Gg: ASbGncv1fn6l/H9f/u6iDY/67065IptpwfU8x6saw8WCL/mb6pMZhd7J6J3w3qXgRDR
	rC+x1YKFlyGVD80HBvSKuMrglHr2l7478I/jMqYC+T5c7Y77KKiZim1L1EB9D+5O7+ogi21J+gW
	2F/tRUn3eO56f9X7EpTajyCO+hR6Xvxa2c896FlkEyYYGh1IVe4oufu1b9Busa1zNncQus6DeW6
	sQlHzLCB2Ku7mNtzf9HpYUeaj5D7Wih8vMQ9FTkljuWoIxS/LcH1WAfFfSePTBB5LUkBnMykLjj
	a6HBkUNBQR8Qsd0Fq7vNAf1J3iiLrbYddYJCrbZN2zs4rQVuQg==
X-Google-Smtp-Source: AGHT+IH1gxZZic6MFjUwMzJgoZ8YGYTQsOie+7V5EQMxQWaNdI6WA0iGm3+Xf9x6MiyTN7yeoRlPiQ==
X-Received: by 2002:a05:6a00:1743:b0:736:73ad:365b with SMTP id d2e1a72fcca58-73960e468b0mr3936030b3a.14.1743073225242;
        Thu, 27 Mar 2025 04:00:25 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7390600a5f6sm13932175b3a.82.2025.03.27.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:00:24 -0700 (PDT)
Date: Thu, 27 Mar 2025 12:00:20 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	PCI <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	shivamurthy.shastri@linutronix.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: next-20250324: x86_64: BUG: kernel NULL pointer dereference
 __pci_enable_msi_range
Message-ID: <Z-UvxG4EIeO5zOgU@macbook.local>
References: <CA+G9fYs4-4y=edxddERXQ_fMsW_nUJU+V0bSMHFDL3St7NiLxQ@mail.gmail.com>
 <b6df035d-74b5-4113-84c3-1a0a18a61e78@stanley.mountain>
 <Z-LDdPeTsnBi8gAU@macbook.local>
 <CA+G9fYumyaftJ9FaK+74g5iw-v9RV4qDT-SLg1XGk8G7ub2EXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYumyaftJ9FaK+74g5iw-v9RV4qDT-SLg1XGk8G7ub2EXA@mail.gmail.com>

On Thu, Mar 27, 2025 at 02:10:21PM +0530, Naresh Kamboju wrote:
> On Tue, 25 Mar 2025 at 20:23, Roger Pau Monné <roger.pau@citrix.com> wrote:
> >
> > On Tue, Mar 25, 2025 at 04:56:33PM +0300, Dan Carpenter wrote:
> > > If I had to guess, I'd say that it was related to Fixes: d9f2164238d8
> > > ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag").  I
> > > suspect d->host_data can be NULL.  I could be wrong, but let's add Roger
> > > to the CC list just in case.
> >
> > Indeed, sorry.  There's a patch from Thomas to switch to using
> > pci_msi_domain_supports() for fetching the flag, as there's no
> > guarantee all call contexts will have an associated msi_domain_info:
> 
> Thanks Roger for the clarification.
> LKFT started noticing this issue on the Linus Torvalds master branch from
> March 26, 2025 at git describe: v6.14-1979-g61af143fbea4
> 
> Anders bisected and confirmed that,
>   # first bad commit:
>      [c3164d2e0d181027da8fc94f8179d8607c3d440f]
>      PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag
> 

Hello,

The fix has already been committed to Linux master, commit hash
3ece3e8e5976c49c3f887e5923f998eabd54ff40.

Regards, Roger.

