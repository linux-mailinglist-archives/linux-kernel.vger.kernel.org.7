Return-Path: <linux-kernel+bounces-732139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ECAB062AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1D165D44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC62264DC;
	Tue, 15 Jul 2025 15:16:19 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110571C862F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592579; cv=none; b=dd9zxBJ3rXsQuRb4e6vTdmXr3Wqt2M+DUQ2ekoASR1Ivaujaq4XXwMAjcuXE+QqxKzJJ9OLpCFkZ0Jy/x486ngI+zhBlZx95fABCLVK8AxOkV50lM5T4Ei6Q56kCRx16ZQfgnNhBinqcINYLtST/Q2fvRmowkJe3FLWYLLXJa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592579; c=relaxed/simple;
	bh=4Wk8Ogik6K4uX4O85PR1o17+usrq0ofsrGAhuQeadmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNhFFpbWNs6ZyOnr4tE9nNQVnWjOK6GrkGQEJQ2H7puO9kTannlCGa0MGYrNmpSnrPuvUWi71pciS6KhAddmWP+8EjMpkI7AH8iPT2xdbtjzIiv4iXtw0k6r6rSGnRdowiZ3U+8LssDG1hrPNzl/bV96QLtBCgGeD7oXVXS59J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 2D4FA1A04A2;
	Tue, 15 Jul 2025 15:16:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id B1CE22F;
	Tue, 15 Jul 2025 15:16:12 +0000 (UTC)
Date: Tue, 15 Jul 2025 11:16:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig
 <hch@infradead.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LTTng upstreaming next steps
Message-ID: <20250715111611.1bdba041@batman.local.home>
In-Reply-To: <699bcae748cbb9663029542f93c9c83bc8a2c029.camel@HansenPartnership.com>
References: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
	<CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
	<20250714162750.45b12314@gandalf.local.home>
	<20250714163755.1de132e9@gandalf.local.home>
	<CAHk-=wgZ=Ssx4qoeuaHet1vx+8M36j0a3q2aw5ePapWm=KnSfQ@mail.gmail.com>
	<20250715052459.0000e119@gandalf.local.home>
	<9f6700d1fb62da8ce633f755b0c9e2d5c2704825.camel@HansenPartnership.com>
	<20250715091649.3cc933fa@gandalf.local.home>
	<ccd1ace31a0fd27f033a1ec70df7c93aefebff3d.camel@HansenPartnership.com>
	<20250715105041.6f63f4a5@batman.local.home>
	<699bcae748cbb9663029542f93c9c83bc8a2c029.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B1CE22F
X-Stat-Signature: ux69zxoto7coa5ppwmm18yrj1b5pwb4w
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/hRKkzsiKCXlnrOCrz5zY0G/d21aevZPg=
X-HE-Tag: 1752592572-694931
X-HE-Meta: U2FsdGVkX18vGEtD/FFrzj1EP13uw7iIGgmjqDJSC1d1sB4KGwXtBn0qQ3hNspKoYFUjxmA/5JU2dymjMQx4nnhfnIRhZU0FI3+eoP2Y4C0b1j0T8JBJp8Gviv8URsV283dXbpxki17o592oUhXBPyrifnPPJkj71Y+wx6oQCAGW9/do/VT22fLqJd1IXZFjsaSF+cq2ue4yqeYI9zA4nEOTFXr6DdTnImRkywV+Gp8PZoJtX+g5XhgOfmn1ZGhFYstOcHWINSmn/eb4JiefexZ7Eg5XYGnO76FMMd5u3FWu0PJTLTDZPmqg0+Ia5B72PZIkEuP6QmUWLHxg+BngLSNic+ArPGFGGZ7rouxzR7CUBqpQngXzS0XFZK0Ao757

On Tue, 15 Jul 2025 11:10:43 -0400
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> Well, if you've no interest in thinking outside the box, by all means
> continue banging your head against it until you think your payback has
> been achieved ...  I'll go and get the popcorn.

I didn't say that. I have no time to give on this. I don't have the
time to finish the things I am responsible for :-p

-- Steve

