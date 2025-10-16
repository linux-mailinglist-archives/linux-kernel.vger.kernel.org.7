Return-Path: <linux-kernel+bounces-855550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAFBBE19BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3762400040
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD279248868;
	Thu, 16 Oct 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tAo2SJwE"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65079246770
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594174; cv=none; b=ILD+pyldZAxYTK2AlWR5DDttqL/zk5E4wwl/kpGbVvXbGF6p6MLhl2dWLQajqjtRKyYOqjo7cf6xaXrY0pvHdH6uaQ5oc93JreuhW20768+EP861Ls5Xf0tRJkLCZ/QdAIC0M3nAMiuthMvJPwi4bHTZEMAPEOdozmIrMQxt0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594174; c=relaxed/simple;
	bh=6ycztQkvJg+KdGCCiCnENVHtBhwB6Y+p5nrVTPjvpLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWtZbP/9HaStYV8PhMaN8XYmNDovHc50ojP6PuSs9quW/qixCl00Hf6OWSHZh+ggOLKHg2eF021ciNgbmxrU4+tlDpjnQ2Vdjhgcu0fJKl8jZIGxEYcKC0ojmWdk77cAf+fnPMcBKitRy8ps8184iH+L59cOruJweiWxLHYoDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tAo2SJwE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b4f323cf89bso60042266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760594171; x=1761198971; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ycztQkvJg+KdGCCiCnENVHtBhwB6Y+p5nrVTPjvpLc=;
        b=tAo2SJwE9rpak8Mebz2GFYOXRsqg0Kq2i/y66sKssWolUVkV9CIztX8YztPD9Emt32
         XldkFvb09so7lXyzGB9nxKHBkREzD3ELC0PuwM1l+vZY/4OipY3aOWuLAT2VvkgQi0VB
         nsPrf6lmLMoG3kQm19zG4/lELk3W/6l0k4mW+xCRU5n6GgfBHz8tyBjhpF/8qZfxbYD7
         SHQi1bueqjmwosezRUMMwjH7qDKfOwL29tAlaPagOUi6HPdxINwLAMUz1PbKoVphWsK3
         GJtxP+fozZgho6HodUeDnboktHpi6RM4AV9tnj/QBjQD6QWB9FpoHKGSNB69hHaRTDFg
         tTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760594171; x=1761198971;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ycztQkvJg+KdGCCiCnENVHtBhwB6Y+p5nrVTPjvpLc=;
        b=eGg0HCwKZQQfilV5xGTXJgM4fn49AWwT9UC1q/bGcC7J6LmHA33l0tSQoTANAQ8tQL
         JceT32L7DskB6msVcirUDqhHfMYBPhjpLLRWnQIy0aVU0ydJh8RteTuYZ0B1TuZJSOwR
         0dtVGksGXp6fdJhD0ZgVdyesLF41pawGQtCbiV0O4+G15vEQE/8S5VRrsWG3eTLLnx30
         6EXzVCTqhVQE+cteIkqvBxTu6BPE6bF1VBYaBsFhc7E2mVysylLdRCGs9iyQcnJifMfo
         4SyPZR7nj9S/eL6iBQaBN03HejMl8TivP9pLDVodSZgVcYx2o5FlfxhlkoF2jUUhW3WW
         Uj4g==
X-Forwarded-Encrypted: i=1; AJvYcCWIRIYS1mksb28cOP8NcBfRmS2hZUtLiHw86Qu43GVEVAkaX/NiSG9sumVGBAa5QoEdU4NA9Mb5tjU4hPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVmc7vLwyhC1p8YT8T+9Go2c0VtyqeneNFOj+kZx+5SJyhJwR
	vTaJd4DA3wdvwUZ0rkrv0dvZx2DqLZp84+R3EO/zfG6LnJ2EpyeSOlWPOAEx7N+D64U=
X-Gm-Gg: ASbGnctBA1cZP/RxN2hMssZMqeCvB6sy01AugHLVmBqP0u6t1VEds1EGReskyEHgfqv
	aPBzmBssd1WxMJkDmHmpP+FVYhcEPzBl9fbMW/eQmhrw6tUvc0E7VlzmmyzcTQfD/RHsMJSY99s
	IG6y6MWntzX1jxYACngvZGS36Eb4Xvx16GLV9g4mdV8OP87p+viTI9SErc15gQOfIvv6ISMZOcc
	Ee9/BQnB9llfrx1G8W3LGX7QfJMTC3bt+64lnJyz4Y1cqfZdDOJqYjktolS72kPLxR3A5BYTt5p
	E8vo7TjdYxo76kyPIQd7krMauPJYvGv/RybFb/FjPIHq2yOW2KBECJwk1iuUy62GxIA3PVWRip0
	FckNjsRbK1Mum/IQ/Ak6raqtuMVs9RRtWwqzIqIBTXDhHmUsKMGdYrmjwG72+0UZBT0pFg6wKaT
	2ja3Ku1tko6LXK4kdaQw==
X-Google-Smtp-Source: AGHT+IHRn6DJcub987XbIaCnD213XxBVwA1OkaUrOOTFR+bbpHbUgS+RyDdcriH37dmE0TK4LGPTbQ==
X-Received: by 2002:a17:906:c149:b0:b41:2209:d35d with SMTP id a640c23a62f3a-b50a9d701b3mr3125674866b.1.1760594170719;
        Wed, 15 Oct 2025 22:56:10 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccaab18sm419863266b.48.2025.10.15.22.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:56:10 -0700 (PDT)
Message-ID: <30a0c50b682b990820d486e536f320c7ea31eabc.camel@linaro.org>
Subject: Re: [PATCH 3/9] arm64: dts: exynos: gs101: add sysreg_misc and
 sysreg_hsi0 nodes
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar	 <alim.akhtar@samsung.com>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sam Protsenko	
 <semen.protsenko@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, Krzysztof Kozlowski	
 <krzk@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@linaro.org>, kernel-team@android.com
Date: Thu, 16 Oct 2025 06:56:09 +0100
In-Reply-To: <20251013-automatic-clocks-v1-3-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
	 <20251013-automatic-clocks-v1-3-72851ee00300@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-13 at 21:51 +0100, Peter Griffin wrote:
> Add syscon DT node for the hsi0 and misc sysreg controllers. These will b=
e
> referenced by their respective CMU nodes in future patchs.

s/patchs/patches :-)

>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

