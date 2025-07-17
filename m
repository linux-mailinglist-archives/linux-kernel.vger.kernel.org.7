Return-Path: <linux-kernel+bounces-735520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55837B09073
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3942E4A2A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62D2F6FA3;
	Thu, 17 Jul 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="TfKu8wJF"
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169151E379B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765615; cv=none; b=nLBaDOsIGzifBhdv6HQ6zlaDgMIEjQp776LFxyyitcc6rKU4qVq9xThrtEUJO3iZ2XMGrwqz78w6gOwsOOiZvch3OeP1x/heaA6zoDoH8UPh9RC2Fr+kk0PFn6I4yy4e/ZMlahPC9ueZ8ag1TWCk1B7xmLrWTFRUhuBWT9fyxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765615; c=relaxed/simple;
	bh=VA2VrYGpzR6/Gr87H1VpRzA+G+Ez+KWr8dRVaugIclU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=o+dp9FR/jwvZAuxtYuMXn+dvRtPp8kQen9hbpIZCxUf9EaeQ4hNRhQyRVwLS9snjqq9AuinmgcnBvpI6qexgQJqTbvF1UZhv9In0WUzLD/KFifXtIiDQMCAL5ObbrqMUGzs42ye0FmhpHzSlyP8T2xRQ/VjoGuBE88sLxl2v4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=TfKu8wJF; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=TfKu8wJF;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 56HF5aas2112221
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:05:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1752764736; bh=ehZpqP5YHCP+VHpc5tZWhn+s8qy7IFUMlhw82i0/OxY=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=TfKu8wJFSu3LAGCQo4Qp76fsjx+d2HWKct4PZRy/E/yD/x1Zp07ZEfylXDmsw3IN/
	 mRdxTIkEbpfI0ckUnemyflo7j4j1QHd7/aIdBVrHJ0g5M3zNxbebQtYnbQg+8xa63O
	 3gzLIEqrQCJLRrmh9ZJAJVvlfPRbrbVTEm84Zm6g=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 56HF5aLa3859790
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 17:05:36 +0200
Received: (nullmailer pid 2792224 invoked by uid 1000);
	Thu, 17 Jul 2025 15:05:35 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: markus.stockhausen@gmx.de, peterz@infradead.org,
        'Chris Packham' <Chris.Packham@alliedtelesis.co.nz>, mingo@redhat.com,
        vincent.guittot@linaro.org, anna-maria@linutronix.de,
        frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: task_non_contending() for fair_server leads to timer retries
Organization: m
References: <085d01dbf596$44286880$cc793980$@gmx.de>
	<aHi8yk8wlVJBFzSR@jlelli-thinkpadt14gen4.remote.csb>
Date: Thu, 17 Jul 2025 17:05:35 +0200
In-Reply-To: <aHi8yk8wlVJBFzSR@jlelli-thinkpadt14gen4.remote.csb> (Juri
	Lelli's message of "Thu, 17 Jul 2025 11:05:14 +0200")
Message-ID: <87ldomkgcg.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.7 at canardo.mork.no
X-Virus-Status: Clean

Juri Lelli <juri.lelli@redhat.com> writes:
> On 15/07/25 16:39, markus.stockhausen@gmx.de wrote:
>> Hi Peter,
>>=20
>> I'm currently investigating issues with the timer-rtl-otto driver in=20
>> 6.12 longterm on the Realtek MIPS switch platform (Chris is working
>> hard to upstream this). While doing so I observed that timer retries=20
>> continually increase (~6/second) according to /proc/timer_list. The=20
>> system is otherwise totally idle. 6.6 longterm does not show that issue.
>> I'm unsure if this is related but documentation reads like "that's bad".=
=20
>>=20
>> To be sure about this one I nailed it down to the fair server.
>
> Apologies for interjecting before Peter had a chance to reply, but I had
> a first look and I wonder if this recent patch from Peter (on
> tip/sched/core atm) can already help with the issue, as it should
> reduce the number of dl-server dequeues:
>
> cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
>
> Can you please check what you see with it?

Spot on.  Thanks
=20
I tested cccb45d7c4295 ("sched/deadline: Less agressive dl_server
handling") on top of the 6.12 longterm we're running and the retries
rate is back to "normal".


Bj=C3=B8rn

