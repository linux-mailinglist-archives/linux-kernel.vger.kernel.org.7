Return-Path: <linux-kernel+bounces-780022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A1AB2FC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58907AA39CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4622882A5;
	Thu, 21 Aug 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGK50HqV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA4279DBB;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=e5RV5fbJUEteFUJQavPIvXBPXjo5KA0rwVK/u3Rubdnz6Snuao76pFxPdgGmtOVnWH9A7OcXbw7Etb7e4kHvWQQvwz32vYeuo7nYb/vKn/ELrD4oSZ9v384b2DDvQTDjXJ9xW4qDXB9NUPxrR7evNd8tVh6sJYWmjH4dTmgb29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=xaVYPkTp3UCaFGLlpkZHV5Y3yGQI0qRfBiGX9ydW30c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOzYofgx58BZSXJ/D1IsuJELJDYJV/FnC/m4t817ry20eyoDChlJIRj6K/Xd+yG0VVsSob5RwKdbn4JO6OHBSXVTfJZvrKrXQL8ajSBAD5jQvpsBo2FbmbKZgISw/0EL9q7NuBNCA3xlFFjttN01QTK0maHaho8aqTJiiYzeAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGK50HqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CEEC113CF;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=xaVYPkTp3UCaFGLlpkZHV5Y3yGQI0qRfBiGX9ydW30c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGK50HqV4D2ftJ2wJq/Of1l9eBbyC4BggYHUAfuBniHo9urdjCJ7IDlYwSoMBj7gF
	 gm8NDxRgbuQW4RFF5/xx++rbT64HbhwNvgRzBosFVnQwgmQ1fsTyYpL/2il5sMBtN0
	 b2mnyjM0zsZcyf20ZmPXNa+Ug/hj4vYeJll7axZebnqjQQy5RpexOuVrBqhRNa+Xc1
	 mwOCWaGkwrsV4p39o+Zorhx1wORB0g2132toww4ME8F6rq2fBWZWwSvYpClJaHMUgj
	 CPHyCEntf1vSxs0PZBFWkx1soa+/Ot0V1V7of1I8qZlc+hmybUXqwSqJPyzxFLyXgG
	 edf6tdxcgRJpA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT8K-0TDw;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/24] docs: parse-headers.py: simplify the rules for hashes
Date: Thu, 21 Aug 2025 16:21:11 +0200
Message-ID: <dd7cd90d1f080d44e035daa72909ecda7215b95e.1755784930.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755784929.git.mchehab+huawei@kernel.org>
References: <cover.1755784929.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Normal :ref domain accept either hashes or underscores, but
c-domain ones don't. Fix it and remove unneeded places where
we opt to disable underscore transformation.

Ideally, we should have a rule about the default, or change
the way media docs have their references.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parse-headers.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/sphinx/parse-headers.py b/Documentation/sphinx/parse-headers.py
index f4ab9c49d2f5..344090ef259c 100755
--- a/Documentation/sphinx/parse-headers.py
+++ b/Documentation/sphinx/parse-headers.py
@@ -162,7 +162,8 @@ class ParseHeader:
                 if not ref_name:
                     ref_name = symbol.lower()
 
-                if replace_underscores:
+                # c-type references don't support hash
+                if ref_type == ":ref" and replace_underscores:
                     ref_name = ref_name.replace("_", "-")
 
                 ref_link = f"{ref_type}:`{symbol} <{ref_name}>`"
@@ -258,8 +259,7 @@ class ParseHeader:
                 if match:
                     name = match.group(2).strip()
                     symbol = match.group(3)
-                    self.store_type("typedef", symbol, ref_name=name,
-                                    replace_underscores=False)
+                    self.store_type("typedef", symbol, ref_name=name)
                     continue
 
                 for re_enum in self.RE_ENUMS:
@@ -272,8 +272,7 @@ class ParseHeader:
                 for re_struct in self.RE_STRUCTS:
                     match = re_struct.match(line)
                     if match:
-                        self.store_type("struct", match.group(1),
-                                        replace_underscores=False)
+                        self.store_type("struct", match.group(1))
                         break
 
     def process_exceptions(self, fname: str):
-- 
2.50.1


