Return-Path: <linux-kernel+bounces-598788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4E3A84B11
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916BE173AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3111EF377;
	Thu, 10 Apr 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nOiU4CeG"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985E1EEA3B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306335; cv=none; b=fDDllMHyTzyqXK56ek6huiJ+H7xoW4kVXr99nXyuc3lW9oZAyRbRlrV3+OaOk5xs9C9xc6fNcpBKI+AL7ofLlK0EC8S70FGZb5zi8ZnRJR3m58WwIvga8VJOlLHJNQe2FT+nvZbYeTdSEk74o6A/RArNEy6EJVNFFDJ52451Oj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306335; c=relaxed/simple;
	bh=o0sL38ZYJOmlgi+WziErMCbewxn1adCrNNO1f2e04xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZpjFI6scFiojiyhJvRSZn+/6TrUY2al43SSKzzpUmlIZfMS0hwBFSIrvdO6MCqM92HSOwT9WtI36rzRBYmWH40Fn5Tt36EgxrXfSUFEAE3j07KO8D7fuIr39OmyQEo1/+y0f0OyPBvArYC7+6kqojqd/LSKs48S/hzVDx4a3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nOiU4CeG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 10 Apr 2025 10:31:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744306329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ5oOh0zz7StublrYqB04NHmYQEpJz4EGl117RgnK/c=;
	b=nOiU4CeG/HCKdRnVk2rzbyL1a26TgtN4ID/0kj8PycK0GSez9OR4nXI5Czps2kr/tPX8+q
	lBFg0gkwx9t5hbklthzPmlTofoD0xxeXZImqFrMBsGzxQtaYuieFWKQz0TSzaHWD6mrPKZ
	Wa+4EDRSFkvHlHvvFfn6BxW8fFJt/g4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	darren@os.amperecomputing.com
Subject: Re: [PATCH] KVM: arm64: nv: Forward hvc traps if originated from
 nested VM
Message-ID: <Z_gAgixMjKQJsWJg@linux.dev>
References: <20250410070743.1072583-1-gankulkarni@os.amperecomputing.com>
 <86mscolc0b.wl-maz@kernel.org>
 <4d1bdea5-43c3-4ca9-9275-feadf158e86e@os.amperecomputing.com>
 <86jz7sl25r.wl-maz@kernel.org>
 <91339d4d-38d7-4512-9fda-339bb4c2a3f4@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91339d4d-38d7-4512-9fda-339bb4c2a3f4@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 10, 2025 at 06:52:45PM +0530, Ganapatrao Kulkarni wrote:
> 
> 
> On 10-04-2025 04:22 pm, Marc Zyngier wrote:
> > On Thu, 10 Apr 2025 11:20:24 +0100,
> > Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
> > > 
> > > 
> > > 
> > > On 10-04-2025 12:49 pm, Marc Zyngier wrote:
> > > > On Thu, 10 Apr 2025 08:07:43 +0100,
> > > > Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
> > > > > 
> > > > > It was discovered while trying selftest(smccc_filter) that the
> > > > > hvc trap is getting forwarded to guest hypervisor even if it is
> > > > > originated from itself.
> > > > > 
> > > > > HVC traps from guest hypervisor should be handled by the host
> > > > > hypervisor and traps originating from nested VM should be
> > > > > forwarded. Adding check to forward only if the hvc is trapped
> > > > > from the nested VM.
> > > > 
> > > > I disagree. HVC from EL2 must be routed to the same EL2. HVC from EL1
> > > > must be routed to the EL2 controlling EL1.
> > > 
> > > Thanks, Understood, In NV case, hvc has to be forwarded to L1
> > > irrespective of it origin (L1 or L2). Need to add hvc handler in the
> > > smccc_filter.c for the vm (when run as L1), so that it is handled and
> > > returns with required args set.
> > 
> > Why? This test checks under which conditions an HVC/SMC gets routed to
> > userspace. What does it even mean to test HVC if it doesn't make it
> > outside of the guest itself?
> 
> smccc_filter.c has 2 tests (test_filter_denied and test_filter_fwd_to_user),
> which runs the vm(guest_code).
> 
> I was trying to modify test_filter_denied to run in vEL2, which led to this
> patch/discussion. I agree, it does not makes sense to run this test for
> vEL2.
> 
> test_filter_fwd_to_user is not feasible to run in vEL2.
> Thanks for the feedback.
> 
> BTW, I could add hvc handler and run test_filter_denied in vEL2.

I would much prefer that the entire test be adapted to consider the EL of
the guest, only testing the behavior of SMCs for EL2.

Thanks,
Oliver

