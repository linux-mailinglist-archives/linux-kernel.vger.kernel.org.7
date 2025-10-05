Return-Path: <linux-kernel+bounces-842347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A776ABB98D8
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 17:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AFD3B833B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C75D1E7660;
	Sun,  5 Oct 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SqYo7PrD"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D20277C87
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759678464; cv=none; b=RThBOKsrncjzEy2/EMIY4NY6x66sJmFpQEeNMBj7LbFJQZuWZgc8/zbwzi02xzK6jFT7SZgQMlFs7duaQ0U/H/2X/Ap0gTYAB8h8N1ydEMpOKZX1q41OWvynXqFa3as79wD+MNpo0ymUWIJ5oLnCYX6HvjyOcOigYoE7do8TYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759678464; c=relaxed/simple;
	bh=MKOfhui0vwQMm5lbXdATgna6tDnSXX9agjqwBCYKOT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N63ccet1wlvcZFHvHpmaFskslikFM0vlRZYiNExnbYKFcoDFFWaRhg1bYIFDTJHlZsaKSHL1RNSHAZ742QeGCURGYv723y/UaBVH6RpXXtzjdM70WEBfOCSdVxsIipllgQEEYJyrgEixXi8NyZL8rF9s2ZWYjfGs66H6tXXqu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SqYo7PrD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso9640472a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759678460; x=1760283260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJkDFsvQAUInrfdD+BwKkH2XbRgSJZRJLqdNZdb2lY4=;
        b=SqYo7PrDymIv97Gxp51JWc7Hc3PbG73/eCFW7RgmdinBkTMzr8623ymFEfCpnF8HrH
         9ROnhbVKoc/akASb6s316ZeFPqiR0K+vkgwuuRQSxkpW6/GU83+C6PhFLO/BTrR3WSMt
         pM8SZ47/l1FloBd4/c5+ghQVmau/GRStoQRKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759678460; x=1760283260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJkDFsvQAUInrfdD+BwKkH2XbRgSJZRJLqdNZdb2lY4=;
        b=mhb/XlFg9hqhA6m3K6t2mmFnHrQ5NOYGjB10FzYxQbht5BWIFnBElJnMX2cUOnUM6I
         gVhNr/Tc8r5a0bwPTlPGlvxnK4JiJECOlx/PrOz875/6fT0xw88KD1MKAvoOp0R2qaTk
         GDGWtQG/IiO5b0NdRxV3s8lzRMzHk9iddGRcsXTYyixCR+jql11zKV80OdZzphMV6FRg
         FvFllMHZBj3l+isICWYZgYRzmJayIjrMpFqs35tw1jdofkK63XnMPolkuiFSD4ySun4l
         F/SdC4tRiHkDZbuhtaB3p3x4U3fkFBV8RMHpAp5TBlNvjFPrArSFuTnY3vroNvKtksKN
         8aew==
X-Forwarded-Encrypted: i=1; AJvYcCXmtX178cZigOT7Ytp3sDzc/+85kRSij52MzI6ZU8pw0UQ4aCph4iW2e+iRkCu/8hGiqvV9XCRUs0qBeZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiFOgdAr7FG172UmgPKvpAyn/r2whpX5wbHyMoInboem998G+
	TUX0RTWxxWE5uVxv/1J1ABkTtZ91VfKM36J/IYs0PBlvY3bOcuQ4xY5TsaSiX80y/aMNalH4j4z
	L88huTcc=
X-Gm-Gg: ASbGncu9B5FtYT8cwzBV/+T1Sf2owHQ2LdASa4NolgCOz+c34l/dw2/RezlVF99A3jZ
	Wa01g3Z83uoVOFqSE09eeQ7vrDe9QUPlvkteSys1AfneduaqC7t1sP00JtSl/IAI0T1SjoennGm
	5wBNPI4yVmLYWnllLtI7OBLUBFWoS3O8bNEbEfNkrMd2JLVvVyTziaKAnLvu39I2PVvplBo5Rqp
	0J0YfNCoMYPGdZLFFre29dMMUpdtzCbhbWm9NU3sivKApAj2kvD9DyAeXl70L2D2wwwv24Rp4Ct
	DiYKIHyL0lcs0R2zF0CpbBKKDakWFMzZQEx5v/n4R3/DbcnfvkPFP1dMHSv4pI5Xzyzh6mu+kZE
	/B7HIDjFW3aOlsqKoIiLNVLJ+RPqVrZmN+UQMFEgNaZYBhBXWTNAb4sCtcm4uEUzVIlhpS7jKoi
	Ls9Hn6FeKlFnRN1z6rblsG5vs7QY2xqG8=
X-Google-Smtp-Source: AGHT+IHltcs57G+bnmOnZFPCOwx5Vi1mXQ1+c8ktv84P8LTquzOfzFGGigEdyTszNGwPL8+bBsbwmw==
X-Received: by 2002:a05:6402:3484:b0:633:feba:4756 with SMTP id 4fb4d7f45d1cf-63904da2aa6mr11098182a12.12.1759678460318;
        Sun, 05 Oct 2025 08:34:20 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811f14bsm8327785a12.45.2025.10.05.08.34.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 08:34:19 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07e3a77b72so856763266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:34:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoriWc00QsepfYpZufGeN12/zDrHG4nqVeXbmVHxXLxkRQL6KidhEhNM5LLvZ4XJi562rzb5oq3WnGHmY=@vger.kernel.org
X-Received: by 2002:a17:907:7f02:b0:b41:c602:c75d with SMTP id
 a640c23a62f3a-b49c4297b0bmr1314052266b.31.1759678459251; Sun, 05 Oct 2025
 08:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005144929.GB1188@redhat.com> <20251005145016.GA1254@redhat.com>
In-Reply-To: <20251005145016.GA1254@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 08:34:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPvwcRwqNmvuZ=jNFyX9g8kO=ECN4u=shHiBknNuTZcA@mail.gmail.com>
X-Gm-Features: AS18NWAaZZ7UJKoC6GOuA6iX-qT8SD2YzmnzsjtOzu-44C748TuzWAKX6bk4SvY
Message-ID: <CAHk-=wjPvwcRwqNmvuZ=jNFyX9g8kO=ECN4u=shHiBknNuTZcA@mail.gmail.com>
Subject: Re: [PATCH 1/5] seqlock: introduce SEQLOCK_READ_SECTION()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 07:51, Oleg Nesterov <oleg@redhat.com> wrote:
>
> +#define __SEQLOCK_READ_SECTION(lock, lockless, seq, flags)     \
> +       for (int lockless = 1, seq = read_seqbegin(lock);               \
> +            lockless || seqlock_read_section_retry(lock, &seq, flags); \
> +            lockless = 0)
> ...
> +#define SEQLOCK_READ_SECTION(lock, flags)      \
> +       __SEQLOCK_READ_SECTION(lock, __UNIQUE_ID(lockless), __UNIQUE_ID(seq), flags)

Ok, I like the helper wrapper, but I don't actually think we need it
to be shouty.

As far as the users are concerned, the result doesn't end up being
really any different from our scoped guards, so I'd actually suggest
you just make this helper look like our scoped_guard() macro does.

And instead of making people pass in a NULL 'flags', just do a
separate version of it, exactly like we do for locking. Even if the
internal implementation then ends up sharing most of the code, please
don't make people pass in NULL just because they don't want the
irqsave version.

So make it two different things:

   scoped_seqlock_read(lock) { .... }

   scoped_seqlock__read_irqsave(lock, flags) { ... }

or something.

(Maybe 'flags' can even be local to that scope?)

Hmm?

                Linus

