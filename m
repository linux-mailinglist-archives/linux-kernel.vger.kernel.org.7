Return-Path: <linux-kernel+bounces-761503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C626FB1FB04
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C8C178A2A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6855D1D5CE8;
	Sun, 10 Aug 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb4LRBnq"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9E1C683
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754842660; cv=none; b=Ueb8GUbmdt3SjqSY8w6mGWi5siwIgxcxfpexpYZvYedkkXTtoOSszoHcV8aPvUXo16Fee/Hw+nYkfMDHhKWV2c3+N42KxErXKgAXu0nuWuzICfpOfozixLOf27D7O994rrPJch9aZvW5M991O7zUb7B0UHzCco4ulKp2RCd7DHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754842660; c=relaxed/simple;
	bh=r+/tz4wOk7S63KAYEOx9vULkKR8ZDVGPGskKkBYlZWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2SkHNdl9WeSP4N9bAMUWBPhfL5uYFoF//EsH2MtA9e7ZBx0c/eruI+3dC6wV6P/VgmEoY+lHnX86xE5GiaoqIagHueEL/Z04Bo8YEI0zsjW+qoMCN668YicslIPu8XgxKdwsW8P6X/1vWOca1IokFJAgzEr1teH4r4VnvKqpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb4LRBnq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bdea88e12so3096344b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754842656; x=1755447456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dEAJER69/NfwAiGupTfaKK2jAZ45McqgSZlh8HSXymw=;
        b=gb4LRBnqdr5mOvEM9bsoBtKBoTPEtuGLhdBxTrrtCHJ4KgggdqIkJUnfrC6NCxpGzx
         Nf/AkTnjDfvQu360S6FvROj3kIc3GTNFrJ0IJQaWj1jCU6tpSMHfKDUHrTWwOxWMuS6u
         /9dCXl5yrgKU1LBCvJUS/MrDYBOAJhOcmnPvoeJ5iib9dijDx/BPc290Dw2SrRt8sSA0
         pBp1/8Q8HmbRSxwDdKkSpI6QufHDAkQGBYOpLE8HD5atB2PfoINIM9w+rnIZrYuIMx7c
         GS2fp3+RWZXjWyieSFB1eDAcYVCaMmZta9WGa07dDPITrTLlooGN60O3fBhuazak1zVB
         w8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754842656; x=1755447456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEAJER69/NfwAiGupTfaKK2jAZ45McqgSZlh8HSXymw=;
        b=tDLmpdth+pwmdddgYP6CrKZhsgZpD+pRdYgp8/ZS3WZZ1vbujFfgLHcZsZKQ1gCQDE
         NmvwQ+QdXCICCmVaeaMeU88pqeYSl52RYt8Y3tIBhika+KVppRyptXDi7EOWCx2Mr/MW
         mxM5fbKHhcXXwoddrb/jtuV3ZTfG5/C016BujAhA31sCC9hGqgn3xowm+3hCW6KuhQXF
         68pAG0SfKl7DAW5Jj2sCL9vhkl0VXwDtBp6gux8gQSdFZL5HqsH1IBPEETSPOUzkH9Vd
         zhH8xsrMAk8r1pTa0MZgLHRFcH2MZO2pNxueF0vyl3eGLJ5yoK74X1BYYFOz2UKl4x0M
         /UOw==
X-Forwarded-Encrypted: i=1; AJvYcCX7z9WQqFzL7myMAB4geXM3r5CYiIS+Rv/gBihedXnH3CsWqmxES1+SGRQpHhk5NKCpp2KILrMLkZh8IV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7oNY1gJLiyKrzZLccoG5uDtsAOZrCUxwU/4VEflxbbVrwntP
	WEk6L3ePCPw7zwTg3B9SuyAsESiQP+ykK1u8ThA8io2FVEiFWmA6Q0PC
X-Gm-Gg: ASbGncvcGF7+pZtz8/roWBsOad/lS6m40bTCkgAKKNV0QpnEKQ1sgap8cnr7VKw+ndQ
	ugQ1SgxNLKSnkPqnSb4xmGfLMlTaLOPwPBQahbBLtt6wIs/MeTdG1oyB8bMWytbWmcaIsU02t+K
	yU4ODsV9yqNFZfKPveN1OcPKl5/x9MGt0/2zeT4p4pJ7pBgoaWtUZAT+jsdHKu7k2kAwQlHCnj3
	2J8CGEPrf5gy7GFIGuR00m2oonfq6K9AWL3w9JuWJ0bJB8uVFuhFWNRgq1xmFTg3q/s3vbiVNYg
	87eWE2vKcFaWzGet7/kmKpciwjXhtI9FZcJH9+C+flq7fx7IPkesepivBrx7JOgEYGJ6FMQ8DTH
	oSnULD8FwTvpWckN4FnnBxQFhMgmut1ROjxBM5oTRjwrhW/CEyQcAMA1TQ7I9TNWLt1UmVTDhdW
	Tf
X-Google-Smtp-Source: AGHT+IGaneADRRWLQHrxVro1KG5pLemoUIgsHzCDalyypmDxM0LYn3Wt757/XYCwlglY3qEq1dRvcQ==
X-Received: by 2002:a05:6a00:b44:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-76c461784fcmr14689584b3a.19.1754842656447;
        Sun, 10 Aug 2025 09:17:36 -0700 (PDT)
Received: from localhost.localdomain (wf122-104.ust.hk. [175.159.122.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdd2725c9sm22495944b3a.6.2025.08.10.09.17.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 Aug 2025 09:17:36 -0700 (PDT)
From: Haoyang LIU <tttturtleruss@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com,
	Haoyang LIU <tttturtleruss@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] scripts/checktransupdate.py: add support for scanning directory
Date: Mon, 11 Aug 2025 00:17:30 +0800
Message-ID: <20250810161730.6530-1-tttturtleruss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Origin script can only accept a file as parameter, this commit enables
it to scan a directory.

Usage example:
./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools

Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
---
 scripts/checktransupdate.py | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
index e39529e46c3d..0d197d036650 100755
--- a/scripts/checktransupdate.py
+++ b/scripts/checktransupdate.py
@@ -13,6 +13,8 @@ The usage is as follows:
 This will print all the files that need to be updated or translated in the zh_CN locale.
 - ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
 This will only print the status of the specified file.
+- ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools
+This will print all the files in the specified folder and its subfolders.
 
 The output is something like:
 Documentation/dev-tools/kfence.rst
@@ -21,6 +23,17 @@ No translation in the locale of zh_CN
 Documentation/translations/zh_CN/dev-tools/testing-overview.rst
 commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
 1 commits needs resolving in total
+
+Documentation/translations/zh_CN/dev-tools/index.rst
+commit d5af79c05e93 ("Documentation: move dev-tools debugging files to process/debugging/")
+commit d5dc95836147 ("kbuild: Add Propeller configuration for kernel build")
+commit 315ad8780a12 ("kbuild: Add AutoFDO support for Clang build")
+3 commits needs resolving in total
+
+Documentation/translations/zh_CN/dev-tools/kcsan.rst
+commit b37221cc861d ("Documentation: kcsan: fix "Plain Accesses and Data Races" URL in kcsan.rst")
+commit 72ffee678f6f ("docs: update dev-tools/kcsan.rst url about KTSAN")
+2 commits needs resolving in total
 """
 
 import os
@@ -131,7 +144,7 @@ def check_per_file(file_path):
     opath = get_origin_path(file_path)
 
     if not os.path.isfile(opath):
-        logging.error("Cannot find the origin path for {file_path}")
+        logging.error(f"Cannot find the origin path for {file_path}")
         return
 
     o_from_head = get_latest_commit_from(opath, "HEAD")
@@ -293,6 +306,17 @@ def main():
                 if args.print_missing_translations:
                     logging.info(os.path.relpath(os.path.abspath(file), linux_path))
                     logging.info("No translation in the locale of %s\n", args.locale)
+    else:
+        # check if the files are directories or files
+        new_files = []
+        for file in files:
+            if os.path.isfile(file):
+                new_files.append(file)
+            elif os.path.isdir(file):
+                # for directories, list all files in the directory and its subfolders
+                new_files.extend(list_files_with_excluding_folders(
+                    file, [], "rst"))
+        files = new_files
 
     files = list(map(lambda x: os.path.relpath(os.path.abspath(x), linux_path), files))
 
-- 
2.50.1


