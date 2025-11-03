Return-Path: <linux-kernel+bounces-882710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13BC2B2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507F14E03E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEDC3009D4;
	Mon,  3 Nov 2025 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GEjDmM21"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031F3002D4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167377; cv=none; b=I5fA1NVFzhKsLrxVmo5DiS8vgHDE00wIzIk4SDK5BIweafS0sn4S6Hr3TEeHkvF0EG46jJ0s6HU+4dN0jvCqC1tW1l8BmQknlyE1QyKvLwb/5mTnruKzLAY+0Ql2pplt8n1u4CaqqMN8BE/k+zAaONwJnMLWDrkzNDTIAXT6Ze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167377; c=relaxed/simple;
	bh=qXd1oKO85msYoAVXXFRKg+REL5mVmucUjgWVubyCwzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lgnp97+PJQLz7v10qlRw7YxQP2obOqBKrbCj8mmHUHLdGTUZfj6lpWpsek2mWukf49tF7Wv2zQV/h8QC7FgBXNlrYTaTwSlvVCtAZpDCofj5H4VowyUyNJwLtBbBeb9BTFn2e9x+W3bSp4QS/e9yfXOfpBNuAcVH9+rigtT9T5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GEjDmM21; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-378e8d10494so43315861fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762167372; x=1762772172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok14Sy5kuYnk485Ftwy7kJP5xIgoR392fDNYbBDnVsc=;
        b=GEjDmM21brD60IDPvOLK4mVw/J58f58NnHnBLBc3eSK7EDPtCPIkrx1lzVOL7ny4NG
         ueMQCmyBb5ySLVGqqeUWmQ6L+5KrSRYSEyaviljmmxcJZWx53bQ6HbtE32r0UuxpR1aE
         HYyGQ+qHThCkNtxLsMjMaL2NgRwjCPS1did9aII8lIDDa1hf1h2Dqe1qyWBAjQvc/jZw
         MuW94y+xfITOAk18nnHwb9my9xpckl53mBGhu6X192TRqlKiCNvkAMIWX5otU+3v76Gw
         YW5wKCMv4shQxT4W9Zbnkyr+gWF9AdHjIT5sTJXd9Mt8unMvoJCl68CBV6VOnLGzFm0K
         X+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167372; x=1762772172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok14Sy5kuYnk485Ftwy7kJP5xIgoR392fDNYbBDnVsc=;
        b=rhYVkkNqaaKSqgxTDKE8DRvvY53FuQO2388aT3J837Qqcu1/KdaCrhM0Srb4fBIOG+
         mBSh21G8PYwVQ4x1a+yxwlBH6yo7z4awtohq7YVKbwPILEyrZ7IOX8hmWqnz6RP4eq5+
         MLEAglOg5KxJdoJtCOXWWmHMjpcpDyAVDv1S7adS4yHjHzzQrxWACCTwOE22tr52voio
         9IXgq1OK+zb89EprR3D8W0upSprWy9hf2AlT3hPXuGERbSZu0k21ootEEv0VBGB3bDLo
         AKMxCvCP2640/YdxnNfnIRjLWQ6Ly/H+/lWO9DP3dCkkej+UBkQdmZq3slIL5tmoCjME
         IzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVniyv8bqMVRGFdrxGCti9BtDKVmcMKCZ7RDdG/5zCjEFW7SDme4pz0EtG93Dw+A1WGjYRAh3fVsoKRi8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7Elwir/N8bFfGV+W2SxEWaVhpv3L9EDAMzLMbF+/oWWufeI2
	ebb/dBBqwiSyYQfbXIW86bV0cktFkg3sBXqT8X0OFHSapnNstdT+GwsXgN7hdH0zRAuCATfHHK3
	rHUZTO7Vucjp7X7w3LGhS4vJWhjFUA5byI6hAeY5XWw==
X-Gm-Gg: ASbGncvZCNeU5vuhUBZ2jeZ/Iocq71yZvM4X7fVcEWBhtzdMQzaQXwHGsxPjDEHH73M
	2eZiPtkLu2rtTYtLE91D6tDEwNM/3XgprtH63C7s1V2pIE7YSDUbnQpZbi7E8xbl06+IUJrpSRR
	6rc2PSinCbkenm/eR3AZKzZ39VaHFZvxz9wXue1hkAmdHTOp92wFiPyiH1Gu0+tdW2UuKz2H7l3
	xQGCdxv/HfdyLzbQSnjfnLSOhKbjgnQEHBlb5DUxDfq2BNhmLXZm2zBaVqJgbUqyDcZrqshgqEK
	rfredsrPiYh2oo6B
X-Google-Smtp-Source: AGHT+IGCNFyrRkoy6fXh6ZFQgn7Nyap9sPAn3749NMDYc+KPJNXNFZcWuq9hVUt8f+/CoqxAouRL21Fy6SGUSNRsLi4=
X-Received: by 2002:a2e:9284:0:b0:372:9c25:7a94 with SMTP id
 38308e7fff4ca-37a18e2d703mr27723701fa.41.1762167372364; Mon, 03 Nov 2025
 02:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-3-6461800b6775@linaro.org>
 <aQh6n2XuI0oayg2g@smile.fi.intel.com> <CAMRc=Md=r7GaO3A_7de+EqzboyA2cqNSTZx7+64VSMvRBb9gpw@mail.gmail.com>
 <aQiJgRDm0lZYqSmj@kekkonen.localdomain>
In-Reply-To: <aQiJgRDm0lZYqSmj@kekkonen.localdomain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 11:56:00 +0100
X-Gm-Features: AWmQ_bk3gj7buQnHcMQ8QrYYR-_txSOE_pOOdJ6cMSRz8o8pL2AgO4lkThKstzw
Message-ID: <CAMRc=MfQ6n0S4RCPMhvE8kx5w4pc47=M3pwMH6c_CCo1-uZMKA@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] software node: allow referencing firmware nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 11:52=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Bartosz, Andy,
>
> On Mon, Nov 03, 2025 at 11:36:36AM +0100, Bartosz Golaszewski wrote:
> > On Mon, Nov 3, 2025 at 10:49=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > > +#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)                  \
> > > > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > > > +
> > > > +#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)                  \
> > > > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > > > +
> > > > +/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
> > > > +#define SOFTWARE_NODE_REFERENCE(_ref, ...)                   \
> > > > +     SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)
> > >
> > > Now, useless.
> > >
> >
> > No, why? With these changes, SOFTWARE_NODE_REFERENCE()'s name is a bit
> > misleading or incomplete, so I'm proposing to start replacing it with
> > SOFTWARE_NODE_REF_SWNODE() which is compatible with the former but has
> > a better name.
>
> Given we're already using _Generic() to determine the argument type, coul=
d
> we simply use e.g. SOFTWARE_NODE_REF() in both cases?
>

It may be possible, yes. I'll look into it.

Bart

