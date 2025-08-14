Return-Path: <linux-kernel+bounces-769215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945BAB26B67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78A31CE371F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219862DC34B;
	Thu, 14 Aug 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oxP+3qJo"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD623C50A;
	Thu, 14 Aug 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186050; cv=none; b=q+sb8WS2EESnV0THHE8In4y3UDchPdg3tDYibniI25KJaGdFJ0dMxlti0X4D8E/g2h5uYBjrkLpEBpVZNGJnMAqFgcyqEq4Qs/2fxAB06Vl9IK9tL0kcfGv0HJ8ui8Op/qpoQaT1yt+vuXs/9TuOGMIe8FfhQV6ru3Rmh3AKheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186050; c=relaxed/simple;
	bh=GdVlU78Y9DzwQcjBjkjX5yDPH7mOhzZ/df9QB+cYA3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaKFnR+OeqijHiImdAzU8Fe0GpCiIIyuybOj+++88uM0G3i72FN/voddI2KQJ2gtFcB93ItFXPuvyU92D9vaPqODwY8T73Vx+fqrr1pL3UJNoxHKcQu9GPHDCDP92fPWNANF0zcyG8f6KkrPlHmrypf84H40xpMfpWvgkbrRE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oxP+3qJo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CBC7240AF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755186048; bh=64xgp67hBLhdwbxYz5yPVU5SQebWB9xbdNy0iYDphqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxP+3qJoAWIK++2ixLgR/+UZ+WrHiqJZgaTIFyY+KVONvZXYQRj2AjI9ha5CvBflu
	 xNX7Y3iKct75walxVInQQZMDWqOUbV9XmiWJED11UmJQ6sPQMeie2TClzhVWhBdCeF
	 VfmLD7t8OALRiJpAUCjQ4mpdPZgYCRMfgGDitH/5FSXhW6PxcdgCgFRKTOtDG7y1NC
	 /G0UuM0yjfM2T99QlGFDgRSw1wmE9L0Md+i3Zc1RFmolgoITz/MN0lD0nkRFm1MlEj
	 6Z0wQwvVc1oZtPmkcZM33kL+YUE6Ui7uRAObx+s/m8c0HAg4K3yp3dZe6o8kb8UTsQ
	 vr+TYChtfIvBg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id CBC7240AF7;
	Thu, 14 Aug 2025 15:40:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 5/7] docs: kdoc: tighten up the array-of-pointers case
Date: Thu, 14 Aug 2025 09:40:33 -0600
Message-ID: <20250814154035.328769-6-corbet@lwn.net>
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

Simplify one gnarly regex and remove another altogether; add a comment
describing what is going on.  There will be no #-substituted commas in this
case, so don't bother trying to put them back.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 29881757bf1c..7f4d95dd47d4 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -527,23 +527,21 @@ class KernelDoc:
                 dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
                 self.push_parameter(ln, decl_type, param, dtype,
                                     arg, declaration_name)
-
+            #
+            # The array-of-pointers case.  Dig the parameter name out from the middle
+            # of the declaration.
+            #
             elif KernRe(r'\(.+\)\s*\[').search(arg):
-                # Array-of-pointers
-
-                arg = arg.replace('#', ',')
-                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\].]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
+                r = KernRe(r'[^\(]+\(\s*\*\s*'		# Up to "(" and maybe "*"
+                           r'([\w.]*?)'			# The actual pointer name
+                           r'\s*(\[\s*\w+\s*\]\s*)*\)') # The [array portion]
                 if r.match(arg):
                     param = r.group(1)
                 else:
                     self.emit_msg(ln, f"Invalid param: {arg}")
                     param = arg
-
-                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
-
-                self.push_parameter(ln, decl_type, param, dtype,
-                                    arg, declaration_name)
-
+                dtype = arg.replace(param, '')
+                self.push_parameter(ln, decl_type, param, dtype, arg, declaration_name)
             elif arg:
                 #
                 # Clean up extraneous spaces and split the string at commas; the first
-- 
2.50.1


