Return-Path: <linux-kernel+bounces-754738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA19B19BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0444D7AA8B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9F21CA04;
	Mon,  4 Aug 2025 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxp6jCAc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9F2E36F4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289368; cv=none; b=vCItiv6z7LqwFUdU71UT4lfo4Z+p/pQYS0GYI/wPUMnJcqOGBP4NkQRRVvC5wYK6cG5nTa8eZVKeUMmp6yL6VbT6tlRm51cK8p0tAUZZwd2+nHuUW5nnrnUd2AvtDdgfGXJMdDYYvPIjQ0neL45tdYfygun2pWHtdfoM2v4hjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289368; c=relaxed/simple;
	bh=xWUKsu37RY2bqm4n6MvNMO5+hGMcJNhFHMo1GtEmpaU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J2zskKE5f2HzFH+gp2GdndyK2GRiRYH+Heb60USciGSWcWdpwdnt3o2XpqHT5t8bdD4PKhEB9caelEtlP2CudLK/JTLzAIb792EnicoCjTTHnURjrJOq5bR0aFUOaxwH4peC+ydzPtXSUXOA10IhjJ0b+94VgnXKvTzVWeV9RaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxp6jCAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE0CC4CEE7;
	Mon,  4 Aug 2025 06:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754289367;
	bh=xWUKsu37RY2bqm4n6MvNMO5+hGMcJNhFHMo1GtEmpaU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lxp6jCAcMl5n92cwpAJR42eWzvc2HkTa/WZk8TJhsfgIv+BP6jMkJqW4OcxKmdOeB
	 SSWWpHgRLvxOcY530Dt/+tQkklRnWBOCTNd1KWFLZNN3Dxsl0ts65KxfJj2Q/p+ImX
	 4Sye6etRk1NxM6auaMotIUugB9YHMXolvIxmEiaFNdV9d+mvzA6ug6xdf6fmbkZTne
	 jtPVEyVwlTuUStKBOduPVJg9D6+6KNiWaoGA+yFPzrdtLdtr6gnc0La3vKQoq1LZQP
	 xlrAJXG+6M2XANuxma+BJGBHycApqmsU5MJUJsWic4sSJ8ZAD/l59mu42YXWcVC0jq
	 lC2ixDyPWVUHA==
Message-ID: <785306c5-27ba-4a18-b702-1d943c484a56@kernel.org>
Date: Mon, 4 Aug 2025 14:36:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: add sysfs entry for effective lookup mode
To: Daniel Lee <chullee@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250804060327.512247-1-chullee@google.com>
 <20250804060327.512247-2-chullee@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250804060327.512247-2-chullee@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 14:03, Daniel Lee wrote:
> This commit introduces a new read-only sysfs entry at
> /sys/fs/f2fs/<device>/effective_lookup_mode.
> 
> This entry displays the actual directory lookup mode F2FS is
> currently using. This is needed for debugging and verification,
> as the behavior is determined by both on-disk flags and mount
> options.
> 
> Signed-off-by: Daniel Lee <chullee@google.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 14 ++++++++++++++
>  fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index bf03263b9f46..e847a50e7403 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -861,3 +861,17 @@ Description:	This is a read-only entry to show the value of sb.s_encoding_flags,
>  		SB_ENC_STRICT_MODE_FL            0x00000001
>  		SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
>  		============================     ==========
> +
> +What:		/sys/fs/f2fs/<disk>/effective_lookup_mode
> +Date:		August 2025
> +Contact:	"Daniel Lee" <chullee@google.com>
> +Description:
> +		This is a read-only entry to show the effective directory lookup mode
> +		F2FS is currently using for casefolded directories.
> +		This considers both the "lookup_mode" mount option and the on-disk
> +		encoding flag, SB_ENC_NO_COMPAT_FALLBACK_FL.
> +
> +		Possible values are:
> +		- "perf": Hash-only lookup.
> +		- "compat": Hash-based lookup with a linear search fallback enabled
> +		  for casefolded directories.

Any way to know whether "perf" or "compat" comes from auto mode or not? something
like "auto:perf", "auto:compat", maybe?

Thanks,

> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 75134d69a0bd..9897dd8564e0 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -281,6 +281,22 @@ static ssize_t encoding_flags_show(struct f2fs_attr *a,
>  		le16_to_cpu(F2FS_RAW_SUPER(sbi)->s_encoding_flags));
>  }
>  
> +static ssize_t effective_lookup_mode_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	switch (f2fs_get_lookup_mode(sbi)) {
> +	case LOOKUP_PERF:
> +		return sysfs_emit(buf, "perf\n");
> +	case LOOKUP_COMPAT:
> +		return sysfs_emit(buf, "compat\n");
> +	case LOOKUP_AUTO:
> +		if (sb_no_casefold_compat_fallback(sbi->sb))
> +			return sysfs_emit(buf, "perf\n");
> +		return sysfs_emit(buf, "compat\n");
> +	}
> +	return 0;
> +}
> +
>  static ssize_t mounted_time_sec_show(struct f2fs_attr *a,
>  		struct f2fs_sb_info *sbi, char *buf)
>  {
> @@ -1166,6 +1182,7 @@ F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
>  F2FS_GENERAL_RO_ATTR(unusable);
>  F2FS_GENERAL_RO_ATTR(encoding);
>  F2FS_GENERAL_RO_ATTR(encoding_flags);
> +F2FS_GENERAL_RO_ATTR(effective_lookup_mode);
>  F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>  F2FS_GENERAL_RO_ATTR(main_blkaddr);
>  F2FS_GENERAL_RO_ATTR(pending_discard);
> @@ -1282,6 +1299,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(current_reserved_blocks),
>  	ATTR_LIST(encoding),
>  	ATTR_LIST(encoding_flags),
> +	ATTR_LIST(effective_lookup_mode),
>  	ATTR_LIST(mounted_time_sec),
>  #ifdef CONFIG_F2FS_STAT_FS
>  	ATTR_LIST(cp_foreground_calls),


