Return-Path: <linux-kernel+bounces-771124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C355BB28325
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC71C81D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA70C30749B;
	Fri, 15 Aug 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrrvFSjF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A821C18A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272683; cv=none; b=pObeMfsxUvvqcJ3vbkgdxaXj9tV9Tx7JKdThhIFB9WE7bv6bYTxlQ+XL1SVzUTQAPm8F8OHL4zlGfLk2zT86UHbiSOM5YQO87rJjOlvJk++DVSUkxt6l2hM0x8Tj4fHEOuOeS480WLWgEBYh7a+Qe9pgPwivrPbxJ1bkSY+bKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272683; c=relaxed/simple;
	bh=8sv8BoHbyse94b4XmO8DS05qUFZUjOytFd+ZdYJk9bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcPECYN5oXYVn5yMEcLtwX41BFefG4N0W46btZnStKBha0fqGMwYJMGItSqc88U1KWzhVPxp38bx+UTRzbta31FG6YKTfRPbZKkXeQXWyDCb6P7gd2rRFj1j6olP+PhQmtPiOYlxTwF0tFf/nBRlF+fPaA5HEsx3ruD41DOcrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrrvFSjF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755272680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbw40Hej2AYRZAalYk6Uw/CWMU/5i+7IQaCvtlPJ1Ms=;
	b=BrrvFSjF3vABl6ysdNYBzC2mQQBQemlid2N6i2cyvBFEsKWMl2l5PkesFKI4vS90Hm2+cE
	A4JJdA2A5Ze9wjXjEgrIcBK/wxbcpXDSEGQhHS84E84hlzp3ziHWg2uREHp4aByY267zdF
	wkBsgkU29xlC/Rwzwhez/EO80UbZE5o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-3hZ1pwxpMSeTUja2It5zUg-1; Fri,
 15 Aug 2025 11:44:37 -0400
X-MC-Unique: 3hZ1pwxpMSeTUja2It5zUg-1
X-Mimecast-MFC-AGG-ID: 3hZ1pwxpMSeTUja2It5zUg_1755272675
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 576611944DE0;
	Fri, 15 Aug 2025 15:44:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D658B19A4D43;
	Fri, 15 Aug 2025 15:44:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 17:43:18 +0200 (CEST)
Date: Fri, 15 Aug 2025 17:43:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250815154311.GG11549@redhat.com>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
 <20250815130125.GD11549@redhat.com>
 <20250815130851.GE11549@redhat.com>
 <f1a8da89-7522-429e-a4ba-4794222f1541@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a8da89-7522-429e-a4ba-4794222f1541@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/15, Mark Brown wrote:
>
> On Fri, Aug 15, 2025 at 03:08:52PM +0200, Oleg Nesterov wrote:
> > On 08/15, Oleg Nesterov wrote:
> > > On 08/14, Mark Brown wrote:
>
> > > > I agree that it's better to leave userspace shadow stacks enabled, given
> > > > that the reason we're not allocating the shadow stack is that we don't
> > > > expect to ever return to userspace then it should be fine to leave the
> > > > feature turned on for userspace.  If we mess up and do somehow return to
> > > > userspace
>
> > > But a PF_USER_WORKER task can never return to userspace. It doesn't differ
> > > from PF_KTHREAD in this respect.
>
> > ... of course unless it does exec.
>
> Sure, but OTOH at least for arm64 there's no cost to leaving the feature
> enabled unless you actually execute userspace code so if we never return
> to userspace writing the code to disable isn't really buying us anything.

The fact that a kernel thread can have the pointless ARCH_SHSTK_SHSTK is
the only reason I know why x86_task_fpu(PF_USER_WORKER) has to work.

I'd like to make this logic consistent with PF_KTHREAD, and in the longer
term change the x86 FPU code so that the kernel threads can run without
without "struct fpu" attached to task_struct.

Again, please see
https://lore.kernel.org/all/20250813191441.GA26754@redhat.com/

Oleg.


