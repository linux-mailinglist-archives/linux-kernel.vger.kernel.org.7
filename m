Return-Path: <linux-kernel+bounces-841904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8E8BB8812
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AE54C1A52
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC5279DB1;
	Sat,  4 Oct 2025 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S6hGIW4v"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E42777F2
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543260; cv=none; b=DBl+ozYiDYZQi+UHhT2XMPAdHgnIv3qNSrAa+GDmMnz6N8BNmpykJ8V0MOJQXiJajWmVzLiHd55xeGbuUKxeprPEX8NvWpYfowSMk+VuvwcHVPobH0IzHXkb1xej7Va69bCAAazex2rshESC9Nk1eWWFAPDx5F6wtzuAynSqiT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543260; c=relaxed/simple;
	bh=DtB9XCkCHl84vYMCaEW3s/Qn/8sI8ZCHY7OjghYLhyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGvtS1cQ4s3wHcGOuqdgHcl+1NrQFAclPitOZ47Bk5pPFjXatcUBCQ1VuYrgWyGYLvROdKpNf72xgakWr9JGysByDXAbaeVmwDzRtssiQES/mzanpjEyq/BxEyjh57Eww3i/WxM6okv5Uo269qdBGS6WvjRso6+Ns/orinYuzwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S6hGIW4v; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759543256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+KMR93xxxTiAFEHwmtxE1350l2cR73NI0MBMfbd0uwM=;
	b=S6hGIW4v7qxbQrTebazPKOPHi99vObtpeSsUzHn6IPUmsSuDwaaMNK7enSBeh5ETCscpSA
	gMmB4TPMcbZ5GcQa63/kYa1rco7wk0EAHqraJG5CW/LuuoWWKrzGb26a6lgs/2oItY3dnv
	WxMrQmtTOxBewyI89zYeP4Fo1sx6DSs=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/7] bcachefs out-of-tree series
Date: Fri,  3 Oct 2025 22:00:42 -0400
Message-ID: <20251004020049.918665-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A few patches for out-of-tree bcachefs.

Since bcachefs was dropped from mainline, the kconfig tweaks for lib/
are needed for it to build out of tree; they just give a few config
options names, so that distros can ensure they are enabled.

Also included is a bugfix patch series for closures for an issue with
unwinding closure_sync_timeout().

Kent Overstreet (7):
  closures: Improve closure_put_after_sub_checks
  closures: closure_sub() uses cmpxchg
  closures: CLOSURE_SLEEPING
  closures: kill closure.closure_get_happened
  lib: Give closures, min_heap config opts names
  lib: Give XOR_BLOCKS, RAID6_PQ config opts names
  lib: Give compression, checksum, crypto config opts names

 crypto/Kconfig                 |   2 +-
 fs/bcachefs/alloc_foreground.h |   2 +-
 fs/bcachefs/fs-io-direct.c     |   1 -
 include/linux/closure.h        |  33 +++---
 lib/Kconfig                    |  24 ++--
 lib/closure.c                  | 203 +++++++++++++++++----------------
 lib/crc/Kconfig                |   4 +-
 lib/crypto/Kconfig             |   4 +-
 8 files changed, 136 insertions(+), 137 deletions(-)

-- 
2.51.0


