Return-Path: <linux-kernel+bounces-850527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192B1BD31B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185E33C3914
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C062F4A00;
	Mon, 13 Oct 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Okjf1fVl"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211F2E2F0D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360105; cv=none; b=bm/Nq+VF6xV7QKtxegQKrkICRfdWmzkvxB4S38ZFOPPOH3fyrk8LOnXkXIlUv7/LNVZ6VmSkr5KjB5g6zPubHe8Ps4pRv+UnrVotLDxlC3RzQVKfEZAwI/eEBaGYW3PP4Rg4vSTHLcy2UYyfL8TdlavyGyXl64rrceHB7p9rkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360105; c=relaxed/simple;
	bh=zt5hEVCNrevPsGcQxcV2hsOEGoKsyrOWbNv+dHo88K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrzmLSNnq8fhLV1TasPDELxEzQ/5YtjWPH/7VAODb4Zbm8EaOv3XMkX8s9KkXSklClzSUFX6gzjdgB5O4CHGweTSh3nlr67DCkvIQ5CPzt0apC0LK7kMZeG197nu0zTxZ4WIH0T0JQRlQV9DISYpfkaWAV0KQsVSvostNoMZmcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Okjf1fVl; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-371e4858f74so49466231fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760360101; x=1760964901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt5hEVCNrevPsGcQxcV2hsOEGoKsyrOWbNv+dHo88K0=;
        b=Okjf1fVloCuwHYEltROxYnd2pFlknVZ7B7amVFMf0TvT29v/ZiaAu6yGqj5UhRkVsn
         ldb1ZANPVDzhdk/9R+GUouwe+TNHn+3l0DK3VyNfmWYTMntT0PHCCSd69gP4bNqIRdwg
         vsqql6iGaU5+sQMlqO+LgXskAmil8/7G41ybn9gB10A0EhvSmglVy/1d2tvwzF3eRqnc
         6vGgrM89ZkpYHBlb76aFnODpgWdWmx41QDNzf/VQ3itHnWcyyaGOK/iwp/ZVlKvU98Pm
         2iw4Wd5j4GFnUQCt8OQqkyENvX2EtsDnsjQ/GuWzUeGWpeLQ8ll73tc2PHzwjCYtNlK0
         jF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760360101; x=1760964901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt5hEVCNrevPsGcQxcV2hsOEGoKsyrOWbNv+dHo88K0=;
        b=FN3iMOcZ2SJjVTrVyJF/yFYWzj4sGw1UVS6YxK1rRHNp11gYPhoIhsyzIuXXBEXQJ2
         B8V6tMXWXrN8YWaQ8IeoaVN36n2998/o2RnkSyCBTfWUBn1ooDwl+l3JRti5qd8Maq3F
         nmtNzWHZNrPFo7Jynat2tBjZ9DgVjqeD6Q3dZxoJxPp7+pjcCM7VM5/usl6ueyYjAujf
         Y2DK7cqJqHGLBr6JVsx/XfblnRccHeGbp4ZUe7cZ69ZddttI551ofHHIK6BVTko7z2vU
         tmMEzh/fkPqSJabeu2Kl9XJAI+J3iHvqXO96vISXGmAEy1zBOWTxHZ3tpphhYDToBtUC
         szAw==
X-Forwarded-Encrypted: i=1; AJvYcCW06A3ixxAUDO5m4NOfw5ognk7nNUCd2y7x37pR/8RqP2AUBRC0uOQLC4OAK0+X5Uedl/Vl4QeNQnFhEEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZeolcDam1ZoFk6EzkWv02MagoTBZJdgIfMpM1wFar+hx4EGK
	sZhQCM6LrPFNyWNNjbjB/imvfNlT2MGWBW1TXQl1wRe6X3LSRc/iiyIFdo2grontCK2U2c5DMgc
	NHBsExrU/WVm/FVWsP1lQDyBNnm7tIya4+3O3ZgcC8w==
X-Gm-Gg: ASbGncshlPASyUUX7P2wLq8oVowFutETnkC9Wgl52vtocu1oKKoGVbicaBTvUdd31Gm
	W1HT+SR+r7Xz8n4XkFhfvP477ffCaGXLA8Dc0wcFHSGbKmfVhVk1fzIOH9qnHbHshLiLZwhbj07
	6FaMp7sKCmoL5Yqg1wgA4I6SlWBi4OZ9HvJpyksGKSKts070s6PxrhZVajuEsZ9Wj5Q2HR2le8V
	mdnSoaUkSwS5LYlCrlGJaFeyxlci4SNGPLI5EH8
X-Google-Smtp-Source: AGHT+IEMJbNvilXOpoOIRQel6Q25owiZoIco1Kl5SF8iRX9hi7hR5hiR4i5XlKv+PrII6XXrbQ676HBjigByg+VgGMM=
X-Received: by 2002:a2e:b88e:0:b0:36c:2899:7a33 with SMTP id
 38308e7fff4ca-3760a29e503mr52205261fa.5.1760360100831; Mon, 13 Oct 2025
 05:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759824376.git.mazziesaccount@gmail.com> <ed65074dbedaf2b503d789b38bd9710926d08a55.1759824376.git.mazziesaccount@gmail.com>
In-Reply-To: <ed65074dbedaf2b503d789b38bd9710926d08a55.1759824376.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 14:54:49 +0200
X-Gm-Features: AS18NWAwGCk0eH0iAHoOmmcayEjfv4yeRrMRzIvsPRl7tRPyzzsktlv39DuLW9c
Message-ID: <CACRpkdZSiZ_74Ar+tRzVSwRW=6XoUpODyxqZDFyrc-0pcHkaPg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/13] gpio: Support ROHM BD72720 gpios
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 10:34=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> The ROHM BD72720 has 6 pins which may be configured as GPIOs. The
> GPIO1 ... GPIO5 and EPDEN pins. The configuration is done to OTP at the
> manufacturing, and it can't be read at runtime. The device-tree is
> required to tell the software which of the pins are used as GPIOs.
>
> Keep the pin mapping static regardless the OTP. This way the user-space
> can always access the BASE+N for GPIO(N+1) (N =3D 0 to 4), and BASE + 5
> for the EPDEN pin. Do this by setting always the number of GPIOs to 6,
> and by using the valid-mask to invalidate the pins which aren't configure=
d
> as GPIOs.
>
> First two pins can be set to be either input or output by OTP. Direction
> can't be changed by software. Rest of the pins can be set as outputs
> only. All of the pins support generating interrupts.
>
> Support the Input/Output state getting/setting and the output mode
> configuration (open-drain/push-pull).
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Nice use of valid-mask here!
I don't know about the special pin binding but the driver
looks good.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

