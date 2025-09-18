Return-Path: <linux-kernel+bounces-761588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E85B1FC3A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BDD3B317E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E62741D1;
	Sun, 10 Aug 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8+vBwuH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C391271443;
	Sun, 10 Aug 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860340; cv=none; b=daIZQZE/Kc+lkBWyxZbf/ljBsDXFf5FJw9SUezU/MdMkqmhJqRBjB5PHlsdXQRELye6+QENcqSB11zwK9DdmQwjmhtgLMiApxauLm8Yi5uGEJZEMYfO/RTUk3NCOp5tBuSnhkzIPi8l29MISwtfuz6JCWD9LXeSq3vdw573IqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860340; c=relaxed/simple;
	bh=5yjMJ5pYAU7roQm0SoETZ1MID+Ix01DRdk2i+IefPp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RumsBx9lPXd3hS3Vf7KZyYANMRIJzxqKPWhkJwKviDiO/RQiYNhCHPNuv2Po4sxQkxHDCxivyTz0UsNPY4OKPmnO8nWynyKmgrRcsQv5yuuNZWXLuL/uZyctj6GzITLECuivgqtMiDltaEkIFN1jlxUv7Knzsa45oNVHf4aNSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8+vBwuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0B3C4CEF1;
	Sun, 10 Aug 2025 21:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860339;
	bh=5yjMJ5pYAU7roQm0SoETZ1MID+Ix01DRdk2i+IefPp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p8+vBwuHbPOX3zWA5AdVdow0dXcpX5lWYUZFlKh7zH9B128VrbY+ROT0gFzs5QfXx
	 BV0kQURmNwLVseCIgn2iBj9UYh1II/3xL9CVa8qHV6XFFLaJYw5n3+2A2kdY5ZY89c
	 wz6jgq5LjTcLQHEauf7gbm7pOgnd2j3+L6OkZ78x1JL9q4wXwanUFQ9KS72+CTpG3D
	 N9PFtwBE40VDKi8WWiUia+dRvn28fqHhu5PrVdqmo4hVL7D4ZdeqveMFfUBes9uU89
	 1hI4AwCdP0An5a5lSs3vgBR/OhzlE02FOlwoKp85o0Ko61E5ETJDB85G2T1NE2+/A6
	 B1A+nE1puMYpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7339D0C2B;
	Sun, 10 Aug 2025 21:12:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/22] RV: Linear temporal logic monitors for RT
 application
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486035199.1221929.9917218333770390161.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:31 +0000
References: <cover.1745390829.git.namcao@linutronix.de>
In-Reply-To: <cover.1745390829.git.namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, gmonaco@redhat.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de, pmladek@suse.com, senozhatsky@chromium.org,
 mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr

Hello:

This patch was applied to riscv/linux.git (fixes)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Wed, 23 Apr 2025 08:49:55 +0200 you wrote:
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
  - [v4,18/22] riscv: mm: Add page fault trace points
    https://git.kernel.org/riscv/c/a37c71ca412d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



