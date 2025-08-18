Return-Path: <linux-kernel+bounces-774160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE94B2AF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2511BA3EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10437267F4C;
	Mon, 18 Aug 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="41jycK8R";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="O9DsE5HB"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82CD21D3DC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537633; cv=none; b=htFKBpYa+vrL/Mz3LVWJxIenkmo4DHlME6+aTVUn8EJR5LEtB7pyluAGanB+ZQ050Ykz/D3xVOWC7fJ3VtEDzx3ef5FgFwjPsposI/bACoMSSCxv1dRuxXOYAwBK1y653l0XFKe1Exzj5zZHu5WgO6cA8W3foscgY9MNzIx/BdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537633; c=relaxed/simple;
	bh=3X2Xs5jjuMTF3d33OZER2fzwprEQ7Q8pIjskalbyCbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r1+AMm2Z3lGWMEkfuIZNBBjpoZ9zx7F01ISscgt3G6DIbSBXaudYnSRWT8qFIfBnVWWQqumshWyKOkgU15obXx0qFF9BvTqP4K35CQSkl4Z9ToVUPg17dkx6eYx7sT2ZfM6Upv90FCbS56DfWw+HAxvnZGCE2smEXLP9iBdZPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=41jycK8R; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=O9DsE5HB; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 1077A26F75D8;
	Tue, 19 Aug 2025 02:12:46 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1755537166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zne+dvh8Cl7zH3AsedTf8l/Of8uQ1RUm3evPNzWIMPg=;
	b=41jycK8RawQnGz+NLfVIo25IFK6pN6Dwh1oYi//Xfvb7fqaFKVGFhJBqC3sUPQ3+BX9i46
	lpvIM4nqqZguMVVBo5KNklmMK7ZEi5eDIsgOLeRIFjyBhc76Yyzc9C16ucri0Ct3coU+E8
	QGaWdulSS25g9p3hPC5XfUqEo2qSx/Hz1FpvbjBsdV+sPDP5TPJhp+Zd1finX8JO4fRi1l
	XqfpBfGv4lbkwxTXOW316JXvdtgeqxKBRsh1vRJspsYPiGyLMTh7s9D5GgPBBm9y6V37aM
	C3fTIw1lxmsc58SEaSrJ7xtjMmimksYJz9fG6qFNavI+tx7aEf+CmmGB0HDUMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1755537166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zne+dvh8Cl7zH3AsedTf8l/Of8uQ1RUm3evPNzWIMPg=;
	b=O9DsE5HBIyvM6Dlf2qYv3OjloF8zyBuT8UvYyHS1LUhtHeOf86CChDcHN2sp9MSzndJDwM
	pJQVvgz1KuCt6NAg==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 57IHCiiT095583
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 02:12:45 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 57IHCif9255916
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 02:12:44 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 57IHCiiK255915;
	Tue, 19 Aug 2025 02:12:44 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: zhoumin <teczm@foxmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfat:remove unused variable
In-Reply-To: <tencent_9DE7CC9367096503F6ADD2BD960079267406@qq.com>
References: <tencent_9DE7CC9367096503F6ADD2BD960079267406@qq.com>
Date: Tue, 19 Aug 2025 02:12:44 +0900
Message-ID: <878qjg7dv7.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

zhoumin <teczm@foxmail.com> writes:

> Remove unused variable definition and related function definition
> and redundant variable assignments within functions.
>
> Signed-off-by: zhoumin <teczm@foxmail.com>

Looks good. Thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/dir.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index acbec5bdd521..92b091783966 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -1209,7 +1209,7 @@ EXPORT_SYMBOL_GPL(fat_alloc_new_dir);
>  
>  static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
>  			       int *nr_cluster, struct msdos_dir_entry **de,
> -			       struct buffer_head **bh, loff_t *i_pos)
> +			       struct buffer_head **bh)
>  {
>  	struct super_block *sb = dir->i_sb;
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> @@ -1269,7 +1269,6 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
>  	get_bh(bhs[n]);
>  	*bh = bhs[n];
>  	*de = (struct msdos_dir_entry *)((*bh)->b_data + offset);
> -	*i_pos = fat_make_i_pos(sb, *bh, *de);
>  
>  	/* Second stage: clear the rest of cluster, and write outs */
>  	err = fat_zeroed_cluster(dir, start_blknr, ++n, bhs, MAX_BUF_PER_PAGE);
> @@ -1298,7 +1297,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  	struct buffer_head *bh, *prev, *bhs[3]; /* 32*slots (672bytes) */
>  	struct msdos_dir_entry *de;
>  	int err, free_slots, i, nr_bhs;
> -	loff_t pos, i_pos;
> +	loff_t pos;
>  
>  	sinfo->nr_slots = nr_slots;
>  
> @@ -1386,7 +1385,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  		 * add the cluster to dir.
>  		 */
>  		cluster = fat_add_new_entries(dir, slots, nr_slots, &nr_cluster,
> -					      &de, &bh, &i_pos);
> +					      &de, &bh);
>  		if (cluster < 0) {
>  			err = cluster;
>  			goto error_remove;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

