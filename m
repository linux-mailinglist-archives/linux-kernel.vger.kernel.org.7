Return-Path: <linux-kernel+bounces-797268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E8B40E34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCAA3A36E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC3350835;
	Tue,  2 Sep 2025 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MLFllj3q"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1F2E1F10
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843061; cv=none; b=srY/jhSDihikJRbvwzHqJeuhtvZAJzM20N4aYHt42XY5D4E96cavh762TJoplrHJ26GvYe+OCSKRalNARIBQQrMkzKhNx+sgsvekjKw1tn3dAsNKJZS4ezp3oNVTVYngKXJ/hNHb7pIsFeQQ3juF7kMyIs+GLZQrV9N7hDLvby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843061; c=relaxed/simple;
	bh=h17LMsILj8e0VSgRn5q9BxKODp6LJ0WmzZ/Aulwk0SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejsLjsFio8uy5kWtVYicyojaXy6tWhtpvmQSYiadC90e4HJb38whVSGRFm1G2T6DQxgvTpF5l9ALuJXCS0ewIk5p37gmE6FUqZcfguf8SiVg4oRTsbUp5N5j3UfuoYs+GXpZpQ5BdkFIKYIhvOj97hKGThdU0Qhed4Cv+u4UmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MLFllj3q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o1WxhFDj4HDK+ojytAfPZg3U0Olh8tYi2Vi91RLUHzQ=; b=MLFllj3qoftsytYU2YiXF5Xxqs
	Xd5xFaBxVoU8TS1flxQERkB5QOuF+iKUSHWKDpqh5t526P0/teZsxD7rgzXqPAGUYini22Ptiz5b0
	fOFS458Hh1PqJYpVG+y+ZLADXK1d/J62NgocdpAZP2bD/4fW49bzBTyaaNdzu8/+oBAOog9X8w6/4
	FwhJOiFWlgcayJI9i7H9WpY3+P3s+ik9Lo1rhTKVIzk1EZEpMPx4RS9nnnngzp1SfRz6oFpigVzrn
	vCzc+yfX8WC3qogFXJ3BvB4tXki16YCIWNfPXQSjC0SwnINw9zKjoyWhBfyJogEZbtYnzn30CKOBv
	zFA8RPuQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utX8K-0000000AuIy-0CIJ;
	Tue, 02 Sep 2025 19:57:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC52230039F; Tue, 02 Sep 2025 21:57:35 +0200 (CEST)
Date: Tue, 2 Sep 2025 21:57:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, Joao Moreira <joao@overdrivepizza.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, ojeda@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250902195735.GM3245006@noisy.programming.kicks-ass.net>
References: <20250901191307.GI4067720@noisy.programming.kicks-ass.net>
 <20250902081915.GK3245006@noisy.programming.kicks-ass.net>
 <CAADnVQJ2zm7BRb3SuwcmCQ5SBULznbUq777vMCHkm9UbPkaAbQ@mail.gmail.com>
 <20250902192609.GL3245006@noisy.programming.kicks-ass.net>
 <CAADnVQKns0xLA+oEdgF-gZ9W=pqjkL2h2OcUQxH+CvJ=vVL-0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKns0xLA+oEdgF-gZ9W=pqjkL2h2OcUQxH+CvJ=vVL-0A@mail.gmail.com>

On Tue, Sep 02, 2025 at 12:37:26PM -0700, Alexei Starovoitov wrote:

> Well, I mean all these tricky changes are allegedly because
> "Intel/AMD have not blessed using this instruction, it is on
> their 'reserved' opcode list for future use"
> 
> I suspect that 'reserved' opcode will not be used any time soon.
> If 10 years from now the opcode is used in some future CPU that CPU
> is better to be not vulnerable and CFI, FineIBT things will be
> gone from the kernel by then.
> So I would do absolutely nothing and just ignore the lack of blessing.

Ah. CFI is not only about speculation, it is also very much a protection
against pointer hijacking. Note how kCFI was not brought in because of
speculation, but as a hardening against pointer hijacking.

Yes, my interest in Intel CET-IBT is mostly from the speculation
avoidance angle, but CFI as a whole has wider applicability. Even a
'fixed' CPU would want to use CFI.

I would also love AMD to grow support for CET-IBT; they already
implemented CET-SS.

Also, Intel pays me, if they say make it use 0xD6, this is what we do
:-)


