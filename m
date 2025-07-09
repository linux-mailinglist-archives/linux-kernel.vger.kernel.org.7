Return-Path: <linux-kernel+bounces-723772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B11BAFEAFE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37122188942C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF172E8E04;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9wANGiS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF62E3AF9;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=SWfwJ7iM5ccvreb03QMAt03RjNXSAgniWEHIYGGgJyAm+VfcyBup171d3NSU3e5I4wdfpHTjXa/dhNiK9YVf5XmLlI7F+fmC2HlZ2RRbxXbu+9L3rzrONUAAC9Y9x39IZA+AwoujHN6T+rrhLkT8c7sMSqHsi/pIoflFINuvsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=Qa0I6IanQu0oRpZuMvSwsgCMF5vqUA+cZZbiygIZvmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYA1XqqlSGWrJpKTIG6aoy85rP/OKvPTa8NDWeETFJspi8QxWPCXaKeEqQq5rXS3ZimiefmfISNQ3mSfqvX+wUNoCJzQL7qopnPGy5XzfOFH1P0vMMac1SDbuVlhmqE6XY0O4AjlEOS3nL6j6/lsXSJlfGjQ5G7jdDJaPAspfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9wANGiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B9CC2BCB5;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=Qa0I6IanQu0oRpZuMvSwsgCMF5vqUA+cZZbiygIZvmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9wANGiSjzurF35NNxyLbzbwmIgKQvw9uVgRjPgVxHp3fT7erhC5sMMwn6lJh9Oxo
	 K73NMr8PVjUfjkx/VX3C5Tbea83uoAOoeuxhEb662wCB9IM4sD+BlL6Bx0UyRqpMHR
	 +83Vv5/h4uqeEYw5VAVlpBtsntVAhoZdkUS5T2vNdTE8ulPCTOZRchKbWD8jhgBlU3
	 Y+7sGWbbKgpQJalJ0Pi9ttSJKaNshe/oGeEcS51ng35DS8XMygqTNlQNw6N2e02DWb
	 fMohIbZ6PKJ98iv5ZijzfxTBUysUQEJb0LT5YH6MRs2fGJKm31uSfs1zTfbgt+MGZG
	 DrgDaOUhFaY9Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDv-3myg;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/39] scripts: sphinx-pre-install: some adjustments related to venv
Date: Wed,  9 Jul 2025 15:52:09 +0200
Message-ID: <7a83f92a31e38452ac191e5bc56be8d4bcc48495.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

While nothing was really needed for virtualenv to work on most
distros, we had an issue with OpenMandriva.

While checking for it, it was noticed that there was no check if
python-virtualenv was installed.

This didn't solve the issues we faced there: at least with
the half-broken OpenMandriva Lx 4.0 docker container we used,
ensurepip was not available anywhere, causing venv to fail.

Add a distro-specific note about that.

Note: at least at the time we did our tests, OpenMandriva Lx 4.0
docker was shipped with wrong dnf repositories. Also, there
was no repos available for it anymore. So, we had to do some
hacks to upgrade to 4.3 before being able to run any tests.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 09a337509b23..b8474848df4e 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -983,6 +983,22 @@ class SphinxDependencyChecker(MissingCheckers):
             # Tested on OpenMandriva Lx 4.3
             progs["convert"] = "imagemagick"
             progs["yaml"] = "python-pyyaml"
+            progs["python-virtualenv"] = "python-virtualenv"
+            progs["python-sphinx"] = "python-sphinx"
+
+            self.check_program("python-virtualenv", DepManager.PYTHON_MANDATORY)
+
+            # On my tests with openMandriva LX 4.0 docker image, upgraded
+            # to 4.3, python-virtualenv package is broken: it is missing
+            # ensurepip. Without it, the alternative would be to run:
+            # python3 -m venv --without-pip ~/sphinx_latest, but running
+            # pip there won't install sphinx at venv.
+            #
+            # Add a note about that.
+
+            if not self.distro_msg:
+                self.distro_msg = \
+                    "Note: for venv, ensurepip could be broken, preventing its install method."
 
         else:
             packager_cmd = "urpmi"
-- 
2.49.0


