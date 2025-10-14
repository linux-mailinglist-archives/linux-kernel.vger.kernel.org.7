Return-Path: <linux-kernel+bounces-853218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A2ABDAF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C5B1923B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480829BD91;
	Tue, 14 Oct 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRX7ddMY"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19779296BBF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466461; cv=none; b=e4OUSyTeHemqI9poxPgW752gDvHd+NlqQMPKDf94HVDU5MAgpFf84W2PIPMsfZ/qgQuFFFmqco7aIElr0zILXlWV/X5vlKPpnIQQA+WRpgeoFSflZncDp9HVAn9aYLSB8cyKe/q8xDAcWESFnHXfNbTQ0IMsLl3rST9qe+hP21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466461; c=relaxed/simple;
	bh=RB74I7aLFP9qio5yu8di8G1iTGBsm2anqMXvHShWuJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDfJuG1ZyXCFX9/30PHqR8jX8tFK8ZATKG8cDPizGil+uOyrPVgXFR7wTMJXockxceOJtAm3s0yl2srpkL/wATZ0aCt+XeHujG10EKKYD6IRhh1M5CJPbus4OIFAW65RoP1UhxpGbnzKnnPlQnnq6+oyYgJNeZQWgmA44mFbjCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRX7ddMY; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78f15d5846dso93642706d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760466458; x=1761071258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSfTQUEeojQQB/O4AumuztWKmGZiVkZuY+HewObt1DM=;
        b=PRX7ddMYMmH5UjMSvlec7gbIoWkdzrabslLufLYe1hkjMH56gfmaRi0Et2DsFQLKaL
         Mu75410tlrPqwEX6wG6a3D90VZyZplLi6iIOw4VC++d0wYppFM7uOGpt7GIBc25G0hSj
         7459r/HKJZdiw5FHGIOBuHvw8H6yEPNGP3dnTNS282lI9chf4fBCMMPJZwLtauuvp7Yc
         S/9l2TvCUan4OdDaERCqn7mRNvhx0QT/GvyjP9zb7P4Yoln153KGfp17UHH6MnvJnJYc
         PLf1rT49hCcDo8NaVAuwlhOTpxSnScbHY/gEpMiH0kWixgHssIvEtVN6EHJufpgYXWYW
         c1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466458; x=1761071258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSfTQUEeojQQB/O4AumuztWKmGZiVkZuY+HewObt1DM=;
        b=l0VcjuUtUxQuubFodlNPuymVTKkfoGOdlYseAj2Ppy4ot5RKx1Vw5Vs0UrZeJBxiyh
         zBquXriLpAxQz4eZAo22eZt4UU1gRgKUQscBUAxTPFIpeQEdHMR1kO+ozsXbwfqxglRW
         CZI0UvuRV6XeYGZjhzaW3m+IO/8p2BI7JSHtkfOCuViYem9ypcJKEAEfsasgiF3zv4nv
         va0YmAR23yLyHJoDWKVZBXXdmQNLMEDX0Gx9n6K1nGzsBYp01QOM6CEXRnBtU2dkCwkg
         HKIpeG0CZRS7muwiPTCVX8F4KV6PX64RlgC1HUtpCXY+1U/DGrH7wA/dDVIfyvWuU34B
         F3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCULz155L2y/VQnnqeT/EJZolF1doLYbq+u88s/GvjIJyOfydwrPBIrS/kcYQ3fKKFDScgXChhY64Ruq2vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3GWjse9GOURxjylyDkOSO46FVDDp1bKZ1plyO8wQV8hwIQrP
	qaqW/+UmTg5z66Ps716JOH/OQADX+NIb6wiJOQnu8ekKVhYLdFPQ5U3dIjYlFyXdFiIqSTlskgO
	ylc70iVkGOCHj+Y/ainSUmEIx3IjogFM=
X-Gm-Gg: ASbGncsYXRvQGJjQjx+Ze59zgfoTvQURe/zqpA5waZ9boWYUJmF88dubeuZmlSvKMN6
	eL84aryjL6IYUtUItS25d8SVhM3Yme76t5DsJBLrQ4t+fAHDiwPFEBqJd02FMFbfoLr38DDyvo7
	Et+TmlUabzX3g2NCa+d7gQIyn9xvH4i94m3DwwXyKAl0q7/vOAeGhFSnL7SAod/EIh42jr1gVq8
	vRS+BEupG7L2JUWG1u80/hyLe2jXjF6KNG0SFYatkfPwMT7vnMhtuOQJ6i2fWvTrmLupPU03fzU
	/XepnEVCZ/HagNZ5lH4lEmvAoISB9CLKuI+ZgTpCl+ZO3Fug5waXk/jh2Oed/02kBgHooYblyYf
	Yga9Z6F3NN0H7J01et79WT1PpS/as4a8R8LMEj3g=
X-Google-Smtp-Source: AGHT+IFU6XFIR+qGieXOiN15wCcKNp7saGyGYeqcKac09vSAanvqo/pyqL6UQId++kEk6bi2MHN+oNsiaYZwxnbnOWI=
X-Received: by 2002:a05:6214:f6b:b0:804:19ef:45dd with SMTP id
 6a1803df08f44-87b2101d85amr393750166d6.25.1760466457838; Tue, 14 Oct 2025
 11:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014133551.82642-1-dhowells@redhat.com>
In-Reply-To: <20251014133551.82642-1-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 14 Oct 2025 13:27:26 -0500
X-Gm-Features: AS18NWDSIxnc3mGWD21jCuzZgR1tbiQpCXCnv_rdJ8bZ8-EdEWCR6tu4SyA_6UY
Message-ID: <CAH2r5muBUFcGWZ+-d8OteT=k7xVk1sK97URmKfwF5saq4ms2Zw@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs, afs, bash: Fix miscomparison of foreign user IDs
 in the VFS
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Marc Dionne <marc.dionne@auristor.com>, Jeffrey Altman <jaltman@auristor.com>, 
	Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org, 
	openafs-devel@openafs.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Additionally, filesystems (CIFS being a notable example) may also have us=
er
identifiers that aren't simple integers

Yes - this is a bigger problem for cifs.ko (although presumably NFS
since they use user@domain for NFSv4.1 and 4.2, instead of small 32
bit uids, could have some overlapping issues as well).

In the protocols, users are represented (e.g. in ACLs and in ownership
info returned by the server) as globally unique "SIDs" which are much
larger than UIDs and so can be safely mapped across large numbers of
systems.

On Tue, Oct 14, 2025 at 8:36=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Al, Christian,
>
> Here's a pair of fixes that deal with some places the VFS mishandles
> foreign user ID checks.  By "foreign" I mean that the user IDs from the
> filesystem do not belong in the same number space as the system's user ID=
s.
> Network filesystems are prime examples of this, but it may also impact
> things like USB drives or cdroms.
>
> Take AFS as example: Whilst each file does have a numeric user ID, the fi=
le
> may be accessed from a world-accessible public-facing server from some
> other organisation with its own idea of what that user ID refers to.  IDs
> from AFS may also collide with the system's own set of IDs and may also b=
e
> unrepresentable as a 32-bit UID (in the case of AuriStor servers).
>
> Further, kAFS uses a key containing an authentication token to specify th=
e
> subject doing an RPC operation to the server - and, as such, this needs t=
o
> be used instead of current_fsuid() in determining whether the current use=
r
> has ownership rights over a file.
>
> Additionally, filesystems (CIFS being a notable example) may also have us=
er
> identifiers that aren't simple integers.
>
> Now the problem in the VFS is that there are a number of places where it
> assumes it can directly compare i_uid (possibly id-mapped) to either than
> on another inode or a UID drawn from elsewhere (e.g. current_uid()) - but
> this doesn't work right.
>
> This causes the write-to-sticky check to work incorrectly for AFS (though
> this is currently masked by a workaround in bash that is slated to be
> removed) whereby open(O_CREAT) of such a file will fail when it shouldn't=
.
>
> Two patches are provided:
>
>  (1) Add a pair of inode operations, one to compare the ownership of a pa=
ir
>      of inodes and the other to see if the current process has ownership
>      rights over an inode.  Usage of this is then extended out into the
>      VFS, replacing comparisons between i_uid and i_uid and between i_uid
>      and current_fsuid().  The default, it the inode ops are unimplemente=
d,
>      is to do those direct i_uid comparisons.
>
>  (2) Fixes the bash workaround issue with regard to AFS, overriding the
>      checks as to whether two inodes have the same owner and the check as
>      to whether the current user owns an inode to work within the AFS
>      model.
>
> kAFS uses the result of a status-fetch with a suitable key to determine
> file ownership (if the ADMINISTER bit is set) and just compares the 64-bi=
t
> owner IDs to determine if two inodes have the same ownership.
>
> Note that chown may also need modifying in some way - but that can't
> necessarily supply the information required (for instance, an AuriStor YF=
S ID
> is 64 bits, but chown can only handle a 32-bit integer; CIFS might use a
> GUID).
>
> The patches can be found here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dafs-sticky-2
>
> Thanks,
> David
>
> David Howells (2):
>   vfs: Allow filesystems with foreign owner IDs to override UID checks
>   afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
>
>  Documentation/filesystems/vfs.rst |  21 ++++
>  fs/afs/dir.c                      |   2 +
>  fs/afs/file.c                     |   2 +
>  fs/afs/internal.h                 |   3 +
>  fs/afs/security.c                 |  46 +++++++++
>  fs/attr.c                         |  58 ++++++-----
>  fs/coredump.c                     |   2 +-
>  fs/inode.c                        |  11 +-
>  fs/internal.h                     |   1 +
>  fs/locks.c                        |   7 +-
>  fs/namei.c                        | 161 ++++++++++++++++++++++++------
>  fs/remap_range.c                  |  20 ++--
>  include/linux/fs.h                |   6 +-
>  13 files changed, 269 insertions(+), 71 deletions(-)
>
>


--=20
Thanks,

Steve

