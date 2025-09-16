Return-Path: <linux-kernel+bounces-818583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A558B59399
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DD27B1289
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AFF30CD8B;
	Tue, 16 Sep 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHoQsvBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7105306D57;
	Tue, 16 Sep 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018218; cv=none; b=DMg6glug1KKktXsrvzSlag6J/a2M9uRBMjSj/AGbmk7/OP5BSKilKYcvAynN9lVbQqF1/npoId+cT5n3y+f+wAJLogKRzXVV1y9U9VpdTBEt8+CZkENpETYcBnBR99MwrXBNrcbSQOHCvnct5Viv5upArWDIjs5t+bcY314lQDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018218; c=relaxed/simple;
	bh=4Yu1gA5/uZ+OPBNEREkXam+9wN35SUbcDazI/2U7I9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0hFg5cpMopc+LQ3Xow1+9DRLei3e5OO3ZsPD929jKp92PvN1gUbvUeAEjL5iKsHK/sssWgxZs7QPco5Z+hzrM3Hxqu93JqblYo+eFR6rocaBO7WoCAm5vXJvuYkOUFAaK5FAcJ2uQPlOvKhnFnYsJh7BNEtKqMc2Z0f8gUoH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHoQsvBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DD0C4CEEB;
	Tue, 16 Sep 2025 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018218;
	bh=4Yu1gA5/uZ+OPBNEREkXam+9wN35SUbcDazI/2U7I9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHoQsvBjyKjFaeeIE8nZgCaSIiwcL8G/+WNTDRm5Ar5IlScUzmvm/MdX96Fa1OMdW
	 Vbx0B7mUE7LRNmm07ifNMIkIjKpJhkIHG1H6fkBD/CeK+BduzaRNMbfUcQ4hS+depg
	 C7IMGV+RD+QbgVonaC1fZH0Ms7MXHafGGmaFf2onNo1eL1PlTgA+2kzxngCu9ibchl
	 xCujzWWtv/NFAK2MrEIQnIFIyMBf3HtS9RkJVSvxFj+WTy5AcmhsSg2PFJNAEBby2M
	 V4M9BjVGpGom2ubkPl1Bzuqbdg+sP158kB3BPvi9F68+rqW7v38a9ixbqYcuqGe+gb
	 d1xGKMERqRreg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqT-0000000BBQ0-10Dg;
	Tue, 16 Sep 2025 12:23:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 19/21] scripts: kdoc_parser.py: warn about Python version only once
Date: Tue, 16 Sep 2025 12:22:55 +0200
Message-ID: <64ed918564e9a6d19e6b3f83afb9584feb0821f5.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
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


