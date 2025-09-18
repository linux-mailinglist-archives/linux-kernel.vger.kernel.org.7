Return-Path: <linux-kernel+bounces-761587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C12B1FC39
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83F2177B86
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA826E6FA;
	Sun, 10 Aug 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwlDPXEy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466CF26CE37;
	Sun, 10 Aug 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860338; cv=none; b=U57PvJCbjQBD3wBppIwJzi2f1XweCpDQNXF9PYMZhcB+DaUHRbzyeKFQ8YBU0u5eUeWPH4IQW33wtGJaFQrOt6qlIWrIJYq7c3zY3aBdG/N7SHWBBqEQL2nEJI7hFin84qc1Jxmv4mlNo2eP2yI1t3p0Tz3kjbjqPBw6rxIpZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860338; c=relaxed/simple;
	bh=+4dnmCmzsqfJqzogK3BsIrwmBCpep0C6Bjw/+YBBuRM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mLeZVAXyIgkvksuwihtaAXDjSzjBMYNtrMRPePhCwF3c+CbfvPwHOtUayF7JJx5pKDCXw2RuUmYBS/L6a0Dw+Banb38c9bWqpXueUvax5R4oxWxaoypAPMyTnVWwInytbyEwzMPp9O3ghr6lm22ojw5+u+3s6d3HilbSthtMIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwlDPXEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3FCC4CEEB;
	Sun, 10 Aug 2025 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860338;
	bh=+4dnmCmzsqfJqzogK3BsIrwmBCpep0C6Bjw/+YBBuRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jwlDPXEycbVxBriw0lhEvzExieU29/OWPjrCEOUv2WqxJVCo7k8qLQNd/23hKV6Id
	 kiLaOV4YOtJcGgxElQjSaCgtWjuxF1TZo4tREA179TeZXdS3lvUfSUPodCgRW5+oXI
	 BCFW1ZUGDUOY0dS0F6zuygKhlBAKehYFNuxADUZB/wNi3lRPG0mDkehuTAMO5r9Gc8
	 37hr0J36RdpHnefSpObuD3L+Tlh1Fkezo6HnNDheo5ggM1beQv0n1jA1HqFn7bWV3N
	 Kt0hHbfjy0QEiUyYkW8gtXP6ZDCpEIB8+gtBCrPbjCcJ7HLqTMTALoRVNr67Pgkjiz
	 1vu91j4EtReHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1939D0C2B;
	Sun, 10 Aug 2025 21:12:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/22] RV: Linear temporal logic monitors for RT
 application
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486035074.1221929.14771271313243309912.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:30 +0000
References: <cover.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
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

On Wed, 16 Apr 2025 08:51:06 +0200 you wrote:
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
  - [v3,18/22] riscv: mm: Add page fault trace points
    https://git.kernel.org/riscv/c/a37c71ca412d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



