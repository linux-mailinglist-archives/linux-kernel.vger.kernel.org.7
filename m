Return-Path: <linux-kernel+bounces-761859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22066B1FF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425D116FA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC02877F1;
	Mon, 11 Aug 2025 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGzQrz95";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+A0LwfXR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55E2472A5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893612; cv=none; b=DqKwpbt9LSbIsNcat8txWOzUx42x5QIB4u8TN207qvVFoZqK5LoTRFn4HjffwlGtW6La6AZCxTGalrbn+W1pBDbhOJ2ba54ALu5g1N2/7SNzgpj6f/u8HyH2UjDfha6w2lFX9Q8cFFa+ZI5Wax9ou3lTc4OflZHuZgZSb1/qBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893612; c=relaxed/simple;
	bh=OCraklBZTqVBiiEECGNqV/m/WAlcoeYDId1Y/7czW2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u22DnKwOM7L4mWQWMunbS45Zs84mZCot1xtovmvg/Rz1G9i+XMJGidQMHnhiKdxCH4Ks4iouoltnWMHuy3R/l9aRlogkm9AKxXcLbefs+WDIsdbBTloWU6nlKL75HXIYBKU5IZLFpFQ1bK8TU9/rk0rlzCMq6YDduUzispG5Nag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VGzQrz95; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+A0LwfXR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754893608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W7gWB95IkQm0qhLR+gScIgXp6KbrQbcmNdAwFbs53Y4=;
	b=VGzQrz952NVfn5NTgN3aLSUOwTAVRceEHASQirfWMqmxwI9EkDbqELwNhukPLjdeKzCFwX
	yF5z32A5v78sJ1uJA13jGUfKx8by8OPgYeH8P7KsrmhE9YXIedxzOC2hr0kSEvCg43J/ic
	6xyn5MhVNtbLmK85EaNEQxWNXwxqVH2Ftza1vmj6T7tHwdSA/Wg0YVXdmU7Z7Wj3O4Mq7W
	VWZJOtSaypLKNXf/fNlujLQikrx1itHBX/EKz2PpykEMA+aDsxa58bJ8cK4rV7XO9LfReP
	E9vGvlB0YQF/BkDPBxwIU13Vncea3hT6vIPCoIGF4usTvUR7R3SjnVN3ylRmcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754893608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W7gWB95IkQm0qhLR+gScIgXp6KbrQbcmNdAwFbs53Y4=;
	b=+A0LwfXRvWw/v44vEwwLew2b3iwvlPHlj5Sj4CHf8Ll4BfzW7yxsUexe0U+KnkCJSIyaUb
	MBRfJQBiQ0qa54AQ==
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Kees Cook <kees@kernel.org>
Subject: Re: [patch 4/6] perf/core: Split out ringbuffer allocation
In-Reply-To: <cd206fce-0a91-4501-a863-d398dbca197f@lucifer.local>
References: <20250806195624.880096284@linutronix.de>
 <20250806200617.450396385@linutronix.de>
 <cd206fce-0a91-4501-a863-d398dbca197f@lucifer.local>
Date: Mon, 11 Aug 2025 08:26:47 +0200
Message-ID: <87sehybcgo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025 at 16:38, Lorenzo Stoakes wrote:
> On Wed, Aug 06, 2025 at 10:12:58PM +0200, Thomas Gleixner wrote:
> THe second is that you don't seem to be doing:
>
> WARN_ON(!rb && event->rb);
> if (vma->vm_flags & VM_WRITE)
> 	flags |= RING_BUFFER_WRITABLE;
>
> In the aux code any more. Maybe first irrelevant, but second surely
> is?

Yeah. The first one is kinda silly. The second one I dropped unintentionally.

> DIFFERENCES:
>
> If we get to the rb_alloc_aux() bit, we're missing the:
>
> WARN_ON(!rb && event->rb);
> if (vma->vm_flags & VM_WRITE)
> 	flags |= RING_BUFFER_WRITABLE;
>
> Bit for aux case.
>
> Otherwise, it seems to be equivalent.

Thanks for taking the time to go through this.

>> -		if (rb_has_aux(rb)) {
>> -			atomic_inc(&rb->aux_mmap_count);
>> -			ret = 0;
>> -			goto unlock;
>> +		if (event->rb) {
>> +			ret = -EINVAL;
>
> Shouldn't this be if (!event->rb) ?
>
>> +		} else {
>
> Because here you're dereffing event->rb in branch where !event->rb?

Yes. I obviously failed to tested this particular patch alone and that's
fixed up in the next which moves the RB allocation out, so it did not
blow up in my face when I tested the whole pile.

Thanks for spotting!

       tglx


