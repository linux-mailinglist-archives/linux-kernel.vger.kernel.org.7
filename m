Return-Path: <linux-kernel+bounces-729912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771D0B03D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE0317AB77
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC22459C5;
	Mon, 14 Jul 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Hgy87jQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D817A2E8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493117; cv=none; b=QGrd2L1zYbCF99L+IHq9XiXx1yTvgAlfcytmD95xgNJ9136nOcJ2nfUlBNiijaaiB9PkObM+Fh6Ogd+zPBMhBGMnyi8sEZFOef0SmXIA7hU55U9RRxlwsA8CCmBR8O5RjmWYSogJABDbHgM8oi1GiOCchR5zB7rVIXK00Ods0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493117; c=relaxed/simple;
	bh=gY5KB8MrNfdx/voPKs2We0Zqihb/c7uT3E6zbC8Xx5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9Kb8rf7AFgyhOZqMDTGFakfkhKeTXSddghj29ixo81eVKmX3I7pSYz+OInvnOH2rISqIZ2X6cK7/oQqSkJqy/ksQ6OpSnbmGFKffpTc0gxHzKX/JxXHOF7vHGVIaSzUsXCeLEpp4jmLmNzA07ZEokcEaI5m37/KtMEvM6uCJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2Hgy87jQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I2lD775XhYeeH1MiGzf4yPSc4AcGHGaz7v+UHkUUxOg=; b=2Hgy87jQ48lyD5M3aRb+76fn4F
	8BlobkFCDs5zsl8jUigzW9bu/RlWho49bggLQX4oXi6LcVdlLNhDyt2zk/lyI6ttGl0JGmBuXaioF
	ocgwMVBRekUfxPbOtdOBvUOQC5ioTr/RRhjhuMTInsCYr3RRKGBYRN7C9DRXj7nzLFuFevYCohqc0
	6KXTcgplUJlkB1jRgaddVByQcUvLJzSwWECi90UBOC07OCmIUdMbXi1Ut4YWTIUr/5MZphLr45173
	o9IMPHL8klrLbmTYVfYS8gWeGc2yHbh4/c1vtIz0YHktcW5FMDR2K/0KsYwUvyOy1aZesgmAKU9FO
	BrS131hQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHVx-000000022nV-1U9a;
	Mon, 14 Jul 2025 11:38:33 +0000
Date: Mon, 14 Jul 2025 04:38:33 -0700
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
Message-ID: <aHTsOcIUs0ObXCo1@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
 <aHSmIa3uffj5vW-m@infradead.org>
 <20250714062724.6febd9fb@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714062724.6febd9fb@gandalf.local.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 14, 2025 at 06:27:24AM -0400, Steven Rostedt wrote:
> This has nothing to do with Mathieu being a friend. He's a long time Linux
> kernel contributor and has played a key role in developing a new feature
> that will help both perf and ftrace, but without the EXPORT_SYMBOL_GPL(),
> LTTng can't use it. It's basically saying "thank you Mathieu for helping us
> with this new feature, now go F*** off!"

You don't have to be as explicit, but otherwise that's exactly how
it works.  No one gets a free ride just because they are nice and/or
contributed something.

The rest of your mail looks just as confused.


