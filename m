Return-Path: <linux-kernel+bounces-883267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D349AC2CEFD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D726202AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D412E3161A2;
	Mon,  3 Nov 2025 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="dqJvrB0t"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47F275111
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184319; cv=none; b=ox3ltkZoWbL5PquzQn39ON/FWdeWbN1ygDncRXDNgPvkIyuKgj2cXe1CRyMoGN4GT1Ur6O/ZA5Qpy42M1JvkVkGSDjaPgO4xp92iyb4d8pD8bxAra2qRiQqMp2qb6EJFNiPGEaaq1CVVcdSuxPXBfFv7MWjDb6lABhfbFKwBwC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184319; c=relaxed/simple;
	bh=lXCo5f1cnSVqszhYTlWLM9Jdt2mjYhfagwS5vItQ1Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVlgCrV/B/l0chx7VNdcWS03NnCBFOiNJLCeIV/3uAguYqbyideYdLSdXl8dgtBfqv+/tuhYtEQAyTC2fL+UAwnX/6uo2c38itQ7y1lH10A21YiuWQf27kjaClt9PB73szq+kJgZ3DKWdmF5XQP4IPVAO07s894kveM1oVekHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=dqJvrB0t; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso7850075e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762184315; x=1762789115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G763qs2cjPyCxHTfBRoBD1+X4jNn3Zm2GLJPTXDg/lc=;
        b=dqJvrB0ts+wgIWa3i1f9/0W6ONSVD6Gw3grjJN1JEscPYY8v0g/7XKBp+/K5z+o2Rc
         To7VjCFW87WOuI5HgjDZ2URnz4c0Z6WLLCI7k6G7fbnkGelr/m08kUBebYlqjcYJiAuc
         lsYoQZ/p+MkVferzc8+tYVqdMy4I7XefAnIuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184315; x=1762789115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G763qs2cjPyCxHTfBRoBD1+X4jNn3Zm2GLJPTXDg/lc=;
        b=waVVMjlNmLnbUW6Uoj9FRjm+YWMeTaOGf/zqIruJsoXAz3q744wJ/aidBB9jQAyoNG
         ZdvTTPQWyVYe9Camo8poMlFkbFzo3UitV2obRU6I0IAD896DCHHUJVzvWLMv2VQJArCU
         xRi00DcZsgZCRGV9NslKdFcM69JI6gdkPAnFKkZktBJhQBfAizJGmR966+srLUL2f8y2
         g6UHcwIQWkBVx8NTgKC1/qgGmS4WxHKjOyXD+eCCw1CIgL89/viuvTQOzsIFR2h++bBv
         bgZbfzP6FZBxZp4qrTP716ZqG5Yy1o+qSEBParoMLcUpykseahMNLHPeEc8489HuXHAj
         MmmA==
X-Forwarded-Encrypted: i=1; AJvYcCXK6hmB8dcgO9igpquJjGpX9gYZTyyS1uByA7J9bt5abRAleeNKWX/Eo1m/9KxZfwDYlJL6CEvPsLc5jPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Oa8gCk5dhsEgi550NxIQ2WpFUvXsw7el36JyOh1Fhc0pcoGu
	5a4WDlkyzYXVCI3Y1hCUHxIZ8/T6psDNWYV7D4s0U21O5f3jC9Fy6Gh+DFvwB+xq/3jmRRkhkie
	nCvdR9vTPIl8mY0cv5/eVC/RpzsuVuBugn7wr0JSvIQ==
X-Gm-Gg: ASbGncv5kKlTz3p9nW0XUWpOQehOQ5jK49rf5Re1QW4SVtO8zqfTl21p/kImTqi8TjB
	2jhM+Q/VBkLez5txzJesvAAUsOxbXDBG/DQYyXkg6hCTe8egeY/CXmIsc3mmwC3L6TcFyDbluPE
	ye5IkPV2MfT9WP/UFxy6upIb+vKg/mVfutaw8GObYCtkn+x3aXiItFYmFmNZJB5Pb8GM45WbQV4
	T3Ybjcda87gT26pocp5EOjlnP/hesBKbG6w2P246Gi1/6Sv/UpKu1HGMzN1
X-Google-Smtp-Source: AGHT+IFoHmKFA6va+9BCF+Wvr7vD5yQOZoAC5LxoxJpya43QUvoFagMsBfCC81Up+BgONs8yfzknsZqJTEhIYGMVJNg=
X-Received: by 2002:ac2:4e0a:0:b0:594:2e45:53b1 with SMTP id
 2adb3069b0e04-5942e45561emr781168e87.23.1762184315293; Mon, 03 Nov 2025
 07:38:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-5-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-5-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:38:24 +0100
X-Gm-Features: AWmQ_bnTxLSH2R-4dR153nFssPhzWJU_Bj6bVcB4r4C8PvRNB4GqE6prGW-RX5w
Message-ID: <CAJqdLrqasST2rf+TNvNarmP2fnp-7xD3dmOoBU0dRqQoqot37A@mail.gmail.com>
Subject: Re: [PATCH 05/22] pidfd: add a new supported_mask field
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
> Some of the future fields in struct pidfd_info can be optional. If the
> kernel has nothing to emit in that field, then it doesn't set the flag
> in the reply. This presents a problem: There is currently no way to know
> what mask flags the kernel supports since one can't always count on them
> being in the reply.
>
> Add a new PIDFD_INFO_SUPPORTED_MASK flag and field that the kernel can
> set in the reply. Userspace can use this to determine if the fields it
> requires from the kernel are supported. This also gives us a way to
> deprecate fields in the future, if that should become necessary.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c                 | 17 ++++++++++++++++-
>  include/uapi/linux/pidfd.h |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 7e4d90cc74ff..204ebd32791a 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -293,6 +293,14 @@ static __u32 pidfs_coredump_mask(unsigned long mm_flags)
>         return 0;
>  }
>
> +/* This must be updated whenever a new flag is added */
> +#define PIDFD_INFO_SUPPORTED (PIDFD_INFO_PID | \
> +                             PIDFD_INFO_CREDS | \
> +                             PIDFD_INFO_CGROUPID | \
> +                             PIDFD_INFO_EXIT | \
> +                             PIDFD_INFO_COREDUMP | \
> +                             PIDFD_INFO_SUPPORTED_MASK)
> +
>  static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>         struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> @@ -306,7 +314,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         const struct cred *c;
>         __u64 mask;
>
> -       BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER1);
> +       BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER2);
>
>         if (!uinfo)
>                 return -EINVAL;
> @@ -412,6 +420,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>                 return -ESRCH;
>
>  copy_out:
> +       if (mask & PIDFD_INFO_SUPPORTED_MASK) {
> +               kinfo.mask |= PIDFD_INFO_SUPPORTED_MASK;
> +               kinfo.supported_mask = PIDFD_INFO_SUPPORTED;
> +       }
> +
> +       /* Are there bits in the return mask not present in PIDFD_INFO_SUPPORTED? */
> +       WARN_ON_ONCE(~PIDFD_INFO_SUPPORTED & kinfo.mask);
>         /*
>          * If userspace and the kernel have the same struct size it can just
>          * be copied. If userspace provides an older struct, only the bits that
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 6ccbabd9a68d..e05caa0e00fe 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -26,9 +26,11 @@
>  #define PIDFD_INFO_CGROUPID            (1UL << 2) /* Always returned if available, even if not requested */
>  #define PIDFD_INFO_EXIT                        (1UL << 3) /* Only returned if requested. */
>  #define PIDFD_INFO_COREDUMP            (1UL << 4) /* Only returned if requested. */
> +#define PIDFD_INFO_SUPPORTED_MASK      (1UL << 5) /* Want/got supported mask flags */
>
>  #define PIDFD_INFO_SIZE_VER0           64 /* sizeof first published struct */
>  #define PIDFD_INFO_SIZE_VER1           72 /* sizeof second published struct */
> +#define PIDFD_INFO_SIZE_VER2           80 /* sizeof third published struct */
>
>  /*
>   * Values for @coredump_mask in pidfd_info.
> @@ -94,6 +96,7 @@ struct pidfd_info {
>         __s32 exit_code;
>         __u32 coredump_mask;
>         __u32 __spare1;
> +       __u64 supported_mask;   /* Mask flags that this kernel supports */
>  };
>
>  #define PIDFS_IOCTL_MAGIC 0xFF
>
> --
> 2.47.3
>

