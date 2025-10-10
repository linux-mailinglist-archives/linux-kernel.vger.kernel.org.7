Return-Path: <linux-kernel+bounces-848312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0F8BCD5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6F719E46CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AE2EF673;
	Fri, 10 Oct 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+ZtXQyF"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961D26A1BE
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104750; cv=none; b=W2WwyEGATvTgEIaLKUzuMuMZKZ6Tq418VcF8tnGWU/cZa5h8ikpnmiQFe8S+EI45P20VotK2dXdoqfHcpT6eEmdq39vPxV3ZYxtmIhdygQbfOHwWn9LJKmVe045TNLHThtL29RuoXnxdJieuJnjnmOfr0o/hy7dqFvzyJfbRAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104750; c=relaxed/simple;
	bh=J17aeTHbROwRfiZR6L7QFwJMsI37eDUzmAXy+ubVcOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQmHqq0KnA3bFVx5IzcDI0MylUr0AjdKcc5kr+p5ewPd7B2H6JNw2uRofq6QKhj2JfInwi8ai+9eeH3CN74fBmruw7Ffp+GSFy0gy1B96V0ujjrjc0sEJLzN6oFvS8QLktCGM+yJWg790hZKK4XmHd07BhHnSnAMxtlhEbdvuO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+ZtXQyF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-330b4739538so1974290a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760104748; x=1760709548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqDMxseq0YeepIl3kfgQklE6zaT80p7XvhxaOx8CEjY=;
        b=B+ZtXQyFRpooBhX4zmaBbmwCx6OukZHRAD9OsjXnsO2VeMg5btYqEFb53vtaHuqrHo
         PjBJykRYsSzjZ10U5F/KnzOllgQMf7ZqtD7AoYouCGZt4FGZ07grMqccxis/NP/vXloy
         5huatbiKTeYs8EUcVA3ROAGA/FM+erxId2GLxwSf2TAPexq+MRURF2nXYvOTnzZH5DJm
         wKmJb83URX/LT9wfI6ptQCl1kS/D3tVFeqrJpfmS+c6z0i2jLT+u8iA7cgUScLIGgl/z
         Ms4BJ+hXJvXZgpgO2fhWPa+W9WnwFszF1WIXTkb88g6GnPtAhIW/oipbCBbKp0S2mnez
         y6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760104748; x=1760709548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqDMxseq0YeepIl3kfgQklE6zaT80p7XvhxaOx8CEjY=;
        b=lDSvnG8QJU1BBE3tYSI67URR+i/niVSJIDag69esLeAQENLhvQInJ0Pa6FDpMSlcR7
         uhO0IQJKqRJiK6ihgTb7rBXnwRcJnmvDNRzk6YyQEfTjb6yx+9+yw0cHvuqz9s1P7keu
         f2y+H66p/MN8+VvrUAk4/X2h20Saa+rhWbNkbIYVCSy9BkNgj2LNc8xqooAVJnRt4Fit
         M/cJgYMcV/hBj7Z8Olb0a+GHvmWCUvucVFsw4l//2is0Io2Ykvat7DrMSP7tBENFNC2r
         3cpbQoNaWlrtnqIYcq8eydbDFr9jtYACK5SneJt8arNupsGlqv3uF1CpVmoDuA0TkfnD
         VZLg==
X-Forwarded-Encrypted: i=1; AJvYcCXJVznJbyPFCTrCRXtkEhv49ZbG+TzzIMqvWMOoMtJ3I97+I/b4bpS42m3VGmC0/NlK0AAbxFa60ochfD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTeYsMbODhKv8JDUWa4NaToA1bHmUdKczyUdQjakBR/lei9RRY
	0G1/LsAKYt4Z6NTidGhZMPLGEg/54xYO7YXe51GGbs6oeB6HLkKPFf99Ncc7+EiL5LyZT8rYxpm
	ed0cDwYVCYTEonNTRDh1BGfGNbGpxdmA=
X-Gm-Gg: ASbGncu2o705EhgqS+RRsZMZYimB6PfUrldtyljUD7f60AtB321POZwKNRVHOVVbjVd
	MZ+Ve/cjxMqbuCKF7rad1bLC5kze/BND1YJiupy7lvbpylUSQ/foFRu+ZAGY7GhLxET4Hu6M/F3
	lPQfgwh7sYiDvFE0VwSd6Q4BhiLVz/lR502ZXgvsMQftKdaRR+wnMu5VRHFgZemZJX2dszq7pgI
	OfHD2FSCby9+I9tTBNv8eKrwg==
X-Google-Smtp-Source: AGHT+IEEO7CawPriEW0/0WOW4dpjQYsEyKshJGHn1pdmy3tv9STs6VYtKvGdq7Z2wdqMp1dddByK47girDVwZrKFyAQ=
X-Received: by 2002:a17:90b:1651:b0:339:dcc3:82ca with SMTP id
 98e67ed59e1d1-33b51148aabmr17168825a91.6.1760104747815; Fri, 10 Oct 2025
 06:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010132610.12001-1-maxime.belair@canonical.com> <20251010132610.12001-5-maxime.belair@canonical.com>
In-Reply-To: <20251010132610.12001-5-maxime.belair@canonical.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Oct 2025 09:58:56 -0400
X-Gm-Features: AS18NWACUq7J7s5W9SgZze2UmbQ2ViWNBvTFHTIJBUHBTUfzcbIhMnsX-w7kg_0
Message-ID: <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] SELinux: add support for lsm_config_system_policy
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net, 
	kees@kernel.org, casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:27=E2=80=AFAM Maxime B=C3=A9lair
<maxime.belair@canonical.com> wrote:
>
> Enable users to manage SELinux policies through the new hook
> lsm_config_system_policy. This feature is restricted to CAP_MAC_ADMIN.

(added selinux mailing list and Fedora/Red Hat SELinux kernel maintainer to=
 cc)

A couple of observations:
1. We do not currently require CAP_MAC_ADMIN for loading SELinux
policy, since it was only added later for Smack and SELinux implements
its own permission checks. When loading policy via selinuxfs, one
requires uid-0 or CAP_DAC_OVERRIDE to write to /sys/fs/selinux/load
plus the corresponding SELinux permissions, but this is just an
artifact of the filesystem-based interface. I'm not opposed to using
CAP_MAC_ADMIN for loading policy via the new system call but wanted to
note it as a difference.

2. The SELinux namespaces support [1], [2] is based on instantiating a
separate selinuxfs instance for each namespace; you load a policy for
a namespace by mounting a new selinuxfs instance after unsharing your
SELinux namespace and then write to its /sys/fs/selinux/load
interface, only affecting policy for the new namespace. Your interface
doesn't appear to support such an approach and IIUC will currently
always load the init SELinux namespace's policy rather than the
current process' SELinux namespace.

[1] https://github.com/stephensmalley/selinuxns
[2] https://lore.kernel.org/selinux/20250814132637.1659-1-stephen.smalley.w=
ork@gmail.com/

>
> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>
> ---
>  security/selinux/hooks.c            | 27 +++++++++++++++++++++++++++
>  security/selinux/include/security.h |  7 +++++++
>  security/selinux/selinuxfs.c        | 16 ++++++++++++----
>  3 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7a7dcab81db..3d14d4e47937 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7196,6 +7196,31 @@ static int selinux_uring_allowed(void)
>  }
>  #endif /* CONFIG_IO_URING */
>
> +/**
> + * selinux_lsm_config_system_policy - Manage a LSM policy
> + * @op: operation to perform. Currently, only LSM_POLICY_LOAD is support=
ed
> + * @buf: User-supplied buffer
> + * @size: size of @buf
> + * @flags: reserved for future use; must be zero
> + *
> + * Returns: number of written rules on success, negative value on error
> + */
> +static int selinux_lsm_config_system_policy(u32 op, void __user *buf,
> +                                           size_t size, u32 flags)
> +{
> +       loff_t pos =3D 0;
> +
> +       if (op !=3D LSM_POLICY_LOAD || flags)
> +               return -EOPNOTSUPP;
> +
> +       if (!selinux_null.dentry || !selinux_null.dentry->d_sb ||
> +           !selinux_null.dentry->d_sb->s_fs_info)
> +               return -ENODEV;
> +
> +       return __sel_write_load(selinux_null.dentry->d_sb->s_fs_info, buf=
, size,
> +                               &pos);
> +}
> +
>  static const struct lsm_id selinux_lsmid =3D {
>         .name =3D "selinux",
>         .id =3D LSM_ID_SELINUX,
> @@ -7499,6 +7524,8 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>  #ifdef CONFIG_PERF_EVENTS
>         LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>  #endif
> +       LSM_HOOK_INIT(lsm_config_system_policy, selinux_lsm_config_system=
_policy),
> +
>  };
>
>  static __init int selinux_init(void)
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index e7827ed7be5f..7b779ea43cc3 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -389,7 +389,14 @@ struct selinux_kernel_status {
>  extern void selinux_status_update_setenforce(bool enforcing);
>  extern void selinux_status_update_policyload(u32 seqno);
>  extern void selinux_complete_init(void);
> +
> +struct selinux_fs_info;
> +
>  extern struct path selinux_null;
> +extern ssize_t __sel_write_load(struct selinux_fs_info *fsi,
> +                               const char __user *buf, size_t count,
> +                               loff_t *ppos);
> +
>  extern void selnl_notify_setenforce(int val);
>  extern void selnl_notify_policyload(u32 seqno);
>  extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 47480eb2189b..1f7e611d8300 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -567,11 +567,11 @@ static int sel_make_policy_nodes(struct selinux_fs_=
info *fsi,
>         return ret;
>  }
>
> -static ssize_t sel_write_load(struct file *file, const char __user *buf,
> -                             size_t count, loff_t *ppos)
> +ssize_t __sel_write_load(struct selinux_fs_info *fsi,
> +                        const char __user *buf, size_t count,
> +                        loff_t *ppos)
>
>  {
> -       struct selinux_fs_info *fsi;
>         struct selinux_load_state load_state;
>         ssize_t length;
>         void *data =3D NULL;
> @@ -605,7 +605,6 @@ static ssize_t sel_write_load(struct file *file, cons=
t char __user *buf,
>                 pr_warn_ratelimited("SELinux: failed to load policy\n");
>                 goto out;
>         }
> -       fsi =3D file_inode(file)->i_sb->s_fs_info;
>         length =3D sel_make_policy_nodes(fsi, load_state.policy);
>         if (length) {
>                 pr_warn_ratelimited("SELinux: failed to initialize selinu=
xfs\n");
> @@ -626,6 +625,15 @@ static ssize_t sel_write_load(struct file *file, con=
st char __user *buf,
>         return length;
>  }
>
> +static ssize_t sel_write_load(struct file *file, const char __user *buf,
> +                             size_t count, loff_t *ppos)
> +{
> +       struct selinux_fs_info *fsi =3D file_inode(file)->i_sb->s_fs_info=
;
> +
> +       return __sel_write_load(fsi, buf, count, ppos);
> +}
> +
> +
>  static const struct file_operations sel_load_ops =3D {
>         .write          =3D sel_write_load,
>         .llseek         =3D generic_file_llseek,
> --
> 2.48.1
>

