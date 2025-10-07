Return-Path: <linux-kernel+bounces-844852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B13CBC2EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FB319A223B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D96258CCB;
	Tue,  7 Oct 2025 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSLkE3hr"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7EF2C9D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878485; cv=none; b=CA1Eza8K70J34OHq6aDJKyQQZ15udEYxzhEu6NWnxgkbTPvFJouTydiAef5sFbeWBrhMeMq5WBLpml7h2sKnOcBOFYQ9hBNsTX/biktkG2fIs8FzqHcdcD348p+GC7CKXWyvJwWnwEyC4lYW5oA5CT7wsWLzyfon9POGVY2dIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878485; c=relaxed/simple;
	bh=4VN9EjJQI+s1niCEU3WXu+PksQUSryrEEQdwBD01R2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yre2FKaXPTgxo2ktLexX/wh9MkZc/vtHPqp13A7L5rggO/qIRiLB4PqXH2SUVjC1LwEKLKf+uZ9w76hF0VNSQPZB6nXCiiflauaSA4sdJ+Ggr8zingrpXNV58elV2ApBIVHhEY8ZUGlKg03g+vhwj8JpyBNwLAFXkeeblC/15pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSLkE3hr; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42d8ad71a51so79797305ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759878482; x=1760483282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zlLF1sF2xA95fa6DO/8tik1XHN3dPL/MPmyceygSHI=;
        b=HSLkE3hrxUQibR0H+OMs26hmrNtQ/TyaEmaZqTG7u8N6u14/lCShT0gKL94co9oPcZ
         j60CkAxmmEmzpYzYnQqhQsMbsZ07fWW4eBj52dDDWNJGGzK2BKt6HHYSxMgeszhr1U4b
         UTjf0cdDtv/KMNWuA/db9hnfjV72CSUROLG1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759878482; x=1760483282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zlLF1sF2xA95fa6DO/8tik1XHN3dPL/MPmyceygSHI=;
        b=Z67B/iR7vMlZNmCpgjL33J1y8aLdRtfZmSH+btcwMZM7DcksUdRTPZ0hlwjc8j6Gzv
         WN4hgazFESt16uyilZ60xedS7wlPRBJs+/8PXfXyVBaP67aqYRoYcCbeh25U9wBzX3tT
         If2KzXUsM7b7PIAk4jID9iWpkurNfU+0ZLis7y75AD5J0HadfOUPI15tcsZpWWQf8gwt
         XIHBd0t2m9aEzzotfD8awCnDmN5h8iNhppLnaCDHOI40kWMbjtzfcZHQqK1hDtRD/W/8
         +JqPrjVgwcq72MPI/IjG0P6VDYLDXLzZZbfpAdf+MJJ3vTU6Cy4/hlEnjgdF9uKzT+2T
         jUbA==
X-Gm-Message-State: AOJu0Yw571SRcUI7HxaXd6ZkGcTUpP4Gn8NmnE1JoK6cuL72yuHbe1e6
	lNIuiHp4jpEhd1gifr4J5jMdhkmHVGcvycIf1DTEl+mSmbECdfks4WvuyBTDq+aLH28=
X-Gm-Gg: ASbGncuwYNUuEgsR8pmpxKxHNM7kO4/+5Wb/rb69HFBMmOMYQR/6r2RNv9lpaoTRaPX
	zTj9jhMp/YpGy6WcHEQxoGYIjVLv1c7Oew8trfbJ09VyRGbcfqzW53FGZmh5sqe1QrqTT/oI3up
	Hl5kwRd3Y4GbH5lWsopa2SEsDEN+2Sc4Qiuo/15oevpW52bzt5mpy/US9CNMWnAXWJLhtenpsdT
	h/5q1HC2mIeYmjJvAjmBXCC2AfHF/1RHUt4/LQhgR0Q6tTH/3UF0KzoAk2CixnCcgYtaeOqOurq
	qBD5X9FH8Ii1Ss8Zz05zEhzjmTFZaT1O32SRWPgjUY+Q7l9BJ2e9P0gtjO/SvbIaC+Gg2xVevXb
	QdcChCGKy8XxLWHdTFRdSpVVdStQggk1066BOFrnh5jPOtK/rNNfQh0sygHk=
X-Google-Smtp-Source: AGHT+IEtLhevApkwpIKEq7+fQ8je8BxgSHsqBpZsQ2zLcnvaHNcZe5ZzCLwO2QkGpik5nYtNYr2I2A==
X-Received: by 2002:a05:6e02:2785:b0:42d:8bf8:967 with SMTP id e9e14a558f8ab-42f8735b606mr12490955ab.13.1759878481614;
        Tue, 07 Oct 2025 16:08:01 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b281664sm70947345ab.25.2025.10.07.16.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 16:08:00 -0700 (PDT)
Message-ID: <efdafa7a-3d24-4a44-ae40-4057b0a8bc51@linuxfoundation.org>
Date: Tue, 7 Oct 2025 17:08:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: Perform sanity check before unlinking directory
 inode
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, jaegeuk@kernel.org,
 chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org,
 syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251003134731.470392-1-zlatistiv@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251003134731.470392-1-zlatistiv@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 07:47, Nikola Z. Ivanov wrote:
> Current i_nlink corruption check does not take into account
> directory inodes which have one additional i_nlink for their "." entry.
> 
> Add additional check and a common corruption path.

How does this change fix the problem? What is common corruption
path in this context?

> 
> Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
> Fixes: 81edb983b3f5 ("f2fs: add check for deleted inode")
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

How did you test this patch? Can add details?

> ---
>   fs/f2fs/namei.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index b882771e4699..68b33e8089b0 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -502,12 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>   		goto out;
>   	}
>   
> -	if (inode->i_nlink == 0) {
> +	if (unlikely(inode->i_nlink == 0)) {
>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
>   			  __func__, inode->i_ino);
> -		err = -EFSCORRUPTED;
> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> -		goto out_iput;
> +		goto corrupted;
> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> +			  __func__, inode->i_ino);
> +		goto corrupted;
>   	}
>   
>   	if (IS_ENCRYPTED(dir) &&
> @@ -533,6 +535,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>   	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
>   				ino, IS_ERR(new) ? PTR_ERR(new) : err);
>   	return new;
> +corrupted:
> +	err = -EFSCORRUPTED;
> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>   out_iput:
>   	iput(inode);
>   out:
> @@ -572,10 +577,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>   	if (unlikely(inode->i_nlink == 0)) {
>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
>   			  __func__, inode->i_ino);
> -		err = -EFSCORRUPTED;
> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> -		f2fs_folio_put(folio, false);
> -		goto fail;
> +		goto corrupted;
> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> +			  __func__, inode->i_ino);
> +		goto corrupted;
>   	}
>   
>   	f2fs_balance_fs(sbi, true);
> @@ -601,6 +607,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>   
>   	if (IS_DIRSYNC(dir))
>   		f2fs_sync_fs(sbi->sb, 1);
> +
> +	goto fail;
> +corrupted:
> +	err = -EFSCORRUPTED;
> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> +	f2fs_folio_put(folio, false);
>   fail:
>   	trace_f2fs_unlink_exit(inode, err);
>   	return err;


