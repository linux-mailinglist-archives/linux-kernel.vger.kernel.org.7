Return-Path: <linux-kernel+bounces-731889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F61B05B13
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA09564858
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C55B2E2F01;
	Tue, 15 Jul 2025 13:16:39 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142302E1C69
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585399; cv=none; b=VCBT3NGk7mTOfx8GAPHBlkOHpzsdKAgwAmrGNCAQ4VGrd0fFEzOV5PjaXIepJEPDfF7orwiP4aQHQBYHhSap+OM5i88K6z80acCuXe9mc/okrYHye71c0rWWsAvLg92RtpFG3eKSMmMTv+tqqRF66W4d575CJKFhFsB2XFYOtUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585399; c=relaxed/simple;
	bh=FXj8gBTucsX48V3AN8CLjewb0yX5zpnuClj6LKJs2eU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd+MNFaNnBm4HtgE+2su/thFcMxWsq+5E9uX8Mgx2Y9GI7md8VdoP6xyxiSWeIllzBk28anqYkhBcqQMdQsHGQQwWjTBTK+a9njsJUYnOvP58sKeFMyAUBppodOjBxV5xJqHTDjFjbReRZCr4h87b3hnykGp+C4xSwZohBiFPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0E923804A6;
	Tue, 15 Jul 2025 13:16:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id ABF1F6000F;
	Tue, 15 Jul 2025 13:16:32 +0000 (UTC)
Date: Tue, 15 Jul 2025 09:16:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds  <torvalds@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig
 <hch@infradead.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LTTng upstreaming next steps
Message-ID: <20250715091649.3cc933fa@gandalf.local.home>
In-Reply-To: <9f6700d1fb62da8ce633f755b0c9e2d5c2704825.camel@HansenPartnership.com>
References: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
	<CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
	<20250714162750.45b12314@gandalf.local.home>
	<20250714163755.1de132e9@gandalf.local.home>
	<CAHk-=wgZ=Ssx4qoeuaHet1vx+8M36j0a3q2aw5ePapWm=KnSfQ@mail.gmail.com>
	<20250715052459.0000e119@gandalf.local.home>
	<9f6700d1fb62da8ce633f755b0c9e2d5c2704825.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f77sn1xtdqk1mptb5dz8xsukro3e44mu
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: ABF1F6000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JJY4R/0bOADbAm0sRUisWDAmrElNg9SA=
X-HE-Tag: 1752585392-741406
X-HE-Meta: U2FsdGVkX18JlneeLi8u03Wjtv/tOwsuo9uiOhk5n5Q4a7YvUymrirRpS4KDnG08OaJqx5FxMfawGWdZ1TJizRZ6tXRYMJn9kHMNtBykcSa6OwPJ3WHg6cbFsYB3g9RmwThrvsKaE5kJgj1J0O3581kZlGpv6IEIIVoP74A4R1ME4KmlDJsqNfMkAIlzU2kBTlP3Bq8JTdHhFDsAtwu5BXm+Vp67/++5NBQlzl4cHLihEgsB7JDtsZOrOFvCJX8VLvAz8KTbzSZ3TbXaVD5irBvFq2vCGnDGfEtys7YvCN09iT67XLxx+vos6n3YEKnBAfStfxrv9HaosvyrtcVFUYOS3Utw4LObpasCfg85Ib0Qcg3Rjh/AB5Ts4IH+rNppdrbh4xSp+EdJlBPGgUSHAg==

On Tue, 15 Jul 2025 08:50:08 -0400
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> What's wrong with doing this the other way around?  i.e. making ftrace
> and perf modules?  That way you could legitimately export the symbol
> you're asking about and there would be way less out-of-tree
> disadvantage to LTTng?  I know a lot of cloud people who would be
> really happy if the tracing infrastructure were modular because it
> would save us from having to boot different kernels to do in depth
> problem analysis for otherwise locked down environments, so they might
> be willing to invest in upstream development to help you achieve this.

Well, if you can get those cloud people to invest in that work without
causing any regressions, go for it.

But I doubt it would be acceptable to make the ftrace tracing
infrastructure into a module for the sole purpose of allowing LTTng to have
EXPORT_SYMBOL_GPL().

-- Steve

