Return-Path: <linux-kernel+bounces-890946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1436C416F5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E462349F15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9C3009EC;
	Fri,  7 Nov 2025 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGWEYpme"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A42ECE9D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543636; cv=none; b=isZ+6G/bHkYhZL1aWwBNrgizUHJnHN/JtELjm0nOGSiLo1l4fO749/CYSmB4+n5PJ8UANSFmP3VzpVkyauYKpgLNcDIMlseJ3G2E3agTGr/zsyQcRdJ88QO7yEdhbNrTSYgxMN81MU6/wf1kQxgA0S0BFaYiko7p5RyGGP3KUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543636; c=relaxed/simple;
	bh=+uAue8VHRfE5bDhEEpaOZp67/N7yEWNDOOmylvy8lLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bt4pyx1XtJsbIxuUfNWP3OD3KHZg0yM/P2gntWEWj0gjWmw1E50VkMUf+yylxPLN3wj3OlBjkr0zDsDxFbdODKQjh/OvD60xzHDHNHLMBzhZmwYW4/tvWcTjTK8iTAhZhB236W3f5TJ5fgepLuBRPRK7DLdmfSqDTGFnnMWiODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGWEYpme; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7869dee42cdso13163257b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762543634; x=1763148434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdkaJh3hOfI8XOdwUl8MBmH4/W03UBCDbQt0lHkUPho=;
        b=WGWEYpmeoXuAZteZ8b/au6G9jguPOKrEJNNUynZMe0KRNmO6jU4C7FemqqMcA120wu
         89XkAGh35E6CgkjzPFWLsfHBtfkdzMGD4l7K3bI7vO7/f0ZgCOSgvFadOwfbRHDnUbkX
         sI96KOnAXawHRrychYZtKkQcqWSOT3fpllmBzMPsY/m+3IBin6YocTi8y38ioOaHqG20
         iwoAX1kSzXu6o+fESfrQjH64vG8wZXxEPH2IFuV0VTmX0we4b42Zm8qzyqhcz9g8VkNn
         H5/MBtGbFn/4iagZGMO936jSoGvwIL5ETOn5s2+Ie9NdiQ5LkaO59vKcaol/+gncttOa
         iPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543634; x=1763148434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VdkaJh3hOfI8XOdwUl8MBmH4/W03UBCDbQt0lHkUPho=;
        b=QY98+X5LIgn3KOQ/RM1/0FI4Ibt0MxZwwxuvCwcMRC166+folc9c23x6cBtsKbvONZ
         pVuxkFAT65Xggw5Y4yClNMA7sYCeb1itcgXiu34YzM0K+EAGGGJiGmV0XeH1Li0u4GjI
         wmNynaefUAonkqtWykDZ73b6PYNrbN16HnLdyzdcjDuzceSVXeqdZVt6J4cpuQz0iva7
         IcoYiGEpwYrwfrmsJqIlm0BKaTpq9am6387XVKDpfZ8fQCnRCs7tZnK5rmwqT1BNWBbt
         Qe5JB4+58jqQZcOdFXjFLQt0/bigZXM5KbZfJn8eJWkpu9nVCEXEG2CiqZvidckaYB5b
         kRpg==
X-Forwarded-Encrypted: i=1; AJvYcCXfh6051rJlOym1v6BZ5tFTJyFtAAZ+78E316r2fSkWoFz9x01/sWe9DqqAdCi9VSHri6dixkWZNguHX6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYPr8j7asLINIg+q85f78z7blyNX9QUWFPjguPW+ELH27WZj+
	K0oFEYEWHT0d/0GbNr2Jshslp6mQmN8xuNNyRcaBU4U4ukGM2AXggOl36ZdzV6CuFlMBLgddzDg
	gSUr+IBcfIpCIDD5Ax3RntziTgxUz3LA=
X-Gm-Gg: ASbGncs3mjZMpcDheUCAsHpqhvr2nLd2f9aIjFtDFjg8EnboNDaC6+0qM7LRdI1qX3H
	sv391L7YTOQnsQXjO3gSy/H96Cc2phhYx9Tty+g0fNh5kXJZTRO4M5Z6Q95xSC3h58yQp7TdERN
	jjLlDNrLWK21MbePwRJMXv2ZR9nwZVuZoQM3xb9+k4S/ZyS5P+HSeJ+w6BROzgVIj0aC/Fpckd2
	adnODp1fQQ4JOSBoEGepDpw5Fo/A1Nm1NaSsHKyof3dvsWtvSxe7fmC8Euv
X-Google-Smtp-Source: AGHT+IGeohnsbh7G27YZJaehGvu2qH71sfz6HWBE6/RSVbMiMu4Y/cvxYKirNRHOMRu2qi2AdGwlTzwh8RFon6gWf3k=
X-Received: by 2002:a05:690e:150f:b0:63f:bb1b:b63a with SMTP id
 956f58d0204a3-640c9caaeb8mr2820507d50.11.1762543633869; Fri, 07 Nov 2025
 11:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106185938.6419-1-rosenp@gmail.com> <20251106185938.6419-2-rosenp@gmail.com>
 <aQ2Yfh5kWCIJ4VsN@yilunxu-OptiPlex-7050>
In-Reply-To: <aQ2Yfh5kWCIJ4VsN@yilunxu-OptiPlex-7050>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 7 Nov 2025 11:27:02 -0800
X-Gm-Features: AWmQ_bkRmJusENLuMOSMfnN-lD4DTZAtuXFfHGCZoTIfniusVPZI_FOqYokHCxo
Message-ID: <CAKxU2N-awq-7HRnobmMzssxX6Noo4Y2b3EyFveB0nSOkvXSNMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpga: stratix10-soc: add missing header
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:12=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com>=
 wrote:
>
> On Thu, Nov 06, 2025 at 10:59:37AM -0800, Rosen Penev wrote:
> > linux/sizes.h is needed for SZ_512K.
>
> Does it always fail or only with COMPILE_TEST?
Well, COMPILE_TEST under x86. If I had to guess, this header gets
included from some ARM header.
>
> Please add "fixes" & Cc stable kernel if it always fail.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/fpga/stratix10-soc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.=
c
> > index 0a295ccf1644..ab309cbf21c6 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/sizes.h>
> >
> >  /*
> >   * FPGA programming requires a higher level of privilege (EL3), per th=
e SoC
> > --
> > 2.51.2
> >
> >

