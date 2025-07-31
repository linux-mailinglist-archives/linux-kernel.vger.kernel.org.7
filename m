Return-Path: <linux-kernel+bounces-751530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C848EB16A99
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D24173A80
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9320E702;
	Thu, 31 Jul 2025 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/heq9cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF815383A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930608; cv=none; b=tU6NkXJH41SgjLsvCJqIMEuDSzBv7OChiho5pQF9X6tZT9CgjuLsKx+a/f5YSubAZIfFojj5sKsxhNbWFUQv7hbiMfrd+OoeGCK051Df8TBQopPb97RKY3iQe+R+phtwUfRSvaxAMZMgTMuBXCB7u71JpxssaaISdQqpAg/w90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930608; c=relaxed/simple;
	bh=oo7rQERvLXJ+qXxeAvJHTDBIvLuAcldgZkVC342F380=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jhh8peXg4UjgIGvEkf+WZp9Bd3HS8CbqWWMfVnw0TkMtjQQtienrTaN2x4+MdHqK7KbeZQROa+hgLGwQj+c/VsJBWznoUQ8etO4EWU4/nuWdZq8ZjDBiXRAaQesD/nCpvsQ2if6NtZYF33zfC5D4O0U9qvbqswUbo3G91Y/6wA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/heq9cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B805C4CEE7;
	Thu, 31 Jul 2025 02:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753930607;
	bh=oo7rQERvLXJ+qXxeAvJHTDBIvLuAcldgZkVC342F380=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=d/heq9cva3KCSUH8/tE1oOcI4Tu2iQR0JdrkGHDPDKhQK6KGLogMQF6aRERdQY6Xm
	 6uW0fKIQWwnpla4EfA090BoDrochxF7oVEFR/k9/B20rC0fcg5L4QXWsJsS4PkKyiI
	 hA2yOLuHF+SFqu4S6cEuhY5M98HD32vzMEzd6+kT8O/OgM/huwfZTKW9erEEt8OfLr
	 21JFiBph5xzAzrhUApitSPSI16ST49a0x8yCAUO/uw1SWLXF+kfUq6AKS0i3OIMSEa
	 boXrVXmwOle1fz4tAUi2jgtB4KxZtWC/XNWBfxywqAnoxufM651huMmaXzM02dajMx
	 CjIj57vkHFqEQ==
Message-ID: <526cac92-29eb-42a4-bf56-220e3b1f7c0c@kernel.org>
Date: Thu, 31 Jul 2025 10:56:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: add reserved nodes for privileged users
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20250730141540.603144-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250730141540.603144-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 22:15, Chunhai Guo wrote:
> This patch allows privileged users to reserve nodes via the
> 'reserve_node' mount option, which is similar to the existing
> 'reserve_root' option.
> 
> "-o reserve_node=<N>" means <N> nodes are reserved for privileged
> users only.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v2->v3: Apply Chao's suggestion from v2.
> v1->v2: Add two missing handling parts.
> v1: https://lore.kernel.org/linux-f2fs-devel/20250729095238.607433-1-guochunhai@vivo.com/
> ---
>  Documentation/filesystems/f2fs.rst |  9 ++++---
>  fs/f2fs/f2fs.h                     | 17 +++++++-----
>  fs/f2fs/super.c                    | 43 +++++++++++++++++++++++++-----
>  3 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 03b1efa6d3b2..95dbcd7ac9a8 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -173,9 +173,12 @@ data_flush		 Enable data flushing before checkpoint in order to
>  			 persist data of regular and symlink.
>  reserve_root=%d		 Support configuring reserved space which is used for
>  			 allocation from a privileged user with specified uid or
> -			 gid, unit: 4KB, the default limit is 0.2% of user blocks.
> -resuid=%d		 The user ID which may use the reserved blocks.
> -resgid=%d		 The group ID which may use the reserved blocks.
> +			 gid, unit: 4KB, the default limit is 12.5% of user blocks.
> +reserve_node=%d		 Support configuring reserved nodes which are used for
> +			 allocation from a privileged user with specified uid or
> +			 gid, the default limit is 12.5% of all nodes.
> +resuid=%d		 The user ID which may use the reserved blocks and nodes.
> +resgid=%d		 The group ID which may use the reserved blocks and nodes.
>  fault_injection=%d	 Enable fault injection in all supported types with
>  			 specified injection rate.
>  fault_type=%d		 Support configuring fault injection type, should be
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 97c1a2a3fbd7..70f32c118dac 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -131,6 +131,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>   * string rather than using the MS_LAZYTIME flag, so this must remain.
>   */
>  #define F2FS_MOUNT_LAZYTIME		0x40000000
> +#define F2FS_MOUNT_RESERVE_NODE		0x80000000
>  
>  #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>  #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
> @@ -172,6 +173,7 @@ struct f2fs_rwsem {
>  struct f2fs_mount_info {
>  	unsigned int opt;
>  	block_t root_reserved_blocks;	/* root reserved blocks */
> +	block_t root_reserved_nodes;	/* root reserved nodes */
>  	kuid_t s_resuid;		/* reserved blocks for uid */
>  	kgid_t s_resgid;		/* reserved blocks for gid */
>  	int active_logs;		/* # of active logs */
> @@ -2355,13 +2357,11 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
>  	return ofs == XATTR_NODE_OFFSET;
>  }
>  
> -static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
> +static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
>  					struct inode *inode, bool cap)
>  {
>  	if (!inode)
>  		return true;
> -	if (!test_opt(sbi, RESERVE_ROOT))
> -		return false;

Oh, I just notice this condition is wrong, let me submit a patch
to fix this, as I hope it can go into stable correctly.

Thanks,

>  	if (IS_NOQUOTA(inode))
>  		return true;
>  	if (uid_eq(F2FS_OPTION(sbi).s_resuid, current_fsuid()))
> @@ -2382,7 +2382,8 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
>  	avail_user_block_count = sbi->user_block_count -
>  					sbi->current_reserved_blocks;
>  
> -	if (!__allow_reserved_blocks(sbi, inode, cap))
> +	if (test_opt(sbi, RESERVE_ROOT) &&
> +			!__allow_reserved_root(sbi, inode, cap))
>  		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> @@ -2740,7 +2741,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  					struct inode *inode, bool is_inode)
>  {
>  	block_t	valid_block_count;
> -	unsigned int valid_node_count;
> +	unsigned int valid_node_count, avail_user_node_count;
>  	unsigned int avail_user_block_count;
>  	int err;
>  
> @@ -2769,8 +2770,12 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  		goto enospc;
>  	}
>  
> +	avail_user_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
> +	if (test_opt(sbi, RESERVE_NODE) &&
> +			!__allow_reserved_root(sbi, inode, false))
> +		avail_user_node_count -= F2FS_OPTION(sbi).root_reserved_nodes;
>  	valid_node_count = sbi->total_valid_node_count + 1;
> -	if (unlikely(valid_node_count > sbi->total_node_count)) {
> +	if (unlikely(valid_node_count > avail_user_node_count)) {
>  		spin_unlock(&sbi->stat_lock);
>  		goto enospc;
>  	}
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 30c038413040..a24e855a38ed 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -143,6 +143,7 @@ enum {
>  	Opt_extent_cache,
>  	Opt_data_flush,
>  	Opt_reserve_root,
> +	Opt_reserve_node,
>  	Opt_resgid,
>  	Opt_resuid,
>  	Opt_mode,
> @@ -265,6 +266,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
>  	fsparam_flag_no("extent_cache", Opt_extent_cache),
>  	fsparam_flag("data_flush", Opt_data_flush),
>  	fsparam_u32("reserve_root", Opt_reserve_root),
> +	fsparam_u32("reserve_node", Opt_reserve_node),
>  	fsparam_gid("resgid", Opt_resgid),
>  	fsparam_uid("resuid", Opt_resuid),
>  	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
> @@ -336,6 +338,7 @@ static match_table_t f2fs_checkpoint_tokens = {
>  #define F2FS_SPEC_discard_unit			(1 << 21)
>  #define F2FS_SPEC_memory_mode			(1 << 22)
>  #define F2FS_SPEC_errors			(1 << 23)
> +#define F2FS_SPEC_reserve_node			(1 << 24)
>  
>  struct f2fs_fs_context {
>  	struct f2fs_mount_info info;
> @@ -437,22 +440,30 @@ static void f2fs_destroy_casefold_cache(void) { }
>  
>  static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
>  {
> -	block_t limit = min((sbi->user_block_count >> 3),
> +	block_t block_limit = min((sbi->user_block_count >> 3),
>  			sbi->user_block_count - sbi->reserved_blocks);
> +	block_t node_limit = sbi->total_node_count >> 3;
>  
>  	/* limit is 12.5% */
>  	if (test_opt(sbi, RESERVE_ROOT) &&
> -			F2FS_OPTION(sbi).root_reserved_blocks > limit) {
> -		F2FS_OPTION(sbi).root_reserved_blocks = limit;
> +			F2FS_OPTION(sbi).root_reserved_blocks > block_limit) {
> +		F2FS_OPTION(sbi).root_reserved_blocks = block_limit;
>  		f2fs_info(sbi, "Reduce reserved blocks for root = %u",
>  			  F2FS_OPTION(sbi).root_reserved_blocks);
>  	}
> -	if (!test_opt(sbi, RESERVE_ROOT) &&
> +	if (test_opt(sbi, RESERVE_NODE) &&
> +			F2FS_OPTION(sbi).root_reserved_nodes > node_limit) {
> +		F2FS_OPTION(sbi).root_reserved_nodes = node_limit;
> +		f2fs_info(sbi, "Reduce reserved nodes for root = %u",
> +			  F2FS_OPTION(sbi).root_reserved_nodes);
> +	}
> +	if (!test_opt(sbi, RESERVE_ROOT) && !test_opt(sbi, RESERVE_NODE) &&
>  		(!uid_eq(F2FS_OPTION(sbi).s_resuid,
>  				make_kuid(&init_user_ns, F2FS_DEF_RESUID)) ||
>  		!gid_eq(F2FS_OPTION(sbi).s_resgid,
>  				make_kgid(&init_user_ns, F2FS_DEF_RESGID))))
> -		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root",
> +		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root"
> +				" and reserve_node",
>  			  from_kuid_munged(&init_user_ns,
>  					   F2FS_OPTION(sbi).s_resuid),
>  			  from_kgid_munged(&init_user_ns,
> @@ -841,6 +852,11 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
>  		ctx->spec_mask |= F2FS_SPEC_reserve_root;
>  		break;
> +	case Opt_reserve_node:
> +		ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
> +		F2FS_CTX_INFO(ctx).root_reserved_nodes = result.uint_32;
> +		ctx->spec_mask |= F2FS_SPEC_reserve_node;
> +		break;
>  	case Opt_resuid:
>  		F2FS_CTX_INFO(ctx).s_resuid = result.uid;
>  		ctx->spec_mask |= F2FS_SPEC_resuid;
> @@ -1424,6 +1440,14 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
>  		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
>  		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_ROOT;
>  	}
> +	if (test_opt(sbi, RESERVE_NODE) &&
> +			(ctx->opt_mask & F2FS_MOUNT_RESERVE_NODE) &&
> +			ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_NODE)) {
> +		f2fs_info(sbi, "Preserve previous reserve_node=%u",
> +			F2FS_OPTION(sbi).root_reserved_nodes);
> +		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
> +		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_NODE;
> +	}
>  
>  	err = f2fs_check_test_dummy_encryption(fc, sb);
>  	if (err)
> @@ -1623,6 +1647,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
>  	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
>  		F2FS_OPTION(sbi).root_reserved_blocks =
>  					F2FS_CTX_INFO(ctx).root_reserved_blocks;
> +	if (ctx->spec_mask & F2FS_SPEC_reserve_node)
> +		F2FS_OPTION(sbi).root_reserved_nodes =
> +					F2FS_CTX_INFO(ctx).root_reserved_nodes;
>  	if (ctx->spec_mask & F2FS_SPEC_resgid)
>  		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
>  	if (ctx->spec_mask & F2FS_SPEC_resuid)
> @@ -2342,9 +2369,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
>  		seq_puts(seq, "fragment:block");
>  	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
> -	if (test_opt(sbi, RESERVE_ROOT))
> -		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
> +	if (test_opt(sbi, RESERVE_ROOT) || test_opt(sbi, RESERVE_NODE))
> +		seq_printf(seq, ",reserve_root=%u,reserve_node=%u,resuid=%u,"
> +				"resgid=%u",
>  				F2FS_OPTION(sbi).root_reserved_blocks,
> +				F2FS_OPTION(sbi).root_reserved_nodes,
>  				from_kuid_munged(&init_user_ns,
>  					F2FS_OPTION(sbi).s_resuid),
>  				from_kgid_munged(&init_user_ns,


