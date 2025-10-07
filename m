Return-Path: <linux-kernel+bounces-844460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F9BC1F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 810F034F553
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966D2E1C7A;
	Tue,  7 Oct 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZMYlZ/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08C1898E9;
	Tue,  7 Oct 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851804; cv=none; b=AGXwINLomAhyDW/xeuN0V2jL5X4i6QLTI7kMd3y1rL3cXjzXt0Jl9ZHRZPadzU81yVdnXJomZ/z3jegN0ICdfPQ0xUlkSGmqIlPkHpyRnJeH0+zl1SxxLjSBiOsLAPxazviodpTc8TuTEud13beCVD8O+nTlQ/SCPboYOXJsQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851804; c=relaxed/simple;
	bh=lBGw09wrcnhK9Qe94pE6wgJIUTT38gyRS8J5n08HrIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LT/NUgkAv1X5g0tfI1uRjkv6g/9hpFfdy1IqAearzYwcG+6ncGdL9oQZi9UzqPJmKuazu9hM3rEzGoohpSPneUmT58o3+HfNFkSiVJsPzpBeFnJNaNYI2oGdUXyd0zO0CRm6rGUTbOPlkTyKWRz1hSchMvY9zsRhNl8ShjWC7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZMYlZ/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139CDC4CEF1;
	Tue,  7 Oct 2025 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759851804;
	bh=lBGw09wrcnhK9Qe94pE6wgJIUTT38gyRS8J5n08HrIo=;
	h=From:To:Cc:Subject:Date:From;
	b=dZMYlZ/8uHBrW3MWL03vX9WoVgRTvemxWYRkdtl0ENl1tPjikQOBX0kepuILgDlLM
	 ualOymDTCtpuPoEATh2UOMxudyZqSAdI6mFrwiseTeU+gtlVRxqy7swMUzK3arHgBM
	 f2N1CbWDYce8knud2V3+h0xNiBE/gngr1lqVn3SJBuXN/WufPk5wGeKum3DfPIlgMV
	 sLGJVzFN4dHjd0zqMOnI0/rgjkvGdnBbmRvZtBhn8urKZPYfHI9j6rXbxvL51s1U8+
	 dBx+e5Xf7neACoVt2XJmwRwFy17Opul8+Yaq16YkAg3mOrSy6Ve8tWLMY6AUFslNqq
	 D5IAvTNc3NDvQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v69qU-0000000HIOM-0Uic;
	Tue, 07 Oct 2025 17:43:22 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/docs: sphinx-build-wrapper: -q is a boolean, not an integer
Date: Tue,  7 Oct 2025 17:43:12 +0200
Message-ID: <cafa10cddce3e5342a66c73f3f51a17fb6c7f5d3.1759851791.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As reported by Konstantin, sphinx-build -q is a boolean, not an integer.

Fix the code.

Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Closes: https://lore.kernel.org/all/871pnepxfy.fsf@trenco.lwn.net/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index a74998e8309a..3e6d166d4102 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -141,7 +141,7 @@ class SphinxBuilder:
         #
         parser = argparse.ArgumentParser()
         parser.add_argument('-j', '--jobs', type=int)
-        parser.add_argument('-q', '--quiet', type=int)
+        parser.add_argument('-q', '--quiet', action='store_true')
 
         #
         # Other sphinx-build arguments go as-is, so place them
-- 
2.51.0


