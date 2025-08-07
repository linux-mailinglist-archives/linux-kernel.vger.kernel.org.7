Return-Path: <linux-kernel+bounces-759581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8DEB1DF7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 00:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6973AD08B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180C238174;
	Thu,  7 Aug 2025 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYyd6Z2P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682AA1E520E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754607432; cv=none; b=cPCrh1W8EoYV6iIksLD3oRg07w6TtFXGEGLBpqm7RJ66Axl3LviTg8BX4lK08gzVu0XhcF9i1XL9n+Xsp+qGhCN7Rmy8rsbWJa2cLP/c9vFCq7DfwV2Uh5FUGCorUvESuxycT+rOKtjNqhVEQNHsc6AvzgshTEJUY+lvBqEDuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754607432; c=relaxed/simple;
	bh=c8duk4lraiBt/JWLIRh8rR4h2Qs+lHhpdIDqCzZilBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp+X6W+mEt9Dy+4dxxWJs3iFMPFx0c0ezwZoj3xO0SZ4r14cv0U116rdxsecXlgVZRYRlbZYvByH/K52mJwQV5iKCcaPBFpzn0xyH7n43VdJd0KptpVeBpwAnQF69QPiCJRUXCN8HaTJE+46RJypu3PEQD4reIUYgMOWFZvD33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYyd6Z2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA189C4CEEB;
	Thu,  7 Aug 2025 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754607432;
	bh=c8duk4lraiBt/JWLIRh8rR4h2Qs+lHhpdIDqCzZilBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYyd6Z2PmYdU5EfQLe2Hc6hQ4YbnHzBaYL+cxlh2swCCvGXc6nt8LUQsPI+IPOnuL
	 BC7caO1ePbookhOsx6M5cFZrnhcIPEWLmjgGb2F9Cng+CaUO72Y9nvUHz0WJZwHia1
	 IMz8GFLrg84gEOvObk0RAAvHGBlYvvEbJhyfW53wk6QKX6PVaJwco/WqLobkmddrM8
	 4fFqJrbsFtS+gwyo2dzvLnz77LymkX6FrQ78B9b/uG9rp85lGGD/RHn0xNz53BepQE
	 TggYxTYQ/tNTUDkb48EYh59dmvnumS+nmxZwAtYJioHwdzaOc5XCH6mlDwKCwX1vsa
	 e+aP2qqTU6vWg==
Date: Thu, 7 Aug 2025 22:57:10 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chunhai Guo <guochunhai@vivo.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] f2fs: add reserved nodes for privileged users
Message-ID: <aJUvRjNZ124o-Quk@google.com>
References: <20250807133501.551848-1-guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807133501.551848-1-guochunhai@vivo.com>

By the way, can we also add some testcases in xfstests to check all this
works as intended?

On 08/07, Chunhai Guo wrote:
> This patch allows privileged users to reserve nodes via the
> 'reserve_node' mount option, which is similar to the existing
> 'reserve_root' option.
> 
> "-o reserve_node=<N>" means <N> nodes are reserved for privileged
> users only.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v5->v6: Modified F2FS_SPEC_reserve_node from (1<<24) to (1<<25) following Zhiguo's suggestion in v5.
> v4->v5: Apply Chao's suggestion from v4.
> v3->v4: Rebase this patch on https://lore.kernel.org/linux-f2fs-devel/20250731060338.1136086-1-chao@kernel.org
> v2->v3: Apply Chao's suggestion from v2.
> v1->v2: Add two missing handling parts.
> v1: https://lore.kernel.org/linux-f2fs-devel/20250729095238.607433-1-guochunhai@vivo.com/
> ---
>  Documentation/filesystems/f2fs.rst |  9 ++++---
>  fs/f2fs/f2fs.h                     | 17 ++++++++----
>  fs/f2fs/super.c                    | 43 +++++++++++++++++++++++++-----
>  3 files changed, 54 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 5cad369ceb92..e06cbb823bb7 100644
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
> index f19472eb2789..047964d66736 100644
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
> @@ -178,6 +179,7 @@ struct f2fs_rwsem {
>  struct f2fs_mount_info {
>  	unsigned int opt;
>  	block_t root_reserved_blocks;	/* root reserved blocks */
> +	block_t root_reserved_nodes;	/* root reserved nodes */
>  	kuid_t s_resuid;		/* reserved blocks for uid */
>  	kgid_t s_resgid;		/* reserved blocks for gid */
>  	int active_logs;		/* # of active logs */
> @@ -2407,7 +2409,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
>  	return ofs == XATTR_NODE_OFFSET;
>  }
>  
> -static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
> +static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
>  					struct inode *inode, bool cap)
>  {
>  	if (!inode)
> @@ -2432,7 +2434,7 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
>  	avail_user_block_count = sbi->user_block_count -
>  					sbi->current_reserved_blocks;
>  
> -	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_blocks(sbi, inode, cap))
> +	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
>  		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> @@ -2790,7 +2792,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  					struct inode *inode, bool is_inode)
>  {
>  	block_t	valid_block_count;
> -	unsigned int valid_node_count;
> +	unsigned int valid_node_count, avail_user_node_count;
>  	unsigned int avail_user_block_count;
>  	int err;
>  
> @@ -2812,15 +2814,20 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  	spin_lock(&sbi->stat_lock);
>  
>  	valid_block_count = sbi->total_valid_block_count + 1;
> -	avail_user_block_count = get_available_block_count(sbi, inode, false);
> +	avail_user_block_count = get_available_block_count(sbi, inode,
> +			test_opt(sbi, RESERVE_NODE));
>  
>  	if (unlikely(valid_block_count > avail_user_block_count)) {
>  		spin_unlock(&sbi->stat_lock);
>  		goto enospc;
>  	}
>  
> +	avail_user_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
> +	if (test_opt(sbi, RESERVE_NODE) &&
> +			!__allow_reserved_root(sbi, inode, true))
> +		avail_user_node_count -= F2FS_OPTION(sbi).root_reserved_nodes;
>  	valid_node_count = sbi->total_valid_node_count + 1;
> -	if (unlikely(valid_node_count > sbi->total_node_count)) {
> +	if (unlikely(valid_node_count > avail_user_node_count)) {
>  		spin_unlock(&sbi->stat_lock);
>  		goto enospc;
>  	}
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3f8bc42e0968..f37004780ce0 100644
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
> @@ -273,6 +274,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
>  	fsparam_flag_no("extent_cache", Opt_extent_cache),
>  	fsparam_flag("data_flush", Opt_data_flush),
>  	fsparam_u32("reserve_root", Opt_reserve_root),
> +	fsparam_u32("reserve_node", Opt_reserve_node),
>  	fsparam_gid("resgid", Opt_resgid),
>  	fsparam_uid("resuid", Opt_resuid),
>  	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
> @@ -346,6 +348,7 @@ static match_table_t f2fs_checkpoint_tokens = {
>  #define F2FS_SPEC_memory_mode			(1 << 22)
>  #define F2FS_SPEC_errors			(1 << 23)
>  #define F2FS_SPEC_lookup_mode			(1 << 24)
> +#define F2FS_SPEC_reserve_node			(1 << 25)
>  
>  struct f2fs_fs_context {
>  	struct f2fs_mount_info info;
> @@ -447,22 +450,30 @@ static void f2fs_destroy_casefold_cache(void) { }
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
> @@ -851,6 +862,11 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
> @@ -1438,6 +1454,14 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
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
> @@ -1637,6 +1661,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
>  	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
>  		F2FS_OPTION(sbi).root_reserved_blocks =
>  					F2FS_CTX_INFO(ctx).root_reserved_blocks;
> +	if (ctx->spec_mask & F2FS_SPEC_reserve_node)
> +		F2FS_OPTION(sbi).root_reserved_nodes =
> +					F2FS_CTX_INFO(ctx).root_reserved_nodes;
>  	if (ctx->spec_mask & F2FS_SPEC_resgid)
>  		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
>  	if (ctx->spec_mask & F2FS_SPEC_resuid)
> @@ -2359,9 +2386,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
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
> -- 
> 2.34.1

