Return-Path: <linux-kernel+bounces-852548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC9BD94CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001141925404
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E24C313546;
	Tue, 14 Oct 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0CChOHF"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76431353E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444231; cv=none; b=JVdG+E5MaQkvyTfCqEofbSUZctr6CO4tcQTQQwRVSU5Z4zt1a+R+GRmLwTOakDUJLerxhHr3ArUSOrCbeRMPaP92hSh9DlcPZuzQzG9/q7MH1LTOSsKB/WEqctgIDULTcJGa10lDtQpJu8UjewOuXNjwffmE1FSr+5rV2Sd/GRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444231; c=relaxed/simple;
	bh=BY6kYeuxEDPJ3ppq84ztaniIfEKi29/fuURVA/vSOH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL+XWWayYu5+sZmCgPB4J/+5r97sI7Ux0gx7VPgkxRNGDF7Qpr7PpL4Bg9oYarwnORNreFwA26Y+vo37mHICH/YfpcQZnNGWH9207Rv341UPJtEKbJkJ0mI2yC3oVXCceZAJejcGhq9+vA5p7KU1jGV9NeOnvGP+l/Y2FttN6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0CChOHF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso840512866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760444227; x=1761049027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m82o4ruRC1Nh+bc2kFllbJdMYTanRIhkJao7LX8GaG0=;
        b=e0CChOHFj5Imj0E+wHXP0TzqK+5XInI/sRL2shwVIk6FEPCrwa9GYlGsRtvjvpjjrD
         wDTCv1oBvOlgQFx2J+955JgRfuGlAl6VKR7NNBlABh9+ju5WY9kM7sa8JjLuFK0hJUty
         SjMaK7eVhhloJpYTdYaslKFAcqmImPrYIa0FNOxlRL3JDo0UA0aqi02lWvM8+MhHp2gs
         0PoVkuh53/++pi0MPCpPHZiIGnJP7zZZ4phfe76ZKndCrilBzke3bIbujAwPZ2mgbKPK
         +NpidzZufEOV2b08IlIgb+cANTItECEGjKCR+H3X39Rwjvueze5yFFlEp7sgCiHn68qf
         rMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444227; x=1761049027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m82o4ruRC1Nh+bc2kFllbJdMYTanRIhkJao7LX8GaG0=;
        b=Qyz7Z1kNiby+nKOIsnH44zJVSC5BL9ijqWMK92hGSDuQVTCfZyrMvYdeB0YiGL7qcL
         7guk40UPkrUoM21y71HCoBZ6E7yosL63gG+Biq+K9Eaa8rqUwDOn1ccsoun7m96vELP7
         rqDiKM0zcD6xdgcNd0/tTbMQU8tmqgXrkQ+Hm13e7QxRRb5Dkp3ac/oFvZsYkAVMpflH
         3eMJz+uGf9BteupT4RVakyKQryjHnVETEeB1JDmvm9ZiDZphwgIWdi/mo9+Sp5iI6ks0
         ZUSoyoh6X6JZSxdi2srV3rOiVyb4qH0PSpWdxsFJVtruYLEvkeRCs9FXlM58q9LwMvuB
         CtqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmZhbaonWyZToeeYIqseuqcfXcwEYR+3UZhvlGre6h1P/4pP0lhTmeyEmRIQPAPGgERE+S3Uej/xtQE+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+aa6C1rCDey+CSJBWV1sL7jPfrwZddKzA+V5JpJH5QbfZ64c2
	kSAa1D/DY7Vy3CXxTC8rwglX+JXMFxgOitrzyvWw5xkx8FLTJVv6aCwU
X-Gm-Gg: ASbGnctMQ2HkNdAB/GxlCeZz3jVDERn5J/RTTG692T8PyYhe3XfdZ57KgdFNNby6QEK
	I6nE77ppM5OFm9arrVmlqjWR8WsdbLxECcEbLZpe3Y+SHncVK6K23y8fc8evP3guV6ZtJ1b6WN9
	PNA7YaiSmLqI9Xvo7t3EMnSDkZyy4XrJm0Gwt09TvmJekFpYA8Y4jw7d9NZxqJeRrQGQzJslMva
	WD0AlCiTlj9D9nywX4aEfByEog1FkubaaQxtB4hgljE02AGCqqR7J66zvfZTIWDdugJLsabzIaH
	sx12tB23wjjx4XxdJj8ADXKkl4P9bdLsDgNPqDdsGGREBr+nOeu70X2s52petVlIs5Q0CQEcB0Y
	0hR8XmsMpgNM8fwkNamSq2B1EUiBVI/uJQ+d+QgLaVEG3TccC+tOpXy/aPowiBdD0jr33T8USwI
	ag10ZZeitF
X-Google-Smtp-Source: AGHT+IGq27w45QLYd+XODJVVnusgATVtS0zDzQLIBAdrmNxLtWSM1Llh13WXNkkw6lvcW1Z8zM/+Pg==
X-Received: by 2002:a17:907:3e22:b0:b3e:b226:5bad with SMTP id a640c23a62f3a-b50a9a6d8a3mr2542115566b.8.1760444227255;
        Tue, 14 Oct 2025 05:17:07 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c129fasm1159133366b.43.2025.10.14.05.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:17:06 -0700 (PDT)
Date: Tue, 14 Oct 2025 15:17:04 +0300
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org, 
	syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: Perform sanity check before unlinking directory
 inode
Message-ID: <zomib7dzvmnggqqy6aqlwij3zihbvzkzrnfvzhk7tcp2mdgh34@tjjugevo4q4a>
References: <20251003134731.470392-1-zlatistiv@gmail.com>
 <839306c1-5f7a-4e89-b2cf-7534d279a03c@kernel.org>
 <gupgic53ouhmdwrglwdviw2mzeaqfjsvyr47u3ebu2ztayswy4@4oxvnu252rdb>
 <9d0fef9d-4093-4a80-af3f-6dc45ffe886c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0fef9d-4093-4a80-af3f-6dc45ffe886c@kernel.org>

On Mon, Oct 13, 2025 at 08:53:04PM +0800, Chao Yu wrote:
> On 10/13/25 05:19, Nikola Z. Ivanov wrote:
> > On Thu, Oct 09, 2025 at 10:54:40AM +0800, Chao Yu wrote:
> >> On 10/3/2025 9:47 PM, Nikola Z. Ivanov wrote:
> >>> Current i_nlink corruption check does not take into account
> >>> directory inodes which have one additional i_nlink for their "." entry.
> >>>
> >>> Add additional check and a common corruption path.
> >>>
> >>> Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> >>> Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
> >>> Fixes: 81edb983b3f5 ("f2fs: add check for deleted inode")
> >>> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> >>> ---
> >>>   fs/f2fs/namei.c | 28 ++++++++++++++++++++--------
> >>>   1 file changed, 20 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> >>> index b882771e4699..68b33e8089b0 100644
> >>> --- a/fs/f2fs/namei.c
> >>> +++ b/fs/f2fs/namei.c
> >>> @@ -502,12 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> >>>   		goto out;
> >>>   	}
> >>> -	if (inode->i_nlink == 0) {
> >>> +	if (unlikely(inode->i_nlink == 0)) {
> >>>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> >>>   			  __func__, inode->i_ino);
> >>> -		err = -EFSCORRUPTED;
> >>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> >>> -		goto out_iput;
> >>> +		goto corrupted;
> >>> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> >>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> >>> +			  __func__, inode->i_ino);
> >>> +		goto corrupted;
> >>
> >> Can we detect such corruption in sanity_check_inode() as well? So that if
> >> f2fs internal flow calls f2fs_iget() on corrupted inode, we can set SBI_NEED_FSCK
> >> flag and then triggering fsck repairment later.
> >>
> >> Thanks,
> >>
> >>>   	}
> >>>   	if (IS_ENCRYPTED(dir) &&
> >>> @@ -533,6 +535,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> >>>   	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
> >>>   				ino, IS_ERR(new) ? PTR_ERR(new) : err);
> >>>   	return new;
> >>> +corrupted:
> >>> +	err = -EFSCORRUPTED;
> >>> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> >>>   out_iput:
> >>>   	iput(inode);
> >>>   out:
> >>> @@ -572,10 +577,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> >>>   	if (unlikely(inode->i_nlink == 0)) {
> >>>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> >>>   			  __func__, inode->i_ino);
> >>> -		err = -EFSCORRUPTED;
> >>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> >>> -		f2fs_folio_put(folio, false);
> >>> -		goto fail;
> >>> +		goto corrupted;
> >>> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
> >>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
> >>> +			  __func__, inode->i_ino);
> >>> +		goto corrupted;
> >>>   	}
> >>>   	f2fs_balance_fs(sbi, true);
> >>> @@ -601,6 +607,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> >>>   	if (IS_DIRSYNC(dir))
> >>>   		f2fs_sync_fs(sbi->sb, 1);
> >>> +
> >>> +	goto fail;
> >>> +corrupted:
> >>> +	err = -EFSCORRUPTED;
> >>> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> >>> +	f2fs_folio_put(folio, false);
> >>>   fail:
> >>>   	trace_f2fs_unlink_exit(inode, err);
> >>>   	return err;
> >>
> > 
> > Hi Chao,
> > 
> > Thank you for the suggestion.
> > I will add this to sanity_check_inode and remove it
> > from f2fs_lookup as it becomes redundant since f2fs_lookup
> > obtains the inode through f2fs_iget. For f2fs_unlink I will
> > move the i_nlink == 1 check to f2fs_rmdir.
> 
> Hi Nikola,
> 
> I meant we can move the i_nlink == 1 check from both f2fs_lookup() and
> f2fs_unlink() to sanity_check_inode(), because before we create in-memory
> inode, we will always call sanity_check_inode().
> 
> Let me know if you have other concerns.
> 
> Thanks,
> 

The issue here is that sanity_check_inode will be called only when 
we initially read the inode off disk, not when it's already in the cache

The syzkaller repro does something like this:
Creates a directory structure /dir1/dir2 where dir1 has
i_nlink == 2, which is one less than it should. It then does
rmdir(/dir1/dir2) followed by rmdir(/dir1) which leads to the warning.

In such case what would you say should happen, should the second rmdir
fail and report the corruption, or do we close our eyes and just drop
i_nlink to 0 and possibly log a message that something isn't quite right?

Thank you,

> > 
> > I will send v2 as soon as I do some more testing.
> 

