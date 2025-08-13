Return-Path: <linux-kernel+bounces-767438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CFB2543B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D2F2A4330
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52C30E82B;
	Wed, 13 Aug 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kntz1a1I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596FB2C0F95;
	Wed, 13 Aug 2025 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115544; cv=none; b=oHMGGGGTbnGIrAKVciensShfitJRSTmzMBQxplXtcYUYclX/1Ss+n/7auUtzS7z6GLyriVNqlBRQtrYbb9HhFixts6gahsafgVI/+fe9wVoIVA6TSVjDbj4eGUiKmk+gk7uS0/boYkS8zPjauH0QzAsr+TRunpbzlMHdqpdGyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115544; c=relaxed/simple;
	bh=pMCILN08odLSk9ZrWA3Vhd3J6o98FvzU2VqhQ94Z1W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtWzxLRmuIK/fyT9LFHJjqqU2pe+TmemYehXnThK/BClwWd9chRPNPD93z8dWaRHuvsBrF9QTrgHnQNowlrjoF3dDwqJBDFh0b3Jt07pHpMof+XlVFvDNLjNuYRR1rWGb+d6ZqhZgRmpJKaOotGoi0c26D8b6xF8hbARsc8TlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kntz1a1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49F3C4CEEB;
	Wed, 13 Aug 2025 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115543;
	bh=pMCILN08odLSk9ZrWA3Vhd3J6o98FvzU2VqhQ94Z1W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kntz1a1IsfPzOs5k/QYDjU5Lt4+zyPaqYQXvVWiRnkEzNJ5H7CNGmXOdqerc8d4FL
	 fyexDRURuuOHPeoP4yqdzofX0ZdOmV8IlNct9sOyZCBe7V0SpolP/Kwk5BtkEr1X2d
	 ycL1g+rPKIWf3teEmKvod2y4fXvWo+fLR9r6lwtcSfu+3L/nQFnNMYq8+uNfxCQxSX
	 rtbLba/R8xkYbFJ2JF7s+FNSGr4ssseD3nCjm/qOY7PuAjV+DZJwfOzA96aCj0BSge
	 gsLkCEY89AV4dsn5THBIHTkyLosEBme5lvV5dg5TwcYCyULbmDUxjT6cLPGfhCzUBO
	 r7Pgb1+Nz7P9g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/9] Documentation: Fix filesystems typos
Date: Wed, 13 Aug 2025 15:05:01 -0500
Message-ID: <20250813200526.290420-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813200526.290420-1-helgaas@kernel.org>
References: <20250813200526.290420-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/filesystems/erofs.rst                      | 2 +-
 Documentation/filesystems/gfs2-glocks.rst                | 2 +-
 Documentation/filesystems/hpfs.rst                       | 2 +-
 Documentation/filesystems/resctrl.rst                    | 2 +-
 Documentation/filesystems/xfs/xfs-online-fsck-design.rst | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 7ddb235aee9d..08194f194b94 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -116,7 +116,7 @@ cache_strategy=%s      Select a strategy for cached decompression from now on:
                                    cluster for further reading. It still does
                                    in-place I/O decompression for the rest
                                    compressed physical clusters;
-                       readaround  Cache the both ends of incomplete compressed
+                       readaround  Cache both ends of incomplete compressed
                                    physical clusters for further reading.
                                    It still does in-place I/O decompression
                                    for the rest compressed physical clusters.
diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2-glocks.rst
index adc0d4c4d979..ce5ff08cbd59 100644
--- a/Documentation/filesystems/gfs2-glocks.rst
+++ b/Documentation/filesystems/gfs2-glocks.rst
@@ -105,7 +105,7 @@ go_unlocked           Yes                       No
    Operations must not drop either the bit lock or the spinlock
    if its held on entry. go_dump and do_demote_ok must never block.
    Note that go_dump will only be called if the glock's state
-   indicates that it is caching uptodate data.
+   indicates that it is caching up-to-date data.
 
 Glock locking order within GFS2:
 
diff --git a/Documentation/filesystems/hpfs.rst b/Documentation/filesystems/hpfs.rst
index 7e0dd2f4373e..0f9516b5eb07 100644
--- a/Documentation/filesystems/hpfs.rst
+++ b/Documentation/filesystems/hpfs.rst
@@ -65,7 +65,7 @@ are case sensitive, so for example when you create a file FOO, you can use
 'cat FOO', 'cat Foo', 'cat foo' or 'cat F*' but not 'cat f*'. Note, that you
 also won't be able to compile linux kernel (and maybe other things) on HPFS
 because kernel creates different files with names like bootsect.S and
-bootsect.s. When searching for file thats name has characters >= 128, codepages
+bootsect.s. When searching for file whose name has characters >= 128, codepages
 are used - see below.
 OS/2 ignores dots and spaces at the end of file name, so this driver does as
 well. If you create 'a. ...', the file 'a' will be created, but you can still
diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c7949dd44f2f..4db3b07c16c5 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -563,7 +563,7 @@ this would be dependent on number of cores the benchmark is run on.
    depending on # of threads:
 
 For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
-thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
+thread, with 10% bandwidth' can consume up to 10GBps and 40GBps although
 they have same percentage bandwidth of 10%. This is simply because as
 threads start using more cores in an rdtgroup, the actual bandwidth may
 increase or vary although user specified bandwidth percentage is same.
diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index e231d127cd40..9fe994353395 100644
--- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -454,7 +454,7 @@ filesystem so that it can apply pending filesystem updates to the staging
 information.
 Once the scan is done, the owning object is re-locked, the live data is used to
 write a new ondisk structure, and the repairs are committed atomically.
-The hooks are disabled and the staging staging area is freed.
+The hooks are disabled and the staging area is freed.
 Finally, the storage from the old data structure are carefully reaped.
 
 Introducing concurrency helps online repair avoid various locking problems, but
@@ -2185,7 +2185,7 @@ The chapter about :ref:`secondary metadata<secondary_metadata>` mentioned that
 checking and repairing of secondary metadata commonly requires coordination
 between a live metadata scan of the filesystem and writer threads that are
 updating that metadata.
-Keeping the scan data up to date requires requires the ability to propagate
+Keeping the scan data up to date requires the ability to propagate
 metadata updates from the filesystem into the data being collected by the scan.
 This *can* be done by appending concurrent updates into a separate log file and
 applying them before writing the new metadata to disk, but this leads to
-- 
2.43.0


