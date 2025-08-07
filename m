Return-Path: <linux-kernel+bounces-758955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA8B1D62A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3725F1899DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8772A1CF;
	Thu,  7 Aug 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf4KmJah"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A826220F5E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564166; cv=none; b=iZsCKNbmgbXxz74YJSfc1yjUPxzMiFYBDyVJR7bdjvyJFyc286y9FqgFWww8ekHcN3KxhlAmuBa1qQCcn1VAZ9dN/fO3kwjHYiQxSVrM8StFVwZScLl714RlTzzXc7GRcku9Wjvpkvl2ZHW6sceh5QL055wIbst5vKVvHONdpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564166; c=relaxed/simple;
	bh=CDQTqUTjrGZ1O6/rxjVzuhg84bZA+kR2laLJczdt2ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Exwx0l8osD+rfJ/26eupIatkVmwysJDhSxz9qfwnT2tpSmWohQUCAMDEDvdOXQzfT0gJY4IP2rj2hbNgZETdFrHE1VFG1bORDwZ5afgYyBb/Ln+19BARTkh8+ZCxC8blP4+ICgqxnRV9ml4fltjsqcIu25LxXQ77dvlfB0+U8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf4KmJah; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-456127b9958so1102105e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754564162; x=1755168962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX3WQJmJq3E5QVkf3JsVMi+F+5ARelFh3TVezhOd40M=;
        b=Gf4KmJahCfhdyiR8iRmRqL3ZxOO+BXVnAMSESzg6GLnzGZIuBSCdk42FnFzP+ZKJe2
         S+BMqqRvj8km+BAPTa3y0c+yNk8xwiJp0mm/OLPHl8LTXgTeWDqLiENgGVS1lQCiIQpc
         owTnrcxJxHdvQ2NTruArY7f5arSVDAyX3/IsUMpvpFLLEUjiO8oim9CJlic+dyMPt8KT
         zkYjXEto/StPE8G2IAncW2LuSxVfMdN1nh2/QQtHBDVsdM7/sucLFCnVQXfCAd+qaksz
         bAQnOdU8+iI0rqpClrFS/lhxyKQfOuklx7xxPEs2keBvjBNDZwKtBZLgvO+Rd7qOAAcG
         Fv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754564162; x=1755168962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX3WQJmJq3E5QVkf3JsVMi+F+5ARelFh3TVezhOd40M=;
        b=RDPb0FsBO6XYZ9JUgda7r/e7lwflUzMEGi3jQJXoeubOtSWy2/EY9qZg+qoTMutuJx
         eNDK36KTkhJYbXdzF234fulwI4UvcrWGDk+avdAAge3Kgzc/sM85x8Op7t1facy8uNac
         Bddlf0rtbW2Naj4ZCsmz+CLOr0xfT6FgkLgzKidD0svpq7gOErvS8NiS0SKo/8XVuPv6
         cWqDXKp5zgOtSljB3oriBNgDfd5TkWcLameKeTGGv+LBxPEW1r1gMG+rnQF6O1xJFrU5
         X2GUVIgDj9xnN7bkYea0kKC2KTFKNGZb3t+2/rChHPeVvSc1ivzU3gyWYhrZp4GGNH/S
         l+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWc06Izz9oYHH8E3OyHjH3zOF3iZqC6Zhin7RnALJRGEBXCuGLQUUY3Akoi+QlLS369t9Rld1KinvBc+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxAWofpe4ASoWfecuuuYzZGYrHDawMVdLObAVmjjtf/zDDla8
	a3ZZipFtrMRDqQYXFCkwJr11iGkakGgAu6HVbnHV3l+D49iZzkoNTCGmFnIBG0SKhqBkcMJQh+p
	eey/xcJaW74HRehLT597wZwvJ3aZKgS8=
X-Gm-Gg: ASbGncsIT7WbwavZIu1Cat/8stcu/AdQqkOWmNkf1TgUM8rafTZsxytSPVPT9n9w4Fz
	STQeOuLrYsJ6sclG0D3yektLpbuiS6xS3QzqdFGkaM1JyV1kAwea4KVKO+7xHxlJ2MVF+2b7aj9
	sEfFrjkYkrLtUsO8wadbK78Ke3kbR/rH/NfYkXGdtu3/w9Xti/hMBtBxJ/Z19bj3iOLvL6DS4kt
	M/X38nNoGOlpXKHsmo=
X-Google-Smtp-Source: AGHT+IGnnIOhfh+KKuN5sigk2Gs1Yp+4JNKkwW6CZAaoM2vNoTTZ+Xu985FmlD9VEpx6+iXf24fReS5td73e992vjFc=
X-Received: by 2002:a05:6000:290b:b0:3b7:95ad:a6d9 with SMTP id
 ffacd0b85a97d-3b8f419271fmr2022271f8f.1.1754564162223; Thu, 07 Aug 2025
 03:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806091954.180602-1-guochunhai@vivo.com>
In-Reply-To: <20250806091954.180602-1-guochunhai@vivo.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 7 Aug 2025 18:55:51 +0800
X-Gm-Features: Ac12FXwU9VA2_-6askRY3FUIvHtONZQojbEIJwGOE7pdhXzH00kWAlRtVtdtFag
Message-ID: <CAHJ8P3Kmkc751eEWVH1wJnA7t_2kYWSzezkv1CfRDvoPPQg-aw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: add reserved nodes for privileged users
To: Chunhai Guo <guochunhai@vivo.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chunhai Guo via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> =E4=BA=8E2025=E5=B9=B48=E6=9C=886=
=E6=97=A5=E5=91=A8=E4=B8=89 17:22=E5=86=99=E9=81=93=EF=BC=9A
>
> This patch allows privileged users to reserve nodes via the
> 'reserve_node' mount option, which is similar to the existing
> 'reserve_root' option.
>
> "-o reserve_node=3D<N>" means <N> nodes are reserved for privileged
> users only.
>
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v4->v5: Apply Chao's suggestion from v4.
> v3->v4: Rebase this patch on https://lore.kernel.org/linux-f2fs-devel/202=
50731060338.1136086-1-chao@kernel.org
> v2->v3: Apply Chao's suggestion from v2.
> v1->v2: Add two missing handling parts.
> v1: https://lore.kernel.org/linux-f2fs-devel/20250729095238.607433-1-guoc=
hunhai@vivo.com/
> ---
>  Documentation/filesystems/f2fs.rst |  9 ++++---
>  fs/f2fs/f2fs.h                     | 17 ++++++++----
>  fs/f2fs/super.c                    | 43 +++++++++++++++++++++++++-----
>  3 files changed, 54 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesyste=
ms/f2fs.rst
> index 03b1efa6d3b2..95dbcd7ac9a8 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -173,9 +173,12 @@ data_flush          Enable data flushing before chec=
kpoint in order to
>                          persist data of regular and symlink.
>  reserve_root=3D%d                 Support configuring reserved space whi=
ch is used for
>                          allocation from a privileged user with specified=
 uid or
> -                        gid, unit: 4KB, the default limit is 0.2% of use=
r blocks.
> -resuid=3D%d               The user ID which may use the reserved blocks.
> -resgid=3D%d               The group ID which may use the reserved blocks=
.
> +                        gid, unit: 4KB, the default limit is 12.5% of us=
er blocks.
> +reserve_node=3D%d                 Support configuring reserved nodes whi=
ch are used for
> +                        allocation from a privileged user with specified=
 uid or
> +                        gid, the default limit is 12.5% of all nodes.
> +resuid=3D%d               The user ID which may use the reserved blocks =
and nodes.
> +resgid=3D%d               The group ID which may use the reserved blocks=
 and nodes.
>  fault_injection=3D%d      Enable fault injection in all supported types =
with
>                          specified injection rate.
>  fault_type=3D%d           Support configuring fault injection type, shou=
ld be
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index eb372af22edc..a4e4c3931441 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -131,6 +131,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>   * string rather than using the MS_LAZYTIME flag, so this must remain.
>   */
>  #define F2FS_MOUNT_LAZYTIME            0x40000000
> +#define F2FS_MOUNT_RESERVE_NODE                0x80000000
>
>  #define F2FS_OPTION(sbi)       ((sbi)->mount_opt)
>  #define clear_opt(sbi, option) (F2FS_OPTION(sbi).opt &=3D ~F2FS_MOUNT_##=
option)
> @@ -172,6 +173,7 @@ struct f2fs_rwsem {
>  struct f2fs_mount_info {
>         unsigned int opt;
>         block_t root_reserved_blocks;   /* root reserved blocks */
> +       block_t root_reserved_nodes;    /* root reserved nodes */
>         kuid_t s_resuid;                /* reserved blocks for uid */
>         kgid_t s_resgid;                /* reserved blocks for gid */
>         int active_logs;                /* # of active logs */
> @@ -2355,7 +2357,7 @@ static inline bool f2fs_has_xattr_block(unsigned in=
t ofs)
>         return ofs =3D=3D XATTR_NODE_OFFSET;
>  }
>
> -static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
> +static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
>                                         struct inode *inode, bool cap)
>  {
>         if (!inode)
> @@ -2380,7 +2382,7 @@ static inline unsigned int get_available_block_coun=
t(struct f2fs_sb_info *sbi,
>         avail_user_block_count =3D sbi->user_block_count -
>                                         sbi->current_reserved_blocks;
>
> -       if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_blocks(sbi, =
inode, cap))
> +       if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, in=
ode, cap))
>                 avail_user_block_count -=3D F2FS_OPTION(sbi).root_reserve=
d_blocks;
>
>         if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> @@ -2738,7 +2740,7 @@ static inline int inc_valid_node_count(struct f2fs_=
sb_info *sbi,
>                                         struct inode *inode, bool is_inod=
e)
>  {
>         block_t valid_block_count;
> -       unsigned int valid_node_count;
> +       unsigned int valid_node_count, avail_user_node_count;
>         unsigned int avail_user_block_count;
>         int err;
>
> @@ -2760,15 +2762,20 @@ static inline int inc_valid_node_count(struct f2f=
s_sb_info *sbi,
>         spin_lock(&sbi->stat_lock);
>
>         valid_block_count =3D sbi->total_valid_block_count + 1;
> -       avail_user_block_count =3D get_available_block_count(sbi, inode, =
false);
> +       avail_user_block_count =3D get_available_block_count(sbi, inode,
> +                       test_opt(sbi, RESERVE_NODE));
>
>         if (unlikely(valid_block_count > avail_user_block_count)) {
>                 spin_unlock(&sbi->stat_lock);
>                 goto enospc;
>         }
>
> +       avail_user_node_count =3D sbi->total_node_count - F2FS_RESERVED_N=
ODE_NUM;
> +       if (test_opt(sbi, RESERVE_NODE) &&
> +                       !__allow_reserved_root(sbi, inode, true))
> +               avail_user_node_count -=3D F2FS_OPTION(sbi).root_reserved=
_nodes;
>         valid_node_count =3D sbi->total_valid_node_count + 1;
> -       if (unlikely(valid_node_count > sbi->total_node_count)) {
> +       if (unlikely(valid_node_count > avail_user_node_count)) {
>                 spin_unlock(&sbi->stat_lock);
>                 goto enospc;
>         }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 30c038413040..a24e855a38ed 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -143,6 +143,7 @@ enum {
>         Opt_extent_cache,
>         Opt_data_flush,
>         Opt_reserve_root,
> +       Opt_reserve_node,
>         Opt_resgid,
>         Opt_resuid,
>         Opt_mode,
> @@ -265,6 +266,7 @@ static const struct fs_parameter_spec f2fs_param_spec=
s[] =3D {
>         fsparam_flag_no("extent_cache", Opt_extent_cache),
>         fsparam_flag("data_flush", Opt_data_flush),
>         fsparam_u32("reserve_root", Opt_reserve_root),
> +       fsparam_u32("reserve_node", Opt_reserve_node),
>         fsparam_gid("resgid", Opt_resgid),
>         fsparam_uid("resuid", Opt_resuid),
>         fsparam_enum("mode", Opt_mode, f2fs_param_mode),
> @@ -336,6 +338,7 @@ static match_table_t f2fs_checkpoint_tokens =3D {
>  #define F2FS_SPEC_discard_unit                 (1 << 21)
>  #define F2FS_SPEC_memory_mode                  (1 << 22)
>  #define F2FS_SPEC_errors                       (1 << 23)
> +#define F2FS_SPEC_reserve_node                 (1 << 24)
Hi Chunhai,
It seems that this conflicts with commit:1399fd4ff25d (f2fs: add
lookup_mode mount option)
#define F2FS_SPEC_errors (1 << 23)
+#define F2FS_SPEC_lookup_mode (1 << 24)
thanks!
>
>  struct f2fs_fs_context {
>         struct f2fs_mount_info info;
> @@ -437,22 +440,30 @@ static void f2fs_destroy_casefold_cache(void) { }
>
>  static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
>  {
> -       block_t limit =3D min((sbi->user_block_count >> 3),
> +       block_t block_limit =3D min((sbi->user_block_count >> 3),
>                         sbi->user_block_count - sbi->reserved_blocks);
> +       block_t node_limit =3D sbi->total_node_count >> 3;
>
>         /* limit is 12.5% */
>         if (test_opt(sbi, RESERVE_ROOT) &&
> -                       F2FS_OPTION(sbi).root_reserved_blocks > limit) {
> -               F2FS_OPTION(sbi).root_reserved_blocks =3D limit;
> +                       F2FS_OPTION(sbi).root_reserved_blocks > block_lim=
it) {
> +               F2FS_OPTION(sbi).root_reserved_blocks =3D block_limit;
>                 f2fs_info(sbi, "Reduce reserved blocks for root =3D %u",
>                           F2FS_OPTION(sbi).root_reserved_blocks);
>         }
> -       if (!test_opt(sbi, RESERVE_ROOT) &&
> +       if (test_opt(sbi, RESERVE_NODE) &&
> +                       F2FS_OPTION(sbi).root_reserved_nodes > node_limit=
) {
> +               F2FS_OPTION(sbi).root_reserved_nodes =3D node_limit;
> +               f2fs_info(sbi, "Reduce reserved nodes for root =3D %u",
> +                         F2FS_OPTION(sbi).root_reserved_nodes);
> +       }
> +       if (!test_opt(sbi, RESERVE_ROOT) && !test_opt(sbi, RESERVE_NODE) =
&&
>                 (!uid_eq(F2FS_OPTION(sbi).s_resuid,
>                                 make_kuid(&init_user_ns, F2FS_DEF_RESUID)=
) ||
>                 !gid_eq(F2FS_OPTION(sbi).s_resgid,
>                                 make_kgid(&init_user_ns, F2FS_DEF_RESGID)=
)))
> -               f2fs_info(sbi, "Ignore s_resuid=3D%u, s_resgid=3D%u w/o r=
eserve_root",
> +               f2fs_info(sbi, "Ignore s_resuid=3D%u, s_resgid=3D%u w/o r=
eserve_root"
> +                               " and reserve_node",
>                           from_kuid_munged(&init_user_ns,
>                                            F2FS_OPTION(sbi).s_resuid),
>                           from_kgid_munged(&init_user_ns,
> @@ -841,6 +852,11 @@ static int f2fs_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
>                 F2FS_CTX_INFO(ctx).root_reserved_blocks =3D result.uint_3=
2;
>                 ctx->spec_mask |=3D F2FS_SPEC_reserve_root;
>                 break;
> +       case Opt_reserve_node:
> +               ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
> +               F2FS_CTX_INFO(ctx).root_reserved_nodes =3D result.uint_32=
;
> +               ctx->spec_mask |=3D F2FS_SPEC_reserve_node;
> +               break;
>         case Opt_resuid:
>                 F2FS_CTX_INFO(ctx).s_resuid =3D result.uid;
>                 ctx->spec_mask |=3D F2FS_SPEC_resuid;
> @@ -1424,6 +1440,14 @@ static int f2fs_check_opt_consistency(struct fs_co=
ntext *fc,
>                 ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
>                 ctx->opt_mask &=3D ~F2FS_MOUNT_RESERVE_ROOT;
>         }
> +       if (test_opt(sbi, RESERVE_NODE) &&
> +                       (ctx->opt_mask & F2FS_MOUNT_RESERVE_NODE) &&
> +                       ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_NODE)) {
> +               f2fs_info(sbi, "Preserve previous reserve_node=3D%u",
> +                       F2FS_OPTION(sbi).root_reserved_nodes);
> +               ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
> +               ctx->opt_mask &=3D ~F2FS_MOUNT_RESERVE_NODE;
> +       }
>
>         err =3D f2fs_check_test_dummy_encryption(fc, sb);
>         if (err)
> @@ -1623,6 +1647,9 @@ static void f2fs_apply_options(struct fs_context *f=
c, struct super_block *sb)
>         if (ctx->spec_mask & F2FS_SPEC_reserve_root)
>                 F2FS_OPTION(sbi).root_reserved_blocks =3D
>                                         F2FS_CTX_INFO(ctx).root_reserved_=
blocks;
> +       if (ctx->spec_mask & F2FS_SPEC_reserve_node)
> +               F2FS_OPTION(sbi).root_reserved_nodes =3D
> +                                       F2FS_CTX_INFO(ctx).root_reserved_=
nodes;
>         if (ctx->spec_mask & F2FS_SPEC_resgid)
>                 F2FS_OPTION(sbi).s_resgid =3D F2FS_CTX_INFO(ctx).s_resgid=
;
>         if (ctx->spec_mask & F2FS_SPEC_resuid)
> @@ -2342,9 +2369,11 @@ static int f2fs_show_options(struct seq_file *seq,=
 struct dentry *root)
>         else if (F2FS_OPTION(sbi).fs_mode =3D=3D FS_MODE_FRAGMENT_BLK)
>                 seq_puts(seq, "fragment:block");
>         seq_printf(seq, ",active_logs=3D%u", F2FS_OPTION(sbi).active_logs=
);
> -       if (test_opt(sbi, RESERVE_ROOT))
> -               seq_printf(seq, ",reserve_root=3D%u,resuid=3D%u,resgid=3D=
%u",
> +       if (test_opt(sbi, RESERVE_ROOT) || test_opt(sbi, RESERVE_NODE))
> +               seq_printf(seq, ",reserve_root=3D%u,reserve_node=3D%u,res=
uid=3D%u,"
> +                               "resgid=3D%u",
>                                 F2FS_OPTION(sbi).root_reserved_blocks,
> +                               F2FS_OPTION(sbi).root_reserved_nodes,
>                                 from_kuid_munged(&init_user_ns,
>                                         F2FS_OPTION(sbi).s_resuid),
>                                 from_kgid_munged(&init_user_ns,
> --
> 2.34.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

