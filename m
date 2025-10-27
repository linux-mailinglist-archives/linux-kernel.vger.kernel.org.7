Return-Path: <linux-kernel+bounces-872634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA26C11A12
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD0434EE47E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4B329C4C;
	Mon, 27 Oct 2025 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtgerWjf"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B331BCBC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603105; cv=none; b=I+n2F6LjBvF7PmkA7sxX4MPF4gOXKRUtyLEKg3zrxDlkDnXqoPyiOqN7/fArvqb2JZJaUvWazApYxqrVAT/8RFmlr0IJcacsEgnXLtQsuON1xfgyLMXotT6pJAR/aedwrWdN7pMLmOT/nyNOlCX8QemFwxGQAT50MvofBCu24vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603105; c=relaxed/simple;
	bh=/tdW9Tc35Kw3/0Y5blWohgMonE+9zr16T+U6ZKHumPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3aUS0nr5lIhZZfEHc8VXUfOm9cnXFD6yuqqWNVp+/pmz6yy6PCqsnXaHjt53DGwy4TfpfjG1Cmyh8V97Yirc2G0MXOqxQER377cF+e67HNTVmcgkcPwVJqlkFseyvS4RUGZ9sGeKAEkSTcCnCy0HiNI3bjF4k8cmGa5tRzpQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JtgerWjf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59310014b8eso127788e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603102; x=1762207902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tdW9Tc35Kw3/0Y5blWohgMonE+9zr16T+U6ZKHumPk=;
        b=JtgerWjfnNGJGdZJeAneaLeKfq3MYQX1xXHFMiLMj5HLGBgHDbWAgQ4R1Ohs4D1+T1
         CBUT4Ym+w/kAIk/kN4c4UmoN+AXvHSF7FbTRszTrHf00LuS6vWKL716sjcSR6W2IJSVr
         OtF9p2ndJtjkK5ofDnyCxLqt9jY6XRMiWYG9dpFH3MvlZrHwQIkOuDZuWRclU8EnCkjb
         wosn5OsvLXe3S+d8G2rIi6UXYxqTkvb+R/bDCOuC3jRj0Shq0jIMVN0AH6zupNCjhA9b
         BJQQlZ2OKtxwQz4VoVKujIVD4U7z/4lGEFtHIrj4uQcP2ryUEsAC5LAvnR3K+qFBKxzn
         ffCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603102; x=1762207902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tdW9Tc35Kw3/0Y5blWohgMonE+9zr16T+U6ZKHumPk=;
        b=p8w+Gv5eJp/28WTXx5bAih6S+awF8H2A/B3MiEiXfDzkU5zeMBoX9sb82ng7cN2nIl
         Og/gBt/2lhVaUzUniFmaHRmns5u7U+TurPGbvoWZu2oRn03IimcKHuDI9r3/N6OeB3ik
         Z9R691x1gPSxA1y2GuXh0s+Wi09NGr9ffHrxkZNForUSfDk4VZEqhlQwvq10DFDB9idB
         Edv8QsGxKa4KeiQbDs1pWzvFhWjUdOtijw5uDLsVSy5EaDLG9aT9A6UhmrhqJcYPAYC6
         gmeFo9XypXI0EIB1p0rYnHtAV1jrS/60fsarVpILcscyYFfWN4ersclwpd96WFjJ0lUR
         +dlg==
X-Forwarded-Encrypted: i=1; AJvYcCVFlUDPUTpZt9AMAOEatLBmNNsmA2rMMjCD9VJu0broK27Y6p+7oBA+T9A/IuOLYiTk1zj1SMYPSR4XV7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjWhtYZtlspUCmAz7oBBolf6Y6L0HAdZsXMVoEZf7uqh63+tA
	03FUbHTdEXwiOg551m3I4kyKDuDD65//u1K5DfCV8f2eLyzHuIoHy/7H6yHaAARZsNQ9H5bc/HX
	9QxEwGiCSFUb3xKO6BtUEeIclrJ6SaTUXPvo8IZLsmA==
X-Gm-Gg: ASbGncvDY5Cj/BYkv8gBDQVEocok29XslqYPYW7zZ/YD55WTkcJ5vF6vFqCGxK1lQSH
	oPQBLO5/hwCLV+Wh+RKUzdpxigwH3DFA2EwEUNu3NCvFXErXGUHZzKKDbQMOHvsbCUhm0YUhVZH
	a99KJy+lP0WWVBHlZl1CxjxwWCq3yTsXeHe9ndHz4CbTMvyPnoP8M1gAZnyEHziGfA1zSDTL6wB
	tw7G1S8EocTkPq+r94qzTK/YMOJBLKPGaKC8pmwxTBS+lEpmMLjim8XioMf
X-Google-Smtp-Source: AGHT+IFLT1ZdWr/hhEMnm9sTGNuOU2VvPh+C7lrdPQU4P+9e/YVXxLQp3pBZJvB8TttzAJ2Uq4NY4gf67nRQdQ5ZGG8=
X-Received: by 2002:a05:651c:885:b0:372:9505:7256 with SMTP id
 38308e7fff4ca-37907711530mr3518411fa.30.1761603101693; Mon, 27 Oct 2025
 15:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-5-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-5-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:11:29 +0100
X-Gm-Features: AWmQ_bma_Zx4YiWdv5O86TAgEFt04A-92MDE252FFHP4HKRhB_QpFTlP5ImwzJk
Message-ID: <CACRpkdZHYWMezkPq55Xmfj9U+0pALg-DJaR2bKXA95s_ptk8-Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] dt-bindings: pincfg-node: Add properties 'skew-delay-{in,out}put-ps'
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

> Add the properties 'skew-delay-input-ps' and 'skew-delay-output-ps'
> to specify independent skew delay value for the two pin's directions.
> Make the new properties unavailable when the existing property
> 'skew-delay' is selected.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

Yours,
Linus Walleij

