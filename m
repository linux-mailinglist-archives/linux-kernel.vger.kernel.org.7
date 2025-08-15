Return-Path: <linux-kernel+bounces-770828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AEB27F61
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8321BC924F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D1E2882AB;
	Fri, 15 Aug 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa0D/W3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF65288534;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=JtEP3Yk5Uf8ZPam/H6DfHaeS2pX7PXUoZxsMNsI4tNyRFlmkAvS2Byv6YBzf4o6MvBmjtC08Is3tp8aGqYOLP17ZCY+FtgLCZ3gqdTZAVd960nnuryeYe9Dpc1sh8TwnQvM9exfz5dKs1xA7sO2IChC/SrssqEvp8X/n+Ka61Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=7SndwlVAORMkK7k0a/gvSMQNE5mjIwPthu9bKP5Mrso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ05T8Uo5Fk/nk6OrOIUwLhGXrjUTuHtPBFfTJu0AgfLR7XXFFxpbExD58EYNenGLUCdB+oCxIn9LjWIFVMr8L2zH4d8oCC5wEaw2NGdQUiFXSAtVjDO7UNijcebAzfl+wY7Rns7yuprxgHwtswzz1ixjAja8TILtrjrwox99ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa0D/W3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8ECC4CEFA;
	Fri, 15 Aug 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257846;
	bh=7SndwlVAORMkK7k0a/gvSMQNE5mjIwPthu9bKP5Mrso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qa0D/W3L1vVbnx0fuGkz0fymKiaoMUfekX1W72hERS0tb55pFPXjmCJY7tAka/AfZ
	 SwA8G7zrExK9qqmEo10fipDd0VgyCf/XlYBxVApJM5REBBjwP+vMoq8t/MrE8mdqXb
	 okSgBTNAxyxrL7TCeJG1UKeoHD3QE+4+1Vz3XvFIySD4zOKJk8OUgr1SGfIT5cvvna
	 WMVvZG3Q6fbFCgsxcgoArDWV4tLBcJq2f2iDv6NL7v1evH3vNMl5H9a/mZL62q9lJu
	 VG/xhJ+6KS6QKCEmME/X3faial/EeQHhlC3XlAogkNyhiislMYvevoKrlSw1ecf+Hq
	 psZbc9unYaJbg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskN-000000042Sx-44Pn;
	Fri, 15 Aug 2025 13:37:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] docs: Makefile: Fix LaTeX paper size settings
Date: Fri, 15 Aug 2025 13:36:17 +0200
Message-ID: <963bf2736855387e092d3e1b455cbe2ec47b61f4.1755256868.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755256868.git.mchehab+huawei@kernel.org>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

According with:
	https://www.sphinx-doc.org/en/master/latex.html

The variable that handles paper size changed during version 1.5,
as pointed at:
	https://www.sphinx-doc.org/en/master/changes/1.5.html

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 820f07e0afe6..2ed334971acd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -60,8 +60,8 @@ ifeq ($(HAVE_LATEXMK),1)
 endif #HAVE_LATEXMK
 
 # Internal variables.
-PAPEROPT_a4     = -D latex_paper_size=a4
-PAPEROPT_letter = -D latex_paper_size=letter
+PAPEROPT_a4     = -D latex_elements.papersize=a4paper
+PAPEROPT_letter = -D latex_elements.papersize=letterpaper
 ALLSPHINXOPTS   = -D kerneldoc_srctree=$(srctree) -D kerneldoc_bin=$(KERNELDOC)
 ALLSPHINXOPTS   += $(PAPEROPT_$(PAPER)) $(SPHINXOPTS)
 ifneq ($(wildcard $(srctree)/.config),)
-- 
2.50.1


