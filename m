Return-Path: <linux-kernel+bounces-765516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC940B23965
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2A11B60AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D772FFDC8;
	Tue, 12 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DqXh31bh"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE652FE594;
	Tue, 12 Aug 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028679; cv=none; b=fTQajLsdV0j3jdKk9AB1gUxXMECsGtCudGnzC4j95JaMlTTm+/VTgvjyJtRSqqnNEJm1OnInJs5BZPfvnAGHx5l9ONtvUZvY7V8VfZVkDe52JcJTXRwbpo5SQQauo9cWKgA1FoEP0A/RYERr75jcZUwkzNNfV8zxFkGZAA044eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028679; c=relaxed/simple;
	bh=4DU+J+rTTiyKivCXoJcHXntfdgk2NjPRT4WF82XNoM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6KiJmvgiOSRSty8BVYNGjAFdtZChQBVHZ2/IDaf7teyI7ug7fyDhmOGkUu8oZOudHYgqmMQXXzhVHYy94B5LIufJtrR89qcVyA2z8fnBZ3XJF2IoZggdQRb5RvU8zhrayDZt0OJj47vVP+8sRmtrdm8L2vXql3jm36gP4zCGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DqXh31bh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 70BB640ADC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755028677; bh=JFF0dVs9V9DAAxQ+F/q3H9i8XQ3gen8VksquAovDBzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqXh31bhIN7HXdtjAmSEKs2343cRTulew2dAG2lGie+JDZE69azM/ZusYVblZlvZi
	 oNrnLyJI4OnmE0zGm+zVEo57gtPSWZPmOBZHNn8ZlJ4btlOhGaIozUCwsKEOl1R8PM
	 rqNi/Oj+xpIyPkZ8oYfNM0JsFohpS5W5mUy+mAZbDYWranE25WF6IFTILWGPCRJVzl
	 Dxk+WWUXCYUfeCUJNkh7aSp4dtidJKPJnoE6i2wNgrl40e3BlvZ/ASkdKrpgXRaMFC
	 ZYWQFLiz1BRy6e/+sHMcPdyj9PXIRWMWhFpV8W8r9HXH6xrXej3j8+fYWlTtbwVAx0
	 6JLQVPdFouZjw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 70BB640ADC;
	Tue, 12 Aug 2025 19:57:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/7] docs: kdoc: remove dead code
Date: Tue, 12 Aug 2025 13:57:42 -0600
Message-ID: <20250812195748.124402-2-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812195748.124402-1-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
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


