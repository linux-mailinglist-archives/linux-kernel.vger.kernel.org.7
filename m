Return-Path: <linux-kernel+bounces-728148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38994B023F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF01173638
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132F42F8C54;
	Fri, 11 Jul 2025 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9/YF3ZZ"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCB2F8C3A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259111; cv=none; b=m69PW2XU4R8BQyFL/Yrxc+AgKFg78QD6Gs1unhTkRbGlqM7Rycj4quW4dZ3oYvriZIeENNq8QUH2UgiSk//xHz7EVkjG7u9UqZCvXTM9bpruyL9gk6TEKLVfEWbqU/WP62x0nCjhrFx94GE5MbVkrNdIr6d3AQV8DzOTJBWgf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259111; c=relaxed/simple;
	bh=2bGsXgH3DvixXtGmpviPe2FgjUQnTgNIUrHSZYwu9Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PycN1dTIRNulkCjm7lFch0ic4nnCJy4xDJbU0bIZZ0ZaD2NdESue/pLaJU5qY2SKYM19Y7BNjK43xv1Vu8C++IYWBPcM8L896FcfTK5f24Nfg71Aou0Dn2KrBMSvVy15TTMxWmBOfpgpZXdkPFxXhFmoxvFHSHxrue90D2uVuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9/YF3ZZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e5d953c0bso27942657b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752259108; x=1752863908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bGsXgH3DvixXtGmpviPe2FgjUQnTgNIUrHSZYwu9Ks=;
        b=O9/YF3ZZZexjg+p3ZweJ5j7u1Xsj2i5R/RgZ+PWDCDuq3IRosbSsvwnz1mxD2/jGTM
         pXWcAyWMqqc78om0BHtuAcyKQ7nZe/uF83jXFtKyMP9F8gBVjuQq+2bhxw4wNCVXilFh
         G9lPQYzzqTO9axpKip7uegN7w6jIt0xQ0rHgN8rmwmX8Ed9kidtRjaM+Pyw10GJRMGUu
         ph6Mg4adhA4ojkFNAJLh9ftty/+mPbA3xfS2mwqtEaB/7E6485NZkZcldwRjjrB4/pUm
         WEQLbCSqn+pW7sbM/J3VHzvueo1oYTWEvsH7g+xof35MfRt7blQe4EVIlu960geRun03
         9RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259108; x=1752863908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bGsXgH3DvixXtGmpviPe2FgjUQnTgNIUrHSZYwu9Ks=;
        b=reaDnUeeujSVlhzyCnbfOVl7s6qpyuc8a5ennOh0vTJGtYl/3ebrBzu/Ys2r/uT1WS
         Cjp6q4CwZYL+3C1dQjuzitAVu3ZNDgH3nrFH8Qh2KX/CH5BpPy0nt1SP/fPoBa38plZh
         EGOf/3UT+Ep/DWZx49aw0CQ2hz19i2tEbuV1dP5wxkLwlomnLWGS4Hc01XaK80Yt9Un5
         w0B/k8XIzDwqEdwqszdCgQTyLyWCkPWioTA5BbWyecSBWWxDTbZPaSRHIBBl6viG83Jx
         TnM/SXvpYIaYhxHPn2CnAhbbo7JO4XWN5UYVUP6K/dLj3/KD3BivdbGflOlsuvIwN+Xz
         mo4A==
X-Forwarded-Encrypted: i=1; AJvYcCVKxBLp4Dgo85BiSXEDc8v9V/V1XcqAlwXjSuVYwKrOFRd4TJiOnO/lYV8MlBbRuvrYGARPVUoLQa/6kOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2A4lbj0Zh4aQTtygnzXKGmTQcAldK5fbMZ9VIJd3VacwYVmxi
	foSMzXc36AwOcdbFeuUJXz9GTQYC8htIt9kKghsahTbJMcDRjcCHTVSq6KM/Qbw7kq1/odYx+wk
	IsZnLJuVpl41l01WefVRXz9aFxtPmKAJFVcGZSUm+gg==
X-Gm-Gg: ASbGncu2LaEPmHI0nQhHdJvg2YUDlUx/DHkvQkCCbTZv7vNGh/lpK9EDHVMwQaFtvHq
	y/UQR423uvUhclQ86brT3HGU4qPJWde6lUvcB6aOQPKjOW8FX325sukppCx4IWgA9RNp8juGRok
	ufix51IuxxL1DsBIccBNaAWYPE/8UsgSIHsWVh3rQsaqqANwKvmjdYtUfUN9KU47EHdo+3SR+Vp
	CUVcg4=
X-Google-Smtp-Source: AGHT+IFzTF2BxLSt9iuKshVeWEKTGIk56Q8yBg21xl/RCRmgu7B4ttCYb5cRb58w2puUDMxo3sDj9HkP4vtfxFSxKMk=
X-Received: by 2002:a05:690c:6108:b0:70f:83af:7db1 with SMTP id
 00721157ae682-717d5dc956emr75028347b3.19.1752259108283; Fri, 11 Jul 2025
 11:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-asoc-gpio-1-v2-0-2233b272a1a6@nxp.com> <20250710-asoc-gpio-1-v2-1-2233b272a1a6@nxp.com>
In-Reply-To: <20250710-asoc-gpio-1-v2-1-2233b272a1a6@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:38:11 +0200
X-Gm-Features: Ac12FXxYkcaMNayRRd6fAY4Lr5pyDgoW-GrE4Px5E8aOoHIoAtE2XDd36yJo0YU
Message-ID: <CACRpkdYOUUn6H3=F8Kqeb65giFkfo+7Zz0ozeG_6Ay725q9NaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ASoC: codec: tlv320aic32x4: Drop aic32x4_pdata usage
To: Peng Fan <peng.fan@nxp.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 2:42=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> There is no machine is using aic32x4_pdata as platform_data, so
> remove the dead code.
>
> Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

