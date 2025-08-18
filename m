Return-Path: <linux-kernel+bounces-774417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E1B2B1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0339D5E85D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4B32749CA;
	Mon, 18 Aug 2025 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlEYtsUE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E43451BE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546972; cv=none; b=RlQHQgsGI4v8dUFsqwuNiF5e0nfXmbG20G7xUOt8HhuQJEL4MQ8s0CM5fUyRCl3iK4WgKgp6WHOoLcn04qcBd2L1bdh/9UbYEYcMcaIu1ufcd0oCn9Lx7XbndNhwUPN68tJR1yce8heiSPnhPBLabhhsUmYJWI/rDhpcQWMMOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546972; c=relaxed/simple;
	bh=//SS2mTO1buSrXfwSBN0G4K0rHUDi7BR5rIuVgEvTeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ejz46zNCbxXNCrZY3bPtN/we7Xn0WeUlrvyxOd39/FVUFUSJRKT75/Wuyc2V3ixJrHTedNnJuDOpXpaFzJ+0zK96c9PpvgDmQHDhGlYD15YlCSHAIy6Mg9i4BsvaO31f9djCzSRHfeutqoJkxP/tVS8oKMW8xBPkBr6k5AzNZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlEYtsUE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755546969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HK47qApgMKXU/215QUij4nw5g/OaReZgV4tLVHxTLrY=;
	b=VlEYtsUEqMUhDFt2vqG2XOKHtXrHO2eT2uF4FrOmDPzGuz6xA2mpSAI9aV7mV8WLKRoYrh
	uu0OnwyHxW2Vvw58us5V47gKQ4Lj0zIQSw8djYwSqd2NRE/65KoYr+ZCFkg3r2ps1N7In6
	o/gUFx5Oq9S8uK/JkxpF1pvpISCZgxI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-ovM-ltb6PvaRRd8KhPEeww-1; Mon,
 18 Aug 2025 15:56:06 -0400
X-MC-Unique: ovM-ltb6PvaRRd8KhPEeww-1
X-Mimecast-MFC-AGG-ID: ovM-ltb6PvaRRd8KhPEeww_1755546963
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDB4E19560AD;
	Mon, 18 Aug 2025 19:56:02 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45561180028B;
	Mon, 18 Aug 2025 19:55:59 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Jens Axboe <axboe@kernel.dk>,
  LKML <linux-kernel@vger.kernel.org>,  Michael Jeanson
 <mjeanson@efficios.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Peter Zijlstra <peterz@infradead.org>,
  "Paul E. McKenney" <paulmck@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Wei Liu <wei.liu@kernel.org>,  Samuel Thibault
 <sthibault@debian.org>
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
In-Reply-To: <aKODByTQMYFs3WVN@google.com> (Sean Christopherson's message of
	"Mon, 18 Aug 2025 12:46:15 -0700")
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
	<87cy8sy2n6.ffs@tglx> <lhuwm70qvac.fsf@oldenburg.str.redhat.com>
	<aKODByTQMYFs3WVN@google.com>
Date: Mon, 18 Aug 2025 21:55:56 +0200
Message-ID: <lhujz30qu9f.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

* Sean Christopherson:

> On Mon, Aug 18, 2025, Florian Weimer wrote:
>> You could add the extern keyword and check &__rseq_offset for NULL if
>> you want to probe for the availability of the signal?
>
> That will fail to link if the glibc version doesn't support rseq in
> any capacity, which is why I added the __weak crud.

You need both (extern and weak) to get a weak symbol reference instead
of a weak symbol definition.  You still need to check &__rseq_offset, of
course.

>>Or use:
>> 
>> #if __has_include(<sys/rseq.h>)
>> #include <sys/rseq.h>
>> /* Code that depends on glibc's rseq support goes here. */
>
> FWIW, the code in question doesn't depend on rseq per se, rather the problem is
> that attempting to register a restartable sequence fails if glibc has already
> "claimed" rseq.

You can set GLIBC_TUNABLES=glibc.pthread.rseq=0 as an environment
variable to prevent glibc from registering it.  For a test that's
probably okay?  It won't help with other libcs that might use rseq
eventually.

> What about something horrific like this?  Or if __has_include(<sys/rseq.h>) is
> preferrable to checking the glibc version, go with that.  The idea with checking
> LIBC_RSEQ_STATIC_LINK is to give folks a way to force static linking if their
> libc registers rseq, but doesn't satisfy the glibc version checks for whatever
> reason.
>
> diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
> index 663a9cef1952..1a88352fcff3 100644
> --- a/tools/testing/selftests/rseq/rseq.c
> +++ b/tools/testing/selftests/rseq/rseq.c
> @@ -36,17 +36,18 @@
>  #include "../kselftest.h"
>  #include "rseq.h"
>  
> -/*
> - * Define weak versions to play nice with binaries that are statically linked
> - * against a libc that doesn't support registering its own rseq.
> - */
> -__weak ptrdiff_t __rseq_offset;
> -__weak unsigned int __rseq_size;
> -__weak unsigned int __rseq_flags;
> +#if defined(LIBC_RSEQ_STATIC_LINK) || __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 35)
> +extern ptrdiff_t __rseq_offset;
> +extern unsigned int __rseq_size;
> +extern unsigned int __rseq_flags;
> +#define GLIBC_RSEQ_PTR(x) &x
> +#else
> +#define GLIBC_RSEQ_PTR(x) NULL
> +#endif

That doesn't work for a couple of distributions nowadays that are
nominally based on glibc 2.34.  The AArch64 performance improvement for
sched_getcpu was just too sweet to give up, so these distributions have
__rseq_offset@@GLIBC_2.35, too.  We added these symbols specifically so
that applications that need to interact with rseq can do so safely, even
though glibc claimed it for the sched_getcpu acceleration.

Thanks,
Florian


