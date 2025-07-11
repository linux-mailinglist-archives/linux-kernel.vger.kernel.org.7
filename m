Return-Path: <linux-kernel+bounces-727084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F29BB014CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD6F1C208B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5C81EF397;
	Fri, 11 Jul 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWb/wlhc"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043C1DDC15
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219391; cv=none; b=Ey+6FL0AO4pst8yyBSR4fwnczFLAM6RQXfir+1AOlQ61z4rSd8piyjtfGCLAhW9FtLhVWgHTNNRHCp4hSxVWd63KZk+zboPg1rBgHk/BfXHw//9O1X4XExEKBUHaxa6re3zgSU3cExstPWVqiArqwZFkTPkdVOCJNTaCCYG9/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219391; c=relaxed/simple;
	bh=DK3E25LOT1I8kE2BN5rTaX4nmSkOnCyxbWuZlf1AcqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtpuStZtueh5uNs9Q+7ECktig+acTKzfGHKKu9JyG1SZSg9byFiIHgr6PnvjXTGjkM0ienJC0ovrVlmwCIzRLlC9GL1qqvdFrlmb+Hmugy9RiISGxAQxSI8K2HZDJvdLJROYk4z2x+96LSh+PsbCJo5h+AN8xnfx9KXX9IJ1Wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lWb/wlhc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DK3E25LOT1I8kE2BN5rTaX4nmSkOnCyxbWuZlf1AcqM=; b=lWb/wlhcL9odqxj3S70XlJ/Mw4
	3ZeUPzrreWXbI4P9klhNiNL8e8DY1S62/B2dQQ8h7wzPmeRBi6I1wo0udMx45qTLVghVOA/lpGSt/
	BM3RCBRLJzFsCHiGP/drhb+3qewAMgCCn3y4dhWSUAabG7cqLPsW6/hC+IlEXGCkSbYBHj5RDNUko
	OXppRdweMM0getK5nUG+iAYWa+zth+0xdGAmfkQqog0CAIRkkrP1/ifg098zRM0j4y1cM4xN7PBNI
	MLmYXao847inWmMpHBf8TR8oh+VyVZy8eD0P6mw21+bSVeg6VvATmerOy8FzPU0mN8XdLdRXg/5sn
	ENaPE1KQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua8J2-0000000Dzle-3W52;
	Fri, 11 Jul 2025 07:36:28 +0000
Date: Fri, 11 Jul 2025 00:36:28 -0700
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
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
Message-ID: <aHC-_HWR2L5kTYU5@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 09, 2025 at 05:25:49PM -0400, Mathieu Desnoyers wrote:
> Allow the unwind_user symbol to be used by GPL modules, for instance
> LTTng.

I don't see a LTTng submission or any other user in this series.
So the usual prohibition against adding unused exports applies here
as usual.


