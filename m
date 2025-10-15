Return-Path: <linux-kernel+bounces-853992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 659BDBDD44F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75FCE500A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA123315D3B;
	Wed, 15 Oct 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WUCdvxf8"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DCE315D3F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515176; cv=none; b=VfRIJd72spNvQ5REwctIiAiegPAXFpbG+sc01/C255Llyf6fCZqUj663+5DMWwS5zWcgOdgFnTjducu45ZEJ1nhjy1uKXH2xmBeYMAo/UsC7MuX9/ZgQ8NZJbEEiKcV0Mo3jCfrAP3odaHBSGGKn2hgzoAwqkdXK5N2gaGs6rNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515176; c=relaxed/simple;
	bh=6fP/i69arfF8fWdZlapKSQh9LzzNgkXKJEVrnqonIwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGZFN7vtnnqxuQroCl3Ka3IBNSQG9kIZPhmAyRYztGVtj4R/LG0tAjwjmBG/mplU3UOzsDuZPcME9ui462pBgjiw+Ger/jcH8l1yySLnVVPK32CCD/Mkev0a4uFH5QSgLP9Y43QLRhJPzODAVrZ4DIh9CVnZ3A7qVdCRPYOl4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WUCdvxf8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4257aafab98so5200119f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760515171; x=1761119971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5B/YsZLvtz4Vz4k84b8+S3byFq2ZeMyQDiX72Vy5xUU=;
        b=WUCdvxf80hDv7juR1Vv7ODPrgA2p/XWsk3leUDKwNgjuntL8mobQv9NQ0Q6P5awEYg
         HDT5Dk9+RzUU8tCA7+qyUKpwmD/20+EzHNtwkuCXTm8pJ417SB3frkqbA8LmHyEw51uw
         aLJP9wodWDr29qy9aaC3FNZ++H4dIMjITFiVIw8WEbYEMXTvqvM7LM+RnISVXrlrSfCG
         ufWxf9icP3TCCxkSrW1GYTWi2t1cPOfDnB7Oe6v0dTmjZG8TqbMeZhniuXiH8+BWGuAr
         Mg+gufDlaz+mt/lw3xBN7eKAqOIGcWeTbIA2WU3IXA+lL6iHIY08V2JtB1rxbKAbicKf
         AFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515171; x=1761119971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B/YsZLvtz4Vz4k84b8+S3byFq2ZeMyQDiX72Vy5xUU=;
        b=aILdaKTBT6suCEpMlkWcU6DxlAYYPLwdK0/jB+wZclQe0Oz23TOPsTM/lJZWwbX7Ni
         lHaJj5CEhCFxRj0xl9JA+DHedALGNSm8ctKfb/5laQJaG2odHX5p+xcMtKqHAyFp53dl
         mlkGNH9QhUOvUuLGGrmdsYs1asjpPukJG9iTbGhTr64CtouKRZahCrzOU8dVpFgVjXBv
         RDTyIXJwiIVsqki5Up9JRmfrcNmdRBySG3ZQSzBQfJcaFy+xcfuRo0NzIJg3PQLbOyl2
         xZW5x56vU1k1GZzgIQuk+P4FDi4nHyfvwmEla2w8+J9xMgK7FsGBEqFgHA7kvWm7RZ9U
         jEwg==
X-Forwarded-Encrypted: i=1; AJvYcCXIQw7pF0S28qfYWxUvleuR8xQwguKhwag0BkKf+E/ZGCEL8PMXJZ84Qumt+nVtSDqZye41fFRf9C+pJSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+90mNmyg2+1clGPIb8MBbkIOIPVV8V/36TiAlzrFXigw650l
	it7/EPt095KppaYkUsWxFKwCRNOno/F7byd3GScZdp2H3mP+mYI6KksTs/+Qz4ncxFkms+tNsLp
	w7tsnsD8spcWmWXKgn/U5cqinf1wi0jXu7SRvOjzgbQ==
X-Gm-Gg: ASbGncvc0yM9AsqANWUqo5w4Rc2onInDLbThXqoG25P0YMn5aHx9I0jUNhXaZkpFiCx
	z7tRCStO7CEsx71x4KWcAhwgC6ngZmGFa+8/Tv1ESl9ESNSnHyAAR2Pfyr8hz0v7JHmltpRO7ys
	L229BrCnsqFqgYYh3VCPLId+/gtsIA6bcYSHRr7zM4cxt+tAi7kmIODCOQsK/1FYRXa1elX1+bb
	hwwc00EtZ9l41HrMEvujq+4
X-Google-Smtp-Source: AGHT+IHlYAnGPR4+sBXbnvDD5yiOrLQHUpd+9XPo6Ae95pZZ4ZJRoJI1F9e90h+u2SnMQCRpOX1T6dYbP4QCztVft+Y=
X-Received: by 2002:a05:6000:290d:b0:425:7168:44c3 with SMTP id
 ffacd0b85a97d-42666ab9684mr18960125f8f.5.1760515171153; Wed, 15 Oct 2025
 00:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
In-Reply-To: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 15 Oct 2025 09:59:20 +0200
X-Gm-Features: AS18NWB-SEts5Wua3RsrCioj0InLqkwJBjS_DUAbeRyBw2inxrYnUobVV7xymPE
Message-ID: <CAPjX3FdquokJ380EuYVf-m4M5o=_PwQkg+OJN-cOSHkCc-N97w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Fix NULL pointer access in btrfs_check_leaked_roots()
To: Dewei Meng <mengdewei@cqsoftware.com.cn>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 09:39, Dewei Meng <mengdewei@cqsoftware.com.cn> wrote:
>
> If fs_info->super_copy or fs_info->super_for_commit is NULL in
> btrfs_get_tree_subvol(), the btrfs_check_leaked_roots() will get the
> btrfs_root list entry using the fs_info->allocated_roots->next
> which is NULL.
>
> syzkaller reported the following information:
>   ------------[ cut here ]------------
>   BUG: unable to handle page fault for address: fffffffffffffbb0
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
>   Oops: Oops: 0000 [#1] SMP KASAN PTI
>   CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 #4 PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (...)
>   RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
>   RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
>   RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
>   RIP: 0010:refcount_read include/linux/refcount.h:170 [inline]
>   RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/disk-io.c:1230
>   [...]
>   Call Trace:
>    <TASK>
>    btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1280
>    btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2029
>    btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
>    vfs_get_tree+0x98/0x320 fs/super.c:1759
>    do_new_mount+0x357/0x660 fs/namespace.c:3899
>    path_mount+0x716/0x19c0 fs/namespace.c:4226
>    do_mount fs/namespace.c:4239 [inline]
>    __do_sys_mount fs/namespace.c:4450 [inline]
>    __se_sys_mount fs/namespace.c:4427 [inline]
>    __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f032eaffa8d
>   [...]
>
> This should check if the fs_info->allocated_roots->next is NULL before
> accessing it.
>
> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
> ---
>  fs/btrfs/disk-io.c | 3 +++
>  1 file changed, 3 insertions(+)

Looks good to me.
Reviewed-by: Daniel Vacek <neelx@suse.com>

Thank you

>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0aa7e5d1b05f..76db7f98187a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1213,6 +1213,9 @@ void btrfs_check_leaked_roots(const struct btrfs_fs_info *fs_info)
>  #ifdef CONFIG_BTRFS_DEBUG
>         struct btrfs_root *root;
>
> +       if (!fs_info->allocated_roots.next)
> +               return;
> +
>         while (!list_empty(&fs_info->allocated_roots)) {
>                 char buf[BTRFS_ROOT_NAME_BUF_LEN];
>
> --
> 2.43.5
>
>

