Return-Path: <linux-kernel+bounces-763674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3CEB21887
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDBC167E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29BD2E0915;
	Mon, 11 Aug 2025 22:43:21 +0000 (UTC)
Received: from sxb1plsmtpa01-04.prod.sxb1.secureserver.net (sxb1plsmtpa01-04.prod.sxb1.secureserver.net [92.204.81.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C81F948
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952201; cv=none; b=MfgnC9Hxx2w0lQEG0phCYCApI2MeDiTJDLnl39VbHYb273Bpvwbsry1VOcnI1ZqQ2pynXmkQnq9RieIU/uc+0IL63THZgR3UEoAYbYl2mRGdCq4uwA1PzigxyKz07nrGTINsFfiH9oidT31213zPDec6QCs3qbo/0oWoJiPGKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952201; c=relaxed/simple;
	bh=9MRx4lFsJOTUCCHhBjm+do0sa2EoYT7DIOjOH6g8ctg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7FGgzHSWF0tVuIpEkcvPqMzlyEX1kEfRzCwtgrMiTsNS5HbBwbIWTcELaUHBD5umkEe43//245EOcScQO39rC3myZkFkvBZgT0QvnRULkQ8hAv0bxoMpfnTgfwIUFD0AGDH/uBVCdSc7MNH19TL0Yc6hf+vUX6YvmazVU5EXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id lb75us1r2CMUGlb7Bu6Q2c; Mon, 11 Aug 2025 15:35:38 -0700
X-CMAE-Analysis: v=2.4 cv=Vfn3PEp9 c=1 sm=1 tr=0 ts=689a703b
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=Byx-y9mGAAAA:8 a=GvQkQWPkAAAA:8 a=xVveRHJumbGvxgx-NYMA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10
Feedback-ID: b02b9d59cd6f6f6f50f4ed83f9c2f43e:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <2156fc8a-a43b-4986-8537-d1d530821dbf@squashfs.org.uk>
Date: Mon, 11 Aug 2025 23:35:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: Avoid mem leak in squashfs_fill_super
To: scott_gzh@163.com
Cc: linux-kernel@vger.kernel.org, Scott GUO <scottzhguo@tencent.com>
References: <20250811061921.3807353-1-scott_gzh@163.com>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20250811061921.3807353-1-scott_gzh@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJeeUsXUeDhxrRdU2a6Ivd48/w5mcbJ94g8GOQ2IHGmG6J2npqfgbmyoFxln8cZdUM48D/l25wepcck0sVcVbNQhbZvLzAQ6BDXtYDNj3ONrFTBEGGMO
 aykJqev4EnK7uas0dSMGQI7Byaxtd0wNcI+03foy+Xj+5XJSAtNLm05DFUsrNobiwwDT9kUOC8qSs/HJGiPRq4bWDXlPLRol2QhN7nXwbC9+/SzMp4Qc1I5A
 V/ofeqaShdYUmdlf5XysEce7eU9ec9oA6jozaMcKTGQ=



On 11/08/2025 07:19, scott_gzh@163.com wrote:
> From: Scott GUO <scottzhguo@tencent.com>
> 
> If sb_min_blocksize returns 0, -EINVAL was returned without freeing
> sb->s_fs_info, causing mem leak.
> 
> Fix it by goto failed_mount.
> 

Thanks for spotting this, but, NACK to the patch.

A better fix is to call sb_min_blocksize and check the
return result before the memory is allocated.

Phillip

> Fixes: 734aa85390ea ("Squashfs: check return result of sb_min_blocksize")
> Signed-off-by: Scott GUO <scottzhguo@tencent.com>
> ---
>   fs/squashfs/super.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index 992ea0e37257..7d501083b2e3 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -201,10 +201,12 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   
>   	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
>   
> +	err = -EINVAL;
> +
>   	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
>   	if (!msblk->devblksize) {
>   		errorf(fc, "squashfs: unable to set blocksize\n");
> -		return -EINVAL;
> +		goto failed_mount;
>   	}
>   
>   	msblk->devblksize_log2 = ffz(~msblk->devblksize);
> @@ -227,8 +229,6 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   		goto failed_mount;
>   	}
>   
> -	err = -EINVAL;
> -
>   	/* Check it is a SQUASHFS superblock */
>   	sb->s_magic = le32_to_cpu(sblk->s_magic);
>   	if (sb->s_magic != SQUASHFS_MAGIC) {

