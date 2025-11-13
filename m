Return-Path: <linux-kernel+bounces-899545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9199C581A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F03A4E2006
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01092E5415;
	Thu, 13 Nov 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SxBq4UZF"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09A2E1F06
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046021; cv=none; b=oWmNOeso1a8rXURlQgc53NU+Aq8RxyaUP7J18uvV0ahRRhnZIBYGFqyVIhtcU+Bi4tnxrxu9x8B3Y5CysFevFrDesfec5IzLvqIBkovOONYVXpVqpgvs1sN5ptS8ZxoUs9QHE7KNoFJ49pL652gT6WG7PTnTvolFcAJ6Ehri7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046021; c=relaxed/simple;
	bh=uzaf6Evj711B9QYw/7gXMBS3bnaZlmZILwfOFV6p5+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBXUleWwoYJkFWiEgc8SpqJZXAaEVbUD72Ck47nIJ2aDIhj9Z7+3xn58ZTucWQJIs8xIz9grM2+gP+7LftbEw0+XlXPZDJNKRj8HWym90A39AQpNl+dfJHZhV2YSkSm82x3klGij04EVuaKIWQaPFXZlk1yLa571lTV0XoGt9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SxBq4UZF; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 14:59:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763046012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk7LczTG/IQm+4uN1QQxImg0cq/uLnlhPZ9Mr9f9U00=;
	b=SxBq4UZFv3BhbD4++7+ZRWTKf5mcxW6QdYZk9HL8uQCpZhUq6Dw+66Ohfp0OYmq65ZZ2Wr
	x72BOIh12oere1jbzhQZ5/N4XUZ9E5lB7I00pfMtoUI3nx2XMzFDz3mFfMCNgXir/mQtSm
	zjhxRoHfdkrEtUS5HYGk0wQeOdl/ORo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Kevin Cheng <chengkev@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/14] x86/svm: Cleanup LBRV tests
Message-ID: <66tns2r4rgrugltijbrxoqyvrpxy6udebpod2udcjnuu6qhsj7@roagtke7znaq>
References: <20251110232642.633672-1-yosry.ahmed@linux.dev>
 <20251110232642.633672-13-yosry.ahmed@linux.dev>
 <1f39d5a3-e728-4b2b-a9c6-50cbc4fffd17@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f39d5a3-e728-4b2b-a9c6-50cbc4fffd17@amd.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 13, 2025 at 05:28:11PM +0530, Shivansh Dhiman wrote:
> Hi Yosry,
> 
> I tested this on EPYC-Turin and found that some tests seem to be a bit flaky.
> See below.

Which ones? I was also running the tests on EPYC-Turin.

> 
> On 11-11-2025 04:56, Yosry Ahmed wrote:
> > @@ -3058,55 +3041,64 @@ u64 dbgctl;
> >  
> >  static void svm_lbrv_test_guest1(void)
> >  {
> > +	u64 from_ip, to_ip;
> > +
> >  	/*
> >  	 * This guest expects the LBR to be already enabled when it starts,
> >  	 * it does a branch, and then disables the LBR and then checks.
> >  	 */
> > +	dbgctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> > +	TEST_EXPECT_EQ(dbgctl, DEBUGCTLMSR_LBR);
> 
> This TEST_EXPECT_EQ is run when LBR is enabled, causing it to change last
> branch. I tried to move it below wrmsr(MSR_IA32_DEBUGCTLMSR, 0) and it works
> fine that way.

It shouldn't matter though because we execute the branch we care about
after TEST_EXPECT_EQ(), it's DO_BRANCH(guest_branch0) below. Is it
possible that the compiler reordered them for some reason?

I liked having the check here because it's easier to follow when the
checks are done at their logical place rather than delayed after
wrmsr().

> 
> >  
> >  	DO_BRANCH(guest_branch0);
> >  
> > -	dbgctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> > +	/* Disable LBR before the checks to avoid changing the last branch */
> >  	wrmsr(MSR_IA32_DEBUGCTLMSR, 0);> +	dbgctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> > +	TEST_EXPECT_EQ(dbgctl, 0);
> >  
> > -	if (dbgctl != DEBUGCTLMSR_LBR)
> > -		asm volatile("ud2\n");
> > -	if (rdmsr(MSR_IA32_DEBUGCTLMSR) != 0)
> > -		asm volatile("ud2\n");
> > +	get_lbr_ips(&from_ip, &to_ip);
> > +	TEST_EXPECT_EQ((u64)&guest_branch0_from, from_ip);
> > +	TEST_EXPECT_EQ((u64)&guest_branch0_to, to_ip);
> >  
> > -	GUEST_CHECK_LBR(&guest_branch0_from, &guest_branch0_to);
> >  	asm volatile ("vmmcall\n");
> >  }
> >  
> >  static void svm_lbrv_test_guest2(void)
> >  {
> > +	u64 from_ip, to_ip;
> > +
> >  	/*
> >  	 * This guest expects the LBR to be disabled when it starts,
> >  	 * enables it, does a branch, disables it and then checks.
> >  	 */
> > -
> > -	DO_BRANCH(guest_branch1);
> >  	dbgctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> > +	TEST_EXPECT_EQ(dbgctl, 0);
> >  
> > -	if (dbgctl != 0)
> > -		asm volatile("ud2\n");
> > +	DO_BRANCH(guest_branch1);
> >  
> > -	GUEST_CHECK_LBR(&host_branch2_from, &host_branch2_to);
> > +	get_lbr_ips(&from_ip, &to_ip);
> > +	TEST_EXPECT_EQ((u64)&host_branch2_from, from_ip);
> > +	TEST_EXPECT_EQ((u64)&host_branch2_to, to_ip);
> >  
> >  	wrmsr(MSR_IA32_DEBUGCTLMSR, DEBUGCTLMSR_LBR);
> >  	dbgctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> > +	TEST_EXPECT_EQ(dbgctl, DEBUGCTLMSR_LBR);
> 
> Same thing here as well.
> 
> > +
> >  	DO_BRANCH(guest_branch2);
> >  	wrmsr(MSR_IA32_DEBUGCTLMSR, 0);
> >  
> > -	if (dbgctl != DEBUGCTLMSR_LBR)
> > -		asm volatile("ud2\n");
> > -	GUEST_CHECK_LBR(&guest_branch2_from, &guest_branch2_to);
> > +	get_lbr_ips(&from_ip, &to_ip);
> > +	TEST_EXPECT_EQ((u64)&guest_branch2_from, from_ip);
> > +	TEST_EXPECT_EQ((u64)&guest_branch2_to, to_ip);
> >  
> >  	asm volatile ("vmmcall\n");
> >  }
> Reviewed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> Other tests look good to me, and work fine.
> 
> Tested-by: Shivansh Dhiman <shivansh.dhiman@amd.com>

Thanks!
> 

