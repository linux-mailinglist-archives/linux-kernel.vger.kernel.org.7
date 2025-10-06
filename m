Return-Path: <linux-kernel+bounces-842553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BECBBD007
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 05:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E224618930F1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 03:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1B1D5ABA;
	Mon,  6 Oct 2025 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L+WNLja9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB215D5B6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759720163; cv=none; b=r7lmONYMw36DHVv4e+t2bu3+WIb4iupkC+UDYXV2xWXe7iPfZhOoRt4AhMM4FLSo9/YTXUWc/z1XiX7JocI6MjwNuclfowKY6VHQmgpHq0ydVxFBKq2CnsHWgke3OOxo4pQ3nfPNmaZLQ2YOCc/tKr1nFLsHkCYXP5SmLMUHtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759720163; c=relaxed/simple;
	bh=0/oRhuy7wgyWPo5Tm7sqj1Q+P6Q3YlvZCfruRjEhaP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmZZ6ITCH0Z0oF4fY+pOCUOPHSu8UK4/O91cxyqURBFrqN1bcq6jKfDk2WxVIU0bTvioQQr8rsd/6iap+//6aPMAEIbPTSztdNFT2zq4fUO47Bgi4pEaIKTtwAVjsHHRN5yp06eT0flblK6/0AdAQODclkb9xkOTMYTTzwiUY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L+WNLja9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7322da8so937281466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 20:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759720159; x=1760324959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XWgxquGziqzvKZNt7I2kVikHQscjyClcd2nLSF+ZHWs=;
        b=L+WNLja9xMoJQyY8o1xR7U8qQMiim6T+rTZx8VvrtrgFEWQLkbO8wyHt0BMDuVGyxp
         VxU7jjdIu5+6KeIUtX76u650TiwqI7Zl/MXIlFnynQ+qEsyob7mHwt3ro/AtIIa716/f
         jy9fVG9b478a1av3+sAuKjOFYeG307CdJ1uGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759720159; x=1760324959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWgxquGziqzvKZNt7I2kVikHQscjyClcd2nLSF+ZHWs=;
        b=f9gtsYgfK2iAP3skfYCofdpHx9wrM13ZES3z/dQ4y8ng9VJBOCwKIpHB2qwUaiT4Ub
         kNB2ncEQ3qqRhI+efxhyVzI8wMGeCXZLYbJvUnpBD1rRvaviodp14dFW41FSc6ROFIvk
         5nsCFPqzCk568ZcWipigDB1U+oPHL+mZzGHTyfa8L4tKR1nAXcdBLQPwwQR8s7+kzh1W
         AX7hpKdl7YBDKGf0BzSvD2zdybecJfdbpQsgAbSeXffiaSX6NPUbBwrrtrO0M/EIk3hR
         J6HaHLj4ECwHn/6Q7o1Wzv/dny/dYV+G9rOZftPGOxWsShjMo70nu9CmOPNq8jE0CakB
         5UJw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1j3K/N8WAbS33zhdiGhDeHUa2oyZqoy3Lsn2HTYNiGixunts6vVIKyu1/b0J7/Fic058Cv6q5E+tT2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3rSwUJzsk4edsfjZtk8rCYUB3FPk+ikIjEyP5vk2XeZXcC9cb
	2tNVCYQYSQOBPErLexHRY8+fjQrZzu3Ge/h61bi3tLwFn6enaMKgNEuqDIr3xXNV0eKEi19M9/1
	WPIY1d2E=
X-Gm-Gg: ASbGncsaCkFyozQXLlexAcwPY/AuVnPrSUyq3Y9aVDUi4fUhIm7tiok//nivYdueORj
	RtVz+LpAD21F7ATO2zQorPN8KwPB5c8OMqeC22AEq88f/HRjQOdSHPigiggab8sKo5HeyoulL7Q
	B/XZbnP+ml0JyNgJMOf9waqWi8WHJ5e58Rmx3RAW6KNGR1AeUwOm0Jj4OHoAqbTrAYuwhk+iz+3
	kKjwKfNQOnJTe14OAdWF+Y7oLvhb+2GBI1U6hyjtdCPdHMR1S0geFj8MbQvIpi1vMpH9bo5t1Dr
	IADQ20yJFQjfFQz+Se44TMZ+vrkAXBoCMOyPCEiF5Wo7tbrTJm7oap9w0c/dPmoJR3iFCac8CFQ
	UG4I15jZV5TWoC/+wleEPT7pR9+v2KrdwWjadE1q8Ih0GTj4NK/wmKHtMONRVOC816Qwvww2pDw
	qKnoU4Fs99vq+4zVP5DTCeevcYPA/pJVk=
X-Google-Smtp-Source: AGHT+IHFtNmx1jOEvgbOrPCetiVBStF0F+C3AglGJhasE/sSUAYxeju2902IUZunVQL1AeKI4ZP4fA==
X-Received: by 2002:a17:907:dab:b0:b47:76a4:574d with SMTP id a640c23a62f3a-b49c197698emr1392412466b.16.1759720159541;
        Sun, 05 Oct 2025 20:09:19 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486606bd5csm1036519966b.44.2025.10.05.20.09.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 20:09:18 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07d4d24d09so822110666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 20:09:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUv9gOB+/e94GbYW/zwqmUgynL+6Uqixm1nJYX6z+EOeS1HBcmVBtHP4YojxjBH40TQf7uScVNPqwsTh2o=@vger.kernel.org
X-Received: by 2002:a17:906:a44a:b0:b3f:6e5:256 with SMTP id
 a640c23a62f3a-b49c373ef47mr1108113866b.32.1759720158476; Sun, 05 Oct 2025
 20:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003084426.f2de6028fd74e1af4e13d190@kernel.org>
 <CAHk-=wg6=DwTD7xT3=Zya-ytYrtS2969KtnTWRPskq5fx2Ev+g@mail.gmail.com> <20251006092743.295205e486acf1b69ca61b89@kernel.org>
In-Reply-To: <20251006092743.295205e486acf1b69ca61b89@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 20:09:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpwrrkPCmPa1dnejVr8AcJVpfyh0CfD-3sNhUO47A1dQ@mail.gmail.com>
X-Gm-Features: AS18NWCYCAmDvzfNHEiTpXtpMXsfMVbF8OivmBisFZr90kzYb0fS4SRWp047aEc
Message-ID: <CAHk-=whpwrrkPCmPa1dnejVr8AcJVpfyh0CfD-3sNhUO47A1dQ@mail.gmail.com>
Subject: Re: [GIT PULL] probes: Update for v6.18
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 17:27, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hmm, I applogise this error. I locally ran build tests and it passed.
> But I might missed something.

So this is why linux-next exists - to get testing with different
configurations, different compiler versions, different architectures
etc.

Local build tests are good, and obviously necessary for some very basic testing.

And local build test can be perfectly sufficient - if it's some small
obvious fix, it's often simply not worth it waiting for a few days for
linux-next to get it merged and tested.

And no, linux-next isn't perfect, and won't find everything anyway.

And even the most trivial small change that quite reasonably didn't go
through linux-next because it was so simple can also end up breaking
things.

So none of this is some kind of "absolute black-and-white rule", and
none of this _guarantees_ that everything always works.

Even when everybody does the best they can, something will
occasionally be missed. I definitely accept that we're not perfect.

But big new features coming in during the merge window had better be
extensively checked _some_ way.

If I find problems in my fairly limited sanity-check build tests, I get unhappy.

It's one thing if it's some little mistake that I feel reasonably
missed testing for some understandable reason.

But if I get the feeling that the problem was that there just wasn't
enough care to begin with, that's when I go "nope, this will need to
wait for another release and be done properly".

And that's what happened this time around. That wasn't some trivial
little change, and it clearly didn't get a lot of coverage testing.

It should have gone through linux-next, and the problem would have
been found there instead of when I tried to merge it.

               Linus

