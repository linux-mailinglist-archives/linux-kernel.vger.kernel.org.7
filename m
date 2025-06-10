Return-Path: <linux-kernel+bounces-680015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D285AD3EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732D417C836
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28E924469E;
	Tue, 10 Jun 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBOukgqU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10B241671;
	Tue, 10 Jun 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572887; cv=none; b=c68EsliO3feC2EdYlZKUDqZb/0MbNR1OebQ7TtjJ2PTVL91UfyfWCqkVhqLl6HTk+kpz4TwK2mLT2qdEgGHEO+veZ8P50R17L00/zrrEp60kZfez8LbIolq5glSR1H9hpgdzKGYSz5F1rNBX3hlXd8VnlJHebxByitS/sQwYGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572887; c=relaxed/simple;
	bh=UfWMNdPrkqC4tlqc6fPvtbZO1G8O2Spm8W6u5bQX+sg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r91y69c0X524qlQxy/uwPiIRAhTFxeCHoPMjVdRw0jfXsiyVfeeRVt7jdlGkpPMyNoxz/dTbW+N9lUdq+tBTlDrX++Rd+edHOZSYML5P+TsV0A/W3BV7WkMYVM4IbTYdsRVZTgl6vbw8GPNvFbtorYVkEtyNeCo+CbJ8x+HyiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBOukgqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5257C4CEED;
	Tue, 10 Jun 2025 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749572886;
	bh=UfWMNdPrkqC4tlqc6fPvtbZO1G8O2Spm8W6u5bQX+sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hBOukgqUoYHkJT4+Yt6L6J0g9mXhH5DdsPOob2ZcLjZ+1qP09+fO9k8aCvWj3lFut
	 fh/pOqPKm3sM5uXajzv5kmcsNFOe3LiGqZzoEzUkpU0sga3+CcpFpKNCYTXfwvwmG5
	 vkVYMPs81brQJ6V1FHgNrH6FJXu92Q/eXiT8ZowvO/lTqd5ZyorWfXP4iNv11QIRat
	 8ofKeBJDI2W1IYTw6fl8dd16NY/GZoT/xBGJI67+57W6RHyWMfNLiQcn3io3XWwzHh
	 upghmHwwb8tEFFfKyBgUItTws0xbpsDIX1Vu8SV/hrA6mdDabFjGpmQyQBSZsuezmL
	 gUgu/mKAEApbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA939D6540;
	Tue, 10 Jun 2025 16:28:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers: acpi: Fix platform profile driver on !acpi
 platforms
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174957291699.2454024.8618597246072730689.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 16:28:36 +0000
References: <20250522141410.31315-1-alexghiti@rivosinc.com>
In-Reply-To: <20250522141410.31315-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, rafael@kernel.org, lenb@kernel.org,
 ilpo.jarvinen@linux.intel.com, mario.limonciello@amd.com,
 mpearson-lenovo@squebb.ca, W_Armin@gmx.de, arnd@arndb.de,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Rafael J. Wysocki <rafael.j.wysocki@intel.com>:

On Thu, 22 May 2025 16:13:56 +0200 you wrote:
> The platform profile driver is loaded even on platforms that do not have
> acpi enabled. The initialization of the sysfs entries was recently moved
> from platform_profile_register() to the module init call, and those
> entries need acpi_kobj to be initialized which is not the case when acpi
> is disabled.
> 
> This results in the following warning:
> 
> [...]

Here is the summary with links:
  - drivers: acpi: Fix platform profile driver on !acpi platforms
    https://git.kernel.org/riscv/c/dd133162c9cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



