Return-Path: <linux-kernel+bounces-810448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C098FB51AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEB9B629F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05B2329F34;
	Wed, 10 Sep 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HgBKUW2T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cv4kftta"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB0329F2F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516059; cv=none; b=pX08gCAIFzJHtRr0SQzCQqgVERsFkUFkCx1Mle1dEpIMQfjfRhr5YeJrtBH7A2TEuPE7/z8TaP1rGMdW2Xuw3s01TjwbBXXJ5aVGC0fhAbjqACXVR/ccYKAEj4xYwul0zh1pxD9DYoY9lhDB+GHAiEdYTc3xZ36YEBTBq5Fe/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516059; c=relaxed/simple;
	bh=XSaX1sxYtqPtQQ8fXDVHqx9RopzIBxiTdAA+e8cMZOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uT6/6XrpdyqtR0ULEb239JofaI3ZHBz9uQinyfk9liVjHZEH2FEsV/HXQzKpmnMhlc/rKQowK8Gw89LOdSy/hpei64B1bPzvP/A0RNYBTrRh07fJmgFFIi09in/5syAn7b35CQmyGP2AsLrVxoxg/7k/vE9MOHb77dZkTQ/xNaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HgBKUW2T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cv4kftta; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757516053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgwqXmToXPpmi6iMjwkVoSVLN5sKUJ4q4e/5ofe+WSU=;
	b=HgBKUW2TGWPSai701tuK9bDxD3f1J3vPUxz+eojSMo1ACqEwt7hU+bEZdV7EhAtqTceSiA
	Hl955WjKPiGSZNM1+FaF9oMGnzsqIULWTb62zYxET0hVMiqNK9JqnbnSRodb3FxqgPgW8q
	gruOpIbB+j9C46JwqZzFviY9Qe0WfraTmgxpWVJv4j4tIS7WtY/wibgVcQve1IfCX3faZB
	KOfjsC5G3iMKBX80rt72FObNsJ448yUUIIXPwAbr6hCcT/HcHnxtxj9dohrMAIT7R5Ze+u
	GbhzCZoHoF20NOe/UHMi1BsGo1jBDR+bQH9hvLxrgWn4qb4J/I7Pqfs8rKOLow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757516053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgwqXmToXPpmi6iMjwkVoSVLN5sKUJ4q4e/5ofe+WSU=;
	b=cv4kfttatviow1VMz62/65CHr5JnYAgdf0asArhaVo7ut6/5UKOWUH5U0i9D0VeZVXN/wA
	F86wiEMJmanviNCw==
To: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 00/36] rseq: Optimize exit to user space
In-Reply-To: <4029c2d2-7a0c-4531-aa1e-b35be9098bb1@kernel.dk>
References: <20250908212737.353775467@linutronix.de>
 <4029c2d2-7a0c-4531-aa1e-b35be9098bb1@kernel.dk>
Date: Wed, 10 Sep 2025 16:54:12 +0200
Message-ID: <87bjnitl2j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025 at 07:55, Jens Axboe wrote:
> On 9/8/25 3:31 PM, Thomas Gleixner wrote:
>> For your convenience all of it is also available as a conglomerate from
>> git:
>> 
>>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf
>
> I used this branch for some quick testing. Since I last looked at the
> rseq performance overhead, glibc must have improved a few things. FWIW,
> box is running libc 2.41 at the moment. Test box is on debian unstable,
> so gets frequent updates. In any case, for one of my usual kernel
> overhead runs of checking running a basic IOPS based test, I see the
> following on the stock (-rc5 + 6.18 targeted changes) kernel running
> that test:
>
> +    0.89%  io_uring  [kernel.kallsyms]  [k] __get_user_8
> +    0.58%  io_uring  [kernel.kallsyms]  [k] __put_user_8
> +    1.13%  io_uring  [kernel.kallsyms]  [k] __rseq_handle_notify_resume
>
> which is about 2.6% of purely rseq related overhead. Pulling in the
> above branch and running the exact same test, all of the above are gone
> and perusing the profile has nothing jump out at me in terms of shifting
> those cycles to other bookkeeping.
>
> So yes, this work does make a very noticeable difference!

I would have been really surprised if not :)

Thanks a lot for testing!

       tglx

