Return-Path: <linux-kernel+bounces-762625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F43B20915
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C52E3BE1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73EB2D3A97;
	Mon, 11 Aug 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bgVNxfD1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c85EGQZz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9A220F4F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916263; cv=none; b=gf93PR6PPbcfXJzD5KJU4GrdS0F7pp5/eMB/ehZiDQBEXbhTAW0h3NdfHFvgIcERenA6Y/vuDfqvax8RR1kF5lUPodIqszLX16aIH6THdHIxDm/nwkPIM1IpmtcB2Uw7Co3XMd1kwFDENLnwgPp85P9fy5rFa2KiKAhQBB+wZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916263; c=relaxed/simple;
	bh=4bPXvTybTYw3uWFJqMw7jey3ul2mSMuUchxQYHAQ1e4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XV/HSTgoW71CL05nKtbSY+B4RlW895kVvjAj5dCFj3t6oKG0HYMUDBJ1wcELkajejO6l27gXBtY6QLOvAnUlWzHXcsbWYCwjQv2pa+IcFNwQ4x5gVTHCcDq4JnBREXd3nbYgoH3fR52UqoLB2IyQAUwf6DIt/JYOLnnOJ7/SGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bgVNxfD1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c85EGQZz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754916260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJqFgM29ffLz4B4qWNr3rGFSEuLN/8lsgvcpqVZRiGg=;
	b=bgVNxfD1VyaFgzgIQv3JXt1FNrvd3hwqTK05Ct+IbbIYY2YL+R0yrCxCMYK89kPUFP6M5f
	pte3v9pwuHTIWqtiKEs3K8wj05lFoO5V/2yUfY1V54KovAuuDgk9c2QCl/yKCwJaYJskwQ
	EsOixpZJCjfRLspSewiUI0aoSp+VdzQhvun5S4v6Mh5JTxGvddLzN3bHOjeor1L4RZPGDH
	j/CfHzp57zgmdlR9aH6XkTt/CtOiCwE6Yo73jzMUzeTtKNRf+rTLadgf1E6yETLCqh0SK2
	dlu2mvMquuypKbtgeeyE4Z5+7ywXY8AU7dYqHbxccJJS5rqbqFAnbOEXF+PaLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754916260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJqFgM29ffLz4B4qWNr3rGFSEuLN/8lsgvcpqVZRiGg=;
	b=c85EGQZzGNWQE6Vg+A9UMu7KBYuhDuOweWST4hHVex3LzjDWjhgxGsC8NnQDhLxLJVzQKS
	ICK8LwbDGf7sk5Ag==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf/core: Split out AUX buffer allocation
In-Reply-To: <20250811100403.GE1613200@noisy.programming.kicks-ass.net>
References: <20250811065859.660930338@linutronix.de>
 <20250811070620.590421133@linutronix.de>
 <20250811100403.GE1613200@noisy.programming.kicks-ass.net>
Date: Mon, 11 Aug 2025 14:44:19 +0200
Message-ID: <87jz3a81uk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025 at 12:04, Peter Zijlstra wrote:
> On Mon, Aug 11, 2025 at 09:06:41AM +0200, Thomas Gleixner wrote:
>> +	/* If mapped, attach to it */
>> +	if (rb_has_aux(rb)) {
>> +		atomic_inc(&rb->aux_mmap_count);
>> +		return 0;
>
> so this was: ret = 0; goto unlock;, which then would've also taken the
> !ret branch and done perf_mmap_account(), no?

Indeed.

> These two aux and rb split out patches seem like they're trying to take
> too big a step. Let me try and do the same with smaller steps.
>
> If only to try and find bugs.

:)

