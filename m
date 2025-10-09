Return-Path: <linux-kernel+bounces-846219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741FBC74DA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E5319E2F54
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48259221F11;
	Thu,  9 Oct 2025 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy2Gxc11"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526E2110
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980839; cv=none; b=TU3124vPcPRE4vVNdLWKUHfcXFoyOcfm+nQ16fhd3m2GbgPAg1wEFPC4ITkdIGu8GDOlUjhG6K6a7cXgjs5F87tCgVN0miMsESiHyvu5yIigT1RU4owC+I2w3S7K2mEEHyWzEKa8fJrqYMRcFkHEGOFKeAkhkV++Fzia4ftrX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980839; c=relaxed/simple;
	bh=xN41ZGE5H76e94Bp2o1lO5iAeArBWDxLBZZo+8wL+BI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Om5WmgT4uUrTpnPuCM6fjdmRTcj7QOeMt45qDcDZzdtjgPOBMS+TpL5Zb+gzedRfZjQpM6qxaiEC5hPWP8o7HtFR6OA80/CZ0fsDBMf0dkXmMxt4HQWxvti5UCgWgEf5rRRg42eI3T+pqg0LucQGoQ7ng8AJ0V/PH6pKuvtiMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy2Gxc11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0CFC4CEE7;
	Thu,  9 Oct 2025 03:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759980839;
	bh=xN41ZGE5H76e94Bp2o1lO5iAeArBWDxLBZZo+8wL+BI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Oy2Gxc11qxZN8TPQ/bTmqRRG6Av8DqQO6KKDUYdRmFKU+FDFEuWXB7VJbJ+57MF9Z
	 cgU0GQOS3534jfvW/Xq3a9vjie1nMxoK9VOzCCt0v9zwQp+pD7nUswWnL+Af8xP6qm
	 NSLKS5WF97Q29v1U2aKTcgZyjUzBGTAARKKE6mOXJLwTCDgDLNKrYyW449FEm+KMkA
	 lcOz5YVFlx4RbZERt6UbmB1iv1jCUcDlBXw0VFOpOyZQg675jvmtWlZg3S3ndIImQg
	 qi7n7g4C4bAbzdFvpz5jx7KqJee0Z60BQJO6SjkbEzSnT6HuRf5jD1jGRBdZ0VeTs9
	 TE9v4Hen7xu9Q==
Message-ID: <c4643bb6-882a-4229-b938-e94398294905@kernel.org>
Date: Thu, 9 Oct 2025 11:33:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: ensure node page reads complete before
 f2fs_put_super() finishes
To: Jan Prusakowski <jprusakowski@google.com>, jaegeuk@kernel.org
References: <20251006084615.2585252-1-jprusakowski@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251006084615.2585252-1-jprusakowski@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/2025 4:46 PM, Jan Prusakowski via Linux-f2fs-devel wrote:
> Xfstests generic/335, generic/336 sometimes crash with the following message:
> 
> F2FS-fs (dm-0): detect filesystem reference count leak during umount, type: 9, count: 1
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/super.c:1939!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 1 UID: 0 PID: 609351 Comm: umount Tainted: G        W           6.17.0-rc5-xfstests-g9dd1835ecda5 #1 PREEMPT(none)
> Tainted: [W]=WARN
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:f2fs_put_super+0x3b3/0x3c0
> Call Trace:
>   <TASK>
>   generic_shutdown_super+0x7e/0x190
>   kill_block_super+0x1a/0x40
>   kill_f2fs_super+0x9d/0x190
>   deactivate_locked_super+0x30/0xb0
>   cleanup_mnt+0xba/0x150
>   task_work_run+0x5c/0xa0
>   exit_to_user_mode_loop+0xb7/0xc0
>   do_syscall_64+0x1ae/0x1c0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> It appears that sometimes it is possible that f2fs_put_super() is called before
> all node page reads are completed.
> Adding a call to f2fs_wait_on_all_pages() for F2FS_RD_NODE fixes the problem.
> 
> Fixes: bf22c3cc8ce7 ("f2fs: fix the panic in do_checkpoint()")
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
> ---
>   fs/f2fs/super.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1e0678e37a30..5c94bc42b8a1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1976,6 +1976,7 @@ static void f2fs_put_super(struct super_block *sb)
>   	f2fs_flush_merged_writes(sbi);
>   
>   	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
> +	f2fs_wait_on_all_pages(sbi, F2FS_RD_NODE);

Jan,

At this stage, GC and checkpoint are both stopped, why there is still read
IOs on node page? Who is reading node page? Can you please dig more details
for this issue?

Thanks,

>   
>   	if (err || f2fs_cp_error(sbi)) {
>   		truncate_inode_pages_final(NODE_MAPPING(sbi));


