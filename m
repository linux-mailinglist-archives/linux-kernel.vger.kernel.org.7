Return-Path: <linux-kernel+bounces-778808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9716CB2EB63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529B6687FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37531253F03;
	Thu, 21 Aug 2025 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+Q/t+/8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62A241136
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744209; cv=none; b=jqcEtSPR6iEpecnIaAl605nDX5BpKMlXmGioZYx6/SA3O0FxDE/m3+LkoQpRG8K3D0DetDaP26BKDR1NAvXWieTtNAQZ31+JxnS9RhCTkIK+Qj4cBdRzlymZwlhpflfSi9tu0itNcn17GCSxQ04V3D4iyUsUsAhE3A/ptgEBNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744209; c=relaxed/simple;
	bh=GJ1Z8Vp5EdDKUAhSExbbjqSpdbo++va1XTaXtbhy6Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3NIn5SUk8ckZ1071CWP983b0WICruOyupfbiNHTUjC2aexqOrNAQbMu5HLLFTZArhHzJVhIZmOm6VXnxlerHlBlepzYikpIt6RnGz4J8dV/QA4NpGprc/hYla7w8SRgn9rTn8pbmenXiQWa3b6aOP3A7TIyj9Xn7nFRinwiS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+Q/t+/8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755744206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b8qT54c0ZICxodssvZk0IEbO+CpWQT3Dngc++Z4hkSY=;
	b=V+Q/t+/8G2vdybLQ9BhKNBNq4hAHJ6sdesWXR2eIO/1fF4cxeZq1f9jZ2BKE+X/EtUMh2+
	yEDEipSAi7+dRChD9mmMRS0WjfPG7keaUZQSAQqqMO9uSsJ4x5HScheWpqfWRWcPCQJBBQ
	zqGAYnfYrwei/gliZnlKWpDgWPib49U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-KsQQNM9wOAel1kmqlx-owA-1; Wed,
 20 Aug 2025 22:43:21 -0400
X-MC-Unique: KsQQNM9wOAel1kmqlx-owA-1
X-Mimecast-MFC-AGG-ID: KsQQNM9wOAel1kmqlx-owA_1755744200
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAE9B1800366;
	Thu, 21 Aug 2025 02:43:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9024A19560B0;
	Thu, 21 Aug 2025 02:43:16 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:43:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: pmladek@suse.com, akpm@linux-foundation.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
	joel.granados@kernel.org, john.ogness@linutronix.de,
	namcao@linutronix.de, sravankumarlpu@gmail.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH 3/9] crash_core: use panic_try_start() in crash_kexec()
Message-ID: <aKaHvnxEaXF/fLnW@MiWiFi-R3L-srv>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820091702.512524-4-wangjinchao600@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/20/25 at 05:14pm, Jinchao Wang wrote:
> crash_kexec() had its own code to exclude
> parallel execution by setting panic_cpu.
> This is already handled by panic_try_start().
> 
> Switch to panic_try_start() to remove the
> duplication and keep the logic consistent.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

I had to use b4 to grab back the whole patchset, but I can't comment on
other patches, especially the patch 1. 

Firstly, this series looks interesting. It does enhance code
readibility. But I am a vim user, I like open code on this one line of
code wrapping. So leave this to other reviewers to decide if this should
be accepted.

Secondly, the lines of your patch log are too short, it's not convenient
for reading. Can you set your mail writer to change this.

Thirdly, please add people to CC in all patches. I don't know why you
only CC me in patch 3 if the whole patchset is related to crash and
panic.

Thanks
Baoquan

> ---
>  kernel/crash_core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index a4ef79591eb2..bb38bbaf3a26 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
>   */
>  
> +#include "linux/panic.h"
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/buildid.h>
> @@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
>  
>  __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>  {
> -	int old_cpu, this_cpu;
> -
> -	/*
> -	 * Only one CPU is allowed to execute the crash_kexec() code as with
> -	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> -	 * may stop each other.  To exclude them, we use panic_cpu here too.
> -	 */
> -	old_cpu = PANIC_CPU_INVALID;
> -	this_cpu = raw_smp_processor_id();
> -
> -	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
> +	if (panic_try_start()) {
>  		/* This is the 1st CPU which comes here, so go ahead. */
>  		__crash_kexec(regs);
>  
> @@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>  		 * Reset panic_cpu to allow another panic()/crash_kexec()
>  		 * call.
>  		 */
> -		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
> +		panic_reset();
>  	}
>  }
>  
> -- 
> 2.43.0
> 


