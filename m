Return-Path: <linux-kernel+bounces-738806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDDB0BD56
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF27188DB17
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEC28030C;
	Mon, 21 Jul 2025 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OCKgueS2"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EE221FDC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082144; cv=none; b=MnrVTJodPhY0J0KlbWJGh8/UevjVqmzNCjFooDysmVdv2ZlybNtn+Y8N+FGfeCOl1pHrka+alUcCreoGZBmt5abBrUDghl9RJJXOZmhhy+sNr84K6Uj8oeYuu74zLmXPgm6utTIdR7OgYR9m+5fSc50GDVbuYS5X2vt71eIMQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082144; c=relaxed/simple;
	bh=3kWJntneY15F2xpfZfpWln4e6VgBuEbyGsDvbnmcEyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fg+uNlSJajPDx95J5mAUy+4deB2CrOWZwFBfzxGUgiRtcS75F/utg+1rAr0wqOZJxLy3gUJgFIVYElfpxUbDRUDxnIgxDKGEo0e+UmH8jzVWfpkuHAtOcUjldOFYhtEo8ZIlwU2vbuOM1XlXBysRoiuOqdSAAOkyr3ehiGM66OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OCKgueS2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-556fd896c99so3702896e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753082141; x=1753686941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kWJntneY15F2xpfZfpWln4e6VgBuEbyGsDvbnmcEyc=;
        b=OCKgueS2usuzji+l6JLEdK8ZMOsPBKj8dKxAP/KVb8n0TPIFZek0kwFWy990fGVAEu
         9xWxHV3Jmyc2/N7uoceSNGyQMt372SqDYUyFDrxfuaEm3FW4K7rO/O1a8lXvb5ogqlq8
         9dPaOvWLv1JlpXpMrv7yV50teqlZMMdR+amQtAtcnNRREc2LjuzXDmaatjDf17mK2ziH
         jTM749JyR5RcNJUHxpCmQm3pPyZB6glUY/ToeGIFHdB2C0lpUPsJVRz6aZydtk1Hk/BL
         S/9szWEV7O1xZoIZs+x35PvvsgHVu2UKoIkkqXKzDeMzER7U1kdT3gOMKH9j8HRR6jWR
         GrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753082141; x=1753686941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kWJntneY15F2xpfZfpWln4e6VgBuEbyGsDvbnmcEyc=;
        b=gi4RkbbFnv15nLHPikPF0pDsON4HB2xSpXXuLEWnjf+8pdCRlDkANgjuXIw0OUQMXT
         r9RREJu9gEhB2mIY2KjeTkF1KGG55mZgz2NkCGJFRY2HgQklIINibh45fOhKHiZKmJv3
         D/tz58mzZhxoiLsox6Q+F2ecRb5MQRNg2mRR8UXCKB0zOsmYiavKmInJ5VrLa5qpzVlH
         j7XxnCtSemSZJy2MZK5wcJIH38siCaK03MpQdmiDjvPArAKD3HvBZZrxElgsbeJrnY0g
         zkEJhGJk4wllwWlG7grw2lH8sLDJmv/6jzVaYeUieckyL1M5uxgbAh5QZwlM3I0HyFGt
         Ysmw==
X-Forwarded-Encrypted: i=1; AJvYcCUgIVZ3pw03eCNqFYcgUUBuJ9iVkBfVvcDRd7ajmurAgsp+XiPYp5sK3AifR/k37+zze+B/yZ5PTRTZzP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkZ4z6loNLJFfcSDGTN5Ltu3QRxUyVqK3esc+Zxf5H8L5DWqq
	vFsAjaxcbkn97v+w3F+YerkwPSvw10ML9eJtb+Rsc+YJoDrgR+fXfkrYs+le4qht/hYYABOg6dn
	KNqSBjLCd8LC1FuyybbyrjcHllropBnnxUy29sVxcoQ==
X-Gm-Gg: ASbGncsooD+Xq1JQv2E9BhoLdAJaYkpD2PLmk3IjnhiaJYR3Cyevx+Qyo+J3jovx8sN
	JGw5oyRU10Xt6/1+51gO8PX9XnliS6IChra+CNhP1GF1WLMCkJ0e20INxl7qRjYsSATkVH9GJX7
	c9HVc/3u8J34exJopXB9dEBZHjIIBOxKFBOVa+XW9Sk6lS4gLcxwFGDJ2HdKvBTLBuELrfZ6Aja
	79Ax8mT0OV/kSS/Vof1MttyOdZyiLyk1oNGH0I=
X-Google-Smtp-Source: AGHT+IHoxHLEDjHlHodorkZV1hHtJ0D4zBzlNTyb1bMriAvVHhlOrbvypWKNsHRIm0CLusBLTKbVPiMboVH4jIeM8hI=
X-Received: by 2002:a05:6512:686:b0:55a:2706:d276 with SMTP id
 2adb3069b0e04-55a2706d336mr5392459e87.28.1753082140608; Mon, 21 Jul 2025
 00:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719155825.6938-1-brgl@bgdev.pl>
In-Reply-To: <20250719155825.6938-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 21 Jul 2025 09:15:29 +0200
X-Gm-Features: Ac12FXzTVtVjmolIWgNvvEZYAdt5AC0175_ZgYHQyr1iw-_jkopUeWsIJczkdQQ
Message-ID: <CAMRc=McceMhTUbYKsWrVR5EB-+8iEvCQ7GwW+VnBGgEFeDBSVg@mail.gmail.com>
Subject: Re: [RESEND PATCH] pinctrl: rp1: use new GPIO line value setter callbacks
To: Andrea della Porta <andrea.porta@suse.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 5:58=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> This driver was not queued via the pinctrl tree as it should so it flew
> under my radar and it uses a deprecated interface that we *really* want
> to remove in v6.17. This patch addresses it. I would really appreciate
> it if it could be queued on top of the SoC tree before the merge window.
> Arnd: could you take it directly?
>

Reviewed-by: Andrea della Porta <andrea.porta@suse.com>

https://lore.kernel.org/all/aHlBZftbEphBYC83@apocalypse/

