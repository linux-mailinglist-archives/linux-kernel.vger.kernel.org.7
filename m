Return-Path: <linux-kernel+bounces-868955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2660C06941
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03C019A727C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876762FB978;
	Fri, 24 Oct 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWYXWVxi"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23168306495
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313879; cv=none; b=Il4Los68c2JQHKc9nsEFyYRUAcVAAuIfyZaXmlzog5NHPOY78hJbXN7gHH5PhMm5vE2YZXSQGL5zBcTQudZ6Vbg7TrX5imxejQ+ibSqQPDxonj4dr6bfThnW6kEEeqysYpsIIRxN43Dg5HSpotLsSGaM4Yquq5IOxSAEv0U06wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313879; c=relaxed/simple;
	bh=2Q+hjtxKQeLXbLBHNqlPoIllo2+ofr0q84sy/acEdSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8BjFBmvb0hdG0nFWJA4Usjc2upN+RwDJQ5esJM6DXGY7Nd2M3a0ImV/G584+2CZpWcSVDoHbL1ETHJhrEmgt/ANq0xtDOJZ+RiAcEKdMFIPKiUWJmhi6eek9ayR7/yxT6RDPdKNylUNvR77sAVKK2U2xMWRHzooJLJULckXxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kWYXWVxi; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-36f51ac0595so570934fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761313877; x=1761918677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q+hjtxKQeLXbLBHNqlPoIllo2+ofr0q84sy/acEdSw=;
        b=kWYXWVxivPJor3zO1cbb2JfDM3Q+uUhUTuRs0dgQeyId3ffk4gJBtcxNSqzhVOaGi4
         mAnR6XE7iOff1lX8im1+I5QnUMdBbg7I0ddBLjOnvJ64t/4CF3K9BILAW7Oh4ymerJeq
         QCci8bQb8mS/fIOlROkcfwLiz7mBpoNPyLh9mGyAhiBkfTTvXmnna0CYQIoK5qidJX3q
         d2ZGdAnFymZOsIXPtcQ0JNDb8oouvlNF/LTsMHrUyvBZ/CbPUYjvgCk9WXE9pyhHKctS
         qQEG0jHQWN0mpU5m09RFzDsPg5f6Yz12NE3MD7sL/dFgVvYeDnDfvjoOXqWvtrQUu2Q+
         bZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313877; x=1761918677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Q+hjtxKQeLXbLBHNqlPoIllo2+ofr0q84sy/acEdSw=;
        b=hmVA3rz+n0M+zSC3laMK2yEqZjXeq+OqTz5hNoczw44E0XdY3093bgQSw3tLYu1Nuf
         MBKjYtw3ZrZGSZNylkt2RdY9UkNg0nE5Ji64rjMwuBf70Ge9+OEr/IfqqYfD1z7cilWN
         Q63goQLRLxqeAQwtIlQGFdscVTBufAYpJFlSNI8HjC1MWW9rd9fhJtavVtx/XZ4Jvjkb
         XZi+OCrR7o3ZE9GCo/FifvXdcmPQuzS39nHzSXFXDHQ8EsS4O4eWOXXvjOIcxE0v0alJ
         8NaFIjQ2cY3UIE8Riww6IKw9jhf8CmiO45Y+B1rWMwdnGI02cTNdmpIqQ/NXQDtwqo9p
         HMhg==
X-Forwarded-Encrypted: i=1; AJvYcCUWWPqSwCoslxgYrIaF8a2bplCh8juSZptRCKz+B4OpfESSyhegSzBJtEXSqHSMuhwo8Zz+gYOd+uYlvQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBw5EXOiopQj5j1ltiOA0xKERBBfME/24eCRdU/oVTe9/Jb0kn
	Pygf6hx0T7TVmFlcKA/WurCoojPerFuYEuBX/uJfmrhUEiqUuCRmIFAPsmiyVDupQYSYIrphh0M
	H5zsthYODU7aUGCtbz64ISyM7m/PBv3GbKfM7y7S8hg==
X-Gm-Gg: ASbGnctPVWhPDMyepWmPTFdNOWq3VkMHJKGyG3hrjKuu3OsNZE5uUNlAvjG0xsR2ZVl
	B6gw6gm4fJH5EEMMX7JLW9zx0NP/Tg9sFZRD0FsWFPFaWt+IKvCNWZkCTdYbnsXWPoZOeUGSNwz
	aMUvzLZvuiGgFpXMURR0B3swtrYmUxnNldhlGFWgSIJ06ncIQfdfrTQGDN1E7dUQEPOiwJVlffO
	tnAqNQq6+MK/ouLhCv3iWXwUdrMkpfZxDDZ2oN+QC3RXm25mqUXaovDROJFEA==
X-Google-Smtp-Source: AGHT+IHlphEUHdTlTQJtVbz4Rb5yJO5rZyVkkvYKLNT5GKPiTAAZeQLOg9k+GYR4etbv9qcFfzt4GYI8LyWVmzZyT20=
X-Received: by 2002:a05:6808:1907:b0:441:8f74:f44 with SMTP id
 5614622812f47-443a319d493mr11540703b6e.62.1761313876914; Fri, 24 Oct 2025
 06:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017161334.1295955-1-ivo.ivanov.ivanov1@gmail.com>
 <20251017161334.1295955-6-ivo.ivanov.ivanov1@gmail.com> <20251022-savvy-sly-auk-a60073@kuoka>
 <CADrjBPpXStuuvbaPZ+knb8fiGQja_hdX42PKfj=bTNCdXPCN9w@mail.gmail.com> <9594fa0e-22f6-4412-a967-6d5c1374da48@gmail.com>
In-Reply-To: <9594fa0e-22f6-4412-a967-6d5c1374da48@gmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 24 Oct 2025 14:51:06 +0100
X-Gm-Features: AS18NWC4v_lHSaYSR7559EcFNWgZxeNNJqRfIGOSzsUX6VCSF3TlMbDJY2BWrMY
Message-ID: <CADrjBPpmUzu=g7RfJShC_2VNnvAt9Ur5NrGbyctssyMQ0nPkmg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] clk: samsung: introduce exynos8890 clock driver
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ivaylo,

On Fri, 24 Oct 2025 at 13:34, Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
> On 10/24/25 15:07, Peter Griffin wrote:
> > Hi Ivaylo & Krzysztof,
> >
> > On Wed, 22 Oct 2025 at 08:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On Fri, Oct 17, 2025 at 07:13:33PM +0300, Ivaylo Ivanov wrote:
> >>> Introduce a clocks management driver for exynos8890, providing clocks
> >>> for the peripherals of that SoC.
> >>>
> >>> As exynos8890 is the first exynos SoC to feature Hardware Auto Clock
> >>> Gating (HWACG), it differs from newer SoCs. Q-channel and Q-state bits
> >>> are separate registers, unlike the CLK_CON_GAT_* ones that feature HWACG
> >>> bits in the same register that controls manual gating. Hence, don't use
> >>> the clk-exynos-arm64 helper, but implement logic that enforces manual
> >>> gating.
> > For sure it isn't the only upstream SoC with HWACG, gs101 and e850 and
> > probably lots of Exynos SoCs have it. Whether it is the "first" in
> > terms of release date of the SoC I don't know
>
> Huh? Samsung hasn't released a lot of exynos chips and you're free to check
> kernel sources if curious. Exynos 7420 didn't have HWACG, 8890 and 8895
> have it. Exynos 7870 (roughly same gen as 8890, but budget lineup) doesn't
> have it.

I'll take your word for it!
>
> > , unless there is some comment in
> > downstream code to that effect). Your CMU registers do look like a
> > different layout though.
>
> Exactly. First implementation/gen of HWACG == lots of room to improve.
> Which they did, and this is what I implied here. I can word it differently
> though, to be more clear.

Ok, that makes sense. If it can be slightly reworded to make that
clearer, as I found it slightly ambiguous on "first read".

>
> > Just fyi gs101 also has Q-Channel registers that contain HWACG Enable
> > bits. The reset state of all these bits on gs101 (both for QCH_CON_XXX
> > registers, QCH_EN bit and HWACG bit in CLK_CON_GAT_* regs is off). In
> > my case I suspect the bootloader doesn't initialize any of them
> > because of the CMUs "global enable override" bits in the CMU_OPTION
> > register (which is initialized by the bootloader).
>
> Well, to be fair, without any documentations or bootloader sources there's
> so much so I can do. The vendor kernel also force disables the qchannel
> registers, hence the assumption.

Sure, I appreciate having no specs and only downstream kernel sources
is tough going. I think it's great what you folks are doing under the
circumstances! I just wanted to point out that having some HWACG bits
in the QCH regs isn't unique to this SoC (although it would seem that
having to initialize all of the registers possibly is). Maybe the
HWACG "global override" bits is one of the things they added in future
revisions of HWACG.

regards,

Peter

