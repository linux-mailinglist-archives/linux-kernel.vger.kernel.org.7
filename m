Return-Path: <linux-kernel+bounces-755966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72926B1AE28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD3A3AC1A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B321A454;
	Tue,  5 Aug 2025 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OteCcpZ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC08186294
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374937; cv=none; b=ukSXjPYSlBQrUbiiQZT1oiZC0UtgrUsxzdm0/OkbafDnlYbNP8aFgxACJLyHCrgx0hmPf6sVfd4LnuSaMswGP7r+EIdT3R140D03bPRnpDpJkpaup0vSYRvK/9eOQQdVz74eEkFri9vj08G9zgzUZUMSuof/WpjPZ7Pf06bVsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374937; c=relaxed/simple;
	bh=6uLVdU8+uyFZR8v0+QdDzKXZRemfEYYr4oJg7JUG+UY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lf9N1Grgv2PtyEpBf/VwlAvylBnz0ESe+XmRBkhPwXsO4UH4PZFtRdvsP1ZJjsnt4/eqhFZ+ujDJENk/R4d8i/cmX8xQWcxsATEnQvU+4wEk7TBFLPyDYWaUg0RIGdoCpZL5UpiJGnXCA3Ua3O4ZH4BoxaYRksq/t1Ws4Fs07hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OteCcpZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0252C4CEF4;
	Tue,  5 Aug 2025 06:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754374936;
	bh=6uLVdU8+uyFZR8v0+QdDzKXZRemfEYYr4oJg7JUG+UY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=OteCcpZ7cdWQLhfYLalP5SwsMO2Tf0LidHI+1mXrtwGzEEClCxlbRD5oBMEEufxp2
	 26wDR1s871RS4J+qW1J+VYVo2p/Uv2I+0D/U+RZK62pO+/6Td6+z3Psny3oA7TDuPn
	 vlrHA6kFiDvDMcp8RcAcDBfo8kU2SQWlGGIsJYJs0uJzC8RevyFT6IBpYhS+PnWXS7
	 IGg7e8roTqV7IJgi0hHGVR9iFQJI1F4uunUINNhxHcO5PCAoinI/cSagWXlCWVz6zp
	 WyHjtU4Aveo+t2jBxnHgyuqQVUvlQDKxqSm+wNmPsdM9kS3LB5pNureafn/8Bka1FA
	 hEj95M1rfIxag==
Message-ID: <c3ec89a5-5eb5-4358-92eb-27c9406027a2@kernel.org>
Date: Tue, 5 Aug 2025 14:22:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] f2fs: add lookup_mode mount option
To: Daniel Lee <chullee@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250804230558.746338-1-chullee@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250804230558.746338-1-chullee@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 07:05, Daniel Lee wrote:
> For casefolded directories, f2fs may fall back to a linear search if
> a hash-based lookup fails. This can cause severe performance
> regressions.
> 
> While this behavior can be controlled by userspace tools (e.g. mkfs,
> fsck) by setting an on-disk flag, a kernel-level solution is needed
> to guarantee the lookup behavior regardless of the on-disk state.
> 
> This commit introduces the 'lookup_mode' mount option to provide this
> kernel-side control.
> 
> The option accepts three values:
> - perf: (Default) Enforces a hash-only lookup. The linear fallback
>   is always disabled.
> - compat: Enables the linear search fallback for compatibility with
>   directory entries from older kernels.
> - auto: Determines the mode based on the on-disk flag, preserving the
>   userspace-based behavior.
> 
> Signed-off-by: Daniel Lee <chullee@google.com>
> ---
> v2:
> - rework mount option parsing to use the new mount API.
> - add lookup_mode field to struct f2fs_mount_info.
> - add show_options support for the new option.
>  Documentation/filesystems/f2fs.rst | 19 +++++++++++++++++++
>  fs/f2fs/dir.c                      | 17 ++++++++++++++++-
>  fs/f2fs/f2fs.h                     |  7 +++++++
>  fs/f2fs/super.c                    | 25 +++++++++++++++++++++++++
>  4 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 03b1efa6d3b2..a80ed82a547a 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -370,6 +370,25 @@ errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
>  			 ====================== =============== =============== ========
>  nat_bits		 Enable nat_bits feature to enhance full/empty nat blocks access,
>  			 by default it's disabled.
> +lookup_mode=%s		 Control the directory lookup behavior for casefolded
> +			 directories. This option has no effect on directories
> +			 that do not have the casefold feature enabled.
> +
> +			 ================== ========================================
> +			 Value		    Description
> +			 ================== ========================================
> +			 perf		    (Default) Enforces a hash-only lookup.
> +					    The linear search fallback is always
> +					    disabled, ignoring the on-disk flag.
> +			 compat		    Enables the linear search fallback for
> +					    compatibility with directory entries
> +					    created by older kernel that used a
> +					    different case-folding algorithm.
> +					    This mode ignores the on-disk flag.
> +			 auto		    F2FS determines the mode based on the
> +					    on-disk `SB_ENC_NO_COMPAT_FALLBACK_FL`
> +					    flag.
> +			 ================== ========================================
>  ======================== ============================================================
>  
>  Debugfs Entries
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index fffd7749d6d1..48f4f98afb01 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -16,6 +16,21 @@
>  #include "xattr.h"
>  #include <trace/events/f2fs.h>
>  
> +static inline bool f2fs_should_fallback_to_linear(struct inode *dir)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
> +
> +	switch (F2FS_OPTION(sbi).lookup_mode) {
> +	case LOOKUP_PERF:
> +		return false;
> +	case LOOKUP_COMPAT:
> +		return true;
> +	case LOOKUP_AUTO:
> +		return !sb_no_casefold_compat_fallback(sbi->sb);
> +	}
> +	return false;
> +}
> +
>  #if IS_ENABLED(CONFIG_UNICODE)
>  extern struct kmem_cache *f2fs_cf_name_slab;
>  #endif
> @@ -366,7 +381,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  
>  out:
>  #if IS_ENABLED(CONFIG_UNICODE)
> -	if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
> +	if (f2fs_should_fallback_to_linear(dir) &&
>  		IS_CASEFOLDED(dir) && !de && use_hash) {
>  		use_hash = false;
>  		goto start_find_entry;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7029aa8b430e..1c0edb8a7134 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -212,6 +212,7 @@ struct f2fs_mount_info {
>  	int compress_mode;			/* compression mode */
>  	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
>  	unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
> +	unsigned int lookup_mode;
>  };
>  
>  #define F2FS_FEATURE_ENCRYPT			0x00000001
> @@ -1448,6 +1449,12 @@ enum {
>  	TOTAL_CALL = FOREGROUND,
>  };
>  
> +enum f2fs_lookup_mode {
> +	LOOKUP_PERF,
> +	LOOKUP_COMPAT,
> +	LOOKUP_AUTO,
> +};
> +
>  static inline int f2fs_test_bit(unsigned int nr, char *addr);
>  static inline void f2fs_set_bit(unsigned int nr, char *addr);
>  static inline void f2fs_clear_bit(unsigned int nr, char *addr);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e16c4e2830c2..ed17ab4d5cef 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -181,6 +181,7 @@ enum {
>  	Opt_nat_bits,
>  	Opt_jqfmt,
>  	Opt_checkpoint,
> +	Opt_lookup_mode,
>  	Opt_err,
>  };
>  
> @@ -244,6 +245,13 @@ static const struct constant_table f2fs_param_errors[] = {
>  	{}
>  };
>  
> +static const struct constant_table f2fs_param_lookup_mode[] = {
> +	{"perf",	LOOKUP_PERF},
> +	{"compat",	LOOKUP_COMPAT},
> +	{"auto",	LOOKUP_AUTO},
> +	{}
> +};
> +
>  static const struct fs_parameter_spec f2fs_param_specs[] = {
>  	fsparam_enum("background_gc", Opt_gc_background, f2fs_param_background_gc),
>  	fsparam_flag("disable_roll_forward", Opt_disable_roll_forward),
> @@ -300,6 +308,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
>  	fsparam_enum("memory", Opt_memory_mode, f2fs_param_memory_mode),
>  	fsparam_flag("age_extent_cache", Opt_age_extent_cache),
>  	fsparam_enum("errors", Opt_errors, f2fs_param_errors),
> +	fsparam_enum("lookup_mode", Opt_lookup_mode, f2fs_param_lookup_mode),
>  	{}
>  };
>  
> @@ -336,6 +345,7 @@ static match_table_t f2fs_checkpoint_tokens = {
>  #define F2FS_SPEC_discard_unit			(1 << 21)
>  #define F2FS_SPEC_memory_mode			(1 << 22)
>  #define F2FS_SPEC_errors			(1 << 23)
> +#define F2FS_SPEC_lookup_mode			(1 << 24)
>  
>  struct f2fs_fs_context {
>  	struct f2fs_mount_info info;
> @@ -1143,6 +1153,10 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	case Opt_nat_bits:
>  		ctx_set_opt(ctx, F2FS_MOUNT_NAT_BITS);
>  		break;
> +	case Opt_lookup_mode:
> +		F2FS_CTX_INFO(ctx).lookup_mode = result.uint_32;
> +		ctx->spec_mask |= F2FS_SPEC_lookup_mode;
> +		break;
>  	}
>  	return 0;
>  }
> @@ -1652,6 +1666,8 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
>  		F2FS_OPTION(sbi).memory_mode = F2FS_CTX_INFO(ctx).memory_mode;
>  	if (ctx->spec_mask & F2FS_SPEC_errors)
>  		F2FS_OPTION(sbi).errors = F2FS_CTX_INFO(ctx).errors;
> +	if (ctx->spec_mask & F2FS_SPEC_lookup_mode)
> +		F2FS_OPTION(sbi).lookup_mode = F2FS_CTX_INFO(ctx).lookup_mode;
>  
>  	f2fs_apply_compression(fc, sb);
>  	f2fs_apply_test_dummy_encryption(fc, sb);
> @@ -2416,6 +2432,13 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  	if (test_opt(sbi, NAT_BITS))
>  		seq_puts(seq, ",nat_bits");
>  
> +	if (F2FS_OPTION(sbi).lookup_mode != LOOKUP_PERF) {
> +		if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_COMPAT)
> +			seq_show_option(seq, "lookup_mode", "compat");
> +		else if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_AUTO)
> +			seq_show_option(seq, "lookup_mode", "auto");

Can we show "lookup_mode=perf" in mount option as well?

Thanks,

> +	}
> +
>  	return 0;
>  }
>  
> @@ -2480,6 +2503,8 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
>  #endif
>  
>  	f2fs_build_fault_attr(sbi, 0, 0, FAULT_ALL);
> +
> +	F2FS_OPTION(sbi).lookup_mode = LOOKUP_PERF;
>  }
>  
>  #ifdef CONFIG_QUOTA


