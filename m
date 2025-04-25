Return-Path: <linux-kernel+bounces-620670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B208FA9CDFC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC309C6555
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48BC199E84;
	Fri, 25 Apr 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="djEJ3HED";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mk7sP/Sv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7E15B543
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598217; cv=none; b=BXqdX2kkxs/9tXrhVc0x4FMvwgBR8Adb9ls4C7w+wpmBAL3wtXzXhxU1ScMRK2IpiOr9QrODKHWZli+ssy9TSOiZ8QLn0Husp9aL/wAJSU+JJI2QS9zZbKuvPTh+nnscj7RI+lcPtorZonh1O3t80L21bAi0hocfjraG4SgJVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598217; c=relaxed/simple;
	bh=H+fW7Wlpu8aJdTi4gApR4bCPJd9Lfy8PXNCMEMvnBh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILdSdU11QvLI0os3okCgDf/+2Wsp7bnh3JucqNYFUqCzqSB8GG2Ona4j5KPyIcFDs5jUXHK5nWA83fUcND9Aot1DglD+lPHzdqCpNzjeZ/Gqlgg83oaOf2GumRJbaDCuZwl0GEEyXOG9zz6143y1hePHO557hdXcMC/9gNE5Dg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=djEJ3HED; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mk7sP/Sv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Apr 2025 18:23:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745598213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jAaSIMhxlsFVyasL4fNhdLj8S0Zxik+9V6e2ixNYehw=;
	b=djEJ3HEDJRMRiGfx411Itey1aaOMWN2KekJ08l9mt561flfUhUVsE+AYrsYIMNmlS/tJ6X
	PBcYjys6hC4CcV7KFD2HTvY0ABTgHLprCLM4T1bxBY0qSSYwjBCmBEb0kf9IR/DSb84byK
	s4lFh2zz3klwQX4CyD5NlZjlIgUyHDzIXRQGsK3mER82gvHJ/Woi7xzBKy2WCsl03gzK6S
	cFoMe/rDLpb0Vaw40FgqO6mT1mYyLyV5HOzequpg4lpKw/BzzhVlVGWTQdngmaXCOKGDa/
	bRPi8r/EH+v4qbKxBQKJj3G1u8i56z4njC5ZXLBVec6SJeqf4OrddHYAkpah6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745598213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jAaSIMhxlsFVyasL4fNhdLj8S0Zxik+9V6e2ixNYehw=;
	b=mk7sP/SvMwdYxg/KeT/YGVBt3XA+4NXrRJo4uu3EVWVMZWny8roE8rsz+EiYa34nNrtx5W
	Q1Sy1hJ7iejTDlDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: npiggin@gmail.com, vaibhav@linux.ibm.com, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
	gautam@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc: kvm: use generic transfer to guest mode work
Message-ID: <20250425162331.qwpzuc-8@linutronix.de>
References: <20250421102837.78515-1-sshegde@linux.ibm.com>
 <20250421102837.78515-2-sshegde@linux.ibm.com>
 <20250424144215._ooDjDz9@linutronix.de>
 <365ba747-9311-45ab-b798-80ba4e578796@linux.ibm.com>
 <20250424183811.7_MLThpt@linutronix.de>
 <2891b989-6249-4e84-969e-f11af3f92b0b@linux.ibm.com>
 <20250425133131.DTvWJE29@linutronix.de>
 <5cc88718-13ff-4220-a8f6-c988a919aa65@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cc88718-13ff-4220-a8f6-c988a919aa65@linux.ibm.com>

On 2025-04-25 19:54:56 [+0530], Shrikanth Hegde wrote:
> > > But looking at the semantics of usage of xfer_to_guest_mode_work
> > > I think using schedule is probably right over here.
> > > Correct me if i got it all wrong.
> > 
> > No, if you do xfer_to_guest_mode_work() then it will invoke schedule()
> > when appropriate. It just the thing in kvmhv_run_single_vcpu() looks odd
> > and might have been duct tape or an accident and could probably be
> > removed.
> > 
> 
> I was wondering xfer_to_guest_mode_work could also call cond_resched
> instead of schedule since for preempt=full/lazy is preemptible
> as early as possible right?

No, I think it is okay. For preempt=full you shouldn't observe the 
flag in xfer_to_guest_mode_work() so it does not matter.

Sebastian

