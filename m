Return-Path: <linux-kernel+bounces-723791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AD9AFEB13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A3C173BEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8F2E54AF;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMp+20Ak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB02E610F;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=GNc0bQf5+74sy0oeAgpB+Pm/atru50wP64GwsP3Q4zNk9J68Cwr3OGWkID6tArPxnlhGfnP4Xxx43ub8hq4R+A/+peQXIBp2C1JEjScTzs3ZQp/8YHa7YfNP2VFKtijK+7cepIwz4eazb1jj3plfYOAINPGe0KJKxULlojb6dYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=SIQGNNtDKtOVtNJm5iIXTjHrV+UsTcmQyxIm4APuQlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H077uK4RNGRq4ol5xeXH/HMo9BQ2pSVJCpNmtpLpaQXM65NnamlAjjLnC7OowLn6y4Yg9p0P9Eh1pq7c86gpGuMwTyYGeNB6YhQlSykpbATdCbMYawH4jFk+I2RlymqC/szJ4kamAjpxLSwuIdPGCgkLxtoDi5pqobXfBjYBQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMp+20Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC0BC4CEF8;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=SIQGNNtDKtOVtNJm5iIXTjHrV+UsTcmQyxIm4APuQlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMp+20AknU9MieLwiXUWCCqP3t253MruWII0bi690Xd7WJjyQabW+CuJrz+6Pm3nC
	 qqthpByH6uzDo3/37KdDImm129X4Svqrp7fHki49VWXVBNEKk1qGhIP3ZgKKZZEJiK
	 0gIwLhQKM90FIjdp8Cpp2JTfKE9H6FJx2LvkpiHM4gMpmsVpT6m57R3joDlQXi1Fjq
	 TzSthuTv/8fW6KCIf3eOFJUjfKvnoel4jrF3o9WFdNKeC4ZGzkZW7mdueZ2VfIPg1D
	 RDyMVKbIbcWW8Bq6CWL71rS+oi8ygIvvmDTgeCmVj31gydbHEDcguDFirACwHgDG0t
	 BxVnqQAMp4QdQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECm-1oUy;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/39] scripts: sphinx-pre-install: output Python and docutils version
Date: Wed,  9 Jul 2025 15:51:46 +0200
Message-ID: <5c041bd36c3a9f86e6d4d3cf98200100cefdaec6.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Specially when debugging issues, knowing the versions is
important. Add it to the script output.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 42f55e67256d..de5bcfd052b5 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -154,6 +154,20 @@ class SphinxDependencyChecker:
 
         cur_ver = sys.version_info[:3]
         if cur_ver >= MIN_PYTHON_VERSION:
+            ver = ver_str(cur_ver)
+            print(f"Python version: {ver}")
+
+            # This could be useful for debugging purposes
+            if SphinxDependencyChecker.which("docutils"):
+                result = SphinxDependencyChecker.run(["docutils", "--version"],
+                                                    capture_output=True, text=True)
+                ver = result.stdout.strip()
+                match = re.search(r"(\d+\.\d+\.\d+)", ver)
+                if match:
+                    ver = match.group(1)
+
+                print(f"Docutils version: {ver}")
+
             return
 
         python_ver = ver_str(cur_ver)
-- 
2.49.0


