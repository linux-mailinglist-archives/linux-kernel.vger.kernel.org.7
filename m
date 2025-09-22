Return-Path: <linux-kernel+bounces-827434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1DBB91C29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39E31897B68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388B27F754;
	Mon, 22 Sep 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HpZE7SAf"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DB27F017
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551993; cv=none; b=WQckq6anlq2MuuIBwfvofFRQXp/SYsqUBETvCOwVgIAaPViYL4Qr+/+W8ZDyBsMeZSFxjuFIuBiofdoIK+9e38UJsI7OVevT5opLdQGLXQzfv+uEbD0HoViufreqK3MxjkoH0OCg2gOQmYJGPy5dGb+WjMs/HetzJMcDBcBYHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551993; c=relaxed/simple;
	bh=1qb/PhPcrTa7xKmIVwUMrRZk69KrdxahU7Zve9sj4Kk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5lQiXpF4BBdZ4SgFBvi7vr2dKCUFrwKvOw7g+5NrdX1vPjgKsv9xfiXUoGhR9jvqdR/uyKJ5zR0amdJ6d8k/5bSIRar4KrRsgwVfhiAUJBGFWSlQtFXQs7m35xhVV0MUE71YFtwb63m/hsKCoJ58Qu/OftyMSCMnpDpDo4r0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HpZE7SAf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36bf096b092so9080911fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758551989; x=1759156789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmPELkULJYImKCx1BhsM+Vu7fjNRwtbTTMHczanPvlU=;
        b=HpZE7SAfU3wPHIrvIh4TEl6K+nqVKQw0UmXKD8ugeOBNC1OKM0bTnk7SV+pFNpSy3W
         iuCRkM8iLwAjnsXZVkIRVUbuq10XWTKe7+i+2KCHAAWpSZoQzcD5BNTA2bumB5K+jSvT
         6+NJ4FhO1NvgbqyRzc6w/ZuVSO21fVu0aczNv1v9PmqKZPK+xycv4gTc005l9jJXEpUs
         5Kq6EWFAaYs4EYu5x2TpVTK996jdK2C/+Akvb3YBdrcoJTZYKx9ojEDxxcFaP5oPbf8a
         s+4dg41LqmJR8ftDJLWCkaSZf4e5LO5hDpXfh+tHmZKEN2SvJLkNYMARX75r0KFxf+xj
         Litw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551989; x=1759156789;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmPELkULJYImKCx1BhsM+Vu7fjNRwtbTTMHczanPvlU=;
        b=lJ96j5epVufrwy57Mn1VKR3VzIaiyo4/7VtjhF1Adr8A49mwjKVwR2snGxuj8vlnHb
         zuGj7jUoYjO+sfl6Yyl+sZ1du5kkk3/rTRyuEg2Tq0KsBqQcGexNGvpaSwHz9V5RbRkn
         nAnQnVSR/f4BN9PB+0Yy64Y/f7hqMj1HK+xyszxyyUBCHGMkc9W2tOOa7jxJo9SZk9j0
         lFdXtbyYP4kN5CRtYwfL4Sy8bb3K3ZNiQiBtkg3uD72akE7PRkEG5xhg+Md9xALZPUWX
         fzOTsw7lhniG2/7pPAhSzykxzJsyJgEIDRDCqMuM+NSliR0WEnpZWmqRfABCpp0EaMrM
         UIAw==
X-Forwarded-Encrypted: i=1; AJvYcCX7tHq00Rknq4CThCPt8SN1ISskfdnhDTnW8Q40k0ij/sGIqX0BndTliIWb5yUEoG0W5sawTFeNA/+lSy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykorWUtQm6p/BJ47UzeAkUm0qBIuvEylE6hn0+Z8Ie9KC4gYRv
	WaTvR8FcewIU9Rhs/xSt4bX6xMdzXvTigQL//c3Xpd5txtw4KEgaLfUlkLr7BONJCIqVw+5D6MC
	+e/H69UNvWFDMi2rXBIJNHi5FnGjiRB8jwLgr9TEM3g==
X-Gm-Gg: ASbGncvWzT9WfSSNjXEr5otGkYHWpsu1rngbywJhOON+yrcmRmvRo0l1GUZg4jp8Vve
	4dt/b1mS8U3okus03Y/j1/5KSxFkwG4YilXHPcopm/I7W7m1TVnZR1Sr7QIsgbgua+N/oF7HCkn
	ZnQva2W4oCWrDGJmyF3yCdxeYfhIoy+6A1JCEZ2GwqC7GBmLLLWPHQMFpAl+Id2+AUFXG1Ssfx6
	5xbADkf4CihyoSl9O2wuuhQRHRqd/B+LGmH6Q==
X-Google-Smtp-Source: AGHT+IExZvu8LaOkD+FFW6unD2a0DePvm8B7wQ5voZaVzHneD76y1XY5ORMFjW0HfESuNlENS6VkMBHIa4vtWl8+mWo=
X-Received: by 2002:a2e:a985:0:b0:36a:5be2:610c with SMTP id
 38308e7fff4ca-36a5be26b03mr17593061fa.42.1758551989460; Mon, 22 Sep 2025
 07:39:49 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 07:39:48 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 07:39:48 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250922142427.3310221-9-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922142427.3310221-1-ioana.ciornei@nxp.com> <20250922142427.3310221-9-ioana.ciornei@nxp.com>
Date: Mon, 22 Sep 2025 07:39:48 -0700
X-Gm-Features: AS18NWCusPQ_ZjuN8MoZetaRUxQ4865VBVL6jpxaDsdoZyr1QW7ZOWPBnamzLQk
Message-ID: <CAMRc=Mf0i+_1VKdumcHyK_vBU_dK5CZWhEPhUwsFX6dRyJ=sjg@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] gpio: add QIXIS FPGA GPIO controller
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sep 2025 16:24:23 +0200, Ioana Ciornei <ioana.ciornei@nxp.com> said:
> Add support for the GPIO controller found on some QIXIS FPGAs in
> Layerscape boards such as LX2160ARDB and LS1046AQDS. This driver is
> using gpio-regmap.
>
> A GPIO controller has a maximum of 8 lines (all found in the same
> register). Even within the same controller, the GPIO lines' direction is
> fixed, which mean that both input and output lines are found in the same
> register. This is why the driver also passed to gpio-regmap the newly
> added .fixed_direction_output bitmap to represent the true direction of
> the lines.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - Use the newly added .fixed_direction_output bitmap representing
>   the fixed direction of the GPIO lines.
> Changes in v3:
> - Remove 'drivers' from the commit title.
> - Remove the qixis_cpld_gpio_type enum since its not needed.
> - Remove the NULL check for device_get_match_data().
> - Use a bitmap declared on the stack as the config field passed to
>   gpio-regmap.
> Changes in v4:
> - none
> Changes in v5:
> - none
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

