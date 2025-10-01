Return-Path: <linux-kernel+bounces-839031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258DBBB0AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F3517BD9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33AE2580EC;
	Wed,  1 Oct 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZxkeUKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B481D9663;
	Wed,  1 Oct 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328137; cv=none; b=shN9o9ux08Zdf/45uxVdUpFElPLssieCVpLyD+QOAI1bbXw+ct/ePeHsotG+L0zMMQtWrlIyCUIUKTtghGNEyBAdp08Q3drbo2H4Gwon/q6+5A2BPH/uStK+4gz0zB2TsgRBExKRcwf4HQHy8DK8QCq/mrsK+CX+2b7LMMXSlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328137; c=relaxed/simple;
	bh=poQHc0zUbKi61U3MBi9zrVxyTLo30MnCelCecnP23IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR/QVMi7buEnRZzHKDzurUxDs4ImKSpzDIbDAXnhQmsgiu9dAeTyrs1rGSl9elaldZTNJjW91FSy1k9JvuIkYcWDZWxz+XEykhJxOyOA3uJ+Ec7GvdnpwG0vMlu+Y05HgR2anbn87W2wRWpkinH+45ShxwDhL0RoAnt6KvhtEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZxkeUKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF55C4CEFB;
	Wed,  1 Oct 2025 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328136;
	bh=poQHc0zUbKi61U3MBi9zrVxyTLo30MnCelCecnP23IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZxkeUKF0TF/wLILhFVfszckjTsin7PEfSFK3zlB87zXTGDiQnxGWC1Kgiw8hMesN
	 KHQgMCX0Bnd4W1Bpowyuc8Uw3aOPmr8lVDa78RE4M56JGxgMUdfqsrNLRuRauGTdXc
	 +GcnMPJF67agz47HebhpwIv38mHEtpB8lIg0m7yJkU387SRWlxY5NL2E5ySr3AZseZ
	 TRWqLIazV2h7XSCLP3VirfpzKK3AJj61Dw6R1XH+2sovQwcOzN7x2WMdIG7+ketvxJ
	 QCDFNXPE5SluVAiZZRLcy5DEslDY18UBe+jxroxHkdwN4mtT7xsjFfEhi5naKwfLte
	 W5p3vyHUMmrVg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v3xcE-0000000BJ9V-3Log;
	Wed, 01 Oct 2025 16:15:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] docs: Makefile: use PYTHONPYCACHEPREFIX
Date: Wed,  1 Oct 2025 16:15:26 +0200
Message-ID: <8c37576342994ea0e3466eec2602a8d989d9a5f0.1759328070.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759328070.git.mchehab+huawei@kernel.org>
References: <cover.1759328070.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Previous cleanup patches ended dropping it when sphinx-build-wrapper
were added. Also, sphinx-pre-install can also generate caches.

So, re-add it for both.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f764604fa1ac..65d184eab739 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -60,8 +60,10 @@ else # HAVE_SPHINX
 
 # Common documentation targets
 htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
-	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
-	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
+	$(Q)PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
+		$(srctree)/tools/docs/sphinx-pre-install --version-check
+	+$(Q)PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
+		$(PYTHON3) $(BUILD_WRAPPER) $@ \
 		--sphinxdirs="$(SPHINXDIRS)" $(RUSTDOC) \
 		--builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
 		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
-- 
2.51.0


