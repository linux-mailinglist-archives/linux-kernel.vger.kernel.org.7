Return-Path: <linux-kernel+bounces-744911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7218CB11263
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A111D0014D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4AC2ED878;
	Thu, 24 Jul 2025 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KevnvUtX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C42ED157
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388997; cv=none; b=B3XR8BsLadaZWAnF6O58igh+pSesdhQXSnZLUJUwL1ti4myyx92BNOkvWDyyddXULVd1/5O3Drqb9lgk/V/aiGRyjTQXZPiR6xjpqkrhfELDxi/Ssfq1f3PZXLdhnNKMBF1Z8pJ0YGT4sNgWUlbFdtiHjGUlaPI14krHyXXrmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388997; c=relaxed/simple;
	bh=yUA0VWIyeHlYZOjb7vM/j98AYzNvhPEn+9fx/2KTsoc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rbEnoRQQXWygY9hpVY1dViO9vFmFR7XirboDLtj6cZ89DT48el0FOaZdOEB7QSxZE/Cih0HhcFrC9KrLSZ10ElLMUa2i5b3VUaMRyZ8ZvUHjp9ZmkCeV6gN2kX6PaLnwidL36Y7DNJveQCTqs9BZQEzt+7h+Uk9eCH59L58DNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KevnvUtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FCDC4CEF1;
	Thu, 24 Jul 2025 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753388996;
	bh=yUA0VWIyeHlYZOjb7vM/j98AYzNvhPEn+9fx/2KTsoc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KevnvUtX5M3vEuUgXUMFOB6wdBE2Cl4dD87KoJAfI2S01De7sTGzSI8LnAeDg/zX5
	 TB6RrHoSyAJstZ47NiKG1HXcyxwy/WQz6+kQWzY3oJL2DUE+hWXSpSanCnyIbMqevI
	 7klEuEP8npU44j8zrJnGajTL2lX/Ah/LnGjew1IGXe/LThFsZENfXrEzSsQVu5Hp7G
	 PJBJqO+IJ0Y+ue5YfmQHxHJymN77sARvGvSCXKOJMR7tbnXnZktCEb51+Uvqy66E7A
	 RfH8e3mev60G61s9jrkYcxULvNfMDO3PiEdYjmeqLIV79HDE3I+tEsygj3ZJBlHBKY
	 ftW+ZEWpHbJAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0C383BF4E;
	Thu, 24 Jul 2025 20:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: vm_unmap_ram() may be called from an
 invalid context
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175338901449.2519964.11721744043840464584.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 20:30:14 +0000
References: <20250724153115.125311-1-jprusakowski@google.com>
In-Reply-To: <20250724153115.125311-1-jprusakowski@google.com>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 24 Jul 2025 17:31:15 +0200 you wrote:
> When testing F2FS with xfstests using UFS backed virtual disks the
> kernel complains sometimes that f2fs_release_decomp_mem() calls
> vm_unmap_ram() from an invalid context. Example trace from
> f2fs/007 test:
> 
> f2fs/007 5s ...  [12:59:38][    8.902525] run fstests f2fs/007
> [   11.468026] BUG: sleeping function called from invalid context at mm/vmalloc.c:2978
> [   11.471849] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 68, name: irq/22-ufshcd
> [   11.475357] preempt_count: 1, expected: 0
> [   11.476970] RCU nest depth: 0, expected: 0
> [   11.478531] CPU: 0 UID: 0 PID: 68 Comm: irq/22-ufshcd Tainted: G        W           6.16.0-rc5-xfstests-ufs-g40f92e79b0aa #9 PREEMPT(none)
> [   11.478535] Tainted: [W]=WARN
> [   11.478536] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   11.478537] Call Trace:
> [   11.478543]  <TASK>
> [   11.478545]  dump_stack_lvl+0x4e/0x70
> [   11.478554]  __might_resched.cold+0xaf/0xbe
> [   11.478557]  vm_unmap_ram+0x21/0xb0
> [   11.478560]  f2fs_release_decomp_mem+0x59/0x80
> [   11.478563]  f2fs_free_dic+0x18/0x1a0
> [   11.478565]  f2fs_finish_read_bio+0xd7/0x290
> [   11.478570]  blk_update_request+0xec/0x3b0
> [   11.478574]  ? sbitmap_queue_clear+0x3b/0x60
> [   11.478576]  scsi_end_request+0x27/0x1a0
> [   11.478582]  scsi_io_completion+0x40/0x300
> [   11.478583]  ufshcd_mcq_poll_cqe_lock+0xa3/0xe0
> [   11.478588]  ufshcd_sl_intr+0x194/0x1f0
> [   11.478592]  ufshcd_threaded_intr+0x68/0xb0
> [   11.478594]  ? __pfx_irq_thread_fn+0x10/0x10
> [   11.478599]  irq_thread_fn+0x20/0x60
> [   11.478602]  ? __pfx_irq_thread_fn+0x10/0x10
> [   11.478603]  irq_thread+0xb9/0x180
> [   11.478605]  ? __pfx_irq_thread_dtor+0x10/0x10
> [   11.478607]  ? __pfx_irq_thread+0x10/0x10
> [   11.478609]  kthread+0x10a/0x230
> [   11.478614]  ? __pfx_kthread+0x10/0x10
> [   11.478615]  ret_from_fork+0x7e/0xd0
> [   11.478619]  ? __pfx_kthread+0x10/0x10
> [   11.478621]  ret_from_fork_asm+0x1a/0x30
> [   11.478623]  </TASK>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: vm_unmap_ram() may be called from an invalid context
    https://git.kernel.org/jaegeuk/f2fs/c/08a7efc5b02a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



