Return-Path: <linux-kernel+bounces-741569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D4B0E5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D8B171096
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6528C5A0;
	Tue, 22 Jul 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UVCLt9hr"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3428C035
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221501; cv=none; b=TLUVisFoKF5vLdFM5zLQyakfT3PM8S4Q7fp/MiYhzJSde2CEZh42TLyy/F+lmERMC2aEEFiyMTKZLOCS/bc2yND3lkxoydbTRlZfFB1p+RU3j/iCbrePMUwGHdJTbPrjiKHiJTIGQ17LRngf/JcesONy/6HYIONmxB652YtPr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221501; c=relaxed/simple;
	bh=EngUjsKE6ntaSga2u9NxwJiCa0I8KWoIYhdBjksfnBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRU5zN0Sp3g47jTld7u/gcVGiCE+rdCUw6UeMkI+2xqcrdV67d94q62Xl2Ca8oBuaWmWbA5myTjQTxQHYtdkarngVAPfePSm0iRNSnUxYw6AFlQxefzKVwtK/3AzxFc5admfrPxAxKYq5fZO6V1JryQDJI/wc5vlSbwNSNx/EGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UVCLt9hr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso2202a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753221497; x=1753826297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XphRFYGKTpOm5xqnRvI7xsnYVXmfTKHiTieuuJNNgkI=;
        b=UVCLt9hrIkRO21cndqVwG+FcQW3FCo2GmRfwuZDHOlTrI7SNrja+Mpmf7h185ZpHBH
         HJny8RyTGLnAEK7fUBtNYdmPGFyHl8jSDINWskWNGEE2vM2twjUD0oAZ0W0Dt8nCS3MB
         BHBj+GuCntnl741iXcVqJ3fnk3DhBbTd2LN0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221497; x=1753826297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XphRFYGKTpOm5xqnRvI7xsnYVXmfTKHiTieuuJNNgkI=;
        b=i6TLmR9neO8cWjBe2R7B+bvzN0XM+hflDnJ5futI2bH/fAnEkC9oR9aBmBt8aHF09/
         ePx9CXRmYlsYIZCNiUMNzU2D4PxSFEt1Qh9njye+ZKKfK0jjrEUgYO+fmsC6Ob2VjFPG
         kGuPBpjDRHvH6IZXsNn6A7mN/UKzRiASjbJG3r2H8hrrMdr+EFfrUyRB7Cspah84LoTU
         P9pRVEpeCDPJR41PgC7yGQY+7tTUupakfi5BRRcQGJVYSxjKOPgmE9cJo5ZePuHLaH5p
         d04nJGpkGQJ0BU5CYfOYpXZ1JBe7bE1qGo9Lp6k+pwBlmbhgtDh34myCLQY07QdoMYDP
         dzkg==
X-Forwarded-Encrypted: i=1; AJvYcCXk9ys/2FmxkQRQIKMIAZ3rbpyVtTtqFHmrAsOiQgMPq2KTTMi3vnR0SsVRkW7A/AN53uzqla4TqwISwo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx96jWy1rlpPTjPlIXgK2LLUZw3md0noM906u/n+uDTF0hGYbJ
	UXQCpl8SoEWFvQpIYy/CD+mcLC4QLctRCXu/AZDQ6OYesopJTO3JwgF/USLicZCEioE6Ju+ZPAS
	ggcegHOIdKsrJuloZNa0H/Z+Qm3lcE2wXbEsROOb3
X-Gm-Gg: ASbGncsl9IMU9omRnkB1oIqUx/KMK+5Z6hsi89pU1mCRLY44E73enFK8uF4IJUb3M34
	U5tvimr3ITjGSF3RTu4A4lBEipMSz05tHMaKAIYsIIHvtU6bSwnjhs+jJTfQvgGAXCF11TZ6Kky
	TV4hNOshaCy+FGhds6LnTTQygId5qpy6L6xizDnZzhguHPDmzU3m+JMZmF2xCOrA6uAIITzssnA
	cbKdvOhiqRDfD0yNr81qYuFsWafegci0d0u+mDlHPJZ
X-Google-Smtp-Source: AGHT+IFp5y+l1fTW8GtjpxnnyEe4EWyuH/zYE3JF5LoJQi9huRUvCNpCO/HKD9InP/jd87P+NKE1aVh/xMR3qwPcil0=
X-Received: by 2002:a50:cd11:0:b0:612:7599:65c7 with SMTP id
 4fb4d7f45d1cf-6149ac2e0b6mr29581a12.6.1753221496595; Tue, 22 Jul 2025
 14:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com> <20250722-ddrperfm-upstream-v3-7-7b7a4f3dc8a0@foss.st.com>
In-Reply-To: <20250722-ddrperfm-upstream-v3-7-7b7a4f3dc8a0@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Tue, 22 Jul 2025 14:58:03 -0700
X-Gm-Features: Ac12FXx4M-_tpsnv6SoYOcaCR3mVKSUiARmyCSX04o5wxXNHMo0oAxmxSQQ0MIM
Message-ID: <CAODwPW-kVcnVtVakXs7aBcwb_nv0bLTaK5PKNo4zmJaJ=VC8Wg@mail.gmail.com>
Subject: Re: [PATCH v3 07/19] dt-bindings: memory: factorise LPDDR channel
 binding into memory channel
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

> +  purpose of this node is to overall memory topology of the system, including the

nit: Might take the opportunity to fix the typo here (missing words:
"is to describe the overall memory topology").

>    - Julius Werner <jwerner@chromium.org>

Why remove me? (Although I'm also not really sure why I'm maintainer
for this file and Krzysztof for all the others, tbh.)

>  examples:
>    - |

I think that's a load-bearing pipe character you're removing here?

> -    lpddr-channel0 {
> +    memory-channel0 {

Just to double-check, the name of this node doesn't really mean
anything and isn't directly interpreted by the kernel, right? I'm fine
with changing the example here to fit better with the new expanded
scope of the schema, but we have existing firmware that generates
nodes with the `lpddr-channel0` name, I want to make sure that it
won't break from making changes here.

