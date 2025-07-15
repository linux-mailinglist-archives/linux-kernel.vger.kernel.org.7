Return-Path: <linux-kernel+bounces-731891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FBCB05B28
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC775647F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CC2E2F1A;
	Tue, 15 Jul 2025 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m0pE6wcl"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2962701B8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585443; cv=none; b=Cc3IZx7Um/VEJ0bstqdAO4AJD+CRkhkUrW1ZpG2SS3DjAdhzanaX0S7U8ILlsAuFi8HQpGiy+5MXOJZ4vcYSZFJPnl7aP6SGhuOU5F/KWSr5gZbC44h3bK1HSLheJLdlR3ao4aOHSkSoqWR4yLa2skS+pFrjxxcsozmjOf59XRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585443; c=relaxed/simple;
	bh=EbPOhYxKmhpuxZYPk4B6pkAFB6wXuZvAR/vSuYVQ5XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l54onHKdngKr64vcQC4X9Kwyt47dMo0+/VkE71J7B1nr98QKvBwsB/kmurc3fOvef4GRwaKGFkxc0DTnU1Ho6YjjRkH6sGt8aUV5zrnLUICsJKASe6QJ7vZ5+LNEciG+UGJ2nxyeewkndOKmBLt0Aawk0UV5xN5mS3LIxImwVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m0pE6wcl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553b16a0e38so5710185e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752585440; x=1753190240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbPOhYxKmhpuxZYPk4B6pkAFB6wXuZvAR/vSuYVQ5XA=;
        b=m0pE6wcl9/rA+zZrcKJgGP+4k0hvB0TUxfzPkMuqyTqdcwrQqUD1Q4dz770UY1P5dq
         ou8rGDrKbPjxs2F2dzgOoiMh8JQrGzU+f+S9S/hMY6HPtoUJ82xT9lg4wq3DGlapPqwk
         FeVIAAPiwQkwl07oon3Ti7I+TB/ZAT26dmIYg1VUnf+CHOQbAVYOjYkVTg6P1gNiJsMg
         yxb4rgHLpvm1+qX5AUppvm1mq3lgvZ71RMu/lZD2+MjRHkOEQQPvIJFvRXl/zpYJI6O/
         byrIND1HhswYcDapYJ6UKAegvG6ecjHLrpXTJO4jXuGvxuKMNMxpnqz5ldn1qGIHfjTE
         woNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585440; x=1753190240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbPOhYxKmhpuxZYPk4B6pkAFB6wXuZvAR/vSuYVQ5XA=;
        b=MgCl5exfv/6Ilhg4TmOPjQJroY9jd6DeQZz/2+GngiI5dZoHaa+pgyiLsjS3YynaiO
         ma84uMS1vIKojQZXn7hCKhR31Y9WBa3nqtvVN1NoGjrdGXtdd4gsbhFuPd7SJXTKXW+C
         sgaQPajaxritzUeyRCSuVgQRsnEZUSnp/D7aLxCkwF1WpMLamfcWyj1XaTwuroVCwpr8
         NHp1wN+q0kCeIXhaPdq8lFmk+D256V7xSIdeOEC/AxcxSZ97WzFX7ZnXu5oIBG5u50l/
         D1xTscsRy2YrKCgdpbJSCP6tv/fF48jOQJawZSI/+HgVCUDfHGnr05II3sL4R0JXXn1G
         PNLA==
X-Forwarded-Encrypted: i=1; AJvYcCVJG7XuukqJ4PiqxOmt3vizBCzmtdzeojf11qAQpOU7tWnJfo3CPHuuwJTC9ROd9gChLdfD2cywy09MN+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdq/8m3ocYAIkwXmizjCElRUXuWw0fYkeEM4pCK2u39fFllR2d
	RU9tjkodk1yFYhq+E8XeYWhs3YQLP6OJYWJ7JPNsoF9uP6VHeee/l2mKs+QHeGiQam5Bdk0p0Ua
	EQfPT2258D4Myncx2rPepoIOIz1PaxDc4oNfozDVq/g==
X-Gm-Gg: ASbGnctJfGNykLO3gY4iFqG5mowxXWx/22SA3Sv5DpLzJtQQGsNzkTwVLJ7wqX6LUT+
	Ke/yfzLj0Yqzv/KMQf9WNpdHr/7IwmvZ7vuTIpx7n/Xm3cOjF6WDaYUAtMcjoAh1aXY49wefnd2
	ET4MJn42kUjBLjSkVTOXYh0ROPzYx55aRtkK8jF0aro7td/qPL6kXD7zQ3UfouGIuzURWffcTfh
	o1zr3/UKodkbq9qhLmvdj/Hgb20FbAvFXbcJuk=
X-Google-Smtp-Source: AGHT+IG09J9PA2KclI10YV95njLPiWN/K6zvwX5knhUkHxQZ1/HA1h98MK7b6qFAh/thxaE0FtygrGZqtBXWqXa8aSM=
X-Received: by 2002:a05:6512:3054:b0:553:3770:c91d with SMTP id
 2adb3069b0e04-55a044d0e3amr5712015e87.4.1752585440185; Tue, 15 Jul 2025
 06:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
 <CAMRc=MfS5Em65n0fwbu8JtJsc3rTgQO5cv+PymSonJtf6_zRKQ@mail.gmail.com> <824ec6d1-4272-44c7-b3bb-93d716ed3d43@bootlin.com>
In-Reply-To: <824ec6d1-4272-44c7-b3bb-93d716ed3d43@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 15 Jul 2025 15:17:09 +0200
X-Gm-Features: Ac12FXxvAYS_y1k5VysfY5vrsZKSD3qX4LU77mI9zq4NyAOxI1SkYaUSlMb4VSs
Message-ID: <CAMRc=McnU6TO5p7Jwy-DOg_8-=AS7rFRfaPD0yH1SERWXM8L+A@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:13=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> On 6/25/25 10:26 AM, Bartosz Golaszewski wrote:
> > On Wed, Jun 11, 2025 at 11:00=E2=80=AFAM Thomas Richard
> > <thomas.richard@bootlin.com> wrote:
> >>
> >> This is the eighth version of this series. I just added a missing head=
er
> >> file in gpio-aggregator driver to fix a build warning reported by a ke=
rnel
> >> test robot [1].
> >>
> >> [1] https://lore.kernel.org/oe-kbuild-all/202506092324.XqSwWl1z-lkp@in=
tel.com/
> >>
> >> Best Regards,
> >>
> >> Thomas
> >>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> ---
> >
> > This series looks pretty good now, any objections to picking it up? As
> > usual - I can take the GPIO patches and provide an immutable branch
> > for Linus to pull.
>
> Hi Bartosz,
>
> When do you plan to pick the patches? Will it be ok for next merge window=
?
>

Well, nobody responded to my last email. This is a cross-tree series
so at least Linus must confirm he's ok.

Bart

