Return-Path: <linux-kernel+bounces-728336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A65B026EE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0342C7BEAE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12A221723;
	Fri, 11 Jul 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dhOkkLO0"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13518DF6D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752273027; cv=none; b=oDC1QfEZsRi8B2nWz3XcgAC1TyPxTcZgAWimhfbYHhFNQ6YywOtxpm17scQeh99M6mJ1p4U7xTwjaH29VVNcIgkIKBr7Am4JeADu9JCj+DTNAudBgXKQouu8QM05AUmIG3dW5uBf1bYa8YaWpLDwbeZVlD0OA3xy7OTdG9eKqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752273027; c=relaxed/simple;
	bh=+gxf5glKr5Y12GsxwVPIc5ZCa6TWWIoML73+PYGD/iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNwAEuUAaBQAxpNAfuHCWVCH2KfFmBMOif/SI2y8W87YDW1vEmWTSm0xZYMBgg1xQvFPg3uaehgPdMBVqY/plhslNyhtNuXSO3O7A3Cln8utnq45fusjvV9wVGsInJ4DKyrYcImOZsaU1CHl7kithAomW6HWEJz+51f9yaHG6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dhOkkLO0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso4865548a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752273023; x=1752877823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YLD68ZjdrAqzhf6X1KszyGFRL1lje5bcBvEkTHmcXNE=;
        b=dhOkkLO0Y9IOwrLrCMV/nwnesKYvX4sAjdZCdnjYg96BDcUww73uzzVU4LSX1PmjJP
         0c1VBOD7l88GNuA69eMXVlD1pcKOfEmVNh3wrq31ne7dPs1SoliLeUixNDxc0R4+H/hY
         qZtdS5D3y0ClXkqG95hcQFvjJnWDz0ijs15io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752273023; x=1752877823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLD68ZjdrAqzhf6X1KszyGFRL1lje5bcBvEkTHmcXNE=;
        b=uNCwKAfbdSg2v/FU2GBNR0VoYb1DXACfJ3upb8zOfKDWU+QnmPg3afBy4AyapFUAA9
         8mJ8kw0xMXvsrgK0sLnoeGz6zu7uvnCwo6WJbQ4MBFTXzfsiOlhV0740eCx4ijbx7knz
         6DdN0yd1+gOkNG61ovMZ89rYhUMpM+BmnkYpqwFjNqtFhmV9a5MwoIaCX7buBI80VjJU
         MRCljm3hs6NBtMo34z5aQG10/AWDvpwNs+hwZCpuqW+jZXD9VLvLwYTttbi8Y9UE7Q2e
         2q3QofeJObAFFigVEPgvPT7cleKhte2aByaS5nxtw8VRFnFanb1BJyFY4at/vGwvLSuV
         2O0A==
X-Forwarded-Encrypted: i=1; AJvYcCUJw8Eiqqq26kQd62H4Rkz/LdhMbfU7ACb36kOIx1nHz1uuCc/lnV41tQzZTMTq0QFJydSH/uZ5EPL9TLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9hD8cKOMquWjUKkvXSndqKSBzaz48Jc8pSTviKYT0XXtM+/m
	cf2PNyO3MeFNvEfgYEyrtTaxjp1TPDD9H5WTrSa985tGWhQjn0vkmojlvgb7IyUGm/DylinCLW5
	11zqm60wDZA==
X-Gm-Gg: ASbGncvdRKx09ICknLuRVTRwB6TqIR0pFrE92xz5FOBQzXATuHEyHv30HnmA+SketrV
	ReIlSN64LF473J3GaUgsgFbMK32GxUvY4JSR0jHYi7ONvvIGxqJOGw2WEtOGted0O0YOLDScMlY
	NYpo5iK36Et7MiO135/kZdDISVM1smBsNGTLivv7wAHQpe9isLW15ut7NEnzKXU5/W/B9CJM6eX
	cioxtUTiCzvFfuaqQZ7c7X5C1yFv6kyZa7konpESeK9pcOovQ8mQuMTplP9tZopMqYUF+ozBveS
	zm1tx70EA5DTWIxGJ/G+nows3fOogaTQGxiyTH/GVuPD3hS+xcT+k/cnca/amRRyyBRdqNlVTOz
	osWlAcPcbcL0b+CpyhlIKMURe4mZkglPPdGu5CAIUtmG0pwq+p2UeWAkMIQZkHWrjc5vac+Jy
X-Google-Smtp-Source: AGHT+IHw91qectyC2xH5TiBf3vwSHG28RwxCRM4tYvqf1gW4DIXmgUFxTaoJ1D2KSQjdCXhELCrGAQ==
X-Received: by 2002:a17:906:c115:b0:ae0:b847:435 with SMTP id a640c23a62f3a-ae6fcc3a1f7mr543581666b.49.1752273023000;
        Fri, 11 Jul 2025 15:30:23 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264761sm373837266b.95.2025.07.11.15.30.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 15:30:22 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so5025383a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:30:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmOmhv4UtpBCJaR1MkVQ6OFlmd7/0v8HMDtDsDb2BpI03d3YflEweuViZShMQSx7hTmncujOZjAWsFa6g=@vger.kernel.org
X-Received: by 2002:a05:6402:27d2:b0:607:eb04:72f0 with SMTP id
 4fb4d7f45d1cf-611e76189edmr4297034a12.4.1752273021572; Fri, 11 Jul 2025
 15:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709193910.151497-1-longman@redhat.com> <aHGONjuRiA3KfH1q@tardis-2.local>
In-Reply-To: <aHGONjuRiA3KfH1q@tardis-2.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 15:30:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com>
X-Gm-Features: Ac12FXwASns96m-41VY-k1n1aIR-4eH8ALpJT_HejKAMSEeXXr0CxqbBmrFNRWA
Message-ID: <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com>
Subject: Re: [PATCH] locking/mutex: Add debug code to help catching violation
 of mutex lifetime rule
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 15:20, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Meta question: are we able to construct a case that shows this can help
> detect the issue?

Well, the thing that triggered this was hopefully fixed by
8c2e52ebbe88 ("eventpoll: don't decrement ep refcount while still
holding the ep mutex"), but I think Jann figured that one out by code
inspection.

I doubt it can be triggered in real life without something like
Waiman's patch, but *with* Waiman's patch, and commit 8c2e52ebbe88
reverted (and obviously with CONFIG_KASAN and CONFIG_DEBUG_MUTEXES
enabled), doing lots of concurrent epoll closes would hopefully then
trigger the warning.

Of course, to then find *other* potential bugs would be the whole
point, and some of these kinds of bugs are definitely of the kind
where the race condition doesn't actually trigger in any real load,
because it's unlikely that real loads end up doing that kind of
"release all these objects concurrently".

But it might be interesting to try that "can you even recreate the bug
fixed by 8c2e52ebbe88" with this. Because if that one *known* bug
can't be found by this, then it's obviously unlikely to help find
others.

That said, it does seem like an obvious trivial thing to stress, which
is why that patch by Waiman has my suggested-by...

          Linus

