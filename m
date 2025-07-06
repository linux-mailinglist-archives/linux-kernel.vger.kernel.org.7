Return-Path: <linux-kernel+bounces-716845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9337DAF8B57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 10:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3CA1C23C11
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4E302CD4;
	Fri,  4 Jul 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZR2yBu8"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47075221739
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616400; cv=none; b=nXfpopDfvUWVkQyuIXOOc3lfmg1xI2T2whmbWOxvPZbP8YwyfXX/Jk5sSlkRKZs5Kj8zLKx+OD8stXfWX54/anPJKH7J9xklL4eTp/aPlzjIaxwBqyEljMw1W+uZ4hhm8ERMWPuIpptuJ8gTXfEVCVc18sJbSM+r0E7Kj+73FrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616400; c=relaxed/simple;
	bh=haPM5d9nRm0BfnEGI9y7TX96tZOk0od7CXgU7Gv9538=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJVKLzXcIFpp+hn69hDm9Ew0E6mqlOl2ufV7A0N0MnQe5HbLwZZczyaWusk/Rh98GyM1abp4Q5RytLJuolvMP/j5C9NiN1DZI6KGgbSXKni1WQHm/ytoqDzlGxOw+BX+ygQ73ejADm8JlKJZDaZsVVr47smug9bXtv+fMJt8KEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fZR2yBu8; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55628eaec6cso690030e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jul 2025 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751616395; x=1752221195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haPM5d9nRm0BfnEGI9y7TX96tZOk0od7CXgU7Gv9538=;
        b=fZR2yBu8qhWQr3O/5yFWEsVW6Ibch76DHawY+AK5C7y/xRC+UWca64kd0WDcJmbXGM
         ik0UOwJXWfUn8CAQZZ+ZvyH705VMREmrwglBwKp07XooY/+nPn5R/pNwzSWX59ncjUuD
         chBWN4xDLyF7geJv8kttxKF/eZIe1fNBVI+V/nZ7wdnqfSa5/+6od6Eu//svFQdQaUP0
         oufkjrFtcBHSAOiDDFAqgVVQjurAAJnGEr18uF8aOxXMqe1zXQU69vm3OK9YEXUQG3QR
         HxXgX8p7QnPdYBi56cr3y9S/JcbWrF6s7Za0ZwSeGV1IvXKBxr2q/nVvV4rYhSr87Abm
         FBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751616395; x=1752221195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haPM5d9nRm0BfnEGI9y7TX96tZOk0od7CXgU7Gv9538=;
        b=LTbrwqjC5DW9ovpA7XDwTunMdk9VagUBVWKdfDo5VZ8xIj4aagiR2t3XrCjnhLAuLM
         Bs/JfIuSr336vjRxu7uESOhA96m6qGkMFaiAS4rkmd0AIo0jRAgzm36Y3BZJTl1nt3Mk
         JdHL535MmaHfzQ8M/imnuCoQ91OpgDAontPT3yjJAL3GJHOpObhNzKjdmCSYy9wia5II
         dLkBwYYZcV2fd9jb3rYYaGou39vcrGEwcsJAvICm0NY2KYGXji5Ds+jklU+TcilPTaA/
         BYk9JUwOQCB/Si8Deah2pf/wqKtgIna2AaodFtsbas8v6SsWLxwnSLBa7Cxv0K11HNDC
         iBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQnruN0paoRtsgeXurq1wrTghnMdDU2dPFnO3MzIrCvDF73sKow2RtTam0rWyIbCPxM3AZ+60q07Ycq1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKflnxpRganFYPsmSbcljayI3cnZSxXr/mnjoJc1BpOLFw4+f
	R3ylSASlG3mAK6baG1572DqPNXKfpj7FK54Hh92sp6Sty9R7YiI5f0u0jew3Cyu+0JyHEdPzmb+
	tPmybJOpCTGZIHfWbUFaoO/FvnnteCn/dW/P4ejMJSw==
X-Gm-Gg: ASbGncsRPCDfPNUH8UMAk/lZhHOZBzG5BfF6TsDndHDmzGW7bw0jgk11xJATUyH69CL
	gI70eFHx8fnL0oRx1ONQU3wjh+hs+nLj48vBgBdaFDQVGB7bP9wQPQBibGpDnqjs3W8Lnimwoo2
	9/hCmS9Li5Vri9rWmjh7I+ZcxpA/2OQEHAinfeW64oO7k=
X-Google-Smtp-Source: AGHT+IGC1fZ7WIxGc1PZ1zqnEHx/TJQOH6gUMEBs/+CoI3+/ybWH75w6tyx4y7Q8INDVFcOmggBTnADBF++JnbcaNGY=
X-Received: by 2002:a05:6512:2353:b0:553:d122:f904 with SMTP id
 2adb3069b0e04-556e7db8361mr376377e87.23.1751616395273; Fri, 04 Jul 2025
 01:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-gpio-sysfs-chip-export-v3-0-b997be9b7137@linaro.org> <20250630-gpio-sysfs-chip-export-v3-8-b997be9b7137@linaro.org>
In-Reply-To: <20250630-gpio-sysfs-chip-export-v3-8-b997be9b7137@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Jul 2025 10:06:23 +0200
X-Gm-Features: Ac12FXya2RnPkR9ZwCspK7Y7sPSs3R6LeMQXGe9usMIglLbpx0bxESo_7ca8_PQ
Message-ID: <CACRpkdY-Y1c9-YTqM+xEwkWqU_uhQOPL8mmuLeJSmYy=OjAs0w@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] gpio: sysfs: export the GPIO directory locally
 in the gpiochip<id> directory
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, Kent Gibson <warthog618@gmail.com>, 
	=?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Marek Vasut <marex@denx.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:37=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> As a way to allow the user-space to stop referring to GPIOs by their
> global numbers, introduce a parallel group of line attributes for
> exported GPIO that live inside the GPIO chip class device and are
> referred to by their HW offset within their parent chip.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

