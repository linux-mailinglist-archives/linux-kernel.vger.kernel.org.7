Return-Path: <linux-kernel+bounces-751192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49517B16640
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFC83B7BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E32E06C3;
	Wed, 30 Jul 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUHEnhZN"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006022E11DD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900205; cv=none; b=jeRmcVcfD7P+h+JuWwRBvo1TWM3c5mjvenYAYPH8UNYphnC1RNPhcLDFacAOs/fVaJTfSaGDIMdKzA4QohXeQJXgrrlbewnQz7NBP13fLfWgP8vpgDHYswvfBkwpOKHJUqv6QhEamZspg6xmT2zv0bQ5Kw+5zyqjj2ranAKy4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900205; c=relaxed/simple;
	bh=+IlnsvCqZpWI1irANdU7vC/52xTZuuB1B7d87Am81c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOgjclZauDJwdbvAyIT5OnxWjBo3gYEupC+VdK5oonOjuPiggh++HvYspVXxShqXfDRf+bfmClscnfZTwP8uKKqqLDcpGbOc3OlHnrhR1NVb/1HIflSe066bp1BTL5gcW8RnjejrHnfeG5SMuYBLXA3JoU1n9TlmPx0t9eWRmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OUHEnhZN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61543b05b7cso1822a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753900202; x=1754505002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7NIbM6q1x218b7Li1UvxruEIMKkwKF1Zyv43mPS1uqY=;
        b=OUHEnhZN94w5azEkzVDqwNxQbrmR0zEibAM/XasVXnXVjGL0j7E7BmSRNc+bAz7S4Q
         53OPHMTJ8fiBPfeF/8akZnLWWqMP0oSwW/rPr6lwyix61oSq2QbHVphJihJovHmqTBDy
         SLaEN/tShBtJW/9eexd+z/Ov+KVtC7ty5Btf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900202; x=1754505002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NIbM6q1x218b7Li1UvxruEIMKkwKF1Zyv43mPS1uqY=;
        b=IelRAkEW0+NlalMCFscvbtrS6UzjtOkN9957/TBZ963EVRwUOlrCPUAA9M2lBTKMd9
         2UEkiyBOeXfu0fwcM2b3sdKaDWrLgiNkrQDnmxac8tH49Fsdk4vwmFaPy0H2UC30BdRG
         kgYK+BLZzRzin0rEROdWmvjCFfc+ENeAO2VfDoRL64W+lwgBHw/Iz0HGoVhL+Tr8JvEd
         JO2oNXFspktM1gNyfv6xebVrMnD4MReoYzLODILpNMopuBbbEXo0kIvcXztHyM+qEJqx
         92zlNBpscSN5/8MPWiYTslPm9FBUBCG6tLNkZm9XsNCZsWIP/aw5a09vHOcnuVuVifYJ
         XZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCWFkHdRX0UUxJntg8ROc+4+GPR/dsP0zMrEVUsAkaRnaa3ON+7QunAPSAnJ/9ljzgpS2ZTx5opk+xRcF1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqV13olNZnU7qx6DFmxXBnlHLXQCm548M0cpX0cDAL1IoQ8kE
	xMwZg7oUlYN+pDoPw4IyIwSbBY9Sl4YwNJlBj3YHrpZpSBpg6dSJyAAvtZaoQrxiSMFlDUOYVDy
	kkTweRByUfUwk1/2pDMJsDGi/ExSfwyIyReS0c8E1
X-Gm-Gg: ASbGncvK/HaAFfIRhoAlb4uGIYUbsd0oe5JBvRbuTfkdpG5Hc+09i5/xvmaDkcldP/p
	6oqvDXiZazm3wupySbsBGJp+SXLn6JlTHo5nICI17fGuOiJsbYzMLyTXgnAhEGDqYOtetaW+Q1z
	FEhZYLIOblHSvsd8o5/cWdKOwmpIm9nJfzyjzoTTvtp3yXDPZJKXgRdcFQ4ovfqHcEO7COeoSck
	Lpe5vg=
X-Google-Smtp-Source: AGHT+IFbbK/ul5EAl+qpurW8QCD6MUFcOByL7/YGvDuMq5A8bS06QIOt2f3QRAN6xuePrLmBIsEPhHn7xYqFra8YQrM=
X-Received: by 2002:a05:6402:d50:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-615a5f03c3amr15582a12.2.1753900202156; Wed, 30 Jul 2025
 11:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com> <20250728-ddrperfm-upstream-v5-6-03f1be8ad396@foss.st.com>
In-Reply-To: <20250728-ddrperfm-upstream-v5-6-03f1be8ad396@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 30 Jul 2025 11:29:49 -0700
X-Gm-Features: Ac12FXzJRbNK4O4rQzoS61E9llbPlM-a0El1zXFqw746Wesi6zAN_YlMACvZJkI
Message-ID: <CAODwPW8ZXfMdFL2=6ht+BvQq5_LQkwHhQJT5j9DcseEx9naXxg@mail.gmail.com>
Subject: Re: [PATCH v5 06/20] dt-bindings: memory: introduce DDR4
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

> +title: DDR3 SDRAM compliant to JEDEC JESD79-4D

Should this say DDR4?

> +examples:
> +  - |
> +    ddr {
> +        compatible = "ddr4-ff,f", "jedec,ddr4";

This is not a valid example for the way you're defining it now anymore.

