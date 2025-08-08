Return-Path: <linux-kernel+bounces-760267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25573B1E8B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C59558458D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2C27AC21;
	Fri,  8 Aug 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIcQ8Xjl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FC27A12C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657710; cv=none; b=UcryfY2xFTG32ruC3gEo4MajH/H0lzZ3OvqDlM4aSPEfNqfsTGLHpNgAIpNULAQvHB23hFgUEd6rVZpNs9bJmNFAoWpKjmMlG8t9ixgKfil1n9sYOEAoS3s31HeC6J7LuwBoaHquDKQFJMgT1JZOErEvRuOQauVtR2MjvSB3Bew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657710; c=relaxed/simple;
	bh=ACUK4qgqm3ftNNEGB9p2GKz/5T/Q8TaeMNYmr6hRbJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFmBDgPftx6awS2D3XYrkBsrLWqeAZpoktxEZGsAQQvLXM5oBNjCZ3mhJ/4v7DbZLCe9EaLlJwVufe5829y1nBXHLft6l4PC2SqP82YXIkWHLB6Ja2z0iWOa+3zbUivt45Dr7eFc4pR3x7DoxAooO/lHEq25C1fs+/wFWmvGY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIcQ8Xjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754657707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=735MKqTpVsLiwF08r9eYm/WhPdFnfobFmT9GhcsZRXQ=;
	b=ZIcQ8XjlH+lc9gWTtRvhOXZ34xKfmRzE9NFRXErYoP7hifsqi+D5/SDRmTrnce17Xtmp+f
	u+Ls84ZB0wLX5Mb1htEAAzQ1fHnaEFzIWntxhXR6L83ScTOJyzLDD19sfPkHxrv11U52GV
	fJSIKW/+xDNbG8lTrS0cpE0AWBexLuo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-JSQNINiVOQuzqBr7vxM5Mg-1; Fri,
 08 Aug 2025 08:55:02 -0400
X-MC-Unique: JSQNINiVOQuzqBr7vxM5Mg-1
X-Mimecast-MFC-AGG-ID: JSQNINiVOQuzqBr7vxM5Mg_1754657700
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5804B180036E;
	Fri,  8 Aug 2025 12:55:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F3B180047F;
	Fri,  8 Aug 2025 12:54:57 +0000 (UTC)
Date: Fri, 8 Aug 2025 20:54:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-mm@kvack.org, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
Message-ID: <aJXznYlO7dpY+p7D@MiWiFi-R3L-srv>
References: <20250805062333.121553-1-bhe@redhat.com>
 <69b4f07d-b83d-4ead-b3f1-1e42b2dca9c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b4f07d-b83d-4ead-b3f1-1e42b2dca9c2@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/07/25 at 06:34pm, Andrey Ryabinin wrote:
> 
> 
> On 8/5/25 8:23 AM, Baoquan He wrote:
> > Currently only hw_tags mode of kasan can be enabled or disabled with
> > kernel parameter kasan=on|off for built kernel. For kasan generic and
> > sw_tags mode, there's no way to disable them once kernel is built. 
> > This is not convenient sometime, e.g in system kdump is configured.
> > When the 1st kernel has KASAN enabled and crash triggered to switch to
> > kdump kernel, the generic or sw_tags mode will cost much extra memory
> > for kasan shadow while in fact it's meaningless to have kasan in kdump
> > kernel.
> > 
> 
> Ideally this problem should be solved by having kdump kernel with different
> config. Because if we want only reliably collect crash dumps, than we probably
> don't want other debug features, e.g. like VM_BUG_ON() crashing our kdump kernel.

Yeah, we have done that in Redhat's internal CI testing. While we still
want to switch back to let kdump take the same kernel as the 1st kernel.
Like this, we have chance to test debug kernel for vmcore dumping. In
this case, KASAN is the main barrier. For other debug features,
VM_BUG_ON() should be captured in 1st kernel's running, we won't wait to
run kdump kernel to catch it. I am planning to check and adding feature
switch for kdump to disable if it's not needed in kdump kernel. E.g I
have done in ima=on|off, and the existing 'kfence.sample_interval=0' for
kfence.

And the public kasan=on|off kernel parameter can make kasan feature more
flexible. It can be used in production environment with kasan=off, and
can switch to the same kernel to catch issues easily by stripping the
cmdline setting. As adding a cmdline is much easier than setting kernel
config and rebuild kernel.

Besides, based on this patchset, we can easily remove
kasan_arch_is_ready() by detecting the arch's support and disable
kasan_flag_enabled. And when I testing generic/sw_tags/hw_tags on arm64,
I feel if adding a kernel parameter for choosing different KASAN mode is
much more convenient than changing kernel config and rebuild. If we
choose to KASAN_OUTLINE, this even doesn't impact much in production
environment. I would like to hear your suggestion.

Thanks
Baoquan
> 
> 
> > So this patchset moves the kasan=on|off out of hw_tags scope and into
> > common code to make it visible in generic and sw_tags mode too. Then we
> > can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> > kasan.
> > 
> > Test:
> > =====
> > I only took test on x86_64 for generic mode, and on arm64 for
> > generic, sw_tags and hw_tags mode. All of them works well.
> > 
> > However when I tested sw_tags on a HPE apollo arm64 machine, it always
> > breaks kernel with a KASAN bug. Even w/o this patchset applied, the bug 
> > can always be seen too.
> > 
> > "BUG: KASAN: invalid-access in pcpu_alloc_noprof+0x42c/0x9a8"
> > 
> > I haven't got root cause of the bug, will report the bug later in
> > another thread.
> > ====
> > 
> > Baoquan He (4):
> >   mm/kasan: add conditional checks in functions to return directly if
> >     kasan is disabled
> >   mm/kasan: move kasan= code to common place
> >   mm/kasan: don't initialize kasan if it's disabled
> >   mm/kasan: make kasan=on|off take effect for all three modes
> > 
> >  arch/arm/mm/kasan_init.c               |  6 +++++
> >  arch/arm64/mm/kasan_init.c             |  7 ++++++
> >  arch/loongarch/mm/kasan_init.c         |  5 ++++
> >  arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
> >  arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
> >  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
> >  arch/riscv/mm/kasan_init.c             |  6 +++++
> >  arch/um/kernel/mem.c                   |  6 +++++
> >  arch/x86/mm/kasan_init_64.c            |  6 +++++
> >  arch/xtensa/mm/kasan_init.c            |  6 +++++
> >  include/linux/kasan-enabled.h          | 11 ++------
> >  mm/kasan/common.c                      | 27 ++++++++++++++++++++
> >  mm/kasan/generic.c                     | 20 +++++++++++++--
> >  mm/kasan/hw_tags.c                     | 35 ++------------------------
> >  mm/kasan/init.c                        |  6 +++++
> >  mm/kasan/quarantine.c                  |  3 +++
> >  mm/kasan/shadow.c                      | 23 ++++++++++++++++-
> >  mm/kasan/sw_tags.c                     |  9 +++++++
> >  18 files changed, 150 insertions(+), 46 deletions(-)
> > 
> 


