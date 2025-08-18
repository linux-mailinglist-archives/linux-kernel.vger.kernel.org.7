Return-Path: <linux-kernel+bounces-774400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FCCB2B1BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD583AD962
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4660C21E0AF;
	Mon, 18 Aug 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsI/XN21"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125113451B3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545644; cv=none; b=LMEKNNqIoGbs6Qp1EBBVihQLrqfXEt6jAtadc+xabLbmTt+YuFXyXfRZ/+5ABj3N706xAJge49iFQDHx3c9/Ky+P/P5+CD1sM8iuabffc4xL2BweP4vgC8O1OCOLfT2RAbU31lV3RT0bTPaH1nVeODihNemGibIDJ42Dd1pCXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545644; c=relaxed/simple;
	bh=bBOaGSJxCOqLYvJyQzTKSnZsMNPBaG4ZX3QxlRCRz/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=moBpgj2LxQUY8CEFbE9uU+FI0ysbirXmHwyZgrKL4vh/taubH4bX1CUZrN/n9gq7PIVuXBnzkc/xZv4o/d/tkpwEuyOrdcWt0UK9Pu9oMdZ4YVHppnUI6hfAoOrbRdFzcRwfcJ7LruSYspI0tDeVoVOfTaol7IIrStwB82RHFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsI/XN21; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755545641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBN0u4ItBWe+goPUbV5rIB04rw3YKPdvNWrhJS6T7wQ=;
	b=LsI/XN21reREvo6GphUjC9JdRMz2xXyiWLli8zpnSGyUOjYbt4oT9VZTZDNxuyBa3DPZSg
	8fVZWS/nFmTlwhY43imgK2pd97sA9VCvcuKUDUzf2Nq/YBkjMscu/IE1m0u5p40PBRGnJk
	afFJaMg2Q1kLgJbzDquVbSqchC4rV+c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-kX13NWyTMRuawZNbgAFEMw-1; Mon,
 18 Aug 2025 15:33:58 -0400
X-MC-Unique: kX13NWyTMRuawZNbgAFEMw-1
X-Mimecast-MFC-AGG-ID: kX13NWyTMRuawZNbgAFEMw_1755545636
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D7641955F1F;
	Mon, 18 Aug 2025 19:33:55 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B7A230001A5;
	Mon, 18 Aug 2025 19:33:50 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>,  LKML <linux-kernel@vger.kernel.org>,
  Michael Jeanson <mjeanson@efficios.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Peter Zijlstra <peterz@infradead.org>,
  "Paul E. McKenney" <paulmck@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Wei Liu <wei.liu@kernel.org>,  Sean
 Christopherson <seanjc@google.com>,  Samuel Thibault
 <sthibault@debian.org>
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
In-Reply-To: <87cy8sy2n6.ffs@tglx> (Thomas Gleixner's message of "Mon, 18 Aug
	2025 19:13:01 +0200")
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
	<87cy8sy2n6.ffs@tglx>
Date: Mon, 18 Aug 2025 21:33:47 +0200
Message-ID: <lhuwm70qvac.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Thomas Gleixner:

> On Mon, Aug 18 2025 at 16:15, Florian Weimer wrote:
>> * Thomas Gleixner:
>>> It's trivial to reproduce. All it needs is to have in the source:
>>>
>>> __weak ptrdiff_t __rseq_offset;
>>>
>>> w/o even being referenced and creating a pthread. Reproducer below.
>>
>> Well, that's sort of expected.  You can't define glibc symbols that are
>> not intended for interposition and expect things to work.  It's kind of
>> like writing:
>>
>> int _rtld_global;
>>
>> That's going to fail rather spectaculary, too.  We make an exception for
>> symbols that are not reserved (you can build in ISO C mode and define
>> open, close, etc., at least as long as you link to glibc only).  But
>> __rseq_offset is a reserved name, so that is not applicable here.
>>
>> The real change here is GCC changing from -fcommon (which made a lot of
>> these things work in the past) to -fno-common.
>
> Thanks for the explanation!
>
> So the only way to make this actually work is to revert that commit and
> the folks who want to link that statically need to come up with:
>
> #ifdef _BUILD_STATICALLY
> extern ....
>
> #else
>         ptr = dlsym(...);
> #endif
>
> or something daft like that. A proper function interface would avoid all
> that nonsense, but we can't have nice things or can we?

I don't understand why a function would be different.  Well, a function
*declaration* would be implicitly extern, in a way a variable
declaration is not (without -fcommon).  Maybe it's just about the
missing extern keyword?

You could add the extern keyword and check &__rseq_offset for NULL if
you want to probe for the availability of the signal?  Or use:

#if __has_include(<sys/rseq.h>)
#include <sys/rseq.h>
/* Code that depends on glibc's rseq support goes here. */
#endif

Thanks,
Florian


