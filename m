Return-Path: <linux-kernel+bounces-811349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC230B527DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8A916BD93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F7247298;
	Thu, 11 Sep 2025 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIkvLkpo"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376B2C86D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757566571; cv=none; b=mLr1J6wFmkhg3u80uLyGfslmutI5/QE4HyDdyQ+/d3CkspTTzrTMHUT5qC3pdnJfLTmE3ywM/VW/HAgD3wL+7s9rZzMdqrlqKl9Xq8q+KbDAgZ4NxfSqdvz+LvzWFQFlT1RnPS9aZI3o91IDr38WJsNW4aIloRE2/zPy9q799bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757566571; c=relaxed/simple;
	bh=W4CKL2AUxvtcuPUDHV7Q09QLfSt3XZW4WmqLs5XEpmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhuHMt4M3sHcdKY2U6KinBSakGnWmAW6pwI9oThdjsVGNeaoMZfC9pERMBAeym4JxL7QUXKTo2njDH7sFHE3ZIzypoh/tDRN1EbmTzowxJYMkzcRm3mgDefIXkHLxidTSNQo++p/Bv66XL8V0YP+f9VBe9jHSoghWPchdzIw4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIkvLkpo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3dea538b826so261224f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757566567; x=1758171367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AR5LhyqVY+1m42Is+L8ZD94uivd8GqQuzwNAxUlt6JY=;
        b=FIkvLkpoe9qXV6drO734u3fItP953qKjJ5+TMc+6RGC+0yXAnqeuW0HD5SJ5MztdKD
         wZPRUGc/33huxUR578DtfNdiLBtMIqP8hKpfQfnm1MJaSzGb7imH4WQylsgGLy555aT8
         /cHia6yggn8ZjMPXvFdMAtGq9P47j7AyNcM77P1E/3fV+HOp3cwC6/90w3KB0TMwcUXW
         im6/eLOgCck2t7+ummrlO2giCegvsflQXh5dTWmODxG3GoeJpnYZ1XTY+A2k36KPwk7e
         OmZVOORJlgL1CG42q8MFpa0M5dGaNnTtKJ1ijlcRYuVCRZznJ0a8B5wkMyBtFA7KfC4y
         nAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757566567; x=1758171367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AR5LhyqVY+1m42Is+L8ZD94uivd8GqQuzwNAxUlt6JY=;
        b=q7znuL7yb1Feqoh6JUC0TnfpKVkmfoLUtnn0YgzcSZQ/kctmBT80WvtghR8uS3MkDP
         3G6PjdBUgnKaMogBMOww1T2di5Bw2OXFFJfQnx430ulZCnYkvOwQhnAFNDBENPjCV6/d
         eedHEuWf4FBke3ePvrAXE+3qb3kSCrgWde54oR1NBFfA8TMWJ47L2WqQuVRpUX328CnJ
         0MpCJ5dv4z3/FaOg2MrqdBfr5gG69SMdthIdfxBImR7LBXgGQABskyr0cXhEQyfIWU14
         uW2AegvpaZ1zpiN/p9KRcTD5XqGrPk1OL6QdxVx9EeVwPC+YtjUzmpeVOKpe4fbRI16/
         KiYw==
X-Forwarded-Encrypted: i=1; AJvYcCW/suBMBG1ugYaDLK6llAMxja89HTWE8Gvv+t9mU85JQ6t7+ldnJsyIAPERowROzhQtlwFgP9O8Y/5T2tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMlZBGXt8EH4gNkTqzpJYcVE2bubSYVcKo2qVMfs9+EwRfRpw
	ZNL2CdzQdxTadfCJf2QMteFZgLJhmyqxiuebETtHX4rbD9XWGGGjFwZW
X-Gm-Gg: ASbGncuhNCogzCUGOgH72bsHP7mrzwpyGv56sYqRA2RmwbXTwSNLx1FxF5J1VEFZph2
	2fgOx4zvUM51gmhCjIUfMN+wK0F/B8YiVQBU8/JWT5W+UxTu/8TIL8j1D+KxAgBlPAnY9Glpxzw
	zI+uF56MkBH4JjjFq6Wkh3BNUUyoW//Eew+7J8Q/rWWgH/LW1h+kfogCxcjKg94MpFOkDcN2gJX
	aBPJpHzsh5MYL9w5BKPeVaDEXQx6/3iw4AuuWOVDHq3+biKcfqqLyf1N3mo+pcnqphGuBkwCekt
	jBMOVOj1wTUBGVoCkp7aBRyuh9z2ye+RxccYeGyPJa+vvDgyhoncZJB2EkuHsaQySSUn+7KGnpI
	UuzmeB+E4QD8u7kUiVY9XHPUaB0Hnm/BF6TLQBV3r
X-Google-Smtp-Source: AGHT+IF0k2EJjQABLVqvLQec70dC1QxUs1rWTK9WCbueHFByutiDt50zbku4UV2s8ar6VbFX0dn6hA==
X-Received: by 2002:a05:6000:2a06:b0:3e7:620e:5295 with SMTP id ffacd0b85a97d-3e7620e56bcmr48038f8f.11.1757566567120;
        Wed, 10 Sep 2025 21:56:07 -0700 (PDT)
Received: from f.. (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e9e6asm889419f8f.62.2025.09.10.21.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:56:06 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH v3 0/4] ->i_state accessors
Date: Thu, 11 Sep 2025 06:55:53 +0200
Message-ID: <20250911045557.1552002-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is generated against:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

The first patch in the series is ready to use(tm) and was sent
separately here:
https://lore.kernel.org/linux-fsdevel/20250909082613.1296550-1-mjguzik@gmail.com/T/#u

It is included in this posting as the newly patched routine has to get
patched further due to the i_state accessor thing. Having it here should
make it handier to test for interested.

Compared to v2 this drops I_WILL_FREE removal for the time being and
converts the entirety of the kernel.

Patch rundown:
  fs: hide ->i_state handling behind accessors

Provides the new helpers and converts general kernel (fs/*.c and others,
but no specific filesystems). ->i_state temporarily remains accessible
with plain loads/stores.

  convert all filesystems to use the new ->i_state accessors

This is a squashed patch to avoid sending a 50-mail churn patchset at
this stage, included for reference for interested how things are going
to look like.  This will be one patch per fs in the actual submission.

Conversion generated with coccinelle + manual fixups.

I got a kernel with ext4 running, I have not tested xfs or btrfs yet.

  type switch

This hides ->i_state behind a struct, so things nicely fail to compile
if someone open-codes a plain access.

Rationale:

The handling in the stock kernel is highly error prone and with 0 assert
coverage.

The ->i_state field is legally accessible for reads without holding the
inode spinlock. This opens up potential for compiler mischief in code
doing things like:

	state = inode->i_state;
	if (state & I_FOO)
		....
	else if (state & I_BAR)
		....

Other code may be expecting the value to be stable (only guaranteed with
the spinlock held) and unknowingly being called without that guarantee.

Some places modifying or reading the field use WRITE_ONCE/READ_ONCE
respectively, but others don't.

Modifying flags requires the lock, but right now it is never checked if
such operations are done while it is being held.

Even ignoring that aspect, all current state modifications lack any
validation whether a given change is legal to do. For example there may
be things which are illegal to do once I_FREEING is set, but the current
code fails to check for it in any capacity.

With the assumption the general intent is to tighten up the interfaces,
I think this is a step forward. Note the new routines can assert on
->i_state changes based on other parts of the inode (trivial example:
the routine can validate nobody sets I_FREEING if there is a refcount >
0).

The proposed routines still remain kind of lax in what they do, notably
there are _unchecked variants to bypass any validation (used in special
cases and by XFS). To be tightened up over time.

As sample usage I'm going to quote part of iput_final() with the
infamous I_WILL_FREE flag:

        if (!drop) {
                inode_state_add(inode, I_WILL_FREE);
                spin_unlock(&inode->i_lock);

                write_inode_now(inode, 1);

                spin_lock(&inode->i_lock);
                inode_state_del(inode, I_WILL_FREE);
                WARN_ON(inode_state_read(inode) & I_NEW);
        }

        inode_state_add(inode, I_FREEING);

Lockless loads are a little bit verbose though:
	VFS_BUG_ON_INODE(inode_state_read_unstable(inode) & I_CLEAR, inode);

I'm not going to argue about naming, it can be trivially changed with
sed on the patchset.

I do claim whacking open-coded access to ->i_state is a mandatory part
of whipping VFS into a better shape in terms of maintainability. I'm not
going to repeat myself how and why, a description can be found in my
responses to the i_obj_count thread:
https://lore.kernel.org/linux-fsdevel/dpi5ey667awq63mgxrzu6qdfpeinrmeapgbllqidcdjayanz2p@kp3alvfskssp/
https://lore.kernel.org/linux-fsdevel/frffkyu6vac5v7qt5ee36xmg6hrwwdks7mnn2k7krdqecn56mc@3kwx24xtmane/

If this looks good I'll write proper commit messages and whatnot, do
some more testing and properly resend.

Mateusz Guzik (4):
  fs: expand dump_inode()
  fs: hide ->i_state handling behind accessors
  convert all filesystems to use the new ->i_state accessors
  type switch

 block/bdev.c                     |   4 +-
 drivers/dax/super.c              |   2 +-
 fs/9p/vfs_inode.c                |   2 +-
 fs/9p/vfs_inode_dotl.c           |   2 +-
 fs/affs/inode.c                  |   2 +-
 fs/afs/dynroot.c                 |   6 +-
 fs/afs/inode.c                   |   8 +-
 fs/bcachefs/fs.c                 |   7 +-
 fs/befs/linuxvfs.c               |   2 +-
 fs/bfs/inode.c                   |   2 +-
 fs/btrfs/inode.c                 |  10 +--
 fs/buffer.c                      |   4 +-
 fs/ceph/cache.c                  |   2 +-
 fs/ceph/crypto.c                 |   4 +-
 fs/ceph/file.c                   |   4 +-
 fs/ceph/inode.c                  |  28 +++----
 fs/coda/cnode.c                  |   4 +-
 fs/cramfs/inode.c                |   2 +-
 fs/crypto/keyring.c              |   2 +-
 fs/crypto/keysetup.c             |   2 +-
 fs/dcache.c                      |   8 +-
 fs/drop_caches.c                 |   2 +-
 fs/ecryptfs/inode.c              |   6 +-
 fs/efs/inode.c                   |   2 +-
 fs/erofs/inode.c                 |   2 +-
 fs/ext2/inode.c                  |   2 +-
 fs/ext4/inode.c                  |  10 +--
 fs/ext4/orphan.c                 |   4 +-
 fs/f2fs/data.c                   |   2 +-
 fs/f2fs/inode.c                  |   2 +-
 fs/f2fs/namei.c                  |   4 +-
 fs/f2fs/super.c                  |   2 +-
 fs/freevxfs/vxfs_inode.c         |   2 +-
 fs/fs-writeback.c                | 123 ++++++++++++++++---------------
 fs/fuse/inode.c                  |   4 +-
 fs/gfs2/file.c                   |   2 +-
 fs/gfs2/glops.c                  |   2 +-
 fs/gfs2/inode.c                  |   4 +-
 fs/gfs2/ops_fstype.c             |   2 +-
 fs/hfs/btree.c                   |   2 +-
 fs/hfs/inode.c                   |   2 +-
 fs/hfsplus/super.c               |   2 +-
 fs/hostfs/hostfs_kern.c          |   2 +-
 fs/hpfs/dir.c                    |   2 +-
 fs/hpfs/inode.c                  |   2 +-
 fs/inode.c                       | 111 +++++++++++++++-------------
 fs/isofs/inode.c                 |   2 +-
 fs/jffs2/fs.c                    |   4 +-
 fs/jfs/file.c                    |   4 +-
 fs/jfs/inode.c                   |   2 +-
 fs/jfs/jfs_txnmgr.c              |   2 +-
 fs/kernfs/inode.c                |   2 +-
 fs/libfs.c                       |   6 +-
 fs/minix/inode.c                 |   2 +-
 fs/namei.c                       |   8 +-
 fs/netfs/misc.c                  |   8 +-
 fs/netfs/read_single.c           |   6 +-
 fs/nfs/inode.c                   |   2 +-
 fs/nfs/pnfs.c                    |   2 +-
 fs/nfsd/vfs.c                    |   2 +-
 fs/nilfs2/cpfile.c               |   2 +-
 fs/nilfs2/dat.c                  |   2 +-
 fs/nilfs2/ifile.c                |   2 +-
 fs/nilfs2/inode.c                |  10 +--
 fs/nilfs2/sufile.c               |   2 +-
 fs/notify/fsnotify.c             |   2 +-
 fs/ntfs3/inode.c                 |   2 +-
 fs/ocfs2/dlmglue.c               |   2 +-
 fs/ocfs2/inode.c                 |  10 +--
 fs/omfs/inode.c                  |   2 +-
 fs/openpromfs/inode.c            |   2 +-
 fs/orangefs/inode.c              |   2 +-
 fs/orangefs/orangefs-utils.c     |   6 +-
 fs/overlayfs/dir.c               |   2 +-
 fs/overlayfs/inode.c             |   6 +-
 fs/overlayfs/util.c              |  10 +--
 fs/pipe.c                        |   2 +-
 fs/qnx4/inode.c                  |   2 +-
 fs/qnx6/inode.c                  |   2 +-
 fs/quota/dquot.c                 |   2 +-
 fs/romfs/super.c                 |   2 +-
 fs/smb/client/cifsfs.c           |   2 +-
 fs/smb/client/inode.c            |  14 ++--
 fs/squashfs/inode.c              |   2 +-
 fs/sync.c                        |   2 +-
 fs/ubifs/file.c                  |   2 +-
 fs/ubifs/super.c                 |   2 +-
 fs/udf/inode.c                   |   2 +-
 fs/ufs/inode.c                   |   2 +-
 fs/xfs/scrub/common.c            |   2 +-
 fs/xfs/scrub/inode_repair.c      |   2 +-
 fs/xfs/scrub/parent.c            |   2 +-
 fs/xfs/xfs_bmap_util.c           |   2 +-
 fs/xfs/xfs_health.c              |   4 +-
 fs/xfs/xfs_icache.c              |   6 +-
 fs/xfs/xfs_inode.c               |   6 +-
 fs/xfs/xfs_inode_item.c          |   4 +-
 fs/xfs/xfs_iops.c                |   2 +-
 fs/xfs/xfs_reflink.h             |   2 +-
 fs/zonefs/super.c                |   4 +-
 include/linux/backing-dev.h      |   5 +-
 include/linux/fs.h               |  59 ++++++++++++++-
 include/linux/writeback.h        |   4 +-
 include/trace/events/writeback.h |   8 +-
 mm/backing-dev.c                 |   2 +-
 security/landlock/fs.c           |   2 +-
 106 files changed, 368 insertions(+), 309 deletions(-)

-- 
2.43.0


