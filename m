Return-Path: <linux-kernel+bounces-881269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA47EC27DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F41E1899707
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB12F744C;
	Sat,  1 Nov 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pH61A7GJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6M3EqIrz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44E2E22BA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000092; cv=none; b=mTa1jXu9xZNeSs3yf4ikVxc+Qu+mIYzfbaO8fUITBbZiXBNBilG1yroTdde9osBFCbzc2O8W/3hRtVRKiYbb0vyEupfnFsucJAn6RHDpuL8k4C2rYp5UWWi1ROhDydcq2prLcs72MaYqt3l/O2jXKaRg1tuJaVb1nPc+Ua2tV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000092; c=relaxed/simple;
	bh=AsLCR26nuDCWrm2z9znmUO6q9rgVG17Qhgef8si6JF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IBL9Ce3vR5mnYybh1uzNVHo+DcmMzj2n4jFnyC5aA8XHGmE33xKvVQATVSaeM7KkxAMqPoHKNcc64LP12as29QAJXmP5IaLgaYPpFaecQ0/Dnnxvdz40fUvt2gztuNlObxAyJZpQ94JClffMhUtv3+ztgJx1cVcx0KDa0Yj58pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pH61A7GJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6M3EqIrz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762000081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B1Fk5WUhSsxnVmoJV+tlqHOS/oQh6/FPjuphxJ/BWVY=;
	b=pH61A7GJfhIF9LGisEIXOCB6RCMpqyih9l6ml2b0amPPV1CGuO0t5Jrvme26CYujOWCe39
	AYpk7vtdxrK2lHVJcSzPwyR2Xo0U50UoFyWtmHqAdqlpurTNil7Edlo3UQDCh/+JAmFeYz
	hnxixzG9kXoCINpZoI7zoS3gNGt9Zld+T9fuTxl3DQvmUp9bKStDwbKWfrQ1rtzuN2OZRJ
	P0GHSuG6zzxY79QZ+ekT9Kg3K/7frEdaG8dUFZ+UdVYtTciwvE42NbmJ9o1LAJcqhsuV4M
	esCGEFEnkLaqgQUeQouO74tI7nfI5TJP1U0NfMLl+WhSuWwjrsHK4X5h9V8NUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762000081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B1Fk5WUhSsxnVmoJV+tlqHOS/oQh6/FPjuphxJ/BWVY=;
	b=6M3EqIrz71jk/pQbXnsyZCgKxntW1r0VF5XJqhpOEQorOlndCJdFU09iSrMD4qkPxC0y7q
	At1eRP/jNdMoExCQ==
To: Shrikanth Hegde <sshegde@linux.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [patch V3 00/20] sched: Rewrite MM CID management
In-Reply-To: <3f7ec825-7e85-499f-bc44-1fcda0a862ae@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <47e73026-390e-40d6-a860-10e9378a3bf3@linux.ibm.com>
 <ae8de225-3c07-43ac-80d1-ecb6ac45d5d9@linux.ibm.com> <87ecqisw2h.ffs@tglx>
 <3f7ec825-7e85-499f-bc44-1fcda0a862ae@linux.ibm.com>
Date: Sat, 01 Nov 2025 13:27:59 +0100
Message-ID: <87h5vex7hs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 01 2025 at 13:26, Shrikanth Hegde wrote:
> On 11/1/25 1:06 AM, Thomas Gleixner wrote:
>> On Thu, Oct 30 2025 at 12:10, Shrikanth Hegde wrote:
>>>> I am running into crash at boot on power10 pseries.
>>>> Thought of putting it here first. Me trying to figure out why.
>>>>
>>>> I am using your tree.
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
>> 
>> Can you update and revalidate? There are a couple of fixes there though
>> I don't know how they would be related.
>
> Tried with latest. It boots fine with NR_CPUS=8192.

Thanks a lot!

