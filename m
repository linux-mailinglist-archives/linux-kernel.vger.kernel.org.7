Return-Path: <linux-kernel+bounces-774665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF07B2B5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B1816DF9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E18A188734;
	Tue, 19 Aug 2025 01:16:05 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7333F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566165; cv=none; b=YrOVIbD5KfcZ+ZmRMFSM860KdIg8GpoHH4XNlmvpn31tJDe8NdkgxCPgCXczm6COZkeoADuWvOpA42T8o+LqBH8xjj+oW4eQ6GlBP3eHGAlKk6p0BuBHvGhaZiHAzizgkFIWtbtraMkzI9AivPwtNa6vRMrqwDN+4njSvOGcyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566165; c=relaxed/simple;
	bh=cI/2YLlXuBpoG7SrtlENoCld405FksSCRJovnoDVR0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c02+cRO7+3V/GiXTRB04E9YimGICX1/vHhkDINKq45zIObOgeCpHiVPsqT6Y8sRzOEkbrxyR7EzgLpv45VpUrcfHVJmMbEyF8KBwimjIjhRMfvJA0pEnfFyVLtimelOlwxWOcwgq8zQgtr5Qm1rB1BBsuT4xz8vbPqocTH8adaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c5WmS0sgdz2TT3C;
	Tue, 19 Aug 2025 09:13:12 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D1EA180042;
	Tue, 19 Aug 2025 09:15:59 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 09:15:58 +0800
Message-ID: <88a96294-c2a2-477f-ac9b-5867e0b59883@huawei.com>
Date: Tue, 19 Aug 2025 09:15:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] f2fs: fix to avoid NULL pointer dereference in
 f2fs_check_quota_consistency()
To: Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com>
References: <20250818020939.3529802-1-chao@kernel.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250818020939.3529802-1-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/8/18 10:09, Chao Yu wrote:
> syzbot reported a f2fs bug as below:
> 
> Oops: gen[  107.736417][ T5848] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 5848 Comm: syz-executor263 Tainted: G        W           6.17.0-rc1-syzkaller-00014-g0e39a731820a #0 PREEMPT_{RT,(full)}
> RIP: 0010:strcmp+0x3c/0xc0 lib/string.c:284
> Call Trace:
>   <TASK>
>   f2fs_check_quota_consistency fs/f2fs/super.c:1188 [inline]
>   f2fs_check_opt_consistency+0x1378/0x2c10 fs/f2fs/super.c:1436
>   __f2fs_remount fs/f2fs/super.c:2653 [inline]
>   f2fs_reconfigure+0x482/0x1770 fs/f2fs/super.c:5297
>   reconfigure_super+0x224/0x890 fs/super.c:1077
>   do_remount fs/namespace.c:3314 [inline]
>   path_mount+0xd18/0xfe0 fs/namespace.c:4112
>   do_mount fs/namespace.c:4133 [inline]
>   __do_sys_mount fs/namespace.c:4344 [inline]
>   __se_sys_mount+0x317/0x410 fs/namespace.c:4321
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The direct reason is f2fs_check_quota_consistency() may suffer null-ptr-deref
> issue in strcmp().
> 
> The bug can be reproduced w/ below scripts:
> mkfs.f2fs -f /dev/vdb
> mount -t f2fs -o usrquota /dev/vdb /mnt/f2fs
> quotacheck -uc /mnt/f2fs/
> umount /mnt/f2fs
> mount -t f2fs -o usrjquota=aquota.user,jqfmt=vfsold /dev/vdb /mnt/f2fs
> mount -t f2fs -o remount,usrjquota=,jqfmt=vfsold /dev/vdb /mnt/f2fs
> umount /mnt/f2fs
> 
> So, before old_qname and new_qname comparison, we need to check whether
> they are all valid pointers, fix it.
> 
> Reported-by: syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com
> Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
> Closes: https://lore.kernel.org/linux-f2fs-devel/689ff889.050a0220.e29e5.0037.GAE@google.com
> Cc: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

>   fs/f2fs/super.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 5aa9d650512d..465604fdc5dd 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1219,7 +1219,8 @@ static int f2fs_check_quota_consistency(struct fs_context *fc,
>   				goto err_jquota_change;
>   
>   			if (old_qname) {
> -				if (strcmp(old_qname, new_qname) == 0) {
> +				if (new_qname &&
> +					strcmp(old_qname, new_qname) == 0) {
>   					ctx->qname_mask &= ~(1 << i);
>   					continue;
>   				}

