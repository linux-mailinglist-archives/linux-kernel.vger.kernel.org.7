Return-Path: <linux-kernel+bounces-723774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CAFAFEB02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821D04A6EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2FC2E8E1F;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo+SIy/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660652E5419;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=IWT/lmBehPCZB/Ik9tKLP0gLgX65B/OLTQJDgGKWySpI2JxHaccwJUsqd2ublutjcLlE/5aMplwXCPlZoUlbWL6BKXJQhHwas6JhOFj3eMH83gGp6B/5CnGkDadNmCJynYGVFuLgs0gsnIB45I0xz7/YrRQoUBnN3SeqZ11v38I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=1NNB7gvudOACbmFoNoa5MHvLv/Y1IWD4ssO//Nr19dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oE/bQF3LkOP3ifSC5UbeD5F1j6cYNOH4om7oWiIeJ+Ya7Q2Nzy0VYSHESeb5U1C+9IX62vlm2IPYT+2sIxyeuDTeHxookbpdiN3TrfhPcPnQnsYFUYLm/ItAvT56Ual+e6CSHzgnDTEa2JA6jiunabi940HcWDso8OwXAGW7rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo+SIy/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73D6C4CEFB;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=1NNB7gvudOACbmFoNoa5MHvLv/Y1IWD4ssO//Nr19dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo+SIy/JW9pFpIida6GdXE7DnwVvDLh11HHYo6Fik7SyLLXsf1ubXxVFG84HpFifh
	 c54nLnJ55KP34kodg7BgGJyW1/OgOLfNQzWLwkgYE28vLpUUGmpCVvsWJimUqsR2xQ
	 yj4JWGyMbK5X6iyNPRj9s0kBTO60+jxkvMTTpsN099XAL2K0+g1ECT7EoA8ttAIheC
	 EG/crTNObduUw6idql8zoFj9CEup7yQ3/IFpWC5cdbafOJkN4xGp/kdar0gapn0eah
	 i6W/x37sBSuUNoVoKCj4dp0DWMiFOqvdSxnaeEK/L5KUbmO1xf/eCKYwVxyoDsRJZM
	 BAtZ1euB+GJIA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECO-19WG;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/39] scripts: sphinx-pre-install: drop obsolete routines
Date: Wed,  9 Jul 2025 15:51:38 +0200
Message-ID: <ac2f69d35ba80e2c41a12aef7431f159cdc632ad.1752067814.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 3912359d2bae..b639acd455cc 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -114,27 +114,6 @@ class SphinxDependencyChecker:
 
         return None
 
-    @staticmethod
-    def find_python_no_venv():
-        # FIXME: does it makes sense now that this script is in Python?
-
-        result = SphinxDependencyChecker.run(["pwd"], capture_output=True,
-                                             text=True)
-        cur_dir = result.stdout.strip()
-
-        python_names = ["python3", "python"]
-
-        for d in os.environ.get("PATH", "").split(":"):
-            if f"{cur_dir}/sphinx" in d:
-                continue
-
-            for p in python_names:
-                if os.access(os.path.join(d, p), os.X_OK):
-                    return os.path.join(d, p)
-
-        # Python not found at the PATH
-        return python_names[-1]
-
     @staticmethod
     def get_python_version(cmd):
 
@@ -940,7 +919,7 @@ class SphinxDependencyChecker:
         else:
             print("\nSphinx needs to be installed either:\n1) via pip/pypi with:\n")
 
-        self.python_cmd = self.find_python_no_venv()
+        self.python_cmd = os.path.abspath(sys.argv[0])
 
         print(f"\t{virtualenv_cmd} {self.virtenv_dir}")
         print(f"\t. {self.virtenv_dir}/bin/activate")
-- 
2.49.0


