Return-Path: <linux-kernel+bounces-850176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A575BD2279
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E433A42CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857402FB603;
	Mon, 13 Oct 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoyHzLaB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0A34BA41
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345619; cv=none; b=BNRhfhp3eCTIsQq6mf8J68UqVoo0WaIOsWEy1rcQPRuT1DLJUHgSRsdmJ9VKYZbDXeohuGlwzvHCgy+3Q9pmtc5iFbEDT/7NGxxw0YsSY8Ru2BqGSCCtjK30lspCp+Qskz+IL0NRijZ57YOSGt/8ns8SU1vV20kDNv+DRhyGfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345619; c=relaxed/simple;
	bh=LxIWAp4NQ5UyaSUAqR48glMT8tLFh5oRYBOsHKUoXlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XN15YYjrGndNwejvy9S4VdqZwByYGn+J3rA53+e/oCyYnuoEn1Rr8V1f/7ySc3Yudg1gFodjq3tiMeMwbt00stVqKSELcHUa2eROE7g/hjtxJa78nN1bef1D83816WcB60Uay0bPLQBTakG14+EHtf0MXRXSD/BXzBhOrw6EdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoyHzLaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33A2C4CEE7;
	Mon, 13 Oct 2025 08:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760345618;
	bh=LxIWAp4NQ5UyaSUAqR48glMT8tLFh5oRYBOsHKUoXlo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HoyHzLaBf7OTov4v/d71JnoAinjTHdm31Gn3VPOXuRhP1DFt9BVsrTzPS8ojNywCD
	 LUMUwdLaLdTyHSZyhV61zY2h2nCeqC521oyhBJJ7q/Kj0UhRSi8GKRO2Ho3bSkejc0
	 FfqPawySfE1xasSmjW0CTeTSBEo8vkNjHdmzntOgVfDqjxweumlzeWDP3H+dhaLVlJ
	 TuV4+0/yBJBAAJjv5pvxt/OdhJimTyl4AMSEiknazFOHIgN+DXgbpBTb4q2+84Z+rq
	 kyLOgc24eMah6U2wT4Dq3GwkrMUtQJVOP0TK4khIqZYH1DHxg8wPUWy5gGBg2lTiwh
	 3T2kPq4h4Xnmw==
Message-ID: <81e33495-ad29-49b1-bb45-ee44f9f2a5ce@kernel.org>
Date: Mon, 13 Oct 2025 10:53:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit Links [was: Linux 6.17-rc5]
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>
 <ef8479be-8bac-42c5-bac6-5a5841959b45@kernel.org>
 <CAHk-=wju1GO-AdGHag2v94mXdmg2uaFez5R8YE2js7ngn+hJyg@mail.gmail.com>
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
In-Reply-To: <CAHk-=wju1GO-AdGHag2v94mXdmg2uaFez5R8YE2js7ngn+hJyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13. 09. 25, 0:22, Linus Torvalds wrote:
> On Thu, 11 Sept 2025 at 23:24, Jiri Slaby <jirislaby@kernel.org> wrote:
>> OK, can we have Submitted-at: or something for the above which you could
>> completely ignore?
> 
> No.
> 
> We're not adding garbage that I'm "supposed to ignore".
> 
> Stop this idiotic thread. Stop adding crap automatically.

Pardon me? I understand you are tired of this (so am I), but can we stay 
constructive instead of constantly resistive? This is not helping.
> I have made it very clear that you can add "Link" to your submissions
> as long as IT IS NOT SOME AUTOMATIC MEANINGLESS GARBAGE.
Yes, that's why I proposed something different than Link:.

> I have also pointed out that you can find the original submission in
> various much better ways than the meaningless link think you argue
> for.

Obvious question: how? Do you have some power tool which we all are 
missing?

One example for all: for 23743ba64709, I want to get the applied v2 
20250825125607.2478-3-calixte.pernot@grenoble-inp.org and not mistakenly 
resent v3 20250909202629.9386-2-calixte.pernot@grenoble-inp.org. How do 
I do that (if there was not a Link)? I can look up for tons of these 
false pos/negs.

Seeming solutions: people are adding git-notes for some trees (tip, 
Vasant's tree). People are implementing b4 dig. People are using lore 
search. All those approaches are hopeless as they simply do NOT work as 
Link does. [Some maintainers I talked to inside SUSE are going to keep 
_this kind_ of Link (but I guess you will start refusing their PRs 
eventually).]

My stance: if I bisect to a commit which does not yield me the right 
message-id in a second, I won't report it and stop right there. I am not 
going to burn my time by dubious searching here and there. The same as 
you don't want to burn your time clicking only-for-you-useless Links -- 
only viewed from the opposite side. And well, provided I alone upgrade 
the Tumbleweed kernel when a new release comes, I have to find bugs in 
final releases quite often.

thanks,
-- 
js
suse labs

