Return-Path: <linux-kernel+bounces-740990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4F1B0DE70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E45918930D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DE82EE28D;
	Tue, 22 Jul 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="cthboUTM"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33B23F413
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193814; cv=none; b=mRkRfI8YiSmN0QGrQo4CfgIbj/VCAyt57jTsf+XdikJctOUcp3FGt2IH82zx03s6XZbTBr0+wRM/QB6qqCPK64qInSVTS3LpGbiM2arPTvzBZ5Y6A4MBB06zsVa+LZShHvwOOv2yCLHoDWdUeJtfS73ogTvvGnkVFyewYGKEwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193814; c=relaxed/simple;
	bh=VgF3YVg7j0A3Z4BF38oA80AX3KGiFBUsUIcqgCgCx84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbOsFhjXGGBMrpMj5stbfq9Ozu4JEEVzV+2UlsfiB2YGLY9R9n30qEpB/+zTSpo/JtDlYvotCcAs+saW2yqLtFxjMBWcSrSytPB3DwKKEohCuNX2pgQUefZOIrwlz0LN1wfOkI2V2Zz/6IHfeoCwMHMENFwlNG3WqwPBsg2vtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=cthboUTM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e75f30452so36167347b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1753193810; x=1753798610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLLBhbPdBkBAifwS3c4NzxbMRa+Sqhs2OsCY4dOuxvg=;
        b=cthboUTMsrb+mP0TN+DgeYEfTFmid9tJ47+DqYkMCugKpDsbNLaTEj5pMocSI3GWky
         NBrm1hkkKnZRbi4DaNHFU0yhEBxLq3sgRbM1TOu2O/tTds6BL2nXCyoZEFTp/4fNENHm
         6CY5l2m61AGhvY+pr4GKeFU1lfO1Io5a+G+mNGzKs2aLfgCrhEdDUWDI18aksljzJ+3U
         33RL6D/NKTk/4onWUvUxID099yvjBXuXrott06Pfrzi//BaLmE7frZuhzijJCYPtw8Xy
         ovwjz2vcHuvnbxEJfUsG0x5aEkOpYr9t/dZq+/QzD1SfFNwWBf4bAM/cY/O2lSPbUZeq
         OoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193810; x=1753798610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLLBhbPdBkBAifwS3c4NzxbMRa+Sqhs2OsCY4dOuxvg=;
        b=qQrWbhO+xCQNUtDlfJ9cKw55+KAvn2BZHdnEiYvc1z8TvcVxiphcVychOjyxsCnUhN
         +xv1nTjNWE37IFokNLgWEIunYR75laz1HJmyutJx3Td5Cf8J/zmGQ7ozRp2BAJN8uhcF
         geJFAXIH4lebxt5HhUb2A13uAmvCr22pug3nn8RwO4zplEN4FsaMF6PY3bNwYygv3yla
         4mieD5ejkxtOFNw2IBH0b0kAH+V2b4G2nyJttEv+2s2K64M1p8Zd3FgfKC1Lu96ibxbm
         +WTBdGSz6uV3cxpYG/5sOIOtzSSw5Vcp+RLZ4hujHcFnvqUmmnDXz67yaiLmsmB2T6Ir
         xXeg==
X-Forwarded-Encrypted: i=1; AJvYcCWGZklM0y3IXArT9xNje+l6Q0jM5EFCwvb7EMJCYBaciIrtIyhHWUpEVna2XixD8zxNlk0eHs6gAqaXsPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVbX1mlBScNHRkYpSMYc4SBmQogwhgX2szrxuhyVVUmuqKry6C
	+tBmv9Sa6+rh9W7/ur7/IQ5buKBwLFq+wxu2Tv9YdU9bq6gUi7ZNQ+wsXBAY+WgLq0+h547o7sc
	TFoZpEsLhyD+a59yxp87MrUzTng0I9tHl799vdpkh
X-Gm-Gg: ASbGncv8hlkzlaHh6sEtP2tMsgoyMQPXsU2Gvpo58z+ft2IhtWPdmZKfAsc4f6ifJUG
	40BrzuKl1M8+d7D/mvyP5prm1NrS0nEYvNGJ7vRwQGbg3STFa1164BqdaO2pnAe0eU0JWREzEyk
	my8s8PnclB8qQn6f9fRTIQWm0sDG65I1bnL/Nn4rTQI4lxTE4hTvamDEbPc1/N8oZhsqtvBCPd4
	VQdIH1B/nFF9zXO
X-Google-Smtp-Source: AGHT+IEAusMMRxJv/4kenS4u2xWRco7tvJDmOmg4xje0HYxpNUnbtf8FDEI6YDJTxu6Nqtvrz384/0PUMhVHK8NdTDU=
X-Received: by 2002:a05:690c:9a8a:b0:70e:7503:1180 with SMTP id
 00721157ae682-71834f363e9mr354128567b3.1.1753193810048; Tue, 22 Jul 2025
 07:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721233146.962225-1-s-ramamoorthy@ti.com> <CAMRc=McTJnTn1sf6Kc42yePvUyP87h1utJ7B_ynWjUxxm0E4Lw@mail.gmail.com>
In-Reply-To: <CAMRc=McTJnTn1sf6Kc42yePvUyP87h1utJ7B_ynWjUxxm0E4Lw@mail.gmail.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Tue, 22 Jul 2025 10:16:38 -0400
X-Gm-Features: Ac12FXw6Zmlkt5j8dq6rsx00GEtPhx20EHVdwU2_nlr4qMv2Js3WQIT7UbtZmPc
Message-ID: <CADL8D3YaF4zt2Wu0Vv1=8W9e9n5BKM+2npgfVmLhJ=wz-jHMKQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add TI TPS65214 PMIC GPIO Support
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Shree Ramamoorthy <s-ramamoorthy@ti.com>, aaro.koskinen@iki.fi, andreas@kemnade.info, 
	khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com, 
	linus.walleij@linaro.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, m-leonard@ti.com, 
	praneeth@ti.com, christophe.jaillet@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Jul 22, 2025 at 1:32=E2=80=AFAM Shree Ramamoorthy <s-ramamoorthy@=
ti.com> wrote:
> >
> > The related MFD series was integrated in mainline during 6.15 cycle [0]=
.
> >
> > TPS65214 is a Power Management Integrated Circuit (PMIC) that has
> > significant register map overlap with TPS65219. The series introduces
> > TPS65214 and restructures the existing driver to support multiple devic=
es.
> >
> > TPS65215's GPIO specs are the same as TPS65219, so the "tps65219-gpio"
> > compatible string is assigned to two devices in the TPS65219 MFD driver=
.
> > No additional support is required in the GPIO driver for TPS65215.
> >
> > - TPS65214 has 1 GPIO & 1 GPO, whereas TPS65219/TPS65215 both have 1 GP=
IO &
> >   2 GPOs.
> > - TPS65214' GPIO direction can be changed with register GENERAL_CONFIG =
and
> >   bit GPIO_CONFIG during device operation.
> > - TPS65219's MULTI_DEVICE_ENABLE bit in register MFP_1_CFG maps to
> >   TPS65214's GPIO_VSEL_CONFIG bit.
> >
> > TPS65214 Datasheet: https://www.ti.com/lit/gpn/TPS65214
> > TPS65214 TRM: https://www.ti.com/lit/pdf/slvud30
> > TPS65215 TRM: https://www.ti.com/lit/pdf/slvucw5/
> >
> > Tested on Jon Cormier's AM62x platform with TPS65219.
> > GPIO offsets remained consistent and functional.
> >
> > Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> > Tested-by: Jonathan Cormier <jcormier@criticallink.com>
> > ---
>
> This doesn't apply on top of my gpio/for-next branch. Do you think you
> can quickly submit another iteration rebased on top of it?
Maybe this is a basic question but is there a rule of thumb for where
to base patches to be submitted to the mailing lists?  I've generally
been basing them off the latest tag in linux-stable/master.  I suppose
this might be one of those it depends on the subsystem things?
>
> Bartosz



--=20
Jonathan Cormier
Senior Software Engineer

Voice:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211

