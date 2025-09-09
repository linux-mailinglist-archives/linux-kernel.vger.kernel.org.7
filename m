Return-Path: <linux-kernel+bounces-808355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E15B4FEFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B3E7BC072
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A7F32CF76;
	Tue,  9 Sep 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pJkEPVMY"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78933EAF7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426756; cv=none; b=stYuuAEKNEHFzL2oaXlOy71kvW9n3W32u5WAsP/S8Tg490rhdl7u8rUVG/d+rHUnlPct6JStQMUy7UMn7yW0sJfPimi93dQ3xdyfHv9foGWW08oxTlaAOUC+tXCyxUiDiAkIy92IHhVRBRarGnh5lgx6DWhhlIEUWni71cjVChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426756; c=relaxed/simple;
	bh=vwHR1FgOXXSSp2VsIjgAXKNRhzqoSYPvwttSy5YEpHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTdevX2W0wq328MQWfwPs6NzeP2pHOAscflY8oRHQViFqsEW/waj0EIbl5x7oMMTeaZ4uZ7J71kf4gvONu9u3t2p0hGbLlUzf5o6DD96p2lS8+BWrhCnuvdL/uIozjVGwYYcMsuhMHXtPNsVISAn3ZaFcN4JewewWQ+auD948pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pJkEPVMY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so5360914e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757426753; x=1758031553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwHR1FgOXXSSp2VsIjgAXKNRhzqoSYPvwttSy5YEpHg=;
        b=pJkEPVMYcYyGrKCWpIdIdsYemX1+edMoeK8dfB0h6epJDltOW+qyW4gtxHE3bEkTle
         Hgi7LvvcW5+jq/WaEol2CJBs1dUrEAlMOhbZQg315laBjc/up8VmZpoeVh+2VIc+cmgu
         Mkj50G4pop64g6/Yca1j8m5tqEfMzPhIjYs3o02NfZTRkGa6mNSPGUyNGoRUCeuJocP4
         7khfVIbhscclQw7ANbbsJ9j4jSIcF5mCOQ5aUgwxgCRP5ys+O8QkzGzNLhNY8BOHcrWF
         4ACnK017d0NcMVDnO7uXzB85KniCDb7LlmUqt7Tq0EEdE8aION7GqY92E4JsfxemflnV
         Glmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426753; x=1758031553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwHR1FgOXXSSp2VsIjgAXKNRhzqoSYPvwttSy5YEpHg=;
        b=Xya+CizcrdPsdCJBVevf34L8oY86NEItJTliJsiBZE7wVTOsBTV/vHVo1S+i0Y0CQJ
         qZyJSEgjVbDH0B/+akQMvNlHVKA5bV2UQRocCcm3VdOksee5lx2Av+aEhAcdAZD7xVYd
         l1ZraqCmURFq2S6NVt4aJlZ8xuXDfnq/3iGapDbUDUKibmEfcox4eooUUDI/v+gMRHMz
         V4caSTkC850+AsLvZlK9pW+xSeSV1+bOisbBa0S5Binzr2J9eVaV5deUMI0rInomsCvf
         /fdJ/5pkHxuFwPv3Oa4i5rpdP6N54Nd1sD3ciGwhYS3S31RQJD0KFGmY6zA8kZFZghH2
         8Umw==
X-Forwarded-Encrypted: i=1; AJvYcCWtMZLo3Rvbllo3ar8nWOaZaM0F9CWqQl/ahDq7gxz/rsjMnrdPr/dy2B8i3B2lfMnXjDKPWOchI6tFj0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYtUDT0DyjL6Dgxf85qv3syjIHg9PBcjS5Li4V7ATHPKmBdaUi
	0eZYqUZhHeZo76QhBSUsj+jxFD51mo+jwmk1i5powRbsOqe7tosfbL/lwcj3f+uagPsE3TYNybB
	Y6E8gZfWEVxMVV3xVgSpb0GQQQY2lbrOcksTnL2Y9hQ==
X-Gm-Gg: ASbGncu6IY8QvV6zO2bbvBvutgVoQeIg3dEU7VY6Br5GghjrM2qXuGP/4qvQlhxuWT3
	MXAmCE8lpLK9Re0y7gAlmmA+PVMWRx5yYrGoZI375ScQNe9xiigilG/b46nTxvdWu07rnyDx1u8
	xHRlg0Dju7V6S3HtRtfL9M0oeYhr0b92E+njbHqZHcAGpLFG0ibMCW1YEmr4gVXI4jS9JUCs3mk
	+BT+QXcDY90vDkw9pCXLRjr8qVr3FI3mg+01aE=
X-Google-Smtp-Source: AGHT+IHxbtPyFzNpPyeaiiBaisDmRYDyXY5HX06QQvzN7rQqg4ycDBS5H9rZi94hP+dpGNYd7MLd29QcT4mULfuZ6+0=
X-Received: by 2002:a05:6512:108a:b0:55f:4db1:e450 with SMTP id
 2adb3069b0e04-56260e3b836mr3230997e87.22.1757426753065; Tue, 09 Sep 2025
 07:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-gpio-mmio-gpio-conv-part4-v1-0-9f723dc3524a@linaro.org>
 <20250909-gpio-mmio-gpio-conv-part4-v1-13-9f723dc3524a@linaro.org>
 <aMAP9hAWars0T83r@smile.fi.intel.com> <CAMRc=MeLTGq8Qu2aT43tkt3vaYCSaJPJPLmaUQ1SAyD_OgVr_g@mail.gmail.com>
 <aMAn4MM_Fs8q8qwj@smile.fi.intel.com> <CAMRc=Mdr4oW2d7XZ90rRr_fKC7WToz72v=_kW-s8=Urd0g8k3g@mail.gmail.com>
 <aMAve1MbONmKVjjg@smile.fi.intel.com> <aMAv3STeZUdSQ14p@smile.fi.intel.com>
 <CAMRc=MeA87p0QAzq_3MACQM90MhN0eRccr7u-VzcfyP8b90AaQ@mail.gmail.com> <aMAzZAbNwrRTgFi-@smile.fi.intel.com>
In-Reply-To: <aMAzZAbNwrRTgFi-@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Sep 2025 16:05:41 +0200
X-Gm-Features: Ac12FXw1RLq4MdeG1hkRFaIkCvacYp3h7kbqz23NMJgO5kiwlT10dViDUNZvzbs
Message-ID: <CAMRc=Mfn7atHTqKc9nMTQ19ZserqeNi3skb-QhG3CVdEhmr0gg@mail.gmail.com>
Subject: Re: [PATCH 13/15] gpio: sodaville: use new generic GPIO chip API
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Alban Bedel <albeu@free.fr>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Yixun Lan <dlan@gentoo.org>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 4:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Sep 09, 2025 at 03:56:41PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Sep 9, 2025 at 3:47=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > TBH, I think those 6 all made the same mistake, i.e. thinking of the =
compound
> > > literal as a cast. Which is not!
> >
> > What do you suggest?
>
> Write it in less odd way :-)
>
> foo =3D (struct bar) { ... };

I don't get your reasoning. typeof() itself is well established in the
kernel and doesn't

foo =3D (struct bar){ ... };

evaluate to the same thing as

foo =3D (typeof(foo)){ ... };

? Isn't it still the same compound literal?

Bartosz

>
> > And are we not allowed to use C99 features now anyway?
>
> It's fine, it's not about the C standard number.
>

