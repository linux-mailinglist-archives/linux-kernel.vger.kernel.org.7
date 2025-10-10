Return-Path: <linux-kernel+bounces-848558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD97FBCE086
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E5A84EB235
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320C1E8320;
	Fri, 10 Oct 2025 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="a5tk1Q2R"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B036B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115860; cv=none; b=QHKencmtwA2LeOFXFSu23eNeut3eG7TcToEAy683GuclDf9nNVCrKBfcme/RZTkxaEMU/nrNwHvTq8szjz189QwJcgfuDVRZY4xZAlsiuBhufljuZiD277bEBq5B2u18kZDixSx6BdDMVcGbmP34kOkzAoA+49zSG/58UtfS0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115860; c=relaxed/simple;
	bh=gRT5PU7wDGh7GtgloUvjUMgoKi1g6w1VadZgRBEHa0I=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkGLABsNopTaoHUDinAaTlk+bge+10gnBJV9smuMQVSVaAJTa9gsGRgt6w3oRaC9PXh4WsgTIeRL0Whr0schZN3xFE2stYTcIjGhT80TSHcBNnCj/SznrN3ugQlPXyzHOadEI246TWoioXJXTr5tiwq2DU7OkL6t1UWBijqbyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=a5tk1Q2R; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 70A233F855
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760115856;
	bh=VMMsbHNHQlUNowhauDzTqGTgCrfFH9KMpRorSuBG4rw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=a5tk1Q2RFaKBve0xxBdEkKrQx3U5MDUNvrGH502dzk8UGJhQQtCi9eyBtTm6/ltQZ
	 Ee6kr74mZQtlNI2T9RlMspwFt3k+0S/WWhcj9F+rrPw9VunASwIQgfCYdyC7GQfzm3
	 q3+Zp7w5A3R7lym7eFcP3fp5EBJk0X60/MbUC4+G6+c+WCQZTAmrBSZB+/yoXigstf
	 rIV5ymr1lAxAQezrkKMj59Ma16tGIVR+zlqDXa/IWF8MmhWLbLy3uBALYGiiFx/7so
	 pmvCv067n5T2SB2ZuajhOORM4EkgyXRvReHRfrXjwV1BQJ+PKjDNHUECcLRVG7Q6El
	 TV+prLnDLTFApbxNu6TnGLtiZQBzzk1E8+DzS6KpsZyFXNxw3iPrP3smWYJ8CB1gtO
	 hSf7OoI+Xw2p8nbgzMMl/WZkTvpUlcEtirr3OvgHvgK7dYnCA0onesc38kJ1SLlNOm
	 VYoRXhugTWGZvvl4H7148iRjvtF38le1M26QenW7of6XlFmerUAxvBjOjwuWNCX8r9
	 bNQMRiZQmNJE7ucwL33d6N4IBRjgQewqPzsuKdlAAZVatPRDQ50m4aUSs9F9+9N0ev
	 fW2CfFwegOvotML7ymBMVt954ep+A2QRm0nRjfDAoTWELN8JVNTnADMQvKMzt4zonf
	 J+U7y+w399nIyjf49EdIfiIY=
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5b736eca1c7so5690075137.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760115854; x=1760720654;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMMsbHNHQlUNowhauDzTqGTgCrfFH9KMpRorSuBG4rw=;
        b=eMRI2a/E+QBrrKUDESd+m4wbwOdvI3Uq8srP2CVg4T1c5GnKJ1gG1EK9W79ki4Nixo
         3LLj0D3+FjpeO4NS81zXdmuM1I4fdGYa/wAWZy1+dm17zH6mjww7r8GnmahyfR7HCWmk
         +7t7zpB7OxfnoZgo6hJ2zZglegIArMMvZIhlu4DQbcwS8qNmG1XXh7ZAhF4XYti2H6c9
         A2Ve/epvWTzOClUXe1v92VtlmyS+r7uO+NzXVu+bysLDXYtqnPJrz0DgWMNLkGmjRXtp
         DXVQGEeDTeEw26OqRS59IUrBaNWJF8vVm60/G0744xhxEiV8IzbGA7Y4p46C8jGxlrHb
         Ioig==
X-Forwarded-Encrypted: i=1; AJvYcCU0suZmCrudVZB0MVNYXU7L3KvOUkp6V78ZpuZC3LwxWoGeZwFqDdAjIZhT9GpIYrl86zy/Bh1V2vDmww0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KCbMg2OrhytNGUo4j2NkJOnKaaH+0bnjNYI/0BkZrbHuAtYw
	iGHOwQ40sba5ZPfyWbfZFqfwSnktrttED+aXuV0BUKOZjYyeXUbj6OT6LcpVHU8h3lCf3q4B32I
	uPvuXUZN+WzVOhVGg077CokxjWKro21JJcs93penXyDaqbMNktqljUuEGf/iNGCesIMwg4qSQAy
	i1n1d5cDcrsK/EFjBJcNw5WATqtCCK/oPMmJcBdvdBANRDniJclyiE9PaI
X-Gm-Gg: ASbGnctHPcvpVrhp6c1xwUEPx4Hw5yfI7a3h47ieSDG3jj13NAEjK8S+CROOyGl8Rob
	OQkHUButbBTUfCJrOYheMgMofl3obW3uwqRVO0rf43/XJQ3jzwiU/waedYZNqEtzlzuiTarQtVq
	oUQxG6M5+G2/jL0KrSovQ=
X-Received: by 2002:a05:6102:3310:b0:555:56e0:f357 with SMTP id ada2fe7eead31-5d5e2351acamr6103876137.23.1760115853721;
        Fri, 10 Oct 2025 10:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBv28DNHJQ5jnD7uIITRjtmxvXAZjjFTFMwrxw+yeFjdrVbwveu4Y97WaEPytCYr30o/zb78JpBxe+rPRUAWY=
X-Received: by 2002:a05:6102:3310:b0:555:56e0:f357 with SMTP id
 ada2fe7eead31-5d5e2351acamr6103795137.23.1760115853023; Fri, 10 Oct 2025
 10:04:13 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 10:04:12 -0700
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 10:04:11 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <6fa3c728-5048-4d26-9b6f-21757320caad@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
 <20251009015839.3460231-17-samuel.holland@sifive.com> <CAJM55Z9kRpc53s3Kip=U-CcDxAX0UZD5AbTBy_owU8xPEYH5MA@mail.gmail.com>
 <6fa3c728-5048-4d26-9b6f-21757320caad@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 10 Oct 2025 10:04:11 -0700
X-Gm-Features: AS18NWCTcud7R14NP1QO40mHS3XWKKbNmY-Wviavp42FX96J5d0QmbVlv50GxHg
Message-ID: <CAJM55Z8masgGn4vVe_2g1e9WXnLu0Vf5oGxbiniGpsbOhYPLRw@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] riscv: mm: Use physical memory aliases to apply PMAs
To: Samuel Holland <samuel.holland@sifive.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	Emil Renner Berthing <kernel@esmil.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Samuel Holland wrote:
> Hi Emil,
>
> Thanks for testing!
>
> On 2025-10-10 10:06 AM, Emil Renner Berthing wrote:
> > Samuel Holland wrote:
[ .. ]
> >> +
> >> +void __init riscv_init_memory_alias(void)
> >> +{
> >> +	int na = of_n_addr_cells(of_root);
> >> +	int ns = of_n_size_cells(of_root);
> >> +	int nc = na + ns + 2;
> >> +	const __be32 *prop;
> >> +	int pairs = 0;
> >> +	int len;
> >> +
> >> +	prop = of_get_property(of_root, "riscv,physical-memory-regions", &len);
> >> +	if (!prop)
> >> +		return;
> >> +
> >> +	len /= sizeof(__be32);
> >> +	for (int i = 0; len >= nc; i++, prop += nc, len -= nc) {
> >> +		unsigned long base = of_read_ulong(prop, na);
> >> +		unsigned long size = of_read_ulong(prop + na, ns);
> >> +		unsigned long flags = be32_to_cpup(prop + na + ns);
> >> +		struct memory_alias_pair *pair;
> >> +		int alias;
> >> +
> >> +		/* We only care about non-coherent memory. */
> >> +		if ((flags & PMA_ORDER_MASK) != PMA_ORDER_MEMORY || (flags & PMA_COHERENT))
> >> +			continue;
> >> +
> >> +		/* The cacheable alias must be usable memory. */
> >> +		if ((flags & PMA_CACHEABLE) &&
> >> +		    !memblock_overlaps_region(&memblock.memory, base, size))
> >> +			continue;
> >> +
> >> +		alias = FIELD_GET(PMR_ALIAS_MASK, flags);
> >> +		if (alias) {
> >> +			pair = NULL;
> >> +			for (int j = 0; j < pairs; j++) {
> >> +				if (alias == memory_alias_pairs[j].index) {
> >> +					pair = &memory_alias_pairs[j];
> >> +					break;
> >> +				}
> >> +			}
> >> +			if (!pair)
> >> +				continue;
> >> +		} else {
> >> +			/* Leave room for the null sentinel. */
> >> +			if (pairs == ARRAY_SIZE(memory_alias_pairs) - 1)
> >> +				continue;
> >> +			pair = &memory_alias_pairs[pairs++];
> >> +			pair->index = i;
> >
> > I think this needs to be pair->index = i + 1, so PMA_ALIAS(1) can refer to the
> > first entry (i = 0).
>
> The code here is as intended. It's the PMA_ALIAS(1) in the DT that I should have
> changed to PMA_ALIAS(0) after I removed the special first entry from the
> riscv,physical-memory-regions property. Patch 18 also needs this fix.

Hmm.. that doesn't quite work for me though. Then the "if (alias)" above won't
trigger with PMR_ALIAS(0) right?

/Emil

