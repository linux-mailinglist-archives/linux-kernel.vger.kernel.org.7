Return-Path: <linux-kernel+bounces-796087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA59B3FBBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158903BE2F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C846B2F39B8;
	Tue,  2 Sep 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="za/KGQhN"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4862EDD54
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807438; cv=none; b=B3NoR6MCOh6qHo596q2TFlfq14OEY6ud+H8yGKKZ2N6UDrrpIDUXGzQCUAzs6xmI/jW0vwf656P6CxHiOumoi+zp11JjhE0ye8seQLz7e2JFPL9wZZJh453J8nb4buG+gdRTVm7xpjrKVn6XIKja4tMzgldpbFwbCascra5LQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807438; c=relaxed/simple;
	bh=RQDIbLgimVbUl3Rk1h7DgepboLPCimSzwadLXc104t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKHCrQEfPuTQhls5uu+KIFscAdJELJLnj7q57sUkN/4A9GfOkZpJMZpq9oiN0MwUAnIqh9FcHMll29jCME1mgO+C5hjBjUMkwiBSr3JPld6/3a7lmyLR0T4eUsDsawF1OXSt4aGPLU7EP8fSiCvCwpWTfqUl5rqSs9bWgeEAzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=za/KGQhN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336b071e806so33580571fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756807435; x=1757412235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQDIbLgimVbUl3Rk1h7DgepboLPCimSzwadLXc104t4=;
        b=za/KGQhN9soTtfENAe/SFQHX3+wuePlxRQc30VdCE6LoObc+AL9nT7YszLXzIiFg8O
         Pf5MqwMyCASFr9ZuIp7CcLI8Y5Rhsa9IKEfSor+zdX8Cv7sproprvkqx4XEfJpHca+zI
         IW5Ga3n7jdDqDGv1x79+0uN6Eo+w/MTXJny0s92HhkAo5GVFsYV/8IvXiLZ+7RP9xbAi
         uIIUghp75Xl9e5pboC1HydQ8FJZYBhWzNQ6CuU/k2Kmo7CPD1E3BQheRXhwi5Dv+gNJY
         fmBeEVCat6lWdBSJEzDscONDADLzIgpwXtNtKqy36Y6k4psUDbBim+QCzuvWzrODpQId
         TBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807435; x=1757412235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQDIbLgimVbUl3Rk1h7DgepboLPCimSzwadLXc104t4=;
        b=uO9A0tV7Zk5iLbSEAdxVZCpFcYiv41FFbK2Fn4AYEspP531RkdaVEXtIMkqsmzW0CS
         p+Y4X1ID2opffwULnfhsMqTSRM+9OPGlVLpm94q9oQqBOlgAtRCwlcqlbec4lwAo7vHB
         7igwSB2KIncKvY8bqU5KZePe49ZsX8JKwNWtlDmBoHl8OX80t+0LSXJK+GSvv8CrclI0
         XVf1D1pUlW5tLwVwNBE5UYLgkXkTSLXkHNRdf2Bvw5L5I5JVjJl40pHlH9dLoJ3QoQTp
         D6uTjJbgoWdwopaRxuwYXXBkejKGb6X0z9MogxkpP/BzGh0srjSuUqfvMR7/+rh/BQd0
         HEAw==
X-Forwarded-Encrypted: i=1; AJvYcCXpUrBE3Mxr3dFzrStxRn8xbUO9xynB84GSmAZGyAsUwJxKXmbCzicuCC/il/R2lJ7J9n91oHBE9CH+Ee4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zYtOvpBNQaYTtqkceMC3w78uUCZu0OALzHq4PJKLdnXkMKMq
	nSefb3RxvbJ0gCvLgUVUwwTRJ7exBv0ev4EcnuOZD6TP07yRLhMQJpVwdwwodFp3X678g8+MWNP
	wixJbYDXKBL0wnkOzny7WUEaM7H3izfOfkqPaWMKNnQ==
X-Gm-Gg: ASbGnctOCP71gApFL6TLGRS7SoydwDSwo1gaKSMDlgPq9OL+9pX1TjPN2S/5Rp//UBZ
	YHMo+cgX7BUtDIn2hlORryye2bzkqN5fQOsabSr12VK6zmX25K9kAq99ayOIF3E0wHNyUaHVqih
	xkUiNfJ3OORWAtfw8yqW96gpgdJHKozuzzc+wZ4jGDYQBiyY0l+wI18y3qOqQ1L4irtMUqNNzpz
	QARmXzrIUCiqDrwyQ==
X-Google-Smtp-Source: AGHT+IE1BlKadkaF5kTFrWzyfYeZ1gvEPDs1S73bM6siyQqc2LEO6j2N1sYbNnQdDv++P5uJf3aJ4CJmqxHTwwn+dFc=
X-Received: by 2002:a05:6512:3b0f:b0:55f:3ecd:31b9 with SMTP id
 2adb3069b0e04-55f708ec379mr2871898e87.26.1756807434523; Tue, 02 Sep 2025
 03:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org> <20250811-gpio-mmio-mfd-conv-v1-2-68c5c958cf80@linaro.org>
In-Reply-To: <20250811-gpio-mmio-mfd-conv-v1-2-68c5c958cf80@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Sep 2025 12:03:43 +0200
X-Gm-Features: Ac12FXzw139kUIsz1dfkuS3UcF1OoGTrZV60kLcfqSHr6g-PiOd7LzRx_KnI0uE
Message-ID: <CACRpkdbuoEitE6ggrmLFBhTCwRzBq4J75RPjFpKzzu=9eXzEbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: vexpress-sysreg: use new generic GPIO chip API
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lee Jones <lee@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Convert the driver to using the new generic GPIO chip interfaces from
> linux/gpio/generic.h.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

