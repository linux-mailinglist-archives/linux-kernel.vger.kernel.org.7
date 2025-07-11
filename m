Return-Path: <linux-kernel+bounces-727065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A4FB0149E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269FE3AC316
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1AE1EFF8B;
	Fri, 11 Jul 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6wWHyBL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AE1E9B08;
	Fri, 11 Jul 2025 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218836; cv=none; b=gx3S7gMgnaXUwrXPNYU1Fx65NIHmxOPfed0R9jkZ6bXJYxJe34WcYii9Mt5A9Td0kXb8J8r7w+RcvO8VTT6DR+eeAei6eG6tv030/bAyXldIB0WUW4LsdS2JZgnzVKBsJhzxSXbf2LTYwLOKndCLGJdaRvjvv9Cduz3rucAzZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218836; c=relaxed/simple;
	bh=nBkQTkDhZsnzFFW82qYBM0kzGOHtVEnCtN29bE/ppyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmbM9JGDHfSG393C3nBPJ6tXsgv7cisbfQmgFbd6/wjDGfaj2ayv10twtly/OcBrgvPMm68OGLYQY7Cl2O4FRX4o2LsobUoh0iZIZZnG8llslP1CfDq6epdBc3g/osaxVPvI3z0HDYoARj1Relo6AcnlKFv+KF1HXIS8I6KWP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6wWHyBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE67BC4CEED;
	Fri, 11 Jul 2025 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752218836;
	bh=nBkQTkDhZsnzFFW82qYBM0kzGOHtVEnCtN29bE/ppyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6wWHyBLm879opsQjQhj5oTUoT5nOVp0YySKdjwu4XfL4JshB7+BRDo3+4xUPxmlX
	 OIBGhrT/MCXfhddusElEhYm+1onc0J03TPNenBMTraHAgPtfCnVqSHVbgJlgTV3BI3
	 r6LUnP3Ev0r2iZUTd4XkAMcLBZRC9zjAxt1VdFhrPjUsrzjxgY8gWWnT1NaqeJlzsY
	 /t2/hZv8GNZ2HAXiuwsWccQ8KZplxMkONlp4tqXsC1Odk44/++8x7x3MrJ5cgoZ4at
	 tjXkDwZ5xwCXzwX1PQNtT/YusCtOHegk2oAZhiKu2GSgUpxVObxoSrRqWChQlccAQe
	 F9PUVF4hhnVSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ua8A6-0000000FSSv-3VEV;
	Fri, 11 Jul 2025 09:27:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts: kdoc: make it backward-compatible with Python 3.7
Date: Fri, 11 Jul 2025 09:27:09 +0200
Message-ID: <d13058d285838ac2bc04c492e60531c013a8a919.1752218291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752218291.git.mchehab+huawei@kernel.org>
References: <cover.1752218291.git.mchehab+huawei@kernel.org>
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


