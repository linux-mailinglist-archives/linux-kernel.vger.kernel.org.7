Return-Path: <linux-kernel+bounces-740460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0864B0D468
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC26A3B9709
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0712DA77A;
	Tue, 22 Jul 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq5/RclN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456252D9EFB;
	Tue, 22 Jul 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172512; cv=none; b=Zb9s9YjhDaHhDWu+r39lvCQzE5aXtn42X0ZTN635C3PxULwt8SlZQNFX2lW7ITITGlsJHImwBABCNuq/7A0zzE7sYmrBLoTNZ6ZM3hFJ/Mh5rW/wvTFSNbxAArgliYpGHrnZK8rLtacaHU9fUQNkAoIolokZUACayPmBnejJays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172512; c=relaxed/simple;
	bh=6rXqAvxh2EPPEVHvI3n5db0KmlV6QKdie9y6A+tzPg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbDGzDcbINaESGovBKoXo6JJ5B89OqpSwUy1NXWlvrMBo1hAX9J7LnvzUXRPfLVsqvNLRhxTg0JG71s/hFk3y2nqqBa6W1N8DAAETKWP25aF1Bup4pZFO0laN4e76XH9HMdk56KPdqc9E5wxB9at8WTJswB5949SH13BWlQEB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq5/RclN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0726DC4CEF6;
	Tue, 22 Jul 2025 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753172511;
	bh=6rXqAvxh2EPPEVHvI3n5db0KmlV6QKdie9y6A+tzPg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eq5/RclN5RcyYOzadQ0rpvDx0bumrP7Q5zyig00vct2JtoIvdUGeXpfcrfjDPAN4S
	 morZz0kkmRKeLXwb/DlLZUVythcX5+U58KwMRUbRTDpcaRd9zmybuPf3ToDIqW7nYX
	 tkDVew86UQMiZvtIZrgBjIqHlALCPidV5mr2f+Q0TYDx0rT3iq43eg8SJAR9s7gNua
	 TzlvJyesnub6BlO4GqI75ykonOxIlti81EapBIHXffx4zTU+Eo2hiILZRXi+Uyn35K
	 Mg42S0oA5J9TT+IrE1QWqO98VhNkvOuWG4ywfgSFfI+LQY+hVUTiRrgSOUZazyE1s7
	 PDKQD68psKrGw==
Message-ID: <adbc919f-772b-46f1-99fb-d05cf0989763@kernel.org>
Date: Tue, 22 Jul 2025 10:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] genirq: add support for warning on long-running IRQ
 handlers
To: Wladislav Wiebe <wladislav.wiebe@nokia.com>, tglx@linutronix.de,
 corbet@lwn.net
Cc: akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, bp@alien8.de, arnd@arndb.de,
 fvdl@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org
References: <20250714084209.918-1-wladislav.wiebe@nokia.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20250714084209.918-1-wladislav.wiebe@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 07. 25, 10:41, Wladislav Wiebe wrote:
> This patch adds a mechanism to detect and warn about long-running IRQ
> handlers exceeding a user-defined duration threshold in microseconds.
> 
> The feature is enabled via the kernel boot parameter:
> "irqhandler.duration_warn_us=<threshold_in_us>"
> 
> For example, passing irqhandler.duration_warn_us=1000 will warn if an
> IRQ handler takes more than 1000 microseconds.
> 
> Implementation uses local_clock() to measure the execution duration of
> IRQ handlers. When the threshold is exceeded, a ratelimited warning is
> printed:
> 
> "[CPU14] long duration on IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"
> 
> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
> V1 -> V2: refactor to use local_clock() instead of jiffies and replace
> 	  Kconfig knobs by a new command-line parameter.
> V1 link:  https://lore.kernel.org/lkml/20250630124721.18232-1-wladislav.wiebe@nokia.com/
> ---
>   .../admin-guide/kernel-parameters.txt         |  5 ++
>   kernel/irq/handle.c                           | 48 ++++++++++++++++++-
>   2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9..fa89f21ea1e6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2543,6 +2543,11 @@
>   			for it. Intended to get systems with badly broken
>   			firmware running.
>   
> +	irqhandler.duration_warn_us= [KNL,EARLY]
> +			Warn if an IRQ handler exceeds the specified duration
> +			threshold in microseconds. Useful for identifying
> +			long-running IRQs in the system.
> +
>   	irqpoll		[HW]
>   			When an interrupt is not handled search all handlers
>   			for it. Also check all handlers each timer
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index 9489f93b3db3..eab8fdfab8d8 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -136,6 +136,44 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
>   	wake_up_process(action->thread);
>   }
>   
> +static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
> +static u64 irqhandler_duration_threshold_us __ro_after_init;
> +
> +static int __init irqhandler_duration_check_setup(char *arg)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	if (!arg)
> +		return 0;
> +
> +	ret = kstrtoul(arg, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > 0) {
> +		irqhandler_duration_threshold_us = val;
> +		static_branch_enable(&irqhandler_duration_check_enabled);
> +	} else {
> +		pr_err("Invalid irqhandler.duration_warn_us setting (%lu)\n", val);
> +		return -EINVAL;

Perhaps invert the condition and drop the "else {}"?

> +	}
> +
> +	return 0;
> +}
> +early_param("irqhandler.duration_warn_us", irqhandler_duration_check_setup);
> +
> +static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
> +					      struct irqaction *action)

Can be const.

> +{
> +	u64 delta_us = (local_clock() - ts_start) >> 10;
> +
> +	if (unlikely(delta_us > irqhandler_duration_threshold_us)) {
> +		pr_warn_ratelimited("[CPU%d] long duration on IRQ[%u:%ps], took: %llu us\n",

s/%d/%u/.
Do you mean "of IRQ[...]"?

> +			smp_processor_id(), irq, action->handler, delta_us);
> +	}
> +}
> +
>   irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
>   {
>   	irqreturn_t retval = IRQ_NONE;

thanks,
-- 
js
suse labs


