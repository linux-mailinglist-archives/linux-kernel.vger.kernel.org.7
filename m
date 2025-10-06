Return-Path: <linux-kernel+bounces-843197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F65BBE9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15593BFA1B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A001B0437;
	Mon,  6 Oct 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="glXwE8TS"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23F1E25FA
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767581; cv=none; b=Qd1c2Pc3kfPiPRY5EAjFef1yTDwfgu4JivdMqFJIbROB4g5c0CWRkvnwTa/32J5UjXSg3oMDtCAmk7GaQgxpxLmtvL776MwhbnY3zPnC7Z/jNs6I1EAePvetyAXh0xH1NiptvqomTGVkY6Jv/X8ci7Pb3jSi2wipQCXRi6kva/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767581; c=relaxed/simple;
	bh=ilQLZBd6Iw562q61xBjSjhOvv2dstXz6kwD00scDbX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btgYzuzZx6ds1qPgkp2st2zD5n+RxxxE5e9QEX4ocpSCL8t/6FwUBpNDzVGfXI6faFumm5ZV552otlGeaf4x7iPbHdIDP6DIHvdPTR/gZ+kL2AX/+tsaL/TzsBPMab9+Uf6g+Qc0+1Amz0i+mIPf+myU3uYuqRHq2pIKQUE4ScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=glXwE8TS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b457d93c155so910033366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759767578; x=1760372378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTyUjRqJNWM7omsm7yhQtvnjFIwOU00+n+cJwl4in/w=;
        b=glXwE8TSJznJIHG9Wg5Aqw2xApX3nturVnmkmu5MJUl66WuImBArYsxTfQ1Ei/o4Py
         /TOIadaM8dvrOysoISWDrjCxnvTbZ7dpxGmVREwkdMhmgrnl+K955Gq14AM5F/m2DqxA
         UcVgeUzovfz+FRB6YtkVHoOZ8pl39WmEPuvTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767578; x=1760372378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTyUjRqJNWM7omsm7yhQtvnjFIwOU00+n+cJwl4in/w=;
        b=jKetU7zuLArqKY/8Uf6idbArj1NNSmWLpQWGKwqIMGUOONP7H4grvVpEbukdS59yOI
         4Ud6LHd+IRDBEWeZrUv0u8r/R9szG32uOAg+BMb+bVHhHvC1FdL91LV+yfiI7ouY8Dn8
         zTdMBjyGx3aM5PBAPRsBk62wiMdOCHPfpVwom/a0wHztSBhNOD+wq17+LcaINbdVybAc
         dcoQ7KnM7oDm2j2KF40P1tKhfM1KDgmTi1qVcobLWOu6yaXsY7dgpYl1qiCQBEi3ZIJ4
         pBdq+YWUTyrnDEY431hL4tzgh0Hh2VA71FInjxUPBJ6IifnwRz+saQPoTvfw9SoWs6ch
         DdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSUchA9N+fdoEgTWAPxhctq59ZleycdQn4AoEl2YhExCqeUv+2v0/IvJ0GOUzJT/uvCjQ9sgDo09pEqkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzum99mM8yLyXnxi21u91FabxAObDMZcWF3NcRDD4BGqX/m0Bq4
	TXRsIe9MgPYMA+TZHrzsxZC3AXY5mQ703y/atRLP25rAQGwnI3+IPFwBm7va+pWZA/ysNV9vF6Y
	y7mhs6VE=
X-Gm-Gg: ASbGncsJIxhQMdIpc1BlKA74oRMVd6PVGTpmsSLSsZN9l0bjXj7w8LZOc6W2eTGtyrj
	hOWGpKcAcNOC+bud9oYvUdPR2tpHCe1jClE9/9VVntfKAWeLprFW48kac1bBIUM1yIWuAjcSS2o
	9Vk0+N6e/izy/LG6jKhcXKI8rS2THpfP2qF74F3nG5HZhpzokgJqFcSIkL2XcOEIHzlFC/pzRc+
	CAtDsyTwwYc/l705XUS3g3zCIx2rmMafCp7kQorBM7wRlJClBoZ10qvx3zoB0MhU7XlZ+9yNLiO
	mulCZJHxj34axQ4js5zk+q5nMsQFQGNF0eg+IOr6wBpoD0V8dhRK5N+YKEqIKpTEtwTI6P4TpCV
	6MvN7LaLYPCvd+BAP2eVM/iDAocXtYjXyPYN1vok5TdV9+ZS+tM2StL3mj3VfLxXQtsf0XnKckB
	ZsGe31Nt/yferAKxsTqRAyT1n5lj6n2aA=
X-Google-Smtp-Source: AGHT+IGkR30FWrM5HJz0bkdd4FCGYmeZvWjLaZuROrJTW7ZrBpYVjCd7dWMgxPWb3c2HM33SAvvjSQ==
X-Received: by 2002:a17:907:9493:b0:b41:27ca:6701 with SMTP id a640c23a62f3a-b49c1a6c16amr1563821066b.24.1759767577557;
        Mon, 06 Oct 2025 09:19:37 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9f50sm1173920566b.9.2025.10.06.09.19.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:19:35 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63994113841so2390685a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:19:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4RX9nyhjn9uZCOrfAhuwHSClX2UCwDmnYkk7kQYMpjFtAi/Bu1VtQHPBJ+rawJU8ldZnJHepy2r1y1nA=@vger.kernel.org
X-Received: by 2002:a17:907:96a9:b0:b46:1db9:cb76 with SMTP id
 a640c23a62f3a-b49c3350413mr1708289066b.39.1759767575015; Mon, 06 Oct 2025
 09:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIirh_7k4SWzE-bF@gondor.apana.org.au> <05b7ef65-37bb-4391-9ec9-c382d51bae4d@kernel.org>
 <aN5GO1YLO_yXbMNH@gondor.apana.org.au> <562363e8-ea90-4458-9f97-1b1cb433c863@kernel.org>
 <8bb5a196-7d55-4bdb-b890-709f918abad0@kernel.org> <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com> <20251002172310.GC1697@sol> <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com>
In-Reply-To: <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 09:19:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
X-Gm-Features: AS18NWDoHsGA-jRDtJnK1_zO_N3TBkB3duq0d2_Pl_53b0GJS8ieGMah2y3ZACw
Message-ID: <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
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

On Mon, 6 Oct 2025 at 04:53, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> I'm pretty sure the use of SHA-1/HMAC inside IPv6 segment routing counts
> as a "security function" (as it is used for message authentication) and
> thus should be subject to FIPS requirements when booting with fips=1.

I think the other way of writing that is "fips=1 is and will remain
irrelevant in the real world as long as it's that black-and-white".

             Linus

