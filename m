Return-Path: <linux-kernel+bounces-734215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC6B07E79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE4F4E82C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADD2D0C6D;
	Wed, 16 Jul 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbYjf43x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF252C17A3
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695993; cv=none; b=totviBvzg/GZLoCC1iG7vyNLmXdb4LrETvX9CZkZfCrTwj/4Q9Ne0ktFiiGRmpL3XGU4CpFh2DnTEgX2/pyopiKhLCBSYtVZvIxIK1e12KHoV6f9M/+JRuqM6CywD/8lT1+/Qh2CHUXbN+8fTFtcg57eFmfml0iP8lt+UGIYKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695993; c=relaxed/simple;
	bh=hwxeQlSgWBk/HzsQpu7mYAmz8iQL+ewlR3LRieKbN80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q40jy1qRvoo2wH2XrzJlSyNobdokjhLDzBU8dxWQyYb+k4IDLm5do3ZfhxSbPZV0HRvjuyr/ZZLtsjUvSNxy16DbFnKDHu4kEPTqurdOiN5zwUAXwZPjlRRhvU1vxWBvxxJdcEjfpEMljxKoNRH5XDv9UD6aJhayzec6aM5DEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbYjf43x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3721EC4CEF1;
	Wed, 16 Jul 2025 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752695993;
	bh=hwxeQlSgWBk/HzsQpu7mYAmz8iQL+ewlR3LRieKbN80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GbYjf43xDQrbApZlHFR5ZpIautdFQd8qySqHmXn8TXJu/pT+AYty6hWwhUX4Y7QqJ
	 xyVnaPB5jeYsfZgU920bZ0L+yEb32IxOfhwYRy5+swZ95aAZDy6Zt3IHd4YXHWBFlY
	 xUUatpuG53qoyCdWVR7fRC4Wf3y/IZIVPAApPeMu8gOJUCuiS9sFJXBP9KKQWrp+wY
	 1SiDUPZrNzi6XAtBer8virong1WPDoFWCoKrWYjx0BsUTfSfw31voVwdD/SQ0q/YDL
	 68MtKr1/xuPBOXDJRh4eubCi4s6/5zYY0Cnci7ePqRGnJ9psxfmt7Y3VPKCsHfYbuO
	 bzpZBRVWAd10Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3F383BA3A;
	Wed, 16 Jul 2025 20:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Stop supporting static ftrace
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175269601325.1308944.797202062677315473.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 20:00:13 +0000
References: <20250716-dev-alex-static_ftrace-v1-1-ba5d2b6fc9c0@rivosinc.com>
In-Reply-To: <20250716-dev-alex-static_ftrace-v1-1-ba5d2b6fc9c0@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, rostedt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, andybnac@gmail.com, bjorn@rivosinc.com,
 linux-kernel@vger.kernel.org, chenmiao.ku@gmail.com, lkp@intel.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Wed, 16 Jul 2025 12:05:16 +0000 you wrote:
> Now that DYNAMIC_FTRACE was introduced, there is no need to support
> static ftrace as it is way less performant. This simplifies the code and
> prevents build failures as reported by kernel test robot when
> !DYNAMIC_FTRACE.
> 
> Also make sure that FUNCTION_TRACER can only be selected if
> DYNAMIC_FTRACE is supported (we have a dependency on the toolchain).
> 
> [...]

Here is the summary with links:
  - riscv: Stop supporting static ftrace
    https://git.kernel.org/riscv/c/5874ca4c6280

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



