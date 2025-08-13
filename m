Return-Path: <linux-kernel+bounces-767520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25326B25580
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FDE17F258
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE8B2F39D2;
	Wed, 13 Aug 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HejI7dMK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945123093D2;
	Wed, 13 Aug 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120758; cv=none; b=Y5Ce08H71oyoeeWs0D0ruxrvVHDpdwFTYNrKN0tQuJwWjGo5+RBNPyHD7pXnSd8fwh7PSBlecv039tjXJthzhvy3gRypWfr2Lo179+CC9iiWRVH3XmcyLjA/1G8azGGd2K06+QgQzRmHvmYSv42xrALygwo2Rll+ly+BuqngzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120758; c=relaxed/simple;
	bh=td1wQOZTn2t7taMZPMo13hQVK7UFhFEqonm4xpsJez8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZdwJVDDfuYkHreyEwoEvMl8p9kAFhxNbhko/kKPD6zX1YfqRRDdu9dbUkPRYoFD6joHUoE8irla4B/xRGT3wNcUDIbH16a0LW+KExfzGuB/2XNutXGg+msfpw/Yak2p3j6HnKcOW1SM2UqnENZgrL3susxS6OTfqsGjiwFoNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HejI7dMK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 064EC40AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120752; bh=6A2E3kW8F6s7/ZG38M+WOh1FiZ91olnH6JrnWCCTVuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HejI7dMKH560V6rSEIIxMCRY9nokCOfubp96mrVGYhqmRhCfP0TWrFM+x0L93M0i2
	 Hr/sH6CsKnOOcbMykOFVpZppqXPGYimh5tMQi5sLveAh2nWcl8abnQ0Ce2QxwxrLwP
	 Kfyh0uEAT24u9AdRbm4zlxORYnjWbZLZkePIn9yN4d3ZR77VB6xwmvIAwQzmDkj3V0
	 tmAIgPOHrhO0d0ap4A7nrp3orOWXryWZ++6wD/CLgDcbs/Mx9OrPM3KrgaIQCS0k9Q
	 hsoRriCeiHpROuvcxpCT1hdbUNwcl/W8UDmrApMIFdKbtYbgzAZJGoMkfpp35hYD//
	 LpziWBB+OAp0g==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 064EC40AFB;
	Wed, 13 Aug 2025 21:32:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 08/13] docs: move test_doc_build.py to tools/doc
Date: Wed, 13 Aug 2025 15:32:07 -0600
Message-ID: <20250813213218.198582-9-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813213218.198582-1-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add this tool to tools/doc.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/sphinx.rst       | 2 +-
 {scripts => tools/doc}/test_doc_build.py | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {scripts => tools/doc}/test_doc_build.py (100%)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 2a0fc6c39cf4..d874dd0ed7d0 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -149,7 +149,7 @@ a venv with it with, and install minimal requirements with::
 
 A more comprehensive test can be done by using:
 
-	scripts/test_doc_build.py
+	tools/doc/test_doc_build.py
 
 Such script create one Python venv per supported version,
 optionally building documentation for a range of Sphinx versions.
diff --git a/scripts/test_doc_build.py b/tools/doc/test_doc_build.py
similarity index 100%
rename from scripts/test_doc_build.py
rename to tools/doc/test_doc_build.py
-- 
2.50.1


