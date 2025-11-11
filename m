Return-Path: <linux-kernel+bounces-894786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDDC4C0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6524134F1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DBA2DA760;
	Tue, 11 Nov 2025 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+HVM2aC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194E22069A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845474; cv=none; b=Doix9+Z4dMYWqvTqQf1agfco9bmVUEWMG1G4yWMWyj2huxiYTagfGX+zTZ4lv3dFZDJSDELHjLh1RLYiCs9kncjKVDw+WuUMr11kZUPwFicDWrZ5wjEbJAd9peia0RuiggknFSHOOsv6re5vjIycaevT8TL630K9fSDte293qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845474; c=relaxed/simple;
	bh=FybQ4/3AZJou/+49uOTNiyNNNev/lS1TDMWjNHq9vDA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Og1MPdYcTf0sr6LcFDXihOFWOAjK3CEq5lJfZP4gaVW8aP265Y8qW04Yp2G3+RHLt5QboEnLjk2KmFD9rSVybPwc4Naxmd+UB0TCaLHZ886g/wJt0CP9q/7QbXIfxLLzflF36YwaRzYPMKIzrGLfidTXlRDZ/TJ+lbp9t/s1Y/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+HVM2aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C9EC19422;
	Tue, 11 Nov 2025 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845473;
	bh=FybQ4/3AZJou/+49uOTNiyNNNev/lS1TDMWjNHq9vDA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=G+HVM2aCVSzuL0pvTj1iE2VNLH1L5Sfn60E2OZgCrVG908jaGBXCmnno+B4X2RUvc
	 GvOro0DZqdcZwhle4q/IzEKZEX5B+JaJ4/fZT3hBADQaJIMVKhB7JunsyIVwl07NY1
	 KRtRBIY+x9uELcsM7BuMX+kLISzcGeAwGjuCvAd+uYSiNacb6z+thwH5oOzd/lQZ2s
	 ZCNP+PdfCsanPSapUfnNwMXSxa8VquCJNBJfyFDlTJtoCH894ESji3d2hPAtEs5uN1
	 DtME2edrPC/MePZXv9+CNQvR0F8yyD4TsVDLBcazxNa6EdEzYJ7bjHfoBbBqT15Y9E
	 M0Psty4mzqntQ==
Message-ID: <2eb3b1e7-931a-4a2c-92ac-4267a6a654ad@kernel.org>
Date: Tue, 11 Nov 2025 15:17:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Subject: Re: [PATCH v2] f2fs: fix has_curseg_enough_space to check all data
 segments for dentry blocks
To: Xiaole He <hexiaole1994@126.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20251111060557.337514-1-hexiaole1994@126.com>
 <20251111061051.337547-1-hexiaole1994@126.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251111061051.337547-1-hexiaole1994@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 14:10, Xiaole He wrote:
> When active_logs == 6, dentry blocks can be allocated to HOT, WARM, or
> COLD segments based on various conditions in __get_segment_type_6():
> - age extent cache (if enabled)
> - FI_HOT_DATA flag (set when dirty_pages <= min_hot_blocks)
> - rw_hint (defaults to WARM via f2fs_rw_hint_to_seg_type)
> - file_is_hot(), FI_NEED_IPU, f2fs_is_cow_file(), etc.
> 
> However, has_curseg_enough_space() only checked CURSEG_HOT_DATA segment
> for dentry blocks, which could lead to incorrect space calculation when
> dentry blocks are actually allocated to WARM or COLD segments.
> 
> Reproducer:
> Note: This reproducer requires adding a tracepoint to observe segment
> type. Add the following tracepoint to include/trace/events/f2fs.h:
> 
> TRACE_EVENT(f2fs_allocate_data_block,
>         TP_PROTO(struct f2fs_sb_info *sbi, struct inode *inode,
>                 enum log_type type, block_t blkaddr),
> 
>         TP_ARGS(sbi, inode, type, blkaddr),
> 
>         TP_STRUCT__entry(
>                 __field(dev_t, dev)
>                 __field(ino_t, ino)
>                 __field(int, type)
>                 __field(block_t, blkaddr)
>                 __field(int, is_dir)
>         ),
> 
>         TP_fast_assign(
>                 __entry->dev = sbi->sb->s_dev;
>                 __entry->ino = inode ? inode->i_ino : 0;
>                 __entry->type = type;
>                 __entry->blkaddr = blkaddr;
>                 __entry->is_dir = inode ? S_ISDIR(inode->i_mode) : 0;
>         ),
> 
>         TP_printk("dev = (%d,%d), ino = %lu, %s, blkaddr = %u, is_dir = %d",
>                 show_dev(__entry->dev),
>                 (unsigned long)__entry->ino,
>                 show_data_type(__entry->type),
>                 __entry->blkaddr,
>                 __entry->is_dir)
> );
> 
> And add the tracepoint call in fs/f2fs/segment.c in
> f2fs_allocate_data_block() function. Find the location after
> locate_dirty_segment() calls and before IS_DATASEG() check:
> 
>         locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
>         locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
> 
>         trace_f2fs_allocate_data_block(sbi, folio ? folio->mapping->host : NULL,
>                                         type, *new_blkaddr);
> 
>         if (IS_DATASEG(curseg->seg_type))
> 
> 1. Mount F2FS with active_logs=6 and age extent cache disabled:
>    # mkfs.f2fs -f /dev/sdb1
>    # mount -t f2fs -o active_logs=6 /dev/sdb1 /mnt/f2fs-test
> 
> 2. Enable tracing and f2fs_allocate_data_block tracepoint:
>    # echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_allocate_data_block/enable
>    # echo 1 > /sys/kernel/debug/tracing/tracing_on
>    # echo > /sys/kernel/debug/tracing/trace
> 
> 3. Create a directory and write enough files to trigger dirty_pages >
>    min_hot_blocks (default 16), which will clear FI_HOT_DATA flag:
>    # mkdir /mnt/f2fs-test/testdir
>    # cd /mnt/f2fs-test/testdir
>    # seq 1 8192 | xargs touch
>    # sync
> 
> 4. Observe dentry block allocation:
>    # cat /sys/kernel/debug/tracing/trace
> 
>    The trace output shows dentry blocks (is_dir = 1) allocated to WARM
>    segment because FI_HOT_DATA is cleared when dirty_pages >
>    min_hot_blocks (default 16). However, has_curseg_enough_space() only
>    checked HOT_DATA segment space.
> 
> Fix by merging the dentry block check into the main data/node block
> check loop and checking data_blocks + dent_blocks for data segments,
> since both regular data blocks and dentry blocks can be written to the
> same segment. When active_logs == 6, dentry blocks can be allocated to
> any of the three data segments (HOT, WARM, COLD), so all three segments
> need to account for dentry blocks. When active_logs != 6, dentry blocks
> are always allocated to HOT_DATA segment only, so only HOT_DATA segment
> needs to account for dentry blocks, while WARM and COLD segments only
> check data_blocks.
> 
> Fixes: ef095d19e82f ("f2fs: write small sized IO to hot log")
> Cc: stable@kernel.org
> Signed-off-by: Xiaole He <hexiaole1994@126.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

