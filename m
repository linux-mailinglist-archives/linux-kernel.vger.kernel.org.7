Return-Path: <linux-kernel+bounces-765186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F5B22CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F9D681AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BEC2FD1CD;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1JpFD1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6852F83B0;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=Y+nczte71Gm+5l7x+7ygflcmC6aJTEW3OmXXQrFNpztIObqFajh7IueNRM8k61zXwDUQz6DMdHzz3tyR3ZTvW4H1z2wh0Nm+KMoaCjq48Ez/CXAi4Gsydlz3UaSekHfu104I7MRLnOOfTv38Zqob26fA7QQNe+pvsaXn1WCfCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=i0mHMu7j1L1UYsoNJE+5G4UPEMroTjEGJD+fY6oMYWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9l5ZhBX/r5DBM3pm+SlJVe5Co1ukmFmTU5ikAYbo5o4gY4uMhqP/0oA8iqDiykb8dY6uIMLiTjxEQML+FtShmnQBNWa2zPMCMrToPPyxbTiJ0OiRhAcguSNg9d8WsV8Q97ES79zbNtWhQswFBhSA8d1J3cHXdmhkkJZNkI5GQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1JpFD1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1541DC4AF48;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=i0mHMu7j1L1UYsoNJE+5G4UPEMroTjEGJD+fY6oMYWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1JpFD1itzwxGC7q+pJ8Cf5X8+RV3TFWbeiYNvZ/umZHmKcsespRuzjY6UBM8T7UY
	 YQRMycqSmiS0n/MlGpf9MnnkoxgRoX+bdnoe12EbfAmg0FEpWVHe7COwdMA+JPwc87
	 T1mXoTuILmE0cdmprEPYoy0QiVMdbNm07o9TdYfBPVCdJNChzE9fquZEpzBNr+BhID
	 RiGeE0a0FMkYl/eZwMmOA3hi9MUCKUXUp73TjI3PLuZp2UcujPVXuJRtrN4S7eSre0
	 qX8LgW4uf7YGAE17YDmOU6e6HFcZoBgkaz/WQ+0vByhUMTepyVzL6f8bN62Pc6KS/N
	 qpCm6FpYT9vgA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ9-00000006kXl-0n9X;
	Tue, 12 Aug 2025 17:53:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/39] scripts: sphinx-pre-install: some adjustments related to venv
Date: Tue, 12 Aug 2025 17:52:56 +0200
Message-ID: <e3a0e5eccd50eb506846e3e8487a2d9124ef83e2.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

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
 scripts/sphinx-pre-install | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 09a337509b23..b8474848df4e 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
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
2.50.1


