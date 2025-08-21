Return-Path: <linux-kernel+bounces-779315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46CB2F285
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD7188664E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1C2EA755;
	Thu, 21 Aug 2025 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enVuY8+7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17156277CB4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765226; cv=none; b=PmRDWmN36aKnHecx7YzuKulKVIHGu2HFzSl1KyUq8V4H3AfR6kFUUK3L2QzHPEnEaQbBUpDJVtFJ6pM9z8ahXPyCojprt0PDtNlsJp04b1KT0tsvoqu+s8CzOOyvRJoKa3kIhwJd5VeBr3Xn9MX2gZGGEUBtjphnpAuII/A9O2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765226; c=relaxed/simple;
	bh=dUiKgRAI3A9prYuCnQ9p9wAtGjplO7hUq0Q2if+VdEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1fUaDB2X2aCc6/coYMGX8ycYAit8l5uVZup0QcfXMG40oePEL8gA7X8zvvrVS6XJfx2IEykiIsYjpGP3Wq6FSdnn8RB/xgWFmudzANLce0Bun1/A4vR11S43Poc8qULMiCKCPNdsQBs742C5l7YwWZBuBpS5RDKPMSDO2sGGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=enVuY8+7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755765221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHkbj41Kh3yJaLj8nTXZWWFLEJs9EarVkmAtxTUg4F8=;
	b=enVuY8+7GWHqah6VuIrStl6NIETfJNgJg6lk1WLO8mj1BMAS/crPRoOcrd69+QSXHbmbd3
	C3sS1cREc7LI9jS3tf799zrrbMt8as4B5muwmD3a2Lr3RrkYQzG26cnUyNwZAC3CwJpR/F
	JkgEEqGrWn1mGkTa/iIiGSgrlPttd7s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-W112auD0NF6QiV5OPsKlWA-1; Thu,
 21 Aug 2025 04:33:37 -0400
X-MC-Unique: W112auD0NF6QiV5OPsKlWA-1
X-Mimecast-MFC-AGG-ID: W112auD0NF6QiV5OPsKlWA_1755765215
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A25D019560B2;
	Thu, 21 Aug 2025 08:33:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E6BE180029D;
	Thu, 21 Aug 2025 08:33:32 +0000 (UTC)
Date: Thu, 21 Aug 2025 16:33:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>, Brian Mak <makb@juniper.net>
Cc: Dave Young <dyoung@redhat.com>, Alexander Graf <graf@amazon.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, x86@kernel.org,
	kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Message-ID: <aKbZ1h5mjtfoFMh8@MiWiFi-R3L-srv>
References: <20250805211527.122367-1-makb@juniper.net>
 <20250805211527.122367-2-makb@juniper.net>
 <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/20/25 at 09:47pm, Andrew Morton wrote:
> On Tue, 5 Aug 2025 14:15:26 -0700 Brian Mak <makb@juniper.net> wrote:
> 
> > Commit 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > introduces logic to use CMA-based allocation in kexec by default. As
> > part of the changes, it introduces a kexec_file_load flag to disable the
> > use of CMA allocations from userspace. However, this flag is broken
> > since it is missing from the list of legal flags for kexec_file_load.
> > kexec_file_load returns EINVAL when attempting to use the flag.
> > 
> > Fix this by adding the KEXEC_FILE_NO_CMA flag to the list of legal flags
> > for kexec_file_load.
> > 
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> 
> A description of the userspace-visible runtime effects of this bug
> would be very helpful, please.  A lot more than "is broken"!
> 
> Also, could we please have some reviewer input on this change?

I didn't receive this patchset, and kexec mailing list is not in CC.
I don't know what happened.

> 
> 
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -460,7 +460,8 @@ bool kexec_load_permitted(int kexec_image_type);
> >  
> >  /* List of defined/legal kexec file flags */
> >  #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
> > -				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG)
> > +				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
> > +				 KEXEC_FILE_NO_CMA)
> >  
> >  /* flag to track if kexec reboot is in progress */
> >  extern bool kexec_in_progress;
> > -- 
> > 2.25.1
> > 
> 


