Return-Path: <linux-kernel+bounces-729480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8268B03747
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340B3176EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B457226863;
	Mon, 14 Jul 2025 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yWg/g4nB"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A324B34CF9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475172; cv=none; b=RQX2uXs2zRK3jKMsGhZCnz+78/5AeVbuHWDE2IAQ1Y9g/J+3n8ITFYgj2tTQ/ity0NKtnDcLbm8tjunYW0e6G0VTtywH3R1BVUSSk/STXlNE75Y+/Rh56Hdpl8NuHyexf3OOvFm5shkRAYw4GrHc5gEkJ/ERgqRiH4HpYLJYb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475172; c=relaxed/simple;
	bh=/qBF0GE4Lcy3zF7EUWSuwpA3ogCcRv/mhkmg9bSDtlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aduZanU0l1YGu8/zL6Vh9uxVqeJAhdlXNtQ0ox0OULL5fn3miUugdlwT0+SPYW0DPAeBGxOypu6UZWltoolvaif0gokOr6d8oPb2co7ytYJ9jNlFHRoa3nmOAL+jQz4twf0apfCoZ7Ilsb8k4IsBelxHyT2pYO1uSLP77rcMd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yWg/g4nB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kZ8LlmSE7LcHGOAYWwUYC/cT6/86+pnmlzQpORyjX3M=; b=yWg/g4nByiboNsUqlgmUuBnUZP
	BehCD9ccFK7DhnH8U/sLljRUgEGOBNOp33NyhPnFsjqKg3JIV39fjt8Kil1/5PC9xZUMpEVnDuqPQ
	8jPJvBpBb8qRltlVGfLBK1I2F7vopGm0GMLNuzjjP0h239t/UJD0Yix+3WRd7oLCbGAdfiKkZEaSB
	f6RGpfTJI/4cBQI/5FviXKWrirCV7yV1fFtj3APhK4intMl2V48tmWo+kqnfU6Qm2t5VvgOwod3fZ
	JQUHG7m8FwIMlVTbklZHL9sk5/cD57HH7htBgUv17VffU4NPvHqug0ipTnG8HeUGMZc0VxS1Irx06
	44rwFdsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubCqX-00000001NaZ-1dL6;
	Mon, 14 Jul 2025 06:39:29 +0000
Date: Sun, 13 Jul 2025 23:39:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
Message-ID: <aHSmIa3uffj5vW-m@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711065742.00d6668b@gandalf.local.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 11, 2025 at 06:57:42AM -0400, Steven Rostedt wrote:
> I want to bring up this discussion. I understand there's a policy not to
> add EXPORT_SYMBOL_GPL() unless there's a current user of it in the kernel
> proper. My question is, does this policy have to be draconian?

Yes.  Making exception for friends and family is like Austrian law
enforcement and thus errodes the whole principle.  If you think lttng
is useful help ustreaming it.


