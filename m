Return-Path: <linux-kernel+bounces-760638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37063B1EE0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E24A3BC9A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD441EFFB2;
	Fri,  8 Aug 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mAxBhCKD"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A61E25F2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675527; cv=none; b=uedZR8RP2oAyxDUEuz0AxlGpvSaOhkteMrhVkYNRGbCMzwOUahCuoij+E0DW/uCy3kwdwg6mSS3yqykmay9JdwFKzpjl4WlcvKHTm8mWdeXMNR7WDvbdwzV40KvYX1SRR7gwnWh8YoUCCM9F3Zt3UFt3VrnTfZO7PJiJwSloYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675527; c=relaxed/simple;
	bh=WOFVCvGAkEVEUCqKYOpl/dRyeNlS5UqIk3RBdYGqXz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm1E+kj4vSOiCvmFu8pnRj69yBwv7B1krvivCIwrJG5n7nKtNRXOGawNoxP65Zz3+SdM7UcIUw+jQ06cE9TMlwlqZnl9Z05Mzarfd8v06AZ4cDTz/xnRKRJxcwB2gMIMpz7lwSD7WfNDMm1gdlwAYk626ViK1+4PBbTdfUkQsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mAxBhCKD; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754675511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5zH1D2kwmr8dCpgiqzWF8oQlWdm8uTmQJ1ar/ni0uw=;
	b=mAxBhCKD4LlUW0eBh/lYzJwUYhgNl3NagukLegOF6BYXBQtSdnjbLzFbp6ITTxiq+WbUtC
	pyCXzfyapFoD8+jgxbvb7FCWav6HpBU5WkpYT61y0s6TaM8KixWl7TxUCpftElM5l0QzIZ
	wfFopWdSOyLpS840FuoMTP+dmyKJ6Fo=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] kvm: arm64: use BUG() instead of BUG_ON(1)
Date: Fri,  8 Aug 2025 10:51:32 -0700
Message-Id: <175467548061.670500.14517325210508247749.b4-ty@linux.dev>
In-Reply-To: <20250807072132.4170088-1-arnd@kernel.org>
References: <20250807072132.4170088-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 07 Aug 2025 09:21:28 +0200, Arnd Bergmann wrote:
> The BUG_ON() macro adds a little bit of complexity over BUG(), and in
> some cases this ends up confusing the compiler's control flow analysis
> in a way that results in a warning. This one now shows up with clang-21:
> 
> arch/arm64/kvm/vgic/vgic-mmio.c:1094:3: error: variable 'len' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>  1094 |                 BUG_ON(1);
> 
> [...]

Applied to fixes, thanks!

[1/1] kvm: arm64: use BUG() instead of BUG_ON(1)
      https://git.kernel.org/kvmarm/kvmarm/c/700d6868fee2

--
Best,
Oliver

