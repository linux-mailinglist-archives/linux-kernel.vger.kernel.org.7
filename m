Return-Path: <linux-kernel+bounces-758066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF13B1CA80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320133AB601
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FE2BE7C3;
	Wed,  6 Aug 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtBUrMtm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFC2BE7B4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500535; cv=none; b=mPK0u4MRRMtgRlN9wGAzZhEfGAnhLitiofJ5Nq+G9tSoeVaQgzJmliBtnSqnMzqC2j0+fJ+CGTH8q3TzrZiSq345IzXO7gK5thmOIOxT+MdAPkbNt0pd/reDVXzwgfcns2FDqRd963vzSqN6scv9lh/V2OWMAPRjGwGXmxclZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500535; c=relaxed/simple;
	bh=t5RvC/jgYvIhqsTqBesHXP99CEex0zEa1a7guj9tKQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqcGdJmx7EKMu1dxKuToLa0GGkZJoxt6gNJDtrYLUhI4IXXgzVoBfOQ88giHE9QTH5DTRANp7CJ4vwhMxfUHn0Uy/oWm7aDc0CgUf2zE2X/iu/PYTT5I1ZJ30JozA3IZsl9jtwNOpbAnLWpoz49MXkoX1FuZIhztSLm6rJHjWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtBUrMtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7509C4CEE7;
	Wed,  6 Aug 2025 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500535;
	bh=t5RvC/jgYvIhqsTqBesHXP99CEex0zEa1a7guj9tKQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AtBUrMtmuj4L6QFpBIYTQk4BdT/sDoh/9oy8svXGi0MR8prP3/zlvK0c0XEXczvbT
	 by/HFAIiwNGd32K2qe4Z+70g6YyzKQbvz7IOQUUH/MlKlkPlBebk2VWiAWLmpFXJvV
	 wuOCZDT7Mq8IB4MSTungC6JEvbayqkIQsPGmDvJKKOc2iAkwDDqQwSS3lsiDlA2li2
	 TFvsvV5/YuYRfEzOBdJym75s8878QYlP6UFf2EsuOHWAzvvBAjE/N/FKcPQZ0snSdf
	 BWXuuiHL38f9RIBw9Fbv9rW5eqkg8sw05P2j9FfBd/yMSkIIpj2ksz+gRycFx37CNN
	 +WCYWoXPsZ7Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE69383BF63;
	Wed,  6 Aug 2025 17:15:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: uaccess: fix __put_user_nocheck for unaligned
 accesses
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450054925.2863135.866620119887163563.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:49 +0000
References: <20250724220853.1969954-1-aurelien@aurel32.net>
In-Reply-To: <20250724220853.1969954-1-aurelien@aurel32.net>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, cleger@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Fri, 25 Jul 2025 00:08:52 +0200 you wrote:
> The type of the value to write should be determined by the size of the
> destination, not by the value itself, which may be a constant. This
> aligns the behavior with x86_64, where __typeof__(*(__gu_ptr)) is used
> to infer the correct type.
> 
> This fixes an issue in put_cmsg, which was only writing 4 out of 8
> bytes to the cmsg_len field, causing the glibc tst-socket-timestamp test
> to fail.
> 
> [...]

Here is the summary with links:
  - riscv: uaccess: fix __put_user_nocheck for unaligned accesses
    https://git.kernel.org/riscv/c/a10ce19d93c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



