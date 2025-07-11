Return-Path: <linux-kernel+bounces-727797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC8B01FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039AF171486
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20FA2E9EDC;
	Fri, 11 Jul 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS65MYjh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20B2E9EB1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245805; cv=none; b=bZdAI/1Qev89cUQ0SVKqzi+0R/rUUUZUb1g2atr+d9sfh34duADWYld2eZw6PsL+Wp7uhJ8gu73acGajaEn+1QF+NOZL3nSwEBhO5oXkGIVWbylxIm0hFj6oNAbGS4dp7V5M6SF+EV3LJ9TwTXp7jTUHx6r0gu50iYoff5eJMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245805; c=relaxed/simple;
	bh=zNp9EER2UQJ65Qwe/j75010fnZ8pc0YCPc+AdF0Qpl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNVJe/ZVPNln/EYMam4R9T7ZQT0DpWHrkGHP6tkIkdVs+8FtBFONnYpc42WWTckgtMdpCn0yxnwmDXXWLHt3J0T7/DtYgqnmGsobMZrlAc0WyNMAdDF/O9eUzB7UVXQPFIt2owBHFzk2qpORdplob013gYc5PlXdYKUUn5YHobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS65MYjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B01CC4CEF0;
	Fri, 11 Jul 2025 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752245804;
	bh=zNp9EER2UQJ65Qwe/j75010fnZ8pc0YCPc+AdF0Qpl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SS65MYjhvk+m+L4KXVaOaTAoGT4WO6qUzscxC0a723+W5hmjYg7yU+TGIkuRrl5SY
	 5Qhl3Sy/vD4C46h4nnndx1HCMyigEIkH6/yDVODbRjDOSEAUjWjjIN5wS1SCw580DK
	 kDF5VkX67AogDxd5HkZnYFK74byT7afmfh7FZVGKdAM5BHGzxhum3QaboioSKdxsPr
	 c9BN6C4AFys9xulwK1tdsEP8tfbKd3PqRqfm3pH7v3atY3gXLO6JdLq4QG5HCDBZn3
	 gluHXzbBa88TgRsOBtr2gn28lO1F3kVW9hRMnK/4UdMkejCwSbEdqt+/P/V6C4lC25
	 oMKxXFfleqRQg==
Date: Fri, 11 Jul 2025 15:56:38 +0100
From: Will Deacon <will@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, maddy@linux.ibm.com, tglx@linutronix.de,
	bigeasy@linutronix.de, vschneid@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
Subject: Re: [PATCH 1/1] sched: preempt: Move dynamic keys into kernel/sched
Message-ID: <aHEmJvhUVG_x1FZx@willie-the-truck>
References: <20250610075344.1379597-1-sshegde@linux.ibm.com>
 <20250610075344.1379597-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610075344.1379597-2-sshegde@linux.ibm.com>

On Tue, Jun 10, 2025 at 01:23:44PM +0530, Shrikanth Hegde wrote:
> Dynamic preemption can be static key or static call based.
> Static key is used to check kernel preemption depending on
> the current preemption model. i.e enable for lazy, full. 
> 
> Code is spread currently across entry/common.c, arm64 and latest being
> powerpc. There is little arch specific to it. For example, arm64,
> powerpc does the same thing. It is better to move it into kernel/sched 
> since preemption is more closely associated with scheduler.  
> 
> Plus, Any new arch that wants dynamic preemption enabled need to have 
> only HAVE_PREEMPT_DYNAMIC_KEY. 
> 
> This is more of code movement. No functional change. 
> 
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/arm64/include/asm/preempt.h   |  1 -
>  arch/arm64/kernel/entry-common.c   |  8 --------
>  arch/powerpc/include/asm/preempt.h | 16 ----------------
>  arch/powerpc/kernel/interrupt.c    |  4 ----
>  include/linux/entry-common.h       |  1 -
>  include/linux/sched.h              |  8 ++++++++
>  kernel/entry/common.c              |  1 -
>  kernel/sched/core.c                |  4 ++++
>  8 files changed, 12 insertions(+), 31 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/preempt.h

Acked-by: Will Deacon <will@kernel.org>

Will

