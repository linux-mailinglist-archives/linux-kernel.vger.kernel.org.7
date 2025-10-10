Return-Path: <linux-kernel+bounces-847655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE9BCB5C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DF11A62D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CAE1F3FED;
	Fri, 10 Oct 2025 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5il7IH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3C4414
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059956; cv=none; b=c+Bg1sUU3NDT1D+z4uIHxxRY5vqWFU9bXlUC5jm8+j0i9jxNBVeYim5QgmO9AmtB8ZM9+3fhW/yPM+pbE7szXIafCu03P3Cxc2oZWJj3bvadhg6iLNOgWEUTIsAuTqwZU/X/sC/5wj0/+bbq2zakgX/RanCnPwD/llHLvnbbTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059956; c=relaxed/simple;
	bh=KPS3uZjL/nqDu+c8uW3Ba+heOFI7/b8h5gZFf0NzBoo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kbpUrrPBLypOiEFTzfCP8wE/fh24kKeP7T6qVLVWoq5i1KUAbjd07YYBAd5ft+vlkvKsJoSP4oQB/1WUafyKk85LTkZ/TMR30DeNcXUr5fWdixWx26Qj1puLxfhwKmYNSPWL2ROo2fzkkaBNHOPej3bz/4ACb/KLH8UoQAQdTk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5il7IH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B54AC4CEE7;
	Fri, 10 Oct 2025 01:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760059956;
	bh=KPS3uZjL/nqDu+c8uW3Ba+heOFI7/b8h5gZFf0NzBoo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=d5il7IH3Rn7Ej5PVeLqMJ3U50pUuHHxSkdMF0LTmPIzYEgo+ezeOsJnVT/yqURy26
	 DkG7jSHBW7WtPksGBe97EG+rgZ63H68sf0QE+ek0SEhF4YM7Zic0Tjp8G2lkSUe2TC
	 Si1bZVQx75CdDqJHIyjt3W4XQtxC5xx7vRvWle2Soqxgxokk5YIf5a2evqiQ7s6u6v
	 mHTkpiwqfr9ydQdjrm1y5Wiz/ptseDpJURvhFW83i2I/P6E3CoKE1DpFg6HjNLbGeH
	 XmTzGNS55Wf4YK8bkNEFwsUMdAoxSqMaD3540sKM/uoM56Y2M3jCpbtOts+nG0qucW
	 W5XtahZJZ1cCA==
Date: Thu, 9 Oct 2025 19:32:31 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: =?ISO-8859-15?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
cc: Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    Himanshu Chauhan <hchauhan@ventanamicro.com>, 
    Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>, 
    Atish Patra <atishp@atishpatra.org>, 
    =?ISO-8859-15?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>, 
    Yunhui Cui <cuiyunhui@bytedance.com>
Subject: Re: [PATCH v7 0/5] riscv: add support for SBI Supervisor Software
 Events
In-Reply-To: <20250908181717.1997461-1-cleger@rivosinc.com>
Message-ID: <86817f9a-c601-81e8-b95b-0f2396275f95@kernel.org>
References: <20250908181717.1997461-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1335458369-1760059956=:876438"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1335458369-1760059956=:876438
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi Clément, 

On Mon, 8 Sep 2025, Clément Léger wrote:

> The SBI Supervisor Software Events (SSE) extensions provides a mechanism
> to inject software events from an SBI implementation to supervisor
> software such that it preempts all other supervisor level traps and
> interrupts. This extension is introduced by the SBI v3.0 specification[1].
> 
> Various events are defined and can be send asynchronously to supervisor
> software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
> as platform specific events. Events can be either local (per-hart) or
> global. Events can be nested on top of each other based on priority and
> can interrupt the kernel at any time.
> 
> First patch adds the SSE definitions. Second one adds support for SSE
> at arch level (entry code and stack allocations) and third one at driver
> level. Finally, the last patch add support for SSE events in the SBI PMU
> driver. Additional testing for that part is highly welcomed since there
> are a lot of possible path that needs to be exercised.
> 
> Amongst the specific points that needs to be handle is the interruption
> at any point of the kernel execution and more specifically at the
> beginning of exception handling. Due to the fact that the exception entry
> implementation uses the SCRATCH CSR as both the current task struct and
> as the temporary register to switch the stack and save register, it is
> difficult to reliably get the current task struct if we get interrupted
> at this specific moment (ie, it might contain 0, the task pointer or tp).
> A fixup-like mechanism is not possible due to the nested nature of SSE
> which makes it really hard to obtain the original interruption site. In
> order to retrieve the task in a reliable manner, add an additional
> __sse_entry_task per_cpu array which stores the current task. Ideally,
> we would need to modify the way we retrieve/store the current task in
> exception handling so that it does not depend on the place where it's
> interrupted.
> 
> Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
> handled and does not adds any overhead to existing code. Moreover, it
> provides "true" NMI-like interrupts which can interrupt the kernel at
> any time (even in exception handling). This is particularly crucial for
> RAS errors which needs to be handled as fast as possible to avoid any
> fault propagation.
> 
> A test suite is available as a separate kselftest module. In order to
> build it, you can use the following command:
> 
> $ KDIR=<build_dir> make O=build TARGETS="riscv/sse"-j $(($(nproc)-1)) -C tools/testing/selftests
> 
> Then load the module using:
> 
> $ sh run_sse_test.sh
> 
> A KVM SBI SSE extension implementation is available at [2].
> 
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc7/riscv-sbi.pdf [1]
> Link: https://github.com/rivosinc/linux/tree/dev/cleger/sse_kvm [2]

I updated these to apply on Linus' current master, commit 5472d60c129f, 
cleaned up the checkpatch.pl --strict issues, applied Anup's pr_info() 
suggestion, and pushed them up here to make it convenient for folks to 
integrate and test:

  https://git.kernel.org/pub/scm/linux/kernel/git/pjw/riscv.git/?h=riscv-experimental-for-v6.18

Am assuming you didn't have other changes that you wanted to make; let me 
know if that's not the case.

I noticed that you asked for folks to do additional testing, particularly 
of the SBI PMU driver integration, but didn't notice any additional 
Tested-by:s.  It would be great if other folks on the list could do some 
focused testing now, particularly since we're on v7 of this series, and 
I'm sure others care about this.


thanks,

- Paul


--8323329-1335458369-1760059956=:876438--

