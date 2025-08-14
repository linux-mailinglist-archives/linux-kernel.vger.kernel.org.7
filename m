Return-Path: <linux-kernel+bounces-769210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C043FB26B66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247EA1630FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DF923C8A0;
	Thu, 14 Aug 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kHDEHFX8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630723ABBE;
	Thu, 14 Aug 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186048; cv=none; b=bwx+9oDYwgfdHgTwj9GyCGR9U3fiYVj6lU403z7ETk997/0GNHMLvkB0F9SRDefWmDkGbqsPRiVHNA+L1IyQCH8+CbBLUovRQY9KQch2PlfJ0OCNyf6qtLCj+RSpWX7QZHPBYFXplISyTcumpblzar249FN6GR+6clNGN+v77Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186048; c=relaxed/simple;
	bh=V9vBaVYsGOM89/AbSRckdlw4a3N2Szaq0f/Y7+Wrt9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQOz8GG8eEQDW368ymBmqKDQCxgoU4PzWFzXNspnkG0SDKW2wIY0z/Ynb6jLMx7euMsSwcfyNq/DFJmW2MDbH7di9hReJF4okvVe2hgO+1v69rfsHjZj21SRG3UrLEH2mmSY78+tXMt3GXqKk3B2fg+8jBneYdHjdxnB4p+Vxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kHDEHFX8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9EBC240AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755186046; bh=u5Ei5e6Ezbbc3DM6w/yyx0CojNL/+K85VRUr7EDaWpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHDEHFX8Qzxw4WOU+LRLSdMENlNye8XgdlNu3KqeACjmCWl4GqrHtAOTt5bn1JFmx
	 QoRgQhF/K91ws4efH3BuWw5FdzQjZjBHejvUIWCsZRn/op7lAzSuu2HkuchWtqPDOg
	 LNDBDAQMguTKew9lzPA2Hb+5df5nRw7qqIO93WNAB7czoc5POIeUB9X13a6U5I8Wcm
	 AqNR/LxIXFMqJQVAv6Bi1ZJPxAhU+ZN/CGJ/r42w7j6Lcic18pWpmlMjttGR276fQz
	 SHmPxwtpwm6lyhKnJDOGC7qrhrtPblm09SxxqlkEhAlIyBFhCS7/B/u2iHemBaIynj
	 /R1eQeNp8hFLQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 9EBC240AF4;
	Thu, 14 Aug 2025 15:40:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 1/7] docs: kdoc: remove dead code
Date: Thu, 14 Aug 2025 09:40:29 -0600
Message-ID: <20250814154035.328769-2-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814154035.328769-1-corbet@lwn.net>
References: <20250814154035.328769-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_parameter_list() tests an argument against the same regex twice, in
two different locations; remove the pointless extra tests and the
never-executed error cases that go with them.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 9e65948f8254..96e3fe4ec431 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -564,28 +564,18 @@ class KernelDoc:
                 args.insert(0, first_arg.pop())
                 dtype = ' '.join(first_arg)
 
+                bitfield_re = KernRe(r'(.*?):(\w+)')
                 for param in args:
-                    if KernRe(r'^(\*+)\s*(.*)').match(param):
-                        r = KernRe(r'^(\*+)\s*(.*)')
-                        if not r.match(param):
-                            self.emit_msg(ln, f"Invalid param: {param}")
-                            continue
-
-                        param = r.group(1)
-
+                    r = KernRe(r'^(\*+)\s*(.*)')
+                    if r.match(param):
                         self.push_parameter(ln, decl_type, r.group(2),
                                             f"{dtype} {r.group(1)}",
                                             arg, declaration_name)
 
-                    elif KernRe(r'(.*?):(\w+)').search(param):
-                        r = KernRe(r'(.*?):(\w+)')
-                        if not r.match(param):
-                            self.emit_msg(ln, f"Invalid param: {param}")
-                            continue
-
+                    elif bitfield_re.search(param):
                         if dtype != "":  # Skip unnamed bit-fields
-                            self.push_parameter(ln, decl_type, r.group(1),
-                                                f"{dtype}:{r.group(2)}",
+                            self.push_parameter(ln, decl_type, bitfield_re.group(1),
+                                                f"{dtype}:{bitfield_re.group(2)}",
                                                 arg, declaration_name)
                     else:
                         self.push_parameter(ln, decl_type, param, dtype,
-- 
2.50.1


