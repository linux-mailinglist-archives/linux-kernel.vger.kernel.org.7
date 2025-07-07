Return-Path: <linux-kernel+bounces-719293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633F3AFAC4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 08:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA91172C64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFD9279DC4;
	Mon,  7 Jul 2025 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fhsVqF0m"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4F262FD7;
	Mon,  7 Jul 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871512; cv=none; b=FfmC+/j8dcjoD7IvQnHQl7f+V1+8xva0jusB3qBWfWRYfMfBlAe38kFImFpVThiATLMclWmUd1N8O/zLR2maFJxdo9J7Aancoda8RdcQUgA77u5Fu7IKn96s6OoDtBg1urNVx/2SZfdbqFAawwS8UKrKBxWpJeImuxrIJ66/kw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871512; c=relaxed/simple;
	bh=XsoAPqueJwzPmnl/cybEaV8AbzQ/KW8Zqt0xVFUUP7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qLD72c5kNylY3P7izAmGLFnvH/e1eh/ioKQXS3bGBRLSQzIwhkVHP9j2LiFi+9YIydlKQ6nfVPP6AgcZvawe+gooP5owueYoNI1urbdy54j5O6/CZGtEHaqXMW5WEOoDW08EnOtmAfIP3vUDcw5oinhyC0E3zpHoBdT8MsAMDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fhsVqF0m; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751871506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=//U6eJF/3Stqol0hp8qR+vLcRjhLZhuFUjDSy/i/3Fs=;
	b=fhsVqF0m6vOp5kwyDLWFzMAyLbliNRIah5IUO11AjvghlyL+uslQfPvoT3g3qvaIyTpsuf
	3tL3ntfvV7U2zr2smWauv4f4AtiR2OCy1O0fHOlwQqb2Jr+Ht95vAIua4w4hJNw8Ed7VpD
	1fyiawszVRPBzEeDBv6jKtXql9pt+do=
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: mpatocka@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	dan.j.williams@intel.com,
	Jonathan.Cameron@Huawei.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	dm-devel@lists.linux.dev,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH v2 00/11] dm-pcache – persistent-memory cache for block devices
Date: Mon,  7 Jul 2025 06:57:58 +0000
Message-ID: <20250707065809.437589-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Mikulas,
	This is V2 for dm-pcache, please take a look.

Code:
    https://github.com/DataTravelGuide/linux tags/pcache_v2

Changelogs

V2 from V1:
	- introduce req_alloc() and req_init() in backing_dev.c, then we
	  can do req_alloc() before holding spinlock and do req_init()
	  in subtree_walk().
	- introduce pre_alloc_key and pre_alloc_req in walk_ctx, that
	  means we can pre-allocate cache_key or backing_dev_request
	  before subtree walking.
	- use mempool_alloc() with NOIO for the allocation of cache_key
	  and backing_dev_req.
	- some coding style changes from comments of Jonathan.

V1 from RFC-V2:
	- use crc32c to replace crc32
	- only retry pcache_req when cache full, add pcache_req into defer_list,
	  and wait cache invalidation happen.
	- new format for pcache table, it is more easily extended with
	  new parameters later.
	- remove __packed.
	- use spin_lock_irq in req_complete_fn to replace
	  spin_lock_irqsave.
	- fix bug in backing_dev_bio_end with spin_lock_irqsave.
	- queue_work() inside spinlock.
	- introduce inline_bvecs in backing_dev_req.
	- use kmalloc_array for bvecs allocation.
	- calculate ->off with dm_target_offset() before use it.

Dongsheng Yang (11):
  dm-pcache: add pcache_internal.h
  dm-pcache: add backing device management
  dm-pcache: add cache device
  dm-pcache: add segment layer
  dm-pcache: add cache_segment
  dm-pcache: add cache_writeback
  dm-pcache: add cache_gc
  dm-pcache: add cache_key
  dm-pcache: add cache_req
  dm-pcache: add cache core
  dm-pcache: initial dm-pcache target

 .../admin-guide/device-mapper/dm-pcache.rst   | 201 ++++
 MAINTAINERS                                   |   8 +
 drivers/md/Kconfig                            |   2 +
 drivers/md/Makefile                           |   1 +
 drivers/md/dm-pcache/Kconfig                  |  17 +
 drivers/md/dm-pcache/Makefile                 |   3 +
 drivers/md/dm-pcache/backing_dev.c            | 345 +++++++
 drivers/md/dm-pcache/backing_dev.h            |  93 ++
 drivers/md/dm-pcache/cache.c                  | 432 +++++++++
 drivers/md/dm-pcache/cache.h                  | 616 ++++++++++++
 drivers/md/dm-pcache/cache_dev.c              | 299 ++++++
 drivers/md/dm-pcache/cache_dev.h              |  70 ++
 drivers/md/dm-pcache/cache_gc.c               | 170 ++++
 drivers/md/dm-pcache/cache_key.c              | 900 ++++++++++++++++++
 drivers/md/dm-pcache/cache_req.c              | 840 ++++++++++++++++
 drivers/md/dm-pcache/cache_segment.c          | 293 ++++++
 drivers/md/dm-pcache/cache_writeback.c        | 279 ++++++
 drivers/md/dm-pcache/dm_pcache.c              | 466 +++++++++
 drivers/md/dm-pcache/dm_pcache.h              |  65 ++
 drivers/md/dm-pcache/pcache_internal.h        | 117 +++
 drivers/md/dm-pcache/segment.c                |  61 ++
 drivers/md/dm-pcache/segment.h                |  73 ++
 22 files changed, 5351 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-pcache.rst
 create mode 100644 drivers/md/dm-pcache/Kconfig
 create mode 100644 drivers/md/dm-pcache/Makefile
 create mode 100644 drivers/md/dm-pcache/backing_dev.c
 create mode 100644 drivers/md/dm-pcache/backing_dev.h
 create mode 100644 drivers/md/dm-pcache/cache.c
 create mode 100644 drivers/md/dm-pcache/cache.h
 create mode 100644 drivers/md/dm-pcache/cache_dev.c
 create mode 100644 drivers/md/dm-pcache/cache_dev.h
 create mode 100644 drivers/md/dm-pcache/cache_gc.c
 create mode 100644 drivers/md/dm-pcache/cache_key.c
 create mode 100644 drivers/md/dm-pcache/cache_req.c
 create mode 100644 drivers/md/dm-pcache/cache_segment.c
 create mode 100644 drivers/md/dm-pcache/cache_writeback.c
 create mode 100644 drivers/md/dm-pcache/dm_pcache.c
 create mode 100644 drivers/md/dm-pcache/dm_pcache.h
 create mode 100644 drivers/md/dm-pcache/pcache_internal.h
 create mode 100644 drivers/md/dm-pcache/segment.c
 create mode 100644 drivers/md/dm-pcache/segment.h

-- 
2.43.0


