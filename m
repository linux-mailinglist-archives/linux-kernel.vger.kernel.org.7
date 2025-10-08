Return-Path: <linux-kernel+bounces-845743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A3FBC5FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 501174E52F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E32244686;
	Wed,  8 Oct 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cm43++bm"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2681D5CC9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940172; cv=none; b=VZJDMwRZmtTyIBQjyAMoIhmZ/fybd523Xy/KK5XRBFcfC6ckK6lHnnXj7+fSQq/vjzTsJKWwmQSxWZjZgzSpl8x6cJB+hmUPNR3uMrkGnPNFN1EDUlMk/zQTMksQp1GSfnhP1fYztshTX5Y7G5nfw6oS7c3bfxVGRzIh/UvYBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940172; c=relaxed/simple;
	bh=uEGenzvUyzBkuEtUVn+BvDaUco6V3TK5byPQuBV+0Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKbQ7fwJLvEw3oYOuqQPi0ZQSPZMjiHy+tD0/i4T0/HLytCKGOk7KPQNxJl7qAshSPJQU6Q6RoaBL4Ozav0lQ8/SUhwr+PYfi0n//3eJ51HVN2TzTqWho/vRd0sBIbns64UnjF9FgR5xryNagsPjy4lU4DYOfB477tACM8Tacf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cm43++bm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so11287327a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759940169; x=1760544969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wafGHdomjeTMWOaW1CHD+uCxSHknTrB56S6k0QVoIaI=;
        b=Cm43++bmhXYlN7w1DWapAMICbB9FZtTY8rg7bredgqSkYAqFKaChUQ9A5cvcW8oFMZ
         4qJrvJLQ2Kz6VA/jx9SFV9UOyIp2BU/zBeR5G4sRsm7Q1pyq0Rts0NPext9li6UufRxU
         xniv6W06t33oj/TlBorylxLJqIptQAibbXHUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940169; x=1760544969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wafGHdomjeTMWOaW1CHD+uCxSHknTrB56S6k0QVoIaI=;
        b=AKpML1ayTiKNkk+1x6Sx+2Trygf8Gz7yoRssVgg9dWq9Pg9nz9RPriiGfSV/N8Ww5A
         9c5UTpsB4u6f4PlYWqLRLhr0gilFsrqRmn2MPbEstGhyIqlWvQn0s8FPe0ltb3J3iAzB
         RNCIF35kKKDePB1grnFURchgURPQXIfAAXaVTRuJxZt/XN9GTg3Cl4BS/jvqCpOQS5sQ
         knbQPcmpsGZyv5kTyU8pwkKBwFftDOLbVMPhVC2fO9ZtJb7pHGGMuOc6gOakESinCzSN
         d8YydTvTzFtN2Z/LRGyyaG7R+4DB1/TMJV9DVfsTbwxDLCBR7eKwhijSGoU0Mdt9WA/6
         gReA==
X-Forwarded-Encrypted: i=1; AJvYcCWUGg3H/lZ1tjIJdbhjVNkPfE8le7yv1K1jL9BgY9GASisrgngm/t7oAdXHB3YILHLCeh89rBk/iYMy7KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXX6cXNfGEqfYIr8yhKbZ3gMdByofhm6fUW703HAQ43Df10YD
	BdUXyvF9KBDoDc91hPI3ooFfJPg5JzE0l3UnQVDP4Jf/tEpVLAzJ3LPU5nS+42kC0/FUB/Chhji
	54A+sBZQ=
X-Gm-Gg: ASbGncvHkiwqQovdDdciB/l8WBIRvkFedVJ2LY/cv2ie+zqduY01igngRI/FwXi9PJ9
	/J6bbpfQ7alDblLM25m5MOCetzepEgDgnGU19SCwmiGF212uTmXVDEi07mC1oUH83RO96yWnU/I
	+8xaZXcFvQcdwUwLxPOpurKe62nz6Svfl8jlJ2hhzqzgaNUqy+GzsRQJrnzKIMjCsK43VP8Vx3O
	pqJgqNj/PRox/IYe6/J+k/GX74WzZYLwWCAsT0FwLGrmuud9JIVgKqCstsYvkOBnTCG3tHo9NfR
	yD1ixn7iTEnEDv0LS/wyJ+l7q2JqGlbtRVxrUHFc32LlzpnRR07TX9rupjnOfcX2m03p0O03dEf
	AvLsHPJxLgxPpO4et14dF2W+8KPJUiwCu9ZKaYs4zsTtswExo1x7YRgodWCMQV5ZLOZfvOA8vPU
	6qroCA/nINncnV4hjyGUmN
X-Google-Smtp-Source: AGHT+IEaluyChxIh5vs1HjszT8Z3a4kOu/QEgUjuYPiCpz32thBVPhf+5sDOFRi/6NgKXY5fD4Q6VQ==
X-Received: by 2002:a05:6402:3506:b0:639:c94f:93a4 with SMTP id 4fb4d7f45d1cf-639d5c30226mr4079220a12.23.1759940168959;
        Wed, 08 Oct 2025 09:16:08 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f3d0a0e0sm284606a12.32.2025.10.08.09.16.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:16:07 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so13207275a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqkkEiNeYFXceXAQg4/wFKvGnmL9sQWfJ1JyIYkOat62xnRg5CrmlFsDC0SvCXbUzB4fEInnRnXVmfOMQ=@vger.kernel.org
X-Received: by 2002:a05:6402:1ed0:b0:639:e469:8ad1 with SMTP id
 4fb4d7f45d1cf-639e469a2e6mr1978291a12.20.1759940166695; Wed, 08 Oct 2025
 09:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com> <20251002172310.GC1697@sol>
 <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com> <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
 <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com> <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
 <e1dc974a-eb36-4090-8d5f-debcb546ccb7@oracle.com> <20251006192622.GA1546808@google.com>
 <0acd44b257938b927515034dd3954e2d36fc65ac.camel@redhat.com> <20251008121316.GJ386127@mit.edu>
In-Reply-To: <20251008121316.GJ386127@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Oct 2025 09:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTKNg8+F5EUP2oxcfr14P7geOOpaPBwhxF7a0jjBm2GA@mail.gmail.com>
X-Gm-Features: AS18NWCvIhnESJ0gUsT-9HGa5XjpSt2eBl3AMS3_hBGymdQg0Vd76BELyTS6HCA
Message-ID: <CAHk-=whTKNg8+F5EUP2oxcfr14P7geOOpaPBwhxF7a0jjBm2GA@mail.gmail.com>
Subject: Re: 6.17 crashes in ipv6 code when booted fips=1 [was: [GIT PULL]
 Crypto Update for 6.17]
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Simo Sorce <simo@redhat.com>, Eric Biggers <ebiggers@kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "nstange@suse.de" <nstange@suse.de>, "Wang, Jay" <wanjay@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 05:13, Theodore Ts'o <tytso@mit.edu> wrote:
>
> If there is something beyond hard-disabling CONFIG_CRYPTO_SHA1 which
> all distributions could agree with --- what would that set of patches
> look like, and would it be evenly vaguely upstream acceptable.  It
> could even hidden behind CONFIG_BROKEN.  :-)

Maybe just

 (a) make it a runtime flag - so that it can't mess up the boot, at least

 (b) make it ternary so that you get a "warn vs turn off"

 (c) and allow people to clear it too - so that you can sanely *test*
it without forcing a possibly unusable machine

and then

 (d) make the clearing be dependent on that 'lockdown' set that nobody
remotely normal uses anyway

would make this thing a whole lot more testable, and a whole lot less abrupt.

Christ, if even FIPS went "we know this is a big thing, we'll give you
a decade to sort things out", then the kernel damn well shouldn't make
it some black-and-white sudden flag.

So we should *NOT* say "FIPS says turn it off eventually, so we should
turn it off". No. That was very very wrong.

We should say "FIPS says turn it off eventually, so we should give
users simple tools to find problem spots".

And that "simple tools" very much is about not making it some kind of
"Oh, what happens is that the machine is unusable". It should be that
"Oh, look, now it gives a warning that I would have a problem in XYZ
if it wasn't available".

                   Linus

