Return-Path: <linux-kernel+bounces-867631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313AC0327D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F816503A13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3860B348471;
	Thu, 23 Oct 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkZsXp9E"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50A26F463
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246958; cv=none; b=f4oTKVTCuKMu2JZ9oCuftIgTwv1+WtccYpfWjT2T0vdkSmPF9lNkbtOLmjVdP09bVnVwFuoi6z+Y+zhOE7CxkHTZ9AHRQH6RXjuvFxDYfEMDAC5CSHaVV+0YdUyGp3LcUJLGSk2qmAglXVNfAOjPGHiTYoiFHYl5PssNwxOifh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246958; c=relaxed/simple;
	bh=xDGtX73x7SGJPDCIn00jSf/iB9V1rtK1wRwkLEUHB2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke9mplz1DTBsM4pGZdWgXaEFOCLRGjXQr8M7EBst4AKtXvr4bEjR+Ca3NQZCzuP3E2Zfpfh/XBiXjNteOi0nIhT/SiPl3UZ/tKVSLZopzH1pQZcBEgOxnBXfXhPgNgr0wFamyCw9Q9Q5NBFhP7VCipHEwleHzrLBK9TtYRWr9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkZsXp9E; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so259255766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761246955; x=1761851755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz4tyMMkNrLPY/Q/KNDJCFpoha4YVqprZv6N7q9EjLU=;
        b=NkZsXp9E6RNXRd+yp0aCw2Wgx28caWDWTfjPaqDoznZai8bx5kYkasCpPw356BV+aa
         MJon6q3Qyl3QnMpBtCDQ1gh6u4n2VO7WGS8nawmtqMvdygjhSQSWdfBSrI/MpDJIYYZZ
         GAXNBIdQ3dNwMlPzh669X4bm5AoqvjfjNU4o5byY9G1EGYqW8R9U1dwMthnT87ge+Wln
         D+u++MSPgB4BhwH1jq8du8XsHtV7zrzOVQr/hfOtekYnRMXrFMqmwVA5mjfNZnmrBj/P
         kTIWlG6f49CF8WrbDvl6qgTl63QbhvNluHMQ57RvEERku5am/DaXMi3sR44M1MC5C9QN
         oBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761246955; x=1761851755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz4tyMMkNrLPY/Q/KNDJCFpoha4YVqprZv6N7q9EjLU=;
        b=VZX2PcQwB0KTULqTq8rlzxjxGUk5Bup4BDGP2Rxf1udxJtfbqbAfK9fgD8linnvjIg
         vc05sKKEJVNCZT6YpCq5tYJF3LgYtdVePcSy7jyx6XOf1JPK0PlzxclXPkaHaQiVzX0B
         lKbl+C/046+bNm1diPRlpzi/ewT4Sd+Ai6klVe8wpjdlSbTsD/mnxOwEW939AqSSjmCE
         yvqtNz36/SKR+Iu4JhC+hmhXLrpniYxGgno0H7ATKJfsj/C9q+zUXgRTnI7RHMVdSJJ+
         6+styLseej2cP5r+FmEp8mzPxKMVJWzHiHiCC3xXarkz6VtctVGmFBGwm1CJ3DN41Q3p
         fAEg==
X-Forwarded-Encrypted: i=1; AJvYcCVM5GgjiBFHqnsL2VdvMdSzH1ord771hpL8hcIkjiHBLoAj74ROnBLDftTNLiAtCtNnej64RXAysBxL29I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLszfaElNQQG09MnSDJ2kBdu3l2dMVnPj1LdeNdZJveRnsRWdr
	jEzviOPb7mTekBjdTSfbdT0p8G80lI4mTzqOqZEuUbyHVAPNwFPAKygQG1uDkiyt
X-Gm-Gg: ASbGnctL9E+z80aNTqB+rvzJDsXl7PAqMVecFBdhVY7paFo6FW5aMW/oGHKhsvd0qNm
	yP85tKI7vApsLnIY+fw+HWBKRIHvJkwa9UMulL1K/yetT7woUUyC/WIzp60z/obhxcMyNiWQiFp
	+X11Y+VXaDxwPBmNZgOyD1rFP4vm+BxWhAavgGPB/j6Ax164PK9f6XfU2/MC9rzgknneKxGEIfH
	jfZ/rw/Q4jEOCKSV2t84Y8Jd2IWONZmGueaJmn08+zdRWlBV4YeVr7Un7E9T+jC6DHllqulnb1B
	pcPkzuaoQ6F/cyxF9i23PfVieb5mdmlxJ/rQjnr5LzIqAHyKG53uAtiXMUeMteTvXVMhp2sp6d0
	DnTsKAZNmkuPFY6AFPnLl+eMNO/gMQWcg4Ivj+L1LhXMagNTZi6YFVSfqSQ50W/EyKcY5pnclfc
	va9l7/BQsMw0U=
X-Google-Smtp-Source: AGHT+IFQ8zsmfxbVRlBQymGZwkPQggnvEm3GLl2aAuMqOaDpv1htIdjug4OIDiv0YEb5M676Erxv0A==
X-Received: by 2002:a17:907:6e87:b0:b3c:193:820e with SMTP id a640c23a62f3a-b6472c619c0mr3105635166b.13.1761246954536;
        Thu, 23 Oct 2025 12:15:54 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5147240csm285346166b.73.2025.10.23.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 12:15:54 -0700 (PDT)
Date: Thu, 23 Oct 2025 22:15:51 +0300
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org, 
	syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: Perform sanity check before unlinking directory
 inode
Message-ID: <2pro6x6xdvfhaypqhddzlmitx2vo6h7ro5mcqcf5tc7ssvzdls@cge4oegdkf5t>
References: <20251003134731.470392-1-zlatistiv@gmail.com>
 <839306c1-5f7a-4e89-b2cf-7534d279a03c@kernel.org>
 <gupgic53ouhmdwrglwdviw2mzeaqfjsvyr47u3ebu2ztayswy4@4oxvnu252rdb>
 <9d0fef9d-4093-4a80-af3f-6dc45ffe886c@kernel.org>
 <zomib7dzvmnggqqy6aqlwij3zihbvzkzrnfvzhk7tcp2mdgh34@tjjugevo4q4a>
 <235adbae-cc45-4b84-b712-1ba9e5a48dce@kernel.org>
 <wtrkydtrovhsw6azexwq576aoq36ut62y2elhzvsq3ansk477y@2rzc56l46pka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wtrkydtrovhsw6azexwq576aoq36ut62y2elhzvsq3ansk477y@2rzc56l46pka>

On Wed, Oct 15, 2025 at 03:55:40PM +0300, Nikola Z. Ivanov wrote:
> On Wed, Oct 15, 2025 at 02:41:53PM +0800, Chao Yu wrote:
> > On 10/14/25 20:17, Nikola Z. Ivanov wrote:
> > > On Mon, Oct 13, 2025 at 08:53:04PM +0800, Chao Yu wrote:
> > >> On 10/13/25 05:19, Nikola Z. Ivanov wrote:
> > >>> On Thu, Oct 09, 2025 at 10:54:40AM +0800, Chao Yu wrote:
> > >>>> On 10/3/2025 9:47 PM, Nikola Z. Ivanov wrote:
> > >>>>> Current i_nlink corruption check does not take into account
> > >>>>> directory inodes which have one additional i_nlink for their "." entry.
> > >>>>>
> > >>>>> Add additional check and a common corruption path.
> > >>>>>
> > >>>>> Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> > >>>>> Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
> > >>>>> Fixes: 81edb983b3f5 ("f2fs: add check for deleted inode")
> > >>>>> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> > >>>>> ---
> > >>>>>   fs/f2fs/namei.c | 28 ++++++++++++++++++++--------
> > >>>>>   1 file changed, 20 insertions(+), 8 deletions(-)
> > >>>>>
> > >>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > >>>>> index b882771e4699..68b33e8089b0 100644
> > >>>>> --- a/fs/f2fs/namei.c
> > >>>>> +++ b/fs/f2fs/namei.c
> > >>>>> @@ -502,12 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> > >>>>>   		goto out;
> > >>>>>   	}
> > >>>>> -	if (inode->i_nlink == 0) {
> > >>>>> +	if (unlikely(inode->i_nlink == 0)) {
> > >>>>>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> > >>>>>   			  __func__, inode->i_ino);
> > >>>>> -		err = -EFSCORRUPTED;
> > >>>>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> > >>>>> -		goto out_iput;
> > >>>>> +		goto corrupted;
> > >>>>> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> > >>>>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> > >>>>> +			  __func__, inode->i_ino);
> > >>>>> +		goto corrupted;
> > >>>>
> > >>>> Can we detect such corruption in sanity_check_inode() as well? So that if
> > >>>> f2fs internal flow calls f2fs_iget() on corrupted inode, we can set SBI_NEED_FSCK
> > >>>> flag and then triggering fsck repairment later.
> > >>>>
> > >>>> Thanks,
> > >>>>
> > >>>>>   	}
> > >>>>>   	if (IS_ENCRYPTED(dir) &&
> > >>>>> @@ -533,6 +535,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> > >>>>>   	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
> > >>>>>   				ino, IS_ERR(new) ? PTR_ERR(new) : err);
> > >>>>>   	return new;
> > >>>>> +corrupted:
> > >>>>> +	err = -EFSCORRUPTED;
> > >>>>> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> > >>>>>   out_iput:
> > >>>>>   	iput(inode);
> > >>>>>   out:
> > >>>>> @@ -572,10 +577,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> > >>>>>   	if (unlikely(inode->i_nlink == 0)) {
> > >>>>>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> > >>>>>   			  __func__, inode->i_ino);
> > >>>>> -		err = -EFSCORRUPTED;
> > >>>>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> > >>>>> -		f2fs_folio_put(folio, false);
> > >>>>> -		goto fail;
> > >>>>> +		goto corrupted;
> > >>>>> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> > >>>>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> > >>>>> +			  __func__, inode->i_ino);
> > >>>>> +		goto corrupted;
> > >>>>>   	}
> > >>>>>   	f2fs_balance_fs(sbi, true);
> > >>>>> @@ -601,6 +607,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> > >>>>>   	if (IS_DIRSYNC(dir))
> > >>>>>   		f2fs_sync_fs(sbi->sb, 1);
> > >>>>> +
> > >>>>> +	goto fail;
> > >>>>> +corrupted:
> > >>>>> +	err = -EFSCORRUPTED;
> > >>>>> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> > >>>>> +	f2fs_folio_put(folio, false);
> > >>>>>   fail:
> > >>>>>   	trace_f2fs_unlink_exit(inode, err);
> > >>>>>   	return err;
> > >>>>
> > >>>
> > >>> Hi Chao,
> > >>>
> > >>> Thank you for the suggestion.
> > >>> I will add this to sanity_check_inode and remove it
> > >>> from f2fs_lookup as it becomes redundant since f2fs_lookup
> > >>> obtains the inode through f2fs_iget. For f2fs_unlink I will
> > >>> move the i_nlink == 1 check to f2fs_rmdir.
> > >>
> > >> Hi Nikola,
> > >>
> > >> I meant we can move the i_nlink == 1 check from both f2fs_lookup() and
> > >> f2fs_unlink() to sanity_check_inode(), because before we create in-memory
> > >> inode, we will always call sanity_check_inode().
> > >>
> > >> Let me know if you have other concerns.
> > >>
> > >> Thanks,
> > >>
> > > 
> > > The issue here is that sanity_check_inode will be called only when 
> > > we initially read the inode off disk, not when it's already in the cache
> > > 
> > > The syzkaller repro does something like this:
> > > Creates a directory structure /dir1/dir2 where dir1 has
> > > i_nlink == 2, which is one less than it should. It then does
> > > rmdir(/dir1/dir2) followed by rmdir(/dir1) which leads to the warning.
> > 
> > Oh, I missed this case.
> > 
> > > 
> > > In such case what would you say should happen, should the second rmdir
> > > fail and report the corruption, or do we close our eyes and just drop
> > > i_nlink to 0 and possibly log a message that something isn't quite right?
> > 
> > I agreed that we should keep i_nlink == 1 check in f2fs_unlink().
> > 
> > Thanks,
> > 
> 
> Hi Chao,
> 
> Just to make sure we're on the same page, do you mean to keep the check 
> in f2fs_unlink as well as sanity_check_inode, or only do it in f2fs_unlink?
> 

Hello,

Kindly sending a reminder here, could you please
provide input when you have the chance?

Thank you!

> > > 
> > > Thank you,
> > > 
> > >>>
> > >>> I will send v2 as soon as I do some more testing.
> > >>
> > 

