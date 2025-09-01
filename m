Return-Path: <linux-kernel+bounces-794809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A342B3E791
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9C417FA20
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D623469FC;
	Mon,  1 Sep 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMUR8Vup"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920F341673;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737758; cv=none; b=qayW7BCqb3SWyUFhber88ukomo73iNNL9w8kxV8yr1Ui0AdkYc5064fGPkoKLhHUpiTFazC1YI95cJPVtkFLrpuhOh+JsYcqVQBonwAvC+IGIGQ+E0MzK5FEcvDIkila8vmVqzAjI7anZ4fRdL0LXoWjOpREG3pe2zO1CTem8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737758; c=relaxed/simple;
	bh=DnuA31bWmX9+YzEEEgX8bB97MR2yK8G9WUM+iYdQ2WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TgUra8NAcZWDyZOeZD7xjNYa6eCXZdSk3KmTWeCKTgD7NkI0GCx1g/HiIXcxHZORt0ncdQW919j6aSt7OnI1Kme61k7RV+Ifpuuyj+USHbkMy4iOz0H5AII5BXsVt3IIKc1fhNVxb03N4H7etMKuLpGt47Eo3i0q95TJRWzM1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMUR8Vup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F1BC116D0;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737757;
	bh=DnuA31bWmX9+YzEEEgX8bB97MR2yK8G9WUM+iYdQ2WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMUR8VupiSaPDITBkbtcMpVGIRM3D+UkNhN39We+7dsJic/brm9COm+yDB9Zm2MmM
	 4WWjl4qgIxZ/g31dt6SFVp4410NA0oEQC68fI5JCGcUZ6LFt96W+L4mCU+1CZd+H1n
	 TXy08/nSnZ2hEIguVXO7krf5bcUn8R8Rr0DMkJ+OX1y7dSoqWy67VYr9txsaoclcAu
	 e/jGYGZom0tjMlskhm2Qipa+bz6L2qg/2u7wzqSCqWBNuMo3/xOKz9h88TILolN+Vx
	 zbnCGY3B/DTXHnayuaKPWm5ASYRzh/26HvXy4MCePEnHNzpiX4O8HCJ5xOeN6ncWWI
	 EI5xjykGoLZvQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut5jv-00000003G3s-3MWg;
	Mon, 01 Sep 2025 16:42:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/15] tools/docs,scripts: sphinx-*: prevent sphinx-build
  crashes
Date: Mon,  1 Sep 2025 16:42:28 +0200
Message-ID: <2a7abc2b8a488d77109226b76193bbc302078f95.1756737440.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756737440.git.mchehab+huawei@kernel.org>
References: <cover.1756737440.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On a properly set system, LANG and LC_ALL is always defined.=0D
However, some distros like Debian, Gentoo and their variants=0D
start with those undefioned.=0D
=0D
When Sphinx tries to set a locale with:=0D
=0D
	locale.setlocale(locale.LC_ALL, '')=0D
=0D
It raises an exception, making Sphinx fail. This is more likely=0D
to happen with test containers.=0D
=0D
Add a logic to detect and workaround such issue by setting=0D
locale to C.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 tools/docs/sphinx-build-wrapper | 11 +++++++++++=0D
 tools/docs/sphinx-pre-install   | 14 +++++++++++++-=0D
 2 files changed, 24 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrap=
per=0D
index 4e87584a92cd..580582a76c93 100755=0D
--- a/tools/docs/sphinx-build-wrapper=0D
+++ b/tools/docs/sphinx-build-wrapper=0D
@@ -45,6 +45,7 @@ the newer version.=0D
 """=0D
 =0D
 import argparse=0D
+import locale=0D
 import os=0D
 import shlex=0D
 import shutil=0D
@@ -439,6 +440,16 @@ class SphinxBuilder:=0D
         if not sphinxdirs:=0D
             sphinxdirs =3D os.environ.get("SPHINXDIRS", ".")=0D
 =0D
+        #=0D
+        # The sphinx-build tool has a bug: internally, it tries to set=0D
+        # locale with locale.setlocale(locale.LC_ALL, ''). This causes a=0D
+        # crash if language is not set. Detect and fix it.=0D
+        #=0D
+        try:=0D
+            locale.setlocale(locale.LC_ALL, '')=0D
+        except locale.Error:=0D
+            self.env["LC_ALL"] =3D "C"=0D
+=0D
         #=0D
         # sphinxdirs can be a list or a whitespace-separated string=0D
         #=0D
diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install=
=0D
index d6d673b7945c..663d4e2a3f57 100755=0D
--- a/tools/docs/sphinx-pre-install=0D
+++ b/tools/docs/sphinx-pre-install=0D
@@ -26,6 +26,7 @@ system pacage install is recommended.=0D
 """=0D
 =0D
 import argparse=0D
+import locale=0D
 import os=0D
 import re=0D
 import subprocess=0D
@@ -422,8 +423,19 @@ class MissingCheckers(AncillaryMethods):=0D
         """=0D
         Gets sphinx-build version.=0D
         """=0D
+        env =3D os.environ.copy()=0D
+=0D
+        # The sphinx-build tool has a bug: internally, it tries to set=0D
+        # locale with locale.setlocale(locale.LC_ALL, ''). This causes a=0D
+        # crash if language is not set. Detect and fix it.=0D
         try:=0D
-            result =3D self.run([cmd, "--version"],=0D
+            locale.setlocale(locale.LC_ALL, '')=0D
+        except Exception:=0D
+            env["LC_ALL"] =3D "C"=0D
+            env["LANG"] =3D "C"=0D
+=0D
+        try:=0D
+            result =3D self.run([cmd, "--version"], env=3Denv,=0D
                               stdout=3Dsubprocess.PIPE,=0D
                               stderr=3Dsubprocess.STDOUT,=0D
                               text=3DTrue, check=3DTrue)=0D
-- =0D
2.51.0=0D
=0D

