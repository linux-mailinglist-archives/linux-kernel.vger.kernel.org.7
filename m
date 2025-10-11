Return-Path: <linux-kernel+bounces-848999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD335BCEFD2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A99189CD09
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 04:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D431DF980;
	Sat, 11 Oct 2025 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bkbc6XV7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF355CA5A
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760158222; cv=none; b=NakURQYi3wWU/kwEohNT5m0kWkogWkl580KbQX8C4aoPQ+gf++/jsOQnGMgnwAMvcHrAtviGOHVNECCuoV53S6IEMfevZvLWcTJnpjXEMX9Yv4vZSNq8LiG9MCAVUfsBsvIpOyqBLcrYW0aT9wjHb76+wlnyt8IWataIHCH2osk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760158222; c=relaxed/simple;
	bh=7iZCkk6Utuot4Emf4RdZwIk0Xs7t/Yn2MMHIxN2VZXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtjNJgsGiIKfxU0Tf5+aPuWIiOTY7yNTxojD6YDiZHZiFHdtcapD66yLDeCVRhqbZw1wdn7fyjNut3ynr853PYTBFazVgE4qni1IGoxeYjurFqmkc2E/FVyr+QJjZ51zD70a5ATzbAlWilfoD135u8KsG0jzrpx5HgLnN92G9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bkbc6XV7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e32139ef7so4387055e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760158218; x=1760763018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJaHHzb98whMDANy7SthGXRNhzvrWK14yO7S2VCvICQ=;
        b=bkbc6XV7SrDv2yormG+cr+AY1xthwiLzVOpkMJnI9GOdYnX9S5FW6Usx9HrfnAWAYx
         go2kCGysqZSPIQOqSJq+Gug2y4ytnMsWJ8dSaVNHBjgOViohf3Bx+DMGtWc/rZRjkqWM
         XnRdfxEi9/ONaiB1llc+f3weB7bSGzipPMvoeIug7+ECtt0AITTDaLbrsfQ1LatI77bc
         zKcdrS0HBY2fyFZbnpg/uKaDLwmBNxeRyLPrfkkmn3AOr9mK93H7axCbUYaRCv6ZXq9Y
         KYUFTcEvR5GeFugADz5Hahuf7P5wBC7hOgEiy+Qutm6cNOUdrdnZzRWE9ExlQ22rNPz7
         E1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760158218; x=1760763018;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJaHHzb98whMDANy7SthGXRNhzvrWK14yO7S2VCvICQ=;
        b=QsX3lM/ZE3YUeIUj8NsIQAmSDiOo0gIrhU7ZEg9mNpg9Y0MYH3BrT4Ids++PRz9lyz
         QzSxn3HcaD6OgkTz30MoU+/wSJ3F+IwlErhFmaWSf7wTUITHZL4t53J7UJO3IiLKDvgw
         /MdgaucQptSq/j1HJAPcVYHeM+k3JQ0jVoYqPQmRJrCoVFqoiDGOW+6sZnqx9Qqs8rsk
         9s9MGH7EJh3SLTNx9oFZBXbyj90Dej4mwF2Xtvnv2aGkDa9UaNCMixQCBXTJW2/XZKo3
         d8QeQCFMlh8V5IfoTHsVg7lTxmaCUpN9CydEKclIBXvcRfqEyHpXNCLhKA9Vl5zqOTXZ
         0FYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqIyXADs6RktkHsRyWnBEa2gjaxPXHeL4QIINF0vZZ8We1MSG2pdfoaKlgCrAFM8ys9n4Lk6oNLxjx1fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoO++Ub+ENxV/1uz920MMqA8FAlmE5SMkSqJMeC7FdPdoCF5Lq
	lCzQMysWdFNJPSeC8E9VkciLBWIeAb0pSoGhJa4RC7VQx6hLsq5+MChxgqTT/38Mmjo=
X-Gm-Gg: ASbGncsoRO/FY3iPdFuJu1vk8vnl85VSKQLAeGtAUo8NHI17fZ0aULoj8TILJyyANff
	1Hg86xx7a/NYCnPhVysD94baZtrh2ZQZn9DJikZ0rlK+mPJqqK0RbZ7qDl219egp+vzYB1ao5pB
	CjSCY2B5I6ucVJYgmXMD4K6v7rNooX9whKqc1BpBs0DbCxrZVEYRno211vYIglNJtjrbF1CbwyM
	4Y7FwCO2OzEX/8gJI5Eo5ZrTrWiQxO4lOhALK385Q3S1GthtAc96pVAAbWqhRM0BO+qK3WQKZtI
	RHSHPAytYnMM6VASI2GTmNt3WY1XvAerLLlNZ05ZNRDa/B7rPqL80EM/axL/1Vbp5EjGuRB2yqw
	Z/cEueHNLzWy1TRqP8zTg/HzPZecVqO2Z7QAAAkosYl/N17rr
X-Google-Smtp-Source: AGHT+IFCY7Bg3bp4HCamL6JdB/O3QwZvJNhtQGCXiG4FoXzDe+0ZqNgI+aBZeDl466KKigUX3DuZFg==
X-Received: by 2002:a05:600c:c162:b0:46e:6778:c631 with SMTP id 5b1f17b1804b1-46fa9a214c4mr51840405e9.0.1760158218154;
        Fri, 10 Oct 2025 21:50:18 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61aac5besm4970688a91.14.2025.10.10.21.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 21:50:17 -0700 (PDT)
Message-ID: <6541511c-8865-4903-b26c-2e2abf78ad99@suse.com>
Date: Sat, 11 Oct 2025 12:50:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix stale extent map cache during COW operations
To: Deepanshu Kartikey <kartikey406@gmail.com>, joseph.qi@linux.alibaba.com,
 mark@fasheh.com, jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
References: <20251009142917.517229-1-kartikey406@gmail.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20251009142917.517229-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Deepanshu and Joseph,

On 10/9/25 22:29, Deepanshu Kartikey wrote:
> 
> Hi Joseph,
> 
> Thank you for the review. You are absolutely right - the cache clearing at the end of ocfs2_refcount_cow_hunk() should handle the COW path correctly.
> 
> After further investigation with the syzbot reproducer and extensive debugging, I found the real issue is in the FITRIM/move_extents code path. The bug occurs when:
> 
> 1. copy_file_range() creates a reflinked extent with flags=0x2 (OCFS2_EXT_REFCOUNTED)
> 2. ioctl(FITRIM) is called, which triggers ocfs2_move_extents()
> 3. In __ocfs2_move_extents_range(), the while loop:
>     - Calls ocfs2_get_clusters() which reads extent with flags=0x2 and caches it
>     - Then calls ocfs2_move_extent() or ocfs2_defrag_extent()
>     - Both eventually call __ocfs2_move_extent() which contains:
>         replace_rec.e_flags = ext_flags & ~OCFS2_EXT_REFCOUNTED;
>     - This clears the refcount flag and writes to disk with flags=0x0
> 4. However, the extent map cache is NOT cleared after the move operation
> 5. Cache still contains stale flags=0x2 while disk has flags=0x0
> 6. Later, when write() triggers COW, ocfs2_refcount_cal_cow_clusters() reads:
>     - From cache: flags=0x2 (stale)
>     - From disk extent tree: flags=0x0 (correct)
> 7. The mismatch triggers: BUG_ON(!(rec->e_flags & OCFS2_EXT_REFCOUNTED))
> 
> The proper fix should be in __ocfs2_move_extents_range() to clear the extent cache after each move/defrag operation completes. I will send a v2 patch with this fix.
> 
> Thanks,
> Deepanshu
> 

let's look at the syzbot page [1].
the following analysis is based on the c code from "2025/10/03 12:11" [2].
(btw, syzbot never calls __ocfs2_move_extents_range().)

The test code mainly involves 9 steps:
1. create img data and mount
2. one time open() the file (0x200000000080ul), return fd: r[0]
3. two times open the file (0x200000000280ul), return fds: r[1] r[2]
4. call ioctl F_SETFL 0 on r[1]
5. write r[2] with "0x0000000000000000" len:0xfea0ul //clean data job
6. call r[3] = dup(r[1])
7. do copy_file_range(), copy from r[1] to r[3] len=0xd8c2ul
                 //creates OCFS2_EXT_REFCOUNTED and create extent cache.
                 //check ocfs2_remap_file_range() => ocfs2_reflink_remap_extent()
8. trim r[0]
9. write on r[1] //crash.

the root cause is that, in step <9>, it calls ocfs2_refcount_cow():
- the input parameter di_bh is created by the caller via
   ocfs2_prepare_inode_for_write() => ocfs2_inode_lock_for_extent_tree() =>
   ocfs2_inode_lock_update(), which reads file data from disk.
   The extent is without OCFS2_EXT_REFCOUNTED flag because r[1] & r[2] point
   to the same file, and step <5> cleanup the file data.
- ocfs2_refcount_cow() then calls ocfs2_get_clusters to retrieve the extent
   from cache, which does contain OCFS2_EXT_REFCOUNTED (cooked by step <7>).
- this difference leads to it calling ocfs2_refcount_cow_hunk(), which
   triggers a BUG_ON().
   I suspect step <7> needs some time to write back the COW data, and syzbot
   starts step <9> too quickly before the write-back job start.

how to fix:
the v1 patch is reasonable, but the commit log needs to be revised.

for Joseph's question: (I copied here)
> At the end of ocfs2_refcount_cow_hunk(), it has:
> 
> 	/*
> 	 * truncate the extent map here since no matter whether we meet with
> 	 * any error during the action, we shouldn't trust cached extent map
> 	 * any more.
> 	 */
> 	ocfs2_extent_map_trunc(inode, cow_start);
> 
> It seems the cached extent record has already been forgotten. So how
> does the above step 3 happen?

my answer:
the crash only happens on the first call to ocfs2_refcount_cow_hunk().
ocfs2_extent_map_trunc() does the cleanup later, but the malicious
extent block is cooked before ocfs2_refcount_cow_hunk() is called.

[1] https://syzkaller.appspot.com/bug?extid=6fdd8fa3380730a4b22c
[2] https://syzkaller.appspot.com/text?tag=ReproC&x=163c9214580000

- Heming

