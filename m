Return-Path: <linux-kernel+bounces-859276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74014BED341
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF2840150B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31B22F772;
	Sat, 18 Oct 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX+SerO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB691153BE9
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803305; cv=none; b=uBigTocacjOyk4Hzi3TNCWwrkmfDnAZtcMU+4sQMdYKOzsl6DY7OS4ddmVb8OhEVYAA4ZFFNPX/EzzduAtP1XxHWJdM29Y5xlesKcxrasADozmhZuKBcxzFqwFKJULjdCWxVFArLaRotjweTXCqpj9npJpa4h45K+ddQEkSk90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803305; c=relaxed/simple;
	bh=14MmDG9UhGu/qABnEIMl0mpUbYr7HbIkZDefzRziZBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GIKCuabJRkDxWJkWop61RKFj1zQv3AwBhJANAxlBP7YUZPUqq+k+l7Kd0O4SEJJsOTSDIKmSLtZyXHYwqofcVjTWhZC3geOoitB+ETntv3MysFFjkGssO9CFFLcXma0ejIzHF/51CAMem5GjzWcdMkCN1tVybBbQVe71TwRk2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX+SerO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B83C4CEF8;
	Sat, 18 Oct 2025 16:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760803305;
	bh=14MmDG9UhGu/qABnEIMl0mpUbYr7HbIkZDefzRziZBI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bX+SerO+NfFijq7MNVOtPcAS9jsbQpe1GSMkow8wKPqFRZpfmofX+UiOd9v5R74lV
	 un6tQMSOLaWlE1SB35VpBD6AQXN2mQiRhXHKsPyuIJyY1IIN3O9Uzany18bO53l6WO
	 7WZf0deXTTZTAK1h+gGf3roxEDTv3Qn8C0s6cHRQY3dgH+kUTerWj7oSELXYwcgFJN
	 2T7zfbyR0ev8iLWDT6JOQT03ncWTSWFwwlgqmGPn589VJnKOW2YUSeC1Kqlj7WsD6a
	 qCt8PxVPp0gGRLulCkn6dlGLIRN//tBrR0KME6n1ses3xpW4B0/8lxe5DVQGHTmVQd
	 gpXXw39ZKvp/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE24439EFBB7;
	Sat, 18 Oct 2025 16:01:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Register IPI IRQs with unique names
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176080328851.3028979.9102914786827075477.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 16:01:28 +0000
References: <20251016003244.3910332-1-samuel.holland@sifive.com>
In-Reply-To: <20251016003244.3910332-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org,
 aou@eecs.berkeley.edu, alex@ghiti.fr, conor.dooley@microchip.com,
 jassisinghbrar@gmail.com, valentina.fernandezalanis@microchip.com,
 cuiyunhui@bytedance.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 15 Oct 2025 17:32:05 -0700 you wrote:
> This allows different IPIs to be distinguished in tracing output.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/riscv/kernel/smp.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Here is the summary with links:
  - riscv: Register IPI IRQs with unique names
    https://git.kernel.org/riscv/c/223bfc4d403c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



