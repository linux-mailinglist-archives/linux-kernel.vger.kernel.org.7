Return-Path: <linux-kernel+bounces-899204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6300C57145
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB93BC622
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A590337BA4;
	Thu, 13 Nov 2025 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgbaE14Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FC299A87;
	Thu, 13 Nov 2025 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031646; cv=none; b=oSxmVWSeIlhPwUcApKW/bLYSi/1Q6LjekYRF+V9zkPseywA2N4zazEVcxTPI1vVB1oot5SK4DCmiDsC4K3GoBtEKSEK+1naNaU+p99CYm4e8548w+3v7KtPhfl4pKdJfTi+V/R9xfh+eRDd00drG8Ro+qYEubfJOmWJ9pBvDDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031646; c=relaxed/simple;
	bh=qvfSEw0SZ1CotusoJoW15C/btkq0zHfMym0GQa+pRNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RReczfM/XpCQ5WvCJFCiCncIAS3D4MHwXz5xD00/Utg6a6q2DcO0IovZYOvZgwp1SJezFh0rrlgj0kwoLe9OYJxY81n6+8tOdpveddeOSf7skQotJKGcqVvjbLjSTAy2YXWWUgbH9YTerjRLzMWPfE+IGKOs/sPggPfkYntHk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgbaE14Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071FFC4CEF5;
	Thu, 13 Nov 2025 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031646;
	bh=qvfSEw0SZ1CotusoJoW15C/btkq0zHfMym0GQa+pRNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QgbaE14QnTozsvEBU7FVTkbPEM6NyX8PomKSBUMcYneL3OWSHi2jESEAZBVB/LVCu
	 gGpraKE7y/9rA4aRfO9pY5GJ1br7RaSoFFwUiDfoTrLeQe8ka/pKRqu/ouAbtEF3oq
	 IDBUt/iIjn6E/YuSdVQd/FlD9DqXwgbET9ltJmgecT/uHR2qd8hqbLcG0CEM4TfQFL
	 /o/LPn4/BCis+uFdfTzN+ab0ttgPQvbc1Is5MTg3yeMM/RRnDjwfCOpQjywj9iGjVn
	 qBzjFWi62i728MSfSIePrDk07sCrwYOyako3RiPhGSUj+4J+NuQv7iug+1Nibss/eA
	 X7k/0VBTmKFDw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vJV4G-0000000B63n-08gs;
	Thu, 13 Nov 2025 12:00:44 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jani Nikula" <jani.nikula@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Makefile: update SPHINXDIRS documentation
Date: Thu, 13 Nov 2025 12:00:32 +0100
Message-ID: <683469813350214da122c258063dd71803ff700b.1763031632.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Since the beginning, SPHINXDIRS was meant to be used by any
subdirectory inside Documentation/ that contains a file named
index.rst on it. The typical usecase for SPHINXDIRS is help
building subsystem-specific documentation, without needing to
wait for the entire building (with can take 3 minutes with
Sphinx 8.x and above, and a lot more with older versions).

Yet, the documentation for such feature was written back in
2016, where almost all index.rst files were at the first
level (Documentation/*/index.rst).

Update the documentation to reflect the way it works.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d514ab6761dc..c66df29cf0a3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -104,7 +104,9 @@ dochelp:
 	@echo  '  cleandocs       - clean all generated files'
 	@echo
 	@echo  '  make SPHINXDIRS="s1 s2" [target] Generate only docs of folder s1, s2'
-	@echo  '  valid values for SPHINXDIRS are: $(_SPHINXDIRS)'
+	@echo  '  top level values for SPHINXDIRS are: $(_SPHINXDIRS)'
+	@echo  '  you may also use a subdirectory like SPHINXDIRS=userspace-api/media,'
+	@echo  '  provided that there is an index.rst file at the subdirectory.'
 	@echo
 	@echo  '  make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'
 	@echo
-- 
2.51.1


