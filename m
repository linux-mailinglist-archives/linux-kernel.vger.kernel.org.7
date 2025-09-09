Return-Path: <linux-kernel+bounces-808382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA30B4FF03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CCE169D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08E32253D;
	Tue,  9 Sep 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XKHhGS/8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JoFN3p2d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C758219A8A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427215; cv=none; b=S2KRZ/pLI+1WSQBmXs30VVaYNrKJqlgJ/KIG1YABT7Xcvyc/HCuH5MSVFcJBM/0QPNHOBvZ3rGl1aoPXsYwtLcQLAtsF3G8L2YbT8gEj12LFT+y3MlTNdtl9OtVkKhwCWPmUuz7edp84XTaQR1UVHitDvibK/MhiC0yF6mp6iFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427215; c=relaxed/simple;
	bh=xD+cHmKjUMb+UO518tag/VemxKEaywqKmiHIBuat73E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HMo0mmI2zHEAl3EZTY0Cm6M1O8NXDyXBYvVVWSd0Epi3StEd2lxXBTWXs0X6+HFT/fP4xuw/TDAMKkKyo6bb1cpPhqlETXpMJjMMtZbKAZ0Q5Ngwtc8a3QzszLrLQlCpPlce/rV9j4h5GD/MNUCFeF4tSnAR6Cvz6GzVB8BoVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XKHhGS/8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JoFN3p2d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757427211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rdiTte2hv5Zu+0LGIjx5hvT/gWGsvb6f67HWeCPJm0=;
	b=XKHhGS/8K2YJcaNxRXiu8hjtCPO4GG2d6moTBv2Za6H1KUl9JJJjmpEWbQxiyH9b0OMmJR
	R4cxbIdHq8B1Rbe4vW2IGYKU5JlWUZzBTZa80FsEXT+nIvmcWprZ0wMG8V76mcJEQK1f/E
	ij21/o2jeJo24HFmTm78+LeoBcaDydMZqm2Gz4JAa452ysOqTd22yHoM42Usg26AX9gM8s
	9qcdP3C74LaQWsp7O3EwJe2NC/VYGoeSm/LzYtAhq7W9aIm2n6fQw90DHTwLiImAgs7I1M
	z8Ax+9KdxyMPnWm3cYXnIpMIS58WvvVuUiuLUugknulImDdBAB9OCsyw48eghQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757427211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rdiTte2hv5Zu+0LGIjx5hvT/gWGsvb6f67HWeCPJm0=;
	b=JoFN3p2d0VJJ7v8oUfucFlIVtvLBQ+En+I7cZ9kgt6wI0M+EE0kNaKaVB+KOexTLYT4mSA
	9XMDXlsbwHw0wjCw==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 14/36] rseq: Cache CPU ID and MM CID values
In-Reply-To: <ac375e1e-87a6-43ab-8f2c-7d9ab4f2f34d@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.161186107@linutronix.de>
 <ac375e1e-87a6-43ab-8f2c-7d9ab4f2f34d@efficios.com>
Date: Tue, 09 Sep 2025 16:13:30 +0200
Message-ID: <87h5xbvhmd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 09:43, Mathieu Desnoyers wrote:
> On 2025-09-08 17:31, Thomas Gleixner wrote:
>>   /**
>> + * struct rseq_ids - Cache for ids, which need to be updated
>
> need -> needs

ids is plural, so 'need' is correct, no?

>> + * @cpu_cid:	Compound of @cpu_id and @mm_cid to make the
>> + *		compiler emit a single compare on 64-bit
>> + * @cpu_id:	The CPU ID which was written last to user space
>> + * @mm_cid:	The MM CID which was written last to user space
>> + *
>> + * @cpu_id and @mm_cid are updated when the data is written to user space.
>> + */
>> +struct rseq_ids {
>> +	union {
>> +		u64		cpu_cid;
>> +		struct {
>> +			u32	cpu_id;
>> +			u32	mm_cid;
>> +		};
>> +	};
>> +};
>> +
>> +/**
>>    * struct rseq_data - Storage for all rseq related data
>>    * @usrptr:	Pointer to the registered user space RSEQ memory
>>    * @len:	Length of the RSEQ region
>>    * @sig:	Signature of critial section abort IPs
>>    * @event:	Storage for event management
>> + * @ids:	Storage for cached CPU ID and MM CID
>
> It's far from clear from the diff, but is there a missing space at the
> beginning of the line above ?

No. The actual diff is:

  * @event:	Storage for event management
+ * @ids:	Storage for cached CPU ID and MM CID
  */

It's just the reply quoting which makes it ugly.


