Return-Path: <linux-kernel+bounces-838525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 369A8BAF642
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0777AF732
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6122B594;
	Wed,  1 Oct 2025 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FsMlJ8Kj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620F23183B;
	Wed,  1 Oct 2025 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303430; cv=none; b=raOw+nzWPldvGkH0IXS/8Adr6I9wQ8J8F9DqyVFapPgfwImacxWRBJBIw0O5LmK06+A+q382vFRq36KXHGzi73QndCale4khpWwxQx2aksPsxOZtei5Zr1xaRtTlRZBSUdSrZKik13iRZlSVprzkZSvIOFm1kmIZVpQXogtH3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303430; c=relaxed/simple;
	bh=RYbmVxzXCzDEJEPoltKBWNXsPmhavy7hw8/o1Yi3jCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMUmbuQTwwstXxhLw/dXrZuUhS2JUCdu+b07aZ49TWzlSAYjuQuHoU6vqqdxgd4ClRk4E5C8H1Q6AD6ZHTyStp70VmXbgO6c5oY0TChN/L2sLJ+ReoqVks9aUwFge+Qt/uYiNhhKcTpUZZ/dg1uG4eSwWAY+ScYgwjFvjhnOiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FsMlJ8Kj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RYbmVxzXCzDEJEPoltKBWNXsPmhavy7hw8/o1Yi3jCA=; b=FsMlJ8KjzDHutUALhWkAwR8ju7
	JOogZwi++N4ETlA5/Q3gXhwt6fUfa18z3ykpy3dDfJggwpt7vgyBz/Xz4HG1/FXMClM/6C9w1yBpc
	PjSJrSJp2QWsNyX3pT3VZiSXFFfGaIj9+zE8xKmYQ3U/SrtYf8UfVn8sO+tmoWHgMHbaZkIOJQNMD
	QoE6VGecceAvsQjHw5puFp/v4LsLpFWS45AmC4XlGQSWk4s3pDSjaY+k6qHK/CsUQVM5id9hPr9EF
	WntXJ5MEK2sYhyYK+UouO51eCPW1Ri+IgnUnSuTXnirtG7EgWaRlCwXVQfUjHOjWifLr9DdvdlNFK
	wyqjm/7w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3rBc-00000009RM0-2N04;
	Wed, 01 Oct 2025 07:23:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9AA0300212; Wed, 01 Oct 2025 09:23:40 +0200 (CEST)
Date: Wed, 1 Oct 2025 09:23:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
	xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
Message-ID: <20251001072340.GM3245006@noisy.programming.kicks-ass.net>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
 <20250930085044.GK3245006@noisy.programming.kicks-ass.net>
 <20250930125156.GK1386988@noisy.programming.kicks-ass.net>
 <2ad137cb-ed38-42f6-ac0a-a81569051779@suse.com>
 <20251001064339.GL4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001064339.GL4067720@noisy.programming.kicks-ass.net>

On Wed, Oct 01, 2025 at 08:43:39AM +0200, Peter Zijlstra wrote:

> Let me see how terrible it all ends up when using as macros

Argh, as macros are differently painful. I hate computers :/

