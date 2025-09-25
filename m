Return-Path: <linux-kernel+bounces-833433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C3CBA1F41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCEF622C68
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83032ED166;
	Thu, 25 Sep 2025 23:18:49 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00832E9756
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842329; cv=none; b=ujPmPqwrRISv5HBhhQ3f2qzJaTD9MVCDNyC/Lz3O+pbZWpwIEzu4LScdhlaNaIRhbMea4+c+jb+tQxexuXBg/sSrjWh0UxH/fwwm6BfxKh6rYhRXNtciwrvghLpG6toHPkEk5uceZ1VavK33qKlQPZmHp6/w9E8Or8hs6/Av+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842329; c=relaxed/simple;
	bh=Ryy9928iNEV97p4PmFANjIWla96VjHkzRAIUSJPHxEI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=qBMLLwImX7olNKMgXxiuyTIaf3e4UuYmy3X1ecHZgWkvBVO6RHPDYbSPsHAGM9iKk5Q2kCLDVfOztPf989HgUhF1WRiKA7CXP0JN162/p3zLeV7CO4z+Wp59+e+ZIg+7/JDC3MfN4cpzO4SGqUmEIzCi9Jnx4bLVAUKj+Df5Gc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-90e469a7f6bso42377039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842327; x=1759447127;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV+tWu0Fty1HLX+ktjEiNVni+9RprrNPYSrnxypX1Ro=;
        b=dhc6NkzIRBto1r+KHWM+qnwWhYij4m5IkDUrCrXIrYAO84vp5cqa3WVp8/KRtbrviU
         XQ7uJoQkCqLvMzev/IVXStbmbtE9hEmm5CxflU9nDd61O9QxNjLhgHkKO3AANG2LgyQ9
         Iersp0842vMepWQXptkT5OlIJ5+AEGbwpgaKNQj7fqcnbxsgE5Clt0G6k0A78ynut8tV
         x5zuVStFdxPlPptwQwwuFOLb+DuFreo4sd0Sta/uBYMC54NKYLucKXnQ22f9aFCFwzMv
         dlnqNmnEimHFzxFCoM8IBVxkLyuM8sK/nzEN7Gwm17QCFJFe9VwQxXS5W5ImblyWQZwA
         4vXA==
X-Forwarded-Encrypted: i=1; AJvYcCW4aG/VVp6dVcGRL7ygcjcWj0ZlvDCso/suaIUhynnyXx1ahWnonHTFQSZOwnmc93bGWODEoFSkSoDX5+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1n3MAw6p8vY2T5/z4s+T7PHmqmjA+kyS5wjLo/nrmUqh7JV6
	+CyPVQGpsDoJP73HhioBbaWVi/uVrzDpNL3Ip9cQ89qGNv+QPlXhOMbV9LrJuOQN8NvEhOdo2F/
	kwIl/p79noG+V+zjE2MZUSpwMd8a5d7MViHmZWfOmNaZjV6XB7jZjf1IvO7w=
X-Google-Smtp-Source: AGHT+IFfp2YetimcAwr8Qq7J7TPtSUAZx3D+n452t4W5O+n39A9rh3+OvrVymFzX/9CR9DEklbX88RVjOQhal9XSkIG6mSkdAbI4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378b:b0:425:9500:ec46 with SMTP id
 e9e14a558f8ab-425955fb24emr78410785ab.14.1758842326910; Thu, 25 Sep 2025
 16:18:46 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:18:46 -0700
In-Reply-To: <20250925231839.5142-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d5cdd6.a00a0220.303701.001e.GAE@google.com>
Subject: Re: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: kartikey406@gmail.com
Cc: kartikey406@gmail.com, yzbot@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test: git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git ma=
ster

"git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git" does not look=
 like a valid git repo address.

>
> hugetlb_vmdelete_list() uses trylock to acquire VMA locks during truncate
> operations. As per the original design in commit 40549ba8f8e0 ("hugetlb:
> use new vma_lock for pmd sharing synchronization"), if the trylock fails
> or the VMA has no lock, it should skip that VMA. Any remaining mapped
> pages are handled by remove_inode_hugepages() which is called after
> hugetlb_vmdelete_list() and uses proper lock ordering to guarantee
> unmapping success.
>
> Currently, when hugetlb_vma_trylock_write() returns success (1) for VMAs
> without shareable locks, the code proceeds to call unmap_hugepage_range()=
.
> This causes assertion failures in huge_pmd_unshare() =E2=86=92 hugetlb_vm=
a_assert_locked()
> because no lock is actually held:
>
>   WARNING: CPU: 1 PID: 6594 Comm: syz.0.28 Not tainted
>   Call Trace:
>    hugetlb_vma_assert_locked+0x1dd/0x250
>    huge_pmd_unshare+0x2c8/0x540
>    __unmap_hugepage_range+0x6e3/0x1aa0
>    unmap_hugepage_range+0x32e/0x410
>    hugetlb_vmdelete_list+0x189/0x1f0
>
> Fix by checking for shareable lock before attempting trylock, avoiding
> both the assertion failure and potential lock leaks from skipping VMAs
> after locks are acquired.
>
> Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3Df26d7c75c26ec19790e7
> Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchroni=
zation")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>
> ---
> Changes in v2:
> - Check for shareable lock before trylock to avoid lock leaks (Andrew Mor=
ton)
> - Add comment explaining why non-shareable VMAs are skipped (Andrew Morto=
n)
> ---
>  fs/hugetlbfs/inode.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 9e0625167517..44943e97adb0 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -484,6 +484,13 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, p=
goff_t start, pgoff_t end,
>  	vma_interval_tree_foreach(vma, root, start, end ? end - 1 : ULONG_MAX) =
{
>  		unsigned long v_start;
>  		unsigned long v_end;
> +		/*
> +		 * Skip VMAs without shareable locks. Per the design in commit
> +		 * 40549ba8f8e0, these will be handled by remove_inode_hugepages()
> +		 * called after this function with proper locking.
> +		 */
> +		if (!__vma_shareable_lock(vma))
> +			continue;
> =20
>  		if (!hugetlb_vma_trylock_write(vma))
>  			continue;
> --=20
> 2.43.0
>

