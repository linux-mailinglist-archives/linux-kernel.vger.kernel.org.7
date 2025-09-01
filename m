Return-Path: <linux-kernel+bounces-794946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA870B3EB32
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AE71B2539E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A82E6CB1;
	Mon,  1 Sep 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms/97Nrm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00822DF125;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740837; cv=none; b=ndzrDtGfyFVrb/vudsxoA7pUDRLbeq1CSUC6BiyqTkQtavWclQEPQ4s0/kjsAPogi3Et1wVS/E/7OVuVGnmc3QTOUdcRJc7zvwDYh0ajN4YbmhJQC55knfwbgEXW3Lvg3Dm0MSTbHY5rafiwshCDJoPnw7gwb0XF8yK4yfVXbqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740837; c=relaxed/simple;
	bh=4uJOao0piUiPHNvIVuXmCv5lmjFUgA59dFcKkl3BP8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mmvy98+ZqZXoUoMkO4/L+loyAfv6xSgjYYgn7TBLtym/r3vz+GLTsUc6vWdyNxDHmA5NH2haWPR0fGUqzB1QuVoA+IfRmlw3CZr04cW2rdrxenNXt+TEEOvnGZy+pzz1cXgiODlZ2tNrfsp+HlfwOImEubpYesStHVmhIs61R90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms/97Nrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CB2C4CEF4;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740837;
	bh=4uJOao0piUiPHNvIVuXmCv5lmjFUgA59dFcKkl3BP8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ms/97NrmJILJ7lCh3+z2gGjLLg0lVPT+oaLpmjraN/yd3G/whQPbm7GpEfx5ovksw
	 orFf7hI/Zyxv+wyyZMDCW4KHrjN8TdzyKNo/VrEdHcIIrk01DyOKyUMVXzRvk/D1ea
	 +vUBRvE6YrdXsq6mMvNCEmt0aAj8WRNSc7gZcJKT22EATtW/gRiqKrNXU3hyKuO+0k
	 YF0crVP/YhfuFr+SpsY555xXRbSp50hJkWIk/N6u6bjDn+nsoHtlQyR7xEHieRvC42
	 RLZPaRvk5lEnwOe2vkWhAXWEz9ITuMVFZXnDzrCvXOpvSOWm7GIRzkLV3GdMK/bPV8
	 HrzKqvxgMMWrA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut6Xb-00000003HLm-2Lxu;
	Mon, 01 Sep 2025 17:33:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 03/15] scripts/jobserver-exec: add a help message
Date: Mon,  1 Sep 2025 17:33:38 +0200
Message-ID: <b8a8ce928094f059f0cb3a075aa53a71ad043618.1756740314.git.mchehab+huawei@kernel.org>
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

Currently, calling it without an argument shows an ugly error=0D
message. Instead, print a message using pythondoc as description.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 scripts/jobserver-exec | 22 +++++++++++++---------=0D
 1 file changed, 13 insertions(+), 9 deletions(-)=0D
=0D
diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec=0D
index 40a0f0058733..ae23afd344ec 100755=0D
--- a/scripts/jobserver-exec=0D
+++ b/scripts/jobserver-exec=0D
@@ -1,6 +1,15 @@=0D
 #!/usr/bin/env python3=0D
 # SPDX-License-Identifier: GPL-2.0+=0D
 =0D
+"""=0D
+Determines how many parallel tasks "make" is expecting, as it is=0D
+not exposed via any special variables, reserves them all, runs a subproces=
s=0D
+with PARALLELISM environment variable set, and releases the jobs back agai=
n.=0D
+=0D
+See:=0D
+    https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.htm=
l#POSIX-Jobserver=0D
+"""=0D
+=0D
 import os=0D
 import sys=0D
 =0D
@@ -12,17 +21,12 @@ sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))=0D
 from jobserver import JobserverExec                  # pylint: disable=3DC=
0415=0D
 =0D
 =0D
-"""=0D
-Determines how many parallel tasks "make" is expecting, as it is=0D
-not exposed via an special variables, reserves them all, runs a subprocess=
=0D
-with PARALLELISM environment variable set, and releases the jobs back agai=
n.=0D
-=0D
-See:=0D
-    https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.htm=
l#POSIX-Jobserver=0D
-"""=0D
-=0D
 def main():=0D
     """Main program"""=0D
+    if len(sys.argv) < 2:=0D
+        name =3D os.path.basename(__file__)=0D
+        sys.exit("usage: " + name +" command [args ...]\n" + __doc__)=0D
+=0D
     with JobserverExec() as jobserver:=0D
         jobserver.run(sys.argv[1:])=0D
 =0D
-- =0D
2.51.0=0D
=0D

