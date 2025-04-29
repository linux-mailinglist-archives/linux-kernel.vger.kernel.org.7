Return-Path: <linux-kernel+bounces-625751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CAFAA1C32
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 22:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E279C0DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD2B267B6B;
	Tue, 29 Apr 2025 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t94tYQyv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7673F267AF2;
	Tue, 29 Apr 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958503; cv=none; b=SYXm+9IQQDqx3ls5qUzhfkdNEBxRH7+KpLSvw2G1CgGOYbV5s3Fp6MMoz2S1yYDPGIFKGR8yPVRP0GtY7nR1Vq3Fvg+KZLiqxoQE0SBeiJVvSp5WRL/p0ItDJJgP44mtFZI/Q5v4G7SmwPfga4fyTX3ZKdHL5Mq+UIsCecgu7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958503; c=relaxed/simple;
	bh=yVQiGQTIo9RNGx1kcMdYwpv2Iyy6ige9ZYny4OmlJuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOy/WEaJWXPzha39EqI94WYBw88JLwF5zkfuvTFGegBtg9b+XVIKqVedxPPFB4uLDIGS+QVlAoy7QpTHQfxI1C0MB9Ki28BW36ifccu7iBt5AQE3IhwlmyXJWLR2GgpoHhJpE1xOfFLFgDnogbwsrJPiPoSf1bX2AvWx/IrB9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t94tYQyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858EDC4CEE3;
	Tue, 29 Apr 2025 20:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745958503;
	bh=yVQiGQTIo9RNGx1kcMdYwpv2Iyy6ige9ZYny4OmlJuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t94tYQyva5/fI1bTsOvrcAuWZgqTtzIRx5afVtXJ9exMTO1hd3U2ECNxmayHBYrEK
	 tDYlVQkhTOx2twKfjj2BY4I0hx1LJA7RKTx6Rj/ftyIWQs2G8Boy6M+1dewrs3xwEQ
	 /REjkLXORQ5poiLHG/sElok6YHGE8GSobRwUb1EHtbrnlujYccq8Ob8FTWm1ptUhYm
	 z9T91wkFj8X4UhQbmaiTkaW9J77yLdQMi7m+lOIT/Ul/8fE/EUd81YPBySTp/7EwWV
	 imRWR+vM+WxKzF8nU9sqUMCyHOAoRDgl/Bl6N2jOJBZ1RQxcjirl1l6leAjN/UR+CK
	 Kx44aNX35py5w==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mike Galbraith <efault@gmx.de>,
	Peter Collingbourne <pcc@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 0/1] arm64: enable PREEMPT_LAZY
Date: Tue, 29 Apr 2025 21:27:52 +0100
Message-Id: <174593068821.431779.9112946165910138990.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250305104925.189198-1-vschneid@redhat.com>
References: <20250305104925.189198-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Mar 2025 11:49:24 +0100, Valentin Schneider wrote:
> Hey folks,
> 
> This is a resubmission of Mark's patch [1]. I didn't end up changing anything
> other than fluffing up the changelog.
> 
> I ran this under an arm64 VM, added some trace_printk's and checked that
> sched_switch's between runnable hackbench threads would occurr in the right
> conditions:
> o with TIF_NEED_RESCHED_LAZY set
>   o at the tick
>   o at do_notify_resume()
> o with TIF_NEED_RESCHED set
> 
> [...]

Applied to arm64 (for-next/entry), thanks!

[1/1] arm64: enable PREEMPT_LAZY
      https://git.kernel.org/arm64/c/c8597e2dd8b6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

