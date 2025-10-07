Return-Path: <linux-kernel+bounces-844425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3523BC1E08
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E166D4F0045
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080CF2E1C7E;
	Tue,  7 Oct 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hv+CKpY5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ysVWsU9F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC88BEC;
	Tue,  7 Oct 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849950; cv=none; b=TXP9Rb86QGfI0KB7q7TeJ3regwDxhMtlR8bqZGEXoj1bvKzrAurSmDp7zHkW64cu8Y3mDn2NVlNBSQodoAt4iS33ptPZxLpODzpFvPYADeds3Us//vDPOSuQsY0BWJLeG+JLz4rdsi/1HEMahbNDKIVy4gAGb40AN173S/FX3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849950; c=relaxed/simple;
	bh=ae6nDSlCWz9xfvlwaCBcRWsJfqjOvPHYZR8tJZhxn5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mu9kJBqsR2MxlbuqGEuxHtCVYmb/Qk6UjNAK3E/FwLah1nJffIQwe3LA1YD6qDIeSY8+E7yOU19G99ej9g1fyNElrzsm6upx546kqK5Cw415lkaCSGvA3LMs7kkbzwI7pZ+z5D5wtI2PXPsDUhH+hdU3bWmJQtICc6YGthEvvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hv+CKpY5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ysVWsU9F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759849947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x2ClbCVr3BVXHDb1NN4Xjp7dDlGKmBkjH5HMzWAKdE8=;
	b=hv+CKpY5p7ityX7mnzhjP8ZQC/BXDUlOnGIc1nGSSJtRofxJxyFYUZX8ud5GnBrcn0CeED
	t1hJ3pPZx40EJWJMvcJDntcU+NSaeOTonGMIoLRIHVfPcx8GThiOZzCq27kXBrUH/MsmHZ
	tNtDOGAgXweGg4GgRGrxbrWLlNZbKcK7647cihhX1PTQuxEOj1XkRuIdvStw6b1pE56K1G
	v2F2ts7wvdtf9h/2/ZjRBUhuXWQxCqRzUhgWN5wdxdCZDDeeENuRoSbc4CWm/0UgfwiQW+
	tQfQiYhC7p9tnL2eVIRwGmlyZXq672gXvnGEgZA0/axyrdgKz0fiV1GE2eMf7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759849947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x2ClbCVr3BVXHDb1NN4Xjp7dDlGKmBkjH5HMzWAKdE8=;
	b=ysVWsU9Fq7OpG+yCvkOe0ZKsOjAutOnfDugsWG3S2r8y+ynMRdUOrXAOIXBjD+E+ZKtcyt
	Fsvxb5Zxhh6OwNCQ==
To: Sehee Jeong <sehee1.jeong@samsung.com>, anna-maria@linutronix.de,
 frederic@kernel.org, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 sehee1.jeong@samsung.com
Subject: Re: [PATCH v2 0/1] timers/migration: add 'tmigr' kernel parameter
 to optionally disable timer migration
In-Reply-To: <20250910074251.8148-1-sehee1.jeong@samsung.com>
References: <CGME20250910074257epcas2p2557473cfc52840b904ed22bdf1a3f27f@epcas2p2.samsung.com>
 <20250910074251.8148-1-sehee1.jeong@samsung.com>
Date: Tue, 07 Oct 2025 17:12:25 +0200
Message-ID: <87jz163fvq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025 at 16:42, Sehee Jeong wrote:
> This patch introduces a kernel boot parameter to optionally disable the
> timer migration.
>
> On heterogeneous systems with big.LITTLE architectures, timer migration
> may cause timers from little cores to run on big cores, or vice versa,
> because core type differences are not considered in the current timer
> migration logic.
>
> In our heterogeneous system, we observed timers being migrated to big
> CPU frequently, resulting in timer callbacks that could have run on
> little CPUs being executed on the big CPU instead. This reduced big
> CPU's idle residency and increased overall power consumption due to
> higher power draw on the big CPU. Since timer_migration is a relatively
> new feature, addressing the structural limitation was difficult.

It's not that new, but anyway I'm not understanding what's so difficult
to address that problem in the migration code. As all of that code is
based on a hierarchy, so it requires to ensure that:

   All big CPUs are on one side of the hierarchy and all little CPUs
   on the other side and those sides are not connected.

Taking the example from the comment on top of the code:

 * LVL 2                           [GRP2:0]
 *                              GRP1:0 = GRP1:M
 *
 * LVL 1            [GRP1:0]                      [GRP1:1]
 *               GRP0:0 - GRP0:2               GRP0:3 - GRP0:5
 *
 * LVL 0  [GRP0:0]  [GRP0:1]  [GRP0:2]  [GRP0:3]  [GRP0:4]  [GRP0:5]
 * CPUS     0-7       8-15      16-23     24-31     32-39     40-47

Assume that GRP1:0 is the big cluster and GRP1:1 is the little
cluster. Then obviously LVL2 is not required for this scenario. So the
resulting hierarchy looks like this:

 * LVL 1            [GRP1:0]                      [GRP1:1]
 *               GRP0:0 - GRP0:2               GRP0:3 - GRP0:5
 *
 * LVL 0  [GRP0:0]  [GRP0:1]  [GRP0:2]  [GRP0:3]  [GRP0:4]  [GRP0:5]
 * CPUS     0-7       8-15      16-23     24-31     32-39     40-47

It works nicely even when the clusters are asymetric, i.e. one requires
more levels than the other:

 * LVL 1            [GRP1:0]                      [GRP1:1]
 *               GRP0:0		               GRP0:1 - GRP0:3
 *
 * LVL 0  [GRP0:0]                        [GRP0:1]  [GRP0:2]  [GRP0:3]
 * CPUS     0-7                             8-15      16-23     24-31 

GRP1:0 is just there to keep the code simple, but as the hierarchy ends
there it is not any different than having only CPU 8-15 online in
GRP1:1.

That means the required changes boil down to:

  1) Calculate the hierarchy levels based on big/little clusters and not
     connect those clusters on top in tmigr_init(), which means the
     hierarchy levels are one less than on a connected system.

  2) Ensure that the CPUs end up on the correct side of the hierarchy in
     tmigr_setup_groups()

  3) Prevent tmigr_cpu_offline() from assigning a cross cluster migrator.

Everything else works out of the box.

I obviously might be missing the real difficulty you observed when you
tried to address this structural "limitation". You surely can explain
that to me then, right?

> Therefore, this patch adds a boot parameter to optionally disable timer
> migration.

You still did not address my comment, that this also means that all
timers must expire on the CPU they are armed on. Which in turn causes
less idle recidency in the overall system, no?

Thanks

        tglx

