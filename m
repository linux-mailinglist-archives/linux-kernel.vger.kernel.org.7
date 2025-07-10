Return-Path: <linux-kernel+bounces-726644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666CB00FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CE276168E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B3A30E827;
	Thu, 10 Jul 2025 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tNX+qUP3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3F309A52;
	Thu, 10 Jul 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190321; cv=none; b=FIPso+jcvTjB0QxcNICnk5uLD2lDceJ21jXpQIdvvxRQx2Zm5iif5XwbkfHAkOB9fVKfzIL2L0jhU4GYMNnZNW9OvAd6jZ1xqkO1GEASDm4VGW7yDOyTAOd5eQat7vCrEkkXGWTzY/59tl+NAtjZ506/AQlEANEJXrQAKa8CQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190321; c=relaxed/simple;
	bh=AYb/kMhuMfcuVGw0rn9Jk1tH146m3ywJMggP+HSSk9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrB4aqVAGLkxt+TMhYlUm/YRu3AzXDe9wXBo+hjIbgfe9Ngh0s7bBK0HdKYtkRXfXbaFkc1SbOAjjaCKWvq2y9nxAbRiEvJk4e7h3Q8VKz1fmTXMMsVe+xayZgdPE9HdjETGNn8MCVMHdJiKpBAApdQq8XB2rq4VTpaEwWHN2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tNX+qUP3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B88FD40AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190319; bh=osk9iDvYkT2VDAGfp2kEG6eJBgGqe8CmQwDNIjc52AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNX+qUP31g1pp2x3jBWH+QbcKAbnRLxSbbBwHIg5ltZP0cQziXve9hkZp5ROi3URY
	 7NGCfxu8D6+2XluOxs66EDY8DNfFQAP8IBBvR/K/J3r/29Apk4rfaW/o+6rLL4TsEA
	 5v9HF53KZwwDGES02qb97u2rLfnZ41esNPIlJccvkYSmGNfMo0+my3qhBNyVHEP/oy
	 e0381LiEk9T8EwiOjFXe/jeYkttkSiiTdySd6NWZOqyv+nw8xONgijsXyBDy0vHhfh
	 lxL9sjkS0yYUxlnCoX2fe+w53Un13HGuRFbkGLD9+rXmbalCU/vUo67O4C7N3GsqEe
	 Q6f6XgICENUNw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id B88FD40AD8;
	Thu, 10 Jul 2025 23:31:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 12/12] docs: kdoc: emit a warning for ancient versions of Python
Date: Thu, 10 Jul 2025 17:31:42 -0600
Message-ID: <20250710233142.246524-13-corbet@lwn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710233142.246524-1-corbet@lwn.net>
References: <20250710233142.246524-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Versions of Python prior to 3.7 do not guarantee to remember the insertion
order of dicts; since kernel-doc depends on that guarantee, running with
such older versions could result in output with reordered sections.

Python 3.9 is the minimum for the kernel as a whole, so this should not be
a problem, but put in a warning just in case somebody tries to use
something older.

Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index fdde14b045fe..23ac4ad204f4 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -12,6 +12,7 @@ Read a C language source or header FILE and extract embedded
 documentation comments
 """
 
+import sys
 import re
 from pprint import pformat
 
@@ -238,6 +239,14 @@ class KernelDoc:
         # Place all potential outputs into an array
         self.entries = []
 
+        #
+        # We need Python 3.7 for its "dicts remember the insertion
+        # order" guarantee
+        #
+        if sys.version_info.major == 3 and sys.version_info.minor < 7:
+            self.emit_message(0,
+                              'Python 3.7 or later is required for correct results')
+
     def emit_msg(self, ln, msg, warning=True):
         """Emit a message"""
 
-- 
2.49.0


