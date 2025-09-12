Return-Path: <linux-kernel+bounces-814257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EDB5518B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90543A535A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9D6320A2F;
	Fri, 12 Sep 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6Sz+Abn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C931AF2E;
	Fri, 12 Sep 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687250; cv=none; b=IDFftByF/qB3CHqv2wv8/berqJAYwAUpBd7+W6CszEl4/io6YftQ+8grOfQjaGaVBmbcaS7NFfTn9yWAextZUbGfo+i3zzxF2laF+gpMMDjtF6GqiPr0W8dmYE/s2AAZ7EQVGzU5/ksm3enRoLznV0mw0dy6St+DwqPwUjWLbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687250; c=relaxed/simple;
	bh=+vR2LJGLDy8UnwSz3eUgz28ph+DI44nRr8Bevp/r3nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c3ettdTKbQ5+qsNwrbxtsfsvhta6DNBQdB0x0FqXB4SCex56EzOzNQ4QRbm243nHjQx1T4at5V8YpzTQaGd5m12ET3HuwUX/VzggnnNUq0qd87g0VdtTwZR7S9r5yY0UAhHet0KSF35F4DAWMWoGuvYnyU/YknSwCnkDJt8hHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6Sz+Abn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A357C4CEF5;
	Fri, 12 Sep 2025 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687250;
	bh=+vR2LJGLDy8UnwSz3eUgz28ph+DI44nRr8Bevp/r3nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6Sz+AbnPH43VtdLaOyL9qxT64MjgWKg9h66MPBtZ+4m++KxeHue1lpOgtnI6JVML
	 Rx13UOxoiEPF5f0FBw8wcOIM05R+ut0NgUqZo8BvKL0smjno2fYkZfeCkTPpqEX1nd
	 ZJXTcGXX06rvaddJfPynPe085ryrx2mIlka+8EqJAIrm8bRgXz1j+XBk5sggx4PieQ
	 111C+ybf4X03kQGyG1BEohGk3DYhXryusEdMr/DtREiFDkH2fK1Smx1XglAwvNp+a9
	 axOcAloR+Fh4skumKDkYXbG0W+IfPRgDRHfbZUTfMssssZVCjmAbs/VMBCyQwD794B
	 jk9An8hxfyVHA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux4kK-00000008VrR-1RN9;
	Fri, 12 Sep 2025 16:27:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tools/docs: sphinx-build-wrapper: warn about broken PDF fonts
Date: Fri, 12 Sep 2025 16:27:22 +0200
Message-ID: <0e7b63016b5493b21c011fe66639b770b2b8f25e.1757685692.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757685692.git.mchehab+huawei@kernel.org>
References: <cover.1757685692.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Depending on the latex install environment, translations can
be broken because of CJK variable fonts. Add a warning in
the end.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index c47f723391b9..d40fc25071c6 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -54,10 +54,11 @@ import subprocess
 import sys
 
 from concurrent import futures
-
-from lib.python_version import PythonVersion
 from glob import glob
 
+from lib.python_version import PythonVersion
+from lib.latex_fonts import LatexFontChecker
+
 LIB_DIR = "../../scripts/lib"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
@@ -476,6 +477,10 @@ class SphinxBuilder:
         print()
 
         if build_failed:
+            msg = LatexFontChecker().check()
+            if msg:
+                print(msg)
+
             sys.exit("PDF build failed: not all PDF files were created.")
         else:
             print("All PDF files were built.")
-- 
2.50.1


