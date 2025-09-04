Return-Path: <linux-kernel+bounces-800172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 442DDB4343E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD38B1C80752
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6AC2D0C74;
	Thu,  4 Sep 2025 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB/g2yv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614392BE7CB;
	Thu,  4 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=rWB6ojBEIZ1FGN8f61pwUO6Tt5ANQc0HEoe7A85DeSC00JI2YIO9LhDcJSyrjSpdwFKWXniTnl7UobIhVL6/etUUPcWVDt/WxNot9xXZ6rQerTJEgFhLeSb4gXRpmOvHZAFm/voGnTuG9prPYrkzege8TT8DuAi6UQ+9EByZ5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=4Yu1gA5/uZ+OPBNEREkXam+9wN35SUbcDazI/2U7I9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lwj5fspyt6xyn3E1uiy5mTEjWVJ4Sjvxc1cN0lhmJn050Jf4+FZW9Bqwv5iHe42Rje/zB4XV6XdzQLUGN1tgyr+9GcU3y9TtilpS9jquCpgpb4VwXp1pbFb/dvaSRwvLh4TOqOf6A9LcYC9oeWjSia/Fc92kJERyMQ43bU/ynvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB/g2yv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB22C2BCAF;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971206;
	bh=4Yu1gA5/uZ+OPBNEREkXam+9wN35SUbcDazI/2U7I9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KB/g2yv207SLTsFdV+b+TrE3aXebjLe0+qdSjzJdHe0Y2saTM4K7RUrG9i0tpEpJ/
	 /AkQUxkKOXXgnrfGXUoIpRBztOqfJtLksd0lkq5DE7h9QIaUyBEZgYFQwvopWO6OFs
	 bpkuWByKjme2oLjS3+0E2oRtURZ+Y4H6O+TFldhPS2TFCfYBe5Sd4UuAYbm3xETVvH
	 rvHsoknvZTjXU2VqvYvPslBGYDffXm8feGhThZBfs2D8uazmlXgnfUNvj4dzL/X9By
	 ZjNHuyzfSHDOrTJKGd/Mc35+3sPYO4PqyCkfnmg3IrZTA/ca5pHR0mPqT6Cf72ir3v
	 fa/F3HVe5hXgw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TF-00000009jQJ-0aW4;
	Thu, 04 Sep 2025 09:33:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/19] scripts: kdoc_parser.py: warn about Python version only once
Date: Thu,  4 Sep 2025 09:33:18 +0200
Message-ID: <d9d6599ebb195f90d1bf2657e728462630fb9c6f.1756969623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

When running kernel-doc over multiple documents, it emits
one error message per file with is not what we want:

	$ python3.6 scripts/kernel-doc.py . --none
	...
	Warning: ./include/trace/events/swiotlb.h:0 Python 3.7 or later is required for correct results
	Warning: ./include/trace/events/iommu.h:0 Python 3.7 or later is required for correct results
	Warning: ./include/trace/events/sock.h:0 Python 3.7 or later is required for correct results
	...

Change the logic to warn it only once at the library:

	$ python3.6 scripts/kernel-doc.py . --none
	Warning: Python 3.7 or later is required for correct results
	Warning: ./include/cxl/features.h:0 Python 3.7 or later is required for correct results

When running from command line, it warns twice, but that sounds
ok.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_parser.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index a560546c1867..574972e1f741 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -314,6 +314,7 @@ class KernelEntry:
             self.section = SECTION_DEFAULT
             self._contents = []
 
+python_warning = False
 
 class KernelDoc:
     """
@@ -347,9 +348,13 @@ class KernelDoc:
         # We need Python 3.7 for its "dicts remember the insertion
         # order" guarantee
         #
-        if sys.version_info.major == 3 and sys.version_info.minor < 7:
+        global python_warning
+        if (not python_warning and
+            sys.version_info.major == 3 and sys.version_info.minor < 7):
+
             self.emit_msg(0,
                           'Python 3.7 or later is required for correct results')
+            python_warning = True
 
     def emit_msg(self, ln, msg, warning=True):
         """Emit a message"""
-- 
2.51.0


