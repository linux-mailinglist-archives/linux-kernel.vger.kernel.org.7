Return-Path: <linux-kernel+bounces-790083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6AB39F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB5362A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768618EFD1;
	Thu, 28 Aug 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="anyIY6bq"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D011DC9B5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388217; cv=none; b=jiwH5sUodiKCSXyRZPXh+4Od5wzuYoGMCw8JJBMkx7XcYj3mEbDASzQpL3XZiG3CPkCnn72ioQjPGvM76JCNXEkZXMMXf1eZEWZGTBYkbD40p0kZHXyA7gcKM9V4CmUPhbDG9b26adplzwABox1ZbdWhyKN0IUXUta7y76GEYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388217; c=relaxed/simple;
	bh=Dhz0H3gxyGM+rtfeLPQ0WqeuSnXhqTSw/EjNYLEea7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/kcbeViBafQTVpoHlSjXj0JtXklT/0KkYvM54lKNWvX7GtH/fKtt/Su59SrhR8KkEDhBORQwG+w8wTooVVhzXaNBHaJgip/sTisLzyOQqrX8E7ETroGgpqdYNFs5FKBPBFbVdplO/OYjiWJorI4Q9gNy4g4pK95nEdJKFMojWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=anyIY6bq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f6017004dso632312e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756388214; x=1756993014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO3s8KTMvJZFdHoHnp5Qdx1sAV4PfJarnSm1ctLLZ3E=;
        b=anyIY6bqVld6bKz8zoUj4u6nWSrlXYXFKJEP89W77u18bB/2lG+RYlILX7aQPRPShc
         nJl6ZKM2A4uOlfQ16kJb/njGo8qy4IkWcTgx2TLc4dyU63llworYglBgTaLn3owQZ4L0
         imd5Vd2uYCxy23QscTs3SksqZWsN/oAfvVeVXfQtFM9pZLTxL1/Qw2fEncFn4cIXDx71
         zgsGax3Zka2RpeEv/ElE2kOz37Z0i6dUtst5MwCzMX3X6hjjQz/PDMQHE9HW4VXvW4Dk
         vrfoSYCc8aGrcEU5TXPVPrm7hzs9clPI/vinO7Fvu9cWxTaTUgUEwyEXZ/gx/tpIC9+m
         C3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388214; x=1756993014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO3s8KTMvJZFdHoHnp5Qdx1sAV4PfJarnSm1ctLLZ3E=;
        b=pAwqT+kshgxkK+bgkJg1uvvsRT/h++GQWK4ZsapQIWLv75OfscL/qTrlyDfIQlsNq9
         g/am4ZBtY/cGXf+7QPdXhgDPCiqn9OGqpZ7cjJ5Xv0PI8c6g6M2oRVSVzfDGYjNXPTSW
         7G7ciiGf1dK9FTvLl64Ptqt79tAdn6ubBB+rVyd5aIyc1rZMsqAk8bCOOTUP07BAlAdZ
         Oo5VT6b4HEq92gv1Y459KnZ4C79bwbGGrzCGnW4M/vy0+lraHCFjfILNgc3MCDkyZ9Go
         k8LzjkQIDciN04DnGJiknIT5pamOvVxG0DAMC1y2MpBK4b97NvpTta94PwBbDG1DI1Aa
         m/hg==
X-Forwarded-Encrypted: i=1; AJvYcCWwGpD+qxDYicrHKHce+ydwqoGpJUdn9iddnP30rrOU2ic+m+VHuPh75hfaJZJol5/3GIUky9Pzol4ihEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNzOMnE6T7oGl8gNUCPyfZE9Jcab12VmtK+o+2cEcZGo0XQdTJ
	TMYHmdmSt5uLGmsRtMotfAE655IQP1a2IrR6JOqm/1nwWkUz8/iKrmjA1RXeIUwCNhKBeRx+KAA
	xrLixb/pJRe1ox+RMP6stKiwvIo+IvJjwZOApink2tQ==
X-Gm-Gg: ASbGnculY/Vl3nb5hFDagPcnFUa2TeIKZ/V/PwrCBtfaKNYi5xvUFE8oGebtrmhjPk7
	ExO8K7ZqssVKO2X0IY5oZxVg6Fjv9Wjkjh8QsQNIc1ktBOVDFNpEMsd67btM91NR/sjsbXo6e2Q
	Andvw7m19mnQGQ4C1vSkWeWdvDpKeRB8oX+dpO87BrBaZv50R2HVObDVElGUkaMvMnmrqL0OShc
	L4chbMsSt5gsGBs1MCu0ABmWur51x/PwYcVtcI=
X-Google-Smtp-Source: AGHT+IGjT2OYHV9mzILkObbuSFLpi9Xf+oP+6Uws6rzp7smTv5kAfs8i0u8RIWSnII9gINWFQq3zddWVjDxSq4eH8MM=
X-Received: by 2002:a05:6512:245b:b0:55f:51b3:9419 with SMTP id
 2adb3069b0e04-55f51b39621mr1791521e87.50.1756388214118; Thu, 28 Aug 2025
 06:36:54 -0700 (PDT)
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
 <1804d9dc-8814-47d4-af88-c819c3f17bc0@sirena.org.uk> <CAMRc=MdKgqa+vjhHvD2+Tjw5NwBtFv-0aUivi5UuEQd+n4KxmA@mail.gmail.com>
 <aLAYoDyz8Xie4Dhb@finisterre.sirena.org.uk>
In-Reply-To: <aLAYoDyz8Xie4Dhb@finisterre.sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 28 Aug 2025 15:36:43 +0200
X-Gm-Features: Ac12FXwlaqUs0TeuR0_lKNQwkWNyJ4q4Po7liyAa4ioyozolnG0jRU9pqqtYG0I
Message-ID: <CAMRc=Mdd3fmKjFAfbUB-AAhx-5_CR+c7f36pePkF1k_2LDoORw@mail.gmail.com>
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

On Thu, Aug 28, 2025 at 10:51=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Wed, Aug 27, 2025 at 06:46:28PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Aug 27, 2025 at 12:22=E2=80=AFPM Mark Brown <broonie@kernel.org=
> wrote:
>
> > > I've just got the log I linked above.
>
> > So, I've been looking at this bisect email and clicking the links to
> > LAVA jobs and I can't find anything. Does it fail to build? Fail at
> > run-time? I'm not sure how to read this.
>
> It's failing prior to putting any output on the console.  I was also
> seeing an issue on i.MX6 so it might be all i.MX boards, same issue:
>
>    https://lava.sirena.org.uk/scheduler/job/1697667
>
> so it's possibly all the i.MX platforms failing.

Not even with earlycon? That's weird. There are no smatch warnings on
this patch and I can't see anything obviously wrong upon visual
inspection. I fixed all other issues but this one I can't test. :(

Bartosz

