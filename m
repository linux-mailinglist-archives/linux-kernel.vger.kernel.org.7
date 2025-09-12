Return-Path: <linux-kernel+bounces-813831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B96B54B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09867BBA22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6BB30100C;
	Fri, 12 Sep 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHxWUjLp"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AA41C62
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677294; cv=none; b=BAbxQqZgbvmODh6c5Gs3yq7GxwOoZPd0/fHv1RumZmf9miUHjdh5UdK8FyAYVtWX7pGmQ9gjZ1C4HUX6+lWc5Hj/7HCVf7HwZKlJ+2+WLL6Vg2hFApfmzCsf4CynZmkjepx8g0hqI5ZCtIj5TpgZbMS8lunJ7imu6+tHDMcPFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677294; c=relaxed/simple;
	bh=qubTz5NccQylmMb5eGhEQxlCqsEwtuA4w4VK8zXpUhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCiwArNOTkhN2LBmrkYfPOoXrZCgA7+PKl68jFBHB++o8XofT/Btdj5zI1cwDbhWG/KJt+OU5VmVKMG11JI86QK+VrtZOr6gKcdAGmGFfK2nirMZL3zZnmO4S5SFIWvrKl4ZfG2BCkk8+U215f1dZ45z0VUxoEIRThMsh9Ocirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHxWUjLp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso121798a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757677291; x=1758282091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhHoQcsUdIg61AwKHb7zq+yf4BOBAwDoM26hBqxnzm0=;
        b=KHxWUjLp3RlkqJpznurnNxsm0jPRUNVwhha0KpRvI7WrQO3368sFvpadgoTXlWf8TJ
         VjahfasgMSRR//hYxf072pCgn3SZuoH3EHVOGUkUVqMis4sou+BSSGEU7QAs1+TnX9kh
         DlEpsrtaSk/WUO8wyc5SiFlArdbchiAsP1Zl8oGpkSQBB0tKTJoRFkU6CR4UAeT0N6F7
         EnzIcEcc8yZLlez/2xbFqnKDrrpfCeCmO9mWbdM6fR24xXmqxB9RkypSi5tUt9+saJMR
         VqvJJhm0tdDfP8e5yTaurk9kr5Sejp7GwVO+sEqkhzGKJnBcDyk5pxjPwmm1XMp0eG03
         5g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757677291; x=1758282091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhHoQcsUdIg61AwKHb7zq+yf4BOBAwDoM26hBqxnzm0=;
        b=W9UfKi5A20HYH0D0yLzM7/phK7rndUv9e3Ux7a/T8mA0KH72FLdlm4k7Ujcj8FzcJ6
         VXndqfv1KBJjtlBDBLBBc2iJZaHDqUPW4H7YMbI4IiPjg6la1F2mJdcHnBY8+ceubQjh
         VokA8Ac6atIKmYlptRjSJ/Lbb32PXZssvHgkrBcMhHKh64TVkL0ovLocr5yIgNfmsi76
         jlOsmhnGyI5N7Ou6R2vY4c0NReW+Yop9c88qggTeXzUB9jm2LVtuH5BGghHPyAvZWzuD
         1smyiYGkpi4wWTvLAE41olyXDayTOl7rvCE7mHyRTeZUoWioJn9Lr7NUkobbOE10aKFP
         sQyg==
X-Forwarded-Encrypted: i=1; AJvYcCWNQcisZEbc9hgiiXV2PdlEL7kj7n9tX/VdrOQP3fAGWPZotzp4owMDQfoHIvgPviZv/jaSqlVTdxswgnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XnTeB/WMWfKxeaE0a7evxdulLThV2Mk3seLv2jw+gy5xKzgV
	7FnbCvUzKltiKipM5JGr4lBLWTyzX+xoFCJy3ECqsS0HbNIL2qmexoPK2IsClI3k1DSFIkILJ7/
	2uYKT7Qfsh3jhZ71Ee9lvvkxesFzAbjs=
X-Gm-Gg: ASbGncux38D74DbNPo0+AYKm8WzSBNEzKJifiFbhwvirEcbs4uANDOV9/e5/hJ7sNOQ
	kj9MaGdIsTziVhY1OFhZgxDmqbifS5Ma/Vdid+s+D42eKizAWQGCFCJUw1/tK0P2yMMAABkE8EQ
	dcVUsNwRzScnwuNhy6PFG8r9UtWEwN5K8uZx5xoLdqBBtriAHrQXfUdB3d8fiX2S9XyBXgH+/7C
	E1Fx3YE5YThiIISWQ==
X-Google-Smtp-Source: AGHT+IFCX157Ka/Iz69jCoqTNuyf01bBoVnyqpL5tf/MmTv7L1D4o9MBDY6xT7cl3eRR3U0HJheMV5AGQH0ph9VTL4s=
X-Received: by 2002:a05:6402:44d2:b0:62c:75bf:651f with SMTP id
 4fb4d7f45d1cf-62ed81ff6f2mr2490531a12.7.1757677291315; Fri, 12 Sep 2025
 04:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8734afp0ct.fsf@igalia.com> <20250729233854.GV2672029@frogsfrogsfrogs>
 <20250731130458.GE273706@mit.edu> <20250731173858.GE2672029@frogsfrogsfrogs>
 <8734abgxfl.fsf@igalia.com> <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
In-Reply-To: <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Sep 2025 13:41:20 +0200
X-Gm-Features: Ac12FXyfcx1I1A6DzNI7vt2tGVPYgJjPcG1Xvt4gHuNmpuaiHvH8En0aZLVYcic
Message-ID: <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Luis Henriques <luis@igalia.com>, "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:31=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
>
>
> On 8/1/25 12:15, Luis Henriques wrote:
> > On Thu, Jul 31 2025, Darrick J. Wong wrote:
> >
> >> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
> >>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> >>>>
> >>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfu=
se
> >>>> could restart itself.  It's unclear if doing so will actually enable=
 us
> >>>> to clear the condition that caused the failure in the first place, b=
ut I
> >>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> >>>> aren't totally crazy.
> >>>
> >>> I'm trying to understand what the failure scenario is here.  Is this
> >>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, wha=
t
> >>> is supposed to happen with respect to open files, metadata and data
> >>> modifications which were in transit, etc.?  Sure, fuse2fs could run
> >>> e2fsck -fy, but if there are dirty inode on the system, that's going
> >>> potentally to be out of sync, right?
> >>>
> >>> What are the recovery semantics that we hope to be able to provide?
> >>
> >> <echoing what we said on the ext4 call this morning>
> >>
> >> With iomap, most of the dirty state is in the kernel, so I think the n=
ew
> >> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, whi=
ch
> >> would initiate GETATTR requests on all the cached inodes to validate
> >> that they still exist; and then resend all the unacknowledged requests
> >> that were pending at the time.  It might be the case that you have to
> >> that in the reverse order; I only know enough about the design of fuse
> >> to suspect that to be true.
> >>
> >> Anyhow once those are complete, I think we can resume operations with
> >> the surviving inodes.  The ones that fail the GETATTR revalidation are
> >> fuse_make_bad'd, which effectively revokes them.
> >
> > Ah! Interesting, I have been playing a bit with sending LOOKUP requests=
,
> > but probably GETATTR is a better option.
> >
> > So, are you currently working on any of this?  Are you implementing thi=
s
> > new NOTIFY_RESTARTED request?  I guess it's time for me to have a close=
r
> > look at fuse2fs too.
>
> Sorry for joining the discussion late, I was totally occupied, day and
> night. Added Kevin to CC, who is going to work on recovery on our
> DDN side.
>
> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
> server restart we want kernel to recover inodes and their lookup count.
> Now inode recovery might be hard, because we currently only have a
> 64-bit node-id - which is used my most fuse application as memory
> pointer.
>
> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
> outstanding requests. And that ends up in most cases in sending requests
> with invalid node-IDs, that are casted and might provoke random memory
> access on restart. Kind of the same issue why fuse nfs export or
> open_by_handle_at doesn't work well right now.
>
> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
> would not return a 64-bit node ID, but a max 128 byte file handle.
> And then FUSE_REVALIDATE_FH on server restart.
> The file handles could be stored into the fuse inode and also used for
> NFS export.
>
> I *think* Amir had a similar idea, but I don't find the link quickly.
> Adding Amir to CC.

Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yU=
Y4L2JRAEKxEwOQ@mail.gmail.com/

>
> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
> will iterate over all superblock inodes and mark them with fuse_make_bad.
> Any objections against that?

IDK, it seems much more ugly than implementing LOOKUP_HANDLE
and I am not sure that LOOKUP_HANDLE is that hard to implement, when
comparing to this alternative.

I mean a restartable server is going to be a new implementation anyway, rig=
ht?
So it makes sense to start with a cleaner and more adequate protocol,
does it not?

Thanks,
Amir.

