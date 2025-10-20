Return-Path: <linux-kernel+bounces-863427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A4BF7D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521AB18C86EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8334C129;
	Tue, 21 Oct 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I1+iMOiD"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95534B67F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067141; cv=none; b=aCbFQwiHnZlhdQv4Mmzbj1UuE24Rw7ZtQA8aWeC/9ZW0e5KXM2lZ95+GdLRKh++QNIjM9PyS3NLb2XszphB95CpdI93x6gYxZ5PwnMaGm0CKKSYzSQl3uMRgWOxZrBqBWzU7zaAsW89K1sm8w2f0stZq+XQDAinpWbAuGsa9CZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067141; c=relaxed/simple;
	bh=KTI+1i+kQoBL6h4/QRdZZT2Em5NJXpLQw9d9EFi/35M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZieJrG/o/BrHrziqJRyRSsI3QkmB7cufyl8qfnc6MwYAXMkWB3OWY5WRC25XBtQld8zQpqOvZvzNxen2Wk4U5h8VbpbMCezP7OlvPS52ODV8OOVACCg+hTXxkV7Mf8qmpt1J/k5o+ZiAn81Ga713PZMmiFbosySYG7olyn1g6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I1+iMOiD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cZj7pUjrTuI9hZQdWp1KopywL9YiwuGXVNDYcWC9r+w=; b=I1+iMOiDi44QD2FCJGX87VlCm+
	mdMvxf3Q3RftftAJ8Eh5fPFHRAESAvZ/mL2SNTXUmHMY0avIpAy7Kr6OAaTipvLvF7TJicp+qhtoD
	o72ifUtfVfs3H1MqILK/X39L+VwQyKD4e/xYR19Pb/+zVKPFIPfYpi/qHGlILr4/m8tOxKn46SxcO
	qUsSwX7fXcaxgZ7/2xnDEV72YlaUDnXVPmsC+WlIRiw8qIf5OBqa1a9Auk12WlbHXl6cVN1QyY/1V
	XvVhQNTLyfbYIFciA6OeutcnPTSG+ffn7EuVH24PlgBl6nIZFDNQrxdG8mNUsl9+AAxmuTTCDJaR4
	6NAQC9Kg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0d-0000000DsXe-1PBX;
	Tue, 21 Oct 2025 17:18:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D76EA3007B5; Mon, 20 Oct 2025 12:38:59 +0200 (CEST)
Date: Mon, 20 Oct 2025 12:38:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: jpoimboe@kernel.org, rostedt@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
Message-ID: <20251020103859.GO3419281@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
 <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>

On Fri, Oct 17, 2025 at 05:47:26PM +0200, Jens Remus wrote:
> On 9/24/2025 9:59 AM, Peter Zijlstra wrote:
> 
> > --- a/include/linux/unwind_user_types.h
> > +++ b/include/linux/unwind_user_types.h
> > @@ -36,6 +36,7 @@ struct unwind_user_state {
> >  	unsigned long				ip;
> >  	unsigned long				sp;
> >  	unsigned long				fp;
> > +	unsigned int				ws;
> 
> Factoring out the word size (ws) from the CFA, FP, and RA offsets is
> clever.  Wondering though whether that would be an issue for unwind user
> sframe.  Do all architectures guarantee that those offsets are aligned
> to the native word size?

I would hope so, but this is all opt-in, I'm sure the first architecture
with an unaligned stack trying to support this will let us know ;-)

> >  	/* Make sure that the address is word aligned */
> > -	if (cfa & (sizeof(long) - 1))
> > +	if (cfa & (state->ws - 1))
> >  		return -EINVAL;
> 
> Alternatively using a state->ws of 1 in uwind user sframe would defeat
> this alignment check.

Indeed. Or rather, with a words size of 1, everything is aligned :-)

