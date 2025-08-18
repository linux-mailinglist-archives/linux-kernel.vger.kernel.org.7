Return-Path: <linux-kernel+bounces-773809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CD4B2AA98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0645684D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500530E835;
	Mon, 18 Aug 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BN7N2vn8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F621CC59
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526555; cv=none; b=a+pGab5EhUXl6Hp9Am6+Ay0s7bZVPwD2GcvT1zrycwe2mna7Uq40R/ox+ROPUa4UJm+5oYpZO9AEUlldtF/bbH2O9YEUzvrO4Iqnmz+0ax4iHo7k03lg4vw/q2Mq9l9XsbO61kDisMnZfwThoqBgTM1+O+CECWcCYJeASKFoi7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526555; c=relaxed/simple;
	bh=9USpyRnb1fxPa09Sd5l/boQOMb607B0Z+GkFYZeyGjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MQvJmRduuefQ9pvjW8YF52hyvkBTmLG+G1j5PP2W9Hs7eKlwXmDz+GyEaS7ED684mnMjc1tq6MEH6p7A67YIDu/8HjfOqR7uf0QkLNjryMnquLySEUPngjii0AU2Sb36YU4XEn0J5EumbYjwTmd90mtL8wmD7GWTIhQT9TenrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BN7N2vn8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755526552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=939vtpCFL3U8h4rCZHr975ZJTiYuY4xWv6Lielz8HCk=;
	b=BN7N2vn81tC/uBEW4lt9r6FP8MLbnsU313dP/Mk/vsAk7WVvJpULcmPCtG62P/TeN3SGAU
	BZXgM/wXh0Uxd+/jIaIHdfC4VBP1lQLhIY9S+7XZ/y6Sn40XuXXLrmioj70Ry+dXW81tHc
	RPb1EV9z6j0oM24bPzXMIqcSIDjxEg0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-6KTG6cDaPKW5yO3H7iIQkw-1; Mon,
 18 Aug 2025 10:15:48 -0400
X-MC-Unique: 6KTG6cDaPKW5yO3H7iIQkw-1
X-Mimecast-MFC-AGG-ID: 6KTG6cDaPKW5yO3H7iIQkw_1755526546
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED72619560AE;
	Mon, 18 Aug 2025 14:15:45 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C172A19560AD;
	Mon, 18 Aug 2025 14:15:41 +0000 (UTC)
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
In-Reply-To: <87frdoybk4.ffs@tglx> (Thomas Gleixner's message of "Mon, 18 Aug
	2025 16:00:27 +0200")
References: <87frdoybk4.ffs@tglx>
Date: Mon, 18 Aug 2025 16:15:38 +0200
Message-ID: <lhuect8sol1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Thomas Gleixner:

> On Sun, Aug 17 2025 at 23:23, Thomas Gleixner wrote:
>> It survives the self test suite after I wasted a day to figure out why
>> the selftests reliably segfault on a machine which has debian trixie
>> installed. The fix is in the branch.
>
> That's glibc 2.41 FWIW. glibc 2.36 from Debian 12 does not have this
> problem.
>
> The fix unfortunately only works with a dynamically linked libc,
> statically linked libc fails. The fix is basically a revert of
>
>    3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked
>                   against glibc 2.35+")
>
> which introduced these weak libc symbols to make static libc linking work.
>
> I have no idea why this creates havoc, but in GDB I saw that libc
> manages to overwrite the TLS of the pthread at some place, but I gave up
> decoding it further. If no pthread is created it just works. Removing
> this weak muck makes it work too.
>
> It's trivial to reproduce. All it needs is to have in the source:
>
> __weak ptrdiff_t __rseq_offset;
>
> w/o even being referenced and creating a pthread. Reproducer below.

Well, that's sort of expected.  You can't define glibc symbols that are
not intended for interposition and expect things to work.  It's kind of
like writing:

int _rtld_global;

That's going to fail rather spectaculary, too.  We make an exception for
symbols that are not reserved (you can build in ISO C mode and define
open, close, etc., at least as long as you link to glibc only).  But
__rseq_offset is a reserved name, so that is not applicable here.

The real change here is GCC changing from -fcommon (which made a lot of
these things work in the past) to -fno-common.

Thanks,
Florian


