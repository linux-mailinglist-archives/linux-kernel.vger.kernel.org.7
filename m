Return-Path: <linux-kernel+bounces-877186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E2C1D63A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D303189A538
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E24318135;
	Wed, 29 Oct 2025 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wyvq73tH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t33dfvAo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C783090CE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772265; cv=none; b=N+4831k2/SS/zyIANkPZG9QQWt14KING7c5fs9Trb7sCz+EnYoVtCQyWjXYv3noXyo3XsZPl/VT23m8PvETFOpKAVfxogBInjmIVdXbNgQPTGrLbSm51hnanMkFPUQ5LFEKZkaMmUILvc9sQiHAWSyAO3iagBC3hawhjvC5p8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772265; c=relaxed/simple;
	bh=iJcSnDsFpy765tHPK5F0nZkpTYiOtmmQFaYBYpmqyxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cRsh6VhaxcpuLBz1Jp6HBrK5QX79mjED3qGzAhcDmURuXf4fHGvXYQ5mNPRzfnTlU+hgdPeIjRi4T63lYvF1hXfSAgQ4IDwuwyxvrdPPlUdJDZO89Av8P+bA4AI9aFBLaBlfgp+K8732OIOUyIGKaSJNueuItOI4wZU7DheUmZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wyvq73tH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t33dfvAo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761772262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hI0jZOz4lJhaD/6EGIsPdMTE5mL26BMHUv65jHq+Fc=;
	b=Wyvq73tHRhxZ0K0zefrMw34F85Df0ErkNlm5cY0sAEsHv9iLa7PD5laRjQCZAOvfOFZA/W
	ALZX5aELZWvesOp39Mr7FR4+H1bD1jkCQjvZMdTLJFQZKhhM8IdO9e6cEBi7p+l49ufvjQ
	JGM6UvJa1GQq9nMjjTF7g3mKaBwDRLl1MJta0IbULJqycn/WoVFCMPIt6382YJQ/2rB3/T
	UIL3b9YlJbi6DMYHr5Prw0xr3l+oa1VFk3wp59dG+XhtM9dMm8hLIvHYSapvOs56foacbS
	0R7G+lKhbWxrfmvRwnATUHn3WNV4OV4sHEYFH3ZfnURXgw+zExJ1KfcWNczNDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761772262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hI0jZOz4lJhaD/6EGIsPdMTE5mL26BMHUv65jHq+Fc=;
	b=t33dfvAoW0szJ3vb1qcPpvlG1PWLxzy7Q3c8yAuuq3hl8/hE3Cl9hZFKFo8j3NlgzRWq4l
	D+fLnB0yCeBQsvDA==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, Jens Axboe
 <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim
 Chen <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>
Subject: Re: [patch V3 04/20] sched: Fixup whitespace damage
In-Reply-To: <e693a1dd-5507-410b-8e91-ac06990ff72e@efficios.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.529672945@linutronix.de>
 <e693a1dd-5507-410b-8e91-ac06990ff72e@efficios.com>
Date: Wed, 29 Oct 2025 22:11:01 +0100
Message-ID: <87v7jxtnve.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 11:42, Mathieu Desnoyers wrote:
> On 2025-10-29 09:09, Thomas Gleixner wrote:
>> With whitespace checks enabled in the editor this makes eyes bleed.
>> 
> [...]
>> -	 *
>> -	 * switch_mm_cid() needs to be updated if the barriers provided
>> -	 * by context_switch() are modified.
>
> This is also removing a comment, but the patch subject and commit
> message clearly state that the intent is to fix whitespaces only.
>
> This change should probably be moved to a different patch.

It was in a different patch and ended up here when reshuffling the
queue. I'll move it to the patch which gets rid of this dependency,
which is actually patch 1/N.

Thanks,

        tglx



