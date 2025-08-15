Return-Path: <linux-kernel+bounces-771141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E80B28352
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06EA1887660
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B6308F2D;
	Fri, 15 Aug 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlA582lc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FDD308F10
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273230; cv=none; b=KKLeJ/WHJh2t9pV33wGsMXvucFoXRe5sCCzEW21uE9qLuddKPSbSeHfJ7TQIgiMLbE2Ac1VhGL1/tLj78nHfUXFiqluxcxVjjkyDpUNQk3fFz/Gg82R/67ecS7FciyUIFC5fRmFWYFVUdeK7Cg5y8URxZe0ohWEMsDMuaf9bGH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273230; c=relaxed/simple;
	bh=gqD7SU7h+xVAvW0IT3ZNJz9KQr11WGoV8KmETbPm2mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhPSnJnoKhD6QSsIoubgo/PZQsmJwQ9S+k/Ddl8C3Q+AzjK1WOotDCkpzG7rDqSdZax2OKT1E3KFh4ueR6h2VBYDu8pPWYSbaV1/CRkNMB13cCE7KJYCSFXVi+dqptBooJkitOyM8iMMPXZLc/GRdaDDT2gmCol27pmDIJYDoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlA582lc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755273227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OecSMFjrQyYkoOnaDbuyx/zIPtpsczdNnMN88HkBMt8=;
	b=MlA582lcqcQuUnJG50gh14doj/ibrmFlnqKHa5sXAifLOlUWb3f7Ka4LVj65Akg0uU7NpT
	34UVkuVNWZTJ+aBOXTHwhzDWu376fZ364RqKC6nLoZGf23Q1xOtcVDwVAokoIPJoQLTil0
	Yq3SRG7RvHTR/k3yvIStgdJ2hf0/r44=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-sjLHOPajP62l1GuK_YGW9A-1; Fri,
 15 Aug 2025 11:53:45 -0400
X-MC-Unique: sjLHOPajP62l1GuK_YGW9A-1
X-Mimecast-MFC-AGG-ID: sjLHOPajP62l1GuK_YGW9A_1755273223
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA80519560AF;
	Fri, 15 Aug 2025 15:53:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6B8E630001B5;
	Fri, 15 Aug 2025 15:53:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 17:52:26 +0200 (CEST)
Date: Fri, 15 Aug 2025 17:52:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER) in
 .regset_get() paths
Message-ID: <20250815155220.GA3702@redhat.com>
References: <20250814101340.GA17288@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814101340.GA17288@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Dave, Sohil, what do you think?

OK, it seems that 5/6 (and thus 6/6) needs more discussion, but what
about 1-3 for the start?

These changes simply shift x86_task_fpu() and sync_fpstate() from
.regset_get() paths into the single helper, get_fpstate(). To me this
makes sense...

Oleg.

On 08/14, Oleg Nesterov wrote:
>
> Sorry, I have no idea how to test these changes, please review. Especially
> 4/6 and 5/6, I don't really understand shstk.c.
>
> If you are fine with these changes, I'll try to update the fpregs_soft_get()
> and user_regset.set() paths as well.
>
> Oleg.
> ---
>
>  arch/x86/include/asm/shstk.h |  8 ++++----
>  arch/x86/kernel/fpu/regset.c | 46 ++++++++++++++++++++++++++------------------
>  arch/x86/kernel/fpu/xstate.c | 12 ++++++------
>  arch/x86/kernel/fpu/xstate.h |  4 ++--
>  arch/x86/kernel/process.c    |  2 +-
>  arch/x86/kernel/process_64.c |  2 +-
>  arch/x86/kernel/shstk.c      | 19 +++++++++++++-----
>  7 files changed, 55 insertions(+), 38 deletions(-)


