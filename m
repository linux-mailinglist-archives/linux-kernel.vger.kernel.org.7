Return-Path: <linux-kernel+bounces-820621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 193DBB7D057
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91357A3097
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CCF30BF5A;
	Wed, 17 Sep 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aScCu71n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383AD225761;
	Wed, 17 Sep 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111354; cv=none; b=UvZUy3S22wI1lTOTMz9+8qRhOX+FvC3Ul5vfKqLGHXtfvcnGrJVZhJKdRGoKa9S1cXGsLI97GfUfbPvBTpYtlgwMDZsz0i8r2OWpeSx+TT7Xzif742tPXrnG8LiCFw/BS3WEX5Air2V872Wk8P2Ah0Yic3ee8DW+xT8ugiACzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111354; c=relaxed/simple;
	bh=0ypUcNGg9z6BJTKB3g3MJi0xHG6c16cyioz2ve+I/iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jG8X3Z12zASABTIzSS4hxEGLviZK38E1q+Lj1GHY7ixRDB3/DqC2BIeQ1+8M+2ws/144ab1l8GjfoQSarwo3f4dPTLpcmCOImawAiZ+6cVd1E7SKvi5Y/Q36wl60XcmR9M/GxFL2iwa72mWlYAaTmmVXkp2qHLbAQ4zVkUcBjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aScCu71n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACD4C4CEF0;
	Wed, 17 Sep 2025 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111353;
	bh=0ypUcNGg9z6BJTKB3g3MJi0xHG6c16cyioz2ve+I/iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aScCu71ns3Q4t5aSDMqAS61P2Jmg7w5LIqvl22+yxOhR/qrCd+WCxU4rs0g14VNfV
	 4Zv2JpekEbA32D3DjQuU6LrmDZRaVnu0MbCIlRzvVRPHet66jIhePEwi/c9Ud5hATv
	 aJRRuBvzV2VZ4ZJh1WErRTL3RiizRf6j4ylhc0NLWW+kA3qY+QmjCdSNE0WKHtCeVK
	 JoG+5DG/k3TFazCHbLX+5m+WrYIuBBSyMZSHRXIrCHoMdN1v/7cYAVgucTfDlcfDdV
	 +CuV7J9dmnUKEXWcpo0hIEjJH/vKQmIZi2hQH8oLQ1NAkvF0/AN6gh50vKGXqYIc8f
	 SZO6dsEIZlLsA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGe0-1cDV;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 13/24] docs: Makefile: document latex/PDF PAPER= parameter
Date: Wed, 17 Sep 2025 14:15:07 +0200
Message-ID: <4ed5c9fbb30c67c0325a278a687c9bbe11d29c16.1758111077.git.mchehab+huawei@kernel.org>
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

While the build system supports this for a long time, this was
never documented. Add a documentation for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 380284026c13..a52b311cdadc 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -124,4 +124,6 @@ dochelp:
 	@echo
 	@echo  '  make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
 	@echo
+	@echo  '  make PAPER={a4|letter} Specifies the paper size used for LaTeX/PDF output.'
+	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
-- 
2.51.0


