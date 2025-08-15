Return-Path: <linux-kernel+bounces-770911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD77EB28053
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079D7AE7EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C172FE066;
	Fri, 15 Aug 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah4EJONy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD42737FD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262977; cv=none; b=AvqBTb1UEHpHP+WSvihSAZctByBCc/2kGx86+gNkGT+mbOdIbBMf3/M4QhZqM+7aGgmv+FRZyCGkuc7QRGI1qqPjxj+HWIwD/9I9hRTJ1+zb42Hc5Cz22eR4M8Nk1hBi//UVG2iZNIvzPu1IZq4dhXBVMYov/cwa6/o4CT9jTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262977; c=relaxed/simple;
	bh=2qbZCeHo/q0ARCQqWP8WDesTq4zE7avYLQORLO2Zp1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJJTcy2v7dh6Kqjj31ILCqs6bc2PbBc8eRAXPXsuVcmbOYPskxoQHhd5eRNZPmDeGrQNkedP1UisDrg0aBXpL1o7PmPCC+hapTjCBmT8RZqUb1itETA+ZDJ0AMQusQ4okA3Nwz6KGUSQMBdmHX/A42R7Cy789AukdkxN6444NvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ah4EJONy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755262975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgRHsnf4AepMa57NL8zv+QF6SxJXzB5B6h+HiE996bw=;
	b=ah4EJONyub3LniWZlZRCA+kZ850RHEm0XrePKgliPCd0kvt586j5BcZEOUHrPavQxTTtAx
	CioQ2oNIl6bF3+DYf6jYKBXv0oOD3je4aitbNlVtNd1PKZeMMu2cqJki1bUnKPfPTdzPj2
	f5jxcEnghPtMFopuMAg26HORuqYJMWY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-wpk9pMfHP6m9Qm0RIXrykw-1; Fri,
 15 Aug 2025 09:02:51 -0400
X-MC-Unique: wpk9pMfHP6m9Qm0RIXrykw-1
X-Mimecast-MFC-AGG-ID: wpk9pMfHP6m9Qm0RIXrykw_1755262969
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1B071800286;
	Fri, 15 Aug 2025 13:02:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 15FC81955E89;
	Fri, 15 Aug 2025 13:02:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 15:01:32 +0200 (CEST)
Date: Fri, 15 Aug 2025 15:01:26 +0200
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
Message-ID: <20250815130125.GD11549@redhat.com>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/14, Mark Brown wrote:
>
> On Thu, Aug 14, 2025 at 05:03:36PM +0000, Edgecombe, Rick P wrote:
> > On Thu, 2025-08-14 at 12:14 +0200, Oleg Nesterov wrote:
>
> > > If a features_enabled(ARCH_SHSTK_SHSTK) userspace thread creates a
> > > PF_USER_WORKER thread, shstk_alloc_thread_stack() allocates the shadow
> > > stack for no reason, the new (kernel) thread will never return to usermode.
>
> > I agree we don't need to allocate a shadow stack in this case, but I'm not sure
> > it is right to fully disable shadow stack in thread.features. First of all,
> > disabling it from shstk_alloc_thread_stack() seems weird. It just handles
> > allocating shadow stacks.
>
> I agree that it's better to leave userspace shadow stacks enabled, given
> that the reason we're not allocating the shadow stack is that we don't
> expect to ever return to userspace then it should be fine to leave the
> feature turned on for userspace.  If we mess up and do somehow return to
> userspace

But a PF_USER_WORKER task can never return to userspace. It doesn't differ
from PF_KTHREAD in this respect.

Oleg.


