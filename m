Return-Path: <linux-kernel+bounces-810960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53272B5225B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAB058358B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5A42EFD92;
	Wed, 10 Sep 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4u2QK7Y4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VHkPU86z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A72D321D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536458; cv=none; b=nkkVd4fjoBQzvh4NGIcQI/cIOQnwW8jaa/UXqE29T2fodDAn23cCT4KLESFrYSUtppGP+4pCn3JMzspTMwIHYcQlISSBdsAZYJ9sz+Qw05C7nPA3WxD4f3xLfQp05WkWSO6FhWOE5JoZ8YhZAeb5M5vqpnESkvutZaohNvCPK8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536458; c=relaxed/simple;
	bh=CkHtW8q/KcW7ygj8WdIW9r/usNUU9k5XqXuzrDabs/A=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KPiAIYnfipPadIuYK2JUXZ5xJ9Cs4d73zvDMX/KDgfFeeUIZuoovHgs+UgQ7UseuZTwCvyr7EnWkJv7GfNBN1K/zAGtUz1EmvYbP/K2IAieJ/9JfKv+p3mag1+eL2J0IYujDJOVXFucxgCyOFPl/JhUv4jTPpSvD2J5ktGsUfCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4u2QK7Y4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VHkPU86z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757536454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BWJUP15r3n8/MjXCZffpwVy4cTnE3JTu8kOjPPspzQs=;
	b=4u2QK7Y4xS6JHeik30JB/GnrUN8xYNIDP6DiFVjfq/omGy9itJpsopIUwNK/9/fjvhNpbO
	Mk171iZmCEMsphtYhyEw63SgMWji0SlRDb27yjJbDm6MbASSmvPf2TUheNOsMgrDZCiE6y
	YCnyRLQkwhm1gZlsPNMck7099jZNMyubEnKMbmk3lwSyZlwAxeUwEQzZmgCgTCr5c2AYHK
	Y/E15WlQmg9OvW6Xk1t+fp7xyCQtWVeyVBB7wNIAtXn+dRw4DIbmwDJTCInnEJbmC7nXdc
	w9gthwATNmpQy7qEg+CofNOfBpy35q/DzQxgTrtv7/gdHZpi5sGtrLmRHzJdvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757536454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BWJUP15r3n8/MjXCZffpwVy4cTnE3JTu8kOjPPspzQs=;
	b=VHkPU86zocAfXvfPyLQ30cXywQDKQ5ukn+GdpWbASXj3o4C7v4KOvtagO6a9S/nqHO62Q3
	+spOKOIoGDiDl1Bw==
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 oleg@redhat.com, kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 mchauras@linux.ibm.com, deller@gmx.de, ldv@strace.io, macro@orcam.me.uk,
 charlie@rivosinc.com, akpm@linux-foundation.org, bigeasy@linutronix.de,
 ankur.a.arora@oracle.com, sshegde@linux.ibm.com, naveen@kernel.org,
 thomas.weissschuh@linutronix.de, Jason@zx2c4.com, peterz@infradead.org,
 namcao@linutronix.de, kan.liang@linux.intel.com, mingo@kernel.org,
 oliver.upton@linux.dev, mark.barnett@arm.com, atrajeev@linux.vnet.ibm.com,
 rppt@kernel.org, coltonlewis@google.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 0/8] Generic IRQ entry/exit support for powerpc
In-Reply-To: <20250908210235.137300-2-mchauras@linux.ibm.com>
References: <20250908210235.137300-2-mchauras@linux.ibm.com>
Date: Wed, 10 Sep 2025 22:34:13 +0200
Message-ID: <87ikhqrqre.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 02:32, Mukesh Kumar Chaurasiya wrote:
> Adding support for the generic irq entry/exit handling for PowerPC. The
> goal is to bring PowerPC in line with other architectures that already
> use the common irq entry infrastructure, reducing duplicated code and
> making it easier to share future changes in entry/exit paths.
>
> This is slightly tested on ppc64le.
>
> The performance benchmarks from perf bench basic syscall are below:
>
> | Metric     | W/O Generic Framework | With Generic Framework | Improvement |
> | ---------- | --------------------- | ---------------------- | ----------- |
> | Total time | 0.885 [sec]           | 0.880 [sec]            | ~0.56%      |
> | usecs/op   | 0.088518              | 0.088005               | ~0.58%      |
> | ops/sec    | 1,12,97,086           | 1,13,62,977            | ~0.58%      |
>
> Thats close to 0.6% improvement with this.

Cool!

>  18 files changed, 698 insertions(+), 810 deletions(-)

Thanks for moving ppc over to this. Makes everyones life easier!

       tglx

