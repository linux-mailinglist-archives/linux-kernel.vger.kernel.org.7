Return-Path: <linux-kernel+bounces-795951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F611B3F9E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A7B7AB2DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FFF2E9EB9;
	Tue,  2 Sep 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="YK+yorOQ";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="yyWTFTud"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EC2E9EC1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804237; cv=none; b=myyTlLvZRjPTF6JuGNEOVO7ZHlPc+OFm07x8PvaT2Mn4dawjMaujsnfUoQ8KF5GPuk8xp5dCfDZqY7ZBg+cxwti22b3Qnn59GzjQynC98HUBBBoLoAGSdKT7OnAowC5ET+4lLZ3j+xz3P2S+nr8zFUo3REOmtLpz0cO5wzJY/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804237; c=relaxed/simple;
	bh=4Xf8OdtcGZaqHdo4VLGymDe418U5yCAwwJdrlbUfSUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H5vshEbyB5XvdZq3WjjknaC8jGU6S3ocNYqDod/21sfPbZDbi+0mxtLvIK5/84V9Qu/lMx+MuzJD391KTFuqv6xlo0x+oYxIUd5dYmRf7vYXmkKKIKwbA7UiX5QC5E2ysvX+nXLL/+Ij7uOWM7yBTtUFkZL7yt3dqqy36rtWjUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=YK+yorOQ; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=yyWTFTud; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A0CA7209655A;
	Tue,  2 Sep 2025 18:01:58 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1756803718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0i4iqDmw+qNlin2BRMdIwbdanhuOVQ1M638HyagkDI=;
	b=YK+yorOQ+8eiThFG2h1iLNeS5cXpZ2HnFZgSuYjTtpQC1YuElFatYW154h9TReeOQLT/MC
	r6ymnZCjBzb1JbmRfYgR/zanuAW6CBprAGhtxngm33TArQdjWefnJT8OV+EbPXwNWoNAs1
	y2/79OhBWwgkgca+mvJDNn8swE02rZoJjQEyKCKfRQnqSOTwgc+JmgLAuYnlnrECb7PhI+
	/eAWS0rGPubv91QBx3rnw4fCNIO63Iqnv2vrIxGJCKartLjquozlXqSGLGGhWYxUFx61Zd
	uCX/uXemeEPtNI8swCQ1OmIMEEzQLCBy7L1tLZYHkOBQbkAFShuhsBDHh4veyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1756803718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0i4iqDmw+qNlin2BRMdIwbdanhuOVQ1M638HyagkDI=;
	b=yyWTFTudxt5mQyhJBzjSALftY2iceFfg/CItyiescXGwZ69mto5WIQZ3H/w5XYNRkTg5+9
	SKQzbSsOsgyrCEAw==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 58291vSW152090
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 18:01:58 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 58291uji378077
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 18:01:56 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 58291uQr378076;
	Tue, 2 Sep 2025 18:01:56 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: YangWen <anmuxixixi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix data-race between fat12_ent_put() and
 fat_mirror_bhs()
In-Reply-To: <20250902081727.7146-1-anmuxixixi@gmail.com>
References: <20250902081727.7146-1-anmuxixixi@gmail.com>
Date: Tue, 02 Sep 2025 18:01:56 +0900
Message-ID: <87y0qxp6rf.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

YangWen <anmuxixixi@gmail.com> writes:

> KCSAN reported a data-race between fat12_ent_put() and fat_mirror_bhs():
> one CPU was updating a FAT12 entry while another CPU was copying the
> whole sector to mirror FATs.Fix this by protecting memcpy() in
> fat_mirror_bhs() with the same fat12_entry_lock that guards
> fat12_ent_put(),so that the writer and the mirror operation
> are mutually exclusive.

Hm, what is wrong with temporary inconsistent?

If it had the race with future modification, it can be temporary
inconsistent. However, future modification will fix it by updating with
latest blocks, right?

Or did you actually get the inconsistent state after clean unmount?

Thanks.

> FAT-fs (loop5): error, clusters badly computed (404 != 401)
> ==================================================================
> BUG: KCSAN: data-race in fat12_ent_put / fat_mirror_bhs
>
> write to 0xffff888106c953e9 of 1 bytes by task 7452 on cpu 1:
>  fat12_ent_put+0x74/0x170 fs/fat/fatent.c:168
>  fat_ent_write+0x69/0xe0 fs/fat/fatent.c:417
>  fat_chain_add+0x15d/0x440 fs/fat/misc.c:136
>  fat_add_cluster fs/fat/inode.c:112 [inline]
>  __fat_get_block fs/fat/inode.c:154 [inline]
>  fat_get_block+0x46c/0x5e0 fs/fat/inode.c:189
>  __block_write_begin_int+0x3fd/0xf90 fs/buffer.c:2145
>  block_write_begin fs/buffer.c:2256 [inline]
>  cont_write_begin+0x5fc/0x970 fs/buffer.c:2594
>  fat_write_begin+0x4f/0xe0 fs/fat/inode.c:229
>  cont_expand_zero fs/buffer.c:2522 [inline]
>  cont_write_begin+0x1ad/0x970 fs/buffer.c:2584
>  fat_write_begin+0x4f/0xe0 fs/fat/inode.c:229
>  generic_perform_write+0x184/0x490 mm/filemap.c:4175
>  __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4292
>  generic_file_write_iter+0x8d/0x2f0 mm/filemap.c:4318
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x52a/0x960 fs/read_write.c:686
>  ksys_pwrite64 fs/read_write.c:793 [inline]
>  __do_sys_pwrite64 fs/read_write.c:801 [inline]
>  __se_sys_pwrite64 fs/read_write.c:798 [inline]
>  __x64_sys_pwrite64+0xfd/0x150 fs/read_write.c:798
>  x64_sys_call+0xc4d/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:19
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888106c95200 of 512 bytes by task 7433 on cpu 0:
>  fat_mirror_bhs+0x1df/0x320 fs/fat/fatent.c:395
>  fat_ent_write+0xd0/0xe0 fs/fat/fatent.c:423
>  fat_free fs/fat/file.c:363 [inline]
>  fat_truncate_blocks+0x353/0x550 fs/fat/file.c:394
>  fat_write_failed fs/fat/inode.c:218 [inline]
>  fat_write_end+0xba/0x160 fs/fat/inode.c:246
>  generic_perform_write+0x312/0x490 mm/filemap.c:4196
>  __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4292
>  generic_file_write_iter+0x8d/0x2f0 mm/filemap.c:4318
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x52a/0x960 fs/read_write.c:686
>  ksys_write+0xda/0x1a0 fs/read_write.c:738
>  __do_sys_write fs/read_write.c:749 [inline]
>  __se_sys_write fs/read_write.c:746 [inline]
>  __x64_sys_write+0x40/0x50 fs/read_write.c:746
>  x64_sys_call+0x27fe/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Signed-off-by: YangWen <anmuxixixi@gmail.com>
> ---
>  fs/fat/fatent.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index a7061c2ad8e4..e25775642489 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -379,6 +379,7 @@ static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>  	struct buffer_head *c_bh;
>  	int err, n, copy;
> +	bool is_fat12 = is_fat12(sbi);
>  
>  	err = 0;
>  	for (copy = 1; copy < sbi->fats; copy++) {
> @@ -392,7 +393,17 @@ static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
>  			}
>  			/* Avoid race with userspace read via bdev */
>  			lock_buffer(c_bh);
> +			/*
> +			 * For FAT12, protect memcpy() of the source sector
> +			 * against concurrent 12-bit entry updates in
> +			 * fat12_ent_put(), otherwise we may copy a torn
> +			 * pair of bytes into the mirror FAT.
> +			 */
> +			if (is_fat12)
> +				spin_lock(&fat12_entry_lock);
>  			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
> +			if (is_fat12)
> +				spin_unlock(&fat12_entry_lock);
>  			set_buffer_uptodate(c_bh);
>  			unlock_buffer(c_bh);
>  			mark_buffer_dirty_inode(c_bh, sbi->fat_inode);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

