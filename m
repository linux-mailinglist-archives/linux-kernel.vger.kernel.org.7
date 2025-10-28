Return-Path: <linux-kernel+bounces-874809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FB7C1724C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12C11B269DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3DB3570AD;
	Tue, 28 Oct 2025 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Jq0KGiXO"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED43563C7;
	Tue, 28 Oct 2025 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689430; cv=none; b=gwKQ6Wt8BGvkYMxo7Q/4uEX4lZ9wCY2LcJWRu7QlL3iCusDq7zCtZn/6OLhFqUsFuFx9zIkRw+K0Z2yGrEWrXEnvTAxCMxlnNCaY6RE6hZ4l+JAxq7k/aEl/oM/ZbdwBrhLe2lVn772Q0NJA7yMP/OZ1pmbDMw0cviSNMpJpSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689430; c=relaxed/simple;
	bh=4YC2m0DRLgYN0aq3nayIIz2Nlxt4xSQLR+XrLklRCZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m986NZnyvdeBWKq5EvELr+rRzBOR2Z2mqmUX+rgFSsMZVeAJxCpJLPegW1iIzw/Ae0UDx/ER+YNiTQ6kuV3XOj/6xoEGRlhy+3MdYWyg9J5gnSwQDT0HbEB+kGx+6ACxC/cMOopK0L+dkjdf0A66XgXODI/nbwafCDOIBg1TyyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Jq0KGiXO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9F3BA40C2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761689428; bh=mdlWTppuyklykN6x72Eo8ijQSx0enYM+/VHzFAQVi+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jq0KGiXOMQh89phOvmgrt8Bp8pQRMBLUzrTqKRCd4PrZwR/N5I9PdCMZ3g1Dx4FLR
	 5pxGjqu0iEK1NN43i3Rr8fsfX3RL0hzgUQ2J31v5zFpMJar3vIVTvWOo0M8XqFRZ3a
	 rz904GPhqzJ13WrFZ9xNLw0Z2hnn75iLFN/CULMWYst9d0VJBOEqFyHhVNmZ6oV3/j
	 8KNcJHnCjDamgR/iY300Hu2cFJhiC5ZzBeB89XeqTV8jZGxYrJa1Qw2qONEwuYEngt
	 YjNaSZX7/DQIVyy4F9z0fUkVAxP+WjwNO1NZknymh4UeJBI3bQo/ImU6Ly/ST9LfuK
	 mUhkRWHZ8mggA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 9F3BA40C2B;
	Tue, 28 Oct 2025 22:10:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v4 5/7] docs: move test_doc_build.py to tools/docs
Date: Tue, 28 Oct 2025 16:10:13 -0600
Message-ID: <20251028221017.5785-6-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028221017.5785-1-corbet@lwn.net>
References: <20251028221017.5785-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add this tool to tools/docs.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/sphinx.rst        | 2 +-
 {scripts => tools/docs}/test_doc_build.py | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {scripts => tools/docs}/test_doc_build.py (100%)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 932f68c53075..51c370260f3b 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -149,7 +149,7 @@ a venv with it with, and install minimal requirements with::
 
 A more comprehensive test can be done by using:
 
-	scripts/test_doc_build.py
+	tools/docs/test_doc_build.py
 
 Such script create one Python venv per supported version,
 optionally building documentation for a range of Sphinx versions.
diff --git a/scripts/test_doc_build.py b/tools/docs/test_doc_build.py
similarity index 100%
rename from scripts/test_doc_build.py
rename to tools/docs/test_doc_build.py
-- 
2.51.0


