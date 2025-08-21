Return-Path: <linux-kernel+bounces-780748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE118B308E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989621892A92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388272EA735;
	Thu, 21 Aug 2025 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMqeI6ve"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170532E88B2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813932; cv=none; b=Lf/oAjEyWpqNZSvCQciLnkmgkhvmkqPDJgH0XXxsIDkCneyRGLFr0NDz/VST2TFinjcyCV/V62680V1og31jFjd6/rVYMawr3D9/y49Qg/YwHhF91KWdz7k8O8YlCodCA1s4WKIRRb2/GEADt1oHntXbhgAtq5cB5exoBHlwX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813932; c=relaxed/simple;
	bh=P5+PojnbPQTrtRF9Wl9yX8jlXFvLA4BAuQTi+TBvbvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsLFQBxnsnKxEf5vDSMLEWIBsWBs0Y5fUEkFYKmxEbnjeuRYu7kShV6DXCaepvYfKzG1AuocLqzkzdT+cIVhlDXLghHP1gGagXX5s2cgp29dSK1pb0XBGepXU+N0QZfodJbh4y40KNYf8vyCY8yIL3nvvPIme0+uozApuKt5isU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMqeI6ve; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f918d71eso10639541fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755813929; x=1756418729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEoIGgjzTubRPR28lvO2YuhgPwi8mIAHDjAhzXLrRpI=;
        b=KMqeI6veBBSeUt4WTF5AZfXmnBmmrDjnwl5GCE59G0pkt5+n/zrhBawyq0siA3DvHT
         CWjqFuCO9vBE/fX8KxI/3a6G9Kbsj6FYOdl+M+fYEU/7aChAg2F7vyt2MqGbW5RxrALd
         +N3AjXJ0VjkNjRVIW4r2FCACSWqHouSxdf6h43B8oh0KkzpWgbwxDgYo68/iGHEHsIfz
         X58cSUCEYUV8nGufqf+DaSlrQGu8scZCDgbw4k8jfQbHvjA4FUkObex0nPtBU/HtJek3
         YBFS2a3dxwYzqeHQnGeY01UqwLGN2/e0QjEcNk1/OwzfztAN3PkeJFk6rhCpg/0KVwaY
         NRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755813929; x=1756418729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEoIGgjzTubRPR28lvO2YuhgPwi8mIAHDjAhzXLrRpI=;
        b=ZzDhVZUyXt30HRUUav5zsU0TI0+IgAx7xfT2kUFkCFtyUFYPcJcoNEv7nvAApW4DYM
         y1C4RnqMF/VT+AZ3X+mPlR7VYeK1GAl9PRRPjpvy/Y42hVvf3Uk/ABcdCT37NnF3UQM8
         3LOuR9VEKwlhv4qbz2I7h+1ss3RYuDRf8Nnm4rTmZMTAG4dZP38lCmpMDPs8goE4NT6T
         8EB9GxtLRAPH17xPMrxsVxdHeFFhqNCRJ7u861u/W/LVOhvA6K2LTHT0wyVU3JgnNnPQ
         Aqq914WcD8974BsrWxySBZnCjdx81q9DlktzAkUP04gY8Wo75L1R2QnxHA5OepWnW+HO
         MQYw==
X-Forwarded-Encrypted: i=1; AJvYcCU67jb1pqOs/F6vsqXQV3S82164rm96I+Z5XVIcQcsMl90LQe2hB34uXGPCjqCu/AFZNC9HaHwIyilcSuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/H7XeRmkY+4OWJj/zmclhT90bQ3xLerBpO29UO+cyd86gCssO
	elkEcgwnnVm0m86/4zZFeJK6HpmTqYrwMfn/k/boDv0XMliRkiSeSjFeJ3euv0SYr3u2DFGCt1+
	uJFJGYVpZyBJ4Srwr2+nq3VdEvnb/b141Ukka1EY=
X-Gm-Gg: ASbGnct2dnX5i4qLqRDsMCCVWJr0CF+hiUz2JX19kMl/dBXwT7DzJENF0OMdjo6fiQS
	q0NxxgT8gRaWIEOBtkKIomIt2nkJKm8IzhC8km6tn47yvsMudFhsW1odwCnt6p5VtmRIheTlBXC
	+CmAY6L1pBFi3T/1/j7kMh3l1K1FH0cPkvGXeaUDt9v7Q4wdnzt7x48gjFi/FglFK/ImzFHhJlk
	3MG8dAF/UXKEXkgXiIJl9d1ZDg02wPrQdjc2vzwWBY=
X-Google-Smtp-Source: AGHT+IEAgnsRZZTBeBDPDig80smarcOxEH06giqqNuoKXrA13XjQ7OiwRrBiWUUoigKNiHoqJl/qovcWZd5Rdn8lJJs=
X-Received: by 2002:a2e:b524:0:b0:335:4125:1e2c with SMTP id
 38308e7fff4ca-33650fde1ccmr1426251fa.38.1755813929028; Thu, 21 Aug 2025
 15:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCr3E3nUjwYqFq1aC9P-EkX6iPs-X857wwN+a_QK9q7u4g@mail.gmail.com>
 <20250821210208.1724231-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250821210208.1724231-1-sumanth.gavini@yahoo.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Aug 2025 15:05:16 -0700
X-Gm-Features: Ac12FXzzr54zcQyksnxtUQGLgWxtveKK_3R-oS6cSdkpVMWWdDoG4arzM3gPIiI
Message-ID: <CANDhNCoao7P8RWbugxY70K-+HRPSy=NypgNXM3DjheHRmznmjw@mail.gmail.com>
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: boqun.feng@gmail.com, clingutla@codeaurora.org, elavila@google.com, 
	gregkh@linuxfoundation.org, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@kernel.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, sashal@kernel.org, 
	stable@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:02=E2=80=AFPM Sumanth Gavini <sumanth.gavini@yaho=
o.com> wrote:
> >>
> >> Just following up on my patch submitted with subject "Subject: [PATCH =
6.1] softirq: Add trace points for tasklet entry/exit".
> >>
> >> Original message: https://lore.kernel.org/all/20250812161755.609600-1-=
sumanth.gavini@yahoo.com/
> >>
> >> Would you have any feedback on this change? I'd be happy to address an=
y comments or concerns.
> >>
> >> This patch fixes this three bugs
> >> 1. https://syzkaller.appspot.com/bug?extid=3D5284a86a0b0a31ab266a
> >> 2. https://syzkaller.appspot.com/bug?extid=3D296695c8ae3c7da3d511
> >> 3. https://syzkaller.appspot.com/bug?extid=3D97f2ac670e5e7a3b48e4
>
> > How does a patch adding a tracepoint fix the bugs highlighted here?
> > It seems maybe it would help in debugging those issues, but I'm not
> > sure I see how it would fix them.
>
> This patch is related to linux 6.1/backports, the backports(https://syzka=
ller.appspot.com/linux-6.1/backports)
> I see this patch would fix these bugs. Let me know if my understand is wr=
ong.

But that doesn't explain why or how it fixes the bugs.  I'm not
opposed to stable taking this, but the reasoning should be clear, if
that is the motivation for including this change.
I fret there is something incidental in this patch that avoids the
problem, and that those issues may need a deeper fix rather then to
hide them with this change.

thanks
-john

