Return-Path: <linux-kernel+bounces-883260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AD9C2D00F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8978E460DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6926C3BE;
	Mon,  3 Nov 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="SZZQMC4G"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49A3148B9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184169; cv=none; b=sYNcVLWdpe0IOSPQewOAz4QzeYyfHve22GZesmCG5fot2cN2kma8kLXh9VyCVJyr5OaJcIPP6bxHQp8HPUQorlMrohTPpYmKLbZ/EugR3oUrVFZnkG1Ev33v4eeHWnsgm8+qKnHCNf9vdJwQRt+ikMIpj1r2H5c+vk69Vj4xr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184169; c=relaxed/simple;
	bh=To6YBtHvG+Ot8iV3UpyscJtjXiqASjcXva85WF1+cwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYY6KTlC/eO076+Ysch5PSOSFXRi7prvdnsFmZMv0v7iZJb78JSBkuiQFqdRzbPrscmKpMuGmjr53TUF171qlEIj72ptW27dJoUoWlfFMUmX8Zn/46Zr7y3b3fYMlBF8yS6EZafu2Q2rlSX51IZJD03LK41h7JlA92bGWjPSvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=SZZQMC4G; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-594330147efso437654e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762184164; x=1762788964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4q7nanxgAPjG6mFRNLv4lMdBfCDrxBKffr3UhQ6bdwg=;
        b=SZZQMC4GkPK7PJ1LSkgF33aE/2stqdpC17dyoFMnD8a0dCraXOctYBT7pM1Rcp/Fz0
         G2am6GzWmSmUg7RK8WK4kIMYp0UKvcvEQe6l8TwYD2KUXCv6+yFNzQheJ7TaV2TgdOo5
         9jqbGpl4VKuTQY5pFMQzw8lwMIbfmkNqgs2Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184164; x=1762788964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4q7nanxgAPjG6mFRNLv4lMdBfCDrxBKffr3UhQ6bdwg=;
        b=K/jz2tMjWlN8EHIBKJNuu0oH89q/eV/B27s6qctvTc+/IRpHgut5uZ5B+Z5EFE16Xo
         1ktdPuwkxOvWeZyvM3QwEYtcGeQefw5WAOmUqpTY+LkgWrVFjpk6Yysvb0aiGvCcVx9f
         vfK6RicKKdm52rIptpCzxuv2P0uLt+Rzbc/Vkmebu50l7Q8zc+H0inx4K96tWTJYoyEH
         IsjNrqCzLjykxQLyjzAzy1PmOTZbYTihlzYt7kvGKPB9u5iNSpqaNiYLO4dabme4klw8
         30DWCEUfyGksgbmqqoOeRGbpXeZEws+EcJeBL0h+hv8QluDuXVJGhgibFpv3nsvMTEKr
         o4cg==
X-Forwarded-Encrypted: i=1; AJvYcCXiWSvqVnzMdTCidQUF7bTAZKOJgJvHOKl8P6WZudEZ2mXeFEUetJR+BgGhyOXfjgK1zkAvTXygfUyAD30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7almFHQiBcv6QJaK7/PVRiVg8VDlT/Qp2OmsGkFzoXXarE29k
	tK9lWs6vBQyK1U7CKzDTNfpfCq0r1Ld6lipPmk6NdSe/pMRj83y573x+8YhFoBq8tIBIJJd/TaF
	GihZthkisHRZ0oGyjKkrG/s+7M3r0980u6KaF9+8j6A==
X-Gm-Gg: ASbGncv1PKbZFplNoDyJ6le7WiAgiRDZUUGFV698YTnrDfb7jLZ0kGvLE5/jk4ggkeR
	Bt+hSYNya5bVLaMhoW7EVIA0wnVmr3AHLqPM9dRwgdu/nlX2qbhoRlxb1/8v3+GvlOJzLbr/RYB
	EJOLMB6ejBEDE72aEie1fkz9PO2OMEu/rwAPHLIRJgyJVaDa/Fb/TYu8e1i8SDrtUXfb1+pgz7C
	/GkZZKaHpNFPRSIysk5naSbRAu7l1diVPMQCytZGaXFcA34CoREkK3r4ZWP
X-Google-Smtp-Source: AGHT+IH97ZofudZYy2YhVvIIBtVo8/XIjLURW5T472yYzr3yF0R+Ac4Gk3xB+10bebg2IPCGrovhYKZsLeaboE+Z0D4=
X-Received: by 2002:a05:6512:3e05:b0:594:27fb:e7f5 with SMTP id
 2adb3069b0e04-59427fbea48mr1899466e87.42.1762184164130; Mon, 03 Nov 2025
 07:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-2-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-2-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:35:50 +0100
X-Gm-Features: AWmQ_bkXv1QBDsVsvIQlpi39qb4kwr3XZZOY4dgbJSwLF1w6jSLZdil2UJ4qNlg
Message-ID: <CAJqdLroQrPkjsDfORf6FimbG2-noX43Kw+Z2M7d3DovpFFyjXw@mail.gmail.com>
Subject: Re: [PATCH 02/22] pidfs: fix PIDFD_INFO_COREDUMP handling
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
> When PIDFD_INFO_COREDUMP is requested we raise it unconditionally in the
> returned mask even if no coredump actually did take place. This was
> done because we assumed that the later check whether ->coredump_mask as
> non-zero detects that it is zero and then retrieves the dumpability
> settings from the task's mm. This has issues though becuase there are
> tasks that might not have any mm. Also it's just not very cleanly
> implemented. Fix this.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c2f0b7091cd7..c0f410903c3f 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -335,8 +335,9 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         }
>
>         if (mask & PIDFD_INFO_COREDUMP) {
> -               kinfo.mask |= PIDFD_INFO_COREDUMP;
>                 kinfo.coredump_mask = READ_ONCE(attr->__pei.coredump_mask);
> +               if (kinfo.coredump_mask)
> +                       kinfo.mask |= PIDFD_INFO_COREDUMP;
>         }
>
>         task = get_pid_task(pid, PIDTYPE_PID);
> @@ -355,12 +356,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         if (!c)
>                 return -ESRCH;
>
> -       if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
> +       if ((mask & PIDFD_INFO_COREDUMP) && !kinfo.coredump_mask) {
>                 guard(task_lock)(task);
>                 if (task->mm) {
>                         unsigned long flags = __mm_flags_get_dumpable(task->mm);
>
>                         kinfo.coredump_mask = pidfs_coredump_mask(flags);
> +                       kinfo.mask |= PIDFD_INFO_COREDUMP;
>                 }
>         }
>
>
> --
> 2.47.3
>

