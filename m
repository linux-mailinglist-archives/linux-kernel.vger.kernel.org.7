Return-Path: <linux-kernel+bounces-849746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8F7BD0C98
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDAE3B7366
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583D2356D9;
	Sun, 12 Oct 2025 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFYw47Gq"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271A21D3F5
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760303950; cv=none; b=DdCYYXcxW5spwJ6sexkfc1ao8A4OdJa410b0o8X73XbrEzRQUrboxXN7XaTg5rUJRXD39ctBhRlxdBrRbsIgfaqAFZBhvDnzkP6O+4myMCBM2OipTHYPPdKZMt1NAMOym3IJAwiU/dagjCmMBoURZtWBj2XrDYpIcKYwfKkFDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760303950; c=relaxed/simple;
	bh=Ghk3kWF8dNB1V0k0mDvpg3iN0UslD0y9riOY5veE2rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjMbA7/aPay+fojhXKdIgFBtGH6xO4/71qZwmcz5yBQYVEMx2A2H/tT7bIXwnFj2nok/R065HNLaHGka8f7cSo1saqtFAFXKtohGKVwFNOeyZ/02xR8lUzMuw6+kMRjzBYe/WqF4mRzVHCr4IwwRJn0dhWZKQmvPGsZE9NPrvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFYw47Gq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42421b1514fso1749497f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760303947; x=1760908747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Adu93qTTKDS0Ch74HcJDA+rP49HUSyI6PQ01hbqUFWo=;
        b=OFYw47GqMfJh80lfJ+CTMT4KQr1vTWG+cBBpU9Q3cVzFjdphM7+Ngmi0c8pOc1ToKP
         0awBvnBsnMZ0EEwSV0MNOElzYrsaDM0J3QQvWx3xxLCZRpDRE2dLHhFJe06V1fqa72Nu
         PanDYgwFBUIgOWGKoOXmeOc2QpEWsZk5KjETOHBDY1nTOpGft51BlIGUYCKodq3NQ7bH
         XxHbzxTKgoX51ImC8+W58faUl3E/wj9e1ZnFND00fegb4Dl9uV7pl6DM/rxHdnhHNQYU
         7pLMKP8vcBw2NJv7K0+r17B6qzq9vUxyucZ5jqFhjR7JiEI2dyO+VcHolp3TXF4cSl8C
         s11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760303947; x=1760908747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adu93qTTKDS0Ch74HcJDA+rP49HUSyI6PQ01hbqUFWo=;
        b=JpgOCzQ2ZVJMuSUQyzx1YQWzxr0b8jCZvNe0wIRuMnvF2dPSHr4yQRpO3w9HRcqAO+
         ydSc1fKBc8nuBtvT9oHmTOBreXHoF+pghmfkiJ19pnSJ5KQY3z4ShInIkjOa+cdDNdPu
         6E8ZmagNXkvPLPyaIWet7hDqU9omSCl/7S6kZkUYyfhDCLSi1iM0Q8YTaYvvMwG5qetH
         +xqq684Zjns45My4Fups+6svzcGlrwGoAg7wbqxP58+PZM0zJhy94ulsnK//7xDn0dDS
         54xPBfoA6C4xfOeGRo+X9D8ZkkVOlWxDrA1plgMKXbHing+Qmr29H0qskRMToksZaBCw
         TaWA==
X-Forwarded-Encrypted: i=1; AJvYcCUTH3TJBKhTTq7h2wKrT4r/i1jjw8xOEWoXk+IlBOKpIaoxd/Cvg1nJm6PiDJKv7B4JDUQWlSSc6Y6bic0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoKhoyyRknsGecDA5zhRobsjxO0wW3Y55Kbla71I7Qhia8R40
	1Eb1YGq5VGKfGV6fXlaIbTTsEXndBfmcFssdZqWt1xoSdDd0+h9uTIbA
X-Gm-Gg: ASbGnct2CwY0mQkYsKivRfIqdKcCdDN9m8dCLuEbE/YDx9+qOcUgk9U+4+NJBj7ZS5S
	mEELfYEsCmf09gGp42X4JQzMvi1rDqoTxOC7ItE2gKSVQLo4PkVHTCQRYU8RLnScy4gUXdB37vp
	zwrltDE/MP8GQo3B5981jIQrlhKvqpSjGZ4m7aFJnUNq/UjbqfP+ECVxqCKtnT+34e7FP/uc8DU
	7y1822qnwNRcTDOw42d6oYyFea5yRlAcJa+AwnJLaSdBX6nh0kvZoRRGosLpilPNFI6ev5Bezz1
	hBsl2GOFtnCkuYOIjbnkujWUwRci9s9EfB0kfu310PR/fQ7+nooyaS+/qmC/pmAGgIJUsifDT2V
	leM+8v4G8pc7EQ3kXHYneN+qlc+yLnefEZe18BfTts3ce41XM4CtEItxvVUNy+VIPTm9kQy1Mkm
	esSM0MWBCD4Ejbnln4vcU=
X-Google-Smtp-Source: AGHT+IGjHlzwxTlSwDIo8bVlsq+pwRAcXzYI1RxLsxjm8COk+bFjmzs7HwuYQVnOLc3GhJHNohSXJA==
X-Received: by 2002:a05:6000:2c11:b0:3ec:dd16:fc16 with SMTP id ffacd0b85a97d-4266e7df779mr12010154f8f.43.1760303946775;
        Sun, 12 Oct 2025 14:19:06 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0987sm14723783f8f.38.2025.10.12.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 14:19:06 -0700 (PDT)
Date: Mon, 13 Oct 2025 00:19:04 +0300
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org, 
	syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: Perform sanity check before unlinking directory
 inode
Message-ID: <gupgic53ouhmdwrglwdviw2mzeaqfjsvyr47u3ebu2ztayswy4@4oxvnu252rdb>
References: <20251003134731.470392-1-zlatistiv@gmail.com>
 <839306c1-5f7a-4e89-b2cf-7534d279a03c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839306c1-5f7a-4e89-b2cf-7534d279a03c@kernel.org>

On Thu, Oct 09, 2025 at 10:54:40AM +0800, Chao Yu wrote:
> On 10/3/2025 9:47 PM, Nikola Z. Ivanov wrote:
> > Current i_nlink corruption check does not take into account
> > directory inodes which have one additional i_nlink for their "." entry.
> > 
> > Add additional check and a common corruption path.
> > 
> > Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
> > Fixes: 81edb983b3f5 ("f2fs: add check for deleted inode")
> > Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> > ---
> >   fs/f2fs/namei.c | 28 ++++++++++++++++++++--------
> >   1 file changed, 20 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index b882771e4699..68b33e8089b0 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -502,12 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> >   		goto out;
> >   	}
> > -	if (inode->i_nlink == 0) {
> > +	if (unlikely(inode->i_nlink == 0)) {
> >   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> >   			  __func__, inode->i_ino);
> > -		err = -EFSCORRUPTED;
> > -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> > -		goto out_iput;
> > +		goto corrupted;
> > +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> > +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> > +			  __func__, inode->i_ino);
> > +		goto corrupted;
> 
> Can we detect such corruption in sanity_check_inode() as well? So that if
> f2fs internal flow calls f2fs_iget() on corrupted inode, we can set SBI_NEED_FSCK
> flag and then triggering fsck repairment later.
> 
> Thanks,
> 
> >   	}
> >   	if (IS_ENCRYPTED(dir) &&
> > @@ -533,6 +535,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> >   	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
> >   				ino, IS_ERR(new) ? PTR_ERR(new) : err);
> >   	return new;
> > +corrupted:
> > +	err = -EFSCORRUPTED;
> > +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> >   out_iput:
> >   	iput(inode);
> >   out:
> > @@ -572,10 +577,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> >   	if (unlikely(inode->i_nlink == 0)) {
> >   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> >   			  __func__, inode->i_ino);
> > -		err = -EFSCORRUPTED;
> > -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> > -		f2fs_folio_put(folio, false);
> > -		goto fail;
> > +		goto corrupted;
> > +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> > +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> > +			  __func__, inode->i_ino);
> > +		goto corrupted;
> >   	}
> >   	f2fs_balance_fs(sbi, true);
> > @@ -601,6 +607,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> >   	if (IS_DIRSYNC(dir))
> >   		f2fs_sync_fs(sbi->sb, 1);
> > +
> > +	goto fail;
> > +corrupted:
> > +	err = -EFSCORRUPTED;
> > +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> > +	f2fs_folio_put(folio, false);
> >   fail:
> >   	trace_f2fs_unlink_exit(inode, err);
> >   	return err;
> 

Hi Chao,

Thank you for the suggestion.
I will add this to sanity_check_inode and remove it
from f2fs_lookup as it becomes redundant since f2fs_lookup
obtains the inode through f2fs_iget. For f2fs_unlink I will
move the i_nlink == 1 check to f2fs_rmdir.

I will send v2 as soon as I do some more testing.

