Return-Path: <linux-kernel+bounces-854837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE366BDF856
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3850E18857E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF642BCF4C;
	Wed, 15 Oct 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfMCKQXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235CC171C9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544143; cv=none; b=kpwe+CXyazaq72ltGH19UKzOb/4PufoHC1EDqrqGxoNXSW1lcLH0L+0zW3KedL14BX1oCEICQvFDmcfcV0gfFfdZzhKX+hH+PIEIllNapewEk6RvmkDhLeI8j1NGqFgQetIayhMpM8bnLLiBoCRKEUZQe0Wx6EfYGJZyN6eSHJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544143; c=relaxed/simple;
	bh=mP9l2Y/KWBVkIMc0hLmAOsAKhzNJjLUGoHmm7dBNPOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS8hep6sOW6ogDF2SnEtKZ547+MlorB/GHoijt/8a94GvVWO3C07cDQntYiSSm/IH4hDvhsvcLtgt5kWZWgKmq3rXuzymuPvnOIA5oc0s5D4RVPmdnhBfoJ/vk0xOaedUMCsSGGFvAqHLUVNPuKzehjo+AgWgWBce8bApi6bk7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfMCKQXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3102C4CEF9;
	Wed, 15 Oct 2025 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544142;
	bh=mP9l2Y/KWBVkIMc0hLmAOsAKhzNJjLUGoHmm7dBNPOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfMCKQXXjXJLQWaJndyD+ED0i6TASkDwZzt3tH4Pl6tut6FKKi93t/lYDf9+/bQjm
	 qtfG5Oze7mqlcGuUoJn/zZ87aBEF3Rl6RkUpwdS7K0SmUTYqogX+6r2AU8vfmiCo6f
	 Rbi4DKgLOVX7j28fQGGQz8HjOOTSXbHzX+ifvBB388zScZ2TaPfAozZiBzM4FtiK9Z
	 wjH/1299vYkjbSGy7GcX5GOvzmJ6kEM4bEwANVxnYNL834Ej1wg7VAapb4t3CdzT56
	 vkNb7cvdhaIB9YYmJCfjMfk/QV20ix7ctVgG4Ukbbd4G3zvo8wDNN6cQwBj1EEYU9L
	 bgGvaPJvJz4zg==
Date: Wed, 15 Oct 2025 09:02:19 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Aaron Rainbolt <arraybolt3@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
Message-ID: <a5kvnas7cttg3pxqdxye7qhyesbtyulhhdiunl2hr5tfmecpbz@y4ggjfafqawn>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251014231039.6d23008f@kf-m2g5>
 <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <cnwawavsdedrp6yyylt2wqiglekwsgrofimkvh32fknj676xsh@4vyzzoky5hzd>
 <LV3PR12MB9265837FA51DFD9D2F11474D94E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265837FA51DFD9D2F11474D94E8A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Oct 15, 2025 at 03:51:01PM +0000, Kaplan, David wrote:
> > On Wed, Oct 15, 2025 at 01:53:31PM +0000, Kaplan, David wrote:
> > > > If `root` is capable of setting `mitigations=off` via this interface,
> > > > doesn't that somewhat defeat the purpose of denying `/proc/kcore`
> > > > access in lockdown confidentiality mode? Assuming one is running on a
> > > > CPU with some form of side-channel memory read vulnerability (which they
> > > > very likely are), they can turn off all mitigations, then read kernel
> > > > memory via one of those exploits.
> > > >
> > > > There should be a one-way switch to allow denying all further writes to
> > > > this interface, so that once the system's mitigations are set properly,
> > > > any further attempts to change them until the next reboot can be
> > > > prevented.
> > > >
> > >
> > > That's a good idea, there could be a separate mitigation_lock file
> > > perhaps that once written to 1 denies any further changes.
> >
> > Wouldn't the enablement of lockdown mode effectively function as that
> > one way switch?
> >
> 
> I'm not too familiar with lockdown mode, but that gets enabled (with
> right cmdline options) during boot right?  I guess the question is
> would we want to allow any window for userspace to reconfigure things
> and then lock things down, or say that if you enable lockdown then
> this interface is completely disabled and you need to specify your
> mitigation options on the cmdline only.

Yeah, I would say the latter, otherwise it defeats the point of lockdown
mode.  Note that lockdown mode can also be enabled at runtime.

-- 
Josh

