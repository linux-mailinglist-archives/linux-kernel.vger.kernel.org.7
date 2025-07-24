Return-Path: <linux-kernel+bounces-745041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8703DB11402
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1BD97BCA65
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E29223C505;
	Thu, 24 Jul 2025 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fyCbavAi"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E523C4ED
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396367; cv=none; b=gk8mZDMCGIVf/pD5cKU3Xpc0jnnv1OmRjVQwLZWajwUXugDvVKV8UhYKGzrD4F2GVwYGQsGOkerdm3uFZRYnqL1ygbTdXhhlDIalU+1pIGMqDm1O0tPkbwd/tWs/ejsa+szG2BhHNsC2BTr4DGV07MKxMEspGA90l8JwyZ2Jby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396367; c=relaxed/simple;
	bh=/X4FypA9ner9RdUyFi3gZVeAiwJRATDSBMzUcNSjRiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=M1//r0lcb9jtDpQl0cK+7RoQzG5nc2oo1UU6zNbL7+swySopScnO4eqVlcrbnWR8o4pQmMtKILVLQnnbPKQFCF0K71HkfXLwM5lBk6ErGQMG14+i0BuQ5kCe54E1FMKCe7MeBN0AZZu2Y/CANZRusuDOvC0qGbc462b9gpvwZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fyCbavAi; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-875acfc133dso62486339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753396365; x=1754001165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BowG7/XkE6ZK3mV0bM7DLAubbfXolAHIJu1TtPOGrqQ=;
        b=fyCbavAiWbigFIlD1j6BYztnwJiiF7GzRsPYIcNxrVLgT1g4dSphPAGv0ECNOivA64
         W83pYLMp0f/sCUzAzey1NRN0/JoKe18IyvfD5PICFoJdFyD+B7mxd5JRe0umw1yu5UHe
         jw8bC/Lsaw8RuAmD065a248fu3Dqmjj1t0AHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753396365; x=1754001165;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BowG7/XkE6ZK3mV0bM7DLAubbfXolAHIJu1TtPOGrqQ=;
        b=LN3Lz+buvJOpCWmvRtZT15AajWVSYMy1qZL82wLExeLSMiIg6+k50sv12yrDx2zCJp
         IGD2+aBgmSZaINJOE6q0xnRjas7dye+Xl0bqz074KONn1T8QflFYktF4lqaf+pphIL9E
         IFHzLsfssF7jgW7M6GDUswXQD3WYiya+tAco+ymNepp/Rx/al2b1f23nznIuhEhAR4xC
         l3ApjUZvbEsG7SseN6ZvGDy3J+BPsNONYWnoT2mK8CIHcSXihyNJoL8Cn44F4TcM+8tx
         xcD6qFFbBER1d9zOSPnf8S/lyXEwhdutm/O+12cqxmn0/J5FgKEyaXoJwR/X4pap2DMh
         h8wg==
X-Forwarded-Encrypted: i=1; AJvYcCUPNs5bE7QUybyDZ4vIdJpCI7TZ9c6DZdg1G4742QSNYYUrKqvMXLs5box75oQMYg5aBjcHp/CrNtIWR4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rxAncbIhQBo+oSDCOPyXlTZ25DUV2B33aCl+7LgMa4Rr8Xsk
	E/tZfEje1MyiH+96mKzhmSsCHAXKqCVV8YBT94Oe0UXWiFc3O4kytWk7q1po+GscnDs=
X-Gm-Gg: ASbGncv7aiXvxxYnlNzq5ZT/IywrAbsmKAVLZSKinaKkSZ3AY8uOXtG6zxdAF3VundU
	5CDa6Q+7VYSCjFGmM69obLwA3G6YqG+RmMs/gkAA+k1u9itOOhSi2T472M85OM/mIdMBaNGfMmG
	M1BOBCYWvNzAe3rhuyjcepVAF5abbKauFlnqb7eWdhOoNsyrnT9zg04mKscw09SO/0CdOiDGE4Z
	29Hx1G3i1CKYK4rp+XAfBnOtMEEnwLN8SrN44CsXOXCtJlzSVGFj7/FgbKcx5WjamWeAPGMA1Oa
	bzchKbAjSPBaaCDNKTMzwBH0uzXeFMoUMvhRFwLinWXy5Rhv8PHCW4rL+r+676ivjlzz928Fgft
	CFYmEx0aveY5l8MdFkp1Q84/puN4THZV4WA==
X-Google-Smtp-Source: AGHT+IEbKOiXyxveiaYhBw5qiIEbptLsXga1ZudzEZCJ+xlt8zDOaAHzQB3cjEB5pgnwF9SJ20+qEA==
X-Received: by 2002:a92:cdaa:0:b0:3e2:abbc:c0c with SMTP id e9e14a558f8ab-3e32fcb809dmr148251935ab.7.1753396364899;
        Thu, 24 Jul 2025 15:32:44 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508aeab7426sm650512173.54.2025.07.24.15.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 15:32:44 -0700 (PDT)
Message-ID: <c6eb6734-93d3-4a59-8869-49ecc438fff9@linuxfoundation.org>
Date: Thu, 24 Jul 2025 16:32:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tsc: Replace do_div() with div64_u64()/div64_ul()
To: Niko Nikolov <nikolay.niko.nikolov@gmail.com>, shuah@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250724215339.11390-1-nikolay.niko.nikolov@gmail.com>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250724215339.11390-1-nikolay.niko.nikolov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 15:53, Niko Nikolov wrote:
> Replace do_div() with the recommended division helpers to avoid
> truncation and follow kernel best practices, as flagged by static
> analysis.

You are making more changes than what change log indicates.

> 
> ./arch/x86/kernel/tsc.c:409:1-7:
> WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> ./arch/x86/kernel/tsc.c:492:1-7:
> WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.
> ./arch/x86/kernel/tsc.c:831:2-8:
> WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.

It is hard to see where you are addressing the above warnings with all
the other changes.

Also you don't have the right reviewers cc'ed

> 
> Signed-off-by: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
> ---
>   arch/x86/kernel/tsc.c | 185 +++++++++++++++++++++---------------------
>   1 file changed, 91 insertions(+), 94 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 87e749106dda..96f40759340e 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -34,13 +34,13 @@
>   #include <asm/uv/uv.h>
>   #include <asm/sev.h>
>   
> -unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
> +unsigned int __read_mostly cpu_khz; /* TSC clocks / usec, not used here */
>   EXPORT_SYMBOL(cpu_khz);
>   
>   unsigned int __read_mostly tsc_khz;
>   EXPORT_SYMBOL(tsc_khz);
>   
> -#define KHZ	1000
> +#define KHZ 1000

What changed here?

>   
>   /*
>    * TSC can be unstable due to cpufreq or due to unsynced TSCs
> @@ -55,13 +55,13 @@ int tsc_clocksource_reliable;
>   static int __read_mostly tsc_force_recalibrate;
>   
>   static struct clocksource_base art_base_clk = {
> -	.id    = CSID_X86_ART,
> +	.id = CSID_X86_ART,

Tabs removed? Why?

>   };
>   static bool have_art;
>   

Same questions for the rest of the format changes.

thanks,
-- Shuah

