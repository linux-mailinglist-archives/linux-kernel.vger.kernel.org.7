Return-Path: <linux-kernel+bounces-899080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F64C56B28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC3054E0FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF32DF12C;
	Thu, 13 Nov 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHUAOohR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8292D0610;
	Thu, 13 Nov 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027633; cv=none; b=c/rclJNFNUr14oDVTTT14qFWS1Omg/+BAge7sz6rj1ly0MKupcX+IZk+yN5XoO0Ni1g0Cjjiiquo61qrtpB3WupFMolrBfUIvlWlB2RYrlHc5av395Vd0MOemVPnsmLynOM7zXDMQWw5WXkA72o5ZAbbaQcdztcLUiv2VaLJK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027633; c=relaxed/simple;
	bh=b6+kLw0MSxnSfWCrbyUlrpcqRMlgnersOvTlBon7gHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxbQvscc/UZCR7PY82FAxuAo0cDF9L6wQTfzQYV1qzyU0vFLvylmUvboDmkNV4lq1JTrxWNCIrBhOBwxZaplJctTIsB0fgRmDOE34NoEARLSM+q8KOzKUnwicGCTYS/4MD/+Td3TRG95Nb60kyz9Y68eXLkMD2mGd5D/icouWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHUAOohR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8552BC116D0;
	Thu, 13 Nov 2025 09:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763027632;
	bh=b6+kLw0MSxnSfWCrbyUlrpcqRMlgnersOvTlBon7gHU=;
	h=From:To:Cc:Subject:Date:From;
	b=KHUAOohRMS06B5kKa+QNfEbpYAGS5Li6XcdXUFryrmS2Ru4471VHIQwD5hLUXfdyK
	 8eBJSlgeUSJJUNR7qyL1lxavEnB7cjeRc81HY/NT0tP9PyTc6UCvfmWdIyLKf9EyBl
	 srkdgP9U2W2PwVmAjpChD+nfy8HwkacKnQB/vlZSqs8c/n4zNfnPgEvOkKLkq+rWcj
	 JdEF7l7YzWTkJNZ8WxyD1ESldGxQOiwN9d8yMnDHUbzywQTBA1cy2etODVBwswxFpn
	 5vY1am6BMXGSMLu3/FZy8FuaszjRGSRKurgQfaCk4f5+5NmdfbB32eCSLZaLi4t6qC
	 u/1h51av2iCxQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vJU1W-0000000B1M2-2XWi;
	Thu, 13 Nov 2025 10:53:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] scripts: docs: kdoc_files.py: don't consider symlinks as directories
Date: Thu, 13 Nov 2025 10:53:43 +0100
Message-ID: <73c3450f34e2a4b42ef2ef279d7487c47d22e3bd.1763027622.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As reported by Randy, currently kdoc_files can go into endless
looks when symlinks are used:

	$ ln -s . Documentation/peci/foo
	$ ./scripts/kernel-doc Documentation/peci/
	...
	  File "/new_devel/docs/scripts/lib/kdoc/kdoc_files.py", line 52, in _parse_dir
	    if entry.is_dir():
	       ~~~~~~~~~~~~^^
	OSError: [Errno 40] Too many levels of symbolic links: 'Documentation/peci/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo'

Prevent that by not considering symlinks as directories.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-doc/80701524-09fd-4d68-8715-331f47c969f2@infradead.org/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_files.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 061c033f32da..1fd8d17edb32 100644
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -49,7 +49,7 @@ class GlobSourceFiles:
             for entry in obj:
                 name = os.path.join(dirname, entry.name)
 
-                if entry.is_dir():
+                if entry.is_dir(follow_symlinks=False):
                     yield from self._parse_dir(name)
 
                 if not entry.is_file():
-- 
2.51.1


