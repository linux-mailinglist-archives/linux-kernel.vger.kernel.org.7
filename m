Return-Path: <linux-kernel+bounces-865307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB012BFCC75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D8A6240F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0734DB41;
	Wed, 22 Oct 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDGTaNJa"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095E34D912
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145335; cv=none; b=io6VmotTcv/ulhHobXgyl6iHcwu4RzIaNQ7r9Aoh8wLkNkiW7pXhKO9YA0rdX6Uhv9Ao7ourvLWE8rJwrPPKsABZt+EYFPuKWLh5YGbf6ar49KWiMIhJCUJul1UdYT1k/y0dnxMe804ML30zIE5XEA8x6rDxYF4dc9Y8KcTf4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145335; c=relaxed/simple;
	bh=hdYfR8VgCU1ZspHH5xOZyDRebDxd3yGnO9egZSHcGHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bP3Fpf0cZdBOlfkTXsxlbBqY2ZJFKvzVcrOgbPP4N9KxwssoI6vlhQO9lg8BltcPVuDla1P7eTAk0YCk1Y34dqFGXkb3+KTNiZTOFLIgh91MQ8IPvYfgA2s7RkGMCAexqxaZHQASGInfF0soozCwSSPUVhx9yuESHLJNSF53fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wDGTaNJa; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87bbee3ba76so2920466d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761145333; x=1761750133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BnIAOSj9hN5H1aKf2wyJor6fNQ1bM8Ks2ytqG7kDK1w=;
        b=wDGTaNJafp0TkjV2WDjXy2XC8NiDYd9xJwapJG+UdY4c/LxxemLKX9PGb3hvImqsyA
         3t6Yqz7BFatgFlPJBT5Neo9Ve3MOR2Sr14sAloMgwh3DQa1AC3acTxcbHxHZzE5RiIdA
         Qj49gmV6weV95hYSBMqbgew1ONIMcWB5hyWpcz/v4Rr3wYhGZwCXdfiZdr3yGTuqJLDz
         xdFcV23X/HYUnByVCsWdVllwxr/Qh2KCiLgePTkI17t+BNjYDOZs/VmMNEbaR44hYPAf
         3nPdxdls3CotHnVozYv8a2POLaeWu8jiVitkr/J9sizkc3brm+5RF5JIkxyhI/oNAd3l
         j7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145333; x=1761750133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnIAOSj9hN5H1aKf2wyJor6fNQ1bM8Ks2ytqG7kDK1w=;
        b=QlkxklVHCJ7nNqgopg8oiufJWRVTOhX+lY+tUZ1kmx9Sodq/Ve8+NA+0mcypAkyp7W
         /g0sBNTgNwdmjy149EfqPKYmmW9HL/JASdMSHIYJjnSX0ZV/3oXcNPubKhtGmFXxxJHv
         jtnwVp8APCszelx6mF4Dcsi9JN7TFISK454ft3ipiKroskJFlBn1iXJpt8DybzigNoEb
         pGTFn3YMON1oICtmbYpLbsZy7LPPtF2cbA8nnX04G+xpOYozdkP2KuB4wh0wTYZcBtQX
         tcyaincPoAWt1aRVVNBAdzlWr+pA5Yf8tY7rey74RXJPDql/kKHiIuuuW9N+Yxk7Z39O
         VIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNHWew4EYN/nd/WFYNqdZJbbWMwmODXf4l2ktx7n9bLbiSGYC/m601kiGSq5jYcuKEmYL9+Rd1D6o8Y/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmVGMaqwoJZ5VtOtJkjhVgglYpJeJbo+MRhRRuzJiGb1I16NN
	c9tETBdPjAye/G9dlLpB1pYVJHlEKV27Xl2fnM7h0Dvd6PVhJdLDWtbi1yvTiDxp+QAXLBiwDDE
	w/vSsnPub848QDzt3riSBuTuwoIRMFuflFbuwAkWqVg==
X-Gm-Gg: ASbGncvWIbGQcc0Rh8eNxh9XRnFqUMe86j994h/Qr5d5yc1OFyIp8XPaztxnJvDp+GK
	K86oKeT8SbnWUjeitX+7t+YM2i2bfapoKb55HCs5nhX9iJhaKhTjL4ChGMGA5j+FC1nw9Z+kREU
	QrXumO++SmQ832WGMmMNNGHUURZq8nFjHjQCt2H42C9rSw2t3byQzsvJnGfMjTnW81qkwx/W1tl
	/FQXtu1H+iA2hPExXt46/TPwLoFZsim/12EBtoTfppHXnRCJcENf++3GHm/ce2/8YGlYg==
X-Google-Smtp-Source: AGHT+IHDNBWFGq/lO9UqX3OiuCVmV8mj/OamM0dXHm9H8/TY++90uwy4eHmeOOO7ME2KeAOXQVNRoq9F5JuwtjkDp/g=
X-Received: by 2002:a05:6214:19c6:b0:87d:f8d3:2456 with SMTP id
 6a1803df08f44-87df8d324a4mr21664096d6.2.1761145331914; Wed, 22 Oct 2025
 08:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
 <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
In-Reply-To: <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 22 Oct 2025 17:02:00 +0200
X-Gm-Features: AS18NWDwE4wLtG7BZRqK8s-_yLrQzlCdiI_YRXplah4qDB6dhd-o_z_6gw0x-cw
Message-ID: <CADYN=9KxQaQMWNbwDSftj7kcBYHjAQPacE+z7AVRZwxPTpexYQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/x86: Add selftests include path for kselftest.h
 after centralization
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: naresh.kamboju@linaro.org, broonie@kernel.org, arnd@arndb.de, 
	benjamin.copeland@linaro.org, bp@alien8.de, dan.carpenter@linaro.org, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, lkft-triage@lists.linaro.org, 
	mingo@redhat.com, regressions@lists.linux.dev, richard.weiyang@gmail.com, 
	shuah@kernel.org, surenb@google.com, tglx@linutronix.de, x86@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 08:29, Bala-Vignesh-Reddy
<reddybalavignesh9979@gmail.com> wrote:
>
> The previous change centralizing kselftest.h include path in lib.mk
> caused x86 selftests to fail, as x86 Makefile overwrites CFLAGS using
> ":=", dropping the include path added in lib.mk. Therefore, helpers.h
> could not find kselftest.h during compilation.
>
> Fix this by adding the tools/testing/sefltest to CFLAGS in x86 Makefile.
>
> Fixes: 4d89827dfb27 ("selftests: complete kselftest include centralization")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com/T/#m83fd330231287fc9d6c921155bee16c591db7360
>
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Yes, works.

Tested-by: Anders Roxell <anders.roxell@linaro.org>


Cheers,
Anders

> ---
>  tools/testing/selftests/x86/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 83148875a12c..434065215d12 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -36,6 +36,7 @@ BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>  BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
>
>  CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
> +CFLAGS += -I $(top_srcdir)/tools/testing/selftests/
>
>  # call32_from_64 in thunks.S uses absolute addresses.
>  ifeq ($(CAN_BUILD_WITH_NOPIE),1)
> --
> 2.43.0
>

