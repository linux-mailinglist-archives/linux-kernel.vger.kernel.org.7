Return-Path: <linux-kernel+bounces-841112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF2EBB64AB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704E04877D1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B8A280CCE;
	Fri,  3 Oct 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcNAhzBY"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30774274B55
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482135; cv=none; b=VjVf/zoIe+brCmNEKxj9NyOGkjO9jMRJkqW+Lvd0LnmHK5GhE0lXlwQP4lY/T4NvOaS4H6O6wlf+KmUBMkySs0y8cuiflOKWZa5lzRvdGarIDXqoaewbLEVJe7HVD2hFlJyFDDs1TBH/SdD5VwZmWNukHjNCQj5VM8yl3MEDfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482135; c=relaxed/simple;
	bh=AoJlu/aMSVaAZ99yWts3jw8DSv4BPd3kziHUYPKMSy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buzBcd+QjWcp4t4UN4XOXPSRCsVsVG1aR43Ds0C7lJL1AVOZT3CT8edHdZ/cXfKHFitAZ5q/YMW5supvRCf+8tR6T7owRWWogSdFOzlLWMo9jO6UUw2+WHXBJmO4XJNU4vcECpRps7yPRwrMGnBBtJb/g+xE4GW8pUOUPfLIgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcNAhzBY; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b55197907d1so1335980a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482133; x=1760086933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxqa+yDgpnoAEXzNRro9y4z3jhhmxVoLzlhoWTC4v1g=;
        b=fcNAhzBYGprF+w7OrvPgpI6+3AHoVTOujVRnua+vOHxFya+cMqyXUN9VYEjzpEYGND
         a3uv6hKTg01ezVLPbE0IluL45Xs+BhWRdIXGMN+ThBRsEtT8smHcMJ9T7E7WXs+aDBeI
         u5hND0PTPGyCoOEByaenbmQQlIhfVqcMKAeC3h2QeAuspyqQytAmkWWtX3RH9wKLR9+O
         ji8l5zRI3I+aurRLPTg+9NLEEy3CRDxP+AFisfRPRS7Y6xg6uk4qQmpNYUtL11XVWvmr
         axUH4OSxnIHkjULZrLNQUKFkgGWEg2BbIkD+NIAmnMYu4r2m+H4u8U7JSzfvYul9z8Or
         oZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482133; x=1760086933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxqa+yDgpnoAEXzNRro9y4z3jhhmxVoLzlhoWTC4v1g=;
        b=KLDxeaN94icZqa8i4D9IRKnXSCeUkrpf7i2eTL0XBTgoIQjwgo4ijb5i7j2764rPJu
         krZV90TbUqNsKFLIjHEjcHWtkFQHD//KvzHxBdJ3Hs/bi/HvO6OUKrDKk62UN/dLYMgV
         rkV/gqWegwU5PFPBZV8K6tCvqj5J5oBO6o33zvd425ZG7W91aou6SD0w7YhhgGKTbKCo
         lRgZLG3R4GinlgaByrhZPH3fd7aZ7OJhg0KDnRu47tng2H5eFZDnq20EEDi9xVENjWlZ
         0Uohe4pw94++YlBFkQcFV8oWw/yChihYaxlCZHl5cQymcbfCr3UWbnDCWpBzRHe5IbnI
         ku7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3Qw1zXXMd/oCfHLJlBOrG8kunwn6SMEiPhBM0LXnX3RXT7JX+c8ljp+Dh+9cKajgVlYYJ19Mt2Eqs69w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfMkZCYf/5p3F7JyHJFIrmhOFzq+Exc3m9MC5m+B7qtu66Oxc
	gt2wH2I1gDSC48nGvToZPU0KvUKb9q7R1evjj3H0uJE9nAxWAWy/uck86IzaPGUr07BXZi1cR/i
	duE2zc/j3IsDtE87X+Me3p4bZKNAU7TU=
X-Gm-Gg: ASbGncvkIFs+cBiN98lIlhlk288u7MpiQOBTc2N4C+STEsq9n5p75eCy9UdTPYnt/g1
	VydgvcXISxL6Z6+fGACmmACezWFc2q9WgVGh5pc6R/tJGCMu9SYaUemie3W4btWg+MoCErmDe9O
	x8sqtVbl9bnPeLJrDmiu89Ypizse5AdI6uL3RZEyegJAe2fWO57idp5tUmE0B4BwmYy3JanpHza
	3o9wgrgHI9hO2CnA78Tlj/aEWIsPV36Wqc/csRGSQf8jMIpCRecSkfu1Oqs27Voi9GdSl6eYLGg
	thkDfH+1d88BlOle
X-Google-Smtp-Source: AGHT+IF+VuyebhfbDmuKwaQz9VO+LNpTaCKzPPtkSI3ZEy/4ghCU+AOuEMJ/tznlAQcxgIL+aISACabvQO9QzaBnXr4=
X-Received: by 2002:a17:903:1ad0:b0:25e:78db:4a0d with SMTP id
 d9443c01a7336-28e9a5ff449mr32573585ad.36.1759482133330; Fri, 03 Oct 2025
 02:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com> <20251003083312.GC2878334@horms.kernel.org>
In-Reply-To: <20251003083312.GC2878334@horms.kernel.org>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 3 Oct 2025 14:32:02 +0530
X-Gm-Features: AS18NWDDuPPIIeehTgoFw-nQ8yC7s8iWiZZdHg0YLrQUfA3dlujVeUboCKThj8Q
Message-ID: <CAL4kbRN=ktZc8fkcjo90GM2EBgCVt_xVmSGVQuM8gE2qV3ZJKw@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: Simon Horman <horms@kernel.org>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thanks for the review and guidance.
I=E2=80=99ll prepare a v2 targeting the net tree, updating the patch subjec=
t
and incorporating the suggested changes.

On Fri, Oct 3, 2025 at 2:03=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, Oct 02, 2025 at 06:05:41PM +0000, Kriish Sharma wrote:
> > Fixes warnings observed during compilation with -Wformat-overflow:
> >
> > drivers/net/wan/hdlc_ppp.c: In function =E2=80=98ppp_cp_event=E2=80=99:
> > drivers/net/wan/hdlc_ppp.c:353:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/wan/hdlc_ppp.c:342:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Introduce local variable `pname` and fallback to "unknown" if proto_nam=
e(pid)
> > returns NULL.
> >
> > Fixes: 262858079afd ("Add linux-next specific files for 20250926")
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
>
> Hi Kriish,
>
> As it looks like there will be another revision of this patch,
> I have a few minor points on process for your consideration.
>
> As a fix for Networking code present in the net tree this should probably
> be targeted at the net tree. That means it should apply cleanly to that
> tree (I assume it does). And the target tree should be denoted in the
> subject.  Like this:
>
> Subject: [PATCh net] ...
>
> This is as opposed to non-fix patches which, generally, are targeted
> at the net-nex tree.
>
> Specifying the target tree helps land patches in the right place
> for CI. And helps the maintainers too.
>
> Also, git history isn't consistent here, but I would suggest
> that a more succinct prefix is appropriate for this patch.
> Perhaps 'hdlc_ppp:'
>
> I.e.: Subject: [PATCH net] hdlc_ppp: ...
>
> For more in process for networking patches please see:
> https://docs.kernel.org/process/maintainer-netdev.html
>
> Thanks!
>
> ...

