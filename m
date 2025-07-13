Return-Path: <linux-kernel+bounces-729128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A62B0321F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF9E3B7FBA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA327A44A;
	Sun, 13 Jul 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGaMq925"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BBE17A2EC;
	Sun, 13 Jul 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752424505; cv=none; b=q/x6cfxA7ASj8TIA5bRfVD5hufZpixmdiVvRGsEHGSyc+2t6rhg3Kmc9prqVupVb0iWSwRclIqbZdVDz1hpbgt6FEIbcR6NvAOZBGLqu1OnHZo1LyrcqHC1PwpZVKaL8CqCqbf8WkPwXt9/9hMegbKrnPGWriF4fFq+twQbhPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752424505; c=relaxed/simple;
	bh=Wx3/Ugp1PE6gQfK/orfJrD+E7Wj1KckD0qVUkrkgnWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffV60mYRn3DmFwrVmUBLnJdfzEt24jMUBOdg9yD05Ox4LyV1rtZaOdhXrOm2T5VaHA2smFTRxoJKD1JR7igeqd/70bx1SlJPgggxwcBPZxZb5Yonlrr+rB/O3kFB+Ez3zKO5HmZqt4YAlEdV7PBAW1RR7XDhYlEQmQ4vzik9yh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGaMq925; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so3740815b3a.0;
        Sun, 13 Jul 2025 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752424503; x=1753029303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dY9XOuYENfLx2Di4rM2clK1Msz1KBnfoQBOq3qV3zNo=;
        b=JGaMq9257hStA5LRX6DAyDXsdQv1aSUCeyMTX0I+LguVd+6sRSDG+aEap4tT/HQG4r
         Ki5bgTDV3ABaML9ddAjSFVseP6g5AgBAeRatu8Xi/zXonIMkOqE4JonM6dhHnd0JpS6A
         t3kVSlpy1E5YAz5UHEbP6NxaSUN2lM1SBfJcekohsKSh+JGyW+h/JmYpmd26d0P/aFqk
         mZTYryl+p9QqbNh6Cy10UwjenOcz3TQ2fgV5Kh/f7CyWfz5WkADj+HKQYGLYgZQkV3wQ
         9f5xO9Ca8d5ByR40RGZqgVU4bT3ZfKQLk95vCKdZi2Y8PsgQoYGyDAHvMFqCtnorbsCy
         7zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752424503; x=1753029303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dY9XOuYENfLx2Di4rM2clK1Msz1KBnfoQBOq3qV3zNo=;
        b=AOtzlhQ6gP+0fvw6+7uWU2HvWlJJmTbWSH9Z4fjpzFxR5bLgBeqJoX9eTW7hAanbzl
         nhwk8RdxpNuR9uojRZ7rHR1JHLeBL9MuqohBf7E9PfxIPKm82ngnCe2yp9Zx+LctRBSm
         nCuh9DkJq5hsm/dHr71eF1vEOJ0P7ildPCrb8Bhcss/nYvT12X/ZclGEr+BTvpk8okpO
         cBPEcCJQhpwbUjI8ZjlDyJl/+KB+milL0nBQh9qp2K6kpaQdYbL01z1Rc57yY70oXYdJ
         50g+HcDKFxtyFtMSfYgOZeLsST4A/P7u36rvJThoqFcblnIMLHEJH6n0ZmAjDN3XGTvX
         hEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwtxxuI1LjgMM/xlJ1jTw2NtQZLncCz+CWOCxsz6FhFKVdhnXRPgK7TbqkSgBzyYSFegO/JDVLE9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDgmtxp4KrhY5kN8f/PHHTv3hMrhAeO4q8knROlKHfaRRaLuO
	w8DcHsBeKTS4CmCk8M5d89BrwcGnNU+UZL7UPt3AaHO8HWj1n0I41g4P
X-Gm-Gg: ASbGncuWJI/svKviHkL1tCXOpgxi9wtExPNtckqm/JVczrYA3yMUWSBsh3x6y3z75Xd
	IXdZ34NS30+ciwkJIFouNw9VlQpyI45kpPp76kqx3jBt+ovKsKWx32kl912Nc85runjyoxQzsMG
	trrI+PNxbREMR+GGoVpf9Pd0EcGU+/5BNy3TXgqi5vDHrwkJ2ObCg7m4T8tysexwVO9GscOZMYb
	gx6sUNLCakFR/0vA1EyIPR39I9p+ZG0jEwJEG3yTAukxppN8jphWLoR6Yztzs9hCB0h81PZDLu6
	1XqOX6qNmrZVg3G2kI5HWbXnAMFtHs1EWfcd8e088upBGXjoVLiZVdXM46niJcJyljA9k5ME7kM
	kR27qFT94fU27sue2ynt1jvqyo76vd6HkXo49goP+Ir1aaXSSph+0PmuWP6q8aFi7fDDcYw==
X-Google-Smtp-Source: AGHT+IGNeMQj3tpu4L38r4CwZWt7NeEWUfmFN2WhzAQSsjvalG5h82vTkC1mCCtHHMDwgwsf4GFkxg==
X-Received: by 2002:a05:6a21:9206:b0:231:c73:7a76 with SMTP id adf61e73a8af0-23124f1a6ebmr16831708637.2.1752424502450;
        Sun, 13 Jul 2025 09:35:02 -0700 (PDT)
Received: from localhost.localdomain ([159.226.94.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b715sm9007424b3a.93.2025.07.13.09.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:35:02 -0700 (PDT)
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
To: dzm91@hust.edu.cn,
	corbet@lwn.net,
	si.yanteng@linux.dev,
	zhiyuzhang999@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] scripts: add origin commit identification based on specific patterns
Date: Mon, 14 Jul 2025 00:34:18 +0800
Message-Id: <20250713163418.1459-1-zhiyuzhang999@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the functionability to smartly identify origin commit
of the translation by matching the following patterns in commit log:
1) update to commit HASH
2) Update the translation through commit HASH
If no such pattern is found, script will obey the original workflow.

Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
 scripts/checktransupdate.py | 38 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
index 578c3fecfdfd..e39529e46c3d 100755
--- a/scripts/checktransupdate.py
+++ b/scripts/checktransupdate.py
@@ -24,6 +24,7 @@ commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
 """
 
 import os
+import re
 import time
 import logging
 from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalAction
@@ -69,6 +70,38 @@ def get_origin_from_trans(origin_path, t_from_head):
     return o_from_t
 
 
+def get_origin_from_trans_smartly(origin_path, t_from_head):
+    """Get the latest origin commit from the formatted translation commit:
+    (1) update to commit HASH (TITLE)
+    (2) Update the translation through commit HASH (TITLE)
+    """
+    # catch flag for 12-bit commit hash
+    HASH = r'([0-9a-f]{12})'
+    # pattern 1: contains "update to commit HASH"
+    pat_update_to = re.compile(rf'update to commit {HASH}')
+    # pattern 2: contains "Update the translation through commit HASH"
+    pat_update_translation = re.compile(rf'Update the translation through commit {HASH}')
+
+    origin_commit_hash = None
+    for line in t_from_head["message"]:
+        # check if the line matches the first pattern
+        match = pat_update_to.search(line)
+        if match:
+            origin_commit_hash = match.group(1)
+            break
+        # check if the line matches the second pattern
+        match = pat_update_translation.search(line)
+        if match:
+            origin_commit_hash = match.group(1)
+            break
+    if origin_commit_hash is None:
+        return None
+    o_from_t = get_latest_commit_from(origin_path, origin_commit_hash)
+    if o_from_t is not None:
+        logging.debug("tracked origin commit id: %s", o_from_t["hash"])
+    return o_from_t
+
+
 def get_commits_count_between(opath, commit1, commit2):
     """Get the commits count between two commits for the specified file"""
     command = f"git log --pretty=format:%H {commit1}...{commit2} -- {opath}"
@@ -108,7 +141,10 @@ def check_per_file(file_path):
         logging.error("Cannot find the latest commit for %s", file_path)
         return
 
-    o_from_t = get_origin_from_trans(opath, t_from_head)
+    o_from_t = get_origin_from_trans_smartly(opath, t_from_head)
+    # notice, o_from_t from get_*_smartly() is always more accurate than from get_*()
+    if o_from_t is None:
+        o_from_t = get_origin_from_trans(opath, t_from_head)
 
     if o_from_t is None:
         logging.error("Error: Cannot find the latest origin commit for %s", file_path)
-- 
2.34.1


