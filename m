Return-Path: <linux-kernel+bounces-775871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F9B2C5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CA15A327B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BA341AA9;
	Tue, 19 Aug 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J3nXfLWG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7D340D99
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610754; cv=none; b=O0O7S8MRl3N3XhJQlVvNcQHCRwXa/GNi35A7flUb2aJ4dzhM8o279F5Cpot6DzpMgc5NuC77sy1L9Ri/wgTqlsyjoI8v+ZPF+s2yHnWgoabHpKmSw9n8klo/kbt85sFA2Ozz1Huu9NU6B/G8ZuCLkn3wU4I+gk9t7zUiXmgdMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610754; c=relaxed/simple;
	bh=lmKHpEKi3S5YBvxye2qvFLbNi4kum+qK2ZmgWcbSeEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmHPnxzRbmoGTa/e6Nt4zqn5mugeSGTk/S0UsWGE0mGSiUrC7MoT2WLqA5q8RMYf42XSFMySWeaKYdGn+1X/weLXmR8D5uUCuEL7vHCsB0wQ7HL/e2a5GHIJbuO63PceAeh94wDxdO0RucTGcZDi8bPnv/2vbOZpTJnrnUwLgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J3nXfLWG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SmYdMrGRh3K2M4DnEijB87LQEQALay2tMSSPCVuo5aA=; b=J3nXfLWGCnnRwz2Wt8YraSjB23
	HF01VOMXfkV9v9Q1f6QGRX2J2DQNgmoLBBK2r8tXjv0xjGONDuuNVcKj8NtaftJabxCg+EG/4ihES
	0N67RxQXsdFYKHIQYiIooWMZTN1JSnFjlPwDRL3iwtzWVsq9ecXfjI59KtCWnxpgQEcjv6RgEfphf
	S0UHCbretJzK2DXMolYfyI/+gR4Ui7ixq3Hbkd6300PYop+BbzvQPKkjeG97C8uDsgA9pFZAqGttu
	PMoA5EnTJVNvLep4jzwSniP2SC6Fevo2E9teS+PacYzZ69llUmYEUEPWKfLDtm3DunwyS4IJd7oIy
	oN/q9VHQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoMYK-000000002W5-09AU;
	Tue, 19 Aug 2025 13:39:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EDBAD30036F; Tue, 19 Aug 2025 15:39:02 +0200 (CEST)
Date: Tue, 19 Aug 2025 15:39:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	tglx@linutronix.de, dave.hansen@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, jolsa@kernel.org,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	dapeng1.mi@linux.intel.com, ak@linux.intel.com, zide.chen@intel.com,
	mark.rutland@arm.com, broonie@kernel.org, ravi.bangoria@amd.com,
	eranian@google.com
Subject: Re: [PATCH V3 05/17] perf/x86: Support XMM register for non-PEBS and
 REGS_USER
Message-ID: <20250819133902.GJ4067720@noisy.programming.kicks-ass.net>
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
 <20250815213435.1702022-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815213435.1702022-6-kan.liang@linux.intel.com>

On Fri, Aug 15, 2025 at 02:34:23PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Collecting the XMM registers in a PEBS record has been supported since
> the Icelake. But non-PEBS events don't support the feature. It's
> possible to retrieve the XMM registers from the XSAVE for non-PEBS.
> Add it to make the feature complete.
> 
> To utilize the XSAVE, a 64-byte aligned buffer is required. Add a
> per-CPU ext_regs_buf to store the vector registers. The size of the
> buffer is ~2K. kzalloc_node() is used because there's a _guarantee_
> that all kmalloc()'s with powers of 2 are naturally aligned and also
> 64b aligned.
> 
> Extend the support for both REGS_USER and REGS_INTR. For REGS_USER, the
> perf_get_regs_user() returns the regs from the task_pt_regs(current),
> which is struct pt_regs. Need to move it to local struct x86_perf_regs
> x86_user_regs.
> For PEBS, the HW support is still preferred. The XMM should be retrieved
> from PEBS records.
> 
> There could be more vector registers supported later. Add ext_regs_mask
> to track the supported vector register group.


I'm a little confused... *again* :-)

Specifically, we should consider two sets of registers:

 - the live set, as per the CPU (XSAVE)
 - the stored set, as per x86_task_fpu()

regs_intr should always get a copy of the live set; however
regs_user should not. It might need a copy of the x86_task_fpu() instead
of the live set, depending on TIF_NEED_FPU_LOAD (more or less, we need
another variable set in kernel_fpu_begin_mask() *after*
save_fpregs_to_fpstate() is completed).

I don't see this code make this distinction.

Consider getting a sample while the kernel is doing some avx enhanced
crypto and such.

