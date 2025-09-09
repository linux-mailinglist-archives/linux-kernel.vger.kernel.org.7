Return-Path: <linux-kernel+bounces-808993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96367B5073F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362AB4E63DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CAC35CED4;
	Tue,  9 Sep 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Nek8+z1i"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E76322C81;
	Tue,  9 Sep 2025 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450648; cv=none; b=DobZ0HFEgxZFJskmijzwOSE3zlmSUkKIFaeeb2Wd83c8WxVE/3VVeO3gU9DJxzQcu/9ns+vdh0ZZ+QoWThcx5QYEc9zKj1cZ4ij1BK7Lzml4Fs4xIgU5rHFwPStrX1vNv8ZVyapQrI68N4fX6sJh7yX1TPhl17+TTbXqX3Iu2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450648; c=relaxed/simple;
	bh=RsUW04hskqugOhbYYrFUMf4gRDhS4v7kPG2OtwRduZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cau7QYAHZnxXo+BRVNfFEAQtn80a794t3jERZroDPxLk0YhITw/+j7ONXUibGa6bMD/QEqC0r4WidDnxpt95LZkW+xFFodG4LG/G8uK3lcb9/ox+xX78h0ZW/sae4bgdv3CbLKyXMm01JFI+aXgQHBS3y+BYmzGMsM3y7jm7d2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Nek8+z1i; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 59A7340AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450646; bh=JfEtJEANLxItI8g8VENMIRoKiFMhUsfKRtczZcQaItw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nek8+z1iTAEhQZlS5a+RuHXD14rVdS3GDzl11k502VNue7Ic+9rYA61a/EiEyglwp
	 Yf4oZpJU2OYYq92NcJwTiQAD6QlKJhU34Y5kuJ3MssmAZwjEiEhcxbKVGqYQQo2IY8
	 W3hBskEoDHQIaDX871Kg57QjiTzfols3h+0//HXwmpUi658cO61JzDNJ4sGpQpRoak
	 EfswpHXHmWWjwkrgQBJHizkrjQkrLg+apqCGqXb0Uj8ieQWjqmUPynsw3HWFsMdZLY
	 Omw5wt2xiXxEPHqqHL+sDNUZHGdWiMurJarJm1hKN5hj9fwEcbM37CEwWZR0Cwjl1K
	 jnuytE6ZL4qBw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 59A7340AF9;
	Tue,  9 Sep 2025 20:44:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 01/13] docs: kdoc: trim __cacheline_group_* with the other annotations
Date: Tue,  9 Sep 2025 14:43:37 -0600
Message-ID: <20250909204349.123680-2-corbet@lwn.net>
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

The special case for __cacheline_group_begin/end() can be handled by just
adding another pattern to the struct_prefixes, eliminating the need for a
special case in push_parameter().

One change is that these annotations no longer appear in the rendered
output, just like all the other annotations that we clean out.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index a560546c1867..a90f77d6b669 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -90,6 +90,7 @@ struct_prefixes = [
     (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
     (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
     (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
+    (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
     #
     # Unwrap struct_group macros based on this definition:
     # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
@@ -447,12 +448,6 @@ class KernelDoc:
             self.entry.parameterdescs[param] = "anonymous\n"
             self.entry.anon_struct_union = True
 
-        # Handle cache group enforcing variables: they do not need
-        # to be described in header files
-        elif "__cacheline_group" in param:
-            # Ignore __cacheline_group_begin and __cacheline_group_end
-            return
-
         # Warn if parameter has no description
         # (but ignore ones starting with # as these are not parameters
         # but inline preprocessor statements)
-- 
2.51.0


