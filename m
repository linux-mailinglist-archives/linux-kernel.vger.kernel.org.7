Return-Path: <linux-kernel+bounces-846129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFABC71D1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7368534B4E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A72156677;
	Thu,  9 Oct 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kVgDRWp7"
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03D155C87
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973388; cv=none; b=WGS5SLxy5goT3gducvnST/N42yOZj+pklajQ8O24lw8/tUUBOv6SHU1zOaaxPfPpKo12TP2VwZ+3GVRBiYADM0DPlcsuI9/j2MzPFwe75E4fILyL7MkMCkGT6xW3wbcVztfIDNvwRIrkOgw2N5OMsRxkYE57vmEiK/lhvGjj2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973388; c=relaxed/simple;
	bh=uvrjhLvAYfZOfvdcnoX6f2sEkNTlZoS2jBSE2bogMfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nreD6IJ+1OshQ9wrPO+eC53u04muKLe/hYFs9Zt0Or3ISWGS/nz5g+okhvJpHGEqrrcMnw/cp2P+kyqxC7TToYLpCXa6AYBF7TrMAN+WXo2yfEHXfbwNd1NSIYwj2GYtd8alJeZ5vr8Hlz0xZbRppQFBa2iwkJY6yXiFffRPXGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kVgDRWp7; arc=none smtp.client-ip=47.90.199.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759973373; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I3slU/IaP0WiQpxT/JegwFgxdB3cll3URPm28WT3mIc=;
	b=kVgDRWp7VgXenjwpP4bP0QodJCXreFMciEvPIJycKWEH8BwjaOvn15hImsfgupm3QJfx/+KW8fWBt6MC79tkePt6XJZlU+fIrh3wTEbwU8dDDdmwTvpUcA+3YrptWllYFIQE8ZyeEzT5xMO2JUn7fS7w9ES/SDDww9WiQQoxeo8=
Received: from 30.221.128.150(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WpgW.lk_1759973372 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 09:29:33 +0800
Message-ID: <5df01bdb-caae-47e7-90f2-d14e3982f4d7@linux.alibaba.com>
Date: Thu, 9 Oct 2025 09:29:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Fix use-after-free in ocfs2_dx_dir_lookup_rec
To: ssrane_b23@ee.vjti.ac.in, Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
References: <20251005151403.9012-1-ssranevjti@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20251005151403.9012-1-ssranevjti@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
This seems to be fixed by the following commit:
44acc46d182f ocfs2: avoid NULL pointer dereference in dx_dir_lookup_rec()

Thanks,
Joseph

On 2025/10/5 23:14, ssrane_b23@ee.vjti.ac.in wrote:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> 
> A syzbot report triggered a KASAN use-after-free read when creating a
> file on a corrupted OCFS2 filesystem image.
> 
> The crash occurs in an error-handling path within the
> ocfs2_dx_dir_lookup_rec function. When the function fails to find a
> matching extent record (`found` is false), it attempts to log details
> about the corruption by reading from the `rec` variable.
> 
> According to the KASAN report, the memory pointed to by `rec` can be
> invalid at this point, leading to a kernel crash.
> 
> Fix this by modifying the error message to use only variables that are
> known to be safe, such as the inode number and the extent block's
> buffer head block number. This preserves the valuable error log for
> debugging corrupted filesystems while preventing the memory safety
> violation.
> 
> Reported-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
> Tested-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
>  fs/ocfs2/dir.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index 8c9c4825f984..8c4dd61efa8d 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -820,8 +820,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
>  		ret = ocfs2_error(inode->i_sb,
>  				  "Inode %lu has bad extent record (%u, %u, 0) in btree\n",
>  				  inode->i_ino,
> -				  le32_to_cpu(rec->e_cpos),
> -				  ocfs2_rec_clusters(el, rec));
> +				  eb_bh ? (unsigned long long)eb_bh->b_blocknr : 0);
>  		goto out;
>  	}
>  


