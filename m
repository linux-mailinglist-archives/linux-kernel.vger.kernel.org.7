Return-Path: <linux-kernel+bounces-797015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE2EB40AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C7171E39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51D32A823;
	Tue,  2 Sep 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iWwPbX2b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDw9Uyff"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F742D6630
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830835; cv=none; b=aakfitXVCYmYKv8gVOPw2jVl45fVYIr8WRJjqofxZkdoVyOXODj/qHHDOTFrJbuX9ytKpw73YzDnrD7UhdBwCrREEQ36tDeekfe3qkBJImPP9DYDr3mk7uQDrhzFwB3y6LekNoXtiTO+aReyrN5jhfl1g8tLBDlHbpXFJksCbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830835; c=relaxed/simple;
	bh=7brBKC1VQjWWkmatNSCROp5VjqYpF2aX1agquRGVmWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmUZFrR3afkpHIImfuCVOQWf5OjQviOero40QzIRWED6nvYGN2qKuXaQoJKEOi+z6NVRubaGLF+vaGejOLeuJhII8RHPAekr8fpCR8vvi+3tOyXSYdpPxLhKJftBga+P+0pgs9Sy7NnFcGUfShc88XLXVtP3rzxXGYPgjhdtrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iWwPbX2b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aDw9Uyff; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756830831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5h6SNMI3jHuU7Q1cyLPg4x5uK6Hxqu2RkvOJX8OHYhc=;
	b=iWwPbX2b6+Wu8N0zOvCX0whJiPzGJkiE1F0PtkSsbxaF9043/a98F6MiVXePbD/qnC0HJo
	n0yMJM982azhilCQ8pVC1HWzk2l4jtXDUCfnp6nls1oFKNJX5ixcHToaKJYd2ftFJAT73a
	nZeZuZ22zS2MwBAEBwDph/8d1kBp6XC1ijjs8dQyTd1c9TWPMErnaIossxdq3zu/NaEpuu
	eFW+kdc2JFCpcP0pjyNMNL2Ag1I902MAXUl62EMBJYjzNvgm+dj4R/Dp6MMDLqRgMOvHg8
	oVvJQjudxQHFuq8VanZQCQUahpqtC+r1KLxOftEGqMY3IRea3U5sghn/s+kaoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756830831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5h6SNMI3jHuU7Q1cyLPg4x5uK6Hxqu2RkvOJX8OHYhc=;
	b=aDw9UyffSe3TFp6EFIs1IlTumLgzGA0TzYk/Q4uG7PUvrcI8xEuPIQuOMvyrT/GHhJFPUs
	4S+dKo6ZZqOZIkCA==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V2 23/37] rseq: Provide and use rseq_set_uids()
In-Reply-To: <878qix0wx4.ffs@tglx>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.741798449@linutronix.de>
 <e87fb53b-329b-44dc-a14e-e8c7a49d9adf@efficios.com> <878qix0wx4.ffs@tglx>
Date: Tue, 02 Sep 2025 18:33:47 +0200
Message-ID: <87qzwozudw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 02 2025 at 16:08, Thomas Gleixner wrote:
> On Tue, Aug 26 2025 at 10:52, Mathieu Desnoyers wrote:
>>> +
>>> +	/* Cache the new values */
>>> +	t->rseq_ids.cpu_cid = ids->cpu_cid;
>>
>> I may be missing something, but I think we're missing updates to
>> t->rseq_ids.mm_cid and we may want to keep track of t->rseq_ids.node_id
>> as well.
>
> Oops. I'm sure I had that mm_cid caching, but somehow dropped it. And
> again, no need to keep track of the node id. It's stable vs. CPU ID.

Correcting myself. You are missing that this caches the compound value
and not only the CPU id.

