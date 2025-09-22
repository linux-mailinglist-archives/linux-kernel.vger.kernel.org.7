Return-Path: <linux-kernel+bounces-827674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DECB92616
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC683B9396
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3670C313290;
	Mon, 22 Sep 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ch9A2iCK"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5D1A9FB6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561459; cv=none; b=nb+TUiClrylOoH4fP1LpeZm3KY0HuaR38hc/UFaLzx3fno63VvLarbFrICQVytvNJTg6WlwGTTznct6v9GYJ6YotVc96sTJPW9J/f7Jmx5psmVuUr7qUgMpbuJzkMz14flIrJ0NUZuKHad2N7i4P0BvVzX+XCOsvuw/nx9afEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561459; c=relaxed/simple;
	bh=yDCyVsMnBe1oen5dvPi/6dU/2jOJ8KUMFS4IHKbrUo0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrqhi/5dEWZ3zqw6TEQzxn7mYrZ2phhSDa28+Ql05BzIxXX5KlNw71VfKX59Ng8XWR1BZlIFJq/JT20LUp1YlKArgGVZVxnVCqCg76QFaKZ/D6+4+x8hXhecDZfld82gSFIoVFqmjlAG+aAJkY532F21BvJLDLGIWqrridulLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ch9A2iCK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57cfe6656dcso1688739e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758561456; x=1759166256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdkfUJcWiIhWIQMyk8FB1DAT7E/1t3lcPeSZOWW85BE=;
        b=Ch9A2iCKWlu/r9bbz/b7q4KA3Yuv3HZ012eCJeLS649Q1gaEYghVQbNL+nANsBzIkx
         OqgyXo3Y9mvzx/JqdcRZMdAQxuE7OXV2ZjUWx+/7TjFBqG4I4kDhV5Ka/w7d8wp5xi85
         AJ7Qcl9ZxPr0V3Au3dDHeixq8hIUr6vlS0XxqCYo7Xkkp3ek2f/4hHb405Jnif1cTSD9
         FJXNYOEUCRvGnHieT7jSo2J85KUhIoXGgkE9Ik6g1BywawF3jhD+HPX7zSyoe9l/23Ui
         NSO1Q068Ix26D4xOZBXDj3n7vkh7LZuBhxIf35SvoGuq+F4Ur3bpsQ156dSARULnm72j
         6Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561456; x=1759166256;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdkfUJcWiIhWIQMyk8FB1DAT7E/1t3lcPeSZOWW85BE=;
        b=CCOZB95NkXr8v4jej42jJH6U4CcQvvGibBtZ6XoCw/Iv+sSxRayOBnByIfbrQXQumZ
         Wu8i0j41Bv8Rp6ak4dfHFrk3i/kbiLI8WlizK2kbxzVoAekd0YYXgFWlsphD2Aqbexh+
         hBVrR7YlPbKF5G2l21u7rp56R7nCqCAuIaFRpd5nqWVXSmvM12bLSMVnIx0+UTCwLhSu
         gCaJNfC6D4Jv8lsRsrZHC8ICV/oEh/pvDarlCfIkNaSkFDyCcVsAW9riCGpyssXawHGH
         QgpkGNjmF+ADZw+MdSIDISHxQ34VYSg5/g6e97kb2tgSQrYPQDuE1ATBZ8QvjqwQXnj1
         4/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3TgxGUiIiWENJxjc504/mCf5VqMs3GSoXy7oIH49gr8sv4tYO7QbVtVTnqofz7yvN9pIPPdYj+1xlNAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFLfIPZUF6ApJr5QZBmWzKVQOm7oxzkt1/azUswXJa1vGOzP5
	UOyQhg5lTQFAAs0jNT81e28OEodOOHZMNQHU1P0ji8qgO7k7NOo0+VeOOLrq3Qrcs/9H8WqRaEv
	HucWFKN4Yv4JRasuyzekrRkj50mraeBahdjLHHZo4mO4XlWQDtPvgMT0=
X-Gm-Gg: ASbGncuu3Rj+H2VjIZrG3Q3W3e/tjcNDHEZzTtKhvabcPF9ewnobqxGsR8MDi2VE4KP
	pJ0z5FSOUfyF8JSnJ+i238q4Mz+Ypzvek5o0Vxzbc3gpefo5WAkTqyuxrM5G7PskY06ZsO4eViV
	NoEMsNZLNk7fikSf/85003gO+UKQEhYSZZ56adzNiNn7HvnwknKM4VJhJSCtnBbyUx23NoOCPdX
	YHERytA5KpnSabMxyPh8U93N9zquQcYTmwQ39FgkBAuo85h
X-Google-Smtp-Source: AGHT+IHa5VS93YBVnCqLOZY3pYwvG4eCX52nyQdKku+32y1T0vkVAt7IQymvU+hEJRGGd/QSDHyzANnwRnT18WFvHlU=
X-Received: by 2002:a05:6512:61af:b0:57d:6fca:f1f6 with SMTP id
 2adb3069b0e04-57d6fcaf45cmr2017701e87.46.1758561455821; Mon, 22 Sep 2025
 10:17:35 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 10:17:34 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 10:17:34 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250922152640.154092-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152640.154092-1-herve.codina@bootlin.com> <20250922152640.154092-6-herve.codina@bootlin.com>
Date: Mon, 22 Sep 2025 10:17:34 -0700
X-Gm-Features: AS18NWDyCQX1J8uZYK9LHdZ-e3eFX6O7LUqq1XRGpyCJLmgX9_jhMo9add6DPkE
Message-ID: <CAMRc=McFZ9rDgBEkUBuUX1c2a9PUwX3+ZzOs-KE4jhbU+p6+ww@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] ARM: dts: r9a06g032: Add GPIO controllers
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sep 2025 17:26:36 +0200, "Herve Codina (Schneider
Electric)" <herve.codina@bootlin.com> said:
> Add GPIO controllers (Synosys DesignWare IPs) available in the
> r9a06g032 (RZ/N1D) SoC.
>
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/arm/boot/dts/renesas/r9a06g032.dtsi | 121 +++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

