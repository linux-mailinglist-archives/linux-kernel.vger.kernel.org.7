Return-Path: <linux-kernel+bounces-780034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274EEB2FCCA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD90A16F6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024512D6E7D;
	Thu, 21 Aug 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MouVHQ/S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E832741D1;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=l3AiaCeoSu/73/fG/0rgfgsudu/Ef9Hkj6WS4Sf0bCBLegNFUZJ04A2VOarPt4wo4TYMc/3E5PrfPJPmhMXF3eGWZnxSozhyZqvxQn1CjFEukkBYcOtSHyL4clGZkmR5C4YqnZaBIrbzhQfQ93z5HRy4u32lujLVmYXtbf6YC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=wQmzELiyLlP6dYnGbR5xm0Wl2cXgsAK4Vx4o5Slpgnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLjMRP0UMEUqH7Qas3vXizUuFhXgfOzWjcNWmZVYlfe+a9aFgPx/zYnM5MTFzhoyoiTwpnn07BsmMV8qMqEiy5I4uChA+Z+1sWRMgZ1r4dk2nLilrKqtNrPmOE0TrBTAlHVLXUECWohJD6uWLfM+JfxnAIyjQmLpofMrbVF5RfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MouVHQ/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5DBC4AF0C;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=wQmzELiyLlP6dYnGbR5xm0Wl2cXgsAK4Vx4o5Slpgnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MouVHQ/SUz3h0bXRfAPJnNzPcYS1KVcbXEpqYXmzjR9pv6IyOCGPq9HcaPZSWCVjK
	 NezXokJ5LOPYcYmU4rR8kq78U/FJ+o50TA8FBODGNmk04ZWLGrMeKOBE9SDhNg+5qB
	 IJ+cV2BfTZSXWILLqPIC0xs+Z0Dpp/kkbDEcID7+wHH7zvE4gzQkS2+SmObfANlx9h
	 66CL2bZ5FPEcdEYcBo8Dzl7ftnvR+ko7Ypm+z2Q86can4pFMwMJN1L9lvNbv2UiPV8
	 bminWawp9iEX++gneBk7Ht6cs8als6I1NPK8cocagTSZYXt3ToNMWpz2CulPuqxT4l
	 0vxxfZM/z+kEg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT8y-1Z67;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/24] docs: kernel_include.py: remove range restriction for gen docs
Date: Thu, 21 Aug 2025 16:21:21 +0200
Message-ID: <92f8d6245a5891918281bca9cf7575da206aa27a.1755784930.git.mchehab+huawei@kernel.org>
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

Originally, parse-readers were generating an output where
the first two lines were setting a literal block.

The script now gets only the actual parsed data without that,
so it is now safe to allow start-line and end-line parameters
to be handled.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index c5f4f34e22cb..4cdd1c77982e 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -122,9 +122,6 @@ class KernelInclude(Include):
             exceptions_file = os.path.join(source_dir, self.options['exception-file'])
             parser.process_exceptions(exceptions_file)
 
-        if self.options.get("start-line") or self.options.get("end-line"):
-            raise self.severe('generate-cross-refs can\'t be used with "start-line" or "end-line"')
-
         # Store references on a symbol dict to be used at check time
         if 'warn-broken' in self.options:
             env._xref_files.add(path)
@@ -209,9 +206,6 @@ class KernelInclude(Include):
 
             title = os.path.basename(path)
 
-            if startline or endline:
-                raise self.severe('generate-cross-refs can\'t be used together with "start-line" or "end-line"')
-
             if "code" not in self.options:
                 rawtext = ".. parsed-literal::\n\n" + rawtext
         else:
-- 
2.50.1


