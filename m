Return-Path: <linux-kernel+bounces-843261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2BEBBEC8B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5241B189847F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E6226D18;
	Mon,  6 Oct 2025 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cThwXl7H"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050D2224AE8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770698; cv=none; b=DYG9s0aqWsQ2nLudD3JHEOhDEGONRjVuwe7BSEPkanOVK+lQZwx9j/nwLqyQYD9AmriP0IwNkRzxGJ3P/cesudNZYUKEVdEYLSNJUTjWPlKdTgxLhnUgNWCxmMxaTHrPZeycGek3pCzQd6S9baiYSNRKDn7GZh5DjgHrNpTjqVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770698; c=relaxed/simple;
	bh=zKkTa7ZhmrpRX4yKjc3XCfiejGSkZfXEDNwW1ZmtDtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlbHusnZ/ewdr5inHpmm9aARQSF93rtW2Rd2U+DE7TxE7priaRo993FWb9FTAXOQDp7wKX05H77XCr9nnht+nmCSziecuj6gLj4lhJncLCUgWHEkiNE4av/0K5OG+HBicSM2Xqb0PPQcLUAGBvNb7TnxgJ9ujtEJbDCEE7KY3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cThwXl7H; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4f323cf89bso32316166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759770694; x=1760375494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ON0py5Pr4Nz6NW5O8PJrqmYAOhtAM3BBfWdJdJiOtZI=;
        b=cThwXl7HcInRoi2HKYBoD1TUhc0fPFrnndUrC9sQ9qS6zLiRyiD34xO4ypEfMYIMYH
         UWTq+rH737ldp+0p1+G/+MyU/oGt8WE83C8Xij62q+OKtfsKNTTZiljWlrB0GMeENrBc
         n9/9/+Zgitv2EaE3+uBILs7mkcRcAEA7tq9sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770694; x=1760375494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ON0py5Pr4Nz6NW5O8PJrqmYAOhtAM3BBfWdJdJiOtZI=;
        b=BuvhjhtRWpIaDTveZGE3IvviY/XZ/8HOsLO58VmPWtH4/yHUHlzPsXnL3fvlVBWQyK
         0Ynx1xfUn3NESPyhJ+TdT7Xn8cjpCVeHJpJ3Ztcxf95jXBPmLaZCocaeG6nIBYb4Pgbh
         dhOl/N0tv83ZKZ0I35SAU/ZRkyxTuztoISstv2uXYu/1QiQH4g6Ss16L2FMcnC6vYiL2
         ulYiLtDVpBUWgn0ERp8Hsu1jgvFyP/aj15DnADBnb2ToGnrPWEG9Ps8lWFqY9ng/VcuK
         0i6yEB30aYCj9PpY+N09yOkUQEsONLtebSaH10A7H7ySvi2XOWwz+mCIoOMPppqwB2jE
         My1w==
X-Forwarded-Encrypted: i=1; AJvYcCWcYdM1Ryo9GwayIAfvSs0A+Dd90MPkkItTb59NhgXaM+UyvYIotXN73Bd4Dlqohqf8CGVi8Mc4HFmIfLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvT1mGkv4NvvbV5D1Io62/8RP6f8Ui3Lxpg2TUQOJ3AAD5W4Tt
	LR0auTXyhl/LtpwQt2Dqf/Mm+tupmJ3J5aMEn/jLOmTWhYU8ynh3BO+cARddnGmncjQ1125knld
	k2TKWC3Y=
X-Gm-Gg: ASbGnctI4vf0Gp7BoxOPQ9ecPJLUoLBXyR+7gN66sHaXctyXE8BF99tjhrKuJJ4tVGt
	ISJgz+cZnCeC4bfhzqeOvOb8s0CLEXu17x1wt5FHAc6NH80K6kEeYjaRzGJh2Dr668B5+dn0AV3
	v1BJvLKXpjdTqnJE7HxD5adcDpNBLeK02WDESFvsuCSRJYqr3EAmpPHkDjSVc/xpCKJJQ5ypwTy
	3qbGNBdJSmNYElpie61OU0B3TEbWwirJDSVRp7AtJQRlPqwbU9NJOIn/KK72fOmuO5VEYmCbSGG
	RXbliBOt3tKLRg0SRcHd9B7SYxucF5NiEQPw/hPbn+hcW6urhow0ocQRMt4iRmbXDHudIXlwb7k
	/8foTVSfxo+vb11DuzaQDsJzDcFIkCYtqIaToVvNwAmXY3aUlMBCVarjPOlIhIiZiz9x4DP88cW
	WCox0eipYhCTu3FSoOJ7lQu4gIlcqxpHM=
X-Google-Smtp-Source: AGHT+IH6AyLqwhHgzh0+kCMMtSmzFICFjvxkzEMmFxqDTy+9mCszCcCfH3mvyn8F3SPMMQm7bBXLrw==
X-Received: by 2002:a17:907:7e8c:b0:b0b:20e5:89f6 with SMTP id a640c23a62f3a-b49c449a236mr1650756566b.60.1759770693945;
        Mon, 06 Oct 2025 10:11:33 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm1216467566b.78.2025.10.06.10.11.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 10:11:32 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso10850635a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:11:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSNYFruxhs7CbNTb3H8CHNlHUWCY7AL/p/vD2aI/frKIPbZhB7gJygblnMiirIQMsc3gPvA871JT18wRQ=@vger.kernel.org
X-Received: by 2002:a05:6402:788:b0:636:7b44:f793 with SMTP id
 4fb4d7f45d1cf-63939c42c3dmr10575986a12.36.1759770691962; Mon, 06 Oct 2025
 10:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIirh_7k4SWzE-bF@gondor.apana.org.au> <05b7ef65-37bb-4391-9ec9-c382d51bae4d@kernel.org>
 <aN5GO1YLO_yXbMNH@gondor.apana.org.au> <562363e8-ea90-4458-9f97-1b1cb433c863@kernel.org>
 <8bb5a196-7d55-4bdb-b890-709f918abad0@kernel.org> <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com> <20251002172310.GC1697@sol>
 <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com> <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
 <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com>
In-Reply-To: <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 10:11:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
X-Gm-Features: AS18NWCXa0wSJ6_VpJSDmpZcgomwitAo1Hggc1PbqkhjmqP5uTQVk83I_Ms3YkQ
Message-ID: <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
Subject: Re: 6.17 crashes in ipv6 code when booted fips=1 [was: [GIT PULL]
 Crypto Update for 6.17]
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, "nstange@suse.de" <nstange@suse.de>, 
	"Wang, Jay" <wanjay@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 09:32, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Okay, so I get that we don't like fips=1 around here (I'm not a
> particularly big fan myself), but what's with the snark? fips=1 exists
> in mainline and obviously has users. I'm just trying to make sure it
> remains useful and usable.

It literally caused non-bootable machines because of that allegedly
"remains useful and usable" because it changed something that never
failed to failing. That's how this thread started.

So that's why the snark. I think you are deluding yourself and others
if you call that "useful and usable".

           Linus

