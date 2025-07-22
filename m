Return-Path: <linux-kernel+bounces-741014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34751B0DEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18A61725B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CABA2EA73B;
	Tue, 22 Jul 2025 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="g8peOOS8"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810682EA177
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194775; cv=none; b=mwdi/t4oyC2YngNgUkH2ds0ixGlCN8+WomQFcv6Kut5Ta/IgN0C46hLLj9JyaU5gCWTLq8/+ArPG8/Xgon7wRjPrmN95rhG6rk3PlAeY8CmIXYxEk/o6FGaGOYnlDrYU1iiq8XeD40SwKQq5q5PVc2Yq3JeX8semStKPSrjawCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194775; c=relaxed/simple;
	bh=RsyPlufZr31PVPnh/EWX43+9YZNSLPJR8i+ZYcSJ4Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnmxRnkovcgVUPtez9ZsIGWkQc6+ELPwizczp3c+9OB2WRX14V5lrh+EIKb7lC1X0B/DcwMhhiGeEQjaxtcbNY3sMEPJLriviIKAiNFHDXXvqsL+3pmRviN5TyUFX+rchUzTm9F6GCLkpfmOCDYx+fKf6H34fQK/VVBq2TB45qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=g8peOOS8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-719a4206caeso7663207b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1753194772; x=1753799572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy3jvsb4tc1nMnyuXE7xVv3bbQGwBcqiT9b1E5knZ2Q=;
        b=g8peOOS8ecf+5OCnOfgRvCAK+mgnADuVd/6KlRsaeHpMDK9FdYWm76Yb3MGtE2DetK
         hB5aldX544w+KsL3a9dPArCjovkvTMnZagd9EUwepuMyD4hBX/b0U3dkV3WzeXBtm0vF
         +9NZJ8FkdpkG09MhAW+dDTULmSEc5vbjaM+EHXlF9dE2oa2EgM4QlwJxDrWG1sTobtbK
         lEsjSR26l2w+O6iJHXJDAvvEM6YszcRLexjC3eySYZF/ukRplm96aQI1uqfjtcJ0Kobp
         yWvd9/tZbtnVuxQRAJWGjC6Kpa0mSV2D/FtJAEEf3tMfjOpVa/LdHrMwcXiRGmqqBRhO
         /z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194772; x=1753799572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy3jvsb4tc1nMnyuXE7xVv3bbQGwBcqiT9b1E5knZ2Q=;
        b=kiwhEs/WWilx6izGWzY7+E9VMJdlwCuMebYVAcU3WFz0JJ7Nnbs0SYxqpEWJy5XuwX
         NsQqQCAHOX7qPqj5ax6Cm5kVdoUtxFOxeUO7fI+p6I0v11qtrLFI6/SgL3+/WWtKAvuN
         e3pC5IGWMsoZ3/OLqENtVbDuVwg4cg+VJ5U4p9JKh0nbYmvp3jlPwsKWHSQ14cFOUAtL
         fTFT/x1fn+uIZ+s6hLQeCx4qa7NFY55oJG1ERq1iihGUEw7ojOXO14SFgfXy4qSOLaJc
         jur/+uM8jcwHkQMvYXeJiK9FvK1g7KlQERKXh5zlq2Fcw3ARspl/3tUZNf2dEjhcNv1b
         naiA==
X-Forwarded-Encrypted: i=1; AJvYcCVnjAQL0Kt1fC0W11nwyoN70G3f5OoSHThSrmsHiq728sNeF/Esx8r0yB+iUysfJECzwEDnJaCjQgHVn9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4qUCbCpGEddJubf6rmbb5phI0RCrmmrn+jusWfYtC+fz5Hpc
	8UnjsP54xkY/okyHfBcEgxsTjXrOVPj7cRE8ezhN3M4Ae5LSxSWJxETVNc8avT+pmGwg46N3+LP
	lnmOXTj4V4C1Ma2T4OH6zY8o97wy9gaAGU5zhEfAYlHpPY2R3D2SxkmXX
X-Gm-Gg: ASbGncvvIT+8y1uf2GjvfSdsShdJuQn0pqSplkFe4Dxjkzj/wEg7GPlgUqIz4vOd7fL
	Z1H9bXpI7nv74kSnklsxjesqRFeNHxkFhaVa+wL+A2FsGD13OdhONQ9u+35WI9TmZPy+1YJSh3D
	cLHOHmbJh/u4DfL027hoDCGi5gAH3QOJhNMy7vLBam3AuqbLFfZhDqizV0d1dcJ4xxnqD0SwGlL
	1kh4g==
X-Google-Smtp-Source: AGHT+IHLgyQbkmFbEUr6Uh7LewyrDsSpPOOYRIa+mMtbYtSMJpZG7OcUm1mC18zFZvRZ3UoLNegv8l+Q7RI3hzXSuhE=
X-Received: by 2002:a05:690c:6c08:b0:719:7123:ce3a with SMTP id
 00721157ae682-7197123f70amr165110647b3.2.1753194772136; Tue, 22 Jul 2025
 07:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721233146.962225-1-s-ramamoorthy@ti.com> <CAMRc=McTJnTn1sf6Kc42yePvUyP87h1utJ7B_ynWjUxxm0E4Lw@mail.gmail.com>
 <CADL8D3YaF4zt2Wu0Vv1=8W9e9n5BKM+2npgfVmLhJ=wz-jHMKQ@mail.gmail.com> <CAMRc=Me7ade2aSJhn4tEAdNUvB3Y5TRLp8j8w8zgP5J3C6_MkQ@mail.gmail.com>
In-Reply-To: <CAMRc=Me7ade2aSJhn4tEAdNUvB3Y5TRLp8j8w8zgP5J3C6_MkQ@mail.gmail.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Tue, 22 Jul 2025 10:32:40 -0400
X-Gm-Features: Ac12FXxo7kCyXFb0iFwNr6tR3KknB8DInMm27gp30SPu0B8ZIwZZ304YZgGvPf0
Message-ID: <CADL8D3Zw9L+UABmSGdZio_Bq1Nx5tJ226EFtVY6DT3xgYBs92w@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add TI TPS65214 PMIC GPIO Support
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Shree Ramamoorthy <s-ramamoorthy@ti.com>, aaro.koskinen@iki.fi, andreas@kemnade.info, 
	khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com, 
	linus.walleij@linaro.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, m-leonard@ti.com, 
	praneeth@ti.com, christophe.jaillet@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 10:31=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Tue, Jul 22, 2025 at 4:16=E2=80=AFPM Jon Cormier <jcormier@criticallin=
k.com> wrote:
> > >
> > > This doesn't apply on top of my gpio/for-next branch. Do you think yo=
u
> > > can quickly submit another iteration rebased on top of it?
> > Maybe this is a basic question but is there a rule of thumb for where
> > to base patches to be submitted to the mailing lists?  I've generally
> > been basing them off the latest tag in linux-stable/master.  I suppose
> > this might be one of those it depends on the subsystem things?
> > >
>
> I feed my tree into linux next, so generally using linux-next/master
> would be your best bet. The rule of thumb typically is checking the
> subsystem's git tree in MAINTAINERS and using whatever branch goes
> into the next release.
Awesome, thanks for the info!
>
> Bartosz



--=20
Jonathan Cormier
Senior Software Engineer

Voice:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211

