Return-Path: <linux-kernel+bounces-758070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E8FB1CA84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B5C56669B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6B32BF00B;
	Wed,  6 Aug 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icnaqOJd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670132BEFFE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500543; cv=none; b=Sv9S5Qc0mwKVppKLprikN+KPDJ8mImkQr3FK2Sw/VrRfH1+qbRj3pgEY8+Yi7zbdVu30WKyonTQNcDv9Cngcbs/S4YLuc1UI3q7qSUsHVfHVIXH0yvCpgG7q+WExaZ9e3LxuEk8ekfSWceAmXiXa0AdkFi6UOHP6f+kLFX/8ws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500543; c=relaxed/simple;
	bh=n4+mBmrM2PXhRcMevexmYO4o9PH4fP3pZStIuAV55rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQF7Z5N2gv8xYSxzk0YKzTGn3kIdYfJTOGULuSIWJIbVU5PlYSPJzM5nkFpxhEjbas+hgPnJeA9j5ktueT6snTMXoiVUGSsfrvk/j2RBUrXNA5xm5adZ5F7TKER0g0M7YBIkXG3Gv7r8uml9PmLSvPqoMiD4/GZpdac5egzbu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icnaqOJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F65EC4CEF1;
	Wed,  6 Aug 2025 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500543;
	bh=n4+mBmrM2PXhRcMevexmYO4o9PH4fP3pZStIuAV55rc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=icnaqOJdzQTMO/kFFBnE2vk1OzKlWqDAD1c+GNsy3zvLHBprU5WWiD5sWUvI8lJoE
	 zK8aVccyma1F5btkyyx6/97UR6HLNH2AHk5E/1YW9AfgB9M2BVVCYnr+r3NWeR2M3I
	 EVrzV0AgRsmSJKCI5hGOsQHwLg4XFYWHhTKYih0zDkipC90tMv5oQXnffO3KUUaKk4
	 IZds+s9kBZ2VHYzCPziDNywtDDQF9cYVR3OL6L1dEgHhjSUxd1aVKuHj5C/+HgsGvD
	 J8sB8AQeFdIkq4R0gEem8521skbb/U0RLD4yEVTZbJUZC6y1hLZOTix3lEDGqlLPjL
	 lSNUGeL36Q+IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D33383BF63;
	Wed,  6 Aug 2025 17:15:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: cpufeature: add validation for zfa, zfh and zfhmin
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450055687.2863135.4984020591537860914.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:56 +0000
References: <20250527100001.33284-1-cleger@rivosinc.com>
In-Reply-To: <20250527100001.33284-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Tue, 27 May 2025 12:00:00 +0200 you wrote:
> These extensions depends on the F one. Add a validation callback
> checking for the F extension to be present. Now that extensions are
> correctly reported using the F/D presence, we can remove the
> has_fpu() check in hwprobe_isa_ext0().
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - riscv: cpufeature: add validation for zfa, zfh and zfhmin
    https://git.kernel.org/riscv/c/3de29352aaeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



