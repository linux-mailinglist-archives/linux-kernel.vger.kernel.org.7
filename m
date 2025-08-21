Return-Path: <linux-kernel+bounces-779278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21068B2F191
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66301CE0AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0642FDC39;
	Thu, 21 Aug 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akVg+l4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC22EBDCA;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764225; cv=none; b=YaaEkaWirZGOfmgEG8jo+wRfpYBVGocrR37hI/ONtf4IZxxXNvWYdfCw1cC2hJeor9wRS0xaxOmnhIxc1cr4s1vmbw+PGiCVxJMGlta+p3QiTj1t14EcSiO5PcxvFqD0pnDHCOGjwzRdSsR2bYMNSX8RvPEFacGnpc4AcK7lA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764225; c=relaxed/simple;
	bh=+0AJ0cWG/9OFYSPOjOfNLiW9rTewkgZT7lE9vDRgSBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brdtHdIudeSpW3YRrepuAAieiGCY5jrWm0gXVtxhUyPmBK9NRgUHfd+dT1IF3/SQqdJ1ERJufyn0Durs8AN35Gggx8uabiBfDCXNC6j362sgpXEyC0EyZ2llC8Ta26vpI+TjcG3XB/H14PsmbipoVXWsonr9dynoe4klMkOZTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akVg+l4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFF4C2BCB7;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=+0AJ0cWG/9OFYSPOjOfNLiW9rTewkgZT7lE9vDRgSBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=akVg+l4EyuUOLB2ezLIsGpaqJ5VlEMWNQzFfgwHPHeil2dkl7MGYirWCyyGuI11gu
	 0FvRNeMFQnqXAXfzQisDOWqVD03RcZfrmyJCFXQmdBmR5CgDFs+TBVc7CA+yu52ytA
	 KwSLbPK5O/IuqDJweBECi/FeB3lXGqmPbkCa7YnLoRQfk9BzYdwiU14YBVYRd5FMK/
	 luUILGiTGX3uoQlJhZS0LptCp5WTGCWxdtzDtlv1wu4QFLcIgMU+FTIH6pvPxFqlZZ
	 2TPSyH98mt5d0Y54NmXen1q2pEfodGGCiyAj/4523+UHoGgk6dHDs/MM2bD6EDcv7a
	 uvfrvwxcFLfdg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgv-3sqz;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] scripts/sphinx-pre-install: fix Archlinux PDF dependencies
Date: Thu, 21 Aug 2025 10:16:50 +0200
Message-ID: <574d902f7691861e18339217f42409850ee58791.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are some missing packages causing PDF build to fail on
Archlinux and add latexmk (from texlive-binextra package).

Yet, at least today, PDF builds are failing on a very late
stage, when trying to run xdvipdfmx:

	$ xdvipdfmx -E -o "peci.pdf"  "peci.xdv"
	xdvipdfmx:fatal: Unrecognized paper format: # Simply write the paper name. See man 1 paper and "paper --no-size --all" for possible values

Despite its message, even using a very simple document like:

        \def\sphinxdocclass{report}
	\documentclass[a4paper,11pt,english]{sphinxmanual}
	\begin{document}
	Test
	\end{document}

or even:

	\def\sphinxdocclass{report}
	\documentclass{sphinxmanual}
	\begin{document}
	Test
	\end{document}

Is causing xdvipdfmx to complain about geometry. As Archlinux is
a rolling release distro, maybe I got it on a bad day. So, let's
fix it in the hope that soon enough someone would fix the issues
there.

Such broken scenario happens with those packages installed:

texlive-basic 2025.2-1
texlive-bin 2025.2-1
texlive-binextra 2025.2-1
texlive-fontsrecommended 2025.2-1
texlive-langchinese 2025.2-1
texlive-langcjk 2025.2-1
texlive-latex 2025.2-1
texlive-latexextra 2025.2-1
texlive-latexrecommended 2025.2-1
texlive-pictures 2025.2-1
texlive-xetex 2025.2-1
python-docutils 1:0.21.2-3
python-sphinx 8.2.3-1
python-sphinx-alabaster-theme 1.0.0-4
python-sphinxcontrib-applehelp 2.0.0-3
python-sphinxcontrib-devhelp 2.0.0-4
python-sphinxcontrib-htmlhelp 2.1.0-3
python-sphinxcontrib-jsmath 1.0.1-19
python-sphinxcontrib-qthelp 2.0.0-3
python-sphinxcontrib-serializinghtml 2.0.0-3

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index c46d7b76f93c..954ed3dc0645 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -1048,7 +1048,12 @@ class SphinxDependencyChecker(MissingCheckers):
         }
 
         archlinux_tex_pkgs = [
+            "texlive-basic",
+            "texlive-binextra",
             "texlive-core",
+            "texlive-fontsrecommended",
+            "texlive-langchinese",
+            "texlive-langcjk",
             "texlive-latexextra",
             "ttf-dejavu",
         ]
-- 
2.50.1


