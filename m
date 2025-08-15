Return-Path: <linux-kernel+bounces-770881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15698B27FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F961CE4B64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAAE2C3264;
	Fri, 15 Aug 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzrLwjrk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E12882A2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260317; cv=none; b=ryu5GNb5tySpULEtdvNiJ5sLY5Pa6e14GMD/ljr/U4L1UxR+0kzVXh8oFy64dClKB4KRWZtwUSxLs/e7GYJRzVWdadD5RzLSxtm16Yn3xRPhizXlqfXo9OBt4dSed54kGKu3F7+LmIeTEz9O7l5YB8Ai+rcjX+QWQVH8nwyVfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260317; c=relaxed/simple;
	bh=2pbdFf3eNQVNnt0LJGJGPrFrWZOoJReCjFnHhKFwIC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O91/8FnHO6fK+Pj/Xqzbf0OmwFsOgdrl5NSAjrCy95id+YmVckLNQgUKoGA5UOOfff3Aog6F2qvZs9zlvS5C0+fgVkUJ5pC82r+wlHPcxtMWUsjhV+Vp1cZyzl9MPcb0C09EoFQPtYeGDqsbG1erlVVcc5m2hezVVmYynzY2kEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzrLwjrk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755260314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/sp5KatZqeUXYYHTpDeGE7G/Qj7GS1ifZdsWbzu2Lg=;
	b=VzrLwjrkFR9nLSAevdIlZ4qjUi8zyTrYFQonEB8M9bucz5rWbAkJGPj3KxL6PFzYtLHtFu
	Rx0U9tFDDeB7124OgRnVZTmBRdCOUCgTRZoaYJHLCLLoOr4rD5ofNrNqV5lPiyLjLI2lcq
	LnE830J/gh2UByalP42Cub6ltRuY4bo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-DnMuRJ1LP9yLqCBFUKR-Fg-1; Fri,
 15 Aug 2025 08:18:30 -0400
X-MC-Unique: DnMuRJ1LP9yLqCBFUKR-Fg-1
X-Mimecast-MFC-AGG-ID: DnMuRJ1LP9yLqCBFUKR-Fg_1755260308
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EA991800285;
	Fri, 15 Aug 2025 12:18:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7CDB81800447;
	Fri, 15 Aug 2025 12:18:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 14:17:10 +0200 (CEST)
Date: Fri, 15 Aug 2025 14:17:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250815121702.GB11549@redhat.com>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/14, Edgecombe, Rick P wrote:
>
> +Mark and Deepak
>
> On Thu, 2025-08-14 at 12:14 +0200, Oleg Nesterov wrote:
> > If a features_enabled(ARCH_SHSTK_SHSTK) userspace thread creates a
> > PF_USER_WORKER thread, shstk_alloc_thread_stack() allocates the shadow
> > stack for no reason, the new (kernel) thread will never return to usermode.
> >
> > Plus the current code doesn't even look correct, in this case fpu_clone()
> > won't call update_fpu_shstk().

...

> I agree we don't need to allocate a shadow stack in this case,

Great,

> but I'm not sure
> it is right to fully disable shadow stack in thread.features.

Why?

> First of all,
> disabling it from shstk_alloc_thread_stack() seems weird. It just handles
> allocating shadow stacks.

I agree in advance with any other change.

> Lastly, it doesn't seem there is any way to clone from IO uring today,

Not sure I understand... create_io_thread() ?

> How about just adding the 'minimal' condition to:
> 	if (clone_flags & CLONE_VFORK) {
> 		shstk->base = 0;
> 		shstk->size = 0;
> 		return 0;
> 	}
> ...then update all the comments where vfork is called out as the only case that
> does this?

but create_io_thread() and vhost_task_create() do not use CLONE_VFORK?

Oleg.


