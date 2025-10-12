Return-Path: <linux-kernel+bounces-849747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2161EBD0C9E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1BD3B753F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA34E23C8C5;
	Sun, 12 Oct 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GwAFG5jx"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C5215789
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304268; cv=none; b=AlB9DPY92d10GoV+aH2V2lzhzwlcPLifHtQbWoW4a+yHv396hBOj0ng5qrmcgdaGzgiJ0sq0ptxPbM+FWF9k0K85ltSf1VrhWLMppBDGYsZ/EaBpOzxCnFnC7ZC1QWwubvp3Gc4SBppbABDLFK+5v8Er86JK5MkSA6BbCm2Drd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304268; c=relaxed/simple;
	bh=GWSW57XzCOAwQmcAZPFVUn2FoWt6/4v6xQ1uP07OHks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TjvHW/Y9WZ97c3spdkIfzBZj407SiCSgL+YXLRbja92k2+PMDvcU9YmsyOSeWhcGS/CBpgYvwaxwr7nNfqKn5vxrT/zIsjGKl8b69MgxjUzr2B99PeXH8jmMEhz2Fxz0NidANAb9IBbssZJZJEeYGVQW2PvdJK1KOijti8+f2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GwAFG5jx; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760304264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DlrSvrRIPziBkR8wSveYCuBUFOtkY4vR8foA3oDN65k=;
	b=GwAFG5jxvsvJASn0H4ifsL0T87yYY4NhSJ11wE1MvBVVPIez9+FfQ0fgtWVeUBsa0aO9VE
	/ekIGByxcjZ+PUBpdbfu0UrF2BONqBDIlvr2RxDK7I4RebH73li726u+f2b8VAyYPo4Pe4
	xiXSboiPgjSZsA8EbK7FRHaUvkcGTx8=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 0/8] bcachefs out-of-tree series
Date: Sun, 12 Oct 2025 17:24:03 -0400
Message-ID: <20251012212414.3225948-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now includes a genradix patch adding overflow checks that ought to make
Kees happy, if he sees it. Otherwise - just commit message fixups.

(I'm the author and listed maintainer of that code).

Kent Overstreet (8):
  closures: Improve closure_put_after_sub_checks
  closures: closure_sub() uses cmpxchg
  closures: CLOSURE_SLEEPING
  closures: kill closure.closure_get_happened
  lib: Give closures, min_heap config opts names
  lib: Give XOR_BLOCKS, RAID6_PQ config opts names
  lib: Give compression, checksum, crypto config opts names
  generix-radix-tree: Overflow checking

 crypto/Kconfig                     |   2 +-
 fs/bcachefs/alloc_foreground.h     |   2 +-
 fs/bcachefs/fs-io-direct.c         |   1 -
 include/linux/closure.h            |  33 +++--
 include/linux/generic-radix-tree.h | 110 +++++++++-------
 lib/Kconfig                        |  24 ++--
 lib/closure.c                      | 203 +++++++++++++++--------------
 lib/crc/Kconfig                    |   4 +-
 lib/crypto/Kconfig                 |   4 +-
 9 files changed, 201 insertions(+), 182 deletions(-)

-- 
2.51.0


