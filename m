Return-Path: <linux-kernel+bounces-729481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF6B03748
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CE03B2388
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9210F225779;
	Mon, 14 Jul 2025 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f9dvLXpI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318B34CF9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475207; cv=none; b=clfLuYQAIF/1yGuEaWv7+LdQKobIJk2KjjrFUf4kl4OC3uw7+Orsw/5IFPu48xgO4h84ZNhuKtUcYGp2T4XSwZPDpmmGw4C52TYc+VAYX1OGjFXWy6dkFj2S6/XJX/uWi/MNmNbiafKs8aWyOrlpgpYLiBMILsaRXRPYYg9nLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475207; c=relaxed/simple;
	bh=1G+kwyH3X7cE8z82gSsuHAyJpYLDzNzOUBJHf8Z+Jx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbCLqteIzNhSg07iMhN7QtENAVsfOJHWmh1LHr56iwEIXjfAVZOjLmc3fzhhufMAGO8AURgDbAfSgh7Jiq1/wV8FQcKHeDGzuctH41D+RpH4QAkiY/rT/FNUVvHvgtiDyiY7KnMWWu1A5I0W9vkyMKJP9QeXsXnWcp5lH5Fu/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f9dvLXpI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1G+kwyH3X7cE8z82gSsuHAyJpYLDzNzOUBJHf8Z+Jx0=; b=f9dvLXpIZThFFBxO1y8DWCweIr
	D6ajTv0gdvlrk1jSfWhsezGfMXFyyo0+9SCej5SfolP/SdWzYsc9RUCpeTdqNc4fsiCNvWwJjhlJI
	PGDjbtk6/dSWhKFe2mPh8NXjSzkmPoXF2eRXBfU6F4nP+8KhCVUyH0768QkuSzH16stu+2VwQ+THN
	WU1OsimusAdIGiN23qYE8FBoVR48bhWWCWh+o2Os0MXjG8IpHQszjsFtChvrqq8u3WaLDUbHWp2jN
	NeyyjEVoNyYW90rh8Atw+NnwpExz8n5EEacbBkyrw/HIhrkHQU1ZCtdSQN2u/7zM35D5rtkJSboR1
	ZmD7cM8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubCr6-00000001NgH-03Yd;
	Mon, 14 Jul 2025 06:40:04 +0000
Date: Sun, 13 Jul 2025 23:40:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: dan.j.williams@intel.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <aHSmQ0AcZA-FUk4M@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
 <2025071124-cola-slouching-9dd2@gregkh>
 <20250711100239.55434108@gandalf.local.home>
 <6871537ec0461_1d3d100c6@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6871537ec0461_1d3d100c6@dwillia2-xfh.jf.intel.com.notmuch>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 11, 2025 at 11:10:06AM -0700, dan.j.williams@intel.com wrote:
> It is odd to read this claimed benefit when viewing it from the wider
> Linux kernel project. Upstream maintenance of ABI contracts is the
> fundamental struggle of subsystems. The request, "can we get the kernel
> out of the way and maintain our own ABI to our users?" is a consistent
> refrain, and it consistently receives a qualified "no" for regression,
> security, and other interface evolution concerns.

Exactly.

