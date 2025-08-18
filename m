Return-Path: <linux-kernel+bounces-773588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B0BB2A1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36C162003C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC627B355;
	Mon, 18 Aug 2025 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT4IjK8Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FB3218CC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520834; cv=none; b=ZZO6JyECCN+Rh5jLCUy7SMe28ESyvHzsL6VmIdhbKi0E8GuXGqxXRiojN54mQYHnbK7lcOkap/0DOI2ePK9gRX8M+Mwnf9ivNoar2w+HovCAA/JB3pWoLcl4kKarFx8wSfzv9/68BSixzfFbJ6KEH3bsSJ+kilKtCgmDFc3FHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520834; c=relaxed/simple;
	bh=ENhkK+xGbDwLOaFQa9/K3YzTFBXZHG2lcLkf8U7OY9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEDR6q6IyJlUL7z/1JULhmIXsIS1LOXuAljERWXMBwu3P9nXkekWW526IbKezSi4cCHA9nF+ND8pSIqJ469FQQZ97CpSLErN0dybJvz8GAFgzhrdcywrs17rLxkMLeAdRGoluczhD4uCgc2EdM4BmpsHQ49T8yisoDHE7wRTltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bT4IjK8Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755520832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FPgjCYbBQ3o35yfUqnUlwAHknTH8U5Krzrh1HruHa8o=;
	b=bT4IjK8ZgRs0E4aX0Jbplo58HCPnT0sKtDWibT+4RYHqSBCEXql4IVv2Ua9Ie9+CbJxhc1
	lyIfrtwTEl5K1lm3fgV3uOq7KKexT1XvOIX61rt5MrbaZPQUdsZZ93vShJVFmsoj6wOyBD
	eNi9vHmkRPPHTmoV7lVkkCrn60nNf2k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-5Zs9xW6NPRyHF2ZyLa7sqA-1; Mon,
 18 Aug 2025 08:40:28 -0400
X-MC-Unique: 5Zs9xW6NPRyHF2ZyLa7sqA-1
X-Mimecast-MFC-AGG-ID: 5Zs9xW6NPRyHF2ZyLa7sqA_1755520826
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92F931800291;
	Mon, 18 Aug 2025 12:40:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0C26A195419F;
	Mon, 18 Aug 2025 12:40:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 18 Aug 2025 14:39:07 +0200 (CEST)
Date: Mon, 18 Aug 2025 14:39:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Li RongQing <lirongqing@baidu.com>, Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250818123900.GB18626@redhat.com>
References: <20250815164009.GA11676@redhat.com>
 <20250817140726.223f8f72@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817140726.223f8f72@pumpkin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

David,

We had a lengthy discussion and you have already acked this fix.

I thought that we agreed on that a) we need to fix the problem first
and b) x86 version should be consistent with the generic implementation
regarding ~0ull on overflow.

Can we finally merge this fix, then discuss the possible improvements
and possibly change both implementation?

Oleg.

On 08/17, David Laight wrote:
>
> On Fri, 15 Aug 2025 18:40:09 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> One of my 'idea patches' is to make mul_u64_u64_div_u64() a wrapper for
> another function that takes in extra 'int *overflowed' parameter that is
> set zero/non-zero for success/overflow.
> The 'overflowed' parameter can either be a compile-time NULL or a
> valid pointer.
>
> So the x86-x64 asm implementation would use different code - you need
> the 'jump around fail label' to write the ~0 return value to *overflowed.
> The extra pointer check in the C version normal path may not be worth
> worrying about (but the '*overflow = 0' could easily be inlined).
>
> The typical use would be:
> 	quotient = mul_u64_u64_div_u64_overflow(..., &overflowed);
> 	if (quotient == ~0ull && overflowed)
> 		...
> That will generate better code than returning 'overflowed' and the
> quotient by reference.
>
> Although I wonder how often ~0ull is a valid result?
>
> 	David
>


