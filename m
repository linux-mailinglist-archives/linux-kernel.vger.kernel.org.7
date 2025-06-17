Return-Path: <linux-kernel+bounces-689555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47232ADC37F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 09:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6264F3B4418
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97DCA6F;
	Tue, 17 Jun 2025 07:37:28 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA4289803
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145847; cv=none; b=rJ7TuY6O44TVC2zVroL8Y4w6G9rLjvo+imm5Zk4bwYnRCgpxPTd2UbFR9ikNAi+/+GAZTlfO7vzK/WM2/omCBraV+1FafSuQ50AaEHaTSkPXPc5VwtzVNRwM5uhXn3Dct66o6r9b0d8Fx1m9PsX9qJNfWxsPYJ/qT1B2shXxLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145847; c=relaxed/simple;
	bh=itOYTDU53ZzZwYMw2cNbGzAtWqcxU3pIlOoeDhPhScA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlYUV2EpAd487jZsPqH+HM2nnLXyAh/QQgvdKJcO6gI0t9fFSIlNNtZvuHZJnSHuvuemajanMI/xccNIO6/72nyWpp6OraLh97Lemg6hopXrJ+7EgJyTc0L3JJHzvkOG6rKz1oggW/tnAcn0DSYfbMiyFgVkCij+u4QONbicM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bLzCF0ScnzYl63Q;
	Tue, 17 Jun 2025 15:34:17 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Jun
 2025 15:36:43 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Jun
 2025 15:36:43 +0800
From: wangzijie <wangzijie1@honor.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
CC: <chao@kernel.org>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid non-section-aligned size pinned file generation
Date: Tue, 17 Jun 2025 15:36:43 +0800
Message-ID: <20250617073643.2361088-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6ccfdae1-13f7-421d-b7d3-76883c2e7b8b@kernel.org>
References: <6ccfdae1-13f7-421d-b7d3-76883c2e7b8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
 (10.68.31.243)

> On 6/17/25 11:57, wangzijie wrote:
> > To prevent non-section-aligned size pinned file generated from truncation,
> > add check condition in setattr.
> > 
> > Signed-off-by: wangzijie <wangzijie1@honor.com>
> > ---
> >  fs/f2fs/file.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 6bd3de64f..72f7d1b4a 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1026,6 +1026,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >  {
> >  	struct inode *inode = d_inode(dentry);
> >  	struct f2fs_inode_info *fi = F2FS_I(inode);
> > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >  	int err;
> >  
> >  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
> > @@ -1047,6 +1048,11 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >  			!IS_ALIGNED(attr->ia_size,
> >  			F2FS_BLK_TO_BYTES(fi->i_cluster_size)))
> >  			return -EINVAL;
> > +		if (f2fs_is_pinned_file(inode) &&
> > +			attr->ia_size < i_size_read(inode) &&
> 
> Do we need to consider attr->ia_size > i_size case?
> 
> Thanks,

Hi, Chao
After commit 3fdd89b452c2("f2fs: prevent writing without fallocate() for pinned
files"), when we want to write data to pinned file, we need to use pin+fallocate, 
and we did CAP_BLKS_PER_SEC roundup align when fallocate pinned file:

block_t sec_len = roundup(map.m_len, sec_blks);

Even if we truncate the file to a larger size(maybe larger than sec_len, section
align or not), and write data to offset beyond sec_len, the write will fail(commit
3fdd89b452c2 prevent it). The scattered pin block cannot be generated by this way,
so I did not consider attr->ia_size > i_size case.
Do you have some suggestions?

> > +			!IS_ALIGNED(attr->ia_size,
> > +			F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
> > +			return -EINVAL;
> >  	}
> >  
> >  	err = setattr_prepare(idmap, dentry, attr);




