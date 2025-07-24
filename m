Return-Path: <linux-kernel+bounces-744163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5AB108DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273203A6548
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9C248864;
	Thu, 24 Jul 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlzUEluG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8726CE0C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355751; cv=none; b=JM/vgKACGARbc4ZFKfLNaDfel1DFCJJmHEWcAbUmCkDHyB+HlwYCCe0ITBfPU0MvkGTE1pwBkWLa1GA1ISU55w5m5eBM952liFuOgHi0TKlgv682ge6LUuvGlZKG53O0hCL3fZvzjNM+XaHrrAmI2724q98n7/4NforbLD9nLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355751; c=relaxed/simple;
	bh=uvCpkW4iF77kZlET6ktb164OMy+EtCsM9rcm+HA79yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=armldX2cx7zSK0CQ9UCRi5UT+lqdFc0I1V/Olt2j9oqW4xEm3Y6rTxYuXMNp3KX5ucu9/nn0Y/3VDpdoj+StlLcJ1Q3cU7ELZ6PKcdaQmfgPGtGK18PNNelYddlFGX/wgDhWGcIa1wY5q+Z66jQMQ6d4tjU2WmQmfJ+2cc4CX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlzUEluG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753355748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8J4cbS3fMYr9VOkIAjyd351Fdlt7vNTZHyqYakBhuB0=;
	b=NlzUEluG7JokYr1DJXT75A8zGsu/aU7EM1djMxCmJBuZB09ObZutVo0g62Tjp8nPqM9PKY
	ChzDZcYRQhfBKFD5gShs3gJF3jzgkeou6ugzur/ZVzLdVZEQYLcWkRc8Wt8Hd5G1+7Xecn
	32kJ+coFEKVe7J9Cv2y2SUEeHkH1Kxg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-dToQx3PBM1yiSLMkWs6L5A-1; Thu,
 24 Jul 2025 07:15:42 -0400
X-MC-Unique: dToQx3PBM1yiSLMkWs6L5A-1
X-Mimecast-MFC-AGG-ID: dToQx3PBM1yiSLMkWs6L5A_1753355740
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 540C519560B5;
	Thu, 24 Jul 2025 11:15:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.245])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F2A65195608D;
	Thu, 24 Jul 2025 11:15:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 24 Jul 2025 13:14:32 +0200 (CEST)
Date: Thu, 24 Jul 2025 13:14:26 +0200
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
Message-ID: <20250724111426.GA15444@redhat.com>
References: <20250721130422.GA31640@redhat.com>
 <20250721192053.58843751@pumpkin>
 <20250722105034.GA2845@redhat.com>
 <20250722130947.0c97c96a@pumpkin>
 <20250722132147.GB2845@redhat.com>
 <20250722230341.5a1cc5e5@pumpkin>
 <20250723093825.GA12884@redhat.com>
 <20250723224831.4492ec75@pumpkin>
 <20250724081125.GA10980@redhat.com>
 <20250724082547.GB10980@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724082547.GB10980@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Finally. If we really want to optimize this function as much as possible,
we can add the CONFIG_CC_HAS_ASM_GOTO_OUTPUT version as Peter suggests.
I guess this should work:

	u64 test(u64 a, u64 mul, u64 div)
	{
		u64 q;

		asm goto ("mulq %2; 1: divq %3\n"
			_ASM_EXTABLE(1b, %l[fail])
			: "=a" (q)
			: "a" (a), "rm" (mul), "rm" (div)
			: "rdx"
			: fail);

		return q;
	fail:
		// BUG? WARN?
		return -1ul;
	}

I agree with everything ;)

Oleg.

On 07/24, Oleg Nesterov wrote:
>
> On 07/24, Oleg Nesterov wrote:
> > On 07/23, David Laight wrote:
> > >
> > > On Wed, 23 Jul 2025 11:38:25 +0200
> > > Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > to remove the conditional branch and additional variable. Your version
> > > > is probably beterr... But this is without WARN/BUG.
> > >
> > > I wish there was a way of doing a WARN_ONCE from asm with a single instruction.
> > > Then you could put one after your 2:
> > > Otherwise is it a conditional and a load of inlined code.
> > >
> > > > So, which version do you prefer?
> > >
> > > I wish I knew :-)
> >
> > ;-)
> >
> > David, you understand this asm magic indefinitely better than me. Plus you are
> > working on the generic code. Can you send the patch which looks right to you?
> > I agree in advance with anything you do.
> >
> > I got lost. Now I don't even understand if we want to add BUG and/or WARN into
> > mul_u64_u64_div_u64().
>
> Forgot to mention... Not that I think this is a good idea, but if we don't
> use BUG/WARN, we can probably add EX_FLAG_ and do something like below.
>
> Oleg.
>
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -38,6 +38,9 @@ static bool ex_handler_default(const struct exception_table_entry *e,
>  	if (e->data & EX_FLAG_CLEAR_DX)
>  		regs->dx = 0;
>
> +	if (e->data & EX_FLAG_XXX_AX)
> +		regs->ax = -1ul;
> +
>  	regs->ip = ex_fixup_addr(e);
>  	return true;
>  }


