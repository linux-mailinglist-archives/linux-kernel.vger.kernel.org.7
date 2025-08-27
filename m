Return-Path: <linux-kernel+bounces-788500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C8B38564
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAF83A487A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0634721A94F;
	Wed, 27 Aug 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dyWjE8Ui"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E02192F4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306115; cv=none; b=BMsPNIe62GLzgUqzngDypzmytz3y1KpG/ufBnXkvlwrG/O0Uz3TY5aHc4wUEpQw1cyRQ8MBswch/IhGtv4uYhdp5zXxr6Dwma6NvjKS+cPXPBcO4xv5cOXRgC5/Ja9FNzBtde/L5OFJkTbYu3+Qm3MwH3YAh+ir6mImENJX+yPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306115; c=relaxed/simple;
	bh=8ZilA80MCJAMf5BXQVQk6vZvGkIeIsf/cUxvkz6kllU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfODBLqq2Qy1H4ro64blqscmd8R5uCCwDQAgqoy67Den0b99FqG+a1ggeiNWjXFHWb8pmgz2Z977Oql9WaXy+hGiVLcwcV0VBHrIxQQl/O+zj35Bo85Hf5j4coLYNoQPgC9hV30BLi1chNxKFiFPZMcRcL2QgEDnq88F2eKDn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dyWjE8Ui; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756306100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WUat8dTvmu9vrcx/Az++te/7zJHiZ/fdv8U7AAxKddc=;
	b=dyWjE8Uip7kDbnMC5Rxu1r29myw0b4jQBM2/jEl/he5sVCMBzRej8X614ALgjLBKHtvgxn
	nqK74ZnVroa3IENlc2QPyb+G2GXmQvgpwbbvB7E3afEA9eJBy9nAMp2o0eMv6W7kyluO5O
	/zzFloDTlGD+fj15jh17WBa3jwqUHEM=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: corbet@lwn.net,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] docs: admin-guide: Fix typo in nfsroot.rst
Date: Wed, 27 Aug 2025 22:47:38 +0800
Message-Id: <20250827144738.43361-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is an obvious mistake in nfsroot.rst where pxelinux was wrongly
written as pxeliunx. Fix it.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 Documentation/admin-guide/nfs/nfsroot.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
index 135218f33394..06990309c6ff 100644
--- a/Documentation/admin-guide/nfs/nfsroot.rst
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -342,7 +342,7 @@ They depend on various facilities being available:
 	When using pxelinux, the kernel image is specified using
 	"kernel <relative-path-below /tftpboot>". The nfsroot parameters
 	are passed to the kernel by adding them to the "append" line.
-	It is common to use serial console in conjunction with pxeliunx,
+	It is common to use serial console in conjunction with pxelinux,
 	see Documentation/admin-guide/serial-console.rst for more information.
 
 	For more information on isolinux, including how to create bootdisks
-- 
2.34.1


