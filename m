Return-Path: <linux-kernel+bounces-765177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A747FB22C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4957C6227C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0A52F659D;
	Tue, 12 Aug 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhrXT25c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711102F8BF0;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=CFI1+R61o6+ViIlXvviL5F+dNk3aiCVm7QWif7JXaNPkJnvd+7TlphmgGvF4Ejn/lkR0p1GyCdYijq/8GYNcjspRvVUiyR1N5cdJK4t7PKOhW1ODZlR4jImHxAYX+d7l639uRPHx6lOomyxoES5s2Jxxl0unoiyMD6IxzuhLw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=ny376t2fqD0GqIIjAOTP7dUiyq0BQJ47NgDRbfadqEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHZzfch8sYdON8C3adhOJOiSckkPoVGkEw+3C9vzSGEH90GFqiY+hXNvomhTWv2/TZFSxmiavt3afJZ1Vxyga8rIrQ6q6vHiaNVBWdZiUqf1TCzCvBE3RzgZ6WlZPDE0Tc+OeckvShizAHr5UCrGNKg5yhikMJOd6uXfj3ZW7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhrXT25c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C81C116C6;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=ny376t2fqD0GqIIjAOTP7dUiyq0BQJ47NgDRbfadqEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhrXT25cltKKir1fMpjVmF+eoD23lWjYSrhUcn7zIzWk+N1t8OG+oigZvvjQM49Sv
	 q6UHWbbzIWJDgb89gqUECI/TUYDtEzAbJ4OmjyzPCODmJSWXSognVWjz4bFpwaKfEK
	 Te62VpqkmDPHDzZIG16mj4AVW/08iNeCqg74so3tadoV3AjhTAJUeWiHjYR2hwmJLN
	 1iWiCVZ0yiwaMeyWiTNH20xWUYQxefGUxLoFbNUSa8hW2F2Dh4uOL/AK6I8ZIvSWEb
	 WcDHl6Jx9pFFxv6TUgqoYFnSIFP+MvO1tJiyYv06jbbd+YIlOBdCYgWwdameD7QlVZ
	 cjKf3eiV8LRfA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWE-2D8G;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/39] scripts: sphinx-pre-install: fix Leap support for rsvg-convert
Date: Tue, 12 Aug 2025 17:52:33 +0200
Message-ID: <6fcc94533d860e2f6f4f2c7d6ceb6cca70f48bb6.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

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
2.50.1


