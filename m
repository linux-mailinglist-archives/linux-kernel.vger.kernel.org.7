Return-Path: <linux-kernel+bounces-879394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB89BC2304A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CF8405CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA2B2E7637;
	Fri, 31 Oct 2025 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZS4Wy3Jq"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEF2E6122
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877820; cv=none; b=e4C+yBV4e82UgNvGNAFVrdWNrwVXPFUTQ3597/i+KayOOEknmJyLnaW+wI3wEoFgmuFQ6zFvUfLlM5jwOwjip7xcrhIG1DkAipuHGTfZlZ5HV9dvYpKDpPhvxpR/cbgVGgXQCIk1yBLWtJL9wcKq1xDVSAhqk1Uul+iFr5fmS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877820; c=relaxed/simple;
	bh=yrxKixVojpbluBisYu0EAkFCmy3swUxaiKLewdtDk78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQaj8Gfx3dH43QvxH/wCIAlCnu8JQgUaXdt687dD7+kXhRcMjcWtf3ToTqRB9ApwRgp64GrIz7SGCrpmdX8Eo5n+aqCs7qzI3N7mJTOe+V0E1cYCAf0m5ii7YmceGQ19PJlfxQbgZG4QokTphVj3L5yv29gMy1Ht3RINVqRHCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZS4Wy3Jq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4285645fdfbso230832f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761877805; x=1762482605; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s70uKhnFnCqxMqoMAQZ8ZdV7WdC7wWM/IA4PJPlpz1o=;
        b=ZS4Wy3Jqxv1OulIIvetGd/IMgkGCJNDS6rFdecwxZU2a7pS4Kqc8KXIYmWl/ciKQsP
         OliOJXqpl/ck2Q6Ouo1sciX2B8oFhpcZidNVcxYWZx/XSlFOLi7N1B5TbG63Ot33kMXZ
         i96v4GCYvftciZ3yrBJVcVWBqpZFMmpjQHGMMOaBK7HurKgnme+6cOJz7Vi1kXthGEC0
         a+SVH5Y7/JDS0j+VSkbes8YiPiFDNy8UqJzpP2QRjssWS563zGu0uIuTA4L28EJDdOAW
         rwYxGWu15w93mV+GQJBDzaAdYlZJevtYCFl4Hti8b7+63VSuDxMmzs+IjoB3jzZX1ged
         7EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761877805; x=1762482605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s70uKhnFnCqxMqoMAQZ8ZdV7WdC7wWM/IA4PJPlpz1o=;
        b=vZJsXTkuGqHqTsboQtNtCPxuxFX2/Vr7JKt9QY1sPWCWhpBXprN08obXjndbgQEL0g
         qrXQ2hEZjFffagoG7ZyExUatX5F2EVye5kTKCOkAVG+IAyqVo/8cuqvJzyUC5t8E5qHw
         GhGF75dc37Vj1FjNP5vP890i2D51zeEK0s9iYLcs/mkjNg07PPPrwJIYC09JogpUrlY/
         OU9QvuSq9yTAcIlG96ZJRZNChh9rAVyRH2aU5RoKcBC2ggO+Mgz52FxBAXTGLTO7SggJ
         DRq/XWGsfNImMIpn9CNxrOLvlyQ198I/sjrQUwhwHQ93dQ+zy6L+izKsVZEaOwu+IHmV
         Npiw==
X-Forwarded-Encrypted: i=1; AJvYcCXaf16E/jBLSMBNELUqqNL8VKUfIaGeMp/F/xNOSrUkDSLg1DXKujreS5WnUNNVsazI4j6ew156McxsVT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2FBz5Ed1j02TWVrqS5XGwLfDT3qb67Nqj8a31HOfK9a8dyQ5
	rljCkUOWrz6qBxqBuJRAj8p38ZMpOZcZx/WNBPX3te8WsjjGA661EvnqGZMjcZ0/4pVVMG4Vbf7
	1brMh
X-Gm-Gg: ASbGnctfdu5N5E+TS90ChjcaBr2SfLuumPCPdXVHz7S9SmxNBKZZ9I3qSxrNkmvJ66d
	79hSD9fxDzUM1OUlOQr/7wmWDzeEkS2VKqHGh1f2ABLHXNPOwOQRpXGhxcVy5I5N5vj+FyUDChj
	0osoSWL4QwVWDmzfo/EhP2mHBHbIrB6d9Alp+DGMD7Rce9uIN4NNPlcTI2Mu1bVShXduSI0DAyu
	ioEUR+vBZTSFR1aahH0PoouMZVIhiJy7z8VUs3rBQIoZSyHUNl+WkU1TdWEPfY0XZOT6QcCc9ii
	YjTIGmKcCVsqC6hVYZBvKF+VlPYcgOLFO0ScuHZQXbGXNZhQS560dCHcMpwbiy5Q93/iNRkDEWu
	nrq0hfSIRcZoMMWM3TeDY7UPK6OzWhffCSO956ngxb+lGsLwAaOWQoc0HBuVxc+hU0kBXwZ5xG5
	s=
X-Google-Smtp-Source: AGHT+IED8Spg75WLEwDjYgLgNpdvHfKONetNjswzCY8ahrupW6jvolIdByK8SLvyz9YbHnzsZdhrdw==
X-Received: by 2002:a05:6000:2c0b:b0:3ed:e1d8:bd7c with SMTP id ffacd0b85a97d-429bd67c441mr683707f8f.2.1761877804602;
        Thu, 30 Oct 2025 19:30:04 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93f1d8f1desm214555a12.2.2025.10.30.19.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 19:30:04 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:30:01 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com, 
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
Message-ID: <qfizhbe5rwzddwnoekr6xjy3gozbqbtl64c5xmfeuudxvficmv@onazesxv4ur6>
References: <20251029225748.11361-2-eraykrdg1@gmail.com>
 <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
 <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>

On Fri, Oct 31, 2025 at 01:07:56AM +0300, Ahmet Eray Karadag wrote:
> Hi Heming,
> 
> Thanks a lot for the review and comments.
> 
> Regarding the placement of make_bad_inode(), our patch places it in
> ocfs2_read_inode_block_full() because
> ocfs2_validate_inode_block() itself doesn't have access
> to the inode object. I believe this (in the caller) is the
> correct layer, as it seems to match other patterns in OCFS2
> where the caller handles the make_bad_inode upon validation
> failure.

Thanks for pointing that out. I agree with the above comments.
> 
> I had one question about your proposal to combine this patch with
> Albin's [1]. When you mentioned, "We should forbid any write
> operations," were you referring to Albin's read-only check in
> ocfs2_setattr as the mechanism to "forbid" the operation? Or
> were you suggesting we should use the inode size sanity check
> itself (e.g., by converting the BUG_ON to an -EIO return)
> as that mechanism?
> 
> Thanks,
> Eray

The 'forbid' refers to the read-only check in ocfs2_setattr.
We can refer to ext4_setattr(), which calls ext4_emergency_state()
to forbid write operations.

- Heming
> 
> Heming Zhao <heming.zhao@suse.com>, 30 Eki 2025 Per, 10:59 tarihinde şunu yazdı:
> >
> > Hi,
> >
> > In my view, combining this patch and another patch [1] is a complete
> > solution for this bug.
> >
> > According to the oops stack, the FS is already in read-only mode.
> > We should forbid any write operations and then perform the inode
> > sanity check.
> >
> > And I think ocfs2_validate_inode_block is a good place for make_bad_inode().
> >
> > [1]:
> > https://syzkaller.appspot.com/text?tag=Patch&x=1287f614580000
> > - by albinbabuvarghese20@gmail.com from:
> >   https://syzkaller.appspot.com/bug?extid=b93b65ee321c97861072
> >
> > Thanks,
> > Heming
> >
> > On Thu, Oct 30, 2025 at 01:57:49AM +0300, Ahmet Eray Karadag wrote:
> > > Potentially triggered by sequences like buffered writes followed by
> > > open(O_DIRECT), can result in an invalid on-disk inode block
> > > (e.g., bad signature). OCFS2 detects this corruption when reading the
> > > inode block via ocfs2_validate_inode_block(), logs "Invalid dinode",
> > > and often switches the filesystem to read-only mode.
> > >
> > > Currently, the function reading the inode block (ocfs2_read_inode_block_full())
> > > fails to call make_bad_inode() upon detecting the validation error.
> > > Because the in-memory inode is not marked bad, subsequent operations
> > > (like ftruncate) proceed erroneously. They eventually reach code
> > > (e.g., ocfs2_truncate_file()) that compares the inconsistent
> > > in-memory size (38639) against the invalid/stale on-disk size (0), leading
> > > to kernel crashes via BUG_ON.
> > >
> > > Fix this by calling make_bad_inode(inode) within the error handling path of
> > > ocfs2_read_inode_block_full() immediately after a block read or validation
> > > error occurs. This ensures VFS is properly notified about the
> > > corrupt inode at the point of detection. Marking the inode bad  allows VFS
> > > to correctly fail subsequent operations targeting this inode early,
> > > preventing kernel panics caused by operating on known inconsistent inode states.
> > >
> > > [RFC]: While this patch prevents the kernel crash triggered by the reproducer,
> > > feedback is requested on whether ocfs2_read_inode_block_full() is the most
> > > appropriate layer to call make_bad_inode(). Should this check perhaps reside
> > > within the caller or should the error propagation be handled differently?:
> > > Input on the best practice for handling this specific VFS inconsistency
> > > within OCFS2 would be appreciated.
> > >
> > > Reported-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
> > > Link: https://syzkaller.appspot.com/bug?extid=b93b65ee321c97861072
> > > Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> > > Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> > > Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> > > ---
> > >  fs/ocfs2/inode.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> > > index fcc89856ab95..415ad29ec758 100644
> > > --- a/fs/ocfs2/inode.c
> > > +++ b/fs/ocfs2/inode.c
> > > @@ -1690,6 +1690,8 @@ int ocfs2_read_inode_block_full(struct inode *inode, struct buffer_head **bh,
> > >       rc = ocfs2_read_blocks(INODE_CACHE(inode), OCFS2_I(inode)->ip_blkno,
> > >                              1, &tmp, flags, ocfs2_validate_inode_block);
> > >
> > > +     if (rc < 0)
> > > +             make_bad_inode(inode);
> > >       /* If ocfs2_read_blocks() got us a new bh, pass it up. */
> > >       if (!rc && !*bh)
> > >               *bh = tmp;
> > > --
> > > 2.43.0
> > >
> > >

