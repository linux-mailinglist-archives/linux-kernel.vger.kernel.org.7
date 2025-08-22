Return-Path: <linux-kernel+bounces-782126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1554EB31B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23818B40891
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5F320CA0;
	Fri, 22 Aug 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEEVSqQz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D53112C2;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=f7casIFIac2wlqB6Gmp8v1IX4e8C0DWcJ/xmOxiSF0HLm/RQzJI9yt58HZDdTaZrgr+HJaBG5t4MvzWuZVevgGaHGcPW96ZkZ+CF6PGJm0ZRe8yU1U66LRzb84i46RtUnLSeEY7iVEgArPqckaMfGkCQwpf4ojwigZXbWXWPrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=HiN7NqutO6hirOm4EnCnsuZhXt+MMY3adGpEmCAC7NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSi0TIbIGwmTxrdwYGOAH7sTmEINx6BhfCZa8T4bSehXsbb9yBcdoDpo6No+4slYxcoartzNPnFLhuh+YNaoyNf8asP8gXXY1GOMS0cDeiUFB/YkaJkg/DGyYr5L98NMdGfQcgTGNf8fWXjFyS8KKweM4QoahKKYOWNMlEwDzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEEVSqQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC11C19423;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=HiN7NqutO6hirOm4EnCnsuZhXt+MMY3adGpEmCAC7NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEEVSqQz141kP3LMW9d5m0XBcOP2hUjvdJSzYCNaGBMzYEvn5sdUjpdzOy3bY6hyl
	 HWeU8lxXxyzpZC9xCyN2r0YjI8NlVMRB3iSlmvlZPjNUJMspTE9QLLDzO5P3Hxdfoq
	 C4dTq9+wYFjSGOMSvoW16chvgXjvYgnln5JBVEH7XYnNb6Z88REAikr/6eZo3KwDy0
	 EFjU0CUUGCN9zj0SVL9uOkg2WK5RrNXaLjfV7kFCSLAh1YAwhL4+cY2HLSchS8EJCb
	 DsOsBye9c5xvkrH6B4SJZGtDJYBgOTKkSIJypNBxwv+h0VowmDu1vVzx/55CpVxNfe
	 rebz35QLGpnjg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCr7-0t4P;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/24] docs: parse-headers.py: better handle @var arguments
Date: Fri, 22 Aug 2025 16:19:16 +0200
Message-ID: <8d06bb713d6ec8de65179dd93defe479715409b6.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The kernel-doc markups inside headers may contain @var markups.

With the current rule, this would be converted into:

     \* @:c:type:`DMX_BUFFER_FLAG_DISCONTINUITY_INDICATOR <dmx_buffer_flags>`\:

Fix it adding a non-printed space if needed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parse-headers.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/parse-headers.py b/Documentation/sphinx/parse-headers.py
index 650f9c9a68d1..f4ab9c49d2f5 100755
--- a/Documentation/sphinx/parse-headers.py
+++ b/Documentation/sphinx/parse-headers.py
@@ -120,12 +120,12 @@ class ParseHeader:
         },
         # This is the name of the enum itself
         "enum": {
-            "prefix": "",
+            "prefix": "\\ ",
             "suffix": "\\ ",
             "ref_type": ":c:type",
         },
         "struct": {
-            "prefix": "",
+            "prefix": "\\ ",
             "suffix": "\\ ",
             "ref_type": ":c:type",
         },
@@ -390,6 +390,8 @@ class ParseHeader:
 
         # Remove "\ " where not needed: before spaces and at the end of lines
         text = re.sub(r"\\ ([\n ])", r"\1", text)
+        text = re.sub(r" \\ ", " ", text)
+
 
         title = os.path.basename(file_in)
 
-- 
2.50.1


