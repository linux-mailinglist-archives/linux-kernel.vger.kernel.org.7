Return-Path: <linux-kernel+bounces-880443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E2AC25C63
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1531A61309
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BB827E7EB;
	Fri, 31 Oct 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TabzbHyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF47277CA1;
	Fri, 31 Oct 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922786; cv=none; b=qgOlRxFVFhQ3ewDCBt7JpDHzEzdJfHDZ7jdI56J7gpj/IYIDLxSYwy6U0VP0/lhwxbW22FwS+dBs4Szh9k5HhPcnCsaJ6ypvztEWZYZ//8DREHcdvp2DYHNoZJEQ7ZpDrkgapf/lfLGzhZ0uCbVIiubqOCcHQE5hJuy/QQ/xqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922786; c=relaxed/simple;
	bh=Se1X+I72s40rkJM8ntQMAsthPScDNCwADTjGR+2p8i8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uUpr293flM0CAluAXhz7ZTa3DUd1Hq6GOlVQvsD+SgXL8gefOmKm6uprMIE7yUA23n5QDTB2fOEy1VLbnns6uyxQ236JEmm3vZ7KcKJzmjUfIYBeUUZiBR+95fdaeH2FCCYAQ0e0Uh6Ce9nqKc3f8Cg8TU5V0EWBEsscFm04aFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TabzbHyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9E2C4CEE7;
	Fri, 31 Oct 2025 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761922785;
	bh=Se1X+I72s40rkJM8ntQMAsthPScDNCwADTjGR+2p8i8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TabzbHyDksb3gZOmCavUq22PsUmNwua/fz4XrJHtK90DBFupxbVOUjNqvAsWsjRsE
	 at9BKimGYNbQY11qtTZ9Ih5wTf1k2sM3u0VVMGM8tm/qnwR/Uw/Brt9vvh7BanuXMO
	 mXYxw1ZAWLD4DA8+p50XG5IROBwWGTY1k/+Bq214IK+BQrB9f18SzK6zzBWgbfZ6dr
	 CgQYphcUND5E4ubz9hC2+td6P4q+N2HtXoHIEyPVbLq6Ax96+oWl98LiYJV0vq4SV4
	 ioYSzZ4Yj/+iLA2GYYPGcDgK+Url8fR3U4UxsBi65l+sYIesHYr+l5FjsnFk42pIle
	 tn/LMiTLkQcsw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v13 03/17] preempt: Introduce HARDIRQ_DISABLE_BITS
In-Reply-To: <20251013155205.2004838-4-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-4-lyude@redhat.com>
Date: Fri, 31 Oct 2025 15:59:34 +0100
Message-ID: <87pla386cp.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude Paul <lyude@redhat.com> writes:

> From: Boqun Feng <boqun.feng@gmail.com>
>
> In order to support preempt_disable()-like interrupt disabling, that is,
> using part of preempt_count() to track interrupt disabling nested level,
> change the preempt_count() layout to contain 8-bit HARDIRQ_DISABLE
> count.
>
> Note that HARDIRQ_BITS and NMI_BITS are reduced by 1 because of this,
> and it changes the maximum of their (hardirq and nmi) nesting level.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  include/linux/preempt.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 9580b972e1545..bbd2e51363d8f 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -17,6 +17,8 @@
>   *
>   * - bits 0-7 are the preemption count (max preemption depth: 256)
>   * - bits 8-15 are the softirq count (max # of softirqs: 256)
> + * - bits 16-23 are the hardirq disable count (max # of hardirq disable: 256)
> + * - bits 24-27 are the hardirq count (max # of hardirqs: 16)
>   * - bit 28 is the NMI flag (no nesting count, tracked separately)
>   *
>   * The hardirq count could in theory be the same as the number of
> @@ -30,29 +32,34 @@
>   *
>   *         PREEMPT_MASK:	0x000000ff
>   *         SOFTIRQ_MASK:	0x0000ff00
> - *         HARDIRQ_MASK:	0x000f0000
> + * HARDIRQ_DISABLE_MASK:	0x00ff0000
> + *         HARDIRQ_MASK:	0x0f000000
>   *             NMI_MASK:	0x10000000
>   * PREEMPT_NEED_RESCHED:	0x80000000
>   */
>  #define PREEMPT_BITS	8
>  #define SOFTIRQ_BITS	8
> +#define HARDIRQ_DISABLE_BITS	8
>  #define HARDIRQ_BITS	4
>  #define NMI_BITS	1
>  
>  #define PREEMPT_SHIFT	0
>  #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
> -#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
> +#define HARDIRQ_DISABLE_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
> +#define HARDIRQ_SHIFT	(HARDIRQ_DISABLE_SHIFT + HARDIRQ_DISABLE_BITS)
>  #define NMI_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
>  
>  #define __IRQ_MASK(x)	((1UL << (x))-1)
>  
>  #define PREEMPT_MASK	(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
>  #define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
> +#define HARDIRQ_DISABLE_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << HARDIRQ_DISABLE_SHIFT)

Should this be HARDIRQ_DISABLE_BITS rather than SOFTIRQ_BITS ?


Best regards,
Andreas Hindborg



