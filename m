Return-Path: <linux-kernel+bounces-831794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C4B9D909
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A301BC26A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5C2D8798;
	Thu, 25 Sep 2025 06:18:56 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC73219E8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781135; cv=none; b=VlBwo082o4WoVnJeA1eo4D3ckFNK2ca/89jA4UJu8i/6zfpOG+tGYEbEclMmAtcizoAKSYFiC1sJVJUW0HWSuPM2BK2riLEYjI5cDyyVewHiJZ71geg2kyUTtiV+72EXc5taM+21tRAB+X17xZ1ihor0Ri7GReJSPi6EFU4Wr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781135; c=relaxed/simple;
	bh=PUPbjxQv8kMU69FrsEVh72mG8Sp8zwJ1brLH46mnIjE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=V1KWKfrVeveurW4khBhxq4gLjuxTjkQlIz/Vr/YxishgIcBtDlfoCQIeeTZK56g+WcvJi2xKLG1TNMh83+uMeUererTsRIomggvUFV9ovImjOE6FZdVT8IIVctfJKi2GVmWprMBJ1SLunL2eIeI3rXT8BYwYZPHl3+0r2MwI2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-424c8578d40so7046925ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781133; x=1759385933;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AORdxVdEw+FMUTpSZ+Op5PNnQoAu5H48nvLWrpjQM2k=;
        b=CabYfMgQvbOJTnfB289c6+zSYSsQuk+bn/SkUP4eP32uFsAelFNxg1/Q4gvWjonk0l
         QVWTaHmbqqBERt4Q/fNH+rtsvhj2yjwWfedI381sYyG81QNDD8FUyeE/xiChAk8rP7Ml
         QyaMERGTF1zQpulbx+eVQyRZpO9vHyuxYqYOk69fXgid0hHBbMHg4QomZgj4NrJDcQBD
         P/g9BnGemIA+zb8bRrHkNKeyI8yTAcuWdnlG2w8pdFhMxtZopBelP71DqosFr6iRxDEq
         qLP9lMzYIYOBIFrrt9RgDRdoLiTWj3ESTN9N8c7ZIYAP0IrBOQbxojY/Pj2J+0rgpBR2
         yr8A==
X-Forwarded-Encrypted: i=1; AJvYcCXWHWOY/qgC+USc89PMeDJzfSxKBBJVAtqf6bcreXQwGU4KaDQduIorK4ReDY5IqUumjiquDsiwKqvmOO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSMmvvwhbNa7yLz4pepizpLGCoaZxaIKto87y1qPA7rRRuNMgz
	PDh+kCn3B3kPO0mdFZSNxsXYVcwzZxsTxoR9FL2oWFpqTzlICfv04kSnmzfUJXsX2iZw9wgtz+/
	gMC2SNsiqh9QgjVAODVLk1yIlM3LRj+ZhuZECDPHPubCnYTxFgevF7kfdpwo=
X-Google-Smtp-Source: AGHT+IF1+xv/GxMsm20k5xsH4ilYNJY3FiSjgvBgJRQC68pXg5SAZFSedY0NmMBXrvI5dubZo8E+h+ZAa9PykvxQRRI0d/wBM89j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:2802:0:b0:3f2:b471:e617 with SMTP id
 e9e14a558f8ab-4259563e04fmr27826695ab.25.1758781133128; Wed, 24 Sep 2025
 23:18:53 -0700 (PDT)
Date: Wed, 24 Sep 2025 23:18:53 -0700
In-Reply-To: <20250925061845.1276501-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4decd.050a0220.25d7ab.0000.GAE@google.com>
Subject: Re: [PATCH] hugetlbfs: fix lock imbalance in hugetlb_vmdelete_list
From: syzbot <syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com>
To: kartikey406@gmail.com
Cc: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

"git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git" does not look like a valid git repo address.

>
> hugetlb_vmdelete_list() has a lock imbalance bug where lock acquisition
> and release evaluate VMA conditions at different times, potentially
> causing unlock to be called on the wrong lock or skipped entirely.
>
> The current code evaluates __vma_shareable_lock() and __vma_private_lock()
> twice - once during hugetlb_vma_trylock_write() and again during
> hugetlb_vma_unlock_write(). If VMA state changes between these calls
> (due to unmap operations or concurrent access), the lock and unlock
> paths may diverge, leading to:
>
> 1. Unlocking a lock that was never acquired
> 2. Unlocking the wrong lock type
> 3. Leaving a lock held
>
> This manifests as "bad unlock balance detected" warnings:
>
>   WARNING: bad unlock balance detected!
>   trying to release lock (&vma_lock->rw_sema) at:
>   hugetlb_vmdelete_list+0x179/0x1c0 fs/hugetlbfs/inode.c:501
>   but there are no more locks to release!
>
> Fix this by saving the lock type and pointer when acquiring the lock,
> then using the saved information for unlock, ensuring symmetric lock
> operations regardless of any VMA state changes.
>
> Reported-by: syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=62edf7e27b2e8f754525
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/hugetlbfs/inode.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 9e0625167517..2721ba2ee3f3 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -42,6 +42,10 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/hugetlbfs.h>
>  
> +#define HPAGE_RESV_OWNER    (1UL << 0)
> +#define HPAGE_RESV_UNMAPPED (1UL << 1)
> +#define HPAGE_RESV_MASK (HPAGE_RESV_OWNER | HPAGE_RESV_UNMAPPED)
> +
>  static const struct address_space_operations hugetlbfs_aops;
>  static const struct file_operations hugetlbfs_file_operations;
>  static const struct inode_operations hugetlbfs_dir_inode_operations;
> @@ -475,6 +479,9 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>  		      zap_flags_t zap_flags)
>  {
>  	struct vm_area_struct *vma;
> +	struct hugetlb_vma_lock *vma_lock;
> +	struct resv_map *resv_map;
> +	bool locked;
>  
>  	/*
>  	 * end == 0 indicates that the entire range after start should be
> @@ -484,8 +491,24 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>  	vma_interval_tree_foreach(vma, root, start, end ? end - 1 : ULONG_MAX) {
>  		unsigned long v_start;
>  		unsigned long v_end;
> -
> -		if (!hugetlb_vma_trylock_write(vma))
> +		vma_lock = NULL;
> +		resv_map = NULL;
> +		locked = false;
> +
> +		if (__vma_shareable_lock(vma)) {
> +			vma_lock = vma->vm_private_data;
> +			if (vma_lock && down_write_trylock(&vma_lock->rw_sema))
> +				locked = true;
> +		} else if (__vma_private_lock(vma)) {
> +			resv_map = (struct resv_map *)((unsigned long)vma->vm_private_data & ~HPAGE_RESV_MASK);
> +			if (resv_map && down_write_trylock(&resv_map->rw_sema))
> +				locked = true;
> +		} else {
> +			/* No lock needed for this VMA */
> +			locked = true;
> +		}
> +
> +		if (!locked)
>  			continue;
>  
>  		v_start = vma_offset_start(vma, start);
> @@ -498,7 +521,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>  		 * vmas.  Therefore, lock is not held when calling
>  		 * unmap_hugepage_range for private vmas.
>  		 */
> -		hugetlb_vma_unlock_write(vma);
> +		if (vma_lock)
> +			up_write(&vma_lock->rw_sema);
> +		else if (resv_map)
> +			up_write(&resv_map->rw_sema);
>  	}
>  }
>  
> -- 
> 2.43.0
>

