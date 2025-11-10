Return-Path: <linux-kernel+bounces-892739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E54A9C45B99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94FF74ECA99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39486301716;
	Mon, 10 Nov 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLg0eIj5"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517F3016FF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768015; cv=none; b=jJVAbJJDyecZMpr3oU4N0vaestZ1UdEZsHA3sP3D1DdOvp07djFlK5HalZrQ/55xBwFHWqSBegyBfM/e75D66Qb6m3ItyI3d86FJ+8QLjX2lVtJOnwsnDZgdgB3BYM97cMhuA0nud9+VJQqwFePDfNgJRZOsAnQ3GE65Bsz8pN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768015; c=relaxed/simple;
	bh=CMt1MZH33HnJ84TQselvVK6jjQYs+rqYxBGmLrt6Q0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXjFwvPXEoeeyNQUAl7x8HOEKkShVa4Zyfz0w+zE7PDE13rgA4z0hsm18epvN56dkWPcI1YSyHj41Qn8JGwWjxdE30GOGtlgJwqPGARN6rtd8vQemAn7EImsM6Y5hTSJBTLzqjBrycVJVWBlGGbEvftAc32KmfJsVu07GC3c0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLg0eIj5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b725ead5800so363757666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762768011; x=1763372811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/ovt5MPxQ2FIrqG2/VX1hDiIlAD6fZ0gfPyzLgRrV4=;
        b=SLg0eIj5Zwc3dUGLxTfz9y7Xa6PAMVzAwB5VYBNF6NhzXXr7YzWUrMrSGkplLRfK00
         5HX4lUSEHipWBCMG3cr7CDhHZdyyY2ANGTqNORDZLJvTOAV3LWZ9e03BWhRviGKgPOWd
         8+MowBjuxJ7dnOlVqR2WhlYqrCrRg+SShshli7wJe6Hz8wl0s4QgYfTvYYVtPsMasMLT
         6Jddc2pEj5DDDwzxp6S3aLHAGLwznmFo70j7vyfJMgQOeDogySWnIryq1NRn0ke2Zw3P
         59PK5BxcilL/HeGTnOWYI9h65XW1ouAmN0zzfKfXO5W3t55euoFKmKejW++Z0+mAM9Ky
         ArSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768011; x=1763372811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/ovt5MPxQ2FIrqG2/VX1hDiIlAD6fZ0gfPyzLgRrV4=;
        b=i4Z/HZvhhrZxIY7QHKN5LmgEEnv95No4CAYA0L95i9wJ0AEl43uqWmCgDDtR8/LBUj
         1qlFK6ufC0etY9PCkpJTMgdOS4XaTT77mfciESn+WisYvR+ehMvV0d0zufl9nb66tHlu
         GQTnHR+ZZFasazWDZ6EvQK0xt6Ur0C7TdNmaf+lgFDbFsL9RHV2Y8HzTRhOL5+LepsgH
         g5PqoFJjJJhQGm74ZluIlQ1uCbvHu+moRaAasj3zaNtFwPZeZMxQiCKP7EeX1TvHhG7g
         AaWOuX9RPZG8FJDw/yYTXZ0pWjLgHShyGaE/0GWORpDg8wPLqeA+eZim30OQVx49ziUI
         HVYg==
X-Forwarded-Encrypted: i=1; AJvYcCWItJepHod6fX91V39yT3Edo5FSa9L8KtFD2vsKAz3N/3rUHrRDutY1Jk7uOXU4ovvDT6w6BEciL+o5aIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRTgP6ki3qVXXu9ZEp/Eh8/ujxdzcG1Df+RykcLzi5l4MZAQA
	IJk7jOKQy/XcY/50H01ItDAomFXcPnlu8bkybrkpLPCeE4nk5Mahtn/y7qHq+h+bKBjNH7lQQSM
	KNKBLFvsof62X4axA7j24sKN7CPRJuZY=
X-Gm-Gg: ASbGncvChIOK8vg93gSlmXpzNoB6Z80uh0fPvIDqzdCd9vZ+zrsJPwjiPETvxuc8Nf4
	vmg6zoFsTpOpcsRlj5QEZmvPgklWc5zULtDi3Zmg8hNeedG9yGd7u0u5F8E6PulxY2Rhoz8424j
	QfS/I7CrdqgU3A2ieXL/l7ZAvw+Bj1tMHoxdiDRX3XPTN+cpzMOEjCXpZSKevCVB6NUuwx1olxh
	CHXpQooE0BgjuADbLJHqFC86+gaUzyujpFtHLjKUM1TY7Yin1O7T2y51mO7MxGL8XebHXKz0GxI
	V7e5dpWwE4BBRonVmCBCYC5qmA==
X-Google-Smtp-Source: AGHT+IEoKLfAe2FfPoMHA67eOqnteZmmOo0KF438w43IyKgIKdr3QG4qa0leY++FvGjwLA2ymO4i/30zOjjBSZ7+xzg=
X-Received: by 2002:a17:906:ee84:b0:b6d:7d46:52b2 with SMTP id
 a640c23a62f3a-b72e02da93bmr875921466b.15.1762768010766; Mon, 10 Nov 2025
 01:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107142149.989998-1-mjguzik@gmail.com> <20251107142149.989998-2-mjguzik@gmail.com>
 <qfoni4sufho6ruxsuxvcwnw4xryptydtt3wimsflf7kwfcortf@372gbykgkctf>
In-Reply-To: <qfoni4sufho6ruxsuxvcwnw4xryptydtt3wimsflf7kwfcortf@372gbykgkctf>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 10 Nov 2025 10:46:38 +0100
X-Gm-Features: AWmQ_bmdy8eSZOKz8pVlw7NsZNd5Ee0ac-ZGxBkyCNQF7V1zDE2m2mrA2-AOaWc
Message-ID: <CAGudoHGz6PXi+DLiWjzwLuYq=c+oiA1cWTUt1RmHw5QOt6DAsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: speed up path lookup with cheaper handling of MAY_EXEC
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:32=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 07-11-25 15:21:47, Mateusz Guzik wrote:
> > The generic inode_permission() routine does work which is known to be o=
f
> > no significance for lookup. There are checks for MAY_WRITE, while the
> > requested permission is MAY_EXEC. Additionally devcgroup_inode_permissi=
on()
> > is called to check for devices, but it is an invariant the inode is a
> > directory.
> >
> > Absent a ->permission func, execution lands in generic_permission()
> > which checks upfront if the requested permission is granted for
> > everyone.
> >
> > We can elide the branches which are guaranteed to be false and cut
> > straight to the check if everyone happens to be allowed MAY_EXEC on the
> > inode (which holds true most of the time).
> >
> > Moreover, filesystems which provide their own ->permission routine can
> > take advantage of the optimization by setting the IOP_FASTPERM_MAY_EXEC
> > flag on their inodes, which they can legitimately do if their MAY_EXEC
> > handling matches generic_permission().
> >
> > As a simple benchmark, as part of compilation gcc issues access(2) on
> > numerous long paths, for example /usr/lib/gcc/x86_64-linux-gnu/12/crten=
dS.o
> >
> > Issuing access(2) on it in a loop on ext4 on Sapphire Rapids (ops/s):
> > before: 3797556
> > after:  3987789 (+5%)
> >
> > Note: this depends on the not-yet-landed ext4 patch to mark inodes with
> > cache_no_acl()
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> The gain is nice. I'm just wondering where exactly is it coming from? I
> don't see that we'd be saving some memory load or significant amount of
> work. So is it really coming from the more compact code and saved several
> unlikely branches and function calls?
>

That's several branches and 2 function calls per path component on the
way to the terminal inode. In the path at hand, that's 10 function
calls elided.

>                                                                 Honza
>
> > ---
> >  fs/namei.c         | 43 +++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/fs.h | 13 +++++++------
> >  2 files changed, 48 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index a9f9d0453425..6b2a5a5478e7 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -540,6 +540,9 @@ static inline int do_inode_permission(struct mnt_id=
map *idmap,
> >   * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
> >   *
> >   * Separate out file-system wide checks from inode-specific permission=
 checks.
> > + *
> > + * Note: lookup_inode_permission_may_exec() does not call here. If you=
 add
> > + * MAY_EXEC checks, adjust it.
> >   */
> >  static int sb_permission(struct super_block *sb, struct inode *inode, =
int mask)
> >  {
> > @@ -602,6 +605,42 @@ int inode_permission(struct mnt_idmap *idmap,
> >  }
> >  EXPORT_SYMBOL(inode_permission);
> >
> > +/**
> > + * lookup_inode_permission_may_exec - Check traversal right for given =
inode
> > + *
> > + * This is a special case routine for may_lookup() making assumptions =
specific
> > + * to path traversal. Use inode_permission() if you are doing somethin=
g else.
> > + *
> > + * Work is shaved off compared to inode_permission() as follows:
> > + * - we know for a fact there is no MAY_WRITE to worry about
> > + * - it is an invariant the inode is a directory
> > + *
> > + * Since majority of real-world traversal happens on inodes which gran=
t it for
> > + * everyone, we check it upfront and only resort to more expensive wor=
k if it
> > + * fails.
> > + *
> > + * Filesystems which have their own ->permission hook and consequently=
 miss out
> > + * on IOP_FASTPERM can still get the optimization if they set IOP_FAST=
PERM_MAY_EXEC
> > + * on their directory inodes.
> > + */
> > +static __always_inline int lookup_inode_permission_may_exec(struct mnt=
_idmap *idmap,
> > +     struct inode *inode, int mask)
> > +{
> > +     /* Lookup already checked this to return -ENOTDIR */
> > +     VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode), inode);
> > +     VFS_BUG_ON((mask & ~MAY_NOT_BLOCK) !=3D 0);
> > +
> > +     mask |=3D MAY_EXEC;
> > +
> > +     if (unlikely(!(inode->i_opflags & (IOP_FASTPERM | IOP_FASTPERM_MA=
Y_EXEC))))
> > +             return inode_permission(idmap, inode, mask);
> > +
> > +     if (unlikely(((inode->i_mode & 0111) !=3D 0111) || !no_acl_inode(=
inode)))
> > +             return inode_permission(idmap, inode, mask);
> > +
> > +     return security_inode_permission(inode, mask);
> > +}
> > +
> >  /**
> >   * path_get - get a reference to a path
> >   * @path: path to get the reference to
> > @@ -1855,7 +1894,7 @@ static inline int may_lookup(struct mnt_idmap *id=
map,
> >       int err, mask;
> >
> >       mask =3D nd->flags & LOOKUP_RCU ? MAY_NOT_BLOCK : 0;
> > -     err =3D inode_permission(idmap, nd->inode, mask | MAY_EXEC);
> > +     err =3D lookup_inode_permission_may_exec(idmap, nd->inode, mask);
> >       if (likely(!err))
> >               return 0;
> >
> > @@ -1870,7 +1909,7 @@ static inline int may_lookup(struct mnt_idmap *id=
map,
> >       if (err !=3D -ECHILD)     // hard error
> >               return err;
> >
> > -     return inode_permission(idmap, nd->inode, MAY_EXEC);
> > +     return lookup_inode_permission_may_exec(idmap, nd->inode, 0);
> >  }
> >
> >  static int reserve_stack(struct nameidata *nd, struct path *link)
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 03e450dd5211..7d5de647ac7b 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -647,13 +647,14 @@ is_uncached_acl(struct posix_acl *acl)
> >       return (long)acl & 1;
> >  }
> >
> > -#define IOP_FASTPERM 0x0001
> > -#define IOP_LOOKUP   0x0002
> > -#define IOP_NOFOLLOW 0x0004
> > -#define IOP_XATTR    0x0008
> > +#define IOP_FASTPERM         0x0001
> > +#define IOP_LOOKUP           0x0002
> > +#define IOP_NOFOLLOW         0x0004
> > +#define IOP_XATTR            0x0008
> >  #define IOP_DEFAULT_READLINK 0x0010
> > -#define IOP_MGTIME   0x0020
> > -#define IOP_CACHED_LINK      0x0040
> > +#define IOP_MGTIME           0x0020
> > +#define IOP_CACHED_LINK              0x0040
> > +#define IOP_FASTPERM_MAY_EXEC        0x0080
> >
> >  /*
> >   * Inode state bits.  Protected by inode->i_lock
> > --
> > 2.48.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

