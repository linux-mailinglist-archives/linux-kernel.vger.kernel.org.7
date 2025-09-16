Return-Path: <linux-kernel+bounces-819703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B7B7F4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C5A37B82D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E7228469B;
	Tue, 16 Sep 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D58sC2Pv"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF1292B2E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061837; cv=none; b=avufleXGhVsrBg126/jN6ABDPzmqX5VasOEBr2INFDMFae08CpC0Hy4l4z+BEXAbLvrMc5THGvEjtJSJYjUGPYJ/E0PG+Y3L1e2OkNTCgMSWv50QE7hSlnWqTwIUtt+9XaNqQM23rLnlzlWe1hW+lu2deF3ekYR1OqmgJdWCg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061837; c=relaxed/simple;
	bh=fQSYWiW5H33VlAd/DMAPALF6CQ5aBsMUQZ2tRC+sRDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WV64UM3KRC2wP9+yjHEIOphdE6M2nih9GShaIYHdYSqtxmZUVFAMnkihbOAqbudPzyHCky38QmoJUSr56tSDMeEjm+jZ3dVMgiFVoobMKEGZbz3B8qGVyWVwI/mv2iH/yXmNVLSpTl5qMQR2VIaOCRsnIXc/8PRnKOiBK2QQYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D58sC2Pv; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758061821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ID8Oe+mxN4A1QCIZ/4llDDSDl+ekwYLMldOlIQM4grM=;
	b=D58sC2Pv7eR2dD/zcbyqknCMunhU+2xiA5Yu9JHFzAQ8wikP4F15bN9QZriREN59C/AODw
	XiODe49wTn52aG58rN9fSz5IH4a6rln0m/UBJ7FxKGr12jcK9CjYngONNDsR6dN59Q+cZG
	BxyEu7ZCUAthgIKu/DsZEJVLR/IS3hY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: maintainer: Fix ambiguous subheading formatting
Date: Wed, 17 Sep 2025 00:29:44 +0200
Message-ID: <20250916222944.2547948-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a newline after both subheadings to avoid any ambiguous formatting,
especially in htmldocs. Without the newline, subheadings are rendered as
part of the following paragraphs, which can be confusing to read.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Fix subheading formatting with newlines as suggested by Randy
- Link to v1: https://lore.kernel.org/r/20250915192235.2414746-2-thorsten.blum@linux.dev/
---
 Documentation/maintainer/maintainer-entry-profile.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index cda5d691e967..d36dd892a78a 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -59,6 +59,7 @@ week) that patches might be considered for merging and when patches need to
 wait for the next -rc. At a minimum:
 
 - Last -rc for new feature submissions:
+
   New feature submissions targeting the next merge window should have
   their first posting for consideration before this point. Patches that
   are submitted after this point should be clear that they are targeting
@@ -68,6 +69,7 @@ wait for the next -rc. At a minimum:
   submissions should appear before -rc5.
 
 - Last -rc to merge features: Deadline for merge decisions
+
   Indicate to contributors the point at which an as yet un-applied patch
   set will need to wait for the NEXT+1 merge window. Of course there is no
   obligation to ever accept any given patchset, but if the review has not
-- 
2.51.0


