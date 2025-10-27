Return-Path: <linux-kernel+bounces-871542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2B8C0D9FC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20BE44F8DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8056B284898;
	Mon, 27 Oct 2025 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BNz1kuk0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC3312823
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568204; cv=none; b=frryn/6QdFupctzwhnIwURXOYuEnI6UZXbBLaaPc5lJdC6ShWuwphTntpSrmh3rNLDx9BvjqgDsyZKPQitMlMZY06vkmsPaWaVj4Ta9uW+pEq8Uy6J7b1VaMsr56OwCUTmYFY3TDvpoqkvrD2RAEct3Xftc+vkH1g3iFceG13nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568204; c=relaxed/simple;
	bh=HJ/2dqyU/Acjvu+mZzB033wWiO44mlaL5jzI8+GPiaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibh7sCWd9PWcYG6UepnsROGQ7w/OsSpvJ/KaeEtQ2hPh1SUtBFykRUlLjxYxCdTQeEC0EMuEaxGlRs+VeZiYnYJAFNWJwZ9IpiKPOssBHJa73DzpqwQo+4Jual+9oE/XbH3xX4jDzZTxboWv92jcWjEjmp2XUKG4NhKQtLqq5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BNz1kuk0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so9850975e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761568200; x=1762173000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3PWBISQV3ncuBoZdb9QUM1ePMIWUZ1r8Gjge94TDN1c=;
        b=BNz1kuk0GSBrNNbU3TxrZScfPwkhxSksnvKApJoWAkDwYXCj8nRF0UajUDcP2Myljf
         bszdtgrGFQM8ELSJYwZJwAe219KU0ojjlxagO6UyWUiy8RvacNB4+axSdOxdju3A2gKk
         gtJW1V2IfZewLdGK6QtkTiY3H2yXTNL8x/fBzU0u0dUn1Vyi0i+Ll6gfkLqSL8mTmqr3
         qtROjPHsZdGALhbTOtNXlxtm0xcZbDPbtVVeGNpwK6D40gbgA+0ZgJE0pIAz/KtLTBRy
         oTIU07HHuuRWVa8SvnaKshNjt++ueP2C9Bwzu/tuCIjTeL4UshYSO1UyQj6bFqHbmFX3
         2DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568200; x=1762173000;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PWBISQV3ncuBoZdb9QUM1ePMIWUZ1r8Gjge94TDN1c=;
        b=txjFgKas7c6VasVZ6wKS4K7KRjvsOgBpggRKpOa9hGWIEJ/E7CW/wtjlOryClsxJLf
         d9DPdliwooqZTueISSzqsbp5C0kIJX6Urnjd1JPD/rw4Ia2H36V7rr3tPlI0DgWLQrIX
         2G0kitU6A8/hHpBN4wz9pYGyW4luBBlSamTRq70SJLtP4FrTx8tfzfBR75fr7kBmsAYb
         scmHr6RvR/RNMePbR661ApgcnP62B431lGOfaleBihpiqpvndDQtXjpzL00807Y5X1li
         4Aqm6Zi3iRArN6FggYBAGOnzG4UvDCEnx/D0lm7eyo0aAgiK9mJeKrE/L9JSTREUOhvo
         W6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUlGSI7vzDjusS4dxjvHGJAQC9waVzGua0IBV4gspHIScg/xWFEnJi6IA1NnRUCdgZCHSuGmSpDEpnvfSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHMZutTCF2Xfb8PVfEHLzj/ZZBDH+5zz1xxLxRNSd6kX1S972
	LOJ4fxG9MMHkyWcq+p6aKe+svS1QHy4QqHOKdWclV6GhYV1hB9gRXj/RQ2MqM7vcWX0=
X-Gm-Gg: ASbGncvCXUZZ0KZR+z1W956NZ2EJ7JGrW+K6fS2qVW1AByGXql3vJedfBWCa5tG46LE
	LvB+DYCclooOxJ4QyAw8I+HcqrzAAivm9kgZfpdEesRCcF/audriZCokPp9jMi+xvUTz8syE/jh
	f1bHAnmgvrsPDexk/Wrupwh3XoJhdWz++34o2Gw03GPX075AQH83r+Ma05AhP4mPUYu7FiZLqNH
	lx+XLDm+s3eqeaWthg/2Wia/eRcsNvBMunG38TuhjdWObpiArGvBI5L6lgUm4xZ7WM8yKsGoV2o
	WdcCAkXclkH0eG8WO5YKBkZ1wry4l/FMzGjp2K//Z14/1MhjzbiiapUDIxxQqnPiEs8v5EuSkWB
	COQuw8GZ++4EzTrxFtlu1WFZb2G3dYx94199nOtUCuiierw+yGNro9bfkOc5zrru9YyGYLDfcx1
	gmzTptQ59ShHP9SykN6tdRd08cahi+fi1F5QvlLw==
X-Google-Smtp-Source: AGHT+IESSdoIje4LFM44NkmkZF81vbk3INubkipM1Uq1eqT0mefzc6gYereDtjtfa+LLk945nxK7+Q==
X-Received: by 2002:a05:600c:540b:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-475d2e95fe2mr100898525e9.18.1761568200589;
        Mon, 27 Oct 2025 05:30:00 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddade9eesm63558295e9.11.2025.10.27.05.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:30:00 -0700 (PDT)
Message-ID: <9ff5551d-79e8-4358-bbdb-cbc7e5c7c36d@suse.com>
Date: Mon, 27 Oct 2025 14:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 55/56] x86/debug: Show return thunk in debugfs
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-56-david.kaplan@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20251013143444.3999-56-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/25 17:34, David Kaplan wrote:
> Make the value of x86_return_thunk visible in debugfs to support user-space
> testing.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

> ---
>   arch/x86/kernel/cpu/bugs.c | 44 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 26ceb42e0cfb..8365448b3aef 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -16,6 +16,7 @@
>   #include <linux/sched/smt.h>
>   #include <linux/pgtable.h>
>   #include <linux/bpf.h>
> +#include <linux/debugfs.h>
>   
>   #include <asm/spec-ctrl.h>
>   #include <asm/cmdline.h>
> @@ -4065,6 +4066,49 @@ void arch_cpu_reset_mitigations(void)
>   	tsa_reset_mitigation();
>   	vmscape_reset_mitigation();
>   }
> +
> +static int rethunk_debug_show(struct seq_file *m, void *p)
> +{
> +	if (x86_return_thunk == __x86_return_thunk)
> +		seq_puts(m, "__x86_return_thunk\n");
> +	else if (x86_return_thunk == retbleed_return_thunk)
> +		seq_puts(m, "retbleed_return_thunk\n");
> +	else if (x86_return_thunk == call_depth_return_thunk)
> +		seq_puts(m, "call_depth_return_thunk\n");
> +	else if (x86_return_thunk == its_return_thunk)
> +		seq_puts(m, "its_return_thunk\n");
> +	else if (x86_return_thunk == srso_alias_return_thunk)
> +		seq_puts(m, "srso_alias_return_thunk\n");
> +	else if (x86_return_thunk == srso_return_thunk)
> +		seq_puts(m, "srso_return_thunk\n");
> +	else
> +		seq_puts(m, "unknown\n");

nit: This might be better suited for a switch construct but it's fine 
either way.

<snip>


