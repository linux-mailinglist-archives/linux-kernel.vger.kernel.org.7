Return-Path: <linux-kernel+bounces-808998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A89B5074A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564E24E7B81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2036A3680AD;
	Tue,  9 Sep 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YKHaoV5z"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9D35E4FF;
	Tue,  9 Sep 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450651; cv=none; b=A8qskq7jwrMEwAOttn89FBvsf3B4sN9b2PCZTxi1g7JJpZGeEsLc7qXf9ROh8TguhhHFEE3STwz9MmkCDJjSUck3OmVHYSAYQs9rSlyjSQvaBMgS+OFJ/YH2QEqevQkvjROzrqLZYgeRXg/Hl+n00EZaD7i72waofPFbh7CW+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450651; c=relaxed/simple;
	bh=1Hil1T0T3/8TdBDvQViio/0LTRVCyBM2IZXgP69Suag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEn0TofgWWMjoqex+DvT2bP3YvvTlA2X0gVctMX4NGyOCo1Sq0WkaDHfBUMIR/d9PUN/WZaUjKC5mu5xxEtgD0UeszeXj3ELwJFgJls2CjS0cyOC8G73p3HPmXZfBFAReQZjCSUhfffKVzyzeKk9yXMsVzY35nARS81vAQHUJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YKHaoV5z; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 037B440AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450649; bh=h98HvVjpkeDQfU+Z0XxLLWseUleTkvErmLg3KT4Sv3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKHaoV5zv+NVH8W34z7YSJ2KTUNAYG+PWI8tlilJJ25h+RA2b8pFdBJODRNTjdbbb
	 tER42/Sr3TBDbVGrwecuF2BpgSV8Xf5Wje0sYWtbgEtSAgd1ZAHQsFrfc+fyVfCOFg
	 q2Q48zWmEaPVKZlZp1n3INfvWXuWRvK+k16bit/zjHwg9oyk0gpCWyDPQuJeH7hipY
	 wU3IEea+ifcLAenG34mSGca04iXvCQOBFZFbconxOu9E4PA5yPgLNyqcw2aiQNa+/e
	 KwxpNDbKItF/5IEnFK/1oH86WwKayYcUodqYs4kF/aICjtr/bS8B52DoytC7En8TsQ
	 jxPCgoUmItzhg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 037B440AF5;
	Tue,  9 Sep 2025 20:44:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 06/13] docs: kdoc: remove a couple of spurious regex characters
Date: Tue,  9 Sep 2025 14:43:42 -0600
Message-ID: <20250909204349.123680-7-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909204349.123680-1-corbet@lwn.net>
References: <20250909204349.123680-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "name" regex in dump_function() includes both the tilde and colon
characters, but neither has any place in function prototypes.  Remove the
characters, after which the regex simplifies to "\w+"

No output changes.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 1a1558211acd..decd127df82e 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -958,7 +958,7 @@ class KernelDoc:
         # - atomic_set (macro)
         # - pci_match_device, __copy_to_user (long return type)
 
-        name = r'[a-zA-Z0-9_~:]+'
+        name = r'\w+'
         prototype_end1 = r'[^\(]*'
         prototype_end2 = r'[^\{]*'
         prototype_end = fr'\(({prototype_end1}|{prototype_end2})\)'
-- 
2.51.0


