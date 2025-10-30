Return-Path: <linux-kernel+bounces-878215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9155EC200AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EEB404C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771FC314D0B;
	Thu, 30 Oct 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="B2tzm3l+"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D91F4F1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827719; cv=pass; b=HRJrk4O0DZKBmryIhBB4MLi8j2cqJtjmG0nBLWt5wWqn0GRGQbpQkFQQ5ekPFvwj1yzumqboqrqaDVAf1gELWfLO5YQRn3cCZM+ebkQf5uyfuGHiR0S8PR7q2d6cgGhBDgIUKlpIQIf8ldJ66XAWgm2NUCYWp59G7Ma1sUd9w7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827719; c=relaxed/simple;
	bh=HH5CD+ABj9c0/4cLQ0cEE3mbv7MXBlq3cBGimMKObKA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RM+vYiVEBiqzRG2MsL5YiKndqTfpX4SrcRY9w3+pq3OisckRmSoP1z1Kp2rqLmxPdA6UdoilC+IFhWzxiTEwtUSia+jdRenbOK0j+yEHWd6N5lWmzJuPXghDM7DhJr5vqPrROiHTZalwKZRaoN28/uQ9UTbdDvCjnFLdz03gObo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=B2tzm3l+; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1761827613; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l85XsWDqoVlNuW+HWY7lPnTZS4X0U011uCCxd6IGhin8sq1BX99JQ7YfkK7U0t6spBnHXUszdh5hD/iT7kVmQtbw4eeJ34gLRyQ3Uy39+6CQX8NhYwVIjaoeFcBuWQPyhx4FjjDfgH+WSWDZ0Vpl1Gx6q5eHcmNgtUp01gRWcQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761827613; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=K8HOkWwttrvijzQTji25uvp1UvEY1l+gmNnhNh8LP/w=; 
	b=Bp9ltoavwDowDcAvwg5naMbqVsKz+WBMZFH2ZZXFO8tI4qgtmhxCCn+0/8M3rRRpkW2NiTfNxjVaJ0qvZ80R6a/2tqAK1APyyWPf77zd1yq48inh/UcLhauo7yXkW8kTx7/eSyVwlReRjxW0odMYSso62HiMOne3QhgpGV9UBFY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761827613;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=K8HOkWwttrvijzQTji25uvp1UvEY1l+gmNnhNh8LP/w=;
	b=B2tzm3l+//VrABkECStbjMfjCgDaaSxeShHx4N70Osgqa16or5ls0gsYM5BhFu7L
	TcV+cfnRiUy6iIv4CrxFBsRU5/u5sim9WP4SAVX/AjOQBFrKHJSjW/tEp+6qs+xKSjD
	PnPRc2D4wZwkPiUy0lnyrWjw2ODBedPqbdgKj4ac=
Received: by mx.zohomail.com with SMTPS id 1761827609401301.4059578727405;
	Thu, 30 Oct 2025 05:33:29 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH 0/3] dm-pcache: built-in support and metadata hardening
Date: Thu, 30 Oct 2025 20:33:18 +0800
Message-ID: <20251030123323.967081-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

This three-patch series tidies dm-pcache’s build glue and tightens the metadata scan.

Patch 1 allow dm-pcache to be linked into vmlinux and avoids clashing with the sunrpc
cache_flush() by using obj-$(CONFIG_DM_PCACHE) and renaming the helper across the tree.

Patch 2 drops a redundant recomputation of the metadata slot pointer while walking headers.

Patch 3 zero-allocates a temporary buffer so callers never see stale metadata,
relies on __free(kvfree) for cleanup, and only copies back once a valid record is found.

Thanks for your review.

Li Chen (3):
  dm-pcache: allow built-in build and rename flush helper
  dm-pcache: reuse meta_addr in pcache_meta_find_latest
  dm-pcache: avoid leaking invalid metadata in pcache_meta_find_latest()

 drivers/md/dm-pcache/Makefile          |  2 +-
 drivers/md/dm-pcache/cache.c           |  2 +-
 drivers/md/dm-pcache/cache.h           |  2 +-
 drivers/md/dm-pcache/cache_req.c       |  6 +++---
 drivers/md/dm-pcache/pcache_internal.h | 15 ++++++++++-----
 5 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.51.0


