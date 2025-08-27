Return-Path: <linux-kernel+bounces-788651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24DB387FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D75463C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748302C08DB;
	Wed, 27 Aug 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y2tS2rwK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD127781E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313203; cv=none; b=kRvBEdtzgbmIlIYK12wIQ/t6LyDljQDE99Ej3jjCE0pg0e3fa5UH61S3VdEUSUTLNF508Ny0Ur22SXfBum57xK3jwhrhfV1y3v/LTvCMj6zVI1htVvOIx+EWrmg/sn5dNzWbfuPO3ks7/zQq7eLmeljbAkwzhJ7m/AXDOn7+IsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313203; c=relaxed/simple;
	bh=/Oe8mL8TjjkGnR2jG5Rxs9VLauseuU6oqwYerqQXRro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXVegh48XytBWHwLxhe0TOhJXQUTJ9D4/9Y2s7u3e5PyiPP/RyrTXtNLIuIoiqIvO/lz/pDRHiIQQaP0JKvvrJaQ0T36ncuMlilLHZd8jQXmmlngWhJ99pj23aQxLO5I7rw/5/HCveAMBdhwzdcIShThU4bCHhoiLMIQC8pJTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y2tS2rwK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f3dcb2b9fso1124997e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756313200; x=1756918000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Oe8mL8TjjkGnR2jG5Rxs9VLauseuU6oqwYerqQXRro=;
        b=Y2tS2rwKaOZMyZh9ka58faXvzXrL50njDDYSugjXepp16GhbLbrRDic1EMKDEsQu7A
         Jo8yPVvxwUMzfjzBwV2r9dxBxeTg8sgMMKdtJapvfsRogNaVdSQnnGdOH4To/VCgFtyC
         CUbfx+Y3/frlByut4tTXIzvdnS1NQ/u3KJM1Vskoxza1szm03/bmnwdDzpkH5RArG2My
         2gh4gwuP36bc8X5O0lejMIEvU5eBN5SnnfgCUXUpwA1NBXYKXNpIyGPt8sbzR72Jml1z
         UlSgYZSxDKJluIOqB94vh/N4j9nleZMEJMlr/u6VmGxhfKuC3Q0WKTQtytRdteJ+0JV5
         cE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313200; x=1756918000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Oe8mL8TjjkGnR2jG5Rxs9VLauseuU6oqwYerqQXRro=;
        b=nStriF7NOL0vO9ESXB2lwplQIxF5Pa91GNTDeVIZt4hnnGCV+HF2YBnO147oI9VWwY
         wNiVx4K2j5167rMctrCQSY1ItCoPv9IfhnIxClLabvaYvD2G5oGv3wyuqb2y4gUoYoTo
         e1bXGQF13qYnifXQ4SEgbmjVd8/xIWZYHs2mphUuvJA+B+wIDhnBK5UB4DXjAFGhbnjB
         KMfLeBnhWe79fdkhGg3fc6qjoJdZsgafQKvdG2NgU4Gb2A9G5wJxqiqlmOXXUxaeQH1V
         1AM+lbCel+luz/gyWkRXUcmcYOKOK1eSE51SgxL2zFe4oVeNp6nHJQaRYRKD8HmfVCoe
         /AjA==
X-Forwarded-Encrypted: i=1; AJvYcCWayr2ZAOU3ZxHtc06v2dDhz0NdjCzOq4xkGwArGDG4VT/2AbUDj2cJDjsPlt0obaiXWZDS13bW1DtC7No=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhWOLg3vJHwarO8yjaavT37KKND+wSEmDfbYeV9B8xyRx5A0/
	sdaEzsbi6uYDXCPz87nqLfYShkPaavHpXo5txf2cvlOufFHh+Q/MfYoJjV4h0DxZkzSqv2ZlAHX
	u/jUdJmMQLt0EE3FBqzUmfG9epl+NpIcL5sDmb6JP5w==
X-Gm-Gg: ASbGnctNicf1rdRPSs6A5Zk3s3B8qfm0msfSDGOgU6onuw0KEJNaaru+1QsfRk1PixH
	59WdAF8TrZuK7aEkxuEc+Z6RNcHpTqnpmUs8bes4dP5UKR/D3clrC7Q/MRXgWxhF6QI29ncze1d
	VxROUpCR27lKmVVWyJCiII5OUMzKsKgq8FvFRH/LJbm0VTT7zhHmjGafKYcMZPXrrTHvQdYolPS
	osaxOgg6HwEIxnp3BCMP4mlUYnAWhuOonTkG6dxyAMiQZRgEw==
X-Google-Smtp-Source: AGHT+IH2vScJrK3ld667OkWoypLYcKly6TqnbjFjPvpTB4KCLVEthUMwQrvNGz6iiIbdkdd5rCAEnq3AM7MI6KeEyo4=
X-Received: by 2002:a05:6512:138c:b0:553:2969:1d6d with SMTP id
 2adb3069b0e04-55f4f4c6a98mr2026962e87.13.1756313200214; Wed, 27 Aug 2025
 09:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815-pinctrl-gpio-pinfuncs-v5-0-955de9fd91db@linaro.org>
 <CACRpkdaDGmdhaik+1saRv7Ts4myQ+tg1aQqGU3xQyT7ma8dJFw@mail.gmail.com>
 <CAHp75VephepLq61HrVy=PX2oKUQd5NK2qS-vOC5h_NR65td3Uw@mail.gmail.com>
 <CACRpkda4soRCLF5=W=6R4wnwT3pjk743j022XfJxjTTQzuarAA@mail.gmail.com>
 <534ad082-08fa-42c0-9c24-f0c11af7d5b2@sirena.org.uk> <CAMRc=Mdn0_yPXyYq4sbvH4P9-h71vEc4arLPBfSk1PiEFaB7jQ@mail.gmail.com>
 <1804d9dc-8814-47d4-af88-c819c3f17bc0@sirena.org.uk>
In-Reply-To: <1804d9dc-8814-47d4-af88-c819c3f17bc0@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Aug 2025 18:46:28 +0200
X-Gm-Features: Ac12FXzUBjVjZcm1OFCa8B8Pt22rGMmSNEEFj8GwunzU7aycJyqw28vaNlWwNSA
Message-ID: <CAMRc=MdKgqa+vjhHvD2+Tjw5NwBtFv-0aUivi5UuEQd+n4KxmA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] pinctrl: introduce the concept of a GPIO pin
 function category
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
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
	Danilo Krummrich <dakr@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:22=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Tue, Aug 26, 2025 at 08:19:37PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Aug 20, 2025 at 8:41=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Wed, Aug 20, 2025 at 09:12:49AM +0200, Linus Walleij wrote:
>
> > > > The qualcomm 32bit platforms fail in next anyway so I dropped the p=
atches
> > > > for now.
>
> > > FWIW the i.MX8MP also seems to have been broken by this:
>
> > I can't test it unfortunately - would you mind sharing some info on
> > what's failing exactly?
>
> I've just got the log I linked above.

So, I've been looking at this bisect email and clicking the links to
LAVA jobs and I can't find anything. Does it fail to build? Fail at
run-time? I'm not sure how to read this.

Bart

