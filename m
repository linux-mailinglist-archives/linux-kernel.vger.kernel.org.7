Return-Path: <linux-kernel+bounces-767395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B282EB253C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83324563077
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C62287263;
	Wed, 13 Aug 2025 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgJyvo3N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7235C96
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112572; cv=none; b=qu1OB948ZtEn4YmQDfzOK8oZq+BgeJolYdr/ZaxFBs1FoY17ar3ACd7GTjSFg3KpKXV1GzShYLGmwmvbKKGzVrEoearY5376ji3D7RBvR7i/WlFXjH5DzRMcGgBLZN7eOW9BuinAepD1/Ei3HGZFSpIlS+HtzNzBLrcX0dAfRqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112572; c=relaxed/simple;
	bh=QboUJ29IRDixW0ZIXd4g4oEsNblPutlyvSFIgkKhXn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+XYhhzeSn244ercmlx1efHyxyNRVQeDvouolik8lCTZthmNMyozzLJ4kJBiF9G9nr1m2k0AbH8gsVolesJhQ9wa6uQIRByqJKDh+/IInCPyb4infARa6AhJHqxw6C4ms1bY3vtNFuXq5WTU7gpUO0rL1/dzZm8s1pyHfQUhA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgJyvo3N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755112570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QboUJ29IRDixW0ZIXd4g4oEsNblPutlyvSFIgkKhXn8=;
	b=PgJyvo3NngE+5zIj7HUYOYWxWuD5bhMLWwavk7zQn6TRmgOg9/PjMPMFo/Vh4ovIumEDFk
	y/ocTzg0y6WmokjnbhsMrTtta4PH9BSfX2hROO85sAsUdyK8dGRUsWzgkPto2AuaAG3SuS
	5VM6+jPDNhjk2aNp4QPDI/1xKpZHalQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-071B5LX5PnKDqw2As-AtdA-1; Wed,
 13 Aug 2025 15:16:06 -0400
X-MC-Unique: 071B5LX5PnKDqw2As-AtdA-1
X-Mimecast-MFC-AGG-ID: 071B5LX5PnKDqw2As-AtdA_1755112564
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 754D51800280;
	Wed, 13 Aug 2025 19:16:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E7DBE3001452;
	Wed, 13 Aug 2025 19:15:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 13 Aug 2025 21:14:47 +0200 (CEST)
Date: Wed, 13 Aug 2025 21:14:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PF_USER_WORKERs and shadow stack
Message-ID: <20250813191441.GA26754@redhat.com>
References: <20250813162824.GA15234@redhat.com>
 <a4cb5e3e-717e-4a86-9e15-5b14ef322314@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4cb5e3e-717e-4a86-9e15-5b14ef322314@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/13, Dave Hansen wrote:
>
> On 8/13/25 09:28, Oleg Nesterov wrote:
> > But it seems that if a features_enabled(ARCH_SHSTK_SHSTK) thread creates a
> > PF_USER_WORKER thread, shstk_alloc_thread_stack() will allocate the shadow
> > stack for no reason.
>
> Is this costing us anything other than some CPU cycles and 160 bytes of
> memory for a VMA?

Well, I guess no, but I do have another reason for "something-like-this" cleanup.
I am working on other changes which should eliminate x86_task_fpu(PF_USER_WORKER).
Hopefully I'll send the patches tomorrow. To remind, see
https://lore.kernel.org/all/20250812125700.GA11290@redhat.com/

So I'd like to ensure that ssp_active() can't return T in ssp_get().


And... Dave, I understand that it is very easy to criticize someone else's code ;)
But - if I am right - the current logic doesn't look clean to me. Regardless.

Oleg.


