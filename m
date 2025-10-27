Return-Path: <linux-kernel+bounces-872639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD08BC11A33
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6F0A4E2B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A5132B9A2;
	Mon, 27 Oct 2025 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCgMFQ4g"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC32D94A3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603245; cv=none; b=PXPmApqU1w1X2a0u4GV7A5SwTsxNaxeDQOVb7YLZXEvgafBDzS1wwWkoogFj7vQWKe8EgXJA7u66Ph85aoayOwriB/3sePzs8+Xh3M3LNY0z1xQjzX2YhKxz1DbTy5vwOk0zFTj1ShKKEmMhBv7WanIzukFyz22AuKrMohNrkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603245; c=relaxed/simple;
	bh=yDb4heLwVr8F9tF67JPmU+lJmZbzaUPek/3Lt5kxQUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW7M71jmFd/ukuo/LMIAUizQNPFESaX4THCQfdjd4qquIBsBsB6vsWZG0oe7W+KHWNflbYnvqhJhRXEoc019YQe80mx4z9fs8busckOkOvvu5rRCKGi9JYFWdhmpBg2smgMLh2Urcq15xqMLeJI1NP683o9ygJFlAUVdLonWnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vCgMFQ4g; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378d246f0f1so56286951fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603242; x=1762208042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDb4heLwVr8F9tF67JPmU+lJmZbzaUPek/3Lt5kxQUA=;
        b=vCgMFQ4ghNYXpjrB1VhA2CmXUTr9pr8OKuLwq+m3U+9vtKRgRyuSH+XHPgadYeiM1z
         eVkxCYluH/1ZnLYhqg73HDvtONnHRHASOCxrmMMAdyURD7FP7IYoRUxpUvJlFaNuXjHD
         L9Nf4NQ1naGmNp86JWhXyGFKZcYrjXptqE049B9y++gGfLVKJF8s4r6XLmauY7zSpOU/
         Qq/w6Y5S2ulOJskPT+I+qo7C9TQqlQcywTr4pS1DtEy+O6spgezH1Qy4UTujms+ZJIf3
         XRavRMvG5H+txX+aL/k2C0ZF2w0oXtXiAehin6JpA4XOO99uWTMOZ7shiWqC9JVsMHzp
         qI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603242; x=1762208042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDb4heLwVr8F9tF67JPmU+lJmZbzaUPek/3Lt5kxQUA=;
        b=r0uiQ+ZOSxXTomXfp6h/1anYbA1Mo7mj9kmxPQEk5a7UcqlXyj6c1H9ucEOyZg4c/a
         AJ7rCh33iRBijMNow/4NGlNtPI/Whjf3Rjt4D3bxk/5CM4+rzQjSp93uZsMQ/HIczesQ
         iRRrAnRJyPqzJ3kyO7Z9ZkjT0tFjO9iTNu6u1FcPvl21B5gNVRu8Qz2lQhOWey0Oq7lt
         5AnvnTpw5Yc9WHp9bd2iVJ7iQaVtNx5qRZ3WHJhuqm0Qk5OgSunohl9zAdiiIMF4UPbF
         u9phjsqKZkdmTZ90cLZAgczlz3OebCRCJwjk51kTNtG0MvbBQvGDZ/2dDAlPqs3bYYvE
         Te5g==
X-Forwarded-Encrypted: i=1; AJvYcCWY/2WpeMSfJdQhj7REzn99GSs6h02UP+VZ238lnE7xFBHHOucJ6E5+QCOWe3xlQ6tcY5OmgsZ/PD2BG4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YylY4RU+vkm1ATn3rDYZ/jJFM7SR8Hy4EdGjHQ6ChliJvWXHaWD
	Y6ECFcu4CV8amklfAtBRQiKa9bPrQhqWBLEJJJr8xla95PFv+l8OEXTQ0SXu9/idUgvgRVlDruX
	2s2roKDkVwaG2vuoXkNGmXf0ULHFvgXIW84Xr8HuiWw==
X-Gm-Gg: ASbGnctvTAe5q7M0L/cC3hfVi1Zjb9GqJFIv8LsuV2N6DkFLQpUNNKWiKGNSkfp/i9/
	+MVLhIqbc31RyRgWA19qi73i/ofAuI9PYC7njeJtFmBDbqQGMeD4lIutdYnx5VVNXKkZL/1S64H
	OicgNRPsq5NjtsiqKteasUQf7DlgCTDBREu1p11xBa2fBv3jUfD6gR+j9xv22clkYi9lOCv08Eo
	kdMTp7bE0xkSVJekqzlLQzP2/LiabDOR/AX3oeSsUYNqladze1QjowsbNT4IfwPBXoARDU=
X-Google-Smtp-Source: AGHT+IGTHGniqnqswQZQSU1fhk8hxerxmT/RZLzkXLtCHwAUJ+0N8EhP8qUlWdXk3822xFbRTLDLonsWXqEkAXahWao=
X-Received: by 2002:a05:651c:1503:b0:36a:a87c:d139 with SMTP id
 38308e7fff4ca-3790776da7emr2956771fa.42.1761603241771; Mon, 27 Oct 2025
 15:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-9-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-9-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:13:50 +0100
X-Gm-Features: AWmQ_bkjaJPnQvsqyBKfvEn0_gjRiWDur5QLSrzsQpj3h_gRODNUm-q5XFQgAKQ
Message-ID: <CACRpkdZrNKgoxy0aHTVQmyeryiDbu3Dc8FQR_KhbubwuLxcc9A@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] pinctrl: stm32: Avoid keeping a bool value in a
 u32 variable
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:27=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> Change type of variable to avoid keeping the bool return value in
> a variable of u32 type.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

Yours,
Linus Walleij

