Return-Path: <linux-kernel+bounces-820625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4FDB7D0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE375846E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1293233E9;
	Wed, 17 Sep 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuSPDP2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE031A7ED;
	Wed, 17 Sep 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111355; cv=none; b=E9giHM9dWDew0BfWgFh/k1JSeglfHpxZ7fKJb07TmiWa6mJXLkrn6tolF2lunIkpc/DmE304HtXkQCW3IAgwX2iQW5FmUvsCWJ0w6M9fWdInG8zin41c9qw4RFigD+Znr10ctxuUoxWoiDArMOZp8IigRZu24soFwOjxV0vgWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111355; c=relaxed/simple;
	bh=4Yu1gA5/uZ+OPBNEREkXam+9wN35SUbcDazI/2U7I9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu6vw0fzqI4adn3a1ygVAQ70feZCRVATfuvFMKSsCSSuNGt8jwfmEORdK7d50bJGgU3V4oQCCgRa7X7vOeJEf8aThk3jUHANK3vO82HxSh2Z+CYH7QbKH4SRqlLkkKRQtkH2pOUHmmOKuY88YSpzSkKlDsjszwDq8iqKuE31ETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuSPDP2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ABBC4CEF5;
	Wed, 17 Sep 2025 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111355;
	bh=4Yu1gA5/uZ+OPBNEREkXam+9wN35SUbcDazI/2U7I9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuSPDP2uz1S6Ah3lzir9ox5agDWER2+Br02ozMoLiMMv0o29AKGdXrioJo1zAQunT
	 dmByOx7XFTteRsralZHWyujQwCtDF/NjbAOwi+B/7MVQM2NCoawVK6ZuzSSqESW15+
	 jmfINvCB36t7CZCRNCe63Jf/exL08BYsI0LhLGZe4ZdVBKGOVtHL/zMoGi2qW0sf99
	 KxlqYAakLN1ZbRSE5C2TBvYK3vlcXXhLaTr+aaAeVd1xnFhP5zPdPfgkn+z9VmdsUp
	 7aqxUTJdAxVL+PXB/JIUPd8d2EXdu28gfwSc5vLO0jIg2jklhb4jG6lsFI++eNIDwy
	 yaDR32QMRIGJQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGeW-2XQS;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 21/24] scripts: kdoc_parser.py: warn about Python version only once
Date: Wed, 17 Sep 2025 14:15:15 +0200
Message-ID: <a11ee33610e007e081db15f8eceb6a6e58d9b48d.1758111077.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758111077.git.mchehab+huawei@kernel.org>
References: <cover.1758111077.git.mchehab+huawei@kernel.org>
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


