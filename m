Return-Path: <linux-kernel+bounces-865344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C2EBFCDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35343A5386
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00134C15C;
	Wed, 22 Oct 2025 15:23:32 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64C34CFC5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146609; cv=none; b=kUH8k3nkMtBJGN3/OBD73b+BvEoxeZWw1IE2H9H+MmFrcKp1LZ218qW3ZWJ/hGp0rdmV4SQEKdx9EdhCmGxhGTeIIjlwud5rlZ0BttYBEwV8sa/6ah2yjW8a/ya9kORCJEQ9aYCOqK+R8FnOlLe6MmppIQVS5rC5WKkGukbheOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146609; c=relaxed/simple;
	bh=2d91Ec5e1XBmQwFjMumBSL6+gTMXcPpax3gJ4iHTn8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCjaBKEiEnxFpN+bcU/E3i5h74BrSfVMZ4+OIw+N9m/2mwP83ygJ53dNokqJ0EbnuoOmEY9rrL1HqYC0PchT4K5r+kbt373H7ieN3nMRCtuClkT6GLRUiaGh/EjaCT5V2Flfce3GF/WuB+EUV2MBpGqwTI1mdZ+6i3y8QZdUZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2F385C022C;
	Wed, 22 Oct 2025 15:23:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 322BD2F;
	Wed, 22 Oct 2025 15:23:20 +0000 (UTC)
Date: Wed, 22 Oct 2025 11:23:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Remus <jremus@linux.ibm.com>, jpoimboe@kernel.org,
 rostedt@kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
 linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
Message-ID: <20251022112344.113da927@gandalf.local.home>
In-Reply-To: <20251020104807.GS1386988@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
	<20250924080119.613695709@infradead.org>
	<bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
	<cc6f34bb-7d05-4260-bc02-299fef2bcb01@linux.ibm.com>
	<20251020103940.GP3419281@noisy.programming.kicks-ass.net>
	<20251020104807.GS1386988@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hk7h6g83u9zqp56njg9xdm91uno7j8k9
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 322BD2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+TkvKMeHMGEqsoYB/n1VwpSpHjcZl1tGY=
X-HE-Tag: 1761146600-388656
X-HE-Meta: U2FsdGVkX18CmJkMWoVd04LcIVyLmMu+ZsWdXZs8+WrVvmn7e+mMAtojkkCTJ276bAKnHEVZqFbAEHWj52zhf2JcEC9LkhB5MKKh+wfzOl5CW9+cZY3TwCWauGLuoE8i3TQF9Hok7kuKjiR5eXxF2P/32IX7lxCMxDgTKAebWf0DyD1WdwY1fZdCrjzqxllLDy18QO+Ls0+Pt1u043Ba0MS7zTncxKpRTnPASwSoaPD1gK4mlCna8G0KiI7q+06pj90/7xL0/gipkMzciDZKNSnOC27ocOvQgbcZz7e0+A/D6OglGOST0nTZ4hHIHMd+v5WWh7JilXdIXKt02Li89PWDF6kUrEbahvsH5qH6fY6BSp/2P795nb/dxrXbSo+mmT2VvsjrnWQvTPajouDsPQ==

On Mon, 20 Oct 2025 12:48:07 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Oct 20, 2025 at 12:39:40PM +0200, Peter Zijlstra wrote:
> 
> > Yes, this should do nicely. I've made the changes, I'll do a test build
> > and then push out to the robots.  
> 
> Ok, this now lives here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git unwind/cleanup
> 
> Suppose this all comes back clean from the robots, where shall I merge
> it? tip/perf/core, tip/x86/core ?

I've been basing all my perf work off of tip/perf/core, so perhaps use that branch?

Thanks!

-- Steve

