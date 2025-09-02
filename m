Return-Path: <linux-kernel+bounces-796692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B410AB405F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A35628C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E674299AB5;
	Tue,  2 Sep 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auY5BGJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j/xgH29d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7126D4E2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821382; cv=none; b=qhF91O1C7ghM+4DgW06dsyls3ksrcknAoPh9QX5b73vZ0yL/sGKAq/pMvYHJobGqitw+ceyhCJ8O6XRYMrI9GALvlB5xBEt8qFsk9iU2oN0fdugsMqQ4HgD0iYrToNIWSX0I+xs3wDexYbhrkVZ4jPRXtwi35YVOJHzw6IpWwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821382; c=relaxed/simple;
	bh=6NjUJdWqNNqnYrUOgCs1pwBPRHM8p+isi6G4JcTG2eM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cGLfYsc7uLUSRKDkci+WhEUQLqloBL1oCMmHOu/EEUWPyDccFptSFwZcSHkGZBf/qn7l+Flm/lKpIvRBV71rtcmqN/HF5j0D0UZDkhC4ZAaFBb22z9WdoThOqKN+YuXVOBNUZOcS7XywofaxLiIXWI4FeoI+vgZ7E4EdOR+J9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auY5BGJJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j/xgH29d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756821379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFGLCwPbLvRuNQmL03+ALFpOnprLer4a9K905eFQfIQ=;
	b=auY5BGJJf8ytFightob8ypip4Q2ENHhyo1FbRf8m4jyXtArhnqkGxgbVdEA3Wg+6QNAScM
	1RjI6iOvhbngWk1efDk4HWySueTeqm/KilgDHHYiCUMl7cTcMQp50xfXdCkg7S7vGPKry3
	KkFLESf3k8zXZkid+BccLCgXco/WhDiuexHmN21CR/cxfypzsjU2Gjlm+HGn6a/O9CC5Ih
	Vieac6FnH5rMLLsO7r4xItrSvDN2fhmLw8+u/Juj7UVHf/x/Yf3t07xX/KTxCaJyelnSoj
	qEcfSQd/vzTLeIpVFAuzWGyYOg6ggguhVoES08Ko5tqrTsVAEcY2FrQK5AHiGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756821379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFGLCwPbLvRuNQmL03+ALFpOnprLer4a9K905eFQfIQ=;
	b=j/xgH29db3LJjlKwNCNE4fDpLbRKAWP7XArbOm02EyUSGO5wGWAdt3KaLX4/g0NtOtwSzP
	wXDMWkT6Y/4lYlDA==
To: Michael Jeanson <mjeanson@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V2 18/37] rseq: Provide static branch for runtime debugging
In-Reply-To: <f3131178-7e69-4d38-bb99-4b063f409a66@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.421576400@linutronix.de>
 <f3131178-7e69-4d38-bb99-4b063f409a66@efficios.com>
Date: Tue, 02 Sep 2025 15:56:18 +0200
Message-ID: <87bjnt0xh9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 25 2025 at 16:30, Michael Jeanson wrote:
> On 2025-08-23 12:39, Thomas Gleixner wrote:
>> +static int __init rseq_setup_debug(char *str)
>> +{
>> +	bool on;
>> +
>> +	if (kstrtobool(str, &on))
>> +		return -EINVAL;
>> +	rseq_control_debug(on);
>> +	return 0;
>
> Functions used by __setup() have to return '1' to signal that the 
> argument was handled, otherwise you get this in the kernel log:
>
> kernel: Unknown kernel command line parameters "rseq_debug=1", will be 
> passed to user space.

Duh, yes.

