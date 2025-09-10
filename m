Return-Path: <linux-kernel+bounces-810820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4782CB52021
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5253A1C8558D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242822259A;
	Wed, 10 Sep 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Pb6HabLH"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5423C0C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528189; cv=none; b=hIKpB+Dzfp/xEA2ipFLuL3rFR6dCtGsIouu0Nd6IQdh6+fVKKto0K+Kdgo6jo6vGufZlfoMdSzRnDc6I3XSafAxHFe5K/rgxKs2wbppqZRAIS17zXszI+QTVNE4l1wNRHN/krC2XOnXu2NCCmf+xAFI7USPNX0I01P0EW9EHYKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528189; c=relaxed/simple;
	bh=BHh+Io2KXMAoSkJCft1a9UKYZOThDteJQ+euqTqLLSg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NgewT9xX29ykl3jsw5Bq9xmGBLUxEQwP9lPp6bD9dKFwlLixMeOEIzkLsagaeVGpnlJ/FbNzgAmUhtBgwJYXl5eQSiwNYV7J4rLrcOPyKu3kXt5+1eC6Y2lq/srRQtkz7r1nlLAc9U+Vo/061y0sQR/1OwSNNmh9oe5smtAiPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Pb6HabLH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757528183; x=1758132983;
	i=markus.stockhausen@gmx.de;
	bh=+uNEjIdyxhIx+huTT+4+dSGdjLWyEpG5PxKxhVHbrc0=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pb6HabLHNZ29U6aNzorCudS36KScQFT+bR7qqblvBDpTLT7rH2x7OqmkSysDIADy
	 Q2wps8gJh7RmUM1/oZLxjZ6oQTPklTM1W1gpuATwEQknCWxFsSR6kZsKyHiyC55hg
	 t55i901gG1M57bQFqj/6vaTz2f4VPMNZyhk1HNCNM1kQnyTYaVwTZDVhDusXJKkKw
	 sGk5dlw3BNdKsrBHoAAea9VO8N7oaeB4emJuNgHTb0N4qte4UaTqB2o+heGR6ZFjl
	 +pfeykcBFtt9L5t12RSYfDNdzTlGDua+pGvht0q5Gi2Or45u11vChgXp6AkRPFdVx
	 o2JvXNg6QWylf4q38w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbW0-1vDWW11A4c-007Xd1; Wed, 10
 Sep 2025 20:16:23 +0200
From: <markus.stockhausen@gmx.de>
To: "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	<tglx@linutronix.de>
Cc: <howels@allthatwemight.be>,
	<bjorn@mork.no>,
	<linux-kernel@vger.kernel.org>
References: <20250804080328.2609287-1-markus.stockhausen@gmx.de> <20250804080328.2609287-2-markus.stockhausen@gmx.de> <af4a09e2-5b3e-4223-a926-4ab33b327416@linaro.org> <007901dc223b$feb371a0$fc1a54e0$@gmx.de> <38633f6f-c14c-4a74-b372-cdfdab80619e@linaro.org>
In-Reply-To: <38633f6f-c14c-4a74-b372-cdfdab80619e@linaro.org>
Subject: AW: AW: [PATCH 1/4] clocksource/drivers/timer-rtl-otto: work around dying timers
Date: Wed, 10 Sep 2025 20:16:22 +0200
Message-ID: <020f01dc227f$03e40b60$0bac2220$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQHp8yyrgZ2WnUFiBUflLXXXxyaZiwJVKvFZAo3A5noDIAuHogJC3pKOtB7Z4TA=
X-Provags-ID: V03:K1:0rNgG6RkqG8kFrgbsHHCBJXDdNrcY+m+8PLXaFa1/SMK2NHfk48
 fqAB3XT5+/GtDxp2SsiiqjeQoT26czHr7MvpXwAUcGaB6ATmQRvJ6vdaFW/44xbASBYaLa9
 ADML4TeHmKyZ7Pn+oF/gkhlRv5M72kDfFdabY+W8hidRA5OAJD3siWRXUh0VIcfOhgFnfZN
 mwT++IKwBLhyoV+ZjXg+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IHqK1k+7bTA=;XHeu6+IrmMJTcU38m9nt9qigXbg
 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

> Von: Daniel Lezcano <daniel.lezcano@linaro.org>=20
> Gesendet: Mittwoch, 10. September 2025 18:39
>
> > What I tried:
> >=20
> > 1. Read out the current (remaining) timer value: In the error cases
> > this can give any value between 1 (=3D320ns) and 15 (=3D4800ns).
> >=20
> > 2. Check if IRQ flag is already set and IRQ might trigger next. This w=
as
> > never the case.
>
> It would have been interesting to check if we are in the time bug range=
=20
> to wait with a delay (5us), check the IRQ flag as the current timer=20
> should have expired, then set the counter and recheck the IRQ flag.

It's been 2 months that I dived deep into this case. Finding a=20
reproducer, adding lightweight logging and try&error a solution=20
was really hard. In the end I was happy to have a fix that was=20
intensively tested.

For some notes see
https://github.com/openwrt/openwrt/pull/19468#issuecomment-3095570297

=46rom what I remember:

- I started on a multithreading SoC and went over to a single
core SoC to reduce side effects during analysis.=20

- The timer never died when it was reprogrammed from
an interrupt of a just finished timer. The reason was always
a reprogramming from outside the interrupt->reprogram
call sequence.

- Reprogramming always worked fine. A timer with <5us left, was=20
restarted with a timer >5us. The new timer started to count.
No interrupt flag seemed to be magically toggled during this=20
process. There was no active IRQ notification directly after the
reprogramming. That was how I expected it.

- But in rare cases the new timer did not trigger the subsequent
interrupt. I was totally confused that the future interrupt of=20
a newly started timer did not work.

Graphically:

- timer run ---+-------------------->|
               | issue stop & start=20
               | timer run ------------------>|
                                              | no IRQ here

Conclusion was for me: If we "kill" a running timer and restart=20
it and it will not fire an interrupt after the newly set time,=20
then something must be somehow broken. The ending timer and=20
the stop/start sequence (that consists of two register writes)=20
have some interference. Whatever it might be.

Markus


