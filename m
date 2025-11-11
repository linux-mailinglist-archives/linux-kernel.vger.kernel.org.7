Return-Path: <linux-kernel+bounces-894526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0710C4B3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 443C434CA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60B3491D0;
	Tue, 11 Nov 2025 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPSX672c"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910E330328
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829102; cv=none; b=be+ipuxtfMj6bxFLzzWcB+DOTDm0dM6lCIuBgkzXZErka1tAeR4GsrGHIRgAy34RLeTgBY4bWtWoBq9aLbTAHaM6f0sDIAkD8BS3exFSa6sAes2lCgvVm4AsnPv6VT/lEQPGYfHZ1UkQEYOJ2kCwlYxBIUKn4uSp/K9UX5U2cDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829102; c=relaxed/simple;
	bh=IVTpkG8sPN8RwEZqKEb4ADfMjzyhzQIRRjkCWARdjUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTIJ7qS3BzAiM4cEzUdIDpaUwBAkqDR46g5moiMiyiAjjzPjhQm1sbJSa5PTNEQOV6atStxpbCUvja37N26HVOh/61CNDDN92WRIrhOM8fG+8VocQ/8FP/ZirucN83G4qnEXMZQnRNeppmaQBEgN6qRGlhMOKO7i5NJBjqJG5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPSX672c; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo2972812b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762829100; x=1763433900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADXi46rhPtl2zKrXkKYDt/vvJ4wJ2S3QdPh5Lh3JrjI=;
        b=nPSX672ciru70LBn8RtWUo283XCRigoGnlt3pfMVGQekJ6vKWvQUuWGRj0MzEUEyWW
         Omu0epkNymUWFgF8XFer/MD/eZBJCK/IQb/R0gfyR8vNBOHbVx+rP6XXqyU1nXyKCwZY
         3v0HzI8CVMPgpsLxP06xJjsmr5wRKGCjiAI7tqhbkWtTfqKasdev6L1BQcsfq327hJcT
         2oHyTbrt2GiM2ZwaThzDMMPZDaF8gnXY8t7zecRiTEgkVnicOFfJJvF4kEDGHUfz7AR+
         J2bejrFpxZA1f2cTDcDKwj/LSoBzGML46ZtQBccqVDGx+fBTMRHgvUEq3Tg2ef9Iqky7
         GrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762829100; x=1763433900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADXi46rhPtl2zKrXkKYDt/vvJ4wJ2S3QdPh5Lh3JrjI=;
        b=bYNubzAb7qMscluZfH5OCbbozvy1GuZdHVvUZapNrr5E8Aq4cvxZ4uYctJmJxLnvI0
         SbpOG1YmFOLe9ooOle4KUryQ84aaMHKxt19mUnbikGChCwgT09pMRXxBtn110HRcSXTf
         UOHuR721JG5j9KBrrqCE3M+WqcecRjt1nBqybWD6l6RtTWK0hnV5l7sQswE1URoo5GgD
         a/JxYq0iY/w+8VTKAhvvlX0OxyETuwMXlOGDCwuRcs1DDnvAtOVfrh4Rksjczh+if+Wq
         nUQTwdbxPmJBc7LmHp6qnrD1nHIyme5kF3yYF+L41wGHr29Yr8wyfG9cf7iKSTn8EUq+
         dYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1jQFVxQdd7BbvlWv//XhlYYmjuu7DbjUuCJyK8B67Pe3BIuga5aUNhOIlgtqGaXG3IkUwSZCYdwYu9h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTF72pBDmpxZTUR52QRaH4obEci6e1YS7OHrgnFfaxG9Ce6+3H
	f6fn/YG6pinpb81hwD79Bebi3cqBeybanRwNV31lA2hxE0mqV0jvVb0I
X-Gm-Gg: ASbGnct7EJLfQckpgVBZqLi2tK6xEjDXWr0OwyW5UZj9gWjeektESmZ8nKXcXkZk+gX
	1QIRnjPhiGO2M+OBYjuUjAtf2aFc2koRGbbLeWFpWNUy70MeLKcUSr/eWMODivojazq6qt3zfmC
	mOhknf5+zMtKL/VDWP5zUWDQcGkfWjeoNZQOu+7bCqoIDkUctilE/sEb6Ya3IVqXCffqHKIKT4n
	XZC9P8JjbPfF2snG09fFFYq2ofwAJabvsf0jw4qv9Afn80BwEIiq78XF05xBfq6x3vaf2OIrUJv
	jNuVHJckGv7MED6nUq5UIk3CRB4dltJrtUFgOX8hTCWAEbL7KmLW1dRXYEHIWmERmWZXog0i5yM
	/cjdpZETGLTK1UcXCWv4SVTuCGdBr4/7KBtI0mBIAunZaDp7CpKI+DRVCenjv2vy0p/20BMfNRQ
	TfFFoiOyF4AGDGh4/W/eNfxmc=
X-Google-Smtp-Source: AGHT+IGn7q43rttlZ3nAPDGApmA7SUPOnoa1PNLBTcXnAm83frafkwx+aYxNLBM9B43r52WGh0kVhw==
X-Received: by 2002:a17:902:744c:b0:296:3f23:b909 with SMTP id d9443c01a7336-297e56c9e07mr105964695ad.39.1762829099546;
        Mon, 10 Nov 2025 18:44:59 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bb57baf9905sm4764105a12.17.2025.11.10.18.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 18:44:59 -0800 (PST)
Message-ID: <3a787685-1765-4068-a8da-d595dd257b71@gmail.com>
Date: Tue, 11 Nov 2025 10:44:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix has_curseg_enough_space to check
 all data segments for dentry blocks
To: Xiaole He <hexiaole1994@126.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251110132654.6485-1-hexiaole1994@126.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251110132654.6485-1-hexiaole1994@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 21:26, Xiaole He wrote:
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
> 	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
> 	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
> 
> 	trace_f2fs_allocate_data_block(sbi, folio ? folio->mapping->host : NULL,
> 					type, *new_blkaddr);
> 
> 	if (IS_DATASEG(curseg->seg_type))
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
> Fix by checking all three data segments (HOT, WARM, COLD) when
> active_logs == 6, similar to how __get_segment_type_6() can return
> any of these segment types for dentry blocks.
> 
> Fixes: ef095d19e82f ("f2fs: write small sized IO to hot log")
> Cc: stable@kernel.org
> Signed-off-by: Xiaole He <hexiaole1994@126.com>
> ---
>   fs/f2fs/segment.h | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 1ce2c8abaf48..c13400a53013 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -632,15 +632,34 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>   	}
>   
>   	/* check current data section for dentry blocks. */
> -	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
> +	if (F2FS_OPTION(sbi).active_logs == 6) {
> +		/*
> +		 * With active_logs == 6, dentry blocks can be allocated to
> +		 * HOT, WARM, or COLD segments based on age extent cache,
> +		 * FI_HOT_DATA flag, rw_hint, etc. Check all three.
> +		 */
> +		for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
> +			segno = CURSEG_I(sbi, i)->segno;
> +
> +			if (unlikely(segno == NULL_SEGNO))
> +				return false;
> +
> +			left_blocks = get_left_section_blocks(sbi, i, segno);
> +
> +			if (dent_blocks > left_blocks)
> +				return false;
> +		}

How about merging this for-loop with the one above to avoid duplicated
code? Since both dent_blocks and data_blocks may write to data segments,
should we also check whether data_blocks + dent_blocks > left_blocks?

Yongpeng,


> +	} else {
> +		segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
>   
> -	if (unlikely(segno == NULL_SEGNO))
> -		return false;
> +		if (unlikely(segno == NULL_SEGNO))
> +			return false;
>   
> -	left_blocks = get_left_section_blocks(sbi, CURSEG_HOT_DATA, segno);
> +		left_blocks = get_left_section_blocks(sbi, CURSEG_HOT_DATA, segno);
>   
> -	if (dent_blocks > left_blocks)
> -		return false;
> +		if (dent_blocks > left_blocks)
> +			return false;
> +	}
>   	return true;
>   }
>   


