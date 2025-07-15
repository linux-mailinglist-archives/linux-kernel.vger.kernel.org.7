Return-Path: <linux-kernel+bounces-732081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC34B061B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AB43AEBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE418DF80;
	Tue, 15 Jul 2025 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="h7fIP6vK"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAA92AE8E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590415; cv=none; b=iJ2+WWEDxv7YkEbql918OlcGjhC2MBaWUSnT9e0zbgREJx/4iL3F0K4uvqNuoC1O6HX/xGqc08yZa1wg8qlsvbtXFNffL7LtKwdpcJ2SXMLti8NM6JpmqGQtaY8riyEU7yjxLWkmVYLtEL71ZE+cuzKN3AMPrNR59yNObO+oFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590415; c=relaxed/simple;
	bh=eY7wENVCZTnXqlEvdwthn37jW0IXf3jGttIHfBBhbxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mi3cZCL5CszPrUJxXh3GDsZO5z84Ggw50eV592Nk8OGsUd1aEHbloSi/pUcIvGQ50N/WvVLKyu3EZrtGu3BD0cUKCty9RkAWuVG1E1zKriCfSqqNT5FlehxKMEZNtlz7tiyj0Y0KlPVgAJ3TuxRuYo7erkizBUaAmXvgxABj3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=h7fIP6vK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752590368; x=1753195168;
	i=markus.stockhausen@gmx.de;
	bh=4vuP3xw/XneKvg7cDFvvTU2hdDvPBe5/w0sBNbSgp/U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h7fIP6vKfbMi1xkqgPC51U4IowBKinQ+NDimICH3YWLwneNj7OO/e8qXME275Bwx
	 3QDurAUENr9HAhCnbxEAR+f1iQem8rpvKSMPBjZknVbr4wFWzsbt0DAEj7z6i0nxn
	 haE2WOHA0z5UrcqMVl9Jg2RJ1DXz/FrNePpf2qNpNDw8yrzmUnsI4wNJh1vHrbl/w
	 /kTZY08mPgAVJttI2NSnmnOlER9TY4wkO2qzCJU+Vl+wA/I24Q/D4uNgoE+tols13
	 n9WCovr83ebaqvOYqQjk6aipON8NVfCqsWBeE9fweWFy+1PJGbxGs2jbch2BLXJ+M
	 6diunkBKl4RNt6KKcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1uaast3b6K-005ymS; Tue, 15
 Jul 2025 16:39:27 +0200
From: <markus.stockhausen@gmx.de>
To: <peterz@infradead.org>
Cc: "'Chris Packham'" <Chris.Packham@alliedtelesis.co.nz>,
	<bjorn@mork.no>,
	<mingo@redhat.com>,
	<juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>,
	<anna-maria@linutronix.de>,
	<frederic@kernel.org>,
	<tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>
Subject: task_non_contending() for fair_server leads to timer retries
Date: Tue, 15 Jul 2025 16:39:25 +0200
Message-ID: <085d01dbf596$44286880$cc793980$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adv1gAwhy4Ku/H1TS465FwEabttagw==
Content-Language: de
X-Provags-ID: V03:K1:h+k1Y1vdU2EiNAqEE40pLKuumFh4Y/GHSp1ueGF6x4clpXcEpCw
 AzktyXuAlKzMKeo7LW3jOKbdRZ0oBey9GQwJARAt8qKBOoj2A8ZqYHUi6IztwJQfqR7mR0J
 aKnObuDQjKv4w6A8neaHv21VpVuyRIn2kvL5cdyoc6sKSsww0iAfXqiXAN8J/fceLu9N3Aq
 C8X4SDad9DhAyxYT0At2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sBS9h1KOUyc=;SDXpmPFZKH4zCEtilSEyB+avGaJ
 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
 Ug==

Hi Peter,

I'm currently investigating issues with the timer-rtl-otto driver in=20
6.12 longterm on the Realtek MIPS switch platform (Chris is working
hard to upstream this). While doing so I observed that timer retries=20
continually increase (~6/second) according to /proc/timer_list. The=20
system is otherwise totally idle. 6.6 longterm does not show that issue.
I'm unsure if this is related but documentation reads like "that's bad".=
=20

To be sure about this one I nailed it down to the fair server.

Whenever task_non_contending() handles the fair_server, zerolag_time is
calculated as 0 and a hrtimer_start(timer, 0, ...) call is issued. Going
down the stack clockevents_program_event() thinks the target time has=20
been exceeded. So it instructs clockevents_program_min_delta() to set
a minimum delta time (2560ns for the otto timer). From there the retry
counter is increased. See attached output.

To silence the noise and focus on the real bug I use this workaround
in task_non_contending():=20

if ((dl_se =3D=3D &rq->fair_server) && (zerolag_time =3D=3D 0))
	zerolag_time =3D 6000;

Totally crap but serves the purpose. Maybe you can share insights about
this (un)desired behaviour.=20

Thanks in advance.

Markus

# uptime
 00:41:19 up 41 min,  load average: 0.00, 0.00, 0.00

# cat /proc/timer_list
...
Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: timer@3100
 max_delta_ns:   85899344321
 min_delta_ns:   2560
 mult:           13421773
 shift:          32
 mode:           3
 next_event:     2469910000000 nsecs
 set_next_event: rttm_next_event
 shutdown:       rttm_state_shutdown
 periodic:       rttm_state_periodic
 oneshot:        rttm_state_oneshot
 event_handler:  hrtimer_interrupt

 retries:        14646


