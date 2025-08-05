Return-Path: <linux-kernel+bounces-756146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17188B1B089
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E90189941A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A04D2586C5;
	Tue,  5 Aug 2025 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHq4cxY7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483C257AF4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384195; cv=none; b=br2SKsswX8xDmIngoNe4zFuHbn+GE9viKXsRPbSI4O3AqULf7k0/GIF185Gh32eV2eNGj5jb1CBPZj7X9sj8t5UFtgr9gna6mslDq64+Q99xoAdCuxUcoCz8bhDUYxRm1pCww1HIdEvjIBLeixvDFp9dGmAHC+f+1srCTvxG+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384195; c=relaxed/simple;
	bh=9vjAPyfgh4NxdA5OBLaM7XfPba5k+3sWvZLcnao3/sc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kd1WYRTm3pH2yfBpL212JHrHnTBpLlooKMN0ldoA4PhBxqUj3CXnJnb1u+MhK+uNXMhCVM2wPhEkvVuV40bPIq2KrE70DdwTo0bAb7qedo9DV7sNJGGZfM/e5igMz6SusrVmVTIY+nj55NI7Hr5WYkx7GvL2arEd2+R1Dq4lroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHq4cxY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C7AC4CEF0;
	Tue,  5 Aug 2025 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754384194;
	bh=9vjAPyfgh4NxdA5OBLaM7XfPba5k+3sWvZLcnao3/sc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FHq4cxY7If6yBp8x+sSlXcTCT8pHiIN2lox/kp25zAFas6B5WDWH799C8A8svTc6H
	 alqlMc33THicxKy72S2M90qL8PMB9inECQKMSPy5Fg4+OUlVhSAYgEnqc/jO793KLy
	 ZSfL5DEAXR3LJhJq576oiXJ/ZJ4No2JW5IkDc6+TP1jlr9zIp+W57jIOlDcumVirON
	 crn8bRhAXJDSlmHVG/BFbusWyCJbeOkrP65YHvAJ72bDdL2h4zhTVMhad8rzHj1GkA
	 7E5rV7TalFOXUzmOwGsZbswswFdHdy0NG7xvL5H/E7UEi3ML5MMLtPWAzfiN3lk1ud
	 kuSnnbjQLv/lQ==
Message-ID: <ee0955ae-7d7a-40b7-8bae-f65ca56bd45c@kernel.org>
Date: Tue, 5 Aug 2025 16:56:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] f2fs: add reserved nodes for privileged users
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20250731075731.628454-1-guochunhai@vivo.com>
 <13bec8f2-8482-44f5-a7c6-db7cbde5173b@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <13bec8f2-8482-44f5-a7c6-db7cbde5173b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/25 16:46, Chao Yu wrote:
> On 7/31/25 15:57, Chunhai Guo wrote:
>> This patch allows privileged users to reserve nodes via the
>> 'reserve_node' mount option, which is similar to the existing
>> 'reserve_root' option.
>>
>> "-o reserve_node=<N>" means <N> nodes are reserved for privileged
>> users only.
>>
>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>> ---
>> v3->v4: Rebase this patch on https://lore.kernel.org/linux-f2fs-devel/20250731060338.1136086-1-chao@kernel.org
>> v2->v3: Apply Chao's suggestion from v2.
>> v1->v2: Add two missing handling parts.
>> v1: https://lore.kernel.org/linux-f2fs-devel/20250729095238.607433-1-guochunhai@vivo.com/
>> ---
>>  Documentation/filesystems/f2fs.rst |  9 ++++---
>>  fs/f2fs/f2fs.h                     | 14 +++++++---
>>  fs/f2fs/super.c                    | 43 +++++++++++++++++++++++++-----
>>  3 files changed, 52 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index 03b1efa6d3b2..95dbcd7ac9a8 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -173,9 +173,12 @@ data_flush		 Enable data flushing before checkpoint in order to
>>  			 persist data of regular and symlink.
>>  reserve_root=%d		 Support configuring reserved space which is used for
>>  			 allocation from a privileged user with specified uid or
>> -			 gid, unit: 4KB, the default limit is 0.2% of user blocks.
>> -resuid=%d		 The user ID which may use the reserved blocks.
>> -resgid=%d		 The group ID which may use the reserved blocks.
>> +			 gid, unit: 4KB, the default limit is 12.5% of user blocks.
>> +reserve_node=%d		 Support configuring reserved nodes which are used for
>> +			 allocation from a privileged user with specified uid or
>> +			 gid, the default limit is 12.5% of all nodes.
>> +resuid=%d		 The user ID which may use the reserved blocks and nodes.
>> +resgid=%d		 The group ID which may use the reserved blocks and nodes.
>>  fault_injection=%d	 Enable fault injection in all supported types with
>>  			 specified injection rate.
>>  fault_type=%d		 Support configuring fault injection type, should be
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index eb372af22edc..b9676ef16246 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -131,6 +131,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>>   * string rather than using the MS_LAZYTIME flag, so this must remain.
>>   */
>>  #define F2FS_MOUNT_LAZYTIME		0x40000000
>> +#define F2FS_MOUNT_RESERVE_NODE		0x80000000
>>  
>>  #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>>  #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
>> @@ -172,6 +173,7 @@ struct f2fs_rwsem {
>>  struct f2fs_mount_info {
>>  	unsigned int opt;
>>  	block_t root_reserved_blocks;	/* root reserved blocks */
>> +	block_t root_reserved_nodes;	/* root reserved nodes */
>>  	kuid_t s_resuid;		/* reserved blocks for uid */
>>  	kgid_t s_resgid;		/* reserved blocks for gid */
>>  	int active_logs;		/* # of active logs */
>> @@ -2355,7 +2357,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
>>  	return ofs == XATTR_NODE_OFFSET;
>>  }
>>  
>> -static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
>> +static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
>>  					struct inode *inode, bool cap)
>>  {
>>  	if (!inode)
>> @@ -2380,7 +2382,7 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
>>  	avail_user_block_count = sbi->user_block_count -
>>  					sbi->current_reserved_blocks;
>>  
>> -	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_blocks(sbi, inode, cap))
>> +	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
>>  		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
>>  
>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>> @@ -2738,7 +2740,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>  					struct inode *inode, bool is_inode)
>>  {
>>  	block_t	valid_block_count;
>> -	unsigned int valid_node_count;
>> +	unsigned int valid_node_count, avail_user_node_count;
>>  	unsigned int avail_user_block_count;
>>  	int err;
>>  
>> @@ -2767,8 +2769,12 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>  		goto enospc;
>>  	}
>>  
>> +	avail_user_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>> +	if (test_opt(sbi, RESERVE_NODE) &&
>> +			!__allow_reserved_root(sbi, inode, false))
> 
> Chunhai,
> 
> Do we need to pass cap=true to __allow_reserved_root()?
> 
> In addition, do we need to change cap as well for below statement?
> 
> avail_user_block_count = get_available_block_count(sbi, inode, false);

I meant something like this? not sure.

---
 fs/f2fs/f2fs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3804b70e5a28..d0aa5766ea66 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2805,7 +2805,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->stat_lock);

 	valid_block_count = sbi->total_valid_block_count + 1;
-	avail_user_block_count = get_available_block_count(sbi, inode, false);
+	avail_user_block_count = get_available_block_count(sbi, inode,
+				test_opt(sbi, RESERVE_NODE));

 	if (unlikely(valid_block_count > avail_user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
@@ -2814,7 +2815,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,

 	avail_user_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
 	if (test_opt(sbi, RESERVE_NODE) &&
-			!__allow_reserved_root(sbi, inode, false))
+			!__allow_reserved_root(sbi, inode, true))
 		avail_user_node_count -= F2FS_OPTION(sbi).root_reserved_nodes;
 	valid_node_count = sbi->total_valid_node_count + 1;
 	if (unlikely(valid_node_count > avail_user_node_count)) {
-- 
2.49.0

Thanks,

> 
> Thanks,
> 
>> +		avail_user_node_count -= F2FS_OPTION(sbi).root_reserved_nodes;
>>  	valid_node_count = sbi->total_valid_node_count + 1;
>> -	if (unlikely(valid_node_count > sbi->total_node_count)) {
>> +	if (unlikely(valid_node_count > avail_user_node_count)) {
>>  		spin_unlock(&sbi->stat_lock);
>>  		goto enospc;
>>  	}
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 30c038413040..a24e855a38ed 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -143,6 +143,7 @@ enum {
>>  	Opt_extent_cache,
>>  	Opt_data_flush,
>>  	Opt_reserve_root,
>> +	Opt_reserve_node,
>>  	Opt_resgid,
>>  	Opt_resuid,
>>  	Opt_mode,
>> @@ -265,6 +266,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
>>  	fsparam_flag_no("extent_cache", Opt_extent_cache),
>>  	fsparam_flag("data_flush", Opt_data_flush),
>>  	fsparam_u32("reserve_root", Opt_reserve_root),
>> +	fsparam_u32("reserve_node", Opt_reserve_node),
>>  	fsparam_gid("resgid", Opt_resgid),
>>  	fsparam_uid("resuid", Opt_resuid),
>>  	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
>> @@ -336,6 +338,7 @@ static match_table_t f2fs_checkpoint_tokens = {
>>  #define F2FS_SPEC_discard_unit			(1 << 21)
>>  #define F2FS_SPEC_memory_mode			(1 << 22)
>>  #define F2FS_SPEC_errors			(1 << 23)
>> +#define F2FS_SPEC_reserve_node			(1 << 24)
>>  
>>  struct f2fs_fs_context {
>>  	struct f2fs_mount_info info;
>> @@ -437,22 +440,30 @@ static void f2fs_destroy_casefold_cache(void) { }
>>  
>>  static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
>>  {
>> -	block_t limit = min((sbi->user_block_count >> 3),
>> +	block_t block_limit = min((sbi->user_block_count >> 3),
>>  			sbi->user_block_count - sbi->reserved_blocks);
>> +	block_t node_limit = sbi->total_node_count >> 3;
>>  
>>  	/* limit is 12.5% */
>>  	if (test_opt(sbi, RESERVE_ROOT) &&
>> -			F2FS_OPTION(sbi).root_reserved_blocks > limit) {
>> -		F2FS_OPTION(sbi).root_reserved_blocks = limit;
>> +			F2FS_OPTION(sbi).root_reserved_blocks > block_limit) {
>> +		F2FS_OPTION(sbi).root_reserved_blocks = block_limit;
>>  		f2fs_info(sbi, "Reduce reserved blocks for root = %u",
>>  			  F2FS_OPTION(sbi).root_reserved_blocks);
>>  	}
>> -	if (!test_opt(sbi, RESERVE_ROOT) &&
>> +	if (test_opt(sbi, RESERVE_NODE) &&
>> +			F2FS_OPTION(sbi).root_reserved_nodes > node_limit) {
>> +		F2FS_OPTION(sbi).root_reserved_nodes = node_limit;
>> +		f2fs_info(sbi, "Reduce reserved nodes for root = %u",
>> +			  F2FS_OPTION(sbi).root_reserved_nodes);
>> +	}
>> +	if (!test_opt(sbi, RESERVE_ROOT) && !test_opt(sbi, RESERVE_NODE) &&
>>  		(!uid_eq(F2FS_OPTION(sbi).s_resuid,
>>  				make_kuid(&init_user_ns, F2FS_DEF_RESUID)) ||
>>  		!gid_eq(F2FS_OPTION(sbi).s_resgid,
>>  				make_kgid(&init_user_ns, F2FS_DEF_RESGID))))
>> -		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root",
>> +		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root"
>> +				" and reserve_node",
>>  			  from_kuid_munged(&init_user_ns,
>>  					   F2FS_OPTION(sbi).s_resuid),
>>  			  from_kgid_munged(&init_user_ns,
>> @@ -841,6 +852,11 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>  		F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
>>  		ctx->spec_mask |= F2FS_SPEC_reserve_root;
>>  		break;
>> +	case Opt_reserve_node:
>> +		ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
>> +		F2FS_CTX_INFO(ctx).root_reserved_nodes = result.uint_32;
>> +		ctx->spec_mask |= F2FS_SPEC_reserve_node;
>> +		break;
>>  	case Opt_resuid:
>>  		F2FS_CTX_INFO(ctx).s_resuid = result.uid;
>>  		ctx->spec_mask |= F2FS_SPEC_resuid;
>> @@ -1424,6 +1440,14 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
>>  		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
>>  		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_ROOT;
>>  	}
>> +	if (test_opt(sbi, RESERVE_NODE) &&
>> +			(ctx->opt_mask & F2FS_MOUNT_RESERVE_NODE) &&
>> +			ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_NODE)) {
>> +		f2fs_info(sbi, "Preserve previous reserve_node=%u",
>> +			F2FS_OPTION(sbi).root_reserved_nodes);
>> +		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
>> +		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_NODE;
>> +	}
>>  
>>  	err = f2fs_check_test_dummy_encryption(fc, sb);
>>  	if (err)
>> @@ -1623,6 +1647,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
>>  	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
>>  		F2FS_OPTION(sbi).root_reserved_blocks =
>>  					F2FS_CTX_INFO(ctx).root_reserved_blocks;
>> +	if (ctx->spec_mask & F2FS_SPEC_reserve_node)
>> +		F2FS_OPTION(sbi).root_reserved_nodes =
>> +					F2FS_CTX_INFO(ctx).root_reserved_nodes;
>>  	if (ctx->spec_mask & F2FS_SPEC_resgid)
>>  		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
>>  	if (ctx->spec_mask & F2FS_SPEC_resuid)
>> @@ -2342,9 +2369,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>  	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
>>  		seq_puts(seq, "fragment:block");
>>  	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
>> -	if (test_opt(sbi, RESERVE_ROOT))
>> -		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
>> +	if (test_opt(sbi, RESERVE_ROOT) || test_opt(sbi, RESERVE_NODE))
>> +		seq_printf(seq, ",reserve_root=%u,reserve_node=%u,resuid=%u,"
>> +				"resgid=%u",
>>  				F2FS_OPTION(sbi).root_reserved_blocks,
>> +				F2FS_OPTION(sbi).root_reserved_nodes,
>>  				from_kuid_munged(&init_user_ns,
>>  					F2FS_OPTION(sbi).s_resuid),
>>  				from_kgid_munged(&init_user_ns,
> 


