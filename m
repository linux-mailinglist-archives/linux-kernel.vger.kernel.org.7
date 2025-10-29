Return-Path: <linux-kernel+bounces-877236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7404FC1D851
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DE8406918
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA22E3B08;
	Wed, 29 Oct 2025 21:53:04 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E62DCF78
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774784; cv=none; b=D/joTQIeZpiWzRcQrGemHcSaid2qXgchRl7fAJ4srRbTEpdcfVolBIi7t3zKFISpoe6SBBmZx65oGyUyDomv/mG0sWfFK2LCzq4Wl2oc0yH65MRXj0d21vnOL6uxcA4mgvMiFIeKkjtski3TMPIO0/2pCZmnFSD8bQEHdS3TXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774784; c=relaxed/simple;
	bh=Z+xHVRWF0/gxljkCTQbxJVwpt2KlRU5mRFICb1g2xk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGZ+HeaVFTNrtyDflxZ5SqSQU3+YvDdz42109ShIAztTK0PVc8R0rmGzACJ/JKiSEbUePJypmkZ0ymApYDVsDHRYQ2bxnUkWoYvRdy2RFpV58K+CGzLBfma/u766JY4fdPAi0MtZJ5coPl+wqfswKE04KS4RKVCHiUGheamij6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B43CDBC243;
	Wed, 29 Oct 2025 21:52:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 8A88A20026;
	Wed, 29 Oct 2025 21:52:52 +0000 (UTC)
Date: Wed, 29 Oct 2025 17:53:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V6 19/31] rseq: Provide and use rseq_update_user_cs()
Message-ID: <20251029175333.399525bb@gandalf.local.home>
In-Reply-To: <871pmlv2x6.ffs@tglx>
References: <20251027084220.785525188@linutronix.de>
	<20251027084307.151465632@linutronix.de>
	<20251029120405.569f9376@gandalf.local.home>
	<871pmlv2x6.ffs@tglx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bpmc9fgf153he1qx5izuufppj7ycnyzp
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8A88A20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19LX/NQ0mlmCaoXcxz2uQJHkCgpEoxXV9s=
X-HE-Tag: 1761774772-131689
X-HE-Meta: U2FsdGVkX1/Niq6k+mVkffjz6qKXuMJmrTAZSCQTNUhKM+apDjScmFvkdvnm1ObpuPluZYS3sKsiSkdPHYeLy0NEhp7vgVnVYSyBrSguD2ajjK+6JTrcZN0ehs4QgDhuP+cziOlSp5ymcV1+H2JtmmpbSQHb0fuFTmgiUW7YfR6jwoUOzbRgJBe1W4SUAB/T4U0mD+DZ3qT2RpWuxE/9waBiQL/jnr1fij+9omzSSVDa5vupflQGj0CMZ9elmc8bF2KPwsbTTM0wv2pHwW1B3Zrclr4GY2mwLJTK5TGI4P4HTyL8AjbIhvqsf6KqYkHT

On Wed, 29 Oct 2025 22:00:37 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> > Or am I missing something?  
> 
> Yes. None of this is compiled at all when CONFIG_RSEQ=n.
> 
> When CONFIG_RSEQ=y then the slowpath muck is compiled into kernel/rseq.c
> because that file defines RSEQ_BUILD_SLOW_PATH.

What I was missing was that the code was in a header file.

I mistook it as being part of rseq.c and not living in
include/linux/rseq_entry.h :-p

-- Steve

