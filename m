Return-Path: <linux-kernel+bounces-837636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF02BACCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DED3A80EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594092F9D8E;
	Tue, 30 Sep 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeB6/Iys"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0E1DD9AD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235020; cv=none; b=E2RCXwwvRLTTY5Pd7q+WtAr1Y1riBA4XIjUPrEb27mp3UoRXId0L3ffZw0cAPwvaHlBpcW5ikuPkFq5fOCsIGULbal4A9+qO5poHnH0ry1nw6cfrI6NXxspJdHlWwxLWMq3WozMLueodXAJgBj9Sqz2RkY8fnv0x/k/ie7YW1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235020; c=relaxed/simple;
	bh=CFblSBEdSaQGPX0Gc4Q+qwyfooSQGZjP6fJV0qhJXws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dONG/2XFwyRMm5rs45aaBjUTOQaXlffTrypwPUkAtjHXOJitbYMMN2enxkP7i3+MO91NXmLp5DfDDdupJZi8lkFmJMVQ/6gBBEpEjewFTlMzgVcm1JE5D6e+GtcAu5sCmr1PJkfA/9f59iLrkovqfLo3/+HKd398g5Bf0dXc188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VeB6/Iys; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-367444a3e2aso67541591fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235017; x=1759839817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5mPBHZgztFe+UJNNaee0Rp7S41YshdGbGpEnWAlyw0=;
        b=VeB6/IysHU6UTkhoMmezC0i5vJzBLzgRMh/19vWeF7D8jw5B4rsja9YZjH8aMRw1xw
         CnZvtj8YEFLkBIivPYiE7qkA8wiw3zpREhwRqUpTmJyKNXSBM05vKlRk50IMHcxjvK61
         21g/NhbHx+tQlNcawKDn1+yX+8e5TCgt42WZVwUr37Fpt2nPnf1Vdb5+H5n9GAM7lHQO
         yKw/O0JjBCgSFR9PEGwgdzj0Uf6J3dSFf3ytAkLjdpOcHLhSS+G/lXOM6GkZktOes6Nj
         hSOf2ReqPUGL57uKMz+mxc+yZsO/oIedb/z6PF12QNUw4Bt9iqlfvstfYuJCcorGOB22
         HxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235017; x=1759839817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5mPBHZgztFe+UJNNaee0Rp7S41YshdGbGpEnWAlyw0=;
        b=ZR/uDXu3s6bj24RZ9cxjesfcD+NJTaBFPUZZ2EyccL1W+EVQyzUlmwR0CQFvk1yvVa
         +4aNupgVORQOqqvKymSaAp7Kr2yB4L0wHNHOmP9wf0tjeOEhLddLcp0Cc0UzovKwfcG0
         M9oTGwWgXfUH1gVDqGqemcecX0sKRRAECRPc04ySsrErx1ADaFTGq+9im9jgt9RrNAND
         5D+p1xU3CeXzmOW+Vk0bTiLI3Aj1V71nT231AkR71VE/yveMIPrJ1oUBnZr5a0EYZLz3
         xt/+PPPhzcrgLpbQJZC4cfr/jphZ0OkQpVgSHA+SaQVBkUVgA3ckkNj07bPRTcfQCkso
         GOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhTRMLbnlsRU8sByz4gtiqsk3dHlA2zeN58P9XQPcGf2Kfg/AEonQPaAacfHR+VaaozYqEd+pkwpmEDLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1V3tI1MwR8DsNiqyPmSWku9a1uusGs8ebjW93WKXQJc0h2DV
	hub2pjDuL0hWE4IJUPABz107Dz+lW7pQAaOyyX6A7UXzElifo3lh9Q/4f7lKP9jLJLezD8LsV0A
	FS0mDeWx8d02OTOyEXON/ttJVBUNFRFWK/NhevX0+tw==
X-Gm-Gg: ASbGncshNo+fBkzz5EHxV2uZ47cIX5ofCi+ltAubIw8khw8T8WpF/265qjCCWKC6usU
	T5vj/Iyy+Hrcs19VmfNFc13CYooXnA7W1w2Lz4mudZ9MRfT2jLNVB6YFNbC5R4YzuPFQ53WJ/Ie
	LpU7oF5TFvTJd5jh4Fb3i5qKy6M80A0RZDpvumh0ALrdZMAmdCNHfzgdDJAKtsLHrAHtjbHTULc
	R8LKQ0pZpXuDYF3cn7nin+4Hm0k56J5BuhNkKLZ3w==
X-Google-Smtp-Source: AGHT+IGSs2X9ijyFw3JfP/dbcoV1x5reGxsDzHTGImekBQcST65Fp+vF2qwnOoDfoooKD5etndPOpCBR4hOz+YmTkyE=
X-Received: by 2002:a05:651c:1541:b0:363:f65f:ddcb with SMTP id
 38308e7fff4ca-36f7d8c0278mr61009281fa.18.1759235016634; Tue, 30 Sep 2025
 05:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905135547.934729-1-antonio.borneo@foss.st.com> <20250905135547.934729-3-antonio.borneo@foss.st.com>
In-Reply-To: <20250905135547.934729-3-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Sep 2025 14:23:25 +0200
X-Gm-Features: AS18NWDLuT_uRRtCvqxguuDTeW5zZ6aEk6iy9iHLeu2I6jlVchqTLlkeIzQ-p-Y
Message-ID: <CACRpkdZCKXYEegV1cK6X9A9k8ORLWweBQs40PWYuTof3JgcC2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] dt-bindings: pincfg-node: Add property "skew-delay-direction"
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

Hi Antonio,

thanks for your patch!

And sorry that it takes so long for me to review it! :(

On Fri, Sep 5, 2025 at 3:56=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> Add the property "skew-delay-direction" to specify on which pin's
> direction (either input, output or both) the value of the generic
> property 'skew-delay' applies.
> For backward compatibility, 'skew-delay' applies on both input and
> output directions when the new property is not present or has
> value '0'.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
(...)
> +  skew-delay-direction:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    default: 0
> +    description: |
> +      0: skew-delay applies to both input and output directions
> +      1: skew-delay applies only to the output direction
> +      2: skew-delay applies only to the input direction

Unfortunately I don't think this will work, because skew-delay
has a value, and with this scheme we can only specify that we
want this value to affect both in/out, only in or only out.

What happens when someone want to configure different
skew delay for input and output?

I think it is better to add:

skew-delay-input =3D <u32>;
skew-delay-output =3D <u32>;

So the drivers that need this explicitly specified will need
to just define one of these instead.

If you want to be very determined, make the schema
not accept skew-delay if either skew-delay-input
or skew-delay-output is specified.

Yours,
Linus Walleij

