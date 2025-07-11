Return-Path: <linux-kernel+bounces-727462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64067B01A89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169C57643C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7928B50A;
	Fri, 11 Jul 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQaulez1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5E27E06D;
	Fri, 11 Jul 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233340; cv=none; b=HhLjBYKJ9NRiIxnL+Xsjx9hD6+e/XC94KZ2LHv3IpwLOSH2DjmK/Yz0IKSYUaZCnxlHxRrPL53IpHJN1qZ80mIIXx/NpauBNO0N+fkIdgi8/lUG2Ex+kY5+NG77Een3hkgmz5+aV9QXNmcDm316P258FXoeN0/ROnUrfu3xQRWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233340; c=relaxed/simple;
	bh=dgDIwm5xlRv1g5vIU7zlBaROFKCXWPLawVbEOwjuzP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFYWXJRCnRuIlmcmGHAP5ZbYh6uYkfmh+YIb+/2W7BhusBNrJjVwsZItdG2fbGGhuqxuUCNClKFbBcg7aEt3CoFFUvlXkKostix7VaFMjpIwqaGAzBUy5Sr6kC2xwuCnGiupjGVEVfEd8iJXaYJp4Okvbqb6ky+z9nxRV0UWfd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qQaulez1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ayfckBgnCQFU9do9xtsmFvO4mmpAGlXUzGjcFbd2Geg=; b=qQaulez15z5DAC8vzlS/V4GlAD
	lKzjlmdmgG5AuIrf3EvQrzuWXwHB2OmVCwdQfwcnCVhUpHkgnlJCv3Zqud82Jdyyd43ikp1g/g0A7
	07uM5YIcOUw82zGNIeMT07Z48ygBkoDc6XBECDOTxGtYVnS3UvMwuPcakbo9545iehqD7Z6hknnc+
	e/bSG+f0jNFtpo+thwv+KfvzTa1dyJHKK8WV+eaUbmweuZ0+M9b2e53ifXbzb4dFzpPLLLek7Xelm
	FEaQQp6nGxBJcUDOcuvUD4mjzXUW3b9J0PuSdSbJ4nR4IKGeoY07mTbJAqyEAoYqDX7GGyaF7m6eX
	YY1SesyQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaBvp-0000000CmkJ-2OU4;
	Fri, 11 Jul 2025 11:28:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 826593001AA; Fri, 11 Jul 2025 13:28:44 +0200 (CEST)
Date: Fri, 11 Jul 2025 13:28:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix up build issues with vpanic
Message-ID: <20250711112844.GG1099709@noisy.programming.kicks-ass.net>
References: <cover.1752232374.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752232374.git.namcao@linutronix.de>

On Fri, Jul 11, 2025 at 01:20:41PM +0200, Nam Cao wrote:
> Hi,
> 
> The newly introduced vpanic() has some build issues. This series fix them
> up.
> 
> As the vpanic() is only in ftrace tree for now, it is probably best to let
> this series goes to ftrace tree, if everyone is okay with that.

Does it make sense to make panic a static inline?

