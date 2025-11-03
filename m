Return-Path: <linux-kernel+bounces-883278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B4C2CF76
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A0F4215BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CB9313538;
	Mon,  3 Nov 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="ZEdPKzha"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D1284B29
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184862; cv=none; b=tMIFZYEuFRVThHaA8up6lxz+9QjpkNAlHtNRzrR94fCOrBPip7mq+eZkl4jBPKiJvVOLzfRLizUtSmi9ab9WHCnzwB/4GqJzhjuqlKESCoOewLJt61PapVC4OllqsVnCzONkf0x0HtggJI37/ImlNieeVUyWJHTHTJruc4ejwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184862; c=relaxed/simple;
	bh=NFs/YEK+ui4fijtqiycT7mfMU5bapMV7WhFGZblpHfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF1s5RQUxo3Cj0y7MId2mpY5WJSvw5pvd9JRpnHQx+o6/5WlHG10ElJj/tlKVvgz2Ykcwt4Mx2HOegzBr5d3y4fYS7JIHsK+zJOgHJpbUQloxZ4qvOPgDwjNJEcS8EhOsWuiOV8RXgG9vx7EwNoOjVYOoMqYOCG3vhvyzNbEDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=ZEdPKzha; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63e19642764so4559703d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762184858; x=1762789658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F+HoO9+4a7Md7jMaImeX/hZVwQ7LdL+3+ozygM9gn2Q=;
        b=ZEdPKzha51RfIxgTt8jqVzG4tH7v14lyE6mk5Tsiidyhv2eHSpM9bHVUYARR5OSsMX
         Bf7uV4WUbU2Br4UmneastUaTR5hIiY3gfer/XsM6FJSpE/9MC2YKUWYdZ8+w6PEPdS4X
         pO2MagUn3M8qXQeAXD+Ixmbhb4m1tXaVsUKNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184858; x=1762789658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+HoO9+4a7Md7jMaImeX/hZVwQ7LdL+3+ozygM9gn2Q=;
        b=qFUu6fihimGAqcRviR2XWv15AoWzDTEilEHZGWmRqmWesx6PMb+8fskrbtwFo/ZMHI
         DKEJLF91VYD9ix+Pg/r70kzLwADL2zgNCsOlWHJ04nAX1Nx2+ydP7MdjYvFjjz2WT5UJ
         3DLRVkmQOIlOJu6vqHfNVhdbkgRAQyFK4K2vAFf8Z+2gX6MARCCpugHsMAUEmhVQzwEK
         Jp0p9TjsRXMW5UzclDdpRQuqrWgGHE1650gR9hHLYIBRBOIx4oy+UzMgl9OzpkurtB2f
         7eNq4gH3jCXZW0o45y0p1cYXD0JXZGsOdbMjpZHwtcZh/QNYVy72TwNPOjS1n9Om8EY9
         wryw==
X-Forwarded-Encrypted: i=1; AJvYcCUC+WQ0t7uIlB9SRsLYSu9fPEqeF2O8it1MIFYtahaoaIRrYsUP63/iTiz1rfvJGrL+jeUmNTxFy45kQ1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3WtyH0/1eDDFksD5CwE1sxrGpk2E77RWnC/bgoUwK5q4e1K3
	YRU2zGfquOwQQEvwxaaDR00HSzH69b6CpISV7aA3F8tNQdESHULVC0x0XoT81MytIYhxW75djyu
	sU4An1zQKIKkuybbto66aeetEYfHyChBND32lqLq7bQ==
X-Gm-Gg: ASbGncv0HfX0J2rutUK2R0M/ravvORogMmfXGg3upSEmWzk+waP7Nyl1YT+VowiQ5Ld
	ESgunJGo55ICAgDCVh3TegMR2aYoX5xpBXM2CzJNieOrjpGXRJs4TrXIG314jmeVz50em+B71N+
	7XeN2sqYU7LmJY+zRxSLEhyG1AtE/KSKP0m/xCdJ6u42uHlvq/cmz6aeZwkoLBM0/tWBFQB+xsS
	dKlPCEtX9o2YHcy4KkMJ0cmv3P/ohU7VZdaq6AmaqDAyQSKIPvdG2uPxV06SfqoI175KdLkCc5P
	NAYO0Q==
X-Google-Smtp-Source: AGHT+IGgvUc7TjWUefDusp+/jv3NE5eqAchXtZPzoGzFB5cbm0lbuzxO+j0Z4Mb9AxD5KNNpwMcDGFSTJkcUq5XR6Pk=
X-Received: by 2002:a53:acc6:0:10b0:63f:aef7:d01b with SMTP id
 956f58d0204a3-63faef7e502mr4273853d50.8.1762184858377; Mon, 03 Nov 2025
 07:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-6-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-6-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:47:25 +0100
X-Gm-Features: AWmQ_blASl_U49ouvvpEp9DG1lNOIldaNpfzOHhMjCYrD34K7u-W7ZEXh1KQCU0
Message-ID: <CAJqdLrpxaQ4RTJXZ2Wd9f4ry7ZJv9FayQkL6zzpRnDYUgN8WEA@mail.gmail.com>
Subject: Re: [PATCH 06/22] pidfs: prepare to drop exit_info pointer
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:46 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> There will likely be more info that we need to store in struct
> pidfs_attr. We need to make sure that some of the information such as
> exit info or coredump info that consists of multiple bits is either
> available completely or not at all, but never partially. Currently we
> use a pointer that we assign to. That doesn't scale. We can't waste a
> pointer for each mulit-part information struct we want to expose. Use a
> bitmask instead.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 204ebd32791a..0fad0c969b7a 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -49,7 +49,12 @@ struct pidfs_exit_info {
>         __u32 coredump_mask;
>  };
>
> +enum pidfs_attr_mask_bits {
> +       PIDFS_ATTR_BIT_EXIT     = 0,
> +};
> +
>  struct pidfs_attr {
> +       unsigned long attr_mask;
>         struct simple_xattrs *xattrs;
>         struct pidfs_exit_info __pei;
>         struct pidfs_exit_info *exit_info;
> @@ -333,8 +338,8 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>
>         attr = READ_ONCE(pid->attr);
>         if (mask & PIDFD_INFO_EXIT) {
> -               exit_info = READ_ONCE(attr->exit_info);
> -               if (exit_info) {
> +               if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask)) {
> +                       smp_rmb();
>                         kinfo.mask |= PIDFD_INFO_EXIT;
>  #ifdef CONFIG_CGROUPS
>                         kinfo.cgroupid = exit_info->cgroupid;
> @@ -663,7 +668,8 @@ void pidfs_exit(struct task_struct *tsk)
>         exit_info->exit_code = tsk->exit_code;
>
>         /* Ensure that PIDFD_GET_INFO sees either all or nothing. */
> -       smp_store_release(&attr->exit_info, &attr->__pei);
> +       smp_wmb();
> +       set_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask);
>  }
>
>  #ifdef CONFIG_COREDUMP
>
> --
> 2.47.3
>

