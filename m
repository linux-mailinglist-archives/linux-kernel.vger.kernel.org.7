Return-Path: <linux-kernel+bounces-664607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872DEAC5E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 02:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E7B4A24C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 00:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7772634;
	Wed, 28 May 2025 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1tmQOkw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED27B667;
	Wed, 28 May 2025 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391523; cv=none; b=LfR9+zcSKn7P1yYfzvdTxq8QkbVECgI4xnkgNuxnolHIH0rNTSt0Oyj3B4d3MSVTxrX7UKVj1CcoOgzScYOUrx4CxF6zKXfQCHye42SOqViuaWpC76/w1ChAriIL9te8PGuovDBvPkvnolMaAsSqKgVG9mnPpfxiiXSux0XCv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391523; c=relaxed/simple;
	bh=bqmnR7r6yChoVMHSf/iV8a7xGq0hBR/VQVvXl67ZSCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie5dqn1uzeMchZWr216gcCKkpSfknGHm1oSap4v5WNJ12/8VM6qzGqsmRbeKdLRs9AYVl1pF+sJcz25P5S8dlVeFfBk2YO3kbt2hqOgq2rf+5o6MTY372czHVdVQoKJuqEPnwpg8pBnBhahCgFRWCLe7YsXu/wVMkyiLafjEzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1tmQOkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C120CC4CEE9;
	Wed, 28 May 2025 00:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748391522;
	bh=bqmnR7r6yChoVMHSf/iV8a7xGq0hBR/VQVvXl67ZSCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1tmQOkw+4S8BjWO5v2hRTQZWKFHrOnmZyJMr9FuCc90Pl+DkvB0fKaIds3fsBfr+
	 hjK7vzV6gnw2cP53/c3ssODqR2apQtcxVFuU5GmITBehYjgEvxFq/LMZ8RzbhfJv69
	 1NEYVURhb6Dr4EKPmapbUQm4X7xWxLklx0fkiJAGsb8raskDQ8TyPz4NOei+3p0MMi
	 Oka3ooikT6ZKBKCTnKLSbpeSLfCPzhZ+Ttq3WGrgAuxVhVmk+Fmd5l6QKcUCiCaI3+
	 RjunZlvarhofQjqJAlRsPQY6QGg27sLbqr5r6COPYMe1lFLubB9cb6c7YucXM37Mcf
	 2xa2f3/uzhODw==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
Date: Wed, 28 May 2025 02:18:27 +0200
Message-ID: <20250528001827.4008958-1-ojeda@kernel.org>
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 May 2025 18:16:37 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.9 release.
> There are 783 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

