Return-Path: <linux-kernel+bounces-882436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62422C2A746
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D37F34EE3D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BF92C158E;
	Mon,  3 Nov 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky0++HxU"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF8242D7C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156507; cv=none; b=XRm036PXL4fLfWrJ6c0DweI4tReJ808Iun9vGa4I+4KGIPCVU0pjTFGrhcNrsx0Bs5kAjXiF/RAgLbm8jhh3djyngzQgGZiQd6mFHEjaHHemGBM7cUdw8a1BXK5N8TKQPNGg+YEoBCzz74K9hR8b/DUaQhiEQEbFQCl5NChC9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156507; c=relaxed/simple;
	bh=UqDUQ6OyyJRLzVQX1Z9hQqRiS2RYJgv3h4EjNJTt7us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsfLumidk3jbTQcvqKZviKdVvSxHi7ySCG6972eJ1zXcN4HgS7PZJqnu7RXrYAFz82pgBkYLduy6NjDoxCmZMZHwxJ69vmDlhmNrhe+jqOhsBhYwzAWFnwaw7TofneCUVWm7xZWhoFZ6YzE/FW5iaCcgT6khqFl0brSTfzShGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky0++HxU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429bccca1e8so1637567f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762156504; x=1762761304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QX9EpicK1kmDyEDBsOzwExi+YjHk71IsQgHccPkCOpk=;
        b=Ky0++HxUjO0M3oN3XwDrWBs8yo44CnDFJxXr06uHL6T5RLdanhrElV70797gpOaOIH
         IEtmQsQoLdr5c7C03J+62pvGJHFgFzqJQgrZyqCLbS5YxoZ5iFAkgKpOPAcjIWA58Kem
         BFBH4Nw3NPc7bqwX7Yjqe/QW3EVyvYksSlVj9m6cAdYSy7B16hFHwKPLApU63/jh74PQ
         LuYg3mHe32GzD7MnJtVKbchhHI3Vt/VXCTS+WUvNs7BXHcBox5et+fE0wMwVlV/Tyc2K
         xkSyLYoAz3LwakrIBgLx94pd+KStOCmWbKSLzxywbjAb61gOcbbZtm+nw5SPCE48Gnip
         lfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156504; x=1762761304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX9EpicK1kmDyEDBsOzwExi+YjHk71IsQgHccPkCOpk=;
        b=k8r5FfkKUBgBLKtGp0DNSfTdch+UgLAr3k+owlhHFz1wNrsaOtv9XRtMiw0cXbs3ST
         On8CjTf1l+smgFRwv7MM3dPwlDpY4EL7BGF+OghTsFcFUvxkSClKSTpLH4iwKUwXj3mF
         fNknzfChrkvSaVab8XCNn7rBrF0g0PIMa3FbVmZX2S/KQLrDhOD768Hw5Tg5CiqzaLha
         loS8XMSTPwEsyAcowogNTEWH6amnuJkJWLo20DaduD61DQMt+1CCOTGQQiOiyk0Bsxrv
         Rk6MnTGGBXD+jEU9MjJR9P2IwhSqFh7o1kVrEEUMfIp8bXbwz88N/ja0oXRrIROCBNGO
         ABqg==
X-Forwarded-Encrypted: i=1; AJvYcCVgFRF5jTm4xwiyggyrC08RhkNqX+dNgE1fVVB95vD8kcGitKKt+Eyh4cFiAAM1Cimty3iCQ78oEFYxEdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6eydNoZOhmI3YbsBHPEjgkwpAJXZJMEoFySF3xl/JHbNxnKx
	l8DVBUWRwpFs5LFqfBwVFD0zSgwuaqsTxl2d/EHeB181BU3+IXdxNrzx
X-Gm-Gg: ASbGncsxEu22OhLI6LSHFrFwWoZttGFcMf93UsveVcSJBa94HoDHovt5rW6GAEx600M
	3aPNfCEfun+TDj5M3eBrlz+oPetkG3sw4DJBnO+Jd3tEKfxJWX0JLlbUKRFP2NPO8XdDLc7nBk6
	a3zx9vGBVKOLpHpKeC/0uCoyPbzwQfSYreJh31BuZ1ead+TxdoAYw0cohKjZGWAsNGnPxcrT9I7
	O+PCmj8c5KXEcF6jzQ+Nd4Gl5kXqgaj+v5MTIK9tvscBbZdawCmyYOKcp9UUtS0mOm8IjkCJd3Q
	fCAcFS6yl33ritqqYXsMhuk/8O1E5gbcBLv2uqidsyQq3httqqwwy8eODX4P5TWLATrU5bHnY3s
	uAqBBYz7B1toj+F1n8O27qKZKTgnynphwMwyMDtyBfBNZazr+Ha/+A268+86qmqv4DYCCtI5yMq
	ckZt8HZc9KqwesUARFx39nrw==
X-Google-Smtp-Source: AGHT+IFyHdL5vinzqBP7jHakygrAZQoPQph4ogdXR370JssBAjuF23hFYbiA6u4HtF1rj6X+jdGEDA==
X-Received: by 2002:a5d:5d02:0:b0:427:9d7:86f9 with SMTP id ffacd0b85a97d-429bd6a8f88mr9630526f8f.47.1762156503565;
        Sun, 02 Nov 2025 23:55:03 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1405fffsm18688238f8f.45.2025.11.02.23.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:55:03 -0800 (PST)
Date: Mon, 3 Nov 2025 09:55:01 +0200
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org, 
	syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/2] f2fs: Add sanity checks before unlinking and
 loading inodes
Message-ID: <pcxf66ac2yjkqyvhb6xgbk6jiihcejuncgbblkewz6rs7i5uzt@m6yjin7t67is>
References: <cover.1761993022.git.zlatistiv@gmail.com>
 <55522ef8f3424e563ff18a720c709dcb065091af.1761993022.git.zlatistiv@gmail.com>
 <ea38e464-a28a-4b06-8046-5b62f7172875@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea38e464-a28a-4b06-8046-5b62f7172875@kernel.org>

On Mon, Nov 03, 2025 at 10:35:17AM +0800, Chao Yu wrote:
> On 11/1/25 20:56, Nikola Z. Ivanov wrote:
> > Add check for inode->i_nlink == 1 for directories during unlink,
> > as their value is decremented twice, which can trigger a warning in
> > drop_nlink. In such case mark the filesystem as corrupted and return
> > from the function call with the relevant failure return value.
> > 
> > Additionally add the 2 checks for i_nlink == 0 and i_nlink == 1 in
> > sanity_check_inode in order to detect on-disk corruption early.
> > 
> > Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
> > Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> > Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> > ---
> >  fs/f2fs/inode.c | 10 ++++++++++
> >  fs/f2fs/namei.c | 15 +++++++++++----
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 8c4eafe9ffac..089cbf3646f0 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -294,6 +294,16 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
> >  		return false;
> >  	}
> >  
> > +	if (unlikely(inode->i_nlink == 0)) {
> 
> This is a possible case, as an orphan inode may exist in filesystem after sudden
> power-cut.
> 
> Thanks,
> 

Hi Chao,

Do you suggest that it should not be wrapped in unlikely()?

I also now realise that I intended to wrap the "else if" case
as well but I've missed it in the final patch.

Should I resend the patch with both cases wrapped in "unlikely()"
or would you suggest otherwise?


> > +		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> > +			  __func__, inode->i_ino);
> > +		return false;
> > +	} else if (S_ISDIR(inode->i_mode) && inode->i_nlink == 1) {
> > +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> > +			  __func__, inode->i_ino);
> > +		return false;
> > +	}
> > +
> >  	if (f2fs_has_extra_attr(inode)) {
> >  		if (!f2fs_sb_has_extra_attr(sbi)) {
> >  			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index 40cf80fd9d9a..d13077bad482 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -572,10 +572,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> >  	if (unlikely(inode->i_nlink == 0)) {
> >  		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> >  			  __func__, inode->i_ino);
> > -		err = -EFSCORRUPTED;
> > -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> > -		f2fs_folio_put(folio, false);
> > -		goto out;
> > +		goto corrupted;
> > +	} else if (S_ISDIR(inode->i_mode) && inode->i_nlink == 1) {
> > +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> > +			  __func__, inode->i_ino);
> > +		goto corrupted;
> >  	}
> >  
> >  	f2fs_balance_fs(sbi, true);
> > @@ -601,6 +602,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> >  
> >  	if (IS_DIRSYNC(dir))
> >  		f2fs_sync_fs(sbi->sb, 1);
> > +
> > +	goto out;
> > +corrupted:
> > +	err = -EFSCORRUPTED;
> > +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> > +	f2fs_folio_put(folio, false);
> >  out:
> >  	trace_f2fs_unlink_exit(inode, err);
> >  	return err;
> 

