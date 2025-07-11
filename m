Return-Path: <linux-kernel+bounces-727401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4994FB0199A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B681C47A06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E8C27FB14;
	Fri, 11 Jul 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="DVgLreXp"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CE279DC3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229287; cv=none; b=a3OP+jLjr797MaObnx3Ydv+FA6laRL5re4nd82U1NLaY4lza/QXn0yUJ/1b+bXkUAgT6FSylPSWnawtZPexWnZb1MhDX0BqOsn0As743N3j9A1t5ZJSPel3YP92c1qgEqPDk65yQBB8jhKhFjJfPwJo4bUsLeDIRGuKhhnnjMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229287; c=relaxed/simple;
	bh=iG36eEHiq74QunglITmI+fgFVpqSr0lVvn46UT1KGYI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lTAOGk2v034b5OZN9c7p3FIVbkj86NveXlCwYEvoE5VrnHGCqVocQAAyJS3r6BCNRTkq3jDQ8eIs0MGXaDdCw4LLBolukLFPSm+veveVyVtjU3Iocn2/esQ9WJV47vo1XdSPzoWmublz85gCWIrahXjL+qWyxbA5Gij0lPaYYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=DVgLreXp; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iG36eEHiq74QunglITmI+fgFVpqSr0lVvn46UT1KGYI=; b=DVgLreXpneHG1aw6/3WjHTsmFj
	NuLzHkdlJ9w3NiczGtQJUwCio4+JW+M4Y8z+0Vms6by26fCEXZ7UTN8X1bb3gAyhCXKgbpgvmliWB
	3VON4NDdyhOZvMESSKEIKJ/5dxg8pgB6fL6+QEhP9Qw4tWam1tCze+G9rM8MTZrgbRKVfaJBQ7D9P
	YXzCFlNEXF9g07hK/2ulwNOUgYppAyduQQDT65ewY3YUFASXUiOjv2owFY8CLUH3/P4jotukQmCyM
	qdwHx8CgCOU4aNHti3WEIOeGlExRnIXoU+GmBf2L/ESennlFICYPZYPGeJNXyTqaCHjqFh+PsIJmJ
	w++93nyg==;
Received: from [167.98.27.226] (helo=[10.17.2.70])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uaAct-00FWjH-7l; Fri, 11 Jul 2025 11:05:07 +0100
Message-ID: <0b51789f52323f92a7f42aa351563dc65537c089.camel@codethink.co.uk>
Subject: Re: [PATCH 0/5] sched/deadline: Fix GRUB accounting
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall	 <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>, Waiman
 Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>
Date: Fri, 11 Jul 2025 12:05:01 +0200
In-Reply-To: <20250627115118.438797-1-juri.lelli@redhat.com>
References: <20250627115118.438797-1-juri.lelli@redhat.com>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

Hi everybody

On Fri, 2025-06-27 at 13:51 +0200, Juri Lelli wrote:
> Hi All,

Any more progress on this?

As this is a bug it would be really nice to land a fix sooner than later : =
)

Thanks!

> This patch series addresses a significant regression observed in
> `SCHED_DEADLINE` performance, specifically when `SCHED_FLAG_RECLAIM`
> (Greedy Reclamation of Unused Bandwidth - GRUB) is enabled alongside
> overrunning jobs. This issue was reported by Marcel [1].
>=20
> Marcel's team extensive real-time scheduler (`SCHED_DEADLINE`) tests on
> mainline Linux kernels (amd64-based Intel NUCs and aarch64-based RADXA
> ROCK5Bs) typically show zero deadline misses for 5ms granularity tasks.
> However, with reclaim mode enabled and the same two overrunning jobs in
> the mix, they observed a dramatic increase in deadline misses: 43
> million on NUC and 600 thousand on ROCK55B. This highlights a critical
> accounting issue within `SCHED_DEADLINE` when reclaim is active.
>=20
> This series fixes the issue by doing the following.
>=20
> - 1/5: sched/deadline: Initialize dl_servers after SMP
> =C2=A0 Currently, `dl-servers` are initialized too early during boot, bef=
ore
> =C2=A0 all CPUs are online. This results in an incorrect calculation of
> =C2=A0 per-runqueue `DEADLINE` variables, such as `extra_bw`, which rely =
on a
> =C2=A0 stable CPU count. This patch moves the `dl-server` initialization =
to a
> =C2=A0 later stage, after SMP initialization, ensuring all CPUs are onlin=
e and
> =C2=A0 correct `extra_bw` values can be computed from the start.
>=20
> - 2/5: sched/deadline: Reset extra_bw to max_bw when clearing root domain=
s
> =C2=A0 The `dl_clear_root_domain()` function was found to not properly ac=
count
> =C2=A0 for the fact that per-runqueue `extra_bw` variables retained stale
> =C2=A0 values computed before root domain changes. This led to broken
> =C2=A0 accounting. This patch fixes the issue by resetting `extra_bw` to
> =C2=A0 `max_bw` before restoring `dl-server` contributions, ensuring a cl=
ean
> =C2=A0 state.
>=20
> - 3/5: sched/deadline: Fix accounting after global limits change
> =C2=A0 Changes to global `SCHED_DEADLINE` limits (handled by
> =C2=A0 `sched_rt_handler()` logic) were found to leave stale or incorrect
> =C2=A0 values in various accounting-related variables, including `extra_b=
w`.
> =C2=A0 This patch properly cleans up per-runqueue variables before implem=
enting
> =C2=A0 the global limit change and then rebuilds the scheduling domains. =
This
> =C2=A0 ensures that the accounting is correctly restored and maintained a=
fter
> =C2=A0 such global limit adjustments.
>=20
> - 4/5 and 5/5 are simple drgn scripts I put together to help debugging
> =C2=A0 this issue. I have the impression that they might be useful to hav=
e
> =C2=A0 around for the future.
>=20
> Please review and test.
>=20
> The set is also availabe at
>=20
> git@github.com:jlelli/linux.git upstream/fix-grub-tip
>=20
> 1 - https://lore.kernel.org/lkml/ce8469c4fb2f3e2ada74add22cce4bfe61fd5bab=
.camel@codethink.co.uk/
>=20
> Thanks,
> Juri
>=20
> Juri Lelli (5):
> =C2=A0 sched/deadline: Initialize dl_servers after SMP
> =C2=A0 sched/deadline: Reset extra_bw to max_bw when clearing root domain=
s
> =C2=A0 sched/deadline: Fix accounting after global limits change
> =C2=A0 tools/sched: Add root_domains_dump.py which dumps root domains inf=
o
> =C2=A0 tools/sched: Add dl_bw_dump.py for printing bandwidth accounting i=
nfo
>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 1 +
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A0kernel/sched/deadline.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 61 +++++++++++++++++++---------
> =C2=A0kernel/sched/rt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++
> =C2=A0kernel/sched/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tools/sched/dl_bw_dump.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 57 ++++++++++++++++++++++++++
> =C2=A0tools/sched/root_domains_dump.py | 68 +++++++++++++++++++++++++++++=
+++
> =C2=A07 files changed, 177 insertions(+), 19 deletions(-)
> =C2=A0create mode 100755 tools/sched/dl_bw_dump.py
> =C2=A0create mode 100755 tools/sched/root_domains_dump.py

Cheers

Marcel

