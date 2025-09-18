Return-Path: <linux-kernel+bounces-757129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F5B1BE11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F8C1896E82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53E13957E;
	Wed,  6 Aug 2025 00:55:18 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49481AD2C;
	Wed,  6 Aug 2025 00:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754441718; cv=none; b=I+wFvXc+Zi4KR45g+mB+SjNMMBjB2RFTtc7UzSM6O3tgThP1EcTtp8bLOxZ2+ZWhP+N8TZtJSSEdFEnvkDwNRlOHKrxqjf9D4jCJMSPpg0e02XFuLmET7hoAcnvmtptPEOv0ECLlBvrsEnkSR2J5dr4dnsnR1lOJmAfKTEkIUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754441718; c=relaxed/simple;
	bh=9xWUvi+yiK4kM6rJqe2ZmEmcv0iy1BI+bQ5X1tNoN6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXnhytT/baFSsKmvdwHBk793fAEsPaWjgfBrrIJl/sxktjWxXEqK18l2csk/n90XFByqQk7E20Zmbkr2eATqF5k1v3QE96kRHghx8LTFnu1F7TfFgKeiY8sQQH/QKAX/iMlfDYZDxG7WPzFTk/nz1yFgE+p0iKXwoz8qhq5aeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxWzj0tBxzKHMpB;
	Wed,  6 Aug 2025 08:55:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2DD941A0C3E;
	Wed,  6 Aug 2025 08:55:12 +0800 (CST)
Received: from [10.174.178.209] (unknown [10.174.178.209])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hLtp5Jori_cCg--.6325S3;
	Wed, 06 Aug 2025 08:55:10 +0800 (CST)
Message-ID: <c980644d-0be1-4a88-890d-349b44ada024@huaweicloud.com>
Date: Wed, 6 Aug 2025 08:55:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] Fix mid_q_entry memory leaks in SMB client
To: Steve French <smfrench@gmail.com>
Cc: pshilov@microsoft.com, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 chengzhihao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 Enzo Matsumiya <ematsumiya@suse.de>
References: <20250805064708.332465-1-wangzhaolong@huaweicloud.com>
 <CAH2r5mssz19Qr+fmY62BnHOzwjQmWWU=wHXEVFkyTRGaWn-t0g@mail.gmail.com>
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
In-Reply-To: <CAH2r5mssz19Qr+fmY62BnHOzwjQmWWU=wHXEVFkyTRGaWn-t0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn4hLtp5Jori_cCg--.6325S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr4fuF4UGF4Uury3Wr1ftFb_yoWxGFyxpr
	1rWFy8A3Z0k3srtrW3tF1xKryFvrsIgr17Xrs2ka4FkFsrCr48XryxAF15WFnIg3y7Zr1D
	KrW0vF15JrykAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: pzdqw6xkdrz0tqj6x35dzhxuhorxvhhfrp/





> The first three patches (cleanup) look fine and have added to
> cifs-2.6.git for-next (also added Enzo Acked-by) but the fourth patch
> ("smb: client: fix mid_q_entry memleak leak with per-mid locking")
> causes xfstest generic/001 to fail with signing enabled.  See
> http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5/builds/58/steps/34/logs/stdio
> and http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5/builds/59/steps/34/logs/stdio
> 

I am unable to view any information in the link above. Is this information
only visible to logged-in users?


> 
> [Tue Aug 5 11:03:32 2025] run fstests generic/001 at 2025-08-05 11:03:32
> [Tue Aug 5 11:03:33 2025] =============================
> [Tue Aug 5 11:03:33 2025] [ BUG: Invalid wait context ]
> [Tue Aug 5 11:03:33 2025] 6.16.0 #1 Tainted: G E
> [Tue Aug 5 11:03:33 2025] -----------------------------
> [Tue Aug 5 11:03:33 2025] cifsd/24912 is trying to lock:
> [Tue Aug 5 11:03:33 2025] ffffffffafc14630
> (crypto_alg_sem){++++}-{4:4}, at: crypto_alg_lookup+0x40/0x120
> [Tue Aug 5 11:03:33 2025] other info that might help us debug this:
> [Tue Aug 5 11:03:33 2025] context-{5:5}
> [Tue Aug 5 11:03:33 2025] 1 lock held by cifsd/24912:
> [Tue Aug 5 11:03:33 2025] #0: ff11000134c25870
> (&temp->mid_lock){+.+.}-{3:3}, at: mid_execute_callback+0x19/0x40
> [cifs]
> [Tue Aug 5 11:03:33 2025] stack backtrace:
> [Tue Aug 5 11:03:33 2025] CPU: 1 UID: 0 PID: 24912 Comm: cifsd
> Tainted: G E 6.16.0 #1 PREEMPT(voluntary)
> [Tue Aug 5 11:03:33 2025] Tainted: [E]=UNSIGNED_MODULE
> [Tue Aug 5 11:03:33 2025] Hardware name: Red Hat KVM, BIOS
> 1.16.3-4.el9 04/01/2014
> [Tue Aug 5 11:03:33 2025] Call Trace:
> [Tue Aug 5 11:03:33 2025] <TASK>
> [Tue Aug 5 11:03:33 2025] dump_stack_lvl+0x79/0xb0
> [Tue Aug 5 11:03:33 2025] __lock_acquire+0xace/0x21c0
> [Tue Aug 5 11:03:33 2025] ? check_irq_usage+0xa4/0xa80
> [Tue Aug 5 11:03:33 2025] lock_acquire+0x143/0x2d0
> [Tue Aug 5 11:03:33 2025] ? crypto_alg_lookup+0x40/0x120
> [Tue Aug 5 11:03:33 2025] ? check_noncircular+0x71/0x120
> [Tue Aug 5 11:03:33 2025] down_read+0x7c/0x2e0
> [Tue Aug 5 11:03:33 2025] ? crypto_alg_lookup+0x40/0x120
> [Tue Aug 5 11:03:33 2025] ? __pfx_down_read+0x10/0x10
> [Tue Aug 5 11:03:33 2025] ? lockdep_unlock+0x51/0xc0
> [Tue Aug 5 11:03:33 2025] ? __lock_acquire+0x11ee/0x21c0
> [Tue Aug 5 11:03:33 2025] crypto_alg_lookup+0x40/0x120
> [Tue Aug 5 11:03:33 2025] crypto_alg_mod_lookup+0x53/0x2b0
> [Tue Aug 5 11:03:33 2025] crypto_alloc_tfm_node+0x76/0x130
> [Tue Aug 5 11:03:33 2025] cifs_alloc_hash+0x44/0x130 [cifs]
> [Tue Aug 5 11:03:33 2025] smb3_calc_signature+0x4f0/0x7b0 [cifs]
> [Tue Aug 5 11:03:33 2025] ? __pfx_smb3_calc_signature+0x10/0x10 [cifs]
> [Tue Aug 5 11:03:33 2025] ? find_held_lock+0x2b/0x80
> [Tue Aug 5 11:03:33 2025] ? tcp_recvmsg+0xc9/0x2d0
> [Tue Aug 5 11:03:33 2025] ? rcu_is_watching+0x20/0x50
> [Tue Aug 5 11:03:33 2025] ? trace_irq_enable.constprop.0+0xac/0xe0
> [Tue Aug 5 11:03:33 2025] ? tcp_recvmsg+0xc9/0x2d0
> [Tue Aug 5 11:03:33 2025] ? __local_bh_enable_ip+0x90/0xf0
> [Tue Aug 5 11:03:33 2025] ? sock_has_perm+0x97/0x1a0
> [Tue Aug 5 11:03:33 2025] smb2_verify_signature+0x178/0x290 [cifs]
> [Tue Aug 5 11:03:33 2025] ? __pfx_smb2_verify_signature+0x10/0x10 [cifs]
> [Tue Aug 5 11:03:33 2025] ? look_up_lock_class+0x5d/0x140
> [Tue Aug 5 11:03:33 2025] smb2_check_receive+0x154/0x1c0 [cifs]
> [Tue Aug 5 11:03:33 2025] ? __pfx_smb2_check_receive+0x10/0x10 [cifs]
> [Tue Aug 5 11:03:33 2025] ? __lock_acquire+0x3f1/0x21c0
> [Tue Aug 5 11:03:33 2025] ? __lock_acquire+0x3f1/0x21c0
> [Tue Aug 5 11:03:33 2025] smb2_writev_callback+0x1f2/0x870 [cifs]
> [Tue Aug 5 11:03:33 2025] ? lock_acquire+0x143/0x2d0
> [Tue Aug 5 11:03:33 2025] ? mid_execute_callback+0x19/0x40 [cifs]
> [Tue Aug 5 11:03:33 2025] ? __pfx_smb2_writev_callback+0x10/0x10 [cifs]
> [Tue Aug 5 11:03:33 2025] ? do_raw_spin_lock+0x10c/0x190
> [Tue Aug 5 11:03:33 2025] ? __pfx_do_raw_spin_lock+0x10/0x10
> [Tue Aug 5 11:03:33 2025] ? _raw_spin_unlock+0x23/0x40
> [Tue Aug 5 11:03:33 2025] mid_execute_callback+0x33/0x40 [cifs]
> [Tue Aug 5 11:03:33 2025] cifs_demultiplex_thread+0xc95/0x15e0 [cifs]
> [Tue Aug 5 11:03:33 2025] ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
> [Tue Aug 5 11:03:33 2025] ? find_held_lock+0x2b/0x80
> [Tue Aug 5 11:03:33 2025] ? __kthread_parkme+0x4b/0xd0
> [Tue Aug 5 11:03:33 2025] ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
> [Tue Aug 5 11:03:33 2025] kthread+0x216/0x3e0
> [Tue Aug 5 11:03:33 2025] ? __pfx_kthread+0x10/0x10
> [Tue Aug 5 11:03:33 2025] ? __pfx_kthread+0x10/0x10
> [Tue Aug 5 11:03:33 2025] ? lock_release+0xc4/0x270
> [Tue Aug 5 11:03:33 2025] ? rcu_is_watching+0x20/0x50
> [Tue Aug 5 11:03:33 2025] ? __pfx_kthread+0x10/0x10
> [Tue Aug 5 11:03:33 2025] ret_from_fork+0x23a/0x2e0
> [Tue Aug 5 11:03:33 2025] ? __pfx_kthread+0x10/0x10
> [Tue Aug 5 11:03:33 2025] ret_from_fork_asm+0x1a/0x30
> [Tue Aug 5 11:03:33 2025] </TASK>
> 
> (it worked without the patch see e.g.
> http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5/builds/60
> and http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5/builds/56)
> 
> On Tue, Aug 5, 2025 at 1:54 AM Wang Zhaolong
> <wangzhaolong@huaweicloud.com> wrote:


It's quite strange that the lock reported in the stack trace is an internal
lock of the crypto module, which only protects the internal logic of crypto.
Moreover, I have not yet found a path where the callback for cifs registration
is executed within the scope of this lock.

```c
// crypto/api.c
static struct crypto_alg *crypto_alg_lookup(const char *name, u32 type,
					    u32 mask)
{
	const u32 fips = CRYPTO_ALG_FIPS_INTERNAL;
	struct crypto_alg *alg;
	u32 test = 0;

	if (!((type | mask) & CRYPTO_ALG_TESTED))
		test |= CRYPTO_ALG_TESTED;

	down_read(&crypto_alg_sem);
	...
	up_read(&crypto_alg_sem);
	return alg;
```
More information is needed to confirm this issue. Could you please provide it?

Best regards,
Wang Zhaolong


