Return-Path: <linux-kernel+bounces-761589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF017B1FC3E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873A87AB911
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42121275B0D;
	Sun, 10 Aug 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTepRrXB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0639221572;
	Sun, 10 Aug 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860341; cv=none; b=QvbhKOUpgVfx/8qr1Kvs6pHr6n65T7rb8qVVmU7vjWsBhD4hms/VamA5hCF6HmVU6dRB4DDVfpxCOdC3ZRj2CoSr+O/JzE+awGwOO2Mm/TuNpS5lQhB3R8MLUtpfKIvB/jZakCZbrAHbKaKIo7MAvFdzoOMFixVrCwMX7BtASNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860341; c=relaxed/simple;
	bh=cCogjkeCTWy7QuKE3sUoaYKqn8csK/aq59mUdEBQkG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=St735RQHBIGRKCAgDiBCEgZ9eFwK5PmR1ns74UEdIsxS24DBnnXF4PBp/gPx8NmK9PI7/om5mMoAo6aevIrkk9mWVmGETA7Hk+zQZTnVl2cjcoA7DGELGQY9iwN975jFRyRIVEKntQZSFJ+uv3BsVOjzWYqZMsk8KzHBCu0528U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTepRrXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214D0C4CEEB;
	Sun, 10 Aug 2025 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860341;
	bh=cCogjkeCTWy7QuKE3sUoaYKqn8csK/aq59mUdEBQkG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cTepRrXBwPr6Tliwxw3HULS5RIv6fc5lJ7zvK6ht8eNz64zDwaKYCWGTG+GdFAFNJ
	 GDeXnGy4bI1xc86e3XvRxMVp5CIT0zYH1ra24f4Xi+6OF1XeC+H59KkC3ZGig77T1A
	 fbd449HXQk8EoqkfeCfkdDT3EDYN3xA2K9CzrdsB1MRQOx26qAPxEcu7/ZUEII/tc2
	 euODO9EogWmI4ocrhXNOwCiNSMv52QpXGymUH6cV2cbSkAx9Cj8AfhFfjnkZTlAO0p
	 cztfqiY0xu7nzIlM3bbxzLEG9HPfQi0vBj6Xc4p+rvnsuN7dA9PGS+/l7qisGaVLs4
	 e6ur9KzIgXjlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC9839D0C2B;
	Sun, 10 Aug 2025 21:12:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 00/23] RV: Linear temporal logic monitors for RT
 application
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486035349.1221929.9634317090323117771.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:33 +0000
References: <cover.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, gmonaco@redhat.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de, pmladek@suse.com, senozhatsky@chromium.org,
 mingo@redhat.com, boqun.feng@gmail.com, longman@redhat.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr

Hello:

This patch was applied to riscv/linux.git (fixes)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Tue, 29 Apr 2025 14:00:45 +0200 you wrote:
> Real-time applications may have design flaws causing them to have
> unexpected latency. For example, the applications may raise page faults, or
> may be blocked trying to take a mutex without priority inheritance.
> 
> However, while attempting to implement DA monitors for these real-time
> rules, deterministic automaton is found to be inappropriate as the
> specification language. The automaton is complicated, hard to understand,
> and error-prone.
> 
> [...]

Here is the summary with links:
  - [v5,18/23] riscv: mm: Add page fault trace points
    https://git.kernel.org/riscv/c/a37c71ca412d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



