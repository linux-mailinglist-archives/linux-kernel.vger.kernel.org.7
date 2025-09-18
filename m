Return-Path: <linux-kernel+bounces-777741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF4B2DD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B151C808FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403931CA45;
	Wed, 20 Aug 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ooAHkEmp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A20353356;
	Wed, 20 Aug 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694905; cv=none; b=fnBgYBwtQ/GdLQdLhnYg/zWAQcjSv3ehFiqd41z9xAtL9ljf8bRy06JV97c7hF4/BZT5ElQi8CvD6DY4kolZ6WRcuih3J4WR/KkQxKoiVbwlubt7xJMnHr/RZ7ZQbDSWenIXRmUoEH1MvkfxqOMiIBMvxrWu9Qbw7dkVUYFcAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694905; c=relaxed/simple;
	bh=g36MSWA1OAlVnR4SJzdNbofVqN8PUVWp9m6DJUGvgtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBPDfaate9bm4E00N/0KfVjQcK/r/rG1jMP7PJi6KxoURoEbvGUiaU14iJ95KthG0X29G5EoBxKfpANvub+LeU5xHIqtDSkWUNWQvFRdRctkNgJe4N3c2V5zGvCJdgmJgcY4F9Umlwl3as4DYDy3btJ4CI7iSeT1UKa1DXahTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ooAHkEmp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ixek98LEZnM0KSSeL6np3Op3Uh5zqqT3bdR/KDtVEn0=; b=ooAHkEmpqDbcTlSl4I28Zd3Dvp
	b82ZivBUUcty6PbgdnZw2d9Bgz9UsEe64HK1J5U6csRVaxTnwkcJs7ZPoTSZE0W/Pz2Ng4t9Je0X+
	WYUDtrqyJgfLF310ns9C+vq0gOv+udFGQO/wguix4Gah8IdSKI3316zJu1vDzi5NeXLFjWx4x3rW4
	sWRrw6jg/YHUlH7+rV8cWRW1vxWka2hGHsjv7LMbgAr1Cxqn5tp/u5KNJBfgan0DFi1+dSolxTo2F
	7d1rTZKQHYGbN90viwsh7XoFEKozP/P+AtGGWDOeGCJVS5J+oo+2IgMMB9gmpyFTfnPgLJ2hOllNT
	nHvZJvHA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoiRb-00000006exZ-035E;
	Wed, 20 Aug 2025 13:01:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AD216300385; Wed, 20 Aug 2025 15:01:34 +0200 (CEST)
Date: Wed, 20 Aug 2025 15:01:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20250820130134.GK4067720@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
 <aKW9Q0cOhNL0XV0R@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKW9Q0cOhNL0XV0R@krava>

On Wed, Aug 20, 2025 at 02:19:15PM +0200, Jiri Olsa wrote:

> > This seems needlessly restrictive. Something like:
> > 
> > is_nop5(const char *buf)
> > {
> > 	struct insn insn;
> > 
> > 	ret = insn_decode_kernel(&insn, buf)
> > 	if (ret < 0)
> > 		return false;
> > 
> > 	if (insn.length != 5)
> > 		return false;
> > 
> > 	if (insn.opcode[0] != 0x0f ||
> > 	    insn.opcode[1] != 0x1f)
> > 	    	return false;
> > 
> > 	return true;
> > }
> > 
> > Should do I suppose.
> 
> ok, looks good, should I respin with this, or is follow up ok?

I cleaned up already; I pushed out these patches to queue/perf/core and
added a few of my own.

I will need to write better Changelogs, and post them, but I need to run
some errants first.

