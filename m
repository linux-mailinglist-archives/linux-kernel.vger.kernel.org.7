Return-Path: <linux-kernel+bounces-741562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75BAB0E5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4508A566523
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1511607A4;
	Tue, 22 Jul 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U4G4LDxz"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4827F171
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221466; cv=none; b=BXgJf8REu9cTPqssg+cFGDFJvzJdQAZolGLFLdhESkN9lDqGqylWDkuyeYAvH0UL9WZDur+VOkKzL81ug2oDpKgRpb1QRjwTpi6piPNskHK5FIqqYS0uyrhiS/SGPq9+C20tkkH42NC0RSl+bDeiXJ1S0d3Uapaxv8Qb4Ku5Nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221466; c=relaxed/simple;
	bh=hWtdbECSOx65U0/2471YPriOi+gPt8KDy8AE8lUQLhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mh1wy9u4k7eV0nkFQlwITVl656qXTcoyJI+zZxMpEcIzFbqxCzClMvNF0KT8OwQx0K1MvfQIhe6oovBaJ+EivBZCeq4lC0fByJ5x9oCy+yJfu1OytjmbieYFO8JKl4DKzxSMbT8skMunpOhKBNyHFiROry7IIapCLMTazKRuATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U4G4LDxz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so1999a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753221463; x=1753826263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cwvuUXqMXjlcbclmWLcZY6jJ7xmd1w9ykxymttXedcE=;
        b=U4G4LDxzVrpUkJ8xMrld7i3geG0B9tnnVrNUp44IB9vWu9qcCzXYnI/1M4BH9AFpKC
         vDskffH4E+EIl/t5HPUfktmgVp/5bcHnZAqM5hWSg7tTzG44168wEaM/G9HFpZ+Zihb+
         o+iVT+i/z7pMgJ8062M6dE/DaLOhVVisab/88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221463; x=1753826263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwvuUXqMXjlcbclmWLcZY6jJ7xmd1w9ykxymttXedcE=;
        b=lkbFWIjuBRYuI+JLJlxi3iWhmDPc8/P1u8lTkGeAiZmX/mWQibEzIbGBVdc0U4vQDs
         oFsiGU5g/zDgSUTdjNwosT2Oz506dz6nNC+o9K3dtslxL2DZZTl4oLRoz2ZVqKWi4stD
         kcCFGl/rCTfzjvBqyZBn9bG6493wdlETZUyFGLJBraJGh1ez78Bq1s55ozu4ulu9bwoD
         mmXUYJFp01iSgtkitz8ZzeReDFocMV5dpViP7lOKfEq/FXkhoY5fskDPGnhtdrm+kGwn
         bus+rsBPMK7kUaRsp3W/7O+hECb3wZlzBVDH9Wu7q3gHpu2+FpFWERBh28+eKx16N1jS
         VPGg==
X-Forwarded-Encrypted: i=1; AJvYcCXhVdqTN1Cqb3AanVrA2aIgWyVrzziIXpzHI0xcPEP3GAAO+rQ8fry4TZNc92dRkmniyjs7Ge4nmf2GiMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHllH9DvSDFOqnf5VMU2KOI9/iofIbJh22FWVShWe3N43Jd+ZA
	8e1NvoKxnyIv7EA/qD58DFIMG7MyNt8TAmzrBmgfsVt0sXM7fT0MOQqojHB+NgVUze0SfXukIPi
	DwivJDeTShgSqP10xO4YFVGG8S7vBFIjH1NRemYNd
X-Gm-Gg: ASbGncvL22cO4nY0cHN9SloVeUPHbfxU403w993/CxjwcSQSdcpP/u+u3qt6mr3/k8o
	fxbFL6kjIImCZfLbWlrbCeLtpNzYwAQshg0qzS3qSHA++buOwd24MdsPukYwb7RnUNJskXwPuSu
	yWuFmyc3+6h4ZP8Y2cpk/HNhJzDmE2/PPnvaAiza8M7RPtM9CaTIjpKPfJ5+le93JFWd2i50/Xg
	0AGq6XBB1ZYYgi/bs8mOStg79FAgfcMMgLYGgIsq1jG
X-Google-Smtp-Source: AGHT+IHkklfoV2jGZf2D1jPpYNy6n0EzpENuUlCVLYxgOK9YU79IkYyUGg7ZPnpy5rOLdzOyNuNgg4SRmVW6s9CMDc0=
X-Received: by 2002:a50:aa87:0:b0:609:99a7:efdb with SMTP id
 4fb4d7f45d1cf-6149a3beea3mr33693a12.2.1753221462404; Tue, 22 Jul 2025
 14:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com> <20250722-ddrperfm-upstream-v3-5-7b7a4f3dc8a0@foss.st.com>
In-Reply-To: <20250722-ddrperfm-upstream-v3-5-7b7a4f3dc8a0@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Tue, 22 Jul 2025 14:57:28 -0700
X-Gm-Features: Ac12FXxqqdXiBOsL8hY8DFhm2tyZoxR-txMizljLW540w1cjvBjPCidmbvKnAZQ
Message-ID: <CAODwPW_fDPY78bmwvLmLkt1yWpVdG=VC8h2NSdWtoiEknajhNw@mail.gmail.com>
Subject: Re: [PATCH v3 05/19] dt-bindings: memory: factorise LPDDR props into
 memory props
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

>        Compatible strings can be either explicit vendor names and part numbers
>        (e.g. elpida,ECB240ABACN), or generated strings of the form
>        lpddrX-YY,ZZZZ where X is the LPDDR version, YY is the manufacturer ID

When you say "in case of LPDDR" below, you should also change this
line to take other cases into account. Maybe the best way to write
this would be something like:

...or generated strings of a memory type dependent form. For LPDDR
types, that form is lpddrX-YY,ZZZZ where X is [...same text...]. For
DDR types, that form is ddrX-YY,ZZZZZ... where X is [...new definition
for DDR types, based on what's available in SPD...].

>    revision-id:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description:
> -      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
> +      Revision IDs read from Mode Register 6 and 7 in case of LPDDR.
> +      One byte per uint32 cell (i.e. <MR6 MR7>).

If this doesn't exist for DDR, then rather than "in case of LPDDR"
this should probably say something like "LPDDR only"?

>    density:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> -      Density in megabits of SDRAM chip. Decoded from Mode Register 8.
> +      Density in megabits of SDRAM chip. Decoded from Mode Register 8 in case of
> +      LPDDR.

Can you list here where in SPD density and I/O width are stored for
the various DDR types?

