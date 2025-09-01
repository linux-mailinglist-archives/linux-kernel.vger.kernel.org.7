Return-Path: <linux-kernel+bounces-794944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20262B3EB2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D9F1B23F9D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FD22E6CB3;
	Mon,  1 Sep 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETq6E1/f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000C2D5941;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740837; cv=none; b=urnounUYpQXQtURA87b9KbWxJSRBcC5HHtvAFCCvLQS6KQaT1QK2jIftXd977x0MF66Ca1d0DuYrRABe5S6F5fJE9DAM3g+b4TMXWVSKeWagEzMCH1VPNPLgBZ4RoZS9DRzWXLSxH9p1FIB+PCLa/NIpGhTEJiP9Ng7JFcQgBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740837; c=relaxed/simple;
	bh=oHXvdy3H7R+x5Ixjfz6V5CGej/pfsID1jTHXgNR3lhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q/Q+pdvc7SOx7W3nkNsKLjmNI/izLnmzDwqLPXR9zecSgyoMHVZeRaZozq+ynNbY5FFdmz8em0kFTHsLUFQcSni5mLGT+H5nzQioAeHFOipxT1T2LfVvTV2lJFV73BT/YxBn0zNefcyXditlCWJ1DL1lGEN5zRApU7sjw6YASx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETq6E1/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C583C4CEF9;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740837;
	bh=oHXvdy3H7R+x5Ixjfz6V5CGej/pfsID1jTHXgNR3lhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETq6E1/fP/nVQSldla7hpI+LUoeSybYS6MrZg9Bd9yakwHMQN+iC3Bhzp8T5Mna+k
	 e8EH7lUY1z0A0i4nuDtfd5WZDkK4wLw/rWiy64MwgndityujOzlza3SG8rwc+lzlsx
	 BV4LlvZrj8dgsjDma2oJh+j/VuTZVOgAyH41IKOgega35NXQab/hcn7p4N/8ytXW1C
	 Tm83xGZeLhl0Rh8b2sGETEWKxQXfp5Z5ECNpTRQopaRM6LEioiF1hntuGbbkOBwfRo
	 wCaJeav08gjokvz3Ff5bdMZh4YHwzDQtditpY6dvFFSDUd3wmp5H4LnVn0QWga0aWY
	 wYTOVPlCmpczQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut6Xb-00000003HLq-2UeQ;
	Mon, 01 Sep 2025 17:33:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 04/15] scripts: sphinx-pre-install: move it to
  tools/docs
Date: Mon,  1 Sep 2025 17:33:39 +0200
Message-ID: <ed365cdc10243a088b13be5e59b8aa7e733c9081.1756740314.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756740314.git.mchehab+huawei@kernel.org>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As we're reorganizing the place where doc scripts are located,=0D
move this one to tools/docs.=0D
=0D
No functional changes.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 Documentation/Makefile                     | 14 +++++++-------=0D
 {scripts =3D> tools/docs}/sphinx-pre-install |  0=0D
 2 files changed, 7 insertions(+), 7 deletions(-)=0D
 rename {scripts =3D> tools/docs}/sphinx-pre-install (100%)=0D
=0D
diff --git a/Documentation/Makefile b/Documentation/Makefile=0D
index 5c20c68be89a..deb2029228ed 100644=0D
--- a/Documentation/Makefile=0D
+++ b/Documentation/Makefile=0D
@@ -46,7 +46,7 @@ ifeq ($(HAVE_SPHINX),0)=0D
 .DEFAULT:=0D
 	$(warning The '$(SPHINXBUILD)' command was not found. Make sure you have =
Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point=
 to the full path of the '$(SPHINXBUILD)' executable.)=0D
 	@echo=0D
-	@$(srctree)/scripts/sphinx-pre-install=0D
+	@$(srctree)/tools/docs/sphinx-pre-install=0D
 	@echo "  SKIP    Sphinx $@ target."=0D
 =0D
 else # HAVE_SPHINX=0D
@@ -105,7 +105,7 @@ quiet_cmd_sphinx =3D SPHINX  $@ --> file://$(abspath $(=
BUILDDIR)/$3/$4)=0D
 	fi=0D
 =0D
 htmldocs:=0D
-	@$(srctree)/scripts/sphinx-pre-install --version-check=0D
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var))=
)=0D
 =0D
 # If Rust support is available and .config exists, add rustdoc generated c=
ontents.=0D
@@ -119,7 +119,7 @@ endif=0D
 endif=0D
 =0D
 texinfodocs:=0D
-	@$(srctree)/scripts/sphinx-pre-install --version-check=0D
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texin=
fo,$(var)))=0D
 =0D
 # Note: the 'info' Make target is generated by sphinx itself when=0D
@@ -131,7 +131,7 @@ linkcheckdocs:=0D
 	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(v=
ar)))=0D
 =0D
 latexdocs:=0D
-	@$(srctree)/scripts/sphinx-pre-install --version-check=0D
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$=
(var)))=0D
 =0D
 ifeq ($(HAVE_PDFLATEX),0)=0D
@@ -144,7 +144,7 @@ else # HAVE_PDFLATEX=0D
 =0D
 pdfdocs: DENY_VF =3D XDG_CONFIG_HOME=3D$(FONTS_CONF_DENY_VF)=0D
 pdfdocs: latexdocs=0D
-	@$(srctree)/scripts/sphinx-pre-install --version-check=0D
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
 	$(foreach var,$(SPHINXDIRS), \=0D
 	   $(MAKE) PDFLATEX=3D"$(PDFLATEX)" LATEXOPTS=3D"$(LATEXOPTS)" $(DENY_VF)=
 -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.=
sh || exit; \=0D
 	   mkdir -p $(BUILDDIR)/$(var)/pdf; \=0D
@@ -154,11 +154,11 @@ pdfdocs: latexdocs=0D
 endif # HAVE_PDFLATEX=0D
 =0D
 epubdocs:=0D
-	@$(srctree)/scripts/sphinx-pre-install --version-check=0D
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(v=
ar)))=0D
 =0D
 xmldocs:=0D
-	@$(srctree)/scripts/sphinx-pre-install --version-check=0D
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var=
)))=0D
 =0D
 endif # HAVE_SPHINX=0D
diff --git a/scripts/sphinx-pre-install b/tools/docs/sphinx-pre-install=0D
similarity index 100%=0D
rename from scripts/sphinx-pre-install=0D
rename to tools/docs/sphinx-pre-install=0D
-- =0D
2.51.0=0D
=0D

