Return-Path: <linux-kernel+bounces-884730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB72C30F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0323D189EBCB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD72ECE9E;
	Tue,  4 Nov 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adnvDbzK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299929BD96;
	Tue,  4 Nov 2025 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258549; cv=none; b=HDFpGaWKQIuczub2fQsbH1rMBsDpEVwbNvTOollyzkAbqDNwzeYO//zWedQ773JF47TvLW0ZK3/0qj4iY7W0BrdEqFoehtdhK41jkwajDuuk9xDIYZz4RAXsAf3xBl5F2Hf/Sy8s57xeHNHPL+2nxjQ0ZNzyzqSjxOkLc07PZic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258549; c=relaxed/simple;
	bh=vUh6UXP3vQcsjT8jNVBf6MBIskpO0zvTW44jCCnnevc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fXYmnRBIBn3oeDK4Vyjb2t/rj35JXWS5xrvEcqZriR1v/pCkxjvkHmVgCQkndFbPcQ0+Iqm3ZSKnzSxdxZHllZmNI90UiNzwK4R8OOf6EXaAyf1ZO+Ng5YqUNZlFIRZf84XXCfVAb2thwfljyPRfzuif5GIXLWcJUs13PSFR0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adnvDbzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D943FC116B1;
	Tue,  4 Nov 2025 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258549;
	bh=vUh6UXP3vQcsjT8jNVBf6MBIskpO0zvTW44jCCnnevc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=adnvDbzKTc1FOJCAMV++ti4UsQA/lkFLg2eENmCQhW1a4mru8Q7T4YsFcE7OYMMDL
	 ObBuDIOhIfRB9qJN/pX4i1y8Fpg5bx3qhiT2hM7WQlnfEf2P1VizmV4Dk/ikGQAhsE
	 H3GlQJXIWIzTdB0ydpddgPBy2qcSHyQxCJCR79vkzshDRYilduV46KSmApNgSJwj59
	 BrxBVAd8uSmhtQ31zdnCKnTMBIEIX0hYNx+GajODw93gUNpSd2o/IV4gZ93UXLcGFY
	 D1v/Sm7klEi66Xl7rmKMeKEGHAs+W3DW+qFYQM7vrtkWhfKIq1j0o+gvjorGTCB/s9
	 8KLBDtOmEzsiw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v13 02/17] preempt: Reduce NMI_MASK to single bit and
 restore HARDIRQ_BITS
In-Reply-To: <20251013155205.2004838-3-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-3-lyude@redhat.com>
Date: Tue, 04 Nov 2025 13:15:34 +0100
Message-ID: <87ecqe8049.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude Paul <lyude@redhat.com> writes:

> From: Joel Fernandes <joelagnelf@nvidia.com>
>
> Now that NMI nesting is tracked in a separate per-CPU variable
> (nmi_nesting), we no longer need multiple bits in preempt_count
> for NMI tracking. Reduce NMI_BITS from 3 to 1, using it only to
> detect if we're in an NMI.
>
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

The commit summary is mentioning HARDIRQ_BITS, but I don't think that
change is part of this commit.


Best regards,
Andreas Hindborg




