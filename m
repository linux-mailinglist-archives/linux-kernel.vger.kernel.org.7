Return-Path: <linux-kernel+bounces-778585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97359B2E7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A030AA6330
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2DA3314A5;
	Wed, 20 Aug 2025 21:41:08 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75372765C9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726068; cv=none; b=bPj8eo8Fu7dzEu5snZlzy+HQhk92HnMqWFxQf3Di2jd9Ng7HQtswNwqAXajKsGDg04TQubrpVCD8c3ectYaUy9JkoF+DWiHpzti3bggy2EwZQEf1MrT9zGMx6Nts3wpOF2om71GmelRhoUmHj+YvYYVk8rZg8/bldo6uodvSRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726068; c=relaxed/simple;
	bh=kl5KF1g7TcqLHhja+Q2NYapGPEBXXCGdvVH6XxCqVYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdDadAA8TNVko/tA3VZaUZJjlDeccbl6Rrpl/aO5txjc99IR65e4pvH8aMXzj87bDvsiMR8ZY+ezci4bkIao7ri422TCrBseBRBBVslqKAaZFmHma84MHww/i+TMV+AmsxMOxUUjufLlO4jqfvFGyNCjEKwIwKzhgQDVnncS9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id ABF461163A9;
	Wed, 20 Aug 2025 21:41:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 5E2CF20019;
	Wed, 20 Aug 2025 21:41:01 +0000 (UTC)
Date: Wed, 20 Aug 2025 17:41:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: Make x86@kernel.org a list and not a maintainer
Message-ID: <20250820174103.3b3eef1e@gandalf.local.home>
In-Reply-To: <e97983fd-b6ee-403a-87c7-53ff37468551@intel.com>
References: <20250820152054.165811ea@gandalf.local.home>
	<e97983fd-b6ee-403a-87c7-53ff37468551@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8ty6fwdeqn44mpfpqudt43chw7afdtop
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5E2CF20019
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0Z5ga12rGd9+K90rKiWvDuewRABuycHM=
X-HE-Tag: 1755726061-828463
X-HE-Meta: U2FsdGVkX1/8yRYdufd5HGk9ceOmUWr0/F7272WSdQ5DGFyqsXQJIUgNaj3MGcPN62GDivfT5qc6Pflnqb4Qa6ma9sDzGyXJyoUXY4swFAuWw+pCTp+HJAFWRscgEPrenXBLTTwQPYxpa+p1m0OdSm2coonM4RTlzanOCX3LoknfGZQ9Yxt4wet9MPj5+RRJau+WsGbJ9EhYWVebcTH7C1D0uDlds3zlz5yyhBBIjUh/+YuNuailEMnRDDdHj87NFs9GyMQOnjZ8G2J1C7Rc8r31asOnjXuK7oPkmq9EPLd8nem6OWsE6qv1fQHQ1dU0Nh5WXPHW28F01O+z1uXUWD0K484JC0pIgd1aFuIRZz6QTaN+Fob/25Dvy0+gafV70t+OqRdAFgM=

On Wed, 20 Aug 2025 14:37:57 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> > The MAINTAINERS document starts with:
> > 
> >         M: *Mail* patches to: FullName <address@domain>
> > 	[..]
> >         L: *Mailing list* that is relevant to this area  
> 
> Yeah, it's not a person, but it's also not a list that folks can
> subscribe to. So there really isn't a good fit for it. I've never heard
> of it causing any problems, so my inclination would be to just leave it
> as-is.

My complaint is that it's listed as both 'L' and 'M'. It should at least be
consistent.

Should it become a list?

-- Steve

