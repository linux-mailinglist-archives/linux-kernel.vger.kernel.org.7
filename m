Return-Path: <linux-kernel+bounces-780028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC4B2FCBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E8C6000E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EEB2D6612;
	Thu, 21 Aug 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYV5s84B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29E28134C;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=RVd8OD0tyC94gxDSJTfXw5mPW0pjWZUgCui6l0jlwGf0qhEPJKlZhHXUgGcBlNiZNIFy0ps2Y/dIvnYMQ4UtpvSZeV3iLF2m+AQvyOFqJLwVXuDOoH2a31GfEZKiOlYTp1rqnFm80/6iHZY8IQttCbGaFWqkF4HiPTJxqnZdYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=HiN7NqutO6hirOm4EnCnsuZhXt+MMY3adGpEmCAC7NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blJVjb3H0M/ojp3ExZm+Xj7A/G/ygnkKfWTEGonK1nQBfE7FqFOsXZ6h27G2P0F1CzAbB0aj5PSrTBs3uI/YWI1TIOGcbZbFYkcb9O9JVlDbDJJ55B5np46iD2zJxRSCj2zeiQ6+GV86uOYj/P9jDlRs3E840iftAGpkbwoL1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYV5s84B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7E3C4CEED;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=HiN7NqutO6hirOm4EnCnsuZhXt+MMY3adGpEmCAC7NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYV5s84Bgs1X5htuk44nmyIRe+YxE4Ga/73kTS/2zGuuZQwn9W0eiJAzNuPo1RcPD
	 JQh1asCNqz5GDYR8NqdO0xr53xgOU2sfKEHu56W+8GpyVMHYloL2/nwUrW4EJKHcK9
	 G3aAqn1IKswVYU+UjQWZcodtDKPoewqCw59wROqPSrDWstHo7tDYSTHncZ7utpRzlZ
	 1EN8ReMFSZgyz2nyLuSh+/ZobxAiXXVwD+hRsxcqEuybel3t//mx/ZFHLMpslF9qN7
	 cT4u1929Q2s4e8SqsO9qAZdjxC6ghDuP4oyVAjaQwJLJgEkpjlrB0h9w4AwDIj4Ibf
	 3ClSBa06FP/Zg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT8G-0MP6;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/24] docs: parse-headers.py: better handle @var arguments
Date: Thu, 21 Aug 2025 16:21:10 +0200
Message-ID: <7a8bb6f607dd3d614cd27ae1c3176aab404605ee.1755784930.git.mchehab+huawei@kernel.org>
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


