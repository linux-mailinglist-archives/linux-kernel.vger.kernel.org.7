Return-Path: <linux-kernel+bounces-744425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189DCB10CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16335C1F86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F22E0B5B;
	Thu, 24 Jul 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGzcmNn9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E872DE1ED
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365603; cv=none; b=GdkQFr+FfsiGR7C484wuaoGU2r63JsuS1kx2LCr4e9pOWVsn5mmqxewaX3nC20/LNSXTBn0ZYFb/o0+8xSmGCz93hcDmV3du1UJG9f70y3lCB4KiTSB4midsHkqLe/hScKlc+tiZhbwrxbesxNi9dZIjkVBaAJWLnziadXXyh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365603; c=relaxed/simple;
	bh=xQW6e/hiMRQN3KwSxGOLYMZOFKiVIrO7GBXKHG+2Wak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJiXsAWgtb8n6qY37csHdoBxLNBv6CBGjsClm0vMn92kacRAldhugsdY7LBOHCXXc9khOEWn1E6hVBVxY7fz74/phrO68QreFVbcNsSaJtaaz8/3Du4K8uXX94XjDNmS2dc999Wc4FJ3AHiPkqUFlKtpCMwi6SKH6O624O0MUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGzcmNn9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753365600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kirBcfhX9IV08ytwc8VWswDQbESP/IVGY+pas3s6wR8=;
	b=JGzcmNn98t2UIXbu41sYOZKIHGD8bSY0AmhT12zTIYU9sRThBWIo9iqM+yp0EFvY4ZJpy0
	qpf8acqP1wpaHSfavPlrGIKKnE2taa5NftnJWZ5OzjprZdiOUwDbf0Swt9In7pSUy84VTr
	qAwdl/FhwRkj4r8RWkxb42shwmzN1pM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-PnS_gXsJOKmbM9xipSquNA-1; Thu,
 24 Jul 2025 09:59:55 -0400
X-MC-Unique: PnS_gXsJOKmbM9xipSquNA-1
X-Mimecast-MFC-AGG-ID: PnS_gXsJOKmbM9xipSquNA_1753365593
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D214E19560A3;
	Thu, 24 Jul 2025 13:59:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.245])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 122DB18003FC;
	Thu, 24 Jul 2025 13:59:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 24 Jul 2025 15:58:46 +0200 (CEST)
Date: Thu, 24 Jul 2025 15:58:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Li,Rongqing" <lirongqing@baidu.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250724135840.GA19593@redhat.com>
References: <20250721192053.58843751@pumpkin>
 <20250722105034.GA2845@redhat.com>
 <20250722130947.0c97c96a@pumpkin>
 <20250722132147.GB2845@redhat.com>
 <20250722230341.5a1cc5e5@pumpkin>
 <20250723093825.GA12884@redhat.com>
 <20250723224831.4492ec75@pumpkin>
 <20250724081125.GA10980@redhat.com>
 <20250724082547.GB10980@redhat.com>
 <20250724130037.1ae77797@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724130037.1ae77797@pumpkin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/24, David Laight wrote:
>
> On Thu, 24 Jul 2025 10:25:48 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > --- a/arch/x86/mm/extable.c
> > +++ b/arch/x86/mm/extable.c
> > @@ -38,6 +38,9 @@ static bool ex_handler_default(const struct exception_table_entry *e,
> >  	if (e->data & EX_FLAG_CLEAR_DX)
> >  		regs->dx = 0;
> >
> > +	if (e->data & EX_FLAG_XXX_AX)
> > +		regs->ax = -1ul;
>
> That would need to set %eax to a 64bit ~0u;
> I don't think the above would sign extend the value.

Hmm... could you spell please?

pt_regs->ax is always 'unsigned long', regardless of bitness...

> Makes me think - always bad.
> I wonder how hard it would be to implement EX_FLAG_WARN_ONCE.
> Mostly it would need a writeable bitmap with one bit for each
> extable entry.

Would be nice... But who else will use this feature ? ;) I mean, it needs
some justification.

Oleg.


