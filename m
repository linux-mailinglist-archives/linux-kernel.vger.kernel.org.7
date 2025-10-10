Return-Path: <linux-kernel+bounces-848218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8113BCCEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2A374FCF3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BBE285CB3;
	Fri, 10 Oct 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVRPaQqW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15181C84DE
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099619; cv=none; b=sMmbzM9rupGpzeFbGGhSBmNv1B7srQv816nETcxqxIOd4o/lpCKlCvGEnYQUtCeT/woeUkBbrySGWm8eeeAXQQdirgZPmRT9IYy++hVNlWuRcw2ARh5HcdZMdQRzgvF6F+WIqaYv2lSxcm7Ne1f8trl1KJWSN/20OD1Lz5oySTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099619; c=relaxed/simple;
	bh=6ECMmbY4Ziw9yObzZmEf0dvJXcY8d5HkNCmboIvHDQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSOUifjyOkREi+RD3Bzv9eUKS0C+/NnyY+KkJU+Ic2/58H7gULvjVi0bE4xA7dQt+Zh/pL9kdpOkgJdKscBwjqDDU/cUt402moMJrYM0uld9Hw+fn+WKWOguR70hsSeve7Lf+qrlI8exAZzK8KaZacUakkm96cBZqoioul5rSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVRPaQqW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760099616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8JmPqJ+JSvmUnLdMiwPZyKqiGKN39TVLryZKU4DwUgE=;
	b=TVRPaQqWFYPO+tmjLAYSCYeT94q8ltX9G8rrG+Mg6iGNlFxf/he6Re2Q/ZqR1VjbMcIlJB
	kqJRUymn8i7mbmUp/l0+V6IQVtcmomuklJ+ECPpKk0ErZ2a4OhZH4U+f0+p9aqTo+Y8bOO
	19N113j5mxGjMje7NgKgRu981U1FmeA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-9lLUvUvePSyF4gKGee9kyw-1; Fri,
 10 Oct 2025 08:33:35 -0400
X-MC-Unique: 9lLUvUvePSyF4gKGee9kyw-1
X-Mimecast-MFC-AGG-ID: 9lLUvUvePSyF4gKGee9kyw_1760099614
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7D311955E8F;
	Fri, 10 Oct 2025 12:33:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0513419560BB;
	Fri, 10 Oct 2025 12:33:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Oct 2025 14:32:13 +0200 (CEST)
Date: Fri, 10 Oct 2025 14:32:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251010122347.GA8798@redhat.com>
References: <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com>
 <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
 <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
 <CAHk-=whmjm0BbirO8HhT_TZQ2JJMs_FpTcT9SXXaA3NifW2a4w@mail.gmail.com>
 <20251010080327.GF4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010080327.GF4067720@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/10, Peter Zijlstra wrote:
>
> I reordered the code, it is happier now.
>
> Anyway, the below seems to generate decent code for
> {-O2,-Os}x{gcc-14,clang-22}. Yay for optimizing compilers I suppose :-)

Another approach which looks better than mine ;)

Linus's version is simpler, but yours can handle break/return and
the "only lockless" case, good.

I leave this patch to you and Linus, he seems to like your code too.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


But... perhaps we should not "export" the _target names and instead
add the additional defines, something like

	scoped_seqlock_read()
	scoped_seqlock_read_or_lock()
	scoped_seqlock_read_or_lock_irqsave()

?

Oleg.


