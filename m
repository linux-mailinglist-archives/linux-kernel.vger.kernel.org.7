Return-Path: <linux-kernel+bounces-731993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC74B060C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729D21C42B54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54339202C49;
	Tue, 15 Jul 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVEgVSM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F0202C26
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588138; cv=none; b=G+yGk0iaoNO9LcK5x51km08X6XK0mMIJqhKIRqPiQgZbS+JfVhdTTCyrNTeo2POKwYRCQZ5FV4jdAWKD55CpP++gkp0+SsOqTxnmmJ1GrlRQ3pfFBqWJn2TkEL7KiHT6wp2nvB1OtYI4eCXxS6hbv4f/7RiSQzKx84Exw8cpdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588138; c=relaxed/simple;
	bh=d5BQBqrR42o5J743Ypk7CrVCgGVYQ58Kfjd6IBpO1Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZtQjB4r9UzoB+e57hfFGEOIsHAPpPwcb53qg5ZgwP1uF1tc7rtxbBqPUW3R7N9B7oyroOtfnKPlzJoA3KJLTfND6qnnYxGW/e0Ago0CNPYjMlTtjKFlxqrUZQeDbSZLPf4qum8zBPHS09Jypc4K+lTr7UyWw/APoSMOP4Lt/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVEgVSM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC23C4CEE3;
	Tue, 15 Jul 2025 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752588138;
	bh=d5BQBqrR42o5J743Ypk7CrVCgGVYQ58Kfjd6IBpO1Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVEgVSM5N26819X4lipZMDyMe34jGjFfmoBrXpftgAESk6apUITUs7awcXwXdVesY
	 MxvVDf0+0JH/bLMNI7vd1EBVTbImSlolEmzozleH423ApiR8OKHuLMz2TMF+hoPyc/
	 MDDAH6zKqXMImFGCdmA7p7e3C4rg/du2I5Dp6vb06npSYQ+YJq1PbrMe8CVJvxATsV
	 ODBo8ScygHfIFquS69M/XxBuF04M7RMkeGI2A2xzRvmXoOR2RLyFOg/sy5XGvxFeoW
	 9uQq6JqRz1h1E54NAbQUYzX8+iBoYQk1LU1cx2NKAbgH/h9rBjAOx/8TeN8ekAq20p
	 sn8FjH3qFsuFA==
Date: Tue, 15 Jul 2025 15:02:13 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, osandov@fb.com, leo.yan@arm.com,
	rmikey@meta.com
Subject: Re: [PATCH] arm64: traps: Mark kernel as tainted on SError panic
Message-ID: <aHZfZbxLGyFjJpNo@willie-the-truck>
References: <20250710-arm_serror-v1-1-2a3def3740d7@debian.org>
 <aHQ3Lu27_mLfR8Ke@willie-the-truck>
 <t3v2xvjal67bl5dwyatwgf46tnr2ikxnq62iqmda544llcd7oh@ws3nnrfp7r5p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t3v2xvjal67bl5dwyatwgf46tnr2ikxnq62iqmda544llcd7oh@ws3nnrfp7r5p>

On Mon, Jul 14, 2025 at 05:26:43AM -0700, Breno Leitao wrote:
> On Sun, Jul 13, 2025 at 11:46:06PM +0100, Will Deacon wrote:
> > On Thu, Jul 10, 2025 at 03:46:35AM -0700, Breno Leitao wrote:
> 
> > > --- a/arch/arm64/kernel/traps.c
> > > +++ b/arch/arm64/kernel/traps.c
> > > @@ -931,6 +931,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
> > >  
> > >  void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
> > >  {
> > > +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
> > >  	console_verbose();
> > >  
> > >  	pr_crit("SError Interrupt on CPU%d, code 0x%016lx -- %s\n",
> > 
> > If we're going to taint for SError, shouldn't we also taint for an
> > unclaimed SEA?
> 
> Yes. I was not very familiar with SEA errors, given I haven't seen on in
> production yet, but, reading about it, that is another seems to crash
> the system due to hardware errors, thus, we want to taint MACHINE_CHECK.
> 
> What about this?
> 
> 	Author: Breno Leitao <leitao@debian.org>
> 	Date:   Mon Jul 14 05:16:55 2025 -0700
> 
> 	arm64: Taint kernel on fatal hardware error in do_sea()
> 
> 	This patch updates the do_sea() handler to taint the kernel with
> 	TAINT_MACHINE_CHECK when a fatal hardware error is detected and
> 	reported through Synchronous External Abort (SEA). By marking
> 	the kernel as tainted at the point of error, we improve
> 	post-mortem diagnostics and make it clear that a machine check
> 	or unrecoverable hardware fault has occurred.
> 
> 	Suggested-by: Will Deacon <will@kernel.org>
> 	Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> 	diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> 	index 11eb8d1adc84..f590dc71ce99 100644
> 	--- a/arch/arm64/mm/fault.c
> 	+++ b/arch/arm64/mm/fault.c
> 	@@ -838,6 +838,7 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
> 			*/
> 			siaddr  = untagged_addr(far);
> 		}
> 	+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
> 		arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
> 
> 		return 0;

Yeah, I reckon so. Probably just fold these into a single patch, though.

Cheers,

Will

