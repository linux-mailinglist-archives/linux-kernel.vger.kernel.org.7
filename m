Return-Path: <linux-kernel+bounces-743237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03130B0FC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2569556330A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEA922A4F1;
	Wed, 23 Jul 2025 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L00Ogef6"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65542226D03
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307319; cv=none; b=BOjMiGIQ/ceSbs8Smp9084cH7ybUERCFS27MU+wQaKdaYYXlsSeKoL5C+J0rvgBJM7b7Y8ANrqzsMaaGdh4VYJfszHUAFcW3kQ9Qpe/4jgN/ZCpb1ksv5xTZ4MVu6LQfu0vRwPysITFPKvRAq3UY69/ajwqLJyO5CR9cDssDT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307319; c=relaxed/simple;
	bh=hmDFVGB3e5lJKHPj2nV0N+TQauvjtNcfS7zNmuXI2+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRG7ZHMI3C0xYciP0uY8B08tKJM3M7taqFexy+EdGuwZFz7wrWODUuqKFimS+ZiFuPeGO5Lw9Lo5FJVmHVJclHoZ2fBf8t2sHt+SEMqKU4Eko+lJ50BLoLp14jatkyPCKoas8SCIldX4ZDnU9/rgLl1nbjgnb6qPB2NRhZMFYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L00Ogef6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so3509a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753307315; x=1753912115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urCBknSfoBxunYc3x4TdwqCRcefY8UK7ESNufBc9V5U=;
        b=L00Ogef6AVXYklHfKTL60sm9mYzOQqVhffloVPAHXppU6QIRTlyBY0YW4Jq7sh/9Yr
         AuoDkJAWCqG2L4FmReSWmh0b+qq+octBXu7GxV9YNvIJWquYjIWOxSh2JCwLTroiNgrA
         Sm6pFcfPUGA8j88ybJblzjaF4X0IL8Qgxk35U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753307315; x=1753912115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urCBknSfoBxunYc3x4TdwqCRcefY8UK7ESNufBc9V5U=;
        b=dDIRTnNav2xkRvH1+JOeqMXRVaBe4SVYG/V0oHfzekujLH8yW2b9C+9BTjHf0eanSU
         DSzSnZgblKYF+GI/kkRP1fMlyS/SL5MacK6qzRGXoufJfvTqS2SdNxeXRbcjKOHRpcVx
         E1/UnLQkpvSicebBHgPVNDBXGA6+GhbDmdyovrN6yel80zTzFjHfJdHWilRqQVjBq4pR
         rOTLOK9LHIG04dNngmulOyDcOwKqw//cp9wh/ctaZaPFzLfheQOEH72WV8BkVbkii1KD
         aIRPUbB9SZCKeBLtSaiEdZN2pQx2VddPprrYxFdzuQf1+Ch4YP8YSqdxLVM63NK/L94V
         rH1w==
X-Forwarded-Encrypted: i=1; AJvYcCUh0LTHiY0Jr5K4YoGnx2oxQ2SYT66k2THQsbe5uTj/41ZIFU1Be0giFYZGG/sYBvPa6w3h3AyOLJf29o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKClZbnHyCIqKtnIyBjURJsqpH0eaeWhTXiZV18KgttPIVdFUV
	ZiD9f2uAwNVsvJ5QJdlbWSA6P8SW0WwfKKF3cKb8wqwpOSVtkR84mbKm+h1GGAgl0pdyZDQGDOs
	PMPZJqPPp45t1gDVxcvA2Z+Tfqnuxjn/Ni9zc6E7W
X-Gm-Gg: ASbGncs1MDkr7BlQWaVFUMNIqvIbKxJ+cV+rs8lex74pBg8uL/y1reegER7RQkEew2q
	EVA3rV5i6MCxTamFzJ3GN0UerM/UBwaZTn8IyMwHYlgyI0xFu+BfvMRnXL+9EDMSMNUsh4A77US
	0ii+kcftohXQHcXtGTnC3eksSs8mtdwpC81BeyPWGidMBI/0u6eclBWcCVsin/9zH9xmg1Fc50b
	GSU1JYzYLZ3KOKT2wZ/0HkzMntVYYvMIP4bDNJnex5w
X-Google-Smtp-Source: AGHT+IE29O588oLM6SeiuCxCPB4k1tkTOOJCtmrayG7KngivziL2hZUa8WDJp6fjlpiSMU5FMaGeqaamK89e2HKbNPg=
X-Received: by 2002:a05:6402:cbc:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-614c4dff31amr25156a12.2.1753307314360; Wed, 23 Jul 2025
 14:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com> <20250723-ddrperfm-upstream-v4-5-1aa53ca319f4@foss.st.com>
In-Reply-To: <20250723-ddrperfm-upstream-v4-5-1aa53ca319f4@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 23 Jul 2025 14:48:21 -0700
X-Gm-Features: Ac12FXxzDR1_uTCXgfJ-I1tKRpXZw5fnYQthEfx3HR3N-6vAUe5POy6l3eogw2g
Message-ID: <CAODwPW_kex5Agqxg_i-XC308scEpUJU0me55G7iZ8nB9LC0acg@mail.gmail.com>
Subject: Re: [PATCH v4 05/20] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Gatien Chevallier <gatien.chevallier@foss.st.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Le Goffic <legoffic.clement@gmail.com>, 
	Julius Werner <jwerner@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +      Compatible strings can be either explicit vendor names and part numbers
> +      (e.g. elpida,ECB240ABACN), or generated strings of the form
> +      (lp)?ddrX-Y,Z where X, Y and Z are in lower case hexadecimal with leading
> +      zeroes and :
> +        - X is the SDRAM version (2, 3, 4, etc.)
> +        - for LPDDR :
> +          - Y is the manufacturer ID (from MR5), 2 bytes
> +          - Z is the revision ID (from MR6 and MR7), 4 bytes

It's actually one byte manufacturer, two bytes revision. The YY,ZZZZ
is supposed to represent the amount of hex digits needed.

> +        - for DDR4 with SPD, according to JEDEC SPD4.1.2.L-6 :
> +          - Y is the manufacturer ID, 2 bytes, from bytes 320 and 321
> +          - Z is the revision ID, 1 byte, from byte 349

I don't think this will identify a part unambiguously, I would expect
the DDR revision ID to be specific to the part number. (In fact, we're
also not sure whether manufacturer+revision identifies LPDDR parts
unambiguously for every vendor, we just didn't have anything more to
work with there.) I would suggest to use either `ddrX-YYYY,AAA...,ZZ`
or `ddrX-YYYY,ZZ,AAA...` (where AAA... is the part number string from
SPD 329-348 without the trailing spaces). The first version looks a
bit more natural but it might get confusing on the off chance that
someone uses a comma in a part number string.

> +      The latter form can be useful when SDRAM nodes are created at runtime by
> +      boot firmware that doesn't have access to static part number information.

nit: This text slightly doesn't make sense anymore when in the DDR
case we do actually have the part number. I guess the real thing the
bootloader wouldn't have access to is the JEDEC manufacturer ID to
name mapping.

> +      SDRAM revision ID:
> +        - LPDDR SDRAM, decoded from Mode Register 6 and 7.
> +        - DDR4 SDRAM, decoded from the SPD from bytes 349 according to
> +          JEDEC SPD4.1.2.L-6.

nit: Clarify that this is always two bytes for LPDDR and always one
byte for DDR.

> +      Density of SDRAM chip in megabits:
> +        - LPDDR SDRAM, decoded from Mode Register 8.
> +        - DDR4 SDRAM, decoded from the SPD from bytes 322 to 325 according to
> +          JEDEC SPD4.1.2.L-6.

Are these numbers correct? I downloaded SPD4.1.2.L-6 now and it looks
like 322 is manufacturing location and 323-324 are manufacturing date.
(Also, I think all of these are specific to DDR4 (and possibly 5?),
but not to earlier versions. I don't think we need to list it for
every version, but we should at least be specific what it applies to.)

