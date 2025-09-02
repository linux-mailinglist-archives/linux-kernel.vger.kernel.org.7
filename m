Return-Path: <linux-kernel+bounces-796403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC8B40016
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94C27B2BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D882FFDCF;
	Tue,  2 Sep 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFEKoPiU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0B2FD1A7;
	Tue,  2 Sep 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815497; cv=none; b=t6e/bFk3Zy79cl6CyQTKx6TCtrLo1JQ3UlE1D3SSwgbOhMqi6AdyKmqDJh+/8kz165wu/M/zKid34ELJrTY3f83RQwZ+ugKBILjsZ+xJJFoCbZq+RId4jG2RC2h1KTn9lCSZt3GOhq6k9yrNj21OxdgwTmRSDdUt9it/bxeg8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815497; c=relaxed/simple;
	bh=4Yu1gA5/uZ+OPBNEREkXam+9wN35SUbcDazI/2U7I9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koQ2516XamYSaQuf360rX06z2yM82/qzjjltIg2vNWH+IB7rM7F3Ydq7gsRrSw2EM2+FOI0OKV6LeVweS3IB09WICUrxMkHnbLGCZvIpFOUf3hOldD2m9xgrhQTvmp4vo2WUTCQvbdXmWMSpY5RApjwlWNZbsUHoHPLfOWQlg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFEKoPiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25B5C4CEED;
	Tue,  2 Sep 2025 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756815496;
	bh=4Yu1gA5/uZ+OPBNEREkXam+9wN35SUbcDazI/2U7I9g=;
	h=From:To:Cc:Subject:Date:From;
	b=MFEKoPiUrByQ2p9fZYcenlG46Tb3DiNsxTj3TgKQShIE/UTbgi5O1NZDWKaleIDhT
	 nHaegyCP0V5dCEi71UKgG8ORLzfXHmbfRWHaN0muaQknPKIEyB5a3JPUgUgUa3ASN1
	 jIvqhI4kdpGHBbxP9/eH83Kk2iOgjtcR3D+sA/oJ7BOqxwVUV80atf9FMAhOxB5ugR
	 bzbJ1alA3UPioKiNMbKnofWSh+WQj43Hi4DiwRjD4NKJi/XQ5V/RykvPG+iF/YlPwW
	 hfQjxFwcuEMnAvvrWsxfbd89lZ+SOuPR0av1vkyVw5XSY4YLpY6BtASz6j2q3W/ZYS
	 9hV7gP476/jsw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utPxm-00000003b5I-3xsS;
	Tue, 02 Sep 2025 14:18:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mark Brown" <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: kdoc_parser.py: warn about Python version only once
Date: Tue,  2 Sep 2025 14:18:00 +0200
Message-ID: <4527153e470dc47e383e6e03c75c9a07a563c154.1756815480.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
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


