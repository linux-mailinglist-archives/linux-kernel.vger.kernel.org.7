Return-Path: <linux-kernel+bounces-861807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C9EBF3B27
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3E2C350BED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7594133375F;
	Mon, 20 Oct 2025 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7tszPtK"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A65334361
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995128; cv=none; b=gQZEJaYaGgY/vxUTAwIBtYp8joIcA0vnZ4mcS8+a6raznyN8ujiL+Vp1BWDeHJsd6o8+tpKcXzaI+te73UXCpFBMpQnmMPF+CW1zEgYwMbC/7CUaK2NyrmcElsYdsxY1sd7qguTEn7HxLnlNRpVPICBDrn45e5FHHxGtbjPz9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995128; c=relaxed/simple;
	bh=vhqFHrRS3d75eDys2Z+xSehOZAf3EsLGfFSB3bsNLdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqMrS0aMp5vXgmxe4hvS6r6d2qK+NnMnS6OW7sgXhfV2FvfcZAK4eoncGOhk7SIs83QVA9+uWXB5+TGOQzh8bMxfZqUcDvA+gBjDUUKwcqai8qnYq6QlUFAF8ixEHMKJaO8ymSNY5SJXuz65VzjcmJCeBii2dxR8xlJik/Sz2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7tszPtK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-784966ad073so20582617b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760995125; x=1761599925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhqFHrRS3d75eDys2Z+xSehOZAf3EsLGfFSB3bsNLdE=;
        b=X7tszPtKLw4/vKZKMBghDdbYDxbbqs+2k2i8OhM8Dq4Vhq1mCSLMPTQoFzxhAd9WeB
         gLuTavlTThQZeBsoeOexRcLpa1u8eQpmb3w4uApzAMyLU5CLCl4Nkfb+vSGQ7iYgayeG
         E57jBxXtG+4FAOooKlD6i5bvlSDwtmk7WOiF6s2Vu/Zmh/B9YK9Wx8oVuImcWoLC3sjs
         VsOWXuMW+t731ebas0G6jQZIC50omETTMOjXA22Cwo8K631sJeQzHItD7Md7FF+yZEp0
         nXl2apPKIkW9wGtIEVovJMM4TqqwqnmgATYoXKT9SneKPsL3DPOOw7V+qjJYPH/Zh11H
         wx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995125; x=1761599925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhqFHrRS3d75eDys2Z+xSehOZAf3EsLGfFSB3bsNLdE=;
        b=GF+TFSwAXqWHtPsu+Ol+SvJsUr4BrGZBYJWTlSyIbK2EJpi1blP+iabGXVoimKJzZw
         EB6isN8CDpumEh1sqaqWJZN+uNJFZk6NSEXcChvsLTkorlwYV1bn2nxnm/0A/9NYsHFQ
         O8CQO9Wch12ZIMtwn0etXLWBz5uCfIZcQ00ae1wm/+a6JTQObxGBwwCahEsSnBAP7TXd
         Ivo+VyaVrRXH0TgID5oYf0naFrrrfzldl+/67Euh6DHbLBqOsVvl+isBO/zLzJw+pJIP
         MFGAzCNhUwjpypBBhSaoIaTZoachm6/KaCefaAQBGPSP3Xv52fz1unCNUT5MouazVSP/
         S+XA==
X-Forwarded-Encrypted: i=1; AJvYcCXGKqo2YZIyowkMQ+Ja2Lk1jz8IkctD6Bf/++Q19cdM0WqL33qdpslxoLir2Ixa3ETMWO4HosOrCEAgICY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2ZOM0ZVZ00o4ArgjVz+N8i4eONShoZwrkvBOIdAQsbjhrm4A
	xGA62zEcMXXqP2lqkaBerGONAij34GcU5NgGURxXCgjTF3fdm8QUojsHNw4BvcsvpEw8REJjJoz
	hdD/UOF0CJS+VmjbRtLqMY+395xIo7mgr7yH325nDHA==
X-Gm-Gg: ASbGncuICRPBjvxm93vgYVpjFfx7elZ/JNZBD4Y9h3j2PJtyIMnfRKLVtEhP1eT3un4
	1spvMEtKeqzE2J6P6VgYqPRPw/zN8UhioFcAdY508kSMEYDr0+g9eiyC4ZJm7YCMSyxgzvk6nkX
	S+9tCN0aNfI1LFL73I/WJW9UINnv+B2nNQrpkMISxmBNHCXtSqQssEmPw1s78l2tT7aH0DcGkuH
	kBUNwfsu17IxRgKX/Wgvwf1ZJThS9S5Ysg4V3z5zWZeVPo6zI/bZgP7Z8Kg
X-Google-Smtp-Source: AGHT+IFFZqDcL4OepPtxgrUsn0uFlGAddlKxRV2+t2Mk3zg4gYMTrsR7MP8K72yAWcdPfCwzSDaFW6FFblpoxw0wji0=
X-Received: by 2002:a05:690e:4146:b0:63e:2ac0:9019 with SMTP id
 956f58d0204a3-63e2ac093a4mr6782178d50.11.1760995125154; Mon, 20 Oct 2025
 14:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
In-Reply-To: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 23:18:32 +0200
X-Gm-Features: AS18NWB4E75rklCBn_aAVgvDZT7FC9Ws_ryqXE76wQ-YtpEHMi8QbWqbrDo34Yk
Message-ID: <CACRpkdbLRKUNUT8HfOPN9zOa6u3JyHO+K_tn76dW-CQT7oyoaA@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio: aspeed: remove the "gpiolib.h" include
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:09=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> gpiolib.h is a header internal to the GPIO core. Drivers should not
> include them. gpio-aspeed only needs to be able to determine the
> hardware offset of the GPIO given the descriptor. Expose the relevant
> symbol in the consumer header which allows us to stop pulling in the
> private one.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for cleaning this up!

Yours,
Linus Walleij

