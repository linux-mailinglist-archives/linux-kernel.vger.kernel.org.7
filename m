Return-Path: <linux-kernel+bounces-691868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C6CADE9BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 13:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7526B1898155
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B82BEC59;
	Wed, 18 Jun 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5daYMbw"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C8295531;
	Wed, 18 Jun 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245371; cv=none; b=kmT7f7pY3frjxnLaukN3wY/tTWCLH8grRIwyIh1vDysKyyjqIxUzI6Syu9r5NkPzZoEnGQEMBulZ9QQYLfSf+rbJpIqkiYXWxJqw4nO81YstF2QM0iqsSpb3KjDeRpVCynwSIhuBYZhjd8lw9DsAFXoFKOWzM4PGJGY68TZiIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245371; c=relaxed/simple;
	bh=K5pTB5IITvkRTBBRO+8HubCgsx539iFFT7LH9lgg4Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRRzZwr5FlRVP9lN84ufFSQ2mkcYdY/GUnC0KGuW4tsL51sZsEABw4cVjrda25aDCfsgPP5vzV+9MFPO8zpEEs2x+/4w2ndQldM+fgbn9lss5l3Cla7/Cob8XikQj/BLexwO3ECcRKnNo4R55t+eXDl1V7z6kHALzS7cpIndSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5daYMbw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748ece799bdso249167b3a.1;
        Wed, 18 Jun 2025 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750245367; x=1750850167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxxGu10V6DoBlyRrA1QrIkw1CSrpJwPgwTi1jCn3eGY=;
        b=d5daYMbwmmevg5a2ArbI3qncNnLCro0QgVy6W6R4Hob3k3dL2m1+IFPa98qFPqwKYa
         zTn9+zSBy05oLYgkCgSQvoLQRTdCcAI2MdO5ExXB0vffnYMn4OwLw9aAF4a+7qFfbBv0
         hEXH3POBaeKsT9zAWA16Sl5zZ9i4sICPIWyuZcjZcR7xn/pYJs5Jskn8sheGDZXsM6HP
         JsKF8IKTOujIt///mswuEwQwhakelvIe3MHnUPeKTzzUr8SIXZeQfyj/gPgYUBBs0wA0
         YbDUjRTGbHBmWifsehbUs0bcvk8yrHaKt9YrmuWQXx+Yylnj9GS22neydHmGW8uEmbh/
         UJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750245367; x=1750850167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxxGu10V6DoBlyRrA1QrIkw1CSrpJwPgwTi1jCn3eGY=;
        b=mSYQpKaHbEEJSAcVuE5XG6Mnf8f0uBinWuHbGv0cvE0t4K9TWibO7I8/UHpMRZ1tZD
         0Js3531sCuQvzxsbtfwlGZU2K3pJDb9OLZqou5ChohlcnetstUpKUlwnVu+JrDEu5xxm
         ZwjosX6sAYI3NuPX047Vvi8lbusu3O/v5PyI6YYwqgvt9KA+OupAiF3Hro3lLBJmItQk
         jySzfw5aOd/S5XgKpUX7CYXUQ0G0j7laFfKhsID8xhdV5z66XkUq71aVfasOTKDSJQHn
         3z3lEZaFqgd4EBY2XVabzPA+4MhFvGhsUQxmjVLxjDI0fJMg/E8gOaff5+rwD5rfZwpD
         vl/A==
X-Forwarded-Encrypted: i=1; AJvYcCWCXYSZ1T5W+urM2nB18fPxoac0QBqISgpzxya4raQqjS4JcbrcXQyWXyIJhtIbQzQJACaXCQ41VjVa8Q==@vger.kernel.org, AJvYcCWy5IJexUe89rSQRLEYHDKlWrqJADc2fdPv0hiG2dSgXQvd5DwdNHIVBOkPpNyOD1envLYZu5hZeMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38CDH6+p1994C4ff7q1SwU++tf7K5x+o27xDFsXhK+Esro0mv
	UucXPQNXEqVXpIL69QlGWe6NOq/Do4L6S1r4v+jLLZp75aFgGRppO7lCuAWoPw==
X-Gm-Gg: ASbGncuw6dMUoTbRH/xW4ESMr7K44lqUIYigXF87nMgmJ721Fb0+F3yVNZSsQt+m1An
	xwUH1OX9kd9yQGvjhdcrJYXMk9nVJAaqk28Gx6TZaML+qcXXQhXW1v+KkFwdwdG6aEJHUvTuh3s
	WLn/oGaKLyKUj8owwBHP5b5PrVkwiULEM3BHblCjhD1H3gs26q8y40eCoRpl3lESjhl+dp3AjOX
	bKKh6QeGG7v4DpQ/Ws8GKH8tXZ56aeSiJ7tYUVFo0pvPR/roUQ/WC2jV703DuAMsbIwqJ5TBx9s
	5K2UyXufdSVoVlu8vjJi3gfmRZmYP4rTsYz5I2aS0HZirXzCd6zOudaC6txJag==
X-Google-Smtp-Source: AGHT+IErWc/EF4yO/GsSLGH4UN19fjyyFu2ijPAcsjK58jl9mdviWlSB1G7dPKqPCIqxc7UnWhR0rw==
X-Received: by 2002:a05:6a00:4b4a:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-7489cfbb3b3mr20955146b3a.15.1750245365958;
        Wed, 18 Jun 2025 04:16:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748efa19750sm717606b3a.58.2025.06.18.04.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:16:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AEAED4596078; Wed, 18 Jun 2025 18:15:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/4] Documentation: ext4: Slurp included subdocs in high-level overview docs
Date: Wed, 18 Jun 2025 18:15:34 +0700
Message-ID: <20250618111544.22602-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618111544.22602-1-bagasdotme@gmail.com>
References: <20250618111544.22602-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=73921; i=bagasdotme@gmail.com; h=from:subject; bh=K5pTB5IITvkRTBBRO+8HubCgsx539iFFT7LH9lgg4Sk=; b=kA0DAAoW9rmJSVVRTqMByyZiAGhSnyaiLz1+AdYQ8EGiVSZwm2SifBdiJkX9xEdlpFS26POZI Yh1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmhSnyYACgkQ9rmJSVVRTqNedgEAu1Zb UA4cyRS/CYcz3zAq1YlfdYvzQl4+wQdNad4FCZwBAPdvueHdaOZWoNAZutB2jAH1uKZGs4xq7h/ fyXHxwKEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Slurp subdocumentations for high-level ext4 design overview
(overview.rst) by replacing reST include:: directive with their
respective contents.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/ext4/allocators.rst |  56 --
 .../filesystems/ext4/atomic_writes.rst        | 225 -----
 Documentation/filesystems/ext4/bigalloc.rst   |  34 -
 Documentation/filesystems/ext4/blockgroup.rst | 135 ---
 Documentation/filesystems/ext4/blocks.rst     | 144 ---
 Documentation/filesystems/ext4/checksums.rst  |  73 --
 Documentation/filesystems/ext4/eainode.rst    |  18 -
 Documentation/filesystems/ext4/inlinedata.rst |  37 -
 Documentation/filesystems/ext4/overview.rst   | 819 +++++++++++++++++-
 .../filesystems/ext4/special_inodes.rst       |  55 --
 Documentation/filesystems/ext4/verity.rst     |  44 -
 11 files changed, 809 insertions(+), 831 deletions(-)
 delete mode 100644 Documentation/filesystems/ext4/allocators.rst
 delete mode 100644 Documentation/filesystems/ext4/atomic_writes.rst
 delete mode 100644 Documentation/filesystems/ext4/bigalloc.rst
 delete mode 100644 Documentation/filesystems/ext4/blockgroup.rst
 delete mode 100644 Documentation/filesystems/ext4/blocks.rst
 delete mode 100644 Documentation/filesystems/ext4/checksums.rst
 delete mode 100644 Documentation/filesystems/ext4/eainode.rst
 delete mode 100644 Documentation/filesystems/ext4/inlinedata.rst
 delete mode 100644 Documentation/filesystems/ext4/special_inodes.rst
 delete mode 100644 Documentation/filesystems/ext4/verity.rst

diff --git a/Documentation/filesystems/ext4/allocators.rst b/Documentation/filesystems/ext4/allocators.rst
deleted file mode 100644
index 7aa85152ace3d0..00000000000000
--- a/Documentation/filesystems/ext4/allocators.rst
+++ /dev/null
@@ -1,56 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Block and Inode Allocation Policy
----------------------------------
-
-ext4 recognizes (better than ext3, anyway) that data locality is
-generally a desirably quality of a filesystem. On a spinning disk,
-keeping related blocks near each other reduces the amount of movement
-that the head actuator and disk must perform to access a data block,
-thus speeding up disk IO. On an SSD there of course are no moving parts,
-but locality can increase the size of each transfer request while
-reducing the total number of requests. This locality may also have the
-effect of concentrating writes on a single erase block, which can speed
-up file rewrites significantly. Therefore, it is useful to reduce
-fragmentation whenever possible.
-
-The first tool that ext4 uses to combat fragmentation is the multi-block
-allocator. When a file is first created, the block allocator
-speculatively allocates 8KiB of disk space to the file on the assumption
-that the space will get written soon. When the file is closed, the
-unused speculative allocations are of course freed, but if the
-speculation is correct (typically the case for full writes of small
-files) then the file data gets written out in a single multi-block
-extent. A second related trick that ext4 uses is delayed allocation.
-Under this scheme, when a file needs more blocks to absorb file writes,
-the filesystem defers deciding the exact placement on the disk until all
-the dirty buffers are being written out to disk. By not committing to a
-particular placement until it's absolutely necessary (the commit timeout
-is hit, or sync() is called, or the kernel runs out of memory), the hope
-is that the filesystem can make better location decisions.
-
-The third trick that ext4 (and ext3) uses is that it tries to keep a
-file's data blocks in the same block group as its inode. This cuts down
-on the seek penalty when the filesystem first has to read a file's inode
-to learn where the file's data blocks live and then seek over to the
-file's data blocks to begin I/O operations.
-
-The fourth trick is that all the inodes in a directory are placed in the
-same block group as the directory, when feasible. The working assumption
-here is that all the files in a directory might be related, therefore it
-is useful to try to keep them all together.
-
-The fifth trick is that the disk volume is cut up into 128MB block
-groups; these mini-containers are used as outlined above to try to
-maintain data locality. However, there is a deliberate quirk -- when a
-directory is created in the root directory, the inode allocator scans
-the block groups and puts that directory into the least heavily loaded
-block group that it can find. This encourages directories to spread out
-over a disk; as the top-level directory/file blobs fill up one block
-group, the allocators simply move on to the next block group. Allegedly
-this scheme evens out the loading on the block groups, though the author
-suspects that the directories which are so unlucky as to land towards
-the end of a spinning drive get a raw deal performance-wise.
-
-Of course if all of these mechanisms fail, one can always use e4defrag
-to defragment files.
diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
deleted file mode 100644
index f65767df3620d5..00000000000000
--- a/Documentation/filesystems/ext4/atomic_writes.rst
+++ /dev/null
@@ -1,225 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-.. _atomic_writes:
-
-Atomic Block Writes
--------------------------
-
-Introduction
-~~~~~~~~~~~~
-
-Atomic (untorn) block writes ensure that either the entire write is committed
-to disk or none of it is. This prevents "torn writes" during power loss or
-system crashes. The ext4 filesystem supports atomic writes (only with Direct
-I/O) on regular files with extents, provided the underlying storage device
-supports hardware atomic writes. This is supported in the following two ways:
-
-1. **Single-fsblock Atomic Writes**:
-   EXT4's supports atomic write operations with a single filesystem block since
-   v6.13. In this the atomic write unit minimum and maximum sizes are both set
-   to filesystem blocksize.
-   e.g. doing atomic write of 16KB with 16KB filesystem blocksize on 64KB
-   pagesize system is possible.
-
-2. **Multi-fsblock Atomic Writes with Bigalloc**:
-   EXT4 now also supports atomic writes spanning multiple filesystem blocks
-   using a feature known as bigalloc. The atomic write unit's minimum and
-   maximum sizes are determined by the filesystem block size and cluster size,
-   based on the underlying device’s supported atomic write unit limits.
-
-Requirements
-~~~~~~~~~~~~
-
-Basic requirements for atomic writes in ext4:
-
- 1. The extents feature must be enabled (default for ext4)
- 2. The underlying block device must support atomic writes
- 3. For single-fsblock atomic writes:
-
-    1. A filesystem with appropriate block size (up to the page size)
- 4. For multi-fsblock atomic writes:
-
-    1. The bigalloc feature must be enabled
-    2. The cluster size must be appropriately configured
-
-NOTE: EXT4 does not support software or COW based atomic write, which means
-atomic writes on ext4 are only supported if underlying storage device supports
-it.
-
-Multi-fsblock Implementation Details
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-The bigalloc feature changes ext4 to allocate in units of multiple filesystem
-blocks, also known as clusters. With bigalloc each bit within block bitmap
-represents cluster (power of 2 number of blocks) rather than individual
-filesystem blocks.
-EXT4 supports multi-fsblock atomic writes with bigalloc, subject to the
-following constraints. The minimum atomic write size is the larger of the fs
-block size and the minimum hardware atomic write unit; and the maximum atomic
-write size is smaller of the bigalloc cluster size and the maximum hardware
-atomic write unit.  Bigalloc ensures that all allocations are aligned to the
-cluster size, which satisfies the LBA alignment requirements of the hardware
-device if the start of the partition/logical volume is itself aligned correctly.
-
-Here is the block allocation strategy in bigalloc for atomic writes:
-
- * For regions with fully mapped extents, no additional work is needed
- * For append writes, a new mapped extent is allocated
- * For regions that are entirely holes, unwritten extent is created
- * For large unwritten extents, the extent gets split into two unwritten
-   extents of appropriate requested size
- * For mixed mapping regions (combinations of holes, unwritten extents, or
-   mapped extents), ext4_map_blocks() is called in a loop with
-   EXT4_GET_BLOCKS_ZERO flag to convert the region into a single contiguous
-   mapped extent by writing zeroes to it and converting any unwritten extents to
-   written, if found within the range.
-
-Note: Writing on a single contiguous underlying extent, whether mapped or
-unwritten, is not inherently problematic. However, writing to a mixed mapping
-region (i.e. one containing a combination of mapped and unwritten extents)
-must be avoided when performing atomic writes.
-
-The reason is that, atomic writes when issued via pwritev2() with the RWF_ATOMIC
-flag, requires that either all data is written or none at all. In the event of
-a system crash or unexpected power loss during the write operation, the affected
-region (when later read) must reflect either the complete old data or the
-complete new data, but never a mix of both.
-
-To enforce this guarantee, we ensure that the write target is backed by
-a single, contiguous extent before any data is written. This is critical because
-ext4 defers the conversion of unwritten extents to written extents until the I/O
-completion path (typically in ->end_io()). If a write is allowed to proceed over
-a mixed mapping region (with mapped and unwritten extents) and a failure occurs
-mid-write, the system could observe partially updated regions after reboot, i.e.
-new data over mapped areas, and stale (old) data over unwritten extents that
-were never marked written. This violates the atomicity and/or torn write
-prevention guarantee.
-
-To prevent such torn writes, ext4 proactively allocates a single contiguous
-extent for the entire requested region in ``ext4_iomap_alloc`` via
-``ext4_map_blocks_atomic()``. EXT4 also force commits the current journalling
-transaction in case if allocation is done over mixed mapping. This ensures any
-pending metadata updates (like unwritten to written extents conversion) in this
-range are in consistent state with the file data blocks, before performing the
-actual write I/O. If the commit fails, the whole I/O must be aborted to prevent
-from any possible torn writes.
-Only after this step, the actual data write operation is performed by the iomap.
-
-Handling Split Extents Across Leaf Blocks
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-There can be a special edge case where we have logically and physically
-contiguous extents stored in separate leaf nodes of the on-disk extent tree.
-This occurs because on-disk extent tree merges only happens within the leaf
-blocks except for a case where we have 2-level tree which can get merged and
-collapsed entirely into the inode.
-If such a layout exists and, in the worst case, the extent status cache entries
-are reclaimed due to memory pressure, ``ext4_map_blocks()`` may never return
-a single contiguous extent for these split leaf extents.
-
-To address this edge case, a new get block flag
-``EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS flag`` is added to enhance the
-``ext4_map_query_blocks()`` lookup behavior.
-
-This new get block flag allows ``ext4_map_blocks()`` to first check if there is
-an entry in the extent status cache for the full range.
-If not present, it consults the on-disk extent tree using
-``ext4_map_query_blocks()``.
-If the located extent is at the end of a leaf node, it probes the next logical
-block (lblk) to detect a contiguous extent in the adjacent leaf.
-
-For now only one additional leaf block is queried to maintain efficiency, as
-atomic writes are typically constrained to small sizes
-(e.g. [blocksize, clustersize]).
-
-
-Handling Journal transactions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-To support multi-fsblock atomic writes, we ensure enough journal credits are
-reserved during:
-
- 1. Block allocation time in ``ext4_iomap_alloc()``. We first query if there
-    could be a mixed mapping for the underlying requested range. If yes, then we
-    reserve credits of up to ``m_len``, assuming every alternate block can be
-    an unwritten extent followed by a hole.
-
- 2. During ``->end_io()`` call, we make sure a single transaction is started for
-    doing unwritten-to-written conversion. The loop for conversion is mainly
-    only required to handle a split extent across leaf blocks.
-
-How to
-------
-
-Creating Filesystems with Atomic Write Support
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-First check the atomic write units supported by block device.
-See :ref:`atomic_write_bdev_support` for more details.
-
-For single-fsblock atomic writes with a larger block size
-(on systems with block size < page size):
-
-.. code-block:: bash
-
-    # Create an ext4 filesystem with a 16KB block size
-    # (requires page size >= 16KB)
-    mkfs.ext4 -b 16384 /dev/device
-
-For multi-fsblock atomic writes with bigalloc:
-
-.. code-block:: bash
-
-    # Create an ext4 filesystem with bigalloc and 64KB cluster size
-    mkfs.ext4 -F -O bigalloc -b 4096 -C 65536 /dev/device
-
-Where ``-b`` specifies the block size, ``-C`` specifies the cluster size in bytes,
-and ``-O bigalloc`` enables the bigalloc feature.
-
-Application Interface
-~~~~~~~~~~~~~~~~~~~~~
-
-Applications can use the ``pwritev2()`` system call with the ``RWF_ATOMIC`` flag
-to perform atomic writes:
-
-.. code-block:: c
-
-    pwritev2(fd, iov, iovcnt, offset, RWF_ATOMIC);
-
-The write must be aligned to the filesystem's block size and not exceed the
-filesystem's maximum atomic write unit size.
-See ``generic_atomic_write_valid()`` for more details.
-
-``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provides following
-details:
-
- * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
- * ``stx_atomic_write_unit_max``: Maximum size of an atomic write request.
- * ``stx_atomic_write_segments_max``: Upper limit for segments. The number of
-   separate memory buffers that can be gathered into a write operation
-   (e.g., the iovcnt parameter for IOV_ITER). Currently, this is always set to one.
-
-The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
-writes are supported.
-
-.. _atomic_write_bdev_support:
-
-Hardware Support
-----------------
-
-The underlying storage device must support atomic write operations.
-Modern NVMe and SCSI devices often provide this capability.
-The Linux kernel exposes this information through sysfs:
-
-* ``/sys/block/<device>/queue/atomic_write_unit_min`` - Minimum atomic write size
-* ``/sys/block/<device>/queue/atomic_write_unit_max`` - Maximum atomic write size
-
-Nonzero values for these attributes indicate that the device supports
-atomic writes.
-
-See Also
---------
-
-* :doc:`bigalloc` - Documentation on the bigalloc feature
-* :doc:`allocators` - Documentation on block allocation in ext4
-* Support for atomic block writes in 6.13:
-  https://lwn.net/Articles/1009298/
diff --git a/Documentation/filesystems/ext4/bigalloc.rst b/Documentation/filesystems/ext4/bigalloc.rst
deleted file mode 100644
index 976a180b209c2a..00000000000000
--- a/Documentation/filesystems/ext4/bigalloc.rst
+++ /dev/null
@@ -1,34 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Bigalloc
---------
-
-At the moment, the default size of a block is 4KiB, which is a commonly
-supported page size on most MMU-capable hardware. This is fortunate, as
-ext4 code is not prepared to handle the case where the block size
-exceeds the page size. However, for a filesystem of mostly huge files,
-it is desirable to be able to allocate disk blocks in units of multiple
-blocks to reduce both fragmentation and metadata overhead. The
-bigalloc feature provides exactly this ability.
-
-The bigalloc feature (EXT4_FEATURE_RO_COMPAT_BIGALLOC) changes ext4 to
-use clustered allocation, so that each bit in the ext4 block allocation
-bitmap addresses a power of two number of blocks. For example, if the
-file system is mainly going to be storing large files in the 4-32
-megabyte range, it might make sense to set a cluster size of 1 megabyte.
-This means that each bit in the block allocation bitmap now addresses
-256 4k blocks. This shrinks the total size of the block allocation
-bitmaps for a 2T file system from 64 megabytes to 256 kilobytes. It also
-means that a block group addresses 32 gigabytes instead of 128 megabytes,
-also shrinking the amount of file system overhead for metadata.
-
-The administrator can set a block cluster size at mkfs time (which is
-stored in the s_log_cluster_size field in the superblock); from then
-on, the block bitmaps track clusters, not individual blocks. This means
-that block groups can be several gigabytes in size (instead of just
-128MiB); however, the minimum allocation unit becomes a cluster, not a
-block, even for directories. TaoBao had a patchset to extend the “use
-units of clusters instead of blocks” to the extent tree, though it is
-not clear where those patches went-- they eventually morphed into
-“extent tree v2” but that code has not landed as of May 2015.
-
diff --git a/Documentation/filesystems/ext4/blockgroup.rst b/Documentation/filesystems/ext4/blockgroup.rst
deleted file mode 100644
index ed5a5cac6d40e1..00000000000000
--- a/Documentation/filesystems/ext4/blockgroup.rst
+++ /dev/null
@@ -1,135 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Layout
-------
-
-The layout of a standard block group is approximately as follows (each
-of these fields is discussed in a separate section below):
-
-.. list-table::
-   :widths: 1 1 1 1 1 1 1 1
-   :header-rows: 1
-
-   * - Group 0 Padding
-     - ext4 Super Block
-     - Group Descriptors
-     - Reserved GDT Blocks
-     - Data Block Bitmap
-     - inode Bitmap
-     - inode Table
-     - Data Blocks
-   * - 1024 bytes
-     - 1 block
-     - many blocks
-     - many blocks
-     - 1 block
-     - 1 block
-     - many blocks
-     - many more blocks
-
-For the special case of block group 0, the first 1024 bytes are unused,
-to allow for the installation of x86 boot sectors and other oddities.
-The superblock will start at offset 1024 bytes, whichever block that
-happens to be (usually 0). However, if for some reason the block size =
-1024, then block 0 is marked in use and the superblock goes in block 1.
-For all other block groups, there is no padding.
-
-The ext4 driver primarily works with the superblock and the group
-descriptors that are found in block group 0. Redundant copies of the
-superblock and group descriptors are written to some of the block groups
-across the disk in case the beginning of the disk gets trashed, though
-not all block groups necessarily host a redundant copy (see following
-paragraph for more details). If the group does not have a redundant
-copy, the block group begins with the data block bitmap. Note also that
-when the filesystem is freshly formatted, mkfs will allocate “reserve
-GDT block” space after the block group descriptors and before the start
-of the block bitmaps to allow for future expansion of the filesystem. By
-default, a filesystem is allowed to increase in size by a factor of
-1024x over the original filesystem size.
-
-The location of the inode table is given by ``grp.bg_inode_table_*``. It
-is continuous range of blocks large enough to contain
-``sb.s_inodes_per_group * sb.s_inode_size`` bytes.
-
-As for the ordering of items in a block group, it is generally
-established that the super block and the group descriptor table, if
-present, will be at the beginning of the block group. The bitmaps and
-the inode table can be anywhere, and it is quite possible for the
-bitmaps to come after the inode table, or for both to be in different
-groups (flex_bg). Leftover space is used for file data blocks, indirect
-block maps, extent tree blocks, and extended attributes.
-
-Flexible Block Groups
----------------------
-
-Starting in ext4, there is a new feature called flexible block groups
-(flex_bg). In a flex_bg, several block groups are tied together as one
-logical block group; the bitmap spaces and the inode table space in the
-first block group of the flex_bg are expanded to include the bitmaps
-and inode tables of all other block groups in the flex_bg. For example,
-if the flex_bg size is 4, then group 0 will contain (in order) the
-superblock, group descriptors, data block bitmaps for groups 0-3, inode
-bitmaps for groups 0-3, inode tables for groups 0-3, and the remaining
-space in group 0 is for file data. The effect of this is to group the
-block group metadata close together for faster loading, and to enable
-large files to be continuous on disk. Backup copies of the superblock
-and group descriptors are always at the beginning of block groups, even
-if flex_bg is enabled. The number of block groups that make up a
-flex_bg is given by 2 ^ ``sb.s_log_groups_per_flex``.
-
-Meta Block Groups
------------------
-
-Without the option META_BG, for safety concerns, all block group
-descriptors copies are kept in the first block group. Given the default
-128MiB(2^27 bytes) block group size and 64-byte group descriptors, ext4
-can have at most 2^27/64 = 2^21 block groups. This limits the entire
-filesystem size to 2^21 * 2^27 = 2^48bytes or 256TiB.
-
-The solution to this problem is to use the metablock group feature
-(META_BG), which is already in ext3 for all 2.6 releases. With the
-META_BG feature, ext4 filesystems are partitioned into many metablock
-groups. Each metablock group is a cluster of block groups whose group
-descriptor structures can be stored in a single disk block. For ext4
-filesystems with 4 KB block size, a single metablock group partition
-includes 64 block groups, or 8 GiB of disk space. The metablock group
-feature moves the location of the group descriptors from the congested
-first block group of the whole filesystem into the first group of each
-metablock group itself. The backups are in the second and last group of
-each metablock group. This increases the 2^21 maximum block groups limit
-to the hard limit 2^32, allowing support for a 512PiB filesystem.
-
-The change in the filesystem format replaces the current scheme where
-the superblock is followed by a variable-length set of block group
-descriptors. Instead, the superblock and a single block group descriptor
-block is placed at the beginning of the first, second, and last block
-groups in a meta-block group. A meta-block group is a collection of
-block groups which can be described by a single block group descriptor
-block. Since the size of the block group descriptor structure is 64
-bytes, a meta-block group contains 16 block groups for filesystems with
-a 1KB block size, and 64 block groups for filesystems with a 4KB
-blocksize. Filesystems can either be created using this new block group
-descriptor layout, or existing filesystems can be resized on-line, and
-the field s_first_meta_bg in the superblock will indicate the first
-block group using this new layout.
-
-Please see an important note about ``BLOCK_UNINIT`` in the section about
-block and inode bitmaps.
-
-Lazy Block Group Initialization
--------------------------------
-
-A new feature for ext4 are three block group descriptor flags that
-enable mkfs to skip initializing other parts of the block group
-metadata. Specifically, the INODE_UNINIT and BLOCK_UNINIT flags mean
-that the inode and block bitmaps for that group can be calculated and
-therefore the on-disk bitmap blocks are not initialized. This is
-generally the case for an empty block group or a block group containing
-only fixed-location block group metadata. The INODE_ZEROED flag means
-that the inode table has been initialized; mkfs will unset this flag and
-rely on the kernel to initialize the inode tables in the background.
-
-By not writing zeroes to the bitmaps and inode table, mkfs time is
-reduced considerably. Note the feature flag is RO_COMPAT_GDT_CSUM,
-but the dumpe2fs output prints this as “uninit_bg”. They are the same
-thing.
diff --git a/Documentation/filesystems/ext4/blocks.rst b/Documentation/filesystems/ext4/blocks.rst
deleted file mode 100644
index b0f80ea87c90e1..00000000000000
--- a/Documentation/filesystems/ext4/blocks.rst
+++ /dev/null
@@ -1,144 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Blocks
-------
-
-ext4 allocates storage space in units of “blocks”. A block is a group of
-sectors between 1KiB and 64KiB, and the number of sectors must be an
-integral power of 2. Blocks are in turn grouped into larger units called
-block groups. Block size is specified at mkfs time and typically is
-4KiB. You may experience mounting problems if block size is greater than
-page size (i.e. 64KiB blocks on a i386 which only has 4KiB memory
-pages). By default a filesystem can contain 2^32 blocks; if the '64bit'
-feature is enabled, then a filesystem can have 2^64 blocks. The location
-of structures is stored in terms of the block number the structure lives
-in and not the absolute offset on disk.
-
-For 32-bit filesystems, limits are as follows:
-
-.. list-table::
-   :widths: 1 1 1 1 1
-   :header-rows: 1
-
-   * - Item
-     - 1KiB
-     - 2KiB
-     - 4KiB
-     - 64KiB
-   * - Blocks
-     - 2^32
-     - 2^32
-     - 2^32
-     - 2^32
-   * - Inodes
-     - 2^32
-     - 2^32
-     - 2^32
-     - 2^32
-   * - File System Size
-     - 4TiB
-     - 8TiB
-     - 16TiB
-     - 256TiB
-   * - Blocks Per Block Group
-     - 8,192
-     - 16,384
-     - 32,768
-     - 524,288
-   * - Inodes Per Block Group
-     - 8,192
-     - 16,384
-     - 32,768
-     - 524,288
-   * - Block Group Size
-     - 8MiB
-     - 32MiB
-     - 128MiB
-     - 32GiB
-   * - Blocks Per File, Extents
-     - 2^32
-     - 2^32
-     - 2^32
-     - 2^32
-   * - Blocks Per File, Block Maps
-     - 16,843,020
-     - 134,480,396
-     - 1,074,791,436
-     - 4,398,314,962,956 (really 2^32 due to field size limitations)
-   * - File Size, Extents
-     - 4TiB
-     - 8TiB
-     - 16TiB
-     - 256TiB
-   * - File Size, Block Maps
-     - 16GiB
-     - 256GiB
-     - 4TiB
-     - 256TiB
-
-For 64-bit filesystems, limits are as follows:
-
-.. list-table::
-   :widths: 1 1 1 1 1
-   :header-rows: 1
-
-   * - Item
-     - 1KiB
-     - 2KiB
-     - 4KiB
-     - 64KiB
-   * - Blocks
-     - 2^64
-     - 2^64
-     - 2^64
-     - 2^64
-   * - Inodes
-     - 2^32
-     - 2^32
-     - 2^32
-     - 2^32
-   * - File System Size
-     - 16ZiB
-     - 32ZiB
-     - 64ZiB
-     - 1YiB
-   * - Blocks Per Block Group
-     - 8,192
-     - 16,384
-     - 32,768
-     - 524,288
-   * - Inodes Per Block Group
-     - 8,192
-     - 16,384
-     - 32,768
-     - 524,288
-   * - Block Group Size
-     - 8MiB
-     - 32MiB
-     - 128MiB
-     - 32GiB
-   * - Blocks Per File, Extents
-     - 2^32
-     - 2^32
-     - 2^32
-     - 2^32
-   * - Blocks Per File, Block Maps
-     - 16,843,020
-     - 134,480,396
-     - 1,074,791,436
-     - 4,398,314,962,956 (really 2^32 due to field size limitations)
-   * - File Size, Extents
-     - 4TiB
-     - 8TiB
-     - 16TiB
-     - 256TiB
-   * - File Size, Block Maps
-     - 16GiB
-     - 256GiB
-     - 4TiB
-     - 256TiB
-
-Note: Files not using extents (i.e. files using block maps) must be
-placed within the first 2^32 blocks of a filesystem. Files with extents
-must be placed within the first 2^48 blocks of a filesystem. It's not
-clear what happens with larger filesystems.
diff --git a/Documentation/filesystems/ext4/checksums.rst b/Documentation/filesystems/ext4/checksums.rst
deleted file mode 100644
index e232749daf5f30..00000000000000
--- a/Documentation/filesystems/ext4/checksums.rst
+++ /dev/null
@@ -1,73 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Checksums
----------
-
-Starting in early 2012, metadata checksums were added to all major ext4
-and jbd2 data structures. The associated feature flag is metadata_csum.
-The desired checksum algorithm is indicated in the superblock, though as
-of October 2012 the only supported algorithm is crc32c. Some data
-structures did not have space to fit a full 32-bit checksum, so only the
-lower 16 bits are stored. Enabling the 64bit feature increases the data
-structure size so that full 32-bit checksums can be stored for many data
-structures. However, existing 32-bit filesystems cannot be extended to
-enable 64bit mode, at least not without the experimental resize2fs
-patches to do so.
-
-Existing filesystems can have checksumming added by running
-``tune2fs -O metadata_csum`` against the underlying device. If tune2fs
-encounters directory blocks that lack sufficient empty space to add a
-checksum, it will request that you run ``e2fsck -D`` to have the
-directories rebuilt with checksums. This has the added benefit of
-removing slack space from the directory files and rebalancing the htree
-indexes. If you _ignore_ this step, your directories will not be
-protected by a checksum!
-
-The following table describes the data elements that go into each type
-of checksum. The checksum function is whatever the superblock describes
-(crc32c as of October 2013) unless noted otherwise.
-
-.. list-table::
-   :widths: 20 8 50
-   :header-rows: 1
-
-   * - Metadata
-     - Length
-     - Ingredients
-   * - Superblock
-     - __le32
-     - The entire superblock up to the checksum field. The UUID lives inside
-       the superblock.
-   * - MMP
-     - __le32
-     - UUID + the entire MMP block up to the checksum field.
-   * - Extended Attributes
-     - __le32
-     - UUID + the entire extended attribute block. The checksum field is set to
-       zero.
-   * - Directory Entries
-     - __le32
-     - UUID + inode number + inode generation + the directory block up to the
-       fake entry enclosing the checksum field.
-   * - HTREE Nodes
-     - __le32
-     - UUID + inode number + inode generation + all valid extents + HTREE tail.
-       The checksum field is set to zero.
-   * - Extents
-     - __le32
-     - UUID + inode number + inode generation + the entire extent block up to
-       the checksum field.
-   * - Bitmaps
-     - __le32 or __le16
-     - UUID + the entire bitmap. Checksums are stored in the group descriptor,
-       and truncated if the group descriptor size is 32 bytes (i.e. ^64bit)
-   * - Inodes
-     - __le32
-     - UUID + inode number + inode generation + the entire inode. The checksum
-       field is set to zero. Each inode has its own checksum.
-   * - Group Descriptors
-     - __le16
-     - If metadata_csum, then UUID + group number + the entire descriptor;
-       else if gdt_csum, then crc16(UUID + group number + the entire
-       descriptor). In all cases, only the lower 16 bits are stored.
-
diff --git a/Documentation/filesystems/ext4/eainode.rst b/Documentation/filesystems/ext4/eainode.rst
deleted file mode 100644
index 7a2ef26b064ac0..00000000000000
--- a/Documentation/filesystems/ext4/eainode.rst
+++ /dev/null
@@ -1,18 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Large Extended Attribute Values
--------------------------------
-
-To enable ext4 to store extended attribute values that do not fit in the
-inode or in the single extended attribute block attached to an inode,
-the EA_INODE feature allows us to store the value in the data blocks of
-a regular file inode. This “EA inode” is linked only from the extended
-attribute name index and must not appear in a directory entry. The
-inode's i_atime field is used to store a checksum of the xattr value;
-and i_ctime/i_version store a 64-bit reference count, which enables
-sharing of large xattr values between multiple owning inodes. For
-backward compatibility with older versions of this feature, the
-i_mtime/i_generation *may* store a back-reference to the inode number
-and i_generation of the **one** owning inode (in cases where the EA
-inode is not referenced by multiple inodes) to verify that the EA inode
-is the correct one being accessed.
diff --git a/Documentation/filesystems/ext4/inlinedata.rst b/Documentation/filesystems/ext4/inlinedata.rst
deleted file mode 100644
index a728af0d2fd0c5..00000000000000
--- a/Documentation/filesystems/ext4/inlinedata.rst
+++ /dev/null
@@ -1,37 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Inline Data
------------
-
-The inline data feature was designed to handle the case that a file's
-data is so tiny that it readily fits inside the inode, which
-(theoretically) reduces disk block consumption and reduces seeks. If the
-file is smaller than 60 bytes, then the data are stored inline in
-``inode.i_block``. If the rest of the file would fit inside the extended
-attribute space, then it might be found as an extended attribute
-“system.data” within the inode body (“ibody EA”). This of course
-constrains the amount of extended attributes one can attach to an inode.
-If the data size increases beyond i_block + ibody EA, a regular block
-is allocated and the contents moved to that block.
-
-Pending a change to compact the extended attribute key used to store
-inline data, one ought to be able to store 160 bytes of data in a
-256-byte inode (as of June 2015, when i_extra_isize is 28). Prior to
-that, the limit was 156 bytes due to inefficient use of inode space.
-
-The inline data feature requires the presence of an extended attribute
-for “system.data”, even if the attribute value is zero length.
-
-Inline Directories
-~~~~~~~~~~~~~~~~~~
-
-The first four bytes of i_block are the inode number of the parent
-directory. Following that is a 56-byte space for an array of directory
-entries; see ``struct ext4_dir_entry``. If there is a “system.data”
-attribute in the inode body, the EA value is an array of
-``struct ext4_dir_entry`` as well. Note that for inline directories, the
-i_block and EA space are treated as separate dirent blocks; directory
-entries cannot span the two.
-
-Inline directory entries are not checksummed, as the inode checksum
-should protect all inline data contents.
diff --git a/Documentation/filesystems/ext4/overview.rst b/Documentation/filesystems/ext4/overview.rst
index 9d4054c17ecb7b..f402ba37179f02 100644
--- a/Documentation/filesystems/ext4/overview.rst
+++ b/Documentation/filesystems/ext4/overview.rst
@@ -16,13 +16,812 @@ All fields in ext4 are written to disk in little-endian order. HOWEVER,
 all fields in jbd2 (the journal) are written to disk in big-endian
 order.
 
-.. include:: blocks.rst
-.. include:: blockgroup.rst
-.. include:: special_inodes.rst
-.. include:: allocators.rst
-.. include:: checksums.rst
-.. include:: bigalloc.rst
-.. include:: inlinedata.rst
-.. include:: eainode.rst
-.. include:: verity.rst
-.. include:: atomic_writes.rst
+Blocks
+------
+
+ext4 allocates storage space in units of “blocks”. A block is a group of
+sectors between 1KiB and 64KiB, and the number of sectors must be an
+integral power of 2. Blocks are in turn grouped into larger units called
+block groups. Block size is specified at mkfs time and typically is
+4KiB. You may experience mounting problems if block size is greater than
+page size (i.e. 64KiB blocks on a i386 which only has 4KiB memory
+pages). By default a filesystem can contain 2^32 blocks; if the '64bit'
+feature is enabled, then a filesystem can have 2^64 blocks. The location
+of structures is stored in terms of the block number the structure lives
+in and not the absolute offset on disk.
+
+For 32-bit filesystems, limits are as follows:
+
+.. list-table::
+   :widths: 1 1 1 1 1
+   :header-rows: 1
+
+   * - Item
+     - 1KiB
+     - 2KiB
+     - 4KiB
+     - 64KiB
+   * - Blocks
+     - 2^32
+     - 2^32
+     - 2^32
+     - 2^32
+   * - Inodes
+     - 2^32
+     - 2^32
+     - 2^32
+     - 2^32
+   * - File System Size
+     - 4TiB
+     - 8TiB
+     - 16TiB
+     - 256TiB
+   * - Blocks Per Block Group
+     - 8,192
+     - 16,384
+     - 32,768
+     - 524,288
+   * - Inodes Per Block Group
+     - 8,192
+     - 16,384
+     - 32,768
+     - 524,288
+   * - Block Group Size
+     - 8MiB
+     - 32MiB
+     - 128MiB
+     - 32GiB
+   * - Blocks Per File, Extents
+     - 2^32
+     - 2^32
+     - 2^32
+     - 2^32
+   * - Blocks Per File, Block Maps
+     - 16,843,020
+     - 134,480,396
+     - 1,074,791,436
+     - 4,398,314,962,956 (really 2^32 due to field size limitations)
+   * - File Size, Extents
+     - 4TiB
+     - 8TiB
+     - 16TiB
+     - 256TiB
+   * - File Size, Block Maps
+     - 16GiB
+     - 256GiB
+     - 4TiB
+     - 256TiB
+
+For 64-bit filesystems, limits are as follows:
+
+.. list-table::
+   :widths: 1 1 1 1 1
+   :header-rows: 1
+
+   * - Item
+     - 1KiB
+     - 2KiB
+     - 4KiB
+     - 64KiB
+   * - Blocks
+     - 2^64
+     - 2^64
+     - 2^64
+     - 2^64
+   * - Inodes
+     - 2^32
+     - 2^32
+     - 2^32
+     - 2^32
+   * - File System Size
+     - 16ZiB
+     - 32ZiB
+     - 64ZiB
+     - 1YiB
+   * - Blocks Per Block Group
+     - 8,192
+     - 16,384
+     - 32,768
+     - 524,288
+   * - Inodes Per Block Group
+     - 8,192
+     - 16,384
+     - 32,768
+     - 524,288
+   * - Block Group Size
+     - 8MiB
+     - 32MiB
+     - 128MiB
+     - 32GiB
+   * - Blocks Per File, Extents
+     - 2^32
+     - 2^32
+     - 2^32
+     - 2^32
+   * - Blocks Per File, Block Maps
+     - 16,843,020
+     - 134,480,396
+     - 1,074,791,436
+     - 4,398,314,962,956 (really 2^32 due to field size limitations)
+   * - File Size, Extents
+     - 4TiB
+     - 8TiB
+     - 16TiB
+     - 256TiB
+   * - File Size, Block Maps
+     - 16GiB
+     - 256GiB
+     - 4TiB
+     - 256TiB
+
+.. note::
+   Files not using extents (i.e. files using block maps) must be
+   placed within the first 2^32 blocks of a filesystem. Files with extents
+   must be placed within the first 2^48 blocks of a filesystem. It's not
+   clear what happens with larger filesystems.
+
+Layout
+------
+
+The layout of a standard block group is approximately as follows (each
+of these fields is discussed in a separate section below):
+
+.. list-table::
+   :widths: 1 1 1 1 1 1 1 1
+   :header-rows: 1
+
+   * - Group 0 Padding
+     - ext4 Super Block
+     - Group Descriptors
+     - Reserved GDT Blocks
+     - Data Block Bitmap
+     - inode Bitmap
+     - inode Table
+     - Data Blocks
+   * - 1024 bytes
+     - 1 block
+     - many blocks
+     - many blocks
+     - 1 block
+     - 1 block
+     - many blocks
+     - many more blocks
+
+For the special case of block group 0, the first 1024 bytes are unused,
+to allow for the installation of x86 boot sectors and other oddities.
+The superblock will start at offset 1024 bytes, whichever block that
+happens to be (usually 0). However, if for some reason the block size =
+1024, then block 0 is marked in use and the superblock goes in block 1.
+For all other block groups, there is no padding.
+
+The ext4 driver primarily works with the superblock and the group
+descriptors that are found in block group 0. Redundant copies of the
+superblock and group descriptors are written to some of the block groups
+across the disk in case the beginning of the disk gets trashed, though
+not all block groups necessarily host a redundant copy (see following
+paragraph for more details). If the group does not have a redundant
+copy, the block group begins with the data block bitmap. Note also that
+when the filesystem is freshly formatted, mkfs will allocate “reserve
+GDT block” space after the block group descriptors and before the start
+of the block bitmaps to allow for future expansion of the filesystem. By
+default, a filesystem is allowed to increase in size by a factor of
+1024x over the original filesystem size.
+
+The location of the inode table is given by ``grp.bg_inode_table_*``. It
+is continuous range of blocks large enough to contain
+``sb.s_inodes_per_group * sb.s_inode_size`` bytes.
+
+As for the ordering of items in a block group, it is generally
+established that the super block and the group descriptor table, if
+present, will be at the beginning of the block group. The bitmaps and
+the inode table can be anywhere, and it is quite possible for the
+bitmaps to come after the inode table, or for both to be in different
+groups (flex_bg). Leftover space is used for file data blocks, indirect
+block maps, extent tree blocks, and extended attributes.
+
+Flexible Block Groups
+---------------------
+
+Starting in ext4, there is a new feature called flexible block groups
+(flex_bg). In a flex_bg, several block groups are tied together as one
+logical block group; the bitmap spaces and the inode table space in the
+first block group of the flex_bg are expanded to include the bitmaps
+and inode tables of all other block groups in the flex_bg. For example,
+if the flex_bg size is 4, then group 0 will contain (in order) the
+superblock, group descriptors, data block bitmaps for groups 0-3, inode
+bitmaps for groups 0-3, inode tables for groups 0-3, and the remaining
+space in group 0 is for file data. The effect of this is to group the
+block group metadata close together for faster loading, and to enable
+large files to be continuous on disk. Backup copies of the superblock
+and group descriptors are always at the beginning of block groups, even
+if flex_bg is enabled. The number of block groups that make up a
+flex_bg is given by 2 ^ ``sb.s_log_groups_per_flex``.
+
+Meta Block Groups
+-----------------
+
+Without the option META_BG, for safety concerns, all block group
+descriptors copies are kept in the first block group. Given the default
+128MiB(2^27 bytes) block group size and 64-byte group descriptors, ext4
+can have at most 2^27/64 = 2^21 block groups. This limits the entire
+filesystem size to 2^21 * 2^27 = 2^48bytes or 256TiB.
+
+The solution to this problem is to use the metablock group feature
+(META_BG), which is already in ext3 for all 2.6 releases. With the
+META_BG feature, ext4 filesystems are partitioned into many metablock
+groups. Each metablock group is a cluster of block groups whose group
+descriptor structures can be stored in a single disk block. For ext4
+filesystems with 4 KB block size, a single metablock group partition
+includes 64 block groups, or 8 GiB of disk space. The metablock group
+feature moves the location of the group descriptors from the congested
+first block group of the whole filesystem into the first group of each
+metablock group itself. The backups are in the second and last group of
+each metablock group. This increases the 2^21 maximum block groups limit
+to the hard limit 2^32, allowing support for a 512PiB filesystem.
+
+The change in the filesystem format replaces the current scheme where
+the superblock is followed by a variable-length set of block group
+descriptors. Instead, the superblock and a single block group descriptor
+block is placed at the beginning of the first, second, and last block
+groups in a meta-block group. A meta-block group is a collection of
+block groups which can be described by a single block group descriptor
+block. Since the size of the block group descriptor structure is 64
+bytes, a meta-block group contains 16 block groups for filesystems with
+a 1KB block size, and 64 block groups for filesystems with a 4KB
+blocksize. Filesystems can either be created using this new block group
+descriptor layout, or existing filesystems can be resized on-line, and
+the field s_first_meta_bg in the superblock will indicate the first
+block group using this new layout.
+
+Please see an important note about ``BLOCK_UNINIT`` in the section about
+block and inode bitmaps.
+
+Lazy Block Group Initialization
+-------------------------------
+
+A new feature for ext4 are three block group descriptor flags that
+enable mkfs to skip initializing other parts of the block group
+metadata. Specifically, the INODE_UNINIT and BLOCK_UNINIT flags mean
+that the inode and block bitmaps for that group can be calculated and
+therefore the on-disk bitmap blocks are not initialized. This is
+generally the case for an empty block group or a block group containing
+only fixed-location block group metadata. The INODE_ZEROED flag means
+that the inode table has been initialized; mkfs will unset this flag and
+rely on the kernel to initialize the inode tables in the background.
+
+By not writing zeroes to the bitmaps and inode table, mkfs time is
+reduced considerably. Note the feature flag is RO_COMPAT_GDT_CSUM,
+but the dumpe2fs output prints this as “uninit_bg”. They are the same
+thing.
+
+Special inodes
+--------------
+
+ext4 reserves some inode for special features, as follows:
+
+.. list-table::
+   :widths: 6 70
+   :header-rows: 1
+
+   * - inode Number
+     - Purpose
+   * - 0
+     - Doesn't exist; there is no inode 0.
+   * - 1
+     - List of defective blocks.
+   * - 2
+     - Root directory.
+   * - 3
+     - User quota.
+   * - 4
+     - Group quota.
+   * - 5
+     - Boot loader.
+   * - 6
+     - Undelete directory.
+   * - 7
+     - Reserved group descriptors inode. (“resize inode”)
+   * - 8
+     - Journal inode.
+   * - 9
+     - The “exclude” inode, for snapshots(?)
+   * - 10
+     - Replica inode, used for some non-upstream feature?
+   * - 11
+     - Traditional first non-reserved inode. Usually this is the lost+found directory. See s_first_ino in the superblock.
+
+Note that there are also some inodes allocated from non-reserved inode numbers
+for other filesystem features which are not referenced from standard directory
+hierarchy. These are generally reference from the superblock. They are:
+
+.. list-table::
+   :widths: 20 50
+   :header-rows: 1
+
+   * - Superblock field
+     - Description
+
+   * - s_lpf_ino
+     - Inode number of lost+found directory.
+   * - s_prj_quota_inum
+     - Inode number of quota file tracking project quotas
+   * - s_orphan_file_inum
+     - Inode number of file tracking orphan inodes.
+
+Block and Inode Allocation Policy
+---------------------------------
+
+ext4 recognizes (better than ext3, anyway) that data locality is
+generally a desirably quality of a filesystem. On a spinning disk,
+keeping related blocks near each other reduces the amount of movement
+that the head actuator and disk must perform to access a data block,
+thus speeding up disk IO. On an SSD there of course are no moving parts,
+but locality can increase the size of each transfer request while
+reducing the total number of requests. This locality may also have the
+effect of concentrating writes on a single erase block, which can speed
+up file rewrites significantly. Therefore, it is useful to reduce
+fragmentation whenever possible.
+
+The first tool that ext4 uses to combat fragmentation is the multi-block
+allocator. When a file is first created, the block allocator
+speculatively allocates 8KiB of disk space to the file on the assumption
+that the space will get written soon. When the file is closed, the
+unused speculative allocations are of course freed, but if the
+speculation is correct (typically the case for full writes of small
+files) then the file data gets written out in a single multi-block
+extent. A second related trick that ext4 uses is delayed allocation.
+Under this scheme, when a file needs more blocks to absorb file writes,
+the filesystem defers deciding the exact placement on the disk until all
+the dirty buffers are being written out to disk. By not committing to a
+particular placement until it's absolutely necessary (the commit timeout
+is hit, or sync() is called, or the kernel runs out of memory), the hope
+is that the filesystem can make better location decisions.
+
+The third trick that ext4 (and ext3) uses is that it tries to keep a
+file's data blocks in the same block group as its inode. This cuts down
+on the seek penalty when the filesystem first has to read a file's inode
+to learn where the file's data blocks live and then seek over to the
+file's data blocks to begin I/O operations.
+
+The fourth trick is that all the inodes in a directory are placed in the
+same block group as the directory, when feasible. The working assumption
+here is that all the files in a directory might be related, therefore it
+is useful to try to keep them all together.
+
+The fifth trick is that the disk volume is cut up into 128MB block
+groups; these mini-containers are used as outlined above to try to
+maintain data locality. However, there is a deliberate quirk -- when a
+directory is created in the root directory, the inode allocator scans
+the block groups and puts that directory into the least heavily loaded
+block group that it can find. This encourages directories to spread out
+over a disk; as the top-level directory/file blobs fill up one block
+group, the allocators simply move on to the next block group. Allegedly
+this scheme evens out the loading on the block groups, though the author
+suspects that the directories which are so unlucky as to land towards
+the end of a spinning drive get a raw deal performance-wise.
+
+Of course if all of these mechanisms fail, one can always use e4defrag
+to defragment files.
+
+Checksums
+---------
+
+Starting in early 2012, metadata checksums were added to all major ext4
+and jbd2 data structures. The associated feature flag is metadata_csum.
+The desired checksum algorithm is indicated in the superblock, though as
+of October 2012 the only supported algorithm is crc32c. Some data
+structures did not have space to fit a full 32-bit checksum, so only the
+lower 16 bits are stored. Enabling the 64bit feature increases the data
+structure size so that full 32-bit checksums can be stored for many data
+structures. However, existing 32-bit filesystems cannot be extended to
+enable 64bit mode, at least not without the experimental resize2fs
+patches to do so.
+
+Existing filesystems can have checksumming added by running
+``tune2fs -O metadata_csum`` against the underlying device. If tune2fs
+encounters directory blocks that lack sufficient empty space to add a
+checksum, it will request that you run ``e2fsck -D`` to have the
+directories rebuilt with checksums. This has the added benefit of
+removing slack space from the directory files and rebalancing the htree
+indexes. If you _ignore_ this step, your directories will not be
+protected by a checksum!
+
+The following table describes the data elements that go into each type
+of checksum. The checksum function is whatever the superblock describes
+(crc32c as of October 2013) unless noted otherwise.
+
+.. list-table::
+   :widths: 20 8 50
+   :header-rows: 1
+
+   * - Metadata
+     - Length
+     - Ingredients
+   * - Superblock
+     - __le32
+     - The entire superblock up to the checksum field. The UUID lives inside
+       the superblock.
+   * - MMP
+     - __le32
+     - UUID + the entire MMP block up to the checksum field.
+   * - Extended Attributes
+     - __le32
+     - UUID + the entire extended attribute block. The checksum field is set to
+       zero.
+   * - Directory Entries
+     - __le32
+     - UUID + inode number + inode generation + the directory block up to the
+       fake entry enclosing the checksum field.
+   * - HTREE Nodes
+     - __le32
+     - UUID + inode number + inode generation + all valid extents + HTREE tail.
+       The checksum field is set to zero.
+   * - Extents
+     - __le32
+     - UUID + inode number + inode generation + the entire extent block up to
+       the checksum field.
+   * - Bitmaps
+     - __le32 or __le16
+     - UUID + the entire bitmap. Checksums are stored in the group descriptor,
+       and truncated if the group descriptor size is 32 bytes (i.e. ^64bit)
+   * - Inodes
+     - __le32
+     - UUID + inode number + inode generation + the entire inode. The checksum
+       field is set to zero. Each inode has its own checksum.
+   * - Group Descriptors
+     - __le16
+     - If metadata_csum, then UUID + group number + the entire descriptor;
+       else if gdt_csum, then crc16(UUID + group number + the entire
+       descriptor). In all cases, only the lower 16 bits are stored.
+
+Bigalloc
+--------
+
+At the moment, the default size of a block is 4KiB, which is a commonly
+supported page size on most MMU-capable hardware. This is fortunate, as
+ext4 code is not prepared to handle the case where the block size
+exceeds the page size. However, for a filesystem of mostly huge files,
+it is desirable to be able to allocate disk blocks in units of multiple
+blocks to reduce both fragmentation and metadata overhead. The
+bigalloc feature provides exactly this ability.
+
+The bigalloc feature (EXT4_FEATURE_RO_COMPAT_BIGALLOC) changes ext4 to
+use clustered allocation, so that each bit in the ext4 block allocation
+bitmap addresses a power of two number of blocks. For example, if the
+file system is mainly going to be storing large files in the 4-32
+megabyte range, it might make sense to set a cluster size of 1 megabyte.
+This means that each bit in the block allocation bitmap now addresses
+256 4k blocks. This shrinks the total size of the block allocation
+bitmaps for a 2T file system from 64 megabytes to 256 kilobytes. It also
+means that a block group addresses 32 gigabytes instead of 128 megabytes,
+also shrinking the amount of file system overhead for metadata.
+
+The administrator can set a block cluster size at mkfs time (which is
+stored in the s_log_cluster_size field in the superblock); from then
+on, the block bitmaps track clusters, not individual blocks. This means
+that block groups can be several gigabytes in size (instead of just
+128MiB); however, the minimum allocation unit becomes a cluster, not a
+block, even for directories. TaoBao had a patchset to extend the “use
+units of clusters instead of blocks” to the extent tree, though it is
+not clear where those patches went-- they eventually morphed into
+“extent tree v2” but that code has not landed as of May 2015.
+
+Inline Data
+-----------
+
+The inline data feature was designed to handle the case that a file's
+data is so tiny that it readily fits inside the inode, which
+(theoretically) reduces disk block consumption and reduces seeks. If the
+file is smaller than 60 bytes, then the data are stored inline in
+``inode.i_block``. If the rest of the file would fit inside the extended
+attribute space, then it might be found as an extended attribute
+“system.data” within the inode body (“ibody EA”). This of course
+constrains the amount of extended attributes one can attach to an inode.
+If the data size increases beyond i_block + ibody EA, a regular block
+is allocated and the contents moved to that block.
+
+Pending a change to compact the extended attribute key used to store
+inline data, one ought to be able to store 160 bytes of data in a
+256-byte inode (as of June 2015, when i_extra_isize is 28). Prior to
+that, the limit was 156 bytes due to inefficient use of inode space.
+
+The inline data feature requires the presence of an extended attribute
+for “system.data”, even if the attribute value is zero length.
+
+Inline Directories
+~~~~~~~~~~~~~~~~~~
+
+The first four bytes of i_block are the inode number of the parent
+directory. Following that is a 56-byte space for an array of directory
+entries; see ``struct ext4_dir_entry``. If there is a “system.data”
+attribute in the inode body, the EA value is an array of
+``struct ext4_dir_entry`` as well. Note that for inline directories, the
+i_block and EA space are treated as separate dirent blocks; directory
+entries cannot span the two.
+
+Inline directory entries are not checksummed, as the inode checksum
+should protect all inline data contents.
+
+Large Extended Attribute Values
+-------------------------------
+
+To enable ext4 to store extended attribute values that do not fit in the
+inode or in the single extended attribute block attached to an inode,
+the EA_INODE feature allows us to store the value in the data blocks of
+a regular file inode. This “EA inode” is linked only from the extended
+attribute name index and must not appear in a directory entry. The
+inode's i_atime field is used to store a checksum of the xattr value;
+and i_ctime/i_version store a 64-bit reference count, which enables
+sharing of large xattr values between multiple owning inodes. For
+backward compatibility with older versions of this feature, the
+i_mtime/i_generation *may* store a back-reference to the inode number
+and i_generation of the **one** owning inode (in cases where the EA
+inode is not referenced by multiple inodes) to verify that the EA inode
+is the correct one being accessed.
+
+Verity files
+------------
+
+ext4 supports fs-verity, which is a filesystem feature that provides
+Merkle tree based hashing for individual readonly files.  Most of
+fs-verity is common to all filesystems that support it; see
+:ref:`Documentation/filesystems/fsverity.rst <fsverity>` for the
+fs-verity documentation.  However, the on-disk layout of the verity
+metadata is filesystem-specific.  On ext4, the verity metadata is
+stored after the end of the file data itself, in the following format:
+
+- Zero-padding to the next 65536-byte boundary.  This padding need not
+  actually be allocated on-disk, i.e. it may be a hole.
+
+- The Merkle tree, as documented in
+  :ref:`Documentation/filesystems/fsverity.rst
+  <fsverity_merkle_tree>`, with the tree levels stored in order from
+  root to leaf, and the tree blocks within each level stored in their
+  natural order.
+
+- Zero-padding to the next filesystem block boundary.
+
+- The verity descriptor, as documented in
+  :ref:`Documentation/filesystems/fsverity.rst <fsverity_descriptor>`,
+  with optionally appended signature blob.
+
+- Zero-padding to the next offset that is 4 bytes before a filesystem
+  block boundary.
+
+- The size of the verity descriptor in bytes, as a 4-byte little
+  endian integer.
+
+Verity inodes have EXT4_VERITY_FL set, and they must use extents, i.e.
+EXT4_EXTENTS_FL must be set and EXT4_INLINE_DATA_FL must be clear.
+They can have EXT4_ENCRYPT_FL set, in which case the verity metadata
+is encrypted as well as the data itself.
+
+Verity files cannot have blocks allocated past the end of the verity
+metadata.
+
+Verity and DAX are not compatible and attempts to set both of these flags
+on a file will fail.
+
+Atomic Block Writes
+-------------------
+
+Introduction
+~~~~~~~~~~~~
+
+Atomic (untorn) block writes ensure that either the entire write is committed
+to disk or none of it is. This prevents "torn writes" during power loss or
+system crashes. The ext4 filesystem supports atomic writes (only with Direct
+I/O) on regular files with extents, provided the underlying storage device
+supports hardware atomic writes. This is supported in the following two ways:
+
+1. **Single-fsblock Atomic Writes**:
+   ext4 supports atomic write operations with a single filesystem block since
+   v6.13. In this the atomic write unit minimum and maximum sizes are both set
+   to filesystem blocksize.
+   e.g. doing atomic write of 16KB with 16KB filesystem blocksize on 64KB
+   pagesize system is possible.
+
+2. **Multi-fsblock Atomic Writes with Bigalloc**:
+   ext4 now also supports atomic writes spanning multiple filesystem blocks
+   using a feature known as bigalloc. The atomic write unit's minimum and
+   maximum sizes are determined by the filesystem block size and cluster size,
+   based on the underlying device’s supported atomic write unit limits.
+
+Requirements
+~~~~~~~~~~~~
+
+Basic requirements for atomic writes in ext4:
+
+ 1. The extents feature must be enabled (default for ext4)
+ 2. The underlying block device must support atomic writes
+ 3. For single-fsblock atomic writes:
+
+    1. A filesystem with appropriate block size (up to the page size)
+ 4. For multi-fsblock atomic writes:
+
+    1. The bigalloc feature must be enabled
+    2. The cluster size must be appropriately configured
+
+.. note::
+   ext4 does not support software or COW based atomic write, which means
+   atomic writes on ext4 are only supported if underlying storage device
+   supports it.
+
+Multi-fsblock Implementation Details
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The bigalloc feature changes ext4 to allocate in units of multiple filesystem
+blocks, also known as clusters. With bigalloc each bit within block bitmap
+represents cluster (power of 2 number of blocks) rather than individual
+filesystem blocks.
+
+ext4 supports multi-fsblock atomic writes with bigalloc, subject to the
+following constraints. The minimum atomic write size is the larger of the fs
+block size and the minimum hardware atomic write unit; and the maximum atomic
+write size is smaller of the bigalloc cluster size and the maximum hardware
+atomic write unit.  Bigalloc ensures that all allocations are aligned to the
+cluster size, which satisfies the LBA alignment requirements of the hardware
+device if the start of the partition/logical volume is itself aligned correctly.
+
+Here is the block allocation strategy in bigalloc for atomic writes:
+
+ * For regions with fully mapped extents, no additional work is needed
+ * For append writes, a new mapped extent is allocated
+ * For regions that are entirely holes, unwritten extent is created
+ * For large unwritten extents, the extent gets split into two unwritten
+   extents of appropriate requested size
+ * For mixed mapping regions (combinations of holes, unwritten extents, or
+   mapped extents), ext4_map_blocks() is called in a loop with
+   EXT4_GET_BLOCKS_ZERO flag to convert the region into a single contiguous
+   mapped extent by writing zeroes to it and converting any unwritten extents to
+   written, if found within the range.
+
+.. note::
+   Writing on a single contiguous underlying extent, whether mapped or
+   unwritten, is not inherently problematic. However, writing to a mixed mapping
+   region (i.e. one containing a combination of mapped and unwritten extents)
+   must be avoided when performing atomic writes.
+
+The reason is that, atomic writes when issued via pwritev2() with the RWF_ATOMIC
+flag, requires that either all data is written or none at all. In the event of
+a system crash or unexpected power loss during the write operation, the affected
+region (when later read) must reflect either the complete old data or the
+complete new data, but never a mix of both.
+
+To enforce this guarantee, we ensure that the write target is backed by
+a single, contiguous extent before any data is written. This is critical because
+ext4 defers the conversion of unwritten extents to written extents until the I/O
+completion path (typically in ->end_io()). If a write is allowed to proceed over
+a mixed mapping region (with mapped and unwritten extents) and a failure occurs
+mid-write, the system could observe partially updated regions after reboot, i.e.
+new data over mapped areas, and stale (old) data over unwritten extents that
+were never marked written. This violates the atomicity and/or torn write
+prevention guarantee.
+
+To prevent such torn writes, ext4 proactively allocates a single contiguous
+extent for the entire requested region in ``ext4_iomap_alloc`` via
+``ext4_map_blocks_atomic()``. ext4 also force commits the current journalling
+transaction in case if allocation is done over mixed mapping. This ensures any
+pending metadata updates (like unwritten to written extents conversion) in this
+range are in consistent state with the file data blocks, before performing the
+actual write I/O. If the commit fails, the whole I/O must be aborted to prevent
+from any possible torn writes.
+Only after this step, the actual data write operation is performed by the iomap.
+
+Handling Split Extents Across Leaf Blocks
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There can be a special edge case where we have logically and physically
+contiguous extents stored in separate leaf nodes of the on-disk extent tree.
+This occurs because on-disk extent tree merges only happens within the leaf
+blocks except for a case where we have 2-level tree which can get merged and
+collapsed entirely into the inode.
+If such a layout exists and, in the worst case, the extent status cache entries
+are reclaimed due to memory pressure, ``ext4_map_blocks()`` may never return
+a single contiguous extent for these split leaf extents.
+
+To address this edge case, a new get block flag
+``EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS flag`` is added to enhance the
+``ext4_map_query_blocks()`` lookup behavior.
+
+This new get block flag allows ``ext4_map_blocks()`` to first check if there is
+an entry in the extent status cache for the full range.
+If not present, it consults the on-disk extent tree using
+``ext4_map_query_blocks()``.
+If the located extent is at the end of a leaf node, it probes the next logical
+block (lblk) to detect a contiguous extent in the adjacent leaf.
+
+For now only one additional leaf block is queried to maintain efficiency, as
+atomic writes are typically constrained to small sizes
+(e.g. [blocksize, clustersize]).
+
+
+Handling Journal transactions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To support multi-fsblock atomic writes, we ensure enough journal credits are
+reserved during:
+
+ 1. Block allocation time in ``ext4_iomap_alloc()``. We first query if there
+    could be a mixed mapping for the underlying requested range. If yes, then we
+    reserve credits of up to ``m_len``, assuming every alternate block can be
+    an unwritten extent followed by a hole.
+
+ 2. During ``->end_io()`` call, we make sure a single transaction is started for
+    doing unwritten-to-written conversion. The loop for conversion is mainly
+    only required to handle a split extent across leaf blocks.
+
+How to
+~~~~~~
+
+Creating Filesystems with Atomic Write Support
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+First check the atomic write units supported by block device.
+See :ref:`atomic_write_bdev_support` for more details.
+
+For single-fsblock atomic writes with a larger block size
+(on systems with block size < page size):
+
+.. code-block:: bash
+
+    # Create an ext4 filesystem with a 16KB block size
+    # (requires page size >= 16KB)
+    mkfs.ext4 -b 16384 /dev/device
+
+For multi-fsblock atomic writes with bigalloc:
+
+.. code-block:: bash
+
+    # Create an ext4 filesystem with bigalloc and 64KB cluster size
+    mkfs.ext4 -F -O bigalloc -b 4096 -C 65536 /dev/device
+
+Where ``-b`` specifies the block size, ``-C`` specifies the cluster size in bytes,
+and ``-O bigalloc`` enables the bigalloc feature.
+
+Application Interface
+^^^^^^^^^^^^^^^^^^^^^
+
+Applications can use the ``pwritev2()`` system call with the ``RWF_ATOMIC`` flag
+to perform atomic writes:
+
+.. code-block:: c
+
+    pwritev2(fd, iov, iovcnt, offset, RWF_ATOMIC);
+
+The write must be aligned to the filesystem's block size and not exceed the
+filesystem's maximum atomic write unit size.
+See ``generic_atomic_write_valid()`` for more details.
+
+``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provides following
+details:
+
+ * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
+ * ``stx_atomic_write_unit_max``: Maximum size of an atomic write request.
+ * ``stx_atomic_write_segments_max``: Upper limit for segments. The number of
+   separate memory buffers that can be gathered into a write operation
+   (e.g., the iovcnt parameter for IOV_ITER). Currently, this is always set to one.
+
+The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
+writes are supported.
+
+.. _atomic_write_bdev_support:
+
+Hardware Support
+~~~~~~~~~~~~~~~~
+
+The underlying storage device must support atomic write operations.
+Modern NVMe and SCSI devices often provide this capability.
+The Linux kernel exposes this information through sysfs:
+
+* ``/sys/block/<device>/queue/atomic_write_unit_min`` - Minimum atomic write size
+* ``/sys/block/<device>/queue/atomic_write_unit_max`` - Maximum atomic write size
+
+Nonzero values for these attributes indicate that the device supports
+atomic writes.
+
+See Also
+~~~~~~~~
+
+* Support for atomic block writes in 6.13:
+  https://lwn.net/Articles/1009298/
diff --git a/Documentation/filesystems/ext4/special_inodes.rst b/Documentation/filesystems/ext4/special_inodes.rst
deleted file mode 100644
index fc0636901fa0e1..00000000000000
--- a/Documentation/filesystems/ext4/special_inodes.rst
+++ /dev/null
@@ -1,55 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Special inodes
---------------
-
-ext4 reserves some inode for special features, as follows:
-
-.. list-table::
-   :widths: 6 70
-   :header-rows: 1
-
-   * - inode Number
-     - Purpose
-   * - 0
-     - Doesn't exist; there is no inode 0.
-   * - 1
-     - List of defective blocks.
-   * - 2
-     - Root directory.
-   * - 3
-     - User quota.
-   * - 4
-     - Group quota.
-   * - 5
-     - Boot loader.
-   * - 6
-     - Undelete directory.
-   * - 7
-     - Reserved group descriptors inode. (“resize inode”)
-   * - 8
-     - Journal inode.
-   * - 9
-     - The “exclude” inode, for snapshots(?)
-   * - 10
-     - Replica inode, used for some non-upstream feature?
-   * - 11
-     - Traditional first non-reserved inode. Usually this is the lost+found directory. See s_first_ino in the superblock.
-
-Note that there are also some inodes allocated from non-reserved inode numbers
-for other filesystem features which are not referenced from standard directory
-hierarchy. These are generally reference from the superblock. They are:
-
-.. list-table::
-   :widths: 20 50
-   :header-rows: 1
-
-   * - Superblock field
-     - Description
-
-   * - s_lpf_ino
-     - Inode number of lost+found directory.
-   * - s_prj_quota_inum
-     - Inode number of quota file tracking project quotas
-   * - s_orphan_file_inum
-     - Inode number of file tracking orphan inodes.
diff --git a/Documentation/filesystems/ext4/verity.rst b/Documentation/filesystems/ext4/verity.rst
deleted file mode 100644
index e99ff3fd09f7e7..00000000000000
--- a/Documentation/filesystems/ext4/verity.rst
+++ /dev/null
@@ -1,44 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Verity files
-------------
-
-ext4 supports fs-verity, which is a filesystem feature that provides
-Merkle tree based hashing for individual readonly files.  Most of
-fs-verity is common to all filesystems that support it; see
-:ref:`Documentation/filesystems/fsverity.rst <fsverity>` for the
-fs-verity documentation.  However, the on-disk layout of the verity
-metadata is filesystem-specific.  On ext4, the verity metadata is
-stored after the end of the file data itself, in the following format:
-
-- Zero-padding to the next 65536-byte boundary.  This padding need not
-  actually be allocated on-disk, i.e. it may be a hole.
-
-- The Merkle tree, as documented in
-  :ref:`Documentation/filesystems/fsverity.rst
-  <fsverity_merkle_tree>`, with the tree levels stored in order from
-  root to leaf, and the tree blocks within each level stored in their
-  natural order.
-
-- Zero-padding to the next filesystem block boundary.
-
-- The verity descriptor, as documented in
-  :ref:`Documentation/filesystems/fsverity.rst <fsverity_descriptor>`,
-  with optionally appended signature blob.
-
-- Zero-padding to the next offset that is 4 bytes before a filesystem
-  block boundary.
-
-- The size of the verity descriptor in bytes, as a 4-byte little
-  endian integer.
-
-Verity inodes have EXT4_VERITY_FL set, and they must use extents, i.e.
-EXT4_EXTENTS_FL must be set and EXT4_INLINE_DATA_FL must be clear.
-They can have EXT4_ENCRYPT_FL set, in which case the verity metadata
-is encrypted as well as the data itself.
-
-Verity files cannot have blocks allocated past the end of the verity
-metadata.
-
-Verity and DAX are not compatible and attempts to set both of these flags
-on a file will fail.
-- 
An old man doll... just what I always wanted! - Clara


