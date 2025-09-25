Return-Path: <linux-kernel+bounces-832436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6885B9F4F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566E04A7412
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE321C8621;
	Thu, 25 Sep 2025 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UZfVmBuh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2121B4224
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804219; cv=none; b=WfauOGio9xMwvC/A6s7okQK0y+75RYDHGmj6USbASMjNLezsRHfI32ZMcEYLzGzg5tw+0sWLxTYVIttuCmn/AWLp8DYgv6ScjJqF2Yme4/5WTfgmmAkGPUG2Gdw9s+BtuYawke6wEBPZTjx1owfB2HRm5xh8vNJ8WZ9Y8STOLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804219; c=relaxed/simple;
	bh=6mA9nd/L/JopJkkkWXedseJkHCwv9GskuiTnIrlfxXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBLOWPpJUh2HHazKvNbauEbVRg2t3jCQLmSREgp+mAWGbuXQj/6o6CKyMeZ0H2D/gxn8u+FgSPF5zqa543aRw7hwMQfng0rmJwENb3Ej3aLZPlF4D/UoJ9EJ0UefSX2Zke3h7ez4+9n0hNl9VUrEONIHu6Yc//8mUGEwv1VJTpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UZfVmBuh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2wDV1r6QzVGOyw/+ijWpQMqt8RFQ6WD11sTJwMW3m3o=; b=UZfVmBuhFAzGGL+vUrytehRX/+
	2sFQ8pf7RZjxx+cv9KTaAfzYceNg6Xk5Oub2gzpvUZ6kYNiYOgdZ1H49OlzxLHhRQXyrejEyOkOQB
	qRQg58SstnS7JYseZcr8Ctn4/YfnvZv9UP6wzJXjxDEy8qed2ZA/4ulFBXwIanivhWSb1LFcwlHWT
	IrAD0fW1EdY/YaJjQsjemqHsmqwnjBKzAxPJkyDip5YzxYZBaWtNGJyDQzCedVa94vEyD0s+97mh1
	dJZZCb40kCfMIpt9wPz5hLNUG3GzgRZmEZXYu4IWCTTundUz8KMUlw14zH4RNatNmIjTGTorvKFm7
	GDrV1TFg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1lJt-00000004RNF-16eM;
	Thu, 25 Sep 2025 12:43:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EE951300220; Thu, 25 Sep 2025 14:43:32 +0200 (CEST)
Date: Thu, 25 Sep 2025 14:43:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: alexandre.chartre@oracle.com, jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
Message-ID: <20250925124332.GA3245006@noisy.programming.kicks-ass.net>
References: <20250925104251.GZ4067720@noisy.programming.kicks-ass.net>
 <a2f6775f-0be5-401b-bc01-effd3f428482@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2f6775f-0be5-401b-bc01-effd3f428482@citrix.com>

On Thu, Sep 25, 2025 at 12:29:18PM +0100, Andrew Cooper wrote:
> > I've made that:
> >
> > 	case 0x90:                                                                                                                                                                                                                        
> > 		if (rex_b) /* XCHG %r8, %rax */ 
> > 			break; 
> >
> > 		if (prefix == 0xf3) /* REP NOP := PAUSE */ 
> > 			break; 
> >
> > 		insn->type = INSN_NOP; 
> > 		break;
> 
> Legacy prefixes can come in any order.  What is F3 66 90 ?
> 
> Also, VEX/EVEX/REX2 want excluding too, all of which can encode rex_b
> differently.

So luckily objtool only really cares about instructions as found in the
kernel text. Neither f3 66 90 nor VEX/EVEX/REX2 prefixes are of much
concern.

But yes.. I happen to have an insn_is_nop() function that can be used on
userspace, and that certainly wants to be taught about these... x86 is
such a pain :/

> Is it really only rex_b which prevents NOP becoming a pause, or is it
> any REX prefix?  I would have thought it was any REX prefix.

SDM opcode table and instruction reference seems consistent with f3
only.

