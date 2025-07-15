Return-Path: <linux-kernel+bounces-732137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C59B06293
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964B83BC0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359BF20B800;
	Tue, 15 Jul 2025 15:13:54 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0B1FECC3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592433; cv=none; b=k11qF2goQflMOugpsX09C39PqzPX9mFOBVBFGYn8T0YcaMR7Du4PhaBHdR0rPltWHysRv96CtBVeLhKp1c8hyohbMsYJpJuqLE5bZTrzsDzGpH23aqlE6FHQ6V4LFhgTP0URs+s+9e3dcckEKCB95ilXAQuHTdpCwy3mGR4Q/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592433; c=relaxed/simple;
	bh=UoogA5pc68RWoudF0TehdH2dYethdf5rTzg9+XQViNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpKvfSsTn65wi8acT1UBUaY6nJuqWk+/l740BMs3FQjtZiDSXM9gD71788eHSK5KTWi1upG9DxSDnz5ggwRLYNptAMR+aqh0hMEZ1rZ1UzQyr5n+bURSIu5HSZNXRrYaXjtLAOc9UovscYKBSIi4Ry+scztdTYUTUWjmQ90u6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9334759339;
	Tue, 15 Jul 2025 15:13:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 5130520016;
	Tue, 15 Jul 2025 15:13:47 +0000 (UTC)
Date: Tue, 15 Jul 2025 11:13:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
 <rostedt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LTTng upstreaming next steps
Message-ID: <20250715111346.57587ec9@batman.local.home>
In-Reply-To: <20250715052459.0000e119@gandalf.local.home>
References: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
	<CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
	<20250714162750.45b12314@gandalf.local.home>
	<20250714163755.1de132e9@gandalf.local.home>
	<CAHk-=wgZ=Ssx4qoeuaHet1vx+8M36j0a3q2aw5ePapWm=KnSfQ@mail.gmail.com>
	<20250715052459.0000e119@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5130520016
X-Stat-Signature: qinqq3hf9topmoddditdu7hifzpz4ufx
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18RvDKBrsI4gig4h/SXNsc0YYCVbUP/Q+c=
X-HE-Tag: 1752592427-877062
X-HE-Meta: U2FsdGVkX19O6bUIylDSKHS33u/6mErUakzyx+T7VUD5i/CX2qedp87fLb00VrIEtLpnsIyTgbgjkJ7ua/9StAVS1QA/0bpNJO4gVXxB+24eX752XeIdBDYAyRuvi8YdeTPnrB6GiZhFdFfvSp9eDf9vrXU8RQgR1yHy7EFZatK9HD+pDme9f/BQTaXHVX6OT5zDZOoZ9KdVQx/1I+N0+yXsKPFghUW1rHfWTmywJNciXxFkAx9/VNgikA924ByXIXO0uxTzavIV+6BdSqtyNjTOMmUOtaOl4moBlj9kiUg7bhLAnaf5zfLW87zYH907gkHx4WVK/JQRaL4jqXc0RNFERNWc1ftBQ79A74KIfMEiQawWKn9ZQiyLMSUvTWR6o6Y95+RGFd8eJsGaeCMVPw==

On Tue, 15 Jul 2025 05:24:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Either LTTng can use the same infrastructure as perf and ftrace, meaning it
> requires EXPORT_SYMBOL_GPL() on those interfaces, or it gets pulled in as
> is, so that it can incrementally start to share the code.

I believe that if we allowed LTTng to have access to the perf and
ftrace infrastructure, it would encourage more collaboration. It would
force Mathieu into working to get perf and ftrace and LTTng working
under one infrastructure so that it could finally get rid of its out of
tree module. Whereas, if we pulled it in as-is, there wouldn't be
really any incentive for it to change.

Now the question is, how do we allow LTTng's out of tree module to have
access to the internal infrastructure without breaking the
"EXPORT_SYMBOL_GPL() is only for in-tree modules" rule?

-- Steve

