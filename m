Return-Path: <linux-kernel+bounces-879645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC20C23A68
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BA81888869
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1469329C53;
	Fri, 31 Oct 2025 08:01:18 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC62236E1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897678; cv=none; b=ZwJZ2skpt5uZk5QRumjhTSq75yhpr1aFybBpJRwL/obXCxrebPI4Jsh7R/nsxE3mWWPMKs1WMTcHjMJ933DHB0htuDtQ7cW3ae88iilI34ydGH7Ucm1IGgSBbC9y6oveJtI05/xLGTXWJ0sutEZD/tisLO0aTRw+TLN9th7MnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897678; c=relaxed/simple;
	bh=6RExzYFt2jFngKeLwZZhIXhryDhrEYofiRI4ar8KsXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwS0YxapKZWgraP6wRtkN8nj6SwckgIckisfA8q8E1Q3K8nRwNkKaPBU+vGh53amHW+6rji/nEErlmq3w0axFlZTkKAuaRQHkhzpsfadEhnDn2K39HCNCYHChordQ2Y/XJ7ZXJ8xoZJYIaPVtROOBBldCagO9hUZ4C/DyA69NQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9310a7b2668so694815241.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897674; x=1762502474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9bvdnPD20ODXbm88Rkbvmv8aTDyzXTmQyD55LvW55s=;
        b=fnvm+iUfPcwyLKlSkU92bFJwlvQ0Cd2dzNJNkDegrJ2Ww4K24fhofQYtoFPXRXfTvC
         N0IFN/nSqgqaHiuukDTzECll3y2vIFCq34jWYA9fz7cQimEvCtjsoxte1S7D9QpIq3aA
         3IxEvI58oSZnjLh/DAYwmj482D5IqRw97drRRT3bix7Ex8sxcgev3Ujo4TTUKjloJgFT
         HiOX0fz8JqvRfpOw+6l+s3VATiyAV8ytQNQcgatBaIVSshTSRIjrWJ6+g+/JpehqwGU0
         iFcP7o86+Bx2s1x9VR7ItkuXAkOx/0ZOIxABOqW13OkQyzA86meKg/AymAnR1+NPK/N4
         Tqmg==
X-Forwarded-Encrypted: i=1; AJvYcCVEuPX3wVvv5ecgp2H5CMHtpK14ekF75qj1gQ7CFhCM6oMHG3339USPtQjNEj78PuV9QHmLT56JQ9v1vuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPI589to6X+WOhP2TZ/a6A8fbcQyrGwiOZ3BZdSPcbRHUmMjHQ
	aoozyZaGd3DB801/4f12IxcVfW0cp9TP7uNIBsz0TpPD6fwAPnHNhD6Yh7H5D6gM
X-Gm-Gg: ASbGncujpjgwZI4GW2snM20VBPGHbBKuCCLGbpyEEbaxneqdJtbJcrDQ7DdiAaW/wbK
	X8mthtE4iqgDa3e6vm91FyzLKkuqhF+yMaPVyenycgtqdJHetC9rfrFPLvj/L69s5Hn3i4vDG7D
	0ZJ/VMr+sTDU6V7azVPMM2sLk7dGU6/fU4CKBX1uSRgNYjTtINXbOhHow5FuE6adNF0eu1zCWW4
	oOKIVU4mO2Q5TRRHHexcZA7C42JwcqNFUMJoHh9AxbG2xdHHglmcSz6rd15tCepOO3k24CFMsGu
	wG14KF/KK3HXDmL+0KbCBN4Ef+RAPLTIlQZQkGYep/f+Bge7wJ6gdRPy7+9b7HObqJTctx43BSh
	5WOcP3a5FH4ochcwJfOsT4DvlTQecq17UwoKAuPIdgB+yyT7/A2vjP27uHXc2RSYVSbyVc0P3u3
	FJhJySBOkydfNMovk2KZ1ZgV/SanoH3Ovgw1RLLHCnvFFIo1S/BdyN
X-Google-Smtp-Source: AGHT+IEepKPes2WZf8vIqV+dJKjKa8AuXlW96z8CHBAA77bNcVkBz1LZxHddsV4N917HfgAdB52ccQ==
X-Received: by 2002:a05:6102:160a:b0:524:3e12:6590 with SMTP id ada2fe7eead31-5dbb121f9c1mr562931137.14.1761897674030;
        Fri, 31 Oct 2025 01:01:14 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93512d25ec5sm409368241.15.2025.10.31.01.01.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:01:13 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-934fb15ee9dso722777241.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:01:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+zXnw9Odvy3cC3Qyu9nh8EdXPwmyAnTfArMUmsyHRPRApaofIO441ezaltDtKQUE6c3snmJzo8LS47Oo=@vger.kernel.org
X-Received: by 2002:a05:6102:4186:b0:538:9b66:7655 with SMTP id
 ada2fe7eead31-5dbb12466ecmr618067137.18.1761897673256; Fri, 31 Oct 2025
 01:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
In-Reply-To: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 09:01:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
X-Gm-Features: AWmQ_blCO1e8lSBOgkh0TQ3Lynfwp2Y7X0NnvV--2NjFJHk-coEQ7bju69mPh3U
Message-ID: <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
Subject: Re: [PATCH] sparc: time: Use pointer from memcpy() call for
 assignment in setup_sparc64_timer()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: sparclinux@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Larsson <andreas@gaisler.com>, 
	Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Finn Thain <fthain@linux-m68k.org>, 
	Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

On Fri, 31 Oct 2025 at 08:46, Markus Elfring <Markus.Elfring@web.de> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 31 Oct 2025 08:36:13 +0100
>
> A pointer was assigned to a variable. The same pointer was used for
> the destination parameter of a memcpy() call.
> This function is documented in the way that the same value is returned.
> Thus convert two separate statements into a direct variable assignment for
> the return value from a memory copy action.
>
> The source code was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks for your patch!

> --- a/arch/sparc/kernel/time_64.c
> +++ b/arch/sparc/kernel/time_64.c
> @@ -760,9 +760,7 @@ void setup_sparc64_timer(void)
>                              : /* no outputs */
>                              : "r" (pstate));
>
> -       sevt = this_cpu_ptr(&sparc64_events);
> -
> -       memcpy(sevt, &sparc64_clockevent, sizeof(*sevt));
> +       sevt = memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clockevent, sizeof(*sevt));

IMHO this makes the code harder to read:
  - Only 0.15% of the memcpy() calls in the kernel use the
    memcpy() chaining feature,
  - The line is now longer than the 80-character limit, which is still
    customary for this file.

>         sevt->cpumask = cpumask_of(smp_processor_id());
>
>         clockevents_register_device(sevt);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

