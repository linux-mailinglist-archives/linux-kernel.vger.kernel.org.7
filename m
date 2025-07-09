Return-Path: <linux-kernel+bounces-723778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B09CAFEB03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EBF562B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0432E92AB;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUkMIWnR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794762E54B3;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=bZ/VQbbqFs0v9NbQECiCL0JTLTu317LknK5wvPvbqPCrBYqrYAGaXOOET0mDoY4RVktMYKGqXzsntTYARbnk3L/DTHLjcdHy8asJ/FA+R3LjxgOcRtK77i2pZ2lBBznxVjansCtkofImflTTi2YXmZTdQz6fOkT2lExDbQVh3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=b6fptr6JRQPFlN7HHjnH+rvHZDs6wo06AtQN59akfOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6+DwpABf44PDkkFCZs7qEPxPqZ/bK8K+WRu2NKY5PnFcnEnFgcJTEPIcRUiSv8BQGRNJO9BlDgUnYzH9bw1QglPr2l1LFvucZy8ngI+31Eh3EWO6UKW1TxP61ml/XSLbXnydZjtkrIt8zQCmuZXzCdVobEIwGmK8jDcToAw/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUkMIWnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F0AC113D0;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=b6fptr6JRQPFlN7HHjnH+rvHZDs6wo06AtQN59akfOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUkMIWnR4ta5OCgwKvQrOtWNhlILJuTYeiEm3w1wukUKsr8lOzp/TIlFJFyaP93RW
	 w7rg1IymZI5lgvzFORah/oGKdlfNWF1A4G+milvUtnO7FEa0CtCR9KFSorupnLJC2F
	 2/1TTkQOKqbtrE6rKo0eub9884BTCBPnoq2NaF8qHUjK/0z31wyZ9VM5ZAlxsj08EF
	 G3MsZb7s+SU/OKjF0cqZvq/ezjJvvDKK4u088Pa93v+St/HaTwrUatAlzSQSGncf1s
	 2OCAW0r6UO8cGXprNAJRTVCNUzvncW2BJJD6ES4+J9TRiRI5+kgzJVJ2mmo1bB4yWY
	 1qZEKSMonrLzg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECs-1zW2;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/39] scripts: sphinx-pre-install: fix Leap support for rsvg-convert
Date: Wed,  9 Jul 2025 15:51:48 +0200
Message-ID: <c038f37690b649f43b6da7ddf2741a9bbb48646d.1752067814.git.mchehab+huawei@kernel.org>
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

There is a test logic meant to be for Leap, renaming rsvg-convert
package. Well, at least on latest Leap releases, this is wrong,
causing install to fail. Drop it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 6a244105f7ef..6b5f9eda91bb 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -566,10 +566,6 @@ class SphinxDependencyChecker:
             "yaml":          "python3-pyyaml",
         }
 
-        # On Tumbleweed, this package is also named rsvg-convert
-        if not re.search(r"Tumbleweed", self.system_release):
-            progs["rsvg-convert"] = "rsvg-view"
-
         suse_tex_pkgs = [
             "texlive-babel-english",
             "texlive-caption",
-- 
2.49.0


