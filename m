Return-Path: <linux-kernel+bounces-728557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2EB029F5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5BC7B5509
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A83E254B03;
	Sat, 12 Jul 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul/PmPWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A025484A;
	Sat, 12 Jul 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308034; cv=none; b=c1YMHQu3uANHHVGdaMTJ4sOEifYq7rr27N3bSFZB6ZPnZWCMsDYCgzkh9p79jeOjVZNaZOKtjEJj+zZ3JOsyMpc00nUaTXcw4SQbtyPj1Pqi2eLG3udkhb3Aq+h2unAAS7yKcrh4lsOxTqiN1FhK8LpEmlrhe2ZtcZc1PWyQzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308034; c=relaxed/simple;
	bh=nBkQTkDhZsnzFFW82qYBM0kzGOHtVEnCtN29bE/ppyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNvIaw2XLE1/Y+oxD2Dc3n+XPhOe3StTndK+gQ6n5Wg8byUp2EQAtACv1QXJkw9XZf4SK1Lk7dmIH/2y3CV9WYHJKpSwQdFdxtmr1lIeY5YTwMQ8b7l4xHWUT0rwiaUFpzAXcB6aH7DzBFVJCpopcZMi7CbUn+/C6pW7SbpcdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul/PmPWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFD0C4CEF7;
	Sat, 12 Jul 2025 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752308034;
	bh=nBkQTkDhZsnzFFW82qYBM0kzGOHtVEnCtN29bE/ppyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ul/PmPWzFaB3KkRMuVpcpdboqnOOAv0KQeyuSd01ZE/jqsZ3T7W4SA/KkLeg0wBGB
	 i1J9NMNyScerZo2ASJs/lyPqHhqQDsFuyfb9bwgg8EVlgDjP3iDxVnSxzESQqtqtj0
	 HthylsFDK42tRBVSHEkXmkycGMZgT+cwtmZpYXhSwVHrLeJFjYdEvsV7/rKuc1J8U1
	 d95SK2EsCUmq+y2lv/goO08WZmzTCzto4iMVzKG8ICm2aWJmc+OXatsYUVUEfgjx0+
	 0iymOqrMJbJbJy0jknVaPvH9WPikLCXAe8ggKkcLM6Gcn8KUhj5XeJxuChWcD94eE4
	 uMTJHcJdQKRvA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uaVMm-0000000GrLy-184g;
	Sat, 12 Jul 2025 10:13:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] scripts: kdoc: make it backward-compatible with Python 3.7
Date: Sat, 12 Jul 2025 10:13:44 +0200
Message-ID: <c6323c9160c1e53c5ef8803e0dea90817b1d372f.1752307866.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752307866.git.mchehab+huawei@kernel.org>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There was a change at kdoc that ended breaking compatibility
with Python 3.7: str.removesuffix() was introduced on version
3.9.

Restore backward compatibility.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/57be9f77-9a94-4cde-aacb-184cae111506@gmail.com/
Fixes: 27ad33b6b349 ("kernel-doc: Fix symbol matching for dropped suffixes")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_parser.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 831f061f61b8..6273141033a8 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1214,7 +1214,9 @@ class KernelDoc:
         # Found an export, trim out any special suffixes
         #
         for suffix in suffixes:
-            symbol = symbol.removesuffix(suffix)
+            # Be backward compatible with Python < 3.9
+            if symbol.endswith(suffix):
+                symbol = symbol[:-len(suffix)]
         function_set.add(symbol)
         return True
 
-- 
2.50.0


