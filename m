Return-Path: <linux-kernel+bounces-869483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33FC07FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FFC1501526
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103432E7650;
	Fri, 24 Oct 2025 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="G1bm2Oqk"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3EA2E2EF0;
	Fri, 24 Oct 2025 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336534; cv=none; b=WDyr0rnwIHdVDwrp2eh0f5GwLh2gfkBfZjtaHlotmCWDKV54IUFuU4dTVj9MCg5hN9BHzNJhP1lRKAauoMLtFv8IK7iUf/tgdBrAv/0L5B+E0Jl6eWJ+XAw0Af8u9uEmZ06mwLCz1VlN//UZT3UqKO2q+AQrYE8BzhiiYSFUGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336534; c=relaxed/simple;
	bh=qP9TR29vJ1KHeNs7La7g0B76CsfqLiT09uHO+4H2JWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+pRxQzci9xaTLe+EniukR/9XDNKX1NKBJu1KnrOsNHwZRvlOI80HGcVCSiUoVOrS7/0FcFe4PCXF6q7Dx1J+xp8wdlbCRRQcT7fl/cCX1CKxWpzu4n00a0ztj2B0uM9N5bDj1ellg2dZzTvcuxqyUQWh9Tl3VIdylGIMPmIxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=G1bm2Oqk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 023BA40C2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761336528; bh=OgfcJ4EgrQ+jyCcgSBx3PMKEUJYag0qgM4FJM9RfeAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G1bm2OqkCg/fjPK375ui2GZCzBWWlgE74cc5mJ0T9uAfR10SeOUWd3ImyptaZpwvi
	 E56rUrtkJATK8PIMi0L8b9GZ8gK5qfd7muIPO2xj7YRiRoqr5pseLIAJLpsyZ4FcjP
	 SbNCgfjlFc5PAMgwBXPh5ez3WhZubth6Ws7NC3C0gfVMqkckgUm0U1H/vY8OePmZR2
	 FcIaShmlw7qpek6tAULoNBHp1O0Jc+BOZAJjsMzNlhW4SMtjjyPEGB6YQYlKxixWdI
	 RxV4kxvmFfF6n6Cge6Es1c2r+e1c/fDQvF5AIGF6AH+z4HJmTbg1gZO9dG8Ow6cHPM
	 s78sMwwEQRj7g==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 023BA40C2D;
	Fri, 24 Oct 2025 20:08:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 5/8] docs: move test_doc_build.py to tools/docs
Date: Fri, 24 Oct 2025 14:08:26 -0600
Message-ID: <20251024200834.20644-6-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024200834.20644-1-corbet@lwn.net>
References: <20251024200834.20644-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add this tool to tools/docs.

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


