Return-Path: <linux-kernel+bounces-751095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55091B16537
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545675A3E19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2902DFA40;
	Wed, 30 Jul 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrmuREDT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DBF2E3711;
	Wed, 30 Jul 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895577; cv=none; b=FpkyMd6gMhU1uRpVvFcHvxKoz0Q6cdXjev2MrDRGxjT+QIKQAA4Poof7eP5jzfVry9VsXx6Jywk/IL/5KcaSDCHg/QE6Rod5W0XhM2+5KMBcch8Y1tWzvfUc4FGyrmXcRaaNwnczgFaR3EeOVTmkzGRYW7dHNMZkZiGZNz4bYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895577; c=relaxed/simple;
	bh=/7C8x0xPNrEXA7MgWp9+pFKCoZyEA7fK40HBvd3+qx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZWI26dX1aeYzFhm2uQgjqi1Lo1LR4HZjQweqCxjqA+7+psL2wVU1McH8brrgR5yGhWNx0ErftrUtVON/kagYaf8VRLFZK1hn+D834Rx1NlESCwt4jeSmGR2oJOxPx8HonhYPJ41VuAbDaiLJBtZ3TrYcFiddgdTQAP6N4QdZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrmuREDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB801C4CEE3;
	Wed, 30 Jul 2025 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753895577;
	bh=/7C8x0xPNrEXA7MgWp9+pFKCoZyEA7fK40HBvd3+qx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrmuREDTdVwR80KQUDynctei+lWuxtEhCJO2mwxu2dE6o/llAHlMyCdJoOqUchRDw
	 O/wgyRDttjMMO1sG7lucqDtJTxVUd0Y1R+++sHifw4yJSJ2qXe4lt8yKKQhdoRIVAd
	 srv0ynkRTBQeey39DsTQIWR5wTSzZkr2CUurI3uUUo44rcSgi8ptia9xykHNMjq2tB
	 rnFEH/ZNLyYp+kzk7D1r0TGGHIXcFsXW7DBRnz3FBcMRr6ivCOzfzp03llpRRqFI8F
	 3B17JNooGb3seCD+DTQpi17z0QjtwulLSLs8Fvk3WkFwFprw8B3mGDNMZ2vQwo0Fi/
	 lPaXJ5p7qphkg==
Date: Wed, 30 Jul 2025 13:12:54 -0400
From: Sasha Levin <sashal@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Greg KH <greg@kroah.com>,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aIpSlhPTC9G1AqvO@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>

On Wed, Jul 30, 2025 at 05:59:25PM +0100, Lorenzo Stoakes wrote:
>On Wed, Jul 30, 2025 at 12:36:25PM -0400, Sasha Levin wrote:
>> On Wed, Jul 30, 2025 at 12:18:29PM -0400, Steven Rostedt wrote:
>> > On Wed, 30 Jul 2025 16:34:28 +0100
>> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>> >
>> > > > Which looked like someone else (now Cc'd on this thread) took it public,
>> > > > and I wanted to see where that ended. I didn't want to start another
>> > > > discussion when there's already two in progress.
>> > >
>> > > OK, but having a document like this is not in my view optional - we must
>> > > have a clear, stated policy and one which ideally makes plain that it's
>> > > opt-in and maintainers may choose not to take these patches.
>> >
>> > That sounds pretty much exactly as what I was stating in our meeting. That
>> > is, it is OK to submit a patch written with AI but you must disclose it. It
>> > is also the right of the Maintainer to refuse to take any patch that was
>> > written in AI. They may feel that they want someone who fully understands
>>
>> This should probably be a stronger statement if we don't have it in the
>> docs yet: a maintainer can refuse to take any patch, period.
>>
>> > what that patch does, and AI can cloud the knowledge of that patch from the
>> > author.
>>
>> Maybe we should unify this with the academic research doc we already
>> have?
>>
>> This way we can extend MAINTAINERS to indicate which subsystems are
>> more open to research work (drivers/staging/ comes to mind) vs ones that
>> aren't.
>>
>> Some sort of a "traffic light" system:
>>
>>  1. Green: the subsystem is happy to receive patches from any source.
>>
>>  2. Yellow: "If you're unfamiliar with the subsystem and using any
>>  tooling to generate your patches, please have a reviewed-by from a
>>  trusted developer before sending your patch".
>>
>>  3. No tool-generated patches without prior maintainer approval.
>
>This sounds good, with a default on red. Which would enforce the opt-in
>part.

I don't think we should (or can) set a policy here for other
maintainers. Right now we allow tool-assisted contributions - flipping
this would mean we need to get an ack from at least a majority of the
MAINTAINERS folks.
-- 
Thanks,
Sasha

