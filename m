Return-Path: <linux-kernel+bounces-835971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E35BA878B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687FD189D1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44AA2C08AD;
	Mon, 29 Sep 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2ecV4X2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EFF2BEFE8;
	Mon, 29 Sep 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136048; cv=none; b=eD9Y6RxOjN9MS0VHHaSRARmPu3jeCHO8/aBS0FfyYUx8VtjMCSSqH+FDXwlX6uop7wrIK8QN/urEhDRo1SUL9JaeRMwq0gc0B1jFD4cHpvIk+0lFA+dmJtmMPcswOJMOoI/w+IJlhEDWVddW96URrrBGWH5CtX104j8QBiRzwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136048; c=relaxed/simple;
	bh=VblHNgwcKUasqczayKzhX0tS6LvSdnh19eIzfXV+JJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpNqLvE9gLMR4pgBnFEnU9TXXTB6cC95LKcehbiaXyKiwkbn7yo1ze92vGx24evCUeZgJ21AhS4/h17fWYkR4C3kXeEM1FR1TJrf93gkogoowtwV6n6vk3bpprKt6GN2cvDjhVpFpWwLPQl2HoAH0CzD0UiI1saBHOltzzKm680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2ecV4X2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A729C19422;
	Mon, 29 Sep 2025 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759136047;
	bh=VblHNgwcKUasqczayKzhX0tS6LvSdnh19eIzfXV+JJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2ecV4X2YxBTd2Xv7J7ByRDgaXm8dR+Nx6fNyYOrrqBG36HFlONCga331IOGsSUOT
	 De4HVkYVD3yYhjIYjKicAjI0LjXO+0pCLoPJz1rKsPtVkdKSC2vlq/z9jtVsuqL1pd
	 172UFz9iFeWAjPzR0XHNeHYCoDzWZP281dbI0blw0yAVnQ/s0IMQybZAoKA4kdezCa
	 v8Hsn8qpnQsB3nYONbTFUh7x78nQ+u+w18pNMMk5l4onDx4JocEYJI3y26DLDVV4Bc
	 ffacQdf6ElxBKzBxHhMHLCjH2g5a9Sm46VWA68WZyXDyV7Z7phAeDBFlzEps7Z2lIe
	 uLznz6vNsvBaw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1v39e1-00000009dSN-2EKq;
	Mon, 29 Sep 2025 10:54:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] docs: Makefile: use PYTHONPYCACHEPREFIX
Date: Mon, 29 Sep 2025 10:53:30 +0200
Message-ID: <65f341d516c329e2b57252176b188ae68f3bb6ca.1759135339.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759135339.git.mchehab+huawei@kernel.org>
References: <cover.1759135339.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Previous cleanup patches ended dropping it when sphinx-build-wrapper
were added. Also, sphinx-pre-install can also generate caches.

So, re-add it for both.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f764604fa1ac..cf26d5332fb5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -60,8 +60,10 @@ else # HAVE_SPHINX
 
 # Common documentation targets
 htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
-	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
-	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
+	$(Q)PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
+		@$(srctree)/tools/docs/sphinx-pre-install --version-check
+	+$(Q)PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
+		$(PYTHON3) $(BUILD_WRAPPER) $@ \
 		--sphinxdirs="$(SPHINXDIRS)" $(RUSTDOC) \
 		--builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
 		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
-- 
2.51.0


