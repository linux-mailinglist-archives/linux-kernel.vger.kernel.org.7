Return-Path: <linux-kernel+bounces-833518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030FBBA2347
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACCF38840C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453225A328;
	Fri, 26 Sep 2025 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eTEUWRa/"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39AC41AAC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758853431; cv=none; b=OxMS1LvjJqZj2kYVntoDUEb0kEraxbpVGZJ0VH7KAcWYiG2amcrIQ2lH4FfICg2LYDbLmB/jJ0UiOq5QQVMUDsrN3mw7p9Ac9lv4yxFGZUwMp+GSxFmhyYM/tHhVrhPpqJVa8JKiY360rlcd3CZiP9H4OZcZeMyj2/RVd/QCPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758853431; c=relaxed/simple;
	bh=9Mh3ikPKDO02lGqbJFoV8tFYUJ5OmTK6KcEALUPSAFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tt+JsiU+vSJEJMBvDOycNWvW/uAlwyv7ec0Qm7W3qMSRLzBgVQhwMMdrFCIInH4EkKzxmL0xl4hAJdgjAuw24EJCctxsPBEFYEbKsh/ucmL2nigLrKokJPIqO2d+c0ZRqAudKEPZmH0RSgLuPKHqMZm/FILQpKpS2BnRzJFt/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eTEUWRa/; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758853416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFJUAlc1QedN1ML8UqazsmtqcsiA3368RFOlp1Qtjc0=;
	b=eTEUWRa/614WScGZACtLUDDBAg0WuIYH8QK1arxC9X4CinwDDMRGhTV8d3+0MZjJ9bjlHO
	mZireO8fFq1mD7bDlfKi58eCjo0OywkFHtBD37UFfZWkEeQxI8LW0QEqMdaEfpu25vPN9b
	8WoUNUTWsZkg7oEFNGQD/IPJjC+ClC0=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 0/3] bcachefs: Fix some hard link count issues
Date: Fri, 26 Sep 2025 10:21:47 +0800
Message-ID: <20250926022150.493115-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

- Improves error reporting by returning the semantically correct
  -EMLINK error code.
- Fixes the maximum link count validation logic during hard link
  creation.
- Consolidates link count checks at the VFS layer for better
  maintainability.

NOTE: Patch3 alone can resolve this series of issues, but patches1-2
are retained to better trace the problem origins.

Youling Tang (3):
  bcachefs: return -EMLINK instead of -EINVAL when hard link count
    exceeds limit
  bcachefs: Fix maximum link count check when creating hard links
  bcachefs: Move the link counting check to the VFS layer

 fs/bcachefs/bcachefs.h |  1 +
 fs/bcachefs/fs.c       |  1 +
 fs/bcachefs/inode.c    | 10 ++--------
 fs/bcachefs/inode.h    |  2 +-
 fs/bcachefs/namei.c    |  4 +---
 5 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.43.0


