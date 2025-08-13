Return-Path: <linux-kernel+bounces-767108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C772B24F60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B219A2624
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB627B50F;
	Wed, 13 Aug 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe+gqP3l"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACC11CBA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101485; cv=none; b=XEkwGRYuvMbYkF1+P12vGl7kuUi8aPNiTMGzN/TYHAjy2D39fk4MpifoB3pkh3U4/DhTA6Dp6eaVikvM6Km3EwdM1aGD5cQ899SAhuh7h2IcRGVR4x7810m/l2rVqKZpIsZkr3RvA2m5hpJW/jexVZ9+x1L2e78M2WMG2DXfHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101485; c=relaxed/simple;
	bh=kHT7Tp//mQENHGCbi9tnw3TvV/OU8Lo5Vpz5QghQ6I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/ZUGzRpqfDxALkxUWetD1//CEcW6lRKCJYOsdbaLOFfTu8JYPBvunUdlobQpv++4H9eN4HNMgDNf1ThMnVbjGBxP7bDd9GvBE6KbyRm9+AoBx+shyEySI4d/hYBshagVkLSkr8hG1PNvxWICLF88+10GCArsGO6FeHmRR3b0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe+gqP3l; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70a927d4aaaso861466d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755101482; x=1755706282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz9gxZWy39cE1DA6U86qHdPXqGPRK5mgWJctmhllYMs=;
        b=Oe+gqP3lPKRAA9Ky7KC5d6D5jwYTJ4+cXGghqxHs8YIN/47zX+6ohuevBhsS9ZUwGh
         4ZIDN1aNfshC6akjR59UNHB7qSkoj5BOzIQWtmtMf5OcbDFCiMotQUeSvvhYwZiDxblH
         z1Ft66PDgadneez+UHT9W8MUrjQeyi88Av2gg7wrPQ1HCq5Xn7i6rV2xTWJ2A0g8ni5M
         1b6U29wDSsn/c1GGXh+ioTFWRRS9OrS/Brc+BDUXSh7hbQBB4eXIb3G4uvuqsyaQ6wGr
         xRd8AEetUcH56HH3UFwnRt+CMMYu1ATBWtCja7RgwO/Q2t54Kyn3yKA4455NhpMfcdPL
         171A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755101482; x=1755706282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gz9gxZWy39cE1DA6U86qHdPXqGPRK5mgWJctmhllYMs=;
        b=eZ/WmorBV3Y40cSCJ6qsTJv9tKFYeW3fEnsNaimgP4tP+TmH1XGKE6dps74Dtu2Ied
         ymxanzUZaDLWiBXjGR/JLsxpGfHSZcUcUGA0MGB0yv3JJhrQRO7IYUTryj775XuY0suO
         FSkImq1w4Vf2YYY6oHTjkwd3n4cQ3zzM6GAxQgVaig+yydU2QRWk8xe9pZ4thctFbTP6
         nVntBday0UWXfwvBqyvmQhjtoGsPEsgUASbTh917ln8lAWP1enGuzQSbGaOvWvJuSRMZ
         Q+b0N1SdFEnk3o3IlJDDidP7pCsdFDlddMAhDOKJysaKGSeE5M6tExULAiCWNvl4RL9N
         uzjA==
X-Gm-Message-State: AOJu0Yyd18H6dRI57xI7MNJRXkilUOcfPmEQ0Lv/vFKCb1d7zEDNevNU
	f+DwlhlUh+tf8OFm3fQ3qCNl4VMt5qW0y5QjmzH1bYtk/O7JlCqBjbm/
X-Gm-Gg: ASbGnctadOTsyFW68tzJIkBtlknK2rSAVUqOMLpcKYifkhleTTpndd/GSapHXEd4p4B
	oF2eJ6upWhRdsgFK/1qWMd9QosLdUw39pvm2hcbnDEwgJF0+0/eiAZ7maCe1Uxd65d2nOvbWH6X
	wHs6p7yPhhHL9DfaB8JJ4A4C1xGgxTDuRpVApAzKqpvIhoT0F41QrR5/8XEXo+bDknzfSrqC25Y
	St/byxLaIzLCuGwSNTpcVRt/UGxt+cTjyrwRYubIE6GBuAUe3sShQ1ejZVXMem4bxn8puJak78n
	2LGtDxoOM0DIBlZo67pJ9RMMoqrCEDTwYeRXRfwNgZx/bl7gSshyouL/SoIY7fQpOHbXv/vG3aE
	EIUHPhcAAb5dUyDD4jMspE7dnNCn04iSEWoITUVv3opPCTI50V882EKqAR6tFQMu52cfHBmyJdu
	SdWvDMwKyI4XlqnhCId/VQyMk=
X-Google-Smtp-Source: AGHT+IEZ86Tb0gHX3KexD3p/rU8EboliWD2i1ek5I/JZsgxdptMw6GxTOkpFMAC5HA4uXh0tzbtTvQ==
X-Received: by 2002:a05:6214:b63:b0:6fb:25f:ac8c with SMTP id 6a1803df08f44-709e893bda5mr46889066d6.31.1755101482114;
        Wed, 13 Aug 2025 09:11:22 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca464acsm198640436d6.36.2025.08.13.09.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:11:21 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 450DEF40068;
	Wed, 13 Aug 2025 12:11:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 12:11:21 -0400
X-ME-Sender: <xms:KbmcaHR-Pv3V0xhHeL8YXvNj81hbll4y2YmH4_M1bIoMoa7UcLA2nA>
    <xme:KbmcaBNq62wNJ5jlUda3iHbsR23ls8-sKc5qnKHYueSsiXmpltBy57L7v-RqrTJQv
    j870W3iqWOCqvxUyQ>
X-ME-Received: <xmr:KbmcaNSr-gi4IhG-QQX3KHZOww3CqIoPijlmqph5tk64cCjAaROVOlp4S-Nc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhh
    ihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgruhhlmhgtkhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:KbmcaHhwAa-mXbKGCU6sr__7hJPRtHt8dACKoeTuYQktxOnee_Lh6Q>
    <xmx:KbmcaO_ReBxo1oJoeWkhu0CGbajMo8zhEYn31KCMbGHMErRBQoSNgQ>
    <xmx:KbmcaGGTaoQBOCSh1ox3E6jTa1KhnfDLbnlveetdxPfUJ9C4McE5cg>
    <xmx:KbmcaJnqAxxDdaTa2TEwa35zYV4d2rQyM54vHhis0FMz2hxcSy12gg>
    <xmx:KbmcaCY1wFAPTpZ-8mkbSwLZcpsheWQ6ESRFefd9wcJIRGpb7wW-QqOJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 12:11:20 -0400 (EDT)
Date: Wed, 13 Aug 2025 09:11:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] rseq: Protect event mask against membarrier IPI
Message-ID: <aJy5Jxf_c8RG7qvU@tardis-2.local>
References: <87o6sj6z95.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6sj6z95.ffs@tglx>

On Wed, Aug 13, 2025 at 05:02:30PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Tue, 12 Aug 2025 16:34:43 +0200
> 
> rseq_need_restart() reads and clears task::rseq_event_mask with preemption
> disabled to guard against the scheduler.
> 
> But membarrier() uses an IPI and sets the PREEMPT bit in the event mask
> from the IPI, which leaves that RMW operation unprotected.
> 
> Use guard(irq) if CONFIG_MEMBARRIER is enabled to fix that.
> 
> Fixes: 2a36ab717e8f ("rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org

Seems reasonable to me.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  include/linux/rseq.h |   11 ++++++++---
>  kernel/rseq.c        |   10 +++++-----
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -7,6 +7,12 @@
>  #include <linux/preempt.h>
>  #include <linux/sched.h>
>  
> +#ifdef CONFIG_MEMBARRIER
> +# define RSEQ_EVENT_GUARD	irq
> +#else
> +# define RSEQ_EVENT_GUARD	preempt
> +#endif
> +
>  /*
>   * Map the event mask on the user-space ABI enum rseq_cs_flags
>   * for direct mask checks.
> @@ -41,9 +47,8 @@ static inline void rseq_handle_notify_re
>  static inline void rseq_signal_deliver(struct ksignal *ksig,
>  				       struct pt_regs *regs)
>  {
> -	preempt_disable();
> -	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> -	preempt_enable();
> +	scoped_guard(RSEQ_EVENT_GUARD)
> +		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
>  	rseq_handle_notify_resume(ksig, regs);
>  }
>  
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -342,12 +342,12 @@ static int rseq_need_restart(struct task
>  
>  	/*
>  	 * Load and clear event mask atomically with respect to
> -	 * scheduler preemption.
> +	 * scheduler preemption and membarrier IPIs.
>  	 */
> -	preempt_disable();
> -	event_mask = t->rseq_event_mask;
> -	t->rseq_event_mask = 0;
> -	preempt_enable();
> +	scoped_guard(RSEQ_EVENT_GUARD) {
> +		event_mask = t->rseq_event_mask;
> +		t->rseq_event_mask = 0;
> +	}
>  
>  	return !!event_mask;
>  }

