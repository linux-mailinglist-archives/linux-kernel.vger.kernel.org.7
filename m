Return-Path: <linux-kernel+bounces-831955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E066B9DFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD815320675
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E9274FCE;
	Thu, 25 Sep 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wjUsZWBn"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9526C3B6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787927; cv=none; b=M7XMW8bolyNsKPmmUeSYKC5ap1FV7nUX5u6r6eWE3Apdw3+MrL2kxvIoSQKWJa4spd+TLjAnKb/g5xho/tLlB40CLy0KW93leZsK2UV/5LvBbdjIx08agFH00GTb1e9cJoNCgIazDLFm7MJguVi4sl5pPIimASyLStjRyIZtXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787927; c=relaxed/simple;
	bh=moVqkNvoC/U4Kiv+fBtM+ZZcVvqGIdKeTYp5d2BfFYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAEWpdZivG5R1p3Z3QNL/Jc9JlOegMCs6BNEOIDV+sHk8xwz4TeC1tIc0Qm8eBK3yzWz7yWwtsRYbEOovoqFk//kfs8CC9JA80ZYcbnw0MY+YW2ZDbIhEoqAGXu/ZgpwiooNVWzgzKiQKynBoDVNaCrbzZbiPn23f2EfjiplKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wjUsZWBn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5797c8612b4so883701e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758787924; x=1759392724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOUEu/+y60hAFjLRRexZAgc5r0XDC4GIpSh+/gdmcBM=;
        b=wjUsZWBnHlVyDmuevdbz0GLyO8N9XO6scKvQNzppb0MhScpF0TF2Np2m/mh90FxgEv
         vBRmFE3CCoMb/ftdTBF1JBg/vsKLqS1hZNj1bDy40XqyYQpwomLOBEkRDeOoMt8sfid2
         d9jWqv+UvMdorC6Fk+OrV8PIdG/N+KtAVZ6eZy8LYUqKiXFoI9Wyy484HcIi51meS+rH
         BdkCBurw57lVu0RNjagiHaWuJQH/uemaE8ajI5u883GAUiV+WIDkTIOmJpaH6qdqim8c
         DhSj35YVlaYLPHrSyu4r7L8dlDryb44LNFqEhdjiUMUannBZ20+1Di0lguci9X6FaGYf
         3IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758787924; x=1759392724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOUEu/+y60hAFjLRRexZAgc5r0XDC4GIpSh+/gdmcBM=;
        b=EksVBlVFvB13w1Oi7+XBvs0Q0ZzlRdC79C4pA3f6h2YHQjpJDYRPArkmWbmfMSXSm2
         4IhR9I9hHalIZeazubaMbcHcY7irkpB8rOPwOcpFCE4BQ8sA3zEP8+4sO1U3jW87JGiU
         gc7WM6jTmCbbOdodhUtK5LrMN7AgwPfiMW8Iv7G8s2BzFvtXheznpAg7XVpOxxbipu/t
         Rqzg+vVcwbkZg6v1gJXsokQDp9McQRlj0EOh38wTXw35zcuuYmebFUino1QMRInMkSNx
         fvlPCMXXWeoFecJn4P3WNPux16KU9rhscwF3/vbnUz+RHa1nZIu/C7Q4rBfOy+CEwPJZ
         aNwg==
X-Forwarded-Encrypted: i=1; AJvYcCVY728/veHAK7BpxdKq5Dop3iotcghaiqb604tdV+wXdP83gHvwsiiXGovo2UJqXLbSStSHaBZHY3QXmbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzerwEVDgH4HQfMDAQxa13ORH9IsaKzRx1u+fygvovklSHnFQ2I
	1OxT1Ds5COjvVGMb9tVE4BK4OAGR7s22MA3o8YgaaU4bzG0n5fQ1/8tsdgQ3S4II4fTpvKi84ND
	di7nTzsk4w/5o9BG5Cf1cDwKDUivCBiBloa3pw/tPXQ==
X-Gm-Gg: ASbGncuyi6ZsWU0VbeJCBUPF0vc40fyDL4sW5Mxbmx6G/FPtAPh5cuXR/4K5p3B8fDh
	Vv5aKkXZfcV3bdO1o4mwixJcVDyGSOfH5Xk6SVBEuVhdLYDaK58aE1fDGW3A8gOdUD92L7gzu0y
	bZKKzg3NJe7BVTDk5wy9D0Ib+rLgOcIFkN/kal+FjV0OiHakVNjTnkYih1yi+NiGCWelHW0EfSl
	RJSq3bCC6lGrHySOD33UGkvaFoF3UP/K6OzUw==
X-Google-Smtp-Source: AGHT+IGJf55i3bv2L8+gmNkmzkA9WiH37A1+UEGPjEgNIhsONYzUjkvXwduJeRWAHBQx5JD4yW8UWOq3aNBoELENYBs=
X-Received: by 2002:a05:6512:114a:b0:57e:6aef:3ffc with SMTP id
 2adb3069b0e04-582d073fab8mr832508e87.4.1758787923677; Thu, 25 Sep 2025
 01:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
 <20250910-make-compound-literals-normal-again-v1-2-076ee7738a0b@linaro.org>
 <CAMuHMdWoEXLTPyQL4kt1OPVbrDDcBdBigqUM7EbNZjZUsSmRHQ@mail.gmail.com>
 <CAMRc=Mej9fQk-1zYKhPK6aWdptXKvjq28TywRyP+iZExRuX9og@mail.gmail.com> <CAMuHMdXgoj+XuKhruEmMpjZignuM9fJLp8NJ0=ZLw8KdFKohsA@mail.gmail.com>
In-Reply-To: <CAMuHMdXgoj+XuKhruEmMpjZignuM9fJLp8NJ0=ZLw8KdFKohsA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 25 Sep 2025 10:11:52 +0200
X-Gm-Features: AS18NWBR36rLL1CtueiFc1sMJzM_SH_VKHScbJyKloWTmjZnMKzJiRko6sa-obs
Message-ID: <CAMRc=MeR3iH7cH4aLuN5T+y5FCFyzpR3BBc4chE7CPAy8Ug2gQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: use more common syntax for compound literals
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	James Cowgill <james.cowgill@blaize.com>, Matt Redfearn <matt.redfearn@blaize.com>, 
	Neil Jones <neil.jones@blaize.com>, 
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>, Hoan Tran <hoan@os.amperecomputing.com>, 
	Yang Shen <shenyang39@huawei.com>, Imre Kaloz <kaloz@openwrt.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev, 
	linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:03=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Bartosz,
>
> On Thu, 25 Sept 2025 at 09:52, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Thu, Sep 25, 2025 at 9:48=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Thu, 11 Sept 2025 at 12:02, Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > The (typeof(foo)) construct is unusual in the kernel, use a more ty=
pical
> > > > syntax by explicitly spelling out the type.
> > >
> > > Thanks for your patch, which is now commit da3a88e9656c17a3 ("pinctrl=
:
> > > use more common syntax for compound literals") in pinctrl/for-next
> > >
> > > > Link: https://lore.kernel.org/all/20250909-gpio-mmio-gpio-conv-part=
4-v1-13-9f723dc3524a@linaro.org/
>
> This is the origin link to the patch (by you) that started the discussion=
.
>
> > >
> > > Looks like you (slightly) missed your target. The correct link is:
> > >
> > >     Link: https://lore.kernel.org/aMAP9hAWars0T83r@smile.fi.intel.com
>
> This is the link to the comment (by Andy) that questioned the construct.
>
> > >
> > > > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This is a link to the discussion with Andy as per Linus Torvalds'
> > recent request to use the Link: tag to point to actually useful
> > information rather than just the patch's origin. Linus Walleij doesn't
> > use b4 so the origin link you'd normally expect to be added
> > automatically is not there at all. That's probably what caused the
> > confusion.
>
> I know ;-)
>
> Given the "Suggested-by: Andy", shouldn't the link point to the email
> with the actual suggestion?
>

Ah, I didn't realize this is what you meant. I wanted to point to the
entire discussion and also this is already in Linus' tree so it's up
to him if he wants to change it.

Bartosz

