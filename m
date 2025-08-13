Return-Path: <linux-kernel+bounces-767518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4EB2558A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A131B61858
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182E230E82C;
	Wed, 13 Aug 2025 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bFpG3rQm"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490F2EE5FD;
	Wed, 13 Aug 2025 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120757; cv=none; b=uaNWLKJkg3ZxC7AiB8ctKWpEIRTyLZtWrOjK2Xt8EJ7ipBKguFIyxxKtLvq7g7jhmRz5iD0OyULM5cgcCwwCXEMZ21jqCHdUED0NnN7ru4Tu0yNkWjcQPMyPnbXwDdiyG1miJeQ/lnXe3Kuf+BKP5lnwg0plyUiih0gQqkt6I2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120757; c=relaxed/simple;
	bh=LTmqyp1/ibDp2tcqxUewokyf5alWURxLCwluqirhyC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmrdr2lyIMJ9kxZ5hbpm2b4pp9+NRebrU/ZTgeXq7D9xni7LmfdamDPO7fyTgIXWXHCHVLJCnI//VAhD3s4NXYzuhv0vdX0MRYOqhA8B9EfQ7gPMxwTmf2E0m3X7IvatQXgKxNKF5OPQbJpat/PQVYcN+yL68G6RZn1KlONfkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bFpG3rQm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3A1F940AF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120750; bh=EMIkJCSFEzX4JDPJfUNMvF3Fqzv6hrJlDW3m1/cGsBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFpG3rQmfysW1PQMFQxVj1u0aAHu7Pepzw+ope22rFpIG3m7HVceHL1zkEMSjNKBZ
	 eYFje5JFwpD792uE48brZljMs4pPgKPck+Uytk5vLMitlEaZxGNnfTGlEoI4UtYq88
	 UWWIhPmrSu9MCF7Ux5nQ8nW55afCtlBU0S9uf+GfTzzQooxhlXibt0gPa41UhHqy2h
	 Vr2TA6ZaZif5fFW+vq+dtOyVeBNdQRT3veGmwEWvIe5upvKaRW9boCMjvIUrQ/Gdxe
	 6WAC7lckHH2Dord1YKNX8Fax39IZ3GZ2uXI14Dtfi6Ug2IQnJ1NV4Qo/G5JQNOBHq8
	 s5ZxQgcKSJFbg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 3A1F940AF8;
	Wed, 13 Aug 2025 21:32:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 05/13] docs: move parallel-wrapper.sh to tools/doc/
Date: Wed, 13 Aug 2025 15:32:04 -0600
Message-ID: <20250813213218.198582-6-corbet@lwn.net>
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

This little script was buried in Documentation/sphinx/; put it with the
other documentation-related tools.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/Makefile                                  | 2 +-
 {Documentation/sphinx => tools/doc}/parallel-wrapper.sh | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {Documentation/sphinx => tools/doc}/parallel-wrapper.sh (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f7b8342f9666..962c4fab94b0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -91,7 +91,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
 	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(src)/$5/$(SPHINX_CONF)) \
 	$(PYTHON3) $(srctree)/scripts/jobserver-exec \
-	$(CONFIG_SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
+	$(CONFIG_SHELL) $(srctree)/tools/doc/parallel-wrapper.sh \
 	$(SPHINXBUILD) \
 	-b $2 \
 	-c $(abspath $(src)) \
diff --git a/Documentation/sphinx/parallel-wrapper.sh b/tools/doc/parallel-wrapper.sh
similarity index 100%
rename from Documentation/sphinx/parallel-wrapper.sh
rename to tools/doc/parallel-wrapper.sh
-- 
2.50.1


