Return-Path: <linux-kernel+bounces-854510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659ABBDE8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28143B1734
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D22F1A38F9;
	Wed, 15 Oct 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpD2JpGJ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D20A1DDC08
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532947; cv=none; b=Ne3P3NviVvIfmGksujyRleJDf8rmPctfvWhFDb+ftxYtY/vUFjVO7GkbxwwWKQlayT8ThoNMpH7bJM621fgpzibY3l02e6YqFnkllXbrXDb7uHFZ+wqxn+OLZb5qTktNn5dYLsQrEJHfIO7QwiT59M/u1SCfNUHFQkMnTXQXpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532947; c=relaxed/simple;
	bh=Uz9vn7rcmIwn6i0tqcTn5bYssbsKorpt5cvKeKxZkjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFhwOzhYa0k50/wxzUK7AEzyuzDeqv2+DcHDBW7FqT1myF8yJpzlnqhp81oqTZRDKJgh91k/p+FZBJ8iEJljTumStZM4Ky9tXDWgzPzHTNmxDYkSpRK8HU5irNasdIFX2dqqvvrNyuxz0XQJNwVLp18YxYgTymJl0fup635sBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpD2JpGJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso14612718a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760532944; x=1761137744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPwsFmftjsCu1r4rEdgmSbyTSppcZYsUBCmBP/cNfX8=;
        b=gpD2JpGJttkHeaYUPIw4QsJT9/yWUHAWRyM9iie2rtUktmVbjlhhCFotEyATyD5VWL
         RVgt3syrnwFYqeO/GaOqV9OJ++ACQ8VSQ/XUfHcWMWgOA7j6x4OpIMBy9jx0QWZqv48T
         NEP5htlBNSk3BryvrInOSwWLlz8fay2fifetLPmPXOnhYUUwdSbJL/IQ9iOXQSgHUAyw
         H9bmjenSWIuDO83XEEzro3sk0XEFqhpIKixfw0759RljofjbMljmjCvupJJ1vNFEUdMH
         P+Oblz4yzmxdnaSwNUTomrIl9lJ2A3Ml2UHbPT42IytFvgjwPsmQBE8pYxhAoG/4qdnl
         Xhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760532944; x=1761137744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPwsFmftjsCu1r4rEdgmSbyTSppcZYsUBCmBP/cNfX8=;
        b=n5uMZf613RuBTLpGwJKCCXYelPNdrI7AsJWf6vzpGL2pBUKQjiiGCnxd4tuwUTP2aR
         TIW751P+bKxSMWJZ9q7qfDIGUt/+WuIrpOF4QHi7BmxUWZI3QVROmDz+grT9O5HGLJ3A
         Ne3hD+TJ4RmFWLdZLwLF2oB+z0SUhtyZYK+j6Cpgas8derEdMuMu6+TtDpxNHYERFimC
         QaBLPYQZpJgtwxVb7zsS/hi8BpsNVoqOx9ebeS6TXvgDCaVR6/eCyVhgZCt1gXoiFSbP
         MkxGv9q9oCp7J28ezLnfcX93YAze3xSMHhtlAXaDIU+4wUYmVKqVCFFN5Xohw1S5l+xt
         el/A==
X-Forwarded-Encrypted: i=1; AJvYcCVYzJbZ5WZFjoQj0MdmQ+pKzJJlCJGSD4Dahm7cu/TpGYNuQwoS8ixqhAW81d2PWKVFgHTfeHbJDfIVnJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgRYQQGy1+uCVbYtu6gU0hZhugwbc0I3ybINtSZU1f0CJtDk4
	5sULR/hFTTahOAUCdhkbFFm3oFg9j69FlwHJcgiXvcv0DihHQ3kHhflv
X-Gm-Gg: ASbGncsEfDyqASwes9GT+QRg2x7+xosCr2BY/nXxVfzTC1zHr3Uvey7Vt/mPyDjjyzS
	UYCafb5EtPhKXPy12cb0UW8mpVn2yuCVShwysXZLZNWqB5RjYRjWDWJ6vx1yT/k0rTfrtK+LA/a
	HN4pxwvpooxqs5h8WnZodWCpqBN3rqkIzBBodYKG4471wa00vWrUewaf0i0F7HaO/MT691lxvh4
	uLTQLj0mSt1aR3TzQi6Bb59zNfhnv9ZYW5mgaEY2py07M4d9yhVT6a8JGckeMRIW3EmGoIeos+/
	BfuG24TGoOQznlGcHWrqvvsbpCrEM2U4zqZs4lEZTYD1ZOYLpc/Hb401MLm5oiehnDVsntd0UsT
	2cezuawJu+dJ+6CnaQHG3Nf7ith9txEJre0vS4Wp/mXru8HdXgtNAq3Ae6m9JhwU2L0npOECjmY
	kaCEp3I94tpxtovS+xCWQ=
X-Google-Smtp-Source: AGHT+IFPmVnwrdUH0AaXcNBVVpT7odSzD/MA2yjUQqiuRk8y1WRUilesmSuJ2NFLYUJFWJPhPBgpHA==
X-Received: by 2002:a05:6402:5203:b0:62e:e722:a3c7 with SMTP id 4fb4d7f45d1cf-639d5b8b60emr26613009a12.9.1760532943620;
        Wed, 15 Oct 2025 05:55:43 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63be969163csm2115271a12.13.2025.10.15.05.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 05:55:43 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:55:40 +0300
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org, 
	syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: Perform sanity check before unlinking directory
 inode
Message-ID: <wtrkydtrovhsw6azexwq576aoq36ut62y2elhzvsq3ansk477y@2rzc56l46pka>
References: <20251003134731.470392-1-zlatistiv@gmail.com>
 <839306c1-5f7a-4e89-b2cf-7534d279a03c@kernel.org>
 <gupgic53ouhmdwrglwdviw2mzeaqfjsvyr47u3ebu2ztayswy4@4oxvnu252rdb>
 <9d0fef9d-4093-4a80-af3f-6dc45ffe886c@kernel.org>
 <zomib7dzvmnggqqy6aqlwij3zihbvzkzrnfvzhk7tcp2mdgh34@tjjugevo4q4a>
 <235adbae-cc45-4b84-b712-1ba9e5a48dce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235adbae-cc45-4b84-b712-1ba9e5a48dce@kernel.org>

On Wed, Oct 15, 2025 at 02:41:53PM +0800, Chao Yu wrote:
> On 10/14/25 20:17, Nikola Z. Ivanov wrote:
> > On Mon, Oct 13, 2025 at 08:53:04PM +0800, Chao Yu wrote:
> >> On 10/13/25 05:19, Nikola Z. Ivanov wrote:
> >>> On Thu, Oct 09, 2025 at 10:54:40AM +0800, Chao Yu wrote:
> >>>> On 10/3/2025 9:47 PM, Nikola Z. Ivanov wrote:
> >>>>> Current i_nlink corruption check does not take into account
> >>>>> directory inodes which have one additional i_nlink for their "." entry.
> >>>>>
> >>>>> Add additional check and a common corruption path.
> >>>>>
> >>>>> Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> >>>>> Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
> >>>>> Fixes: 81edb983b3f5 ("f2fs: add check for deleted inode")
> >>>>> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> >>>>> ---
> >>>>>   fs/f2fs/namei.c | 28 ++++++++++++++++++++--------
> >>>>>   1 file changed, 20 insertions(+), 8 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> >>>>> index b882771e4699..68b33e8089b0 100644
> >>>>> --- a/fs/f2fs/namei.c
> >>>>> +++ b/fs/f2fs/namei.c
> >>>>> @@ -502,12 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> >>>>>   		goto out;
> >>>>>   	}
> >>>>> -	if (inode->i_nlink == 0) {
> >>>>> +	if (unlikely(inode->i_nlink == 0)) {
> >>>>>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> >>>>>   			  __func__, inode->i_ino);
> >>>>> -		err = -EFSCORRUPTED;
> >>>>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> >>>>> -		goto out_iput;
> >>>>> +		goto corrupted;
> >>>>> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> >>>>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> >>>>> +			  __func__, inode->i_ino);
> >>>>> +		goto corrupted;
> >>>>
> >>>> Can we detect such corruption in sanity_check_inode() as well? So that if
> >>>> f2fs internal flow calls f2fs_iget() on corrupted inode, we can set SBI_NEED_FSCK
> >>>> flag and then triggering fsck repairment later.
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>   	}
> >>>>>   	if (IS_ENCRYPTED(dir) &&
> >>>>> @@ -533,6 +535,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> >>>>>   	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
> >>>>>   				ino, IS_ERR(new) ? PTR_ERR(new) : err);
> >>>>>   	return new;
> >>>>> +corrupted:
> >>>>> +	err = -EFSCORRUPTED;
> >>>>> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> >>>>>   out_iput:
> >>>>>   	iput(inode);
> >>>>>   out:
> >>>>> @@ -572,10 +577,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> >>>>>   	if (unlikely(inode->i_nlink == 0)) {
> >>>>>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> >>>>>   			  __func__, inode->i_ino);
> >>>>> -		err = -EFSCORRUPTED;
> >>>>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> >>>>> -		f2fs_folio_put(folio, false);
> >>>>> -		goto fail;
> >>>>> +		goto corrupted;
> >>>>> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> >>>>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> >>>>> +			  __func__, inode->i_ino);
> >>>>> +		goto corrupted;
> >>>>>   	}
> >>>>>   	f2fs_balance_fs(sbi, true);
> >>>>> @@ -601,6 +607,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> >>>>>   	if (IS_DIRSYNC(dir))
> >>>>>   		f2fs_sync_fs(sbi->sb, 1);
> >>>>> +
> >>>>> +	goto fail;
> >>>>> +corrupted:
> >>>>> +	err = -EFSCORRUPTED;
> >>>>> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> >>>>> +	f2fs_folio_put(folio, false);
> >>>>>   fail:
> >>>>>   	trace_f2fs_unlink_exit(inode, err);
> >>>>>   	return err;
> >>>>
> >>>
> >>> Hi Chao,
> >>>
> >>> Thank you for the suggestion.
> >>> I will add this to sanity_check_inode and remove it
> >>> from f2fs_lookup as it becomes redundant since f2fs_lookup
> >>> obtains the inode through f2fs_iget. For f2fs_unlink I will
> >>> move the i_nlink == 1 check to f2fs_rmdir.
> >>
> >> Hi Nikola,
> >>
> >> I meant we can move the i_nlink == 1 check from both f2fs_lookup() and
> >> f2fs_unlink() to sanity_check_inode(), because before we create in-memory
> >> inode, we will always call sanity_check_inode().
> >>
> >> Let me know if you have other concerns.
> >>
> >> Thanks,
> >>
> > 
> > The issue here is that sanity_check_inode will be called only when 
> > we initially read the inode off disk, not when it's already in the cache
> > 
> > The syzkaller repro does something like this:
> > Creates a directory structure /dir1/dir2 where dir1 has
> > i_nlink == 2, which is one less than it should. It then does
> > rmdir(/dir1/dir2) followed by rmdir(/dir1) which leads to the warning.
> 
> Oh, I missed this case.
> 
> > 
> > In such case what would you say should happen, should the second rmdir
> > fail and report the corruption, or do we close our eyes and just drop
> > i_nlink to 0 and possibly log a message that something isn't quite right?
> 
> I agreed that we should keep i_nlink == 1 check in f2fs_unlink().
> 
> Thanks,
> 

Hi Chao,

Just to make sure we're on the same page, do you mean to keep the check 
in f2fs_unlink as well as sanity_check_inode, or only do it in f2fs_unlink?

> > 
> > Thank you,
> > 
> >>>
> >>> I will send v2 as soon as I do some more testing.
> >>
> 

