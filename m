Return-Path: <linux-kernel+bounces-732103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1EB06203
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DAF4A4616
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B841EF36B;
	Tue, 15 Jul 2025 14:50:49 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D21E5701
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591049; cv=none; b=GJi/w80jML6Kt+6hnAw5FxEgROjWyF+CqMhHiDzYibG/Z3QpcRfXISBc59BbYbkTNoe3NNjI94LYA4BsmDYClqHCT7OMknfwVM3CtH9IJrDXcIrNaUQhwQjQuRbBpcNMu8wJYbyXciLEavuJcslZwRGVxXiGd+r5AZbVh80xxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591049; c=relaxed/simple;
	bh=ldtUpXLVLpfehaErGpN5AMpJX/YsOQVaVrJvd8cSKuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+OevReg70A+vrPD+KeJe324kve5nQjs4scZXZ1nanRQkmOKS2oQ9IQakA5S1MNh7e2FlP3AliAc1e5Khq3fg32TFtWtOXMO/DMJZLi9xjDMTazJzJY18UH/SQNwPzU1lJ0W64GVKjH1HCWFjumcJI2qWH5fLLYAtdSAMfl7Wo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 9F46A10F55C;
	Tue, 15 Jul 2025 14:50:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 5688A18;
	Tue, 15 Jul 2025 14:50:42 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:50:41 -0400
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
Message-ID: <20250715105041.6f63f4a5@batman.local.home>
In-Reply-To: <ccd1ace31a0fd27f033a1ec70df7c93aefebff3d.camel@HansenPartnership.com>
References: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
	<CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
	<20250714162750.45b12314@gandalf.local.home>
	<20250714163755.1de132e9@gandalf.local.home>
	<CAHk-=wgZ=Ssx4qoeuaHet1vx+8M36j0a3q2aw5ePapWm=KnSfQ@mail.gmail.com>
	<20250715052459.0000e119@gandalf.local.home>
	<9f6700d1fb62da8ce633f755b0c9e2d5c2704825.camel@HansenPartnership.com>
	<20250715091649.3cc933fa@gandalf.local.home>
	<ccd1ace31a0fd27f033a1ec70df7c93aefebff3d.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k3iyjahdg7njcwisagfpf34eqzttq4i5
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5688A18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+qLZlG/h5osOU3/O6RF08+YuDDCJaPJm4=
X-HE-Tag: 1752591042-727489
X-HE-Meta: U2FsdGVkX1+yMVgpYSHDJOd1180biPWwHTG7j66g0qiq1UqoCeq7QLhwC2d6tJGyY66IBlAMD66QGGRuVZ7WAmRRzmQMWLLOC9BLvFoH9p36y8D5gnjO1ap5DLxEDYaQ8JjoVqmpiDJVcpF4kO6DnjWp7bBD72i2tKD9f37B6L33iTAfQxfkfyT2NzI6QWkhPtlHyC6z3L3bsDyAnOB3SLyEQnD2F23Pd+S5WLQUETSSdKINjYcRvyrhJnqaKyjTVhmffG0LcaM+wgY4PsWxhj3DY2QdktdymrRqxTvbxwC572UH1y8fVPbP/MpEFRQf62CcbDZrdiJX4brjEgsb27O1+yQ1q9A4SlQMqZIGs7UZFyarCDBW6+Bu5cN55wCM

On Tue, 15 Jul 2025 10:38:34 -0400
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > Well, if you can get those cloud people to invest in that work
> > without causing any regressions, go for it.  
> 
> I think you know as well as I no investment happens without some
> indication of upstream being in favour, particularly for large changes.

I think you just pointed out why Mathieu doesn't want to do this huge
update to merge upstream.


> So they're not going to invest in doing this on spec because it would
> be unmaintainable out of tree and would be way more hassle than simply
> having customers reboot as they do today.
> 
> > But I doubt it would be acceptable to make the ftrace tracing
> > infrastructure into a module for the sole purpose of allowing LTTng
> > to have EXPORT_SYMBOL_GPL().  
> 
> I don't believe I said that: purpose is not monolithic in open source

No you didn't say that, but I figured I'd mention it as it was likely
a thought someone may have had when reading your reply ;-)

> because people do things for wildly different reasons which a clever
> leader can stitch together into something more synergistically useful.
> The cloud vendors would be invested solely for the purpose of being
> able to load tracing infrastructure on demand (with the permission of
> the tenant) into a running kernel.  They wouldn't care at all about the
> symbol export problems of LTTng.  However, working with the cloud
> vendors on what they want (and could be persuaded to invest in) would
> give you what you wanted: an in-tree consumer for these symbols.

I have no vested interest in it. Mathieu has just been very helpful for
the last several years with reviewing and improving the in-tree tracing
infrastructure (which LTTng received no benefit from), that I'm just
paying back the favor in trying to help him out.

-- Steve

