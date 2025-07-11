Return-Path: <linux-kernel+bounces-727086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1AB014CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718885A1E51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F21EFF8B;
	Fri, 11 Jul 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vqdOhGHw"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074751DDC15
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219454; cv=none; b=X0M//m9ajkmYqyihg+2EvtcLJFpILEVeL0MIwUfVsE8CD3zPwgW/xUpb7yT1fflTq2Lr2YTeAMVsKA5qtYOEg7VhecgNvwo3aHjVM5LFTMd9T2/FYZT6BPTHvr2GOKL8Q49vAnYb2Pnqp1mKi34LUrZxxjRrqC0hUrcR1ghWu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219454; c=relaxed/simple;
	bh=VQSOBblDnH8Nu/vrW+KEgqDWdWu/ONzBiULEcqToVqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0ZoytYVyvl11hw/3/DyMT7g8eeEt5PYvpm0BHpR7Coku8DcjNoLcpqEKQq+Td1PyTvV/uCRvEt3E/UJ/gHGAqy/P8WUgp5GUujxvX5qoF9KDAr3EEMlg129+PALrYpOlTuhWtsufwhBCGUonRQ7KNms8BHItqW62HUjTOLLul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vqdOhGHw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KqPiowxiYTxo0biT0p4CeawYRZdkUE5oW6VYmcMOZII=; b=vqdOhGHwJIOPLv/zuAsRV8sNta
	2jT+vWaZsMKSkK8l9c2Wcl2vLOA8ZTawD6sW1HdzkZfeWcmOcnMsve68847DTMZ8zBLDbBbpnGHjE
	2FK7bXoDkaYo6I3WghRwmKYKSr4eaTI8kXWD126M1mjcARn3aETMc24/C+AOg05cb1zpHxGVZvVoY
	yzTjSvBMMFfyXPCQP+GJb1Yntw4a7M6/P/rQuxb36crlG6G8U+bBEuoNFDPWRkNOw6ZFhvae3wAuz
	UptBTs5nEOUy6Xb7AkPFgIdWGgPKbHaNdb8V3Lr6cbQ0TovDObj1vTAgdnsom5A1g9NJDNRRbWo4I
	fsEJ4mQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua8K4-0000000DzwI-1OcS;
	Fri, 11 Jul 2025 07:37:32 +0000
Date: Fri, 11 Jul 2025 00:37:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 3/5] unwind deferred: Introduce
 unwind_user_trace_cached
Message-ID: <aHC_PFyC11ewcdB_@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709212556.32777-4-mathieu.desnoyers@efficios.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 09, 2025 at 05:25:50PM -0400, Mathieu Desnoyers wrote:
> Introduce unwind_user_trace_cached which copies the stack trace if it
> was previously stored into the cache since the last reset of the cache.
> 
> The expected use-case is sampling a stack trace from a faultable context
> at system call entry (coping it into the cache), and then copying the
> stack trace from the cache from non-faultable context to a ring buffer.

Why is this and the following patches adding unused code?


