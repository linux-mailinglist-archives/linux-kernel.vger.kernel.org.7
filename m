Return-Path: <linux-kernel+bounces-760454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FD5B1EB5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2703587D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371C4283121;
	Fri,  8 Aug 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1mBZUvH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888E2820CB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665997; cv=none; b=mYgSkbDoEycnxLXBZLaXlPrFAdUd0pb99dEVkRawZoVJ5Z9hnJ6Rd9joav7DfsX2dnne+ksrxWl5A2p2KTuhLN8YX9Ut2HMeCdrI8TWxIHcn9nRymFTNqYvz6CtI8vagZjulWvMEeIp+ot+QivjBvENFkiIrISwRPLkbd5h5MD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665997; c=relaxed/simple;
	bh=6P4GgRnln8aRFg83nZMaESb68F5Hmi4XlvG+BP2xtB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMDMJfs2zdx6hZEGfszVJF7BL9Dw1h/ckPBf/9xZKNFk87FfmsRMmluz6vOHYQLCdB2/7P1QUQ91TK0n/Wn6C18yiZlDVgHb3ztRbIyGQjaoyi0l+0ZV88em20lXTvi0KvbNnrO9HJYb914hJ/ZthhYa6qTwsPi0VhJ8ANlPg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1mBZUvH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97724RcLp1B6Jsq66dWqemQKOPJIc3oWihoZILL2Kxk=;
	b=X1mBZUvHSzdcTCf72fmfYKJZZsTuK3eN28jl2QSHe0Aa+0rRt2eifUvjlen9KTIbWAfUFn
	WBS6G7udIO8/cXRXLFPBnxdAkFOlw1hHtubGdm6hcoIFT4PaS47BPLA+Jl5wEgfnc0PrTM
	trYw5bsFXIoIQZER0/g/5gHS6nOvbPg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-LM7UDeIMP4iUZ7ECAgQa6A-1; Fri,
 08 Aug 2025 11:13:10 -0400
X-MC-Unique: LM7UDeIMP4iUZ7ECAgQa6A-1
X-Mimecast-MFC-AGG-ID: LM7UDeIMP4iUZ7ECAgQa6A_1754665986
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A25C21888B2B;
	Fri,  8 Aug 2025 15:12:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C710F19560AD;
	Fri,  8 Aug 2025 15:12:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  8 Aug 2025 17:11:42 +0200 (CEST)
Date: Fri, 8 Aug 2025 17:11:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Brian Gerst <brgerst@gmail.com>, Eric Biggers <ebiggers@google.com>,
	Kees Cook <kees@kernel.org>, Chao Gao <chao.gao@intel.com>,
	Fushuai Wang <wangfushuai@baidu.com>, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: Re: [PATCH v3 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
Message-ID: <20250808151131.GD21685@redhat.com>
References: <20250724013422.307954-1-sohil.mehta@intel.com>
 <20250724013422.307954-2-sohil.mehta@intel.com>
 <aJVuZZgYjEMxiUYq@ly-workstation>
 <20250808074948.GA29612@redhat.com>
 <e46bab92-ee1f-478f-8076-d46bd3fe9411@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e46bab92-ee1f-478f-8076-d46bd3fe9411@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/08, Sohil Mehta wrote:
>
> On 8/8/2025 12:49 AM, Oleg Nesterov wrote:
> > On 08/08, Lai, Yi wrote:
> >>
> >> [   17.474769] WARNING: CPU: 1 PID: 731 at arch/x86/kernel/fpu/core.c:61 x86_task_fpu+0x76/0x90
> >
> > ...
> >
> >> [   17.481244]  xfpregs_get+0x9c/0x1e0
> >
> > ...
> >
> >> [   17.485304]  do_coredump+0x370e/0x5060
> >
>
> The warning here is mostly benign, right?
>
> x86_task_fpu(target) and x86_task_fpu(current) wouldn't match, causing
> sync_fpstate() to return early.

Sorry, I am not sure I understand...

I only meant that the PF_USER_WORKER check in x86_task_fpu() is not
correct right now.

> However, independent of this warning, can xfpregs_get()->sync_fpstate()
> be called in the context of the PF_USER_WORKER thread?

Probably not but I need to recheck.

> Yeah, I am wondering whether treating PF_USER_WORKER threads as
> equivalent to PF_KTHREAD is truly accurate in the FPU.

I think it is more or less equivalent but needs some work. In fact
I was thinking about it a long ago, see
https://lore.kernel.org/all/20240606120038.GB22450@redhat.com/

I'll try to do something next week.

Oleg.


