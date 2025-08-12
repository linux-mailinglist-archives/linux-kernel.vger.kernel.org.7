Return-Path: <linux-kernel+bounces-765163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2517B22C83
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEFB622063
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B8F2F83DB;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdCHPJDE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B82F659F;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=oGFjv1H0hVFmT2DlIeAORTi68GQBeMN7n1DzOcIpDgNMXKqyBQfBbY8gTBgCZ6fOIVb1Vig5k/ocF2SLStXVsTWqu6XJIaHwlTcPg0SGlEM52nW+s+Bi6Rx/ASGf9CJBASuVFKdJEVBzR4O9PGHBaHYda1aW5JWxM2m0Wt1QArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=pGT/dJ53lsh8VHk2ntlH7KrRTKY2+y+5ODEQAIhvyXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cL5x5fU2zgV+dgnac80+sLcfmetQM8mv50nt1pK712uY01EkuCBQnG8j76M1IrTHdXVtV8wpZ9Jlc3u0RBDnan6c3nFyGkqBYJHP4WjsqD0w4CMMZzLQPgJHkriTtN8+zpX43HNtvZ276Y+mSb/iCTQmr5kbDJAx1Nw4SLoRcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdCHPJDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8160C4CEF1;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=pGT/dJ53lsh8VHk2ntlH7KrRTKY2+y+5ODEQAIhvyXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdCHPJDEq60dZomyyc7UglZUBwAT7hWQlGJg4fyUJyANhZP4GL8+amPtylK9J01y6
	 SZJHogBtUhXpvZdMyb9Mfwp3mrjgZs2fiBXmuanJ3HHhz0CvLshEZzjZKi7GNLowYD
	 Kabxs0TahdWWlNaWGShOPiw++Gmsut7QgINjMSLHnvs2qzOTKrC1AH2EyV54Mbq9Mi
	 A+ZRw96BfMPhFFuwCx60HiYOjX6ochlrNwxCHE8xkaxbfmpIAJsLT69TbdHy0WpQbx
	 EdLNncMpbVzLHJb4uUBcgLuqjZLFrQ0Vcs70xDKO5SC5+JtHUHMD/RADdLah1g8vnq
	 8BknR7sADB8lg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVa-0yT2;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/39] scripts: sphinx-pre-install: drop obsolete routines
Date: Tue, 12 Aug 2025 17:52:23 +0200
Message-ID: <afb97854f05b0852f4c6c1fcee102e9697c14cd8.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


