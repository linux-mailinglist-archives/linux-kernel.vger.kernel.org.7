Return-Path: <linux-kernel+bounces-759607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3864B1E005
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8070D18990DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927F317BBF;
	Fri,  8 Aug 2025 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeAgkTt6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62448C0B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754614482; cv=none; b=Cz6qHhprFC/+7pkUE8oHUJHQk/rvJk8ZNFIla/bo82H4+1J5sro0I35MVfGj176ZQXNaN44YgWskiBks+ka4JtldUMo4d3CNIqNuCpxkFr8vF+kMU8IJlid0RObk/KHpUy17GQjbIsjIm5Yx0RZ0UrFcbsKWcZ6hMAiHt4kqL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754614482; c=relaxed/simple;
	bh=XHE3sd5GJvshRAI71pHWSRmcMcULrUsawebrIo8oXl8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nz75RPDr4ObISI9IC9JHj4IEO30dsk65ZWJ9Qb4BXMCEHmZpnYXYhk9cc5+O9xu3SqMOo0wxDefsgSPchVx7AKiJOjK9jJ8qyZdfL2fmFyvJCuwBM/hpU2WOYiFEsgJ9o99i9nk2mfc+UAcbF1+SfUd59SwthQ8mrBWC/BhrX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeAgkTt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAFEC4CEEB;
	Fri,  8 Aug 2025 00:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754614482;
	bh=XHE3sd5GJvshRAI71pHWSRmcMcULrUsawebrIo8oXl8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NeAgkTt6tEgdbFDR/rTXxflXN9+/7xrBtHa5eaEymB1QQIdO3pFXkHR/vXeBMa2ag
	 6lebaPf27dqjK2IUQo6cKwvNfKZ1yAPsbHwJzORCQbzJiTVqhFkuSeiIBtRf2jRuQT
	 1qOxvjuu7lfBfn60Ee+cusKNuLrpQYwErGW20pZvmgCL/seck5JpGLJtDAKd1kj3S+
	 D+N8qnvIKbvZVd0UgAxZOSptHjiwug9rae/A+PrE8XRM6KhAH+l546wqjtJEqMSGQE
	 ZWlzZdhsZwjVof9xo3zf7QEOkZZl2fLDy8sR0TaNv1foSzeX/6YQNEo+VM73GOsWqS
	 9l9UJRgMh+bGQ==
Message-ID: <6bd753f0-c498-409e-b39a-59eb8f66819a@kernel.org>
Date: Fri, 8 Aug 2025 08:54:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] f2fs: add reserved nodes for privileged users
To: Chunhai Guo <guochunhai@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250807133501.551848-1-guochunhai@vivo.com>
 <aJUvRjNZ124o-Quk@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aJUvRjNZ124o-Quk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Chunhai, can we test selinux case as well? It may need to revert selinux fix
to find out the problem scenario first.

Thanks,

On 2025/8/8 06:57, Jaegeuk Kim wrote:
> By the way, can we also add some testcases in xfstests to check all this
> works as intended?
> 
> On 08/07, Chunhai Guo wrote:
>> This patch allows privileged users to reserve nodes via the
>> 'reserve_node' mount option, which is similar to the existing
>> 'reserve_root' option.
>>
>> "-o reserve_node=<N>" means <N> nodes are reserved for privileged
>> users only.
>>
>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>> ---
>> v5->v6: Modified F2FS_SPEC_reserve_node from (1<<24) to (1<<25) following Zhiguo's suggestion in v5.
>> v4->v5: Apply Chao's suggestion from v4.
>> v3->v4: Rebase this patch on https://lore.kernel.org/linux-f2fs-devel/20250731060338.1136086-1-chao@kernel.org
>> v2->v3: Apply Chao's suggestion from v2.
>> v1->v2: Add two missing handling parts.
>> v1: https://lore.kernel.org/linux-f2fs-devel/20250729095238.607433-1-guochunhai@vivo.com/
>> ---
>>   Documentation/filesystems/f2fs.rst |  9 ++++---
>>   fs/f2fs/f2fs.h                     | 17 ++++++++----
>>   fs/f2fs/super.c                    | 43 +++++++++++++++++++++++++-----
>>   3 files changed, 54 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index 5cad369ceb92..e06cbb823bb7 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -173,9 +173,12 @@ data_flush		 Enable data flushing before checkpoint in order to
>>   			 persist data of regular and symlink.
>>   reserve_root=%d		 Support configuring reserved space which is used for
>>   			 allocation from a privileged user with specified uid or
>> -			 gid, unit: 4KB, the default limit is 0.2% of user blocks.
>> -resuid=%d		 The user ID which may use the reserved blocks.
>> -resgid=%d		 The group ID which may use the reserved blocks.
>> +			 gid, unit: 4KB, the default limit is 12.5% of user blocks.
>> +reserve_node=%d		 Support configuring reserved nodes which are used for
>> +			 allocation from a privileged user with specified uid or
>> +			 gid, the default limit is 12.5% of all nodes.
>> +resuid=%d		 The user ID which may use the reserved blocks and nodes.
>> +resgid=%d		 The group ID which may use the reserved blocks and nodes.
>>   fault_injection=%d	 Enable fault injection in all supported types with
>>   			 specified injection rate.
>>   fault_type=%d		 Support configuring fault injection type, should be
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index f19472eb2789..047964d66736 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -131,6 +131,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>>    * string rather than using the MS_LAZYTIME flag, so this must remain.
>>    */
>>   #define F2FS_MOUNT_LAZYTIME		0x40000000
>> +#define F2FS_MOUNT_RESERVE_NODE		0x80000000
>>   
>>   #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>>   #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
>> @@ -178,6 +179,7 @@ struct f2fs_rwsem {
>>   struct f2fs_mount_info {
>>   	unsigned int opt;
>>   	block_t root_reserved_blocks;	/* root reserved blocks */
>> +	block_t root_reserved_nodes;	/* root reserved nodes */
>>   	kuid_t s_resuid;		/* reserved blocks for uid */
>>   	kgid_t s_resgid;		/* reserved blocks for gid */
>>   	int active_logs;		/* # of active logs */
>> @@ -2407,7 +2409,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
>>   	return ofs == XATTR_NODE_OFFSET;
>>   }
>>   
>> -static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
>> +static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
>>   					struct inode *inode, bool cap)
>>   {
>>   	if (!inode)
>> @@ -2432,7 +2434,7 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
>>   	avail_user_block_count = sbi->user_block_count -
>>   					sbi->current_reserved_blocks;
>>   
>> -	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_blocks(sbi, inode, cap))
>> +	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
>>   		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
>>   
>>   	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>> @@ -2790,7 +2792,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>   					struct inode *inode, bool is_inode)
>>   {
>>   	block_t	valid_block_count;
>> -	unsigned int valid_node_count;
>> +	unsigned int valid_node_count, avail_user_node_count;
>>   	unsigned int avail_user_block_count;
>>   	int err;
>>   
>> @@ -2812,15 +2814,20 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>   	spin_lock(&sbi->stat_lock);
>>   
>>   	valid_block_count = sbi->total_valid_block_count + 1;
>> -	avail_user_block_count = get_available_block_count(sbi, inode, false);
>> +	avail_user_block_count = get_available_block_count(sbi, inode,
>> +			test_opt(sbi, RESERVE_NODE));
>>   
>>   	if (unlikely(valid_block_count > avail_user_block_count)) {
>>   		spin_unlock(&sbi->stat_lock);
>>   		goto enospc;
>>   	}
>>   
>> +	avail_user_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>> +	if (test_opt(sbi, RESERVE_NODE) &&
>> +			!__allow_reserved_root(sbi, inode, true))
>> +		avail_user_node_count -= F2FS_OPTION(sbi).root_reserved_nodes;
>>   	valid_node_count = sbi->total_valid_node_count + 1;
>> -	if (unlikely(valid_node_count > sbi->total_node_count)) {
>> +	if (unlikely(valid_node_count > avail_user_node_count)) {
>>   		spin_unlock(&sbi->stat_lock);
>>   		goto enospc;
>>   	}
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 3f8bc42e0968..f37004780ce0 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -143,6 +143,7 @@ enum {
>>   	Opt_extent_cache,
>>   	Opt_data_flush,
>>   	Opt_reserve_root,
>> +	Opt_reserve_node,
>>   	Opt_resgid,
>>   	Opt_resuid,
>>   	Opt_mode,
>> @@ -273,6 +274,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
>>   	fsparam_flag_no("extent_cache", Opt_extent_cache),
>>   	fsparam_flag("data_flush", Opt_data_flush),
>>   	fsparam_u32("reserve_root", Opt_reserve_root),
>> +	fsparam_u32("reserve_node", Opt_reserve_node),
>>   	fsparam_gid("resgid", Opt_resgid),
>>   	fsparam_uid("resuid", Opt_resuid),
>>   	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
>> @@ -346,6 +348,7 @@ static match_table_t f2fs_checkpoint_tokens = {
>>   #define F2FS_SPEC_memory_mode			(1 << 22)
>>   #define F2FS_SPEC_errors			(1 << 23)
>>   #define F2FS_SPEC_lookup_mode			(1 << 24)
>> +#define F2FS_SPEC_reserve_node			(1 << 25)
>>   
>>   struct f2fs_fs_context {
>>   	struct f2fs_mount_info info;
>> @@ -447,22 +450,30 @@ static void f2fs_destroy_casefold_cache(void) { }
>>   
>>   static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
>>   {
>> -	block_t limit = min((sbi->user_block_count >> 3),
>> +	block_t block_limit = min((sbi->user_block_count >> 3),
>>   			sbi->user_block_count - sbi->reserved_blocks);
>> +	block_t node_limit = sbi->total_node_count >> 3;
>>   
>>   	/* limit is 12.5% */
>>   	if (test_opt(sbi, RESERVE_ROOT) &&
>> -			F2FS_OPTION(sbi).root_reserved_blocks > limit) {
>> -		F2FS_OPTION(sbi).root_reserved_blocks = limit;
>> +			F2FS_OPTION(sbi).root_reserved_blocks > block_limit) {
>> +		F2FS_OPTION(sbi).root_reserved_blocks = block_limit;
>>   		f2fs_info(sbi, "Reduce reserved blocks for root = %u",
>>   			  F2FS_OPTION(sbi).root_reserved_blocks);
>>   	}
>> -	if (!test_opt(sbi, RESERVE_ROOT) &&
>> +	if (test_opt(sbi, RESERVE_NODE) &&
>> +			F2FS_OPTION(sbi).root_reserved_nodes > node_limit) {
>> +		F2FS_OPTION(sbi).root_reserved_nodes = node_limit;
>> +		f2fs_info(sbi, "Reduce reserved nodes for root = %u",
>> +			  F2FS_OPTION(sbi).root_reserved_nodes);
>> +	}
>> +	if (!test_opt(sbi, RESERVE_ROOT) && !test_opt(sbi, RESERVE_NODE) &&
>>   		(!uid_eq(F2FS_OPTION(sbi).s_resuid,
>>   				make_kuid(&init_user_ns, F2FS_DEF_RESUID)) ||
>>   		!gid_eq(F2FS_OPTION(sbi).s_resgid,
>>   				make_kgid(&init_user_ns, F2FS_DEF_RESGID))))
>> -		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root",
>> +		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root"
>> +				" and reserve_node",
>>   			  from_kuid_munged(&init_user_ns,
>>   					   F2FS_OPTION(sbi).s_resuid),
>>   			  from_kgid_munged(&init_user_ns,
>> @@ -851,6 +862,11 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>   		F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
>>   		ctx->spec_mask |= F2FS_SPEC_reserve_root;
>>   		break;
>> +	case Opt_reserve_node:
>> +		ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
>> +		F2FS_CTX_INFO(ctx).root_reserved_nodes = result.uint_32;
>> +		ctx->spec_mask |= F2FS_SPEC_reserve_node;
>> +		break;
>>   	case Opt_resuid:
>>   		F2FS_CTX_INFO(ctx).s_resuid = result.uid;
>>   		ctx->spec_mask |= F2FS_SPEC_resuid;
>> @@ -1438,6 +1454,14 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
>>   		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
>>   		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_ROOT;
>>   	}
>> +	if (test_opt(sbi, RESERVE_NODE) &&
>> +			(ctx->opt_mask & F2FS_MOUNT_RESERVE_NODE) &&
>> +			ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_NODE)) {
>> +		f2fs_info(sbi, "Preserve previous reserve_node=%u",
>> +			F2FS_OPTION(sbi).root_reserved_nodes);
>> +		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
>> +		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_NODE;
>> +	}
>>   
>>   	err = f2fs_check_test_dummy_encryption(fc, sb);
>>   	if (err)
>> @@ -1637,6 +1661,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
>>   	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
>>   		F2FS_OPTION(sbi).root_reserved_blocks =
>>   					F2FS_CTX_INFO(ctx).root_reserved_blocks;
>> +	if (ctx->spec_mask & F2FS_SPEC_reserve_node)
>> +		F2FS_OPTION(sbi).root_reserved_nodes =
>> +					F2FS_CTX_INFO(ctx).root_reserved_nodes;
>>   	if (ctx->spec_mask & F2FS_SPEC_resgid)
>>   		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
>>   	if (ctx->spec_mask & F2FS_SPEC_resuid)
>> @@ -2359,9 +2386,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>   	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
>>   		seq_puts(seq, "fragment:block");
>>   	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
>> -	if (test_opt(sbi, RESERVE_ROOT))
>> -		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
>> +	if (test_opt(sbi, RESERVE_ROOT) || test_opt(sbi, RESERVE_NODE))
>> +		seq_printf(seq, ",reserve_root=%u,reserve_node=%u,resuid=%u,"
>> +				"resgid=%u",
>>   				F2FS_OPTION(sbi).root_reserved_blocks,
>> +				F2FS_OPTION(sbi).root_reserved_nodes,
>>   				from_kuid_munged(&init_user_ns,
>>   					F2FS_OPTION(sbi).s_resuid),
>>   				from_kgid_munged(&init_user_ns,
>> -- 
>> 2.34.1


