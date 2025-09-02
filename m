Return-Path: <linux-kernel+bounces-796709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3656DB405FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35BBF7BC9DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B1D305076;
	Tue,  2 Sep 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JHycl7Xh"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9E2882DC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821763; cv=none; b=MjiQ5p/lBnYLrHVaY7Eeys2IocEiohvcU87n3Y65sIoWpsPRhtOTu6i3TkHukWWMnHNSExszqYXZ47QYcKTQDJYPtYbnzmcbKx4tlCjn1Ezy7Bl8OMMfAWqCl+2rE4SrYybJAWJujz8FbQH1oR9VdnDEo9oi8YViWeyOwr1tHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821763; c=relaxed/simple;
	bh=t6qJ4Krbe8Eig8u7HuRNaH82OJCGzRpxUAzmtO7ZEgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzPQRPt65w+Ne7RAtCGLTY6kz1dw9TogK/z8VOUjC+Fjtm5P6UAmEuTNu6spsSdDrivAcE/tH1FTdhvPlNgHD3SdLUwI5HVHnW4N4kmrrW0rRXsKgu8KKGfW1UyR07GZjRKVtW9idlcU/zka5N/x6k0FPnPnK6Gvu3Ultb+WwHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JHycl7Xh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f753ec672so3195058e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756821759; x=1757426559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6qJ4Krbe8Eig8u7HuRNaH82OJCGzRpxUAzmtO7ZEgM=;
        b=JHycl7XhizIXDhB7H67QiM3ora39fFS0qsQGf0MBFXfqjJb9Dgzdbi+DoMs5pSRqrV
         H1S+PvcYqslE3IKKcShPsILhFh4PRKSBIAn2FyPiXHDOWJKPwZBIn2szYzVeB2zX/lMj
         xFY9l3BIbKeACyANe2Gl3Wi6Pd7of6ydyevAVU5jUxXdKw5bKg3NiKjq5Drw1+1CjB80
         GGS0MHpxBmKUTIVIfgW3lM2SpmJ2s70Gi+ySjOdNCbzVX9RHI09fnUcaI4TZdECpt6IX
         U51ywl0Jzjr9Tx1v8W1cgFltIxP+C9cVUMC5r6Jdd9EqAUs2Tx+TLplVLKgDqqO8QFNo
         UMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821759; x=1757426559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6qJ4Krbe8Eig8u7HuRNaH82OJCGzRpxUAzmtO7ZEgM=;
        b=SOupLJLJc/DULbbSbpEC35Qe+EBlbvg2cgRL4B4F/Uz/+OhvRpm/HZoQdQ6BjxvI9W
         yo9V1wlfWjbSADRuyPDt0z1jyTy3vz3UO01ay8Xv5hlB7cBA1s+Ylcq7+J13GEndiTFK
         +nwwEpRqzAcVbaRuLW2vjljpm1MhcCmM5W2ITuqg/2MWd4pJMumjB7g2hGhAuGIbPCeH
         heY4xz6SxR2mOGnEoO2m/49Yyh2S/oTL4niIfdCUrw5G7iKwnHoxIcFvk9T6tNPssd8g
         +1gAiZmQUqEpWcMazKAxSpyQ9xNOwknLKBT0bOZ189uEogfs6qTp2ImkuJaXLxiiK0tL
         NZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8fYR2zCWEU09q2xbqO+wyyAF1tLpMCvk4BAN75bUHqnIAn+dMzE9eIEFC41VWtY94qDXk3O6ERukb8ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz24RBSCJbaPWDv/o/57lumCDwvmwdAhH+pkq9dJN5ZvzAfRVAp
	nKUP0mzekt/W3yfGWEeEgCpkvV91L7wnZWcA0F6JQ1AmQNTPH5vjhWRtwgleydcJgEpiBfjoh06
	A3UCIU6CsYDDKK1aap2Vm1aWDBQBCZzt26za49r/5pA==
X-Gm-Gg: ASbGnctPG1KBNDYKbRLbZZxCDbIblFAh/1qn4RH4S9NlzhOHB4KBd7rEESx2pN9C7kO
	O5359PDIamZJOTbRv/+g8OE5pqy08T0viaMtNIbmPxVZuCqoem3qzgNRNjUjkzLtZHvaG+aRyCU
	HAgr3YKzvZ4eluSxLof0LF6fliHaIeyBYTv9YUDpmsbFDJZNqKaewiVhO/mF6KmfzpBlUip9JtS
	VAf7MbsxWiXb3dA1k6w1G/CESbiegS5qqpFAW19WaRJHzgYPQ==
X-Google-Smtp-Source: AGHT+IF0XxTo4Eof/cAnsUmsXyl7FaRgZjHqhfNse8z4FzsrSjUbnY+JobcnARjelIxZIYceGk+U5xWeRaOHkRoNgZc=
X-Received: by 2002:a05:6512:1289:b0:55f:3f25:f03d with SMTP id
 2adb3069b0e04-55f708dbc89mr4083265e87.32.1756821758848; Tue, 02 Sep 2025
 07:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pinctrl-gpio-pinfuncs-v7-0-bb091daedc52@linaro.org>
 <20250902-pinctrl-gpio-pinfuncs-v7-1-bb091daedc52@linaro.org>
 <aLbrz5DYS5Yxx_UE@smile.fi.intel.com> <CAMRc=Mfx5czDM=vfEYhFtVO3MviYaW4wKBYjGZ9ZnMbr-+T4mg@mail.gmail.com>
 <aLb2HH5zgxdbDiPo@smile.fi.intel.com>
In-Reply-To: <aLb2HH5zgxdbDiPo@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Sep 2025 16:02:27 +0200
X-Gm-Features: Ac12FXzmmMVa4i5hYh_JJ6GZvRRv05y-_-Nk_APJiumjkhCqONHKECafTZ1ySu4
Message-ID: <CAMRc=Mdp2djgGbgu_uwLSkrtRPomAU=6-SRdzCdSbrHWzS2c2A@mail.gmail.com>
Subject: Re: [PATCH v7 01/16] pinctrl: check the return value of pinmux_ops::get_function_name()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexey Klimov <alexey.klimov@linaro.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Sep 02, 2025 at 03:29:31PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Sep 2, 2025 at 3:06=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Sep 02, 2025 at 01:59:10PM +0200, Bartosz Golaszewski wrote:
> > > >
> > > > While the API contract in docs doesn't specify it explicitly,
> > >
> > > So, why not to amend the doc at the same time?
> >
> > Because this series is already big as is. That would be another commit
> > that can be separate.
>
> I meant _in the same_ patch.
>
> > > > the generic implementation of the get_function_name() callback from=
 struct
> > > > pinmux_ops - pinmux_generic_get_function_name() - can fail and retu=
rn
> > > > NULL. This is already checked in pinmux_check_ops() so add a simila=
r
> > > > check in pinmux_func_name_to_selector() instead of passing the retu=
rned
> > > > pointer right down to strcmp() where the NULL can get dereferenced.=
 This
> > > > is normal operation when adding new pinfunctions.
>
> > > Fixes?
> >
> > This has always been like that.
> >
> > > Reported?
> >
> > I mean, technically Mark Brown reported my previous patch failing but
> > I don't think we do this if we're still within the same series just
> > another iteration?
> >
> > > Closes?
> >
> > Ditto.
>
> I meant that this fixes a potential issue disregard to your series, right=
?
>

No, as long as the imx driver keeps putting stuff into the pin
function radix tree directly, this cannot happen. The issue was
triggered by the discrepancy between the number of added selectors and
the hardcoded number of functions (we started at 0 which was not in
the radix tree and crashed before we got to 1).

Bart

