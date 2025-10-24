Return-Path: <linux-kernel+bounces-869032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569A2C06C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C523ACDFC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CE222B8A6;
	Fri, 24 Oct 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd8fq9iY"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272B20F079
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317245; cv=none; b=rqHqhEwtjKfYAShFVjN27dy3XQ/Gzel1agA1mCrPXLv1ksCceMk7jVNPp8idRt++3vVGwnZyxHnrzCb+Ma2DXfRXQUatCrWowNnqms1+7q4KCP4PUX7Te3YMRcLOWXlfm9i/2C+cCkTMGGrf/LH4i7T6hzVaH4g5pFe+mjm1LV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317245; c=relaxed/simple;
	bh=gta0DxKrEcNfad47Oo9JSubMMf/6TM5hGH1NT1plFG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkI5TLLlF5SgY+x/awJWHWHsT+xnbPwLsyUIpZgJA0H6AYQp3d6PGW8LjbzMI8uuqk5d+r6FrFzSdN40pFoltC5ppJC5V4ilUlk5b9mA9XPxBsNDVmZVeS+J8c3mHUjPBfEjnJINj4czPD1oEM8BafCzjoeG5byF2NbEpzOaKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd8fq9iY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710022571cso22792295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317241; x=1761922041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU+wnuo2Z/1XtZ6g63nPnwv0VWCw8ghGKwTmMdWFqpg=;
        b=dd8fq9iYx5oAV5LoXJg5ffGcYE8yx64JpmGLblMq6osIl6vGgpjJdpRV4Xa7tETaMn
         MDqc5vhiAJiDtTP4Lamyhwz8AgqCczTCIgCrZeMcBjqOFtmd88OiljwJ0NCaEl6WVbSB
         /o6tkFdCgNS5ZA1PCGFasYPYX+H6tFZCn5CkOo77m92ksQ2cLYUG47hh2Dj6nUiXBkSJ
         M13MKsEPGUqCRxswpGpnC1GkZiB9qcdaJKrM2m1tyqWHLy1WMMqCRD3nVmxHMkPas5kr
         NdvqX7zaFWepxumZDF++yLjD9xoyMcmAsjaLPoLzw+s/Oer/vKctgv43iFmuIQKcTNlq
         euDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317241; x=1761922041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU+wnuo2Z/1XtZ6g63nPnwv0VWCw8ghGKwTmMdWFqpg=;
        b=ReyGphKZ5wOJUHWh4QmNhH+MEsKZvH0cataN5x9ukmQ5XpoOzQs6vzcZ8nPq1J95Lo
         gNoChrmcPaqbi/Juywt6kc/aOGR5HjLEsRWAJo+V3vGfWNxpuRVvU5ez6qHTnmkCCQjE
         hiXh0lkgNj5q6ouSN3+WZR1IEZ5B1IDbACVuql1FqDzFLQQst+kMPo3VpGY9Y0YbWAkq
         Ed64M0Nh9qTL4oa2IRuPZ+AQH+Xi0RhmMOzdR4Mzf6xRHHc+HGaNvy/StqUmg8Nn49je
         GdAfZU8GzTggKHOca7aqUYIhaF4QdoiKDziXGpNOW3xjn9OB4sGIvQsh+rz93enqAR6/
         kzxg==
X-Forwarded-Encrypted: i=1; AJvYcCVtThT8xMXIZujZZjStvW5APHNJS7mprjKLmSj3fAtAC4GhwDyCF0oydJ60B1t+l8Ols+lsST6I/fa1lyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws871xDNlarnGxWgBDQPwjkiMP6rhEr/VuD9MSK8/nHHAWMSIt
	a+3GnSf//4HtlEMzERsbqOTfUGvtiMD+jXuSH3RSd1/c+ycMCSqBCVMa
X-Gm-Gg: ASbGnctKMKZCHFR12VRrIIILtC/VNpcqVCja1CWc9f/tTTyZ97WUhBqbfCitZxhIgeL
	6IrPgXducXkOiaNcLWtwSKCqL8eSoHyn8dGB4mtb6wul1ZZnbz5dil1PDZnuQbwOfubVHyT2GGm
	BLMzW0cpjPM4d/+XwrXrJJASNeHUhTM7T3D66Qn4Z4JWv/PV0p2DkV8VPICaVoBIryR7QyAvSYX
	UOtig5TcOePMqleHx5xHaqOEPhOUuvKH6DAHYnLmG4nA61xlu2GiVF84TiHzn/U8tWDL1odcdE2
	BqTTWhTd+8iQG3zRooOhe6J/M3uTIxJar2LApbqVvD3IhIAjWg72jlWRO5shRxQudQu1f/YkxUe
	o/LiE43S3T4O4JDy1zsNLMVqT5dh403wJihhCmO/tofKxDmS14ZHM0yeo2Ga1GBh7ykLSOczrvP
	TNC7mbCgWoSQBZUSoT4/pHIN9jYWqu/Tkvx64PNlPqksP+/yAUD8M/
X-Google-Smtp-Source: AGHT+IHTEaO13+9fHR05oni62pNnB6SFZLHntJBdSUcQjV2Scfibpu0XNA7qJvhSpMY2WZf1fNFglQ==
X-Received: by 2002:a5d:584f:0:b0:428:52d8:9680 with SMTP id ffacd0b85a97d-42852d89820mr8617704f8f.18.1761317240510;
        Fri, 24 Oct 2025 07:47:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429932cbbb0sm514747f8f.35.2025.10.24.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:47:19 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:47:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, alex@ghiti.fr,
 aou@eecs.berkeley.edu, axboe@kernel.dk, bp@alien8.de, brauner@kernel.org,
 catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, edumazet@google.com, hpa@zytor.com,
 kuni1840@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mingo@redhat.com,
 mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org,
 tglx@linutronix.de, torvalds@linux-foundation.org, will@kernel.org,
 x86@kernel.org
Subject: Re: [PATCH v1 2/2] epoll: Use __user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
Message-ID: <20251024154715.577258ef@pumpkin>
In-Reply-To: <ea7552f1-842c-4bb8-b19e-0410bf18c305@intel.com>
References: <0bfa4895-727b-407b-90d2-7d54b9bd4910@intel.com>
	<20251024051653.66329-1-kuniyu@google.com>
	<ea7552f1-842c-4bb8-b19e-0410bf18c305@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 07:05:50 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 10/23/25 22:16, Kuniyuki Iwashima wrote:
> >> This makes me nervous. The access_ok() check is quite a distance away.
> >> I'd kinda want to see some performance numbers before doing this. Is
> >> removing a single access_ok() even measurable?  
> > I noticed I made a typo in commit message, s/tcp_rr/udp_rr/.
> > 
> > epoll_put_uevent() can be called multiple times in a single
> > epoll_wait(), and we can see 1.7% more pps on UDP even when
> > 1 thread has 1000 sockets only:
> > 
> > server: $ udp_rr --nolog -6 -F 1000 -T 1 -l 3600
> > client: $ udp_rr --nolog -6 -F 1000 -T 256 -l 3600 -c -H $SERVER
> > server: $ nstat > /dev/null; sleep 10; nstat | grep -i udp
> > 
> > Without patch (2 stac/clac):
> > Udp6InDatagrams                 2205209            0.0
> > 
> > With patch (1 stac/clac):
> > Udp6InDatagrams                 2242602            0.0  
> 
> I'm totally with you about removing a stac/clac:
> 
> 	https://lore.kernel.org/lkml/20250228203722.CAEB63AC@davehans-spike.ostc.intel.com/
> 
> The thing I'm worried about is having the access_ok() so distant
> from the unsafe_put_user(). I'm wondering if this:
> 
> -	__user_write_access_begin(uevent, sizeof(*uevent));
> +	if (!user_write_access_begin(uevent, sizeof(*uevent))
> +		return NULL;
> 	unsafe_put_user(revents, &uevent->events, efault);
> 	unsafe_put_user(data, &uevent->data, efault);
> 	user_access_end();
> 
> is measurably slower than what was in your series. If it is
> not measurably slower, then the series gets simpler because it
> does not need to refactor user_write_access_begin(). It also ends
> up more obviously correct because the access check is closer to
> the unsafe_put_user() calls.
> 
> Also, the extra access_ok() is *much* cheaper than stac/clac.

access_ok() does contain a conditional branch
- just waiting for the misprediction penalty (say 20 clocks).
OTOH you shouldn't get that more that twice for the loop.

I'm pretty sure access_ok() itself contains an lfence - needed for reads.
But that ought to be absent from user_write_access_begin().

The 'masked' version uses alu operations (on x86-64) and don't need
lfence (or anything else) and don't contain a mispredictable branch.
They should be faster than the above - unless the code has serious
register pressure and too much gets spilled to stack.

The timings may also depend on the cpu you are using.
I'm sure I remember some of the very recent ones having much faster
stac/clac and/or lfence.

	David

> 


