Return-Path: <linux-kernel+bounces-838476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEB4BAF453
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E7F7A6C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A16126F2B9;
	Wed,  1 Oct 2025 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndZnO9j8"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BB248F57
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759300800; cv=none; b=VAhQedi+VinJn4guYq9vXfZdu73yqNYvE97FECsLUgXm/h5loNg/rPZNNghMgfJvy98ylQMjV6dnPUMDbB9DB+jlzCmCKs9tNEFmMCjZFv9q274A035Xnol/adtfTvoMBgmQ9YODpLKZEgJ+a9/Slpbd7cw5Bp3Lez0ULGprRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759300800; c=relaxed/simple;
	bh=cx98nY2Wuh/R0QLxHx+rOBNr28Ke1Ond79H5ttIERso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uojRQYAipDopPObMpP7sDibAnsQctVcCslVmhUMOficC2oGAcuLA2K6is0he4hHyfWhmDYfrRajE6SoANSLGnCLVEw6T3NEtT4pFoLdZy36HsMjLPh8VbrdF5vszNfVRvsFUxC4OSNj1A5qb6KLUTmWtRTzY2IAJHGlGy7L3q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ndZnO9j8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-36639c30bb7so67514991fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759300797; x=1759905597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx98nY2Wuh/R0QLxHx+rOBNr28Ke1Ond79H5ttIERso=;
        b=ndZnO9j89mcpnNLnCDVECygfw80JVYud/u3pVZ+yJn+UodCeVK8fQqjsq27lXqbdPa
         kUbuGkj/cPrT4e3M9gqYqHe0ub1YfltLoSqse0/HDvKs87dkOuUqBNmTxgsQE8Rcezal
         MLvoik6em8Ds6v5YxFc0ZMOE3RSUXD68NhlEHkEuFHhQK90EgfddWJWYJcWRvSNePKKU
         Sz8ZJ2W+JxYNqhRtsBvawp3T4ydnaCbwOeFxDxBl1SM8S0NPyUHs3OeivTZt64YyRA9K
         ortxV8as7MQCy32Gt7KbDocWm/SKeZQ1TbL5kliFLnCLS6d6MYW5z6ek+DJLro5Ipqby
         BH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759300797; x=1759905597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx98nY2Wuh/R0QLxHx+rOBNr28Ke1Ond79H5ttIERso=;
        b=Db8vWFjdtZe/HC9V4w/6lvECsC6LMLeBU4xfKzqHoyGicMls0lABZY2pHEJqNEHcHi
         FWXPp4mSrvkiGXpR5nN05nNZ9zPu83zrM/P6ihW4hh9/CA+eJPU/Ck0c5oeZ3LsvZDVC
         h2q3jsByN+X3fkM5blAzvZbHsO8CR66zbMwukccNl7euqsq6Vvq7SldSqPnbRymu5VeR
         VjXNRnVmv1tjbsdOGCNp3XDIec+iJ7JHZ1uu0EKXEpc8VSRCjtEtCV1HkRPqdYpk3zWY
         txBYO1VYLagWIosG3Gpi2Uv4mc92COiEFhHUFLGZNupAssNJBD1e6m/wxmHEZHlYCEUJ
         qthg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ol9GI5iu38oPTMs2h9Mrm7LXaYPyZx97ou17HBl9pkOGnKF3+h/rcU3YyKoPJlH4k+dUeE14lN/zThs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7/PwXGM3Hh+OfXxU9nT1JqgT6nO14/sxY0q3BUid92arM7ND
	3mNd72/TLte1fRqWZLlvMg0PD8aniutE/lJIU6Qs0e/vwJFEN/oDjgz2mTInAAxllAAmHjIHi/I
	9Gj0Vz8fbnf8tfEk61gNC97Sqrljle2KKEDwao7/HLw==
X-Gm-Gg: ASbGncshHIxzbNRjM6v+no7ElbNs++3OQjH0eMIJUyLGORHBQ/vKs4cNGHnEnqqKHzW
	1wR8bnDHCVpVIqVX2kEDkmo//Hoxu5ow26rVklWQwQgWwOZ9JgV5kHsqNpRkEm6zz+TyHT0pwZK
	jiII6GE+BTOcx1q/gekuazx4JUUzP81MJC0vd9dg7f7H+EVHvTLUO6gkk04X75dlytf4bzB3525
	A/gcBFhNEctB8Oa9Hr0ZGOVqtnRurg=
X-Google-Smtp-Source: AGHT+IHsjJ1uKKsfAZJeXtqlzXQ+Q2c/+ZMxDMDEIndUVBtIVCy3R9bWJv0HFWzE5Jfq4QSBRXm1ooFEPc5dvZn9AIg=
X-Received: by 2002:a05:651c:1548:b0:35f:246:a751 with SMTP id
 38308e7fff4ca-373a710a6f9mr5660521fa.5.1759300797301; Tue, 30 Sep 2025
 23:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
In-Reply-To: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 08:39:45 +0200
X-Gm-Features: AS18NWDBRp2u0dRh0NLHjgjLSPkMkLODZzx8GDSTd53SVEgMmIU0Xp0yU3m2d6w
Message-ID: <CACRpkdbgaYPVzv=MqvehDyZfF_8bMTxN=6p7qhB5cQq3wr9h0A@mail.gmail.com>
Subject: Re: [PATCH 0/4] gpio: rework debug macros
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:54=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> Rename the chip_$level() macros to gpiochip_$level() and reuse some code
> in macro definitions.
>
> No functional change.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This LGTM!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

