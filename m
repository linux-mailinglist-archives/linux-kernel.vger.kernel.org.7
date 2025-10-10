Return-Path: <linux-kernel+bounces-847685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7183EBCB691
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13983BFA3D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DE6242D86;
	Fri, 10 Oct 2025 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzNjMqVo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171923D7E8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063253; cv=none; b=hbHHYp3Gfw7rWcpr2jIfcrrkO5Xqb/7YcetppYj/W9auWi7vgEF3EiMs63vzMLJwZuqqlMyneGPKB2zX870XY5C4TwkoYbCytnh8eMGSjpzMmiHyvBautwbGrmaM0bv4Mc3HZbWr5zLWQ7mdWoLrolHo7rO1ZV33EfSwR5VwETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063253; c=relaxed/simple;
	bh=CAvsAwjaWn/h2QM1s6i1PciEcb48b9O0RDgV9x92drI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JsAyspHnsulqgOD6uPrp1OOUajxKNDOLwccb334pcWI/50rtc2KjQSVeEmXmNKZX9N4grIys/ll+pXQtmkOx2zAhGE1uTjpeMnl5dtGY4uSWO1qMXE4fnoj/IYiPbraf4j66me7tZaqc0+cq+qgIfCHOdRLtoWUUtg0vE6qDK6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzNjMqVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9928C4CEE7;
	Fri, 10 Oct 2025 02:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063252;
	bh=CAvsAwjaWn/h2QM1s6i1PciEcb48b9O0RDgV9x92drI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qzNjMqVoQ9XsQjbJt3m8Yj2kqXw7xRvVExRuwyxE1Plet9Zz3QsHIZEXQRJMJsLEU
	 lpkV5/We1G/xDANaLw/UEe4ofEtLcNGxnRzDYaX1s68olfOxXDzWGJ18jzVNkPT/uU
	 6TK8a+3iyofC7cc3RkVO7gtbe97wOilE0dRlGWT3//9X6R0sunE4iRCRX70tcfi2eQ
	 8TbWYVyviI7EfWR8dGbS218JkYfK98sS1R3lUVKLP+JsTvg6vnsZeGTZmdiMzNhvFl
	 noehEnnyhgciOmUZhYDrYofcOpT7mUkpVnbB7QB87a4Wj7BpqgjOxkYL/dPY8qAVE2
	 itkAyxL9ysFbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5B3A55FB5;
	Fri, 10 Oct 2025 02:27:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: acpi: chose to boot from acpi then disable FDT
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176006324074.354358.17217967414602352060.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 02:27:20 +0000
References: <20250910112401.552987-1-rabenda.cn@gmail.com>
In-Reply-To: <20250910112401.552987-1-rabenda.cn@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, rppt@kernel.org, andybnac@gmail.com,
 guoweikang.kernel@gmail.com, visitorckw@gmail.com, bjorn@rivosinc.com,
 sycamoremoon376@gmail.com, usamaarif642@gmail.com, yongxuan.wang@sifive.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 10 Sep 2025 19:24:01 +0800 you wrote:
> avoid errors caused by repeated driver initialization.
> 
> commit 3505f30fb6a9 ("ARM64 / ACPI: If we chose to boot from acpi then disable FDT")
> 
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> ---
>  arch/riscv/kernel/setup.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Here is the summary with links:
  - riscv: acpi: chose to boot from acpi then disable FDT
    https://git.kernel.org/riscv/c/69a8b62a7aa1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



