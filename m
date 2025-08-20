Return-Path: <linux-kernel+bounces-778593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66869B2E7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252171C84A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744B334377;
	Wed, 20 Aug 2025 21:49:58 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34E2BE7A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726598; cv=none; b=qJ1G9iHmJRlsst5kdVARoL07gMeI+1QBVnB4VSPxY+jPEN33uIgbkbfz0WPZGBtR+jl4d6BQssdnm1lJTdBYLXkRppe7nu5h+aSA1Z3X4+kgaxxY43HM6vfZPwS7SVUD/zkfOLrI+NIs39E0WQaVAWzZbD+CVuJJFuzknHOD6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726598; c=relaxed/simple;
	bh=5JWHqo9BJ1lUZZUd0XZCny8tRBRivym52om9SVEIre0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1klGguim/CsT5LpWVy3C958v8vzpbYsN7BWGAna+fttWoCbGlRLFE7986dwEVeh1KLYSkIw3FtzLrRqrCEMMkVI/L3ptlxDm55QnC92WJG51LK8Q79QDzvP5kzhH8AhK9wnB/L5Y6QPpGQzmz52k1g8nhd18e+iEultfwZvZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 403821D90CE;
	Wed, 20 Aug 2025 21:49:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 0494B2002D;
	Wed, 20 Aug 2025 21:49:51 +0000 (UTC)
Date: Wed, 20 Aug 2025 17:49:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: Make x86@kernel.org a list and not a maintainer
Message-ID: <20250820174954.6a8ec50a@gandalf.local.home>
In-Reply-To: <f472c4ab-9ca2-4183-8f95-8390bc35e068@intel.com>
References: <20250820152054.165811ea@gandalf.local.home>
	<e97983fd-b6ee-403a-87c7-53ff37468551@intel.com>
	<20250820174103.3b3eef1e@gandalf.local.home>
	<f472c4ab-9ca2-4183-8f95-8390bc35e068@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: j1twu6h8pjy6gh19bp3akngbbxdqag4n
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0494B2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19z4lYHuKNM6qLdih6nhvpqeAshUznYZ90=
X-HE-Tag: 1755726591-240932
X-HE-Meta: U2FsdGVkX19DMOh3zUIU4jioGUVInPRRKyvMaLbvNg0Pn2EpN9Qbv2cl2djT0gEH5pRXi4Ot0w0k9+PNWWLlLrfj+3hWlrxNfLquF8UJKduq3XWYce5cOc/bF8Wwjq27Agl6RwXEuzGUQIrHgPTZ97oRNyHVesCmtvJil7AnYYnMu3R3HrNU64j8txsml5KHuZHkoGeMfStcYhI/kDYrsjjL+IKbsYZidVMCpEb+huyT7PAHpXRE+pu9CNJQzRnA7RuVGJ2YsHWFqpZhAgXi/MLdOm5bc/+DeRizibQhG7kOLFd40IsKVFrkbp4B37Qi40dOAHTZAokJL5ahNhwJCqyIcZDj8TSMRBSFIgjjaN3+qML2wbHBz51BFqY/mIdD2YeDhTG8qY4=

On Wed, 20 Aug 2025 14:44:40 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> But I'm still not seeing much of a problem here. :)

My confusion is that I put the lists into the 'To' section and the
maintainers into the 'Cc' sections when I send out patches.

I just noticed this when I added the x86@kernel.org to the 'Cc' section and
decided it should have been in the 'To' section.

-- Steve

