Return-Path: <linux-kernel+bounces-840971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37CABB5D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 05:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C943AD6F7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 03:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7C42AA9;
	Fri,  3 Oct 2025 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahh9/NqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F14A01
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759461334; cv=none; b=EyyaNCmPphWwosDJfJMcsJ30w2/o6i8hpg+i7IZtn4RinyB3NyOLkyEHWHE2kvDe1Rrz4Z73htfWr0YlJgKwkXbkSSNbVEu4be/o5JlaWJrzjWgBRII2/zJAvByu2TvqjUGcGzHUAQLScFarh+RxUFJvyLNmEvOik27q7ipHgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759461334; c=relaxed/simple;
	bh=sk3y8tknfOwTAtWs2x2BOp4Uzd3iFdPo7zrPBdb6P4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjju2CiVDOVNvwn2H573wB00k3oveOJaK8HWL0lFjMuCq1lbnVxQccpNdy8RF9vudQBdiIk2xrMvb39Kpwz85G+QzVbG7bcajL2rQp/nU0unP5ZBKYOTuks+mkrl1sS3DvhTPpC8Qz9zOkB2QrbM1fHIv7zB+VPskw+R3LL0tqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahh9/NqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCCDC4CEF4;
	Fri,  3 Oct 2025 03:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759461333;
	bh=sk3y8tknfOwTAtWs2x2BOp4Uzd3iFdPo7zrPBdb6P4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahh9/NqIy7/60+4tECOftLkCVDmack28EU778HdJ8yX5sjjp/DpO567ReWibvG0IM
	 g9PK9I/85fRD41KNQMdnhdSoGhQZWY1ixYvsCm4TJRe/XpI2BPqFh1pVdlCsSclxaz
	 txICycc584ykAmYE1dmsNZv1Q13UEtw/KdmQE5tHRNqfS7hyroeznLTIm/5xQB5zsY
	 Zjjlg0QJpzaQA3ELd0zA8mtaKsVFvyIQSJbL6CryJMYd/dNJRYlWTuU/+NeLxSMtbw
	 n6g+88agY4d+EOkJEg5/yPBTULNhtVL716TNYEJeRL8OedayViNByARBhEzv/g+LOG
	 4rdTJI+/pkIXQ==
Date: Fri, 3 Oct 2025 03:15:31 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Haofeng Li <920484857@qq.com>, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: Re: [PATCH] f2fs: fix ifolio memory leak in f2fs_move_inline_dirents
 error path
Message-ID: <aN8_05vg6Lz1eAkF@google.com>
References: <tencent_3FA2C956B557ED4D050EB26922B50D3CF40A@qq.com>
 <3bdcdb11-2d67-4842-b21c-2b41ce5faea9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdcdb11-2d67-4842-b21c-2b41ce5faea9@kernel.org>

On 10/03, Chao Yu wrote:
> On 2025/9/30 17:16, Haofeng Li wrote:
> > From: Haofeng Li <lihaofeng@kylinos.cn>
> > 
> > Fixes a memory leak issue in f2fs_move_inline_dirents() where
> > the ifolio is not properly released in certain error paths.
> > 
> > Problem Analysis:
> > - In f2fs_try_convert_inline_dir(), ifolio is acquired via f2fs_get_inode_folio()
> > - When do_convert_inline_dir() fails, the caller expects ifolio to be released
> > - However, in f2fs_move_inline_dirents(), two specific error paths don't release ifolio
> > 
> > Fixes: 201a05be9628a ("f2fs: add key function to handle inline dir")
> > Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
> > ---
> >   fs/f2fs/inline.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > index 58ac831ef704..2496866fc45d 100644
> > --- a/fs/f2fs/inline.c
> > +++ b/fs/f2fs/inline.c
> > @@ -425,7 +425,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
> >   	set_new_dnode(&dn, dir, ifolio, NULL, 0);
> >   	err = f2fs_reserve_block(&dn, 0);
> 
> f2fs_reserve_block() will call f2fs_put_dnode() in its error path, it has
> unlocked & released inode folio?
> 
> >   	if (err)
> > -		goto out;
> > +		goto out_put_ifolio;
> >   	if (unlikely(dn.data_blkaddr != NEW_ADDR)) {
> >   		f2fs_put_dnode(&dn);
> 
> Ditto, or am I missing something?

It seems you're right. Let me drop this patch.

> 
> Thanks,
> 
> > @@ -434,7 +434,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
> >   			  __func__, dir->i_ino, dn.data_blkaddr);
> >   		f2fs_handle_error(F2FS_F_SB(folio), ERROR_INVALID_BLKADDR);
> >   		err = -EFSCORRUPTED;
> > -		goto out;
> > +		goto out_put_ifolio;
> >   	}
> >   	f2fs_folio_wait_writeback(folio, DATA, true, true);
> > @@ -479,6 +479,10 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
> >   out:
> >   	f2fs_folio_put(folio, true);
> >   	return err;
> > +
> > +out_put_ifolio:
> > +	f2fs_folio_put(ifolio, true);
> > +	goto out;
> >   }
> >   static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)

