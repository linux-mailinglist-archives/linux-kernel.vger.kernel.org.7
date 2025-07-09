Return-Path: <linux-kernel+bounces-724642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD300AFF54D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7647B4D86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5EC23BCFD;
	Wed,  9 Jul 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="McLfgi2a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FC21E0BA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752103256; cv=none; b=MzSVppJg1XoNDqVbuiZl5/m/4ag3QzW1EVPxHQVek20HvWTwblqdjpHYgsLGcVI2Rc+FffE4yA445pBwtyCWQrCek9xLri34iNu3DFOpzzlqHLE1ZQXXwBgB4BEHzskvF6iz983NrCWemxJmPtMnhJlMGYkbhwxMaJoiS4N8rF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752103256; c=relaxed/simple;
	bh=LJA/fZobR2N3EAw7d6reLtpat5yHcpKJdasf0bzzcnE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mxSVn8gK/vy76zeBmoqgCqN4WItMUIaPIu5yHCiVpqsZ97nLOSGIqI+4JGF5ts56Z40prt6JB2yUUSOmu6F9U5kYH+fXtj4fcMaaHzmPioPqAvFCqEYEpcC8Zjgnh5IjPbr4dg6DmuWrETP/ICCVDUlfwXMgxs0V4pm/JZbwmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=McLfgi2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B402C4CEEF;
	Wed,  9 Jul 2025 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752103254;
	bh=LJA/fZobR2N3EAw7d6reLtpat5yHcpKJdasf0bzzcnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=McLfgi2a29KScXBa2gqR61wGCP3cdlCkxaJxtVqkr+d5iQ2aFa7fkRTSZFhlBcGRP
	 taT9QeO5V4Sj2u8EdPcl71XOGTRsLsUXlxe1Y++eFh/5Vc5zfPP+rc14FyQ+HUdmg5
	 A7T0zoSv5FuuMdBUgqXH/oHrwAluR6ihGKOjqq78=
Date: Wed, 9 Jul 2025 16:20:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw, Yu-Chun Lin
 <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 0/3] Optimize GCD performance on RISC-V by selecting
 implementation at runtime
Message-Id: <20250709162053.0389d4068832d98bd11daa00@linux-foundation.org>
In-Reply-To: <20250606134758.1308400-1-visitorckw@gmail.com>
References: <20250606134758.1308400-1-visitorckw@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Jun 2025 21:47:55 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> The current implementation of gcd() selects between the binary GCD and
> the odd-even GCD algorithm at compile time, depending on whether
> CONFIG_CPU_NO_EFFICIENT_FFS is set. On platforms like RISC-V, however,
> this compile-time decision can be misleading: even when the compiler
> emits ctz instructions based on the assumption that they are efficient
> (as is the case when CONFIG_RISCV_ISA_ZBB is enabled), the actual
> hardware may lack support for the Zbb extension. In such cases, ffs()
> falls back to a software implementation at runtime, making the binary
> GCD algorithm significantly slower than the odd-even variant.
> 
> To address this, we introduce a static key to allow runtime selection
> between the binary and odd-even GCD implementations. On RISC-V, the
> kernel now checks for Zbb support during boot. If Zbb is unavailable,
> the static key is disabled so that gcd() consistently uses the more
> efficient odd-even algorithm in that scenario. Additionally, to further
> reduce code size, we select CONFIG_CPU_NO_EFFICIENT_FFS automatically
> when CONFIG_RISCV_ISA_ZBB is not enabled, avoiding compilation of the
> unused binary GCD implementation entirely on systems where it would
> never be executed.
> 
> This series ensures that the most efficient GCD algorithm is used in
> practice and avoids compiling unnecessary code based on hardware
> capabilities and kernel configuration.

I removed the v2 series from mm.git and added this, thanks.

v2 was in -next for a month, no issues of which I am aware.

