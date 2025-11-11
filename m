Return-Path: <linux-kernel+bounces-894719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6132BC4BAE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B3E3A6582
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9DA2D594D;
	Tue, 11 Nov 2025 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow31pOuO"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A5287263
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842583; cv=none; b=fkvECeikvnim9DdfsO7rkp4p56SZaFFGmqwVwVd7ljTDDTXjFe6zVEiNpA5d0bGBXqjCuPJOCoa7K9+QOp6uvIW15lXONM5//iftjyY4HyMHLiPjRNCRO6vbEnb5AXTrRLzcWlV65vPY9hemXMHgNeAn/tYkXIgbFwyL0QE8WQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842583; c=relaxed/simple;
	bh=98VHIJNXts5pkqDxpusii3VJgY4opzx6AuTlyTNUPio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MeraB0xMwGMii0QONCg9fsEHsv5rICVLPG94EjvfjqetRo5466O0DdhVjXsPw6Ew2ro8NB4kzkEHpJWEPSn5MgruspvjOnz9ywzklXXfiml5XQ5aIEnel00R+XyG0Dmqh32RzivNOPElpqwY8O39FT7BWTL/ldiCWt9762d4NaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow31pOuO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29555b384acso35925265ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762842581; x=1763447381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKqgvyJtGNbVzE7kGd6bpftMWsr85S+/cQsPs3EDLeQ=;
        b=Ow31pOuOKX52dQ6Ry3XfUWwmX8XmWsGZ2BMymuI2yNbjMorbZYL9kE30w/zsRCbdij
         wnzy3h0P5jw/ne5KvuiOVnfEMAlkINxIasjXaUKfigc4TFL5H98v//k4oNVXi+JDk0uJ
         G2Czq58S9kQUldAFC/Nn1zQ/kseoG5mga899AP5rTKzabCXl8VtDOXVa0IVpKTUP08r8
         2b2EJyZTH9rmQmd0FKgAdKCIJTxS/do6Yvod0PuARag4WlL3diOIjFK8OIiCjeMrbx9x
         1kz3ZIl3lXW+pGzIXw6WJY910mGBTLKD3ZkgF0M8ZOl6h/tHPxlJMfjj2jKZUO3C2tgK
         jIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762842581; x=1763447381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKqgvyJtGNbVzE7kGd6bpftMWsr85S+/cQsPs3EDLeQ=;
        b=frJy6NStSK1XxIht3yIGGNGSZHBfNJDlPOg3ckG+GmTCZ83Ow927MFGmLtSpDm3zij
         tacZBjRZsGlz40RojjVTjefZ6LfPX+e3Rr8hh492q+/5pemYEsuYX8A+YHHcu+Wqby96
         LfKBCdGT9CvUcZDRhC+2rGe/DvAIFZgok7hXE2+U8t4Hp9znq8FgZaLx3+86Y0G5Zo3B
         eULZuSp4cL7qRaoMHjmS7TipPLgzQYsCbdSQWtn6mIGwmayqrnxhW9hjbQYNBtJReOMs
         inncbvJAjeKqNZhdcrqTyXKezdxwxHTXu/I00sYeeJn111vwIr//eJNU2MASLykmVUGs
         0lvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmdxK4igLmSSN6Zlg8fc4IkX/RnB69hQuX5owLddNJIObu+uZBk0gQy08nHX2X4CIjqgo5LXQ//6CCjYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3h9zM9gKQiPl4WyZoWtZ0taOy68dX8sez3KKlJPNZKdO65eE5
	Yn7Zp2qhSiqznVrt8YLNj8WfSpsRhMBYS8yUttmfSjjU8xTmS3GkbaiG
X-Gm-Gg: ASbGnctyJL+4YTSad7+ghzP6WCqkSkgJHKf123fNaRqKkIkqKsW38uxc2VB0OsCnJVB
	TkMyzk/GwgI0qNs4guguYku/Y56gnwUdDFB3upN63JTbTwvyRgJjs/7vVT89sUOcvZYMalkr2Df
	5dlNYJ4Dm70Vb6RlfTx6gxEtAyn40QXqGh82INurbyYAcVQsn1tR1B+dgrAzManS5iEVC7V3d1H
	po4asdoPXTvK7EEFVvmlZhsFSxLoyhr76O7KBEt5lAwNfoiojp+atQWeIgGEvmlP6VK32j9IpcB
	Ibrud0Lc5bdsdR2+EUgdPkQ/qqoiWzIcp0fhcUoslh4xjgTTB2oHZxn9WOGeLqmSZBBCsztJiG2
	SIEyETDPiK711f97u9cpHxzGWVQkS0DlMfjRjILlFqCCmUK9gd58nb4u19uKpDOtWEkDPMyzSwe
	EZhp3FJVmoi2WI+qdB5C7gd4q4kpUUYUgL8d83atK6TnWk
X-Google-Smtp-Source: AGHT+IF40G3iSq8Wz5OHk5M+HgDuMFVNr7+LzM/sauYtkMXM6MYI+qYKqu0qHN2JK/1VfKDa/+xIQA==
X-Received: by 2002:a17:902:db05:b0:295:7806:1d64 with SMTP id d9443c01a7336-297e5666153mr136774245ad.25.1762842581251;
        Mon, 10 Nov 2025 22:29:41 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d83c941esm114165585ad.44.2025.11.10.22.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 22:29:41 -0800 (PST)
Message-ID: <635c7224-5bfe-40fd-9338-d9c600b7def4@gmail.com>
Date: Tue, 11 Nov 2025 14:29:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix has_curseg_enough_space to check
 all data segments for dentry blocks
To: Xiaole He <hexiaole1994@126.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251111060557.337514-1-hexiaole1994@126.com>
 <20251111061051.337547-1-hexiaole1994@126.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251111061051.337547-1-hexiaole1994@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
>          TP_PROTO(struct f2fs_sb_info *sbi, struct inode *inode,
>                  enum log_type type, block_t blkaddr),
> 
>          TP_ARGS(sbi, inode, type, blkaddr),
> 
>          TP_STRUCT__entry(
>                  __field(dev_t, dev)
>                  __field(ino_t, ino)
>                  __field(int, type)
>                  __field(block_t, blkaddr)
>                  __field(int, is_dir)
>          ),
> 
>          TP_fast_assign(
>                  __entry->dev = sbi->sb->s_dev;
>                  __entry->ino = inode ? inode->i_ino : 0;
>                  __entry->type = type;
>                  __entry->blkaddr = blkaddr;
>                  __entry->is_dir = inode ? S_ISDIR(inode->i_mode) : 0;
>          ),
> 
>          TP_printk("dev = (%d,%d), ino = %lu, %s, blkaddr = %u, is_dir = %d",
>                  show_dev(__entry->dev),
>                  (unsigned long)__entry->ino,
>                  show_data_type(__entry->type),
>                  __entry->blkaddr,
>                  __entry->is_dir)
> );
> 
> And add the tracepoint call in fs/f2fs/segment.c in
> f2fs_allocate_data_block() function. Find the location after
> locate_dirty_segment() calls and before IS_DATASEG() check:
> 
>          locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
>          locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
> 
>          trace_f2fs_allocate_data_block(sbi, folio ? folio->mapping->host : NULL,
>                                          type, *new_blkaddr);
> 
>          if (IS_DATASEG(curseg->seg_type))
> 
> 1. Mount F2FS with active_logs=6 and age extent cache disabled:
>     # mkfs.f2fs -f /dev/sdb1
>     # mount -t f2fs -o active_logs=6 /dev/sdb1 /mnt/f2fs-test
> 
> 2. Enable tracing and f2fs_allocate_data_block tracepoint:
>     # echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_allocate_data_block/enable
>     # echo 1 > /sys/kernel/debug/tracing/tracing_on
>     # echo > /sys/kernel/debug/tracing/trace
> 
> 3. Create a directory and write enough files to trigger dirty_pages >
>     min_hot_blocks (default 16), which will clear FI_HOT_DATA flag:
>     # mkdir /mnt/f2fs-test/testdir
>     # cd /mnt/f2fs-test/testdir
>     # seq 1 8192 | xargs touch
>     # sync
> 
> 4. Observe dentry block allocation:
>     # cat /sys/kernel/debug/tracing/trace
> 
>     The trace output shows dentry blocks (is_dir = 1) allocated to WARM
>     segment because FI_HOT_DATA is cleared when dirty_pages >
>     min_hot_blocks (default 16). However, has_curseg_enough_space() only
>     checked HOT_DATA segment space.
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
> ---
> Changes in v2 (per Yongpeng's feedback):
> - Merged dentry block check into the main loop to avoid duplication
> - Check data_blocks + dent_blocks for data segments (both can write to same segment)
> ---
>   fs/f2fs/segment.h | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 1ce2c8abaf48..acda720a54eb 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -626,21 +626,21 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>   
>   		left_blocks = get_left_section_blocks(sbi, i, segno);
>   
> -		blocks = i <= CURSEG_COLD_DATA ? data_blocks : node_blocks;
> +		if (i <= CURSEG_COLD_DATA) {
> +			blocks = data_blocks;
> +			/*
> +			 * With active_logs == 6, dentry blocks can be allocated to
> +			 * any data segment. With active_logs != 6, dentry blocks
> +			 * are always allocated to HOT_DATA segment.
> +			 */
> +			if ((F2FS_OPTION(sbi).active_logs == 6) || (i == CURSEG_HOT_DATA))
> +				blocks += dent_blocks;
> +		} else {
> +			blocks = node_blocks;
> +		}
>   		if (blocks > left_blocks)
>   			return false;
>   	}
> -
> -	/* check current data section for dentry blocks. */
> -	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
> -
> -	if (unlikely(segno == NULL_SEGNO))
> -		return false;
> -
> -	left_blocks = get_left_section_blocks(sbi, CURSEG_HOT_DATA, segno);
> -
> -	if (dent_blocks > left_blocks)
> -		return false;
>   	return true;
>   }
>   

Looks good to me,
Reviewed-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Thanks
Yongpeng,

