Return-Path: <linux-kernel+bounces-726567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF126B00EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CB01C25069
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0A2BD013;
	Thu, 10 Jul 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ow/zjSNn"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46A4C97
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186899; cv=none; b=Yn4p183NjoJTvosZTOsZU+5Z2O1l/VcibT4kGDMvEjUadYlu00TBTmkENhIzMQ4j92vwkGzQ/+eOsxtZln2mgX+YAi+89VWLq/iN/+qb0H4R8c2EMNrpP7uVZ9OyepeyYjimZPsdEO7rHaveDvvx2eZ66vsU6pQ4buv0XOrfJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186899; c=relaxed/simple;
	bh=yVh66acthu6J6IcXm4m/4Uj6wbfy1DTZooP7O1ZX4H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1y5i/l6UCIsdxxgr8L6B8FQgg4ZEdbXV5jUWIu9N8Lm1/Emi9CkSPj8C+YP/+aEcE3L1haA7ZjKWWvq701x06422eYRZ00+jFPUAgOKl+318nNZaz++lnhii+BNvSHSrqYWvt0Mem7LlgpGVMtY+ov502P8hWl1bCPRK39uS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ow/zjSNn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-558fa0b2cc8so1296545e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752186895; x=1752791695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dPHJ//ZU8p5qKrzh9zty72ZQJ4R8fsELp28sl7pL/M=;
        b=Ow/zjSNnttk4xulKkUfjGD93GHch6RikRFveK8BfaAQ00grSoDkI8DhYd2m/bZtrFN
         GRGKqqGcVNeJIvopUZa5m/KOQn9U2LPL5x1+OklNO8Lo4pIPR9YltyguHnZ9PpUpcg+M
         1Mqy9jDabO6WmbIi+eGmU9P4UM4xuFJCE1urb+6XIjR7ypatVn75os50ylYt1VhLIlAZ
         9RBBBI0jqnXmxKSf6fRJ430lVegNu5OgeRjf6rNkSHW/ke4FziK1BHs7Rxcas3Pk/c2B
         3EnlCBsT0+Ou9kPmfKfs/CUVF2/ou0o0OmNu8Ikem5UkLlcvnkXcpAzZq4xpBFPzpKW0
         Ra4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752186895; x=1752791695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dPHJ//ZU8p5qKrzh9zty72ZQJ4R8fsELp28sl7pL/M=;
        b=ZW2lhNwT+BmxIirBxLe6cqHmyCcnSyyM0HNFvQxiAbCuLiCl0AkJwBcj5N02NlnC2X
         pbteHUsXUcm60+KyK78XO5FPrbkwQ27OKG6a1TCW9B4uOzzeRYUwaFT/tkDjmixh8N8H
         Tef0o5gzic1Xd+EdhU2x/TxG49UtsMyFFYmEqF4kd98T3AenYXeUz280UJP/g7/tft1V
         IJGdKp+AmpSM896MgRMESFwaLYstiQV/hbUbWx7onCg6FWfpL3fBnS4pZ9IYTG4/lGQU
         Xgz2bQbvqArvjpV10aW2KWtfH93LHY6nGfED0Syh5JEacZkt18K+gbnMHOkz9qRA0551
         n9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU3SRF556dVpsQIGqRtV5G2njtdDz5veo+fX6UKHm/5HKizLDtRCmnOESqd6qoEAIH2W5wnTTFGO6xm8yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNOM16/7quvPs1J1hEg8fT5W9zf5S6pQhF23Eq+mdpOCEAYO4
	5i6iyOj1tbR1+uKmr3ACPbLjgdhySsf/WAPNGrpFd/wKCglM5kYirA+uAsrb3Rb+r0BqH7HX1z1
	QlDSp+23uxmlhIswnZHFn91XeaBr5fwM10Gl40Jw=
X-Gm-Gg: ASbGncsys5+g/s50E9MUsz087fBYtND3mebfTGSpC3rYq98LtHOBLuOlsnZHoxAss2p
	ElXAN//sCz996FRx3SnQo4bikk9B4ibsDdi/hdHMQh/Ea0jROizDdu/pEciz0T4ZtQIF7Zo4oaL
	xx6ocGndtZJnd9x6sS2tWf7oO80yD/9ZcjIvy/85/irk3/NzPs1hpyFYxe7HlOUrrheWK58tY/0
	HTftsrHVZoqkpF8NdE7P/mNU4lb2spIntN9YmURwPq5tRY=
X-Google-Smtp-Source: AGHT+IG0Jt0F+H8ws01F7A/4pvkhxz8kyGzoUj7Y3DMX9DxPL5uC4Dxim0O59t0qkQgtO/+aMgx5AjX4UJwG32eQQ1w=
X-Received: by 2002:a05:6512:15aa:b0:553:28f1:66ec with SMTP id
 2adb3069b0e04-55a045f07bbmr166129e87.31.1752186895155; Thu, 10 Jul 2025
 15:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cbd9533b091576a62f597691ced375850d7464a.camel@decadent.org.uk> <CANDhNCoYPX_5m-v_sR4TJ3Xj5TVtrMLP8Bswo_-_+BMXwWUkjg@mail.gmail.com>
In-Reply-To: <CANDhNCoYPX_5m-v_sR4TJ3Xj5TVtrMLP8Bswo_-_+BMXwWUkjg@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 10 Jul 2025 15:34:43 -0700
X-Gm-Features: Ac12FXzRtPRCG3vVKe_al9TAYFZy78y3CS7g8LC2LK-_0V2sZ7fkJfcot95IKmY
Message-ID: <CANDhNCqK26S7p0nypKOytgvzKUL8CMMr4-JbN-8PkNc=Em6VYA@mail.gmail.com>
Subject: Re: User-space watchdog timers vs suspend-to-idle
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	linux-pm@vger.kernel.org, 1107785@bugs.debian.org, 
	Tiffany Yang <ynaffit@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 2:59=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> On Thu, Jul 10, 2025 at 12:52=E2=80=AFPM Ben Hutchings <ben@decadent.org.=
uk> wrote:
> > There seems to be a longstanding issue with the combination of user-
> > space watchdog timers (using CLOCK_MONOTONIC) and suspend-to-idle.  Thi=
s
> > was reported at <https://bugzilla.kernel.org/show_bug.cgi?id=3D200595> =
and
> > more recently at <https://bugs.debian.org/1107785>.
> >
> > During suspend-to-idle the system may be woken by interrupts and the
> > CLOCK_MONOTONIC clock may tick while that happens, but no user-space
> > tasks are allowed to run.  So when the system finally exits suspend, a
> > watchdog timer based on CLOCK_MONOTONIC may expire immediately without
> > the task being supervised ever having an opportunity to pet the
> > watchdog.
> >
> > This seems like a hard problem to solve!
>
> So I don't know much about suspend-to-idle, but I'm surprised it's not
> suspending timekeeping! That definitely seems problematic.

Hrm. The docs here seem to call out that timekeeping is supposed to be
suspended in s2idle:
  https://docs.kernel.org/admin-guide/pm/sleep-states.html#suspend-to-idle

Looking at enter_s2idle_proper():
https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/cpuidle/cpuidle.c=
#L154

We call tick_freeze():
https://elixir.bootlin.com/linux/v6.16-rc5/source/kernel/time/tick-common.c=
#L524

Which calls timekeeping_suspend() when the last cpu's tick has been frozen.

So it seems like the problem might be somehow all the cpus maybe
aren't entering s2idle, causing time to keep running?

thanks
-john

