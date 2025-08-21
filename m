Return-Path: <linux-kernel+bounces-779270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7146B2F18C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560F31CE08FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC92FD1CA;
	Thu, 21 Aug 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAc78K0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F172EB85D;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764224; cv=none; b=X6+3fpqq8cjccWKCMgxZehEsArr8fDLiNXpxjAGjlYSV0/EZJiVJGl6d6CugzesUGcuZq3rirSPEqN7ENG4IgktxmbGcTIJfPwCxBVeBx79ANVXTBZmR0Q91sLXX2DJ7eTokkaYc1ZyXxM8hcTTAPSzQeuQ+7od+dnvHTKRauos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764224; c=relaxed/simple;
	bh=TuZzM907xB+KTOv4gNdoJ0KIyd5sboPQJN60CO9pPLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILmAUjDez8XVfC5ODUtPLcDGBjvu3Nq5RTdQM+wMjjQCGd2cfAgQS594I0Hts38XIAV7kOPIBp9UCeAGO5RrtG8si6Lg6QR0Tj42McXaQtlnhjhpkMFHMNuocYAWToc3i13SfzPoivi8/3CjNyOR28u7dT54It6tiGIJBSCuI5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAc78K0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73992C19421;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=TuZzM907xB+KTOv4gNdoJ0KIyd5sboPQJN60CO9pPLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAc78K0n906bqvlnrznWY63kjBqp5ET2aODKVPx+m94hCUANr5sZ5HOHk4aHLI/ug
	 QUeI96V5wpT+vYRSuSsTYA93xSO8D64TlkFFHYjfaMWTz2OHHmlT63aLBZy2pB9rMI
	 VSI6aDy9ldaLz796clBKyd9JjDbmHwurmDnWKJ0BNvRQs9WFz5uqhNidBIVPa3mcwa
	 ojUMchYqigcKMbdOGjauuFoClYFvwfz17zUmUNh7a/Exd1Merde9xDxRDtqeHtxyHo
	 LR7TNUop1yha9QUK66F/7AyrRPjevLXOW59EOtnPt2PIgg3CxpSw+QUqlsBw9ermjL
	 wsTJ0x8jbSsWA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgT-34TO;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] docs: conf.py: extra cleanups and fixes
Date: Thu, 21 Aug 2025 10:16:43 +0200
Message-ID: <08d16c2ad817910eb5606842f776d3f77d83282f.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Makes it more adehent with modern Sphinx LaTeX build setup as
defined at:

	https://www.sphinx-doc.org/en/master/latex.html

There, it suggests:

1) to add: 'printindex'

    “printindex” call, the last thing in the file. Override if you want to generate
    the index differently, append some content after the index, or change the font.
    As LaTeX uses two-column mode for the index it is often advisable to set this
    key to r'\footnotesize\raggedright\printindex'.

This indeed solved a corner case on a distro where the index was not properly
generated.

2) to add at the main example:
         \PassOptionsToPackage{svgnames}{xcolor}

3) I got a corner case on one of the distros was using xindy to produce
   indexes. This ended causing the build logic to incorretly try to use
   T1 fontenc, which is not UTF-8 compatible.

   This patch adds:

        \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}

   to cover such case. It should be noticed that, as the config doesn't
   have \usepackage{xindy}, this will be used only if latexmk ends
   using xindy.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 5888e2988b4f..1c4695727208 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -456,8 +456,15 @@ htmlhelp_basename = "TheLinuxKerneldoc"
 latex_elements = {
     # The paper size ('letterpaper' or 'a4paper').
     "papersize": "a4paper",
+    "passoptionstopackages": dedent(r"""
+        \PassOptionsToPackage{svgnames}{xcolor}
+        % Avoid encoding troubles when creating indexes
+        \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
+    """),
     # The font size ('10pt', '11pt' or '12pt').
     "pointsize": "11pt",
+    # Needed to generate a .ind file
+    "printindex": r"\footnotesize\raggedright\printindex",
     # Latex figure (float) alignment
     # 'figure_align': 'htbp',
     # Don't mangle with UTF-8 chars
-- 
2.50.1


