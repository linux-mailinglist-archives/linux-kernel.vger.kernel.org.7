Return-Path: <linux-kernel+bounces-847684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE56DBCB68E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDDFD4E0EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190123BF9C;
	Fri, 10 Oct 2025 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6yDLkBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68023AE66
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063252; cv=none; b=FqrCubeDb5zJ6KEN+2KmvC0nQip82MrZi0eb27BQbv6KBg7q6/dCqFry6TINnsIn/MR/Tanu+3fbAX8V5SIqZp5Sa78cIbOBnib9SQGqD8B998kHgdHeqlV3NaS+DD1oQsyL7YrKI6TF7heq7ulmZu0OsVfFZI4OvkKYHcEtOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063252; c=relaxed/simple;
	bh=WdaR/Hhu12IphEu5iAM2TzbHpgJPVxeGQf1ik2Mps1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nsKQ6GP/DPliMUKV6KRIj3tR3q2IK090+zHaS3ws9bKouhP0/8cgvtnL2Q0nlG23MAGpFdP/LIDyXzh+h3pa9q5fmOMlfdqwsQQ/GKvscXDs1666vWh6NAuvvfUPqgUF70RCoWgM5FnWycoYQmH9jKgqes0zQ58A+iMuQhw81VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6yDLkBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C23EC4AF09;
	Fri, 10 Oct 2025 02:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063251;
	bh=WdaR/Hhu12IphEu5iAM2TzbHpgJPVxeGQf1ik2Mps1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m6yDLkBHs3od5J9K+GT0WbgiCDCw/GjVUMAolgeUqyHnoYE2m44SIi4EcCOLisB5x
	 40iIsHyNZlJy1YLlK/BtFrv8sJEzVjX3BJhOhjLiApHEKQFUDksBSvQtwM1+LpDqHb
	 L8keqsNqZEhhopB3ht3LssiE8CJ0idh4SW7rDVvsfKI8bjgaFhoxuGvKq9BtSPyaz2
	 s6Wb830DXwh3VNsJYUoV8Uz5/otF52IQOvVsm2CtXsLpACHJjotgxuAs87yvWJMgmz
	 0LTqVIc9i9fbFy2hdxx0nyuRPqKsJb41F6ubtSl/7GwoPgOr/Ox3bCBVpmMkCwzcnV
	 sTqZ4JfduI+gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8E3A55FB5;
	Fri, 10 Oct 2025 02:27:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: kprobes: Fix probe address validation
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176006323925.354358.7825559946978649755.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 02:27:19 +0000
References: <6191817.lOV4Wx5bFT@fvogt-thinkpad>
In-Reply-To: <6191817.lOV4Wx5bFT@fvogt-thinkpad>
To: Fabian Vogt <fvogt@suse.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 guoren@kernel.org, marvin.friedrich@suse.com, alex@ghiti.fr,
 aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
 bjorn@kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 10 Sep 2025 17:25:13 +0200 you wrote:
> When adding a kprobe such as "p:probe/tcp_sendmsg _text+15392192",
> arch_check_kprobe would start iterating all instructions starting from
> _text until the probed address. Not only is this very inefficient, but
> literal values in there (e.g. left by function patching) are
> misinterpreted in a way that causes a desync.
> 
> Fix this by doing it like x86: start the iteration at the closest
> preceding symbol instead of the given starting point.
> 
> [...]

Here is the summary with links:
  - riscv: kprobes: Fix probe address validation
    https://git.kernel.org/riscv/c/9e68bd803fac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



