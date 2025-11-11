Return-Path: <linux-kernel+bounces-894372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82AC49DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B90D188D927
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBA81FDA92;
	Tue, 11 Nov 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FErf+LGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E61519AC;
	Tue, 11 Nov 2025 00:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821043; cv=none; b=jUK/zt34SQvUc2RK41sUxecD94d/kdHkO96dHjOeclpKubhC9yloN2XoPhdHZYl/hmBMO+ryA6UzP13FZIoDcIuX86vjNqGoZE4JnxwUwdDFyc9Y+9hJeFUHgBdarqu96q52W9PA7Bavh3xuVVHvXLnIi9fKeTRCUeEwNFlAaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821043; c=relaxed/simple;
	bh=B4VMH9VIBesNio0hvZT25KAARBNpcqNnEDJoyUG+DcA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r2IB6kasT9WS7ktiG/KLK2w5aLJ3pTAt6vdRzZzqRh0wuQTe4u3yxHYrTe9C8nwEX6bA1sF7oCeJiDRYdaAnjEMrojIYdG4HA/PijMRYD02ll29fhlHlkPfivfYhpfn9IWETHTAyZjrvL1AcPejAL5AHenV+RDkxDkRzvupxhgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FErf+LGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1159C16AAE;
	Tue, 11 Nov 2025 00:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762821042;
	bh=B4VMH9VIBesNio0hvZT25KAARBNpcqNnEDJoyUG+DcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FErf+LGwhymSBNx567BBMzezTHfeIDpAQY0XnJLeJ60MIoofkJ8SDHastFyqFMod0
	 UmNUdLoO6S9DVeOKmAr7P8VdKk75wxL12UAf2hh0JUA72NJquAcr+gHIeOmBs/Az2g
	 /MaYzJVt8+Fx9CD2138t9G1OkxoGHGEvsE0QQKqx43KcTWJXYnKQpPn6c0HXHyN9SO
	 hDN6LJOTPktmhEaDHCzsaTv9PQizk1k0tMxTB9oukOeykUxLJIIVzBKmk4rJ05SDyt
	 eZ6VdQQEeflHmNj0XwYthAI4iGBKOVlp9zKp+HjCAHp8MyJictHT6rVLyox3PIvUQp
	 FkBscGSy4qIbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCB380CFD7;
	Tue, 11 Nov 2025 00:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: ocp: Document sysfs output format for backward
 compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282101299.2823873.13816529606804209236.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 00:30:12 +0000
References: <20251107074533.416048-1-zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20251107074533.416048-1-zhongqiu.han@oss.qualcomm.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Nov 2025 15:45:33 +0800 you wrote:
> Add a comment to ptp_ocp_tty_show() explaining that the sysfs output
> intentionally does not include a trailing newline. This is required for
> backward compatibility with existing userspace software that reads the
> sysfs attribute and uses the value directly as a device path.
> 
> A previous attempt to add a newline to align with common kernel
> conventions broke userspace applications that were opening device paths
> like "/dev/ttyS4\n" instead of "/dev/ttyS4", resulting in ENOENT errors.
> 
> [...]

Here is the summary with links:
  - ptp: ocp: Document sysfs output format for backward compatibility
    https://git.kernel.org/netdev/net-next/c/5b9192c2c075

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



