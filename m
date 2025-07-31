Return-Path: <linux-kernel+bounces-751428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AE1B16989
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A637B27FE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC66AA7;
	Thu, 31 Jul 2025 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko0+iwE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F16163;
	Thu, 31 Jul 2025 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753920153; cv=none; b=UhBfBjvkUCCx6FasojUs7UheONrt5vCcVutLabg4Ce9AZV/cabBqevl638BvaKiOFx4LqjTj9QS7gR4EYdteXbOFJTW1/mLGHTMGcxotM/IdbIS5Ph2QpKKT45+oz/uwbZ4FZWcpyGQJTlbRVfMSDdfNAis/yg/KvtCvkHPY1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753920153; c=relaxed/simple;
	bh=Xzb7ffAvPR1VyGKCplTYvADdIaIu1Fhp0ZWfn5GccgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7tstCQZVK31ZmO8twOpPAa1uZNyPnaF9apTtSRacz4nzRaQv2frLkm1m6hiX6yDzuUoZhVKIETKhkgShpGw/nU/d+6CXmmqQLVtYiDPMUorBFCM9xmrUxH2U6kYwZfdY72ZHxnvJHVSe+3aSkDeXLsApACnvN1Qy4Wcy4O7nZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko0+iwE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D63C4CEE3;
	Thu, 31 Jul 2025 00:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753920152;
	bh=Xzb7ffAvPR1VyGKCplTYvADdIaIu1Fhp0ZWfn5GccgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ko0+iwE5sVrIwyCCmMwKRTrU56Zx0pd0s6qRzt4atnvH+OYSPUsg2XlmaQfoJ3hP0
	 snja93LCzDutO26r2ev/Sj3f+dQFxKSCBvQKIyNtRmvbpPX6pn58ch4Ul+DDcMh7Aw
	 1n7YfZjh1UjjliDbJxBYAaq06AUEZ1THgJGxtxtlWPPlB/jVP5Rj3gKGTtU+sTxGvB
	 Ba+cxbuBgASPkPYJvDWRsFre0/YEbY7KRwJ579+7j8Oycsw8tfA6ORX4BKpduNMQGs
	 dxcXB8FVoNj966MmeYnJLEIWgCpBxqbbhy25waIZwkObToWu9P3HkPQv6xVHuQrOvO
	 ni+cDYciOuBsg==
Date: Thu, 31 Jul 2025 02:02:26 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>, corbet@lwn.net,
 linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250731020226.3d008bcb@foz.lan>
In-Reply-To: <aIpah6DTRd99mMqb@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
	<20250730112753.17f5af13@gandalf.local.home>
	<158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
	<20250730121829.0c89228d@gandalf.local.home>
	<aIpKCXrc-k2Dx43x@lappy>
	<20250730130531.4855a38b@gandalf.local.home>
	<aIpah6DTRd99mMqb@lappy>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 30 Jul 2025 13:46:47 -0400
Sasha Levin <sashal@kernel.org> escreveu:

> >> Some sort of a "traffic light" system:
> >>
> >>   1. Green: the subsystem is happy to receive patches from any source.
> >>
> >>   2. Yellow: "If you're unfamiliar with the subsystem and using any
> >>   tooling to generate your patches, please have a reviewed-by from a
> >>   trusted developer before sending your patch".
> >>
> >>   3. No tool-generated patches without prior maintainer approval.  
> >

That sounds a terrible idea. I mean, maintainers should be green for good
patches and red for bad ones. It doesn't matter if they're aided or
generated by AI or $TOOL. At the end, the one submitting it shall be able
to properly understand, describe and debug it. It shall also be able to
test it in real life before submitting.

AI can do good things, but can also do bad things. I'd say that anyone
using it shall double-check the code at least twice, checking if are
there any hidden bugs.

I've been doing myself some experiments: sometimes, LLM can quickly point
something broken, doing root cause analysis, completing a TODO requirement
and even write unittests and code.

However, sometimes, AI starts to "allucinate"(*), pointing to things that
don't exist, like inventing fields on structures and command line
arguments that don't exist (it likely inferred the names from projects 
could be using similar patterns/goals).

(*) AI being an statistics tool, the correct term is to diverge.

> >Perhaps. Of course there's the Coccinelle scripts that fix a bunch of code
> >around the kernel that will like be ignored in this. But this may still be
> >a good start.  

This is something that maintainers don't want: yet-another-tool that
newbies wanting to have their one microsecond of fame by getting patches
merged to start sending stuff that weren't tested nor bring any value.
Maybe we can add a text about that.

Thanks,
Mauro

