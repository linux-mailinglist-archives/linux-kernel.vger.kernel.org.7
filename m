Return-Path: <linux-kernel+bounces-737804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B510BB0B0BD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC93AC3BF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F17270548;
	Sat, 19 Jul 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpHkZsfT"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598452AE97
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752940311; cv=none; b=OwvUtGr9TH/h5dVA7oXouhrhGuRga9uFkFMuR3dK3i98UxldYZee1sK6fZ6ugZ3Rtez8jMOIyR/5OvZAJjUtErr5gCy8VH6BIHEt2wWtq6BE5WETHxoWG0toGQCTfpeZXl0Z6hh8Xm7Zqf6XRe/bH88rhHNi9rlVbqL6+gswJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752940311; c=relaxed/simple;
	bh=xUyLwvuX8RrIJBwb9nywYEnmo/FKy04yCsP85ts1BQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwF2lzKjotIW/t5+0vcpeAajLXLes1ZZfuZ7gsFKv5XkqpXWFt3BSlAmJdr50Z/rK2wvdkKdR2gR/VbCSOnMcueVmYAqljADkAKjz3w7vVDJVsfu3NM3FIwLYBJmqgZWz2+dgQWxe3RsxbfONm2X4Y2AizEzxwo4tPBr40YJbgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hpHkZsfT; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso28494001fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752940307; x=1753545107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUyLwvuX8RrIJBwb9nywYEnmo/FKy04yCsP85ts1BQc=;
        b=hpHkZsfTqpAK1DtqNxy0JrcoZEEoKU/yllwvDC8UhO3GAeHoRS+NvKKsQYc3MREaTr
         AiGa+4bSpQcH6B/Xxfz/A6ERh3XMOc1PfnXAyeItk9aRFH+HxT85kcBxA35pg8IGnQ7F
         1M+Dp2LB5WubjwOjj5TCPpiCjH5eeRsLgEu72gjvowb1FWwIOtzsGuuZ0dnzpnWqI7QS
         wwmq9lt70FDWU7rC23mZGeWO/d/2785hEdL4K8bVhAOHXm1njOMgXING5RIZGtzTqiW1
         QOnAU8MT3nNIq7hSRMppds8a4icHksONZwNkylzN/GfEjZovD60M1R8rWdT1CA/RsVdM
         9Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752940307; x=1753545107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUyLwvuX8RrIJBwb9nywYEnmo/FKy04yCsP85ts1BQc=;
        b=gq89g2qVNRlJJzX7Zp1HxCrPYjh9szWAep3/DIB91Bm84dfU/6LCt8SL1cSoX7vDRe
         ScQL9ujc9qc/xRpHcj/4JhftNXB1qiOIY6h3fl6WYg0U69tK39hxfsRa4LiTzkzVvxxD
         4mPFA2LZYQo1aQa7GvoMw35COzeKTz1CvoH+nvAMIBGRP6pgPkcICMcCIxTx8cS5rWC7
         CUmLBpGVkcO42DiIZnGGkz3of7+aR8w2HM8rB6OHwQaHDS2Yby9k0r42cQQsn13bS9+N
         EcGsndo4SlLCJwqUMzNeSlV93+j7RfvNBrGm6zLfaHq2o7FE1wQD6x1lTlqlcnDkk4/u
         msPg==
X-Forwarded-Encrypted: i=1; AJvYcCWeGsD2ghVeAiR+gfQlw8jVaTvj3aDjD0ORgT1SdAIeP/3wA3f5I3WUQTQH6fgbGcHQxXg3pn+e4WaQpVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVl2uaqYnwaKusKtwHvCC6X1iPzA6A5UMs4ufEujFUCIIDIYBT
	GNQHHoZ02gGXiSBSN+sMqMWsibS+ttFwJ14H+1JesABEdpSu3eyXaIgK9Yltog6SMamrr+J764z
	NpU6Jhz1SdH9qbTZZcwmid25xtTTVyuw+QZ5oGAFZjA==
X-Gm-Gg: ASbGncuDHR4FyuDG2QkrsNqqCUxp4UQW9uvTGk8fPmtxNmINx0gOoYbGtKR6cdfsCfd
	oI7SUM5KkqZUMEuPtBx03W4rXKmMhAO8RBGGUT3MwC3n8udKP90vgVFrOXrBzZQ9Ps51t0+jARJ
	Cw7Y0fejKIBH2GW4ys5qCuV4tuRfk+nNoolELJvv7P9bhNCTEdp47w7ATkVytwwD69rXxYb4LHd
	eGgjP8=
X-Google-Smtp-Source: AGHT+IFXeTHhPaOyxY0Nk9agb1L0O31EoADNbqUd9xTlC8OSA53ttfdVB/jc5+To3L3KfXA2F+y39spMOsqQEmMnEHA=
X-Received: by 2002:a2e:a99f:0:b0:32a:de85:4613 with SMTP id
 38308e7fff4ca-3308e546b5cmr52460501fa.23.1752940307461; Sat, 19 Jul 2025
 08:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717131251.54021-1-brgl@bgdev.pl>
In-Reply-To: <20250717131251.54021-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 19 Jul 2025 17:51:36 +0200
X-Gm-Features: Ac12FXyWnmZ3mBsiac0JX_cSbKPzIlY5bLihE_1iOsyGvaZBUN9ieovpMR_Xnwo
Message-ID: <CACRpkdb-u1JBQykc0BdnoVE0mEHnw6ygyg0EQxziDSU50VCiNQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rp1: use new GPIO line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrea della Porta <andrea.porta@suse.com>, inux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:12=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This one isn't in the pinctrl tree, I think it's in SoC, maybe Arnd can
apply it pronto?

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

