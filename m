Return-Path: <linux-kernel+bounces-775094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64769B2BB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A283BEB89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28AF3112DD;
	Tue, 19 Aug 2025 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o9gOqjB5"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A35310654;
	Tue, 19 Aug 2025 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590100; cv=none; b=lTgJzQ30jg4ELAWpO6rp8x1P8HT9dHWmH7Rj4Pmd3mxJc5R0PEAYiRJoZESd+Y0JAUXlx0YJv5I7ZjqNxGsZjYnSSDYRGrMPm99IyCT/AvKHG12ZLhN5u5/QZb6ECY77mQWfo4kO76I4nA3DUo7XGtVcoKXU8B5twEEmDdbvT38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590100; c=relaxed/simple;
	bh=lOWRNPjAbWDU1OxWxL8IZOKvD7OnnxkkEk2IxwpgI+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzoBzgwK5SkaEWaTeJL1QdRYgj15nxVOmJCPbCT3qC4xWI0tLMJA+obuGxfbblF1BB/xDZNF+JCwuUx0XQbQRMoiMpYu8QLwh3lNJpRvWrwNMEPGu7rC9lHNbHyFZrRKZZCw5OPVM9MJtnMKWfQQ6f1sI05JaSVQQf97syABdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o9gOqjB5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4JFfscaUjEj0NSwaHft0IALdktI66k0BP5dIqYD4Mxs=; b=o9gOqjB57YX1BH/x/Ivops8m1e
	KnBgUygqlfwl3I7BS4cqerhdNwyiAbfeGqC9G4fbm/IyJD2oi9SyQLSRwTbhCL5RWplvRAXbgfSIT
	ixbRJUKcf2q1fB/yzc99gHfbs8pMqh6YUuQ1ZY2YjSZfV0oGwIWDabyKklMcvdakiZuND9exGJE0m
	W/CZEB34UCSfKk31iJH8PE6bxgVpHgmZG2MIi6Hjs+YqKNhpd14yphyKB9NBm10DSGkAESUrKVFcE
	GHvVdSR6/6k4SuzlD9fFj09BFyo3hr6IT8plu4OyCNfyR8/riIHWTM+ipMmsl/brvWeNthLT2BzwC
	hW1iUFhA==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoHBJ-00000009jht-1Vuj;
	Tue, 19 Aug 2025 07:54:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: sysctl: add a few more top-level /proc/sys entries
Date: Tue, 19 Aug 2025 00:54:56 -0700
Message-ID: <20250819075456.113623-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few missing directories under /proc/sys.
Fix punctuation and doubled words.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/sysctl/index.rst |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- linux-next-20250814.orig/Documentation/admin-guide/sysctl/index.rst
+++ linux-next-20250814/Documentation/admin-guide/sysctl/index.rst
@@ -66,25 +66,31 @@ This documentation is about:
 
 =============== ===============================================================
 abi/		execution domains & personalities
-debug/		<empty>
-dev/		device specific information (eg dev/cdrom/info)
+<$ARCH>		tuning controls for various CPU architecture (e.g. csky, s390)
+crypto/		<undocumented>
+debug/		<undocumented>
+dev/		device specific information (e.g. dev/cdrom/info)
 fs/		specific filesystems
 		filehandle, inode, dentry and quota tuning
 		binfmt_misc <Documentation/admin-guide/binfmt-misc.rst>
 kernel/		global kernel info / tuning
 		miscellaneous stuff
+		some architecture-specific controls
+		security (LSM) stuff
 net/		networking stuff, for documentation look in:
 		<Documentation/networking/>
 proc/		<empty>
 sunrpc/		SUN Remote Procedure Call (NFS)
+user/		Per user namespace limits
 vm/		memory management tuning
 		buffer and cache management
-user/		Per user per user namespace limits
+xen/		<undocumented>
 =============== ===============================================================
 
-These are the subdirs I have on my system. There might be more
-or other subdirs in another setup. If you see another dir, I'd
-really like to hear about it :-)
+These are the subdirs I have on my system or have been discovered by
+searching through the source code. There might be more or other subdirs
+in another setup. If you see another dir, I'd really like to hear about
+it :-)
 
 .. toctree::
    :maxdepth: 1

