Return-Path: <linux-kernel+bounces-897803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 982DFC539E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBB06342C75
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAA345721;
	Wed, 12 Nov 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os9YyjqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D53343D76;
	Wed, 12 Nov 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967694; cv=none; b=bvEa5ox+AjMhzs3DbYl0/2Y7w/vSMHEArbMHY0uXPaY60MYm9OhDlp9J9d26GodE1j3BhWrGERjNoGo6kzyXhFyte2smyFON+b8Fi4wQfZbgILc8TQKRBu40WeBoo10xd8d8qoZSE85sWox7Lu3oGiOZglFjubpRFE88NBnAltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967694; c=relaxed/simple;
	bh=0hPBNyo4oNjc7cd3pRNgm/5T/U2NWpO2lwFxU+nsiEc=;
	h=Date:From:To:Message-ID; b=F20kSHqGJ7QSYBVNBqqEkSxZkpmF+pMg9cIrLc6uOZyWyCVoB0QIXfGb5sQVUueI6LGMWQD7bILQgBBZ2vV3t34aie0bZgAcV36e3NLwCFXNpmGaPeC7uG3e70qkCPxlxJ7YWu07XFGGNQBQy84pmpCcCIZeMmu+Pnk/3HxW+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os9YyjqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D4FC16AAE;
	Wed, 12 Nov 2025 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762967694;
	bh=0hPBNyo4oNjc7cd3pRNgm/5T/U2NWpO2lwFxU+nsiEc=;
	h=Date:From:To:From;
	b=Os9YyjqNR62vSBYCiPeckl0mnobkSX5loopfpyMbZe0bQiol6xXCZi/jj/iJmf3Ua
	 Bip+/r541OKfE69+m1oOx/unWJP+fKMxKBPjEWFM4fM9PGa7Vl0754QZny8F2hgFmh
	 bY3QwyjgR/nnmoAT1k+4ux7W9lGVxrqFwp1J9iN5XrQv/uulI3o44AOnM9T/X17KBE
	 P3nFmAXjM0Yq9LtDIL/df9BF/FZUV5Tf7scQxqIzFpC43w3UZRP5Ywf7R/WxcV4Eu9
	 ZfeRSuyANOfo/WTNRFwB2vxOzVw2AWJl4JkLvHoKKWzdkrrAiJ/tKXIN3QpFLeXmxI
	 IqHWAi+4JAapw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vJEQm-00000009iKx-0Xuz;
	Wed, 12 Nov 2025 18:14:52 +0100
Date: Wed, 12 Nov 2025 18:14:52 +0100
From: mchehab+huawei@kernel.org
To: linux-doc@vger.kernel.org, corbet@lwn.net, mchehab+huawei@kernel.org,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org
Message-ID: <20251112171452.Y5jX9%mchehab+huawei@kernel.org>
User-Agent: s-nail v14.9.25
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] scripts: docs: kdoc_files.py: don't consider symlinks as directories
Date: Wed, 12 Nov 2025 18:14:49 +0100
Message-ID: <73c3450f34e2a4b42ef2ef279d7487c47d22e3bd.1762967688.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


