Return-Path: <linux-kernel+bounces-774147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4136EB2AF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552775671ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB632C322;
	Mon, 18 Aug 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IXqYppCY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n7X8yHok"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBA32C321
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537187; cv=none; b=l6SdwR58gYa38OqNORo5DXOUb1163VK/MGjqbti21YPIco6slhxLfkUWH1UkzzIYlfU82+IR2EzE9R5WedMymd5GIzS56xBjKYqc+AxzCFJFWeg/qV8u+KCCPGkQZ6rJok4CbjssrjcCGWRu3hy/bln8yBp40/X9bw7BeGO7tbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537187; c=relaxed/simple;
	bh=EDPpEGcxMTyYFkkxcAFSr0LROXTLY4QYEBEFD4O3sU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EFoV11mEY0COfgM2AhkVIgO97ngrqZNaa5VDeFJ+GTr4qyheCdoVKaSfqST3xWvX9BEhIeSBr96thBQrDYD/Kwz7BL4yfEuVkF71tHxfwmHST4u4NAsvJLP6ryJ0tsxifMgHSGoDpOu50XKN4BTAgJ+e2SFWdtqUCTSE90CIMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IXqYppCY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n7X8yHok; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755537182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTYUhF3bXD/ytq126zFWKGQIGvLT3hAKpaitCU+9r58=;
	b=IXqYppCYV8Y/S3PIUPlF7/0gNqu+YzKVv8gZrA4m6uNUU4+6M6aaZlPrEYKuTNZU19TDtn
	eprKrg6gdbVZIAPEJuCUZWvpzAnsBZ79ZvxARnaRJD4dB2xZ1iJ1Xya9AgluvHDu9KjFJi
	RK3SK1m43xDPU1VGfW48FFLGfQf+rL9Ff4SUPOgXFQgNgBOtX3FAt43gnxKZ1hKqN8obzR
	hqU76CFxHePUzBAM2GF1ptK2VmPZhEBKEDL984jXLUAX/zQ15YuLddbt/JnvgRi0U+CorL
	QXTzgoTAcFQ5k2+j2+nOhOF4XhlPDjS4DJdRKeu/a6TNGYeGfBsRclVxa0Otww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755537182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTYUhF3bXD/ytq126zFWKGQIGvLT3hAKpaitCU+9r58=;
	b=n7X8yHokqh5xZX4SjSXm9dcuTYAwGGHFV0ROnYIFolDYISg4xzBsVcaoTkEbAjLHTzKbtX
	y3HNoQUo77TTrJAA==
To: Florian Weimer <fweimer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
 Michael Jeanson <mjeanson@efficios.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, Sean
 Christopherson <seanjc@google.com>, Samuel Thibault <sthibault@debian.org>
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
In-Reply-To: <lhuect8sol1.fsf@oldenburg.str.redhat.com>
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
Date: Mon, 18 Aug 2025 19:13:01 +0200
Message-ID: <87cy8sy2n6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 18 2025 at 16:15, Florian Weimer wrote:
> * Thomas Gleixner:
>> It's trivial to reproduce. All it needs is to have in the source:
>>
>> __weak ptrdiff_t __rseq_offset;
>>
>> w/o even being referenced and creating a pthread. Reproducer below.
>
> Well, that's sort of expected.  You can't define glibc symbols that are
> not intended for interposition and expect things to work.  It's kind of
> like writing:
>
> int _rtld_global;
>
> That's going to fail rather spectaculary, too.  We make an exception for
> symbols that are not reserved (you can build in ISO C mode and define
> open, close, etc., at least as long as you link to glibc only).  But
> __rseq_offset is a reserved name, so that is not applicable here.
>
> The real change here is GCC changing from -fcommon (which made a lot of
> these things work in the past) to -fno-common.

Thanks for the explanation!

So the only way to make this actually work is to revert that commit and
the folks who want to link that statically need to come up with:

#ifdef _BUILD_STATICALLY
extern ....

#else
        ptr = dlsym(...);
#endif

or something daft like that. A proper function interface would avoid all
that nonsense, but we can't have nice things or can we?

Thanks,

        tglx

