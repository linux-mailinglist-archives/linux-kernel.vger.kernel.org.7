Return-Path: <linux-kernel+bounces-872642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34410C11A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202F53B4CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF52F39AB;
	Mon, 27 Oct 2025 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBO75K8y"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C02E8B76
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603392; cv=none; b=WUylWAO+/kv7NMeSTvKIVjQn4r8NijnF2WHV/odkxaKnWvQU9CyzLa8A5pom6QpAuv4NpIZs3WclrWOG9htxJylLWTFisV6pzeSSADLcSG9+dONxMB2ilET2GY6JgDhvaXnLVGCJ6lnGzKb4CIkkKBNox+SkaihgvJj8NzZ3ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603392; c=relaxed/simple;
	bh=Zc9UIv9/MZ8vS/A9E/+9Rzg7ZN5v4cfKPUZNZPqRWGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/7hT6pxq6SwGYqqV8yz63lQme/6Xp/LaM914zalE4NT9NetzsABmWw3rZlgGrpFZvQ2/cvpl5SK27/Y4SCGK80A8j5DMADX2dPoEDG/OtSxxTQPQz4PdrSFXVsUXJVG3M+rxAI4renBPnGj0wYq6cc5/a6xZ9HEELnYNwYhXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YBO75K8y; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378d50162e0so60555451fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603389; x=1762208189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc9UIv9/MZ8vS/A9E/+9Rzg7ZN5v4cfKPUZNZPqRWGI=;
        b=YBO75K8yUsF13/walveGNT2ZweT0wNllcspwcgJL8h3LaMCQo1lGsp9NybEP1Newyu
         +pMdrVZ6d6mbN6IigHGd2ZCFZOI0RgPjxAad0/sPa1whmuJ39p7JffuPvt3mz4TINDat
         wNR4heIFcbGrePW7FXzewvCdTlRTTrn/8tBmBmNYmtGxsm2gCTQrO32RHF/TGghyu96c
         ViljOYE+LKXhvW7e3b8Lcc93r1K28SubHSdC2f5HBIdOVC3OQ+e5r362fGjAFnGYyQ4X
         2nSjUbcmgAkyOn4xW4OCGYt23IAvRN74SN3MYNbJRHy1GN9nHe8f1l2g4EZtztx+nPaA
         AMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603389; x=1762208189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zc9UIv9/MZ8vS/A9E/+9Rzg7ZN5v4cfKPUZNZPqRWGI=;
        b=tGHi79D+UhxQouh6OpXOqkVctdcu5m3W89fxlM/nG/+Q03VW5jb88g2BQU0LM0sWdm
         n4LXGHLb64JiLr+i/cLo77hXNgRJ7MtU0JI57vhQIMG7vsdlv4AuFKnFs7fPu1ep3fck
         63rvN0KkijJQwCtlPvmK0P6DO4CDf7LKhmgZHhO5M7/+M2lPa/04cx/64w6fWmDe+C3b
         ex8I3EbnKdu26kbZREj4aPZGwOmEnyBqDb6i0FZ+B362xwQvhlxFzSPNgliBCROv+wW6
         /kgKk+cR1moRWhSa5T8UhGnjWO/gstkKDT4NDF02qauS7brG6STJcAVB/r8LwC3ES07f
         5wfw==
X-Forwarded-Encrypted: i=1; AJvYcCUZkHHpSHBThqp2RK8RG6b4tk4w0pjyKP9T9BuvGRfnhQy34/gusQi27sMRMyEZn8QgzvZpfMVYMTHi04c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrwQMFYYKKF38xwRt8xve8aCgj2V5uofNhfTerQMoFDwbh9Rn
	fCwLyacmabZ8bjHOevj46Y1AcHVTdX7NhcwynLiGm7XLISE6+f57mc/81kKGJSye89zLnU1mZsM
	Y99kz/AC6vOkt1v1hpN+LSXRvc6W93Xozc+tly+9yqA==
X-Gm-Gg: ASbGnct/13WG/HgCkCOaPITI763UOIk/nwWUy5FI7PwFfT6nGHYKwbk+WzhcEx8n3kp
	Y5fGgSCHIQEsyo2LuflamrEL0uQPCPxZbENVbzwDWJwaKMQeMgoN5xFR1irL3C1dFxduxHMiFwD
	tJWMSSsIKUaE4n1Lcih+H1PGC9uwpdV3hialzhxyBs6sQAyvI70+Y0zSRl2+4OzCMzP6n4/xpxL
	HiV2PrzcTCrvoqRaal+4MMdJKGqGYiIkWKWhDMdZQeE2I7bcfv0rS/8bTTG
X-Google-Smtp-Source: AGHT+IFA8HV2G/sHhNwZvEShaiZsTM+MMwIFC3kj57n0Kcgm/A/zFAgZaU2xFGY5jATvp1YPW4KS9FCoawvfscRyh9U=
X-Received: by 2002:a05:651c:25d7:20b0:378:d690:5d96 with SMTP id
 38308e7fff4ca-379076a9b61mr3296741fa.8.1761603388859; Mon, 27 Oct 2025
 15:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-12-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-12-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:16:17 +0100
X-Gm-Features: AWmQ_bmBzMCqn0FgOeFfQ7QhGc6mfzGjYtXO83EFE5z1zNwN1wCq6PGHLCzury8
Message-ID: <CACRpkdY-e=KT+nOaVNaEB3nFkXTrZeJ7e47LLzD46xsfzm63sA@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] dt-bindings: pinctrl: stm32: Support I/O
 synchronization parameters
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

> Document the support of the I/O synchronization parameters:
> - skew-delay-input-ps;
> - skew-delay-output-ps;
> - st,io-sync.
>
> Forbid 'skew-delay-input-ps' and 'skew-delay-output-ps' to be both
> present on the same pin.
> Allow the new properties only with compatibles that support them.
> Add an example that uses the new properties.
>
> Co-developed-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

Yours,
Linus Walleij

