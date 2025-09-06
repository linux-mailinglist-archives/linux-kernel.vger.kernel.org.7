Return-Path: <linux-kernel+bounces-804495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B3B477F2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 00:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B64A4043D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20E2D7DEE;
	Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqgSwUhh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC92C1587
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757197051; cv=none; b=UGR7WbTFnq86OcvlfpHxOYY/N+6K3Ln7h3KYP7Wijv4DLY8J09bpQSLQ4RBzaGNAfjdkCTVi3/pqCjxhZR8fy/2ecVEyfR+IzrCllQbxQX4mzOcSWGwuOMgN98A8zgdqJVonn2T44q85ILV3renUwZKe2+lN/TW/uF19R2NFvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757197051; c=relaxed/simple;
	bh=bs2P/21fq6fCmZ6dVd7FIaH7vC8qjoiArrOBmg7Y0yg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=MvFoAVq2SfHz7S2wjslJhneermuF/QUow4wqXONiIVgnKzmihY68hFe7KRstZXnvJtkmY3lA1wv1eX04YtUYYo4DBvDtVeo8K2wyuk5xN7RpYqecRfML1uxCFVrtAhP55hgidf3eqVLZbeia/Xp+e7e/qoRCmNv+sM+wCQY5lhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqgSwUhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82DFC4CEF5;
	Sat,  6 Sep 2025 22:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757197051;
	bh=bs2P/21fq6fCmZ6dVd7FIaH7vC8qjoiArrOBmg7Y0yg=;
	h=Date:From:To:Cc:Subject:From;
	b=nqgSwUhhUFKPTiMRlqn9RSBzWtg4vvM+rJ8xRgxtZWldsYCLufXUYqf/8qXju/84P
	 yWlTJ5KtlkusFCq5Tz+ItJD9J309pmXV/ufp/aagNIIjZUf0SqM/ebD2aKZ7iEf/xt
	 X7rNSQJ4OYcYoE3BJAZwXC0rGosu24cJAowaKEfG8pIK0flHXAc32Evur+LBAvJRqK
	 spQfsaI07G/iNAPo4Jrc8/7euUCn9WM/M94jvOrMcj8pMfrsw2ERybEC8t94HRFKwh
	 ny5OXSD5qSEwRxLIS6tw7HdEy+2f1dysdrriHCbBrh1ru0kNSEI2VPSHQBGRHUDN96
	 YJGLxhSF1OwRg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uv1Ea-00000006Ugf-1xYr;
	Sat, 06 Sep 2025 18:18:12 -0400
Message-ID: <20250906221751.054623340@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 06 Sep 2025 18:17:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Fixes for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: c1628c00c4351dd0727ef7f670694f68d9e663d8


Guenter Roeck (1):
      trace/fgraph: Fix error handling

Luo Gengkun (1):
      tracing: Fix tracing_marker may trigger page fault during preempt_disable

Qianfeng Rong (1):
      trace: Remove redundant __GFP_NOWARN

Vladimir Riabchun (1):
      ftrace/samples: Fix function size computation

Wang Liang (1):
      tracing/osnoise: Fix null-ptr-deref in bitmap_parselist()

----
 kernel/trace/fgraph.c                 | 3 ++-
 kernel/trace/trace.c                  | 4 ++--
 kernel/trace/trace_events_user.c      | 2 +-
 kernel/trace/trace_osnoise.c          | 3 +++
 samples/ftrace/ftrace-direct-modify.c | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

