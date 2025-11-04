Return-Path: <linux-kernel+bounces-884383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC881C30127
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A872E4FCA29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194A2BDC28;
	Tue,  4 Nov 2025 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="bNd6EJRE"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B524886A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245973; cv=none; b=szBZnK4ux4sdN9apthXeFxZ4I+SihnEd/H2XNMHAoNpChZJUcuAyLoYN2BmmcSa+rYt1NxMi7LEfKrXxZuKyI3MYKD4zA+v/OWcLW8bi7X7I092iA+0es7PF1Pgwh/82WANRoHjdVhB+E/oIg8FzKxs7EVJJS2z33PCNBBXFPT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245973; c=relaxed/simple;
	bh=llcHZomcCcYqyyGqguubvbpQD1djA8iATNWRT6JOWCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2NBdScAWJlM1I5tqCVGtkfZkKnXTToTm9ahMHhnYgvL9vu/NdQ42x4Vqj1i0gYm5DQWDcR+TkmFf6kkORiP3IG107WCrmH2jbuSVhhWELtizhJS4qzFfcgOSl5W0HNi8fU4GBgLo+jaqJjp5Fe6xbZWm8QvUF9z2fXDRYKK7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=bNd6EJRE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-58b025fce96so4369931e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762245969; x=1762850769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnXar9Wr5UxLLu783ced0BqM7t4CxuKlHntmiXFswCI=;
        b=bNd6EJRE/Z89MKyUJtMecTUi4xYW3+t6bqg8zgDxxelyKZggbTvNF+7dkChpzNi9UZ
         OwNROGLctwbY6zjz4xff2Re86sEjVfVQLWjFDxSB65Y2GIo5FXkgvGpA+MnAQy13TCDm
         wz/jHgHOOaPwZuGZX9Wv++p3b4VBfBQyYG0rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245969; x=1762850769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnXar9Wr5UxLLu783ced0BqM7t4CxuKlHntmiXFswCI=;
        b=APXJ1Yik1mD2StCVMl2oN4+kNQ9LAQenSrWjvKvDGBcbziOnrmImj2PLqKNa/H6bdY
         ITxebjIQh0Bg+6e5jIP1CZknZ4nvzbPA+331lZnznEk7GvpcQ+/sNKRlEmEXRj6AqxUU
         gM1zX71oLeel1cffjICDTIHT1I1PqJg9ae80+Omw/2ivs6vKQReS8QYQLvoqpInKcxmE
         U96ZSWOS2yboebVD0H0zDToBLZ2MgkMqk3WmAs6WnuLojv932XSwT0TmtvEeDMLzEDdt
         bYsPBH3zdkaAhmuF/RVr6Xvah+ZFYGfL4Nv33SCF1KdY+yklKmUsJ3+QTV0JV0aRThLQ
         dvZw==
X-Forwarded-Encrypted: i=1; AJvYcCXm5TjxPQs4F+GY1etbmIRMqNJ8p0a7TVLiLnHlfV8/8wABjZnAHzApX0XTwwbcIXsvH5BLoJTj42ekjLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8ZOZ2V1iV/dZiHfQbzObEv9x3WZWaPHJ7UDWcONaapvGrC20
	w6NhiHRHSE1IS09H0m4SdCrv65b8pg4DdZjTfwxLB5nh19qzSq39otDNGapDetJu/Yx6DLZ1JHb
	sTjgKU4EDU17dYDPEZ09vWyO6/5f8DuSnTHJIBlpwPA==
X-Gm-Gg: ASbGncv97aXhj+WvLBHhsKyYyW4Q9tgJWkxYTLR4mkD3l3SxDQ5ARzAT11Gjw/SkjG0
	d1FBYkQHtTn4s0o9+Iqm8JCMgP8IO6Ri1hEryDUQ5wCFnVyU478idGIAdRm/KYxyy9u/JCaV+cz
	i+OMgWSZFCMTCmkXBhRi7pVgme8Gm9+AiWy/mfDhKcBPDWlHBDIkL0FFOq/k/cCdcL4x0EESSk5
	uME6/XIhgJGD2ZBYbHCokipPLirkCya/Mqs2aqbKhjkX70jVx5JrZq/iTCq
X-Google-Smtp-Source: AGHT+IGmcyMQMchAUsCjxdqfrykqnEvdHSa18ThgK8/5nUb7IaGKXQ6KGbZV02Rp9MX5r7OIIwBbvBaZSiMxSHYKb1A=
X-Received: by 2002:a05:6512:1150:b0:594:2c58:9784 with SMTP id
 2adb3069b0e04-5942c589aabmr2563189e87.53.1762245968851; Tue, 04 Nov 2025
 00:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-8-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-8-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 09:45:57 +0100
X-Gm-Features: AWmQ_bkTtgnWEZ5W_GRA60pGSiEfHADxh92uICX54W3Kpf9K7nBvZz65uK58438
Message-ID: <CAJqdLro54iDWbR1P3hw_2AVLFPq4kSLcc85J_5u+OAifghUjyA@mail.gmail.com>
Subject: Re: [PATCH 08/22] pidfs: expose coredump signal
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
> Userspace needs access to the signal that caused the coredump before the
> coredumping process has been reaped. Expose it as part of the coredump
> information in struct pidfd_info. After the process has been reaped that
> info is also available as part of PIDFD_INFO_EXIT's exit_code field.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c                 | 30 +++++++++++++++++++-----------
>  include/uapi/linux/pidfd.h |  7 +++++--
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index a3b80be3b98b..354ceb2126e7 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -41,6 +41,7 @@ void pidfs_get_root(struct path *path)
>
>  enum pidfs_attr_mask_bits {
>         PIDFS_ATTR_BIT_EXIT     = 0,
> +       PIDFS_ATTR_BIT_COREDUMP = 1,
>  };
>
>  struct pidfs_attr {
> @@ -51,6 +52,7 @@ struct pidfs_attr {
>                 __s32 exit_code;
>         };
>         __u32 coredump_mask;
> +       __u32 coredump_signal;
>  };
>
>  static struct rb_root pidfs_ino_tree = RB_ROOT;
> @@ -297,7 +299,8 @@ static __u32 pidfs_coredump_mask(unsigned long mm_flags)
>                               PIDFD_INFO_CGROUPID | \
>                               PIDFD_INFO_EXIT | \
>                               PIDFD_INFO_COREDUMP | \
> -                             PIDFD_INFO_SUPPORTED_MASK)
> +                             PIDFD_INFO_SUPPORTED_MASK | \
> +                             PIDFD_INFO_COREDUMP_SIGNAL)
>
>  static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> @@ -342,9 +345,12 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         }
>
>         if (mask & PIDFD_INFO_COREDUMP) {
> -               kinfo.coredump_mask = READ_ONCE(attr->coredump_mask);
> -               if (kinfo.coredump_mask)
> -                       kinfo.mask |= PIDFD_INFO_COREDUMP;
> +               if (test_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask)) {
> +                       smp_rmb();
> +                       kinfo.mask |= PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
> +                       kinfo.coredump_mask = attr->coredump_mask;
> +                       kinfo.coredump_signal = attr->coredump_signal;
> +               }
>         }
>
>         task = get_pid_task(pid, PIDTYPE_PID);
> @@ -370,6 +376,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>
>                         kinfo.coredump_mask = pidfs_coredump_mask(flags);
>                         kinfo.mask |= PIDFD_INFO_COREDUMP;
> +                       /* No coredump actually took place, so no coredump signal. */
>                 }
>         }
>
> @@ -666,20 +673,21 @@ void pidfs_coredump(const struct coredump_params *cprm)
>  {
>         struct pid *pid = cprm->pid;
>         struct pidfs_attr *attr;
> -       __u32 coredump_mask = 0;
>
>         attr = READ_ONCE(pid->attr);
>
>         VFS_WARN_ON_ONCE(!attr);
>         VFS_WARN_ON_ONCE(attr == PIDFS_PID_DEAD);
>
> -       /* Note how we were coredumped. */
> -       coredump_mask = pidfs_coredump_mask(cprm->mm_flags);
> -       /* Note that we actually did coredump. */
> -       coredump_mask |= PIDFD_COREDUMPED;
> +       /* Note how we were coredumped and that we coredumped. */
> +       attr->coredump_mask = pidfs_coredump_mask(cprm->mm_flags) |
> +                             PIDFD_COREDUMPED;
>         /* If coredumping is set to skip we should never end up here. */
> -       VFS_WARN_ON_ONCE(coredump_mask & PIDFD_COREDUMP_SKIP);
> -       smp_store_release(&attr->coredump_mask, coredump_mask);
> +       VFS_WARN_ON_ONCE(attr->coredump_mask & PIDFD_COREDUMP_SKIP);
> +       /* Expose the signal number that caused the coredump. */
> +       attr->coredump_signal = cprm->siginfo->si_signo;
> +       smp_wmb();
> +       set_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask);
>  }
>  #endif
>
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index e05caa0e00fe..ea9a6811fc76 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -27,6 +27,7 @@
>  #define PIDFD_INFO_EXIT                        (1UL << 3) /* Only returned if requested. */
>  #define PIDFD_INFO_COREDUMP            (1UL << 4) /* Only returned if requested. */
>  #define PIDFD_INFO_SUPPORTED_MASK      (1UL << 5) /* Want/got supported mask flags */
> +#define PIDFD_INFO_COREDUMP_SIGNAL     (1UL << 6) /* Always returned if PIDFD_INFO_COREDUMP is requested. */
>
>  #define PIDFD_INFO_SIZE_VER0           64 /* sizeof first published struct */
>  #define PIDFD_INFO_SIZE_VER1           72 /* sizeof second published struct */
> @@ -94,8 +95,10 @@ struct pidfd_info {
>         __u32 fsuid;
>         __u32 fsgid;
>         __s32 exit_code;
> -       __u32 coredump_mask;
> -       __u32 __spare1;
> +       struct /* coredump info */ {
> +               __u32 coredump_mask;
> +               __u32 coredump_signal;
> +       };
>         __u64 supported_mask;   /* Mask flags that this kernel supports */
>  };
>
>
> --
> 2.47.3
>

