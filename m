Return-Path: <linux-kernel+bounces-743796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF5B1036F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAE81CE2F67
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3DC2749DA;
	Thu, 24 Jul 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Frpe84D3"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD359274FF5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345268; cv=none; b=RiYXz3qFhrE2qvm7Z71tLjR9ZL8LzZfh9vHVjNGYuTwEqQ/s+hseQs0wfNclZoTO9jBvkEYnvuwz8Y0dVrOKR+Ek1hHvKx7diOTrwHA1fa8vzkBkg+Udn4cwlEFJSkMC3bfdzFLSXVtOV7otDpIiu5n88FWk3Fns1alPy8rlgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345268; c=relaxed/simple;
	bh=Jeoj9tglqbA1NMZVkivEDbgZNBzAjFEQXNqjJ9m7z5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCSj2kjK+90wI2IArTkFQcCS0lJq6aBQonctmi2O38+KXUd+ewDd1Jvdkhe+ZRITsL+bUDuHlHvlN/p7TEhNTrcniorTlX8a0swLNSpGXUYxcGpaYrzbqG/r3+3TaPilOl1Dktoz8fSa/S2ZU+4Zs2YLXpMzvY0LFlM8Bstvtoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Frpe84D3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55b51713671so951929e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753345265; x=1753950065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jeoj9tglqbA1NMZVkivEDbgZNBzAjFEQXNqjJ9m7z5o=;
        b=Frpe84D3xSlII3vYvrPxAwgIQtpabuQwWMFE3c3KUAXxCkfQrgGNUL7Sh/G7DEtuVK
         j2vjXMY1a9F7a5otz2369xL46/oJmDzWg+pmYMBq6mU2kQtJxzgtVPyaD+K0CK+pLofg
         U5ferSeiDPo/Ki9a2iCSfqSkPLyYH1w1R6x6898fnohYJjZ1Tyi+bDoMz3+AhgMxxwo9
         ylmaBJO2BAHseX25OGIMJ/hxLw0I3IWHo3BpzNEhFSu9UmmPa3qDVhaQQwmINDKFwjx4
         NAxT0Ql84W2ZN07NpuUoHaZX2BqkAfO6+FH496fUN5gT3m3Z4cTjhA0/GxBYgbZSH/9z
         UQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345265; x=1753950065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jeoj9tglqbA1NMZVkivEDbgZNBzAjFEQXNqjJ9m7z5o=;
        b=DW6hYV7k4G9/2A8MFqcKUhOJ8yDWe1Up5IXeTWZHSpcbjqALKQle8j48/jDqierG/I
         6Dz35dQO8hEGyXVV8NWz03JUBfkS6kLMOfKn7pExWd5yYOL3s2oxHc1wmENKBg8zm9r6
         eqJxhWRsLEKv2LbYHaDiGcCFHoVzdORb5PMYgz/K2PxgNGObVBRei3YUAjgOtNfMW4fm
         s4q0SRchGuKyRmJkhSq4k/R2YB6ExM8EUzfcXIAhVbLxkcUA0kmiy+C5yqe+qTsht+po
         UowZTafO2gnUI2nCEt+wXl+LQs5UmfO1LtDPCG8K6T9v8kvpE8NNIK9zF1uPRNTXOCzM
         h3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXZKyS7v+8+WaAGjbCRcUoSrOlz3Qq8QpdTSbdZ7s6vtPnr5/kUliRuCK5NZjEW1SR9EPtvwvSU8zSJgWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZc5zZ7HUzZNFmaY97GPLa8v1Q0+9iEE/bjHLRo61AEg3IF4+
	33L6hrVJA7ig/4nEZzYlFI/pnsxxjCJfLce3Ng7OfMH5tgz6oFQ+jSo7CACUk6o7Py3UHXe8QxD
	sre7tozNtw/QBf42K7xX/HvR3S2IVC/4PquPC3Qa9kA==
X-Gm-Gg: ASbGnctu41mTW5UuE1ldeHVewT6zFsQ9O3Ju9Q5ZlvMav8c+cS/SLrAlbCgjM21qcNk
	Q0uz4T6tzJuufK+eVDPVpKiiEis/QFaTjhluEvpkapBin9Kt2x74iythTPsSFvp5D3MG+LPYVdw
	bFWUv9Y3pUoQQifK5CTFw0llTzYPTE2DRvyH/xlhl6OsV7kAhadGTQedb1SBRYqtgmRhUqHA/MY
	fVd3apkOaIIaxzSKg==
X-Google-Smtp-Source: AGHT+IFgj4NWeTcCOklpWerO2NLRG1ZV07PkzHyWzYdoKpwy1nHtaHQiocPmCwpZPKGCesesIznxt7/Ce26GvJafkus=
X-Received: by 2002:a05:6512:4028:b0:558:f939:4435 with SMTP id
 2adb3069b0e04-55b558b8ed8mr426827e87.13.1753345264967; Thu, 24 Jul 2025
 01:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071542.19030-1-brgl@bgdev.pl>
In-Reply-To: <20250722071542.19030-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Jul 2025 10:20:53 +0200
X-Gm-Features: Ac12FXwgRHrq4Y_NxH7wnxF43eHBfmddYtdiL0ONyJqVi-ngRTs-yiFQQ-zYlLw
Message-ID: <CACRpkdYzjrU3Rz08tkGOCBvmcdKe30zd1f0m+iJQUX57sjQoPw@mail.gmail.com>
Subject: Re: [PATCH] ARM: sa110/gpio: convert set_multiple() to returning an integer
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:15=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The conversion to using the new GPIO line setter callbacks missed the
> set_multiple() in this file. Convert it to using the new callback.
>
> Fixes: 9c3782118a57 ("ARM: sa1100/gpio: use new line value setter callbac=
ks")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

