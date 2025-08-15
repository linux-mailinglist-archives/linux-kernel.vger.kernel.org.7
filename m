Return-Path: <linux-kernel+bounces-771399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F32BB2867A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6811CC74CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3B236A70;
	Fri, 15 Aug 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADFcpKg5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4B1F7060
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286644; cv=none; b=Ma/4ORU2xlWiC21HxIP/MiZalOJh7P6LUzIMRE1LCzzE6H9UTQjVBAizaVe9Xq4S4JM0gIKEnMejKVDcPOEU6mVqGAO/w9irYY07UPvTzAzfobZnaQp6ebsmwmD/JXkjpBSISyggrEmpynf26HyQnuIjCjOuJXZr2zhohnkQ9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286644; c=relaxed/simple;
	bh=AK98bkrpqFt4OfDNBMsHWWDhylCwiMpM9bjCjP2Z6zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJeDP4qnlqWzhgnq5HSCazvHcR+1WblG2KJt7xGGFnGjKaTDh8JPyu1/XFsPTT3PNCa8j/f0CQwVJL9TILbzNnahwBiPIZPl8DOMvUR/Xh5c061zTZNW5nUxhdI1IMS2fXndNbfXT4ziwifFCbqZNyzrhf64N/nbigH9hPDAjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADFcpKg5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755286642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H96GI6djMvVb8TH4JMsUd14X4hoGq4qLp4EIWA1iANo=;
	b=ADFcpKg5ksL2P3cHFn09Rf2w5tvdUhuK8iL4neWOZseQEnOeut0jxuLELoGtz3z4yRIk9L
	M5BvLfd48IN4ZT2dHhBGgnz8+tCFqBEvXWhHd5O+xq+VA88/DmSUemya4h7dMDtLKS7Jfu
	WYhhLNrTKr2WLPb541E6cbyNf6wgADI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-N1yFTERAMdmWmh5uam9UdA-1; Fri,
 15 Aug 2025 15:35:25 -0400
X-MC-Unique: N1yFTERAMdmWmh5uam9UdA-1
X-Mimecast-MFC-AGG-ID: N1yFTERAMdmWmh5uam9UdA_1755286523
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3613C195608E;
	Fri, 15 Aug 2025 19:35:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B5A4B180044F;
	Fri, 15 Aug 2025 19:35:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 21:34:05 +0200 (CEST)
Date: Fri, 15 Aug 2025 21:33:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER) in
 .regset_get() paths
Message-ID: <20250815193356.GL11549@redhat.com>
References: <20250814101340.GA17288@redhat.com>
 <20250815155220.GA3702@redhat.com>
 <d74b6f8b-2662-47f4-8221-2d2e6e7fe580@intel.com>
 <20250815160244.GI11549@redhat.com>
 <f8aaa8a3-e4aa-4958-a147-9a40385ebd8d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8aaa8a3-e4aa-4958-a147-9a40385ebd8d@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/15, Sohil Mehta wrote:
>
> I think it would be useful to categorize the impact of the "abuse" in
> the cover letter.

Yes, let me repeat that this is my fault.

>Is it going to cause kernel crashes, userspace crashes
> or just incorrect reporting?

Heh ;)

In the short term, I'd like to make your patch correct ;)

	[PATCH v3 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
	https://lore.kernel.org/all/20250724013422.307954-2-sohil.mehta@intel.com/

(just in case, no, this series alone is not enough).

In the longer term, rightly or not I'd like to do other changes we have already
discussed. See my other emails in this thread.

Oleg.


