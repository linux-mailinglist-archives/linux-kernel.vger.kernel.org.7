Return-Path: <linux-kernel+bounces-855323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E0FBE0E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98D01A212BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25645305E26;
	Wed, 15 Oct 2025 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bRv3Iqc9"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7D30505E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566012; cv=none; b=B4dCxdT+j9G2mB9u4t3AQNEkrS72QymdAcpqCJlxdzCkagj8BQMIrjlm0FPHj4e9gZUHzuyWJP3ryY+3uujaezyrMd3wXVjzz3NV1z5wzohbLWjOALAr5xPDyK1jezyOxK20T+ccE6WETcOfriI99QH+wzWBClE/WJwapIApoGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566012; c=relaxed/simple;
	bh=Wdpn2gTjQJBFZWl/cSLc/YQoQqtEHLVGvOPx+0pSDek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b46cWWkznauZhkMU8QyaxgYLOZhflv8y+TITj/D3Ln4+7XG7zJ9u1nsvUNKzo4ebCqH17PnDnyhI310fcED3yFNkUrPDldreZ9JI4v5gfXVjYMKTjCd0DBY6qr0jI2OdNEvFDjqhUtaViq2LzWhhXZm6/fAAL5I0t3wOdMhMhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bRv3Iqc9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33067909400so82025a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760566010; x=1761170810; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M6eApBBDQQL/Q0ea8jzVs7vVBk+VLf27Z3qhgm/L8eI=;
        b=bRv3Iqc9FEJ5J2g2UTfE4Tkljw64+G5CFEGGhMGkaDDmAImRVEVmXuW2Zpun6MFr+U
         zJUerIu31tZ8jIEKVOmIwL3wqI5C6K2+nnNRmcgMLvKglF4gwx322QisWM5aS4dyJygy
         /JNWrhr4Tlqe/tv85QvhMcTbK+ykeukpVuKVuQILU+wmujb1hN0YuyRRetvmynrzcktu
         YMpmZtiW4U6ow0dyqdEqVxrZdP/PinkTNWdwRF+nOauKXyCalw+1364F/dazvW62m13m
         4+HXXzo10FLiRO54cpoCsG2x60E5uYXMqNZa3zltcIjzGlrspz7tv2vGactXkodWeybB
         KSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566010; x=1761170810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6eApBBDQQL/Q0ea8jzVs7vVBk+VLf27Z3qhgm/L8eI=;
        b=n4MjV+2CjKzpd3qo/RXQGb7+Cfu+L07JXTjjuqCtMnpTY3okAaj6UJAx/vGJP8koSm
         gzZwViwIHyqe+wGToBgmukGCUdEHsvRSdfDaaBam5qjGyTi8Sl6mpOeClcnKaejSXfpR
         q47XqCWdcIm5uaHYUzm2nZQoPfXcHXllhjl2rdwSdyWPgFDv5URIS4BrvR2otf0o+Klo
         tN0qDRzpWaismanqofOn6gYW9IDdVwPtl8u3XG+Jo7MPvQg4kTYSdhlqwmFNxWBQNxcd
         OP66GRPbKVdFBQ8QzKW6ki23n8GN02bFI7wnHfFDhvqKo+HQvPwyQkjlKIFANB/sj0d7
         rcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmVNQabKcnem6YrZVAHBlNfkLAU7vr8uNVfniP8TOi6jnurkCKg7PDbB/HxdZ1WdDBo2KYg9aiydqvw1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6uG6ZvDo8KMB/pBIoJFUIrh1bp06gFh7PxVtqJzkBmKyc3Zl
	1J5aHWe0U+mSGeTC0vJk8z9cfgX3ABfSgHLrUiNQZZ2ENy7kQJPLpZIc4vmh40wSpfA=
X-Gm-Gg: ASbGncs3UkoDaMcNcJQPi5xWEqNap7Dha4QUnS40puoKrTbKX4ugHQ4T9lDxFNKw7DM
	E8b5uNWASc2F1aHOBfJRYAFS2oPzLRHp2taPLV/Gj9k8HIm5LXvAclz+90baq/Hfr9Kz7P7W0Fc
	n0L1x+VX2Kmm4wTJ3kiP9nehmX54CM/MUyLH+Yfm0mJfPVERMP+qVBONE7gLJYTpq6t8Jj8oHbr
	SxSIR0gMYJTHP9rA35j7jiF+vHzpYOeFT0BjUWAZPFRVGLwkaprlhNgFTgb8QxVSZqx/VW4in9E
	pL+SJn4LNo+izFLbtOIDuUJyBfn8c/PvA4upobOUwiAWGoNcMjHSDo2HUB1lHFCA8TXc93HYqMz
	xoztUUxcSR9s6cF7GHCutsitC7zwFqH4okxfmG+mIeVIQEkHEgCL3SUpB7Wa8Fy6DGa/hoZ2cOD
	s5II62k17ApN197FJ3ZF3IpJsza8sHITQVSW9wMP/tLsheKryrYpho7fbPSjwZvw==
X-Google-Smtp-Source: AGHT+IFm6y/lppOf0Edu2tNY3405NaNnHIA0Sq0GymYj/emWFWGXsYmduItLrpe8rLNIyLezcWkacw==
X-Received: by 2002:a17:90b:1b11:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-33b513a1ffbmr41330010a91.35.1760566009498;
        Wed, 15 Oct 2025 15:06:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33badfe8abdsm71776a91.1.2025.10.15.15.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:06:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v99dt-0000000FKma-1fVY;
	Thu, 16 Oct 2025 09:06:45 +1100
Date: Thu, 16 Oct 2025 09:06:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
Message-ID: <aPAa9fz-4OG_9pVX@dread.disaster.area>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-4-mjguzik@gmail.com>
 <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
 <CAGudoHFJxFOj=cbxcjmMtkzXCagg4vgfmexTG1e_Fo1M=QXt-g@mail.gmail.com>
 <aO7NqqB41VYCw4Bh@dread.disaster.area>
 <CAGudoHFpoo0Qm=b4Z85tbJJmhh+vmSHuNnm3pVaLaQsmX9mURg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFpoo0Qm=b4Z85tbJJmhh+vmSHuNnm3pVaLaQsmX9mURg@mail.gmail.com>

On Wed, Oct 15, 2025 at 07:46:39AM +0200, Mateusz Guzik wrote:
> On Wed, Oct 15, 2025 at 12:24 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Oct 10, 2025 at 05:51:06PM +0200, Mateusz Guzik wrote:
> > > On Fri, Oct 10, 2025 at 4:44 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> > > > > +static inline void inode_state_set_raw(struct inode *inode,
> > > > > +                                    enum inode_state_flags_enum flags)
> > > > > +{
> > > > > +     WRITE_ONCE(inode->i_state, inode->i_state | flags);
> > > > > +}
> > > >
> > > > I think this shouldn't really exist as it is dangerous to use and if we
> > > > deal with XFS, nobody will actually need this function.
> > > >
> > >
> > > That's not strictly true, unless you mean code outside of fs/inode.c
> > >
> > > First, something is still needed to clear out the state in
> > > inode_init_always_gfp().
> > >
> > > Afterwards there are few spots which further modify it without the
> > > spinlock held (for example see insert_inode_locked4()).
> > >
> > > My take on the situation is that the current I_NEW et al handling is
> > > crap and the inode hash api is also crap.
> >
> > The inode hash implementation is crap, too. The historically poor
> > scalability characteristics of the VFS inode cache is the primary
> > reason we've never considered ever trying to port XFS to use it,
> > even if we ignore all the inode lifecycle issues that would have to
> > be solved first...
> >
> 
> I don't know of anyone defending the inode hash tho. The performance
> of the thing was already bashed a few times, I did not see anyone
> dunking on the API ;)

I think it goes without saying that the amount of
similar-but-slightly-different-and-inconsistently-named functions
that have simply grown organically as individual fs needs have
occurred has resulted in a bit of a mess that nobody really wants to
tackle... :/

> > > For starters freshly allocated inodes should not be starting with 0,
> > > but with I_NEW.
> >
> > Not all inodes are cached filesystem inodes. e.g. anonymous inodes
> > are initialised to inode->i_state = I_DIRTY.  pipe inodes also start
> > at I_DIRTY. socket inodes don't touch i_state at init, so they
> > essentially init i_state = 0....
> >
> > IOWs, the initial inode state depends on what the inode is being
> > used for, and I_NEW is only relevant to inodes that are cached and
> > can be found before the filesystem has fully initialised the VFS
> > inode.
> >
> 
> Well it is true that currently the I_NEW flag is there to help out
> entities like the hash inode hash.
> 
> I'm looking to change it into a generic indicator of an uninitialized
> inode. This is completely harmless for the consumers which currently
> operate on inodes which never had the flag.
> 
> Here is one use: I'd like to introduce a mandatory routine to call
> when the filesystem at hand claims the inode is ready to use.

I like the idea, but I don't think that overloading I_NEW is the
right thing to do nor is it that simple.

e.g. We added the I_CREATING state years ago as a subset of I_NEW so
that VFS inodes being instantiated can't be found -at all- by the
open-by-handle interface doing direct inode hash lookups. However,
only some of the inode hash APIs add this flag, and only overlay as
a filesystem adds it in certain circumstances.

IOWs, even during initialisation, different filesystems need to
behave differently w.r.t. how the core VFS performs various
operations on the inode during the initialisation stage...

FWIW, XFS has the XFS_INEW state that wraps around the outside of
the VFS inode initialisation process that prevents it from being
found via any type of inode cache lookup (internal or external)
until the inode is fully initialised.

IOWs, features that XFS has
supported for 25+ years (like open-by-handle) is supported natively
by the XFS inode cache and the XFS inode life cycle state machine.

In contrast, The way the VFS inode cache handles stuff like this is
very much a hacked-in "oops we didn't think of that" after-thought
that doesn't actually cover all the different APIs or filesystems...

> Said routine would have 2 main purposes:
> - validate the state of the inode (for example that a valid mode is
> set; this would have caught some of the syzkaller bugs from the get
> go)

I think that's going to be harder than it sounds (speaking as the
architect of the comprehensive on-disk metadata validation
infrastructure in XFS).

> - pre-compute a bunch of stuff, for example see this crapper:
> 
>    static inline int do_inode_permission(struct mnt_idmap *idmap,
>                                         struct inode *inode, int mask)
>   {
>           if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
>                   if (likely(inode->i_op->permission))
>                           return inode->i_op->permission(idmap, inode,
> mask);
> 
>                   /* This gets set once for the inode lifetime */
>                   spin_lock(&inode->i_lock);
>                   inode->i_opflags |= IOP_FASTPERM;
>                   spin_unlock(&inode->i_lock);
>           }
>           return generic_permission(idmap, inode, mask);
>   }

Yup, that would be useful.

> Note unlock_new_inode() and similar are not mandatory to call.

To a point. i.e. if you are using a VFS inode hash implemtation that
sets I_NEW, then it is definitely mandatory to call
unlock_new_inode().  Documentation/filesystems/porting.rst even says
that.

However, if you aren't using a VFS inode cache implemenation that
sets I_NEW, then you've got to set it yourself and clear it
appropriately so the rest of the VFS functionality does the right
thing whilst the inode is published but still being initialised.
e.g. putting an inode still undergoing initialisation on the
sb->s_inodes list without it being marked as I_NEW is, quite simply,
a bug.

Hence it may not be mandatory to use unlock_new_inode(), but if you
are publishing a partially initialised inode on any VFS list or
cache, you still need to be doing the right thing w.r.t. locking,
I_NEW, I_CREATING and calling unlock_new_inode() during inode
initialisation and cache lookups.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

