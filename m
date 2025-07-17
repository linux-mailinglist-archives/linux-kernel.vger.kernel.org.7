Return-Path: <linux-kernel+bounces-734865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B21B08753
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E76F18990CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A3D2550D2;
	Thu, 17 Jul 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3vGw98T"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C402AD14;
	Thu, 17 Jul 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738479; cv=none; b=lbjMVf0agJRHchSq01oJbU/yepcgb3EzrikQQfcrark57Ed7+3Xqz4aq3x0gb8OUJ7dM/flCp2vnUvOa0j5ro9U16ANkDpLuJbI9O3yOIs3rf1oCySu0Dfiqkp6fmRe6CN9DsLEAD6PxV6FofeyUKWN7Cc3ySJ5N9jukf6Gsz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738479; c=relaxed/simple;
	bh=2S5QpJz5HeVbfwdYCyitCABajQTcQVOAJAYG0QR/Fjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g5Vlp/w0Iy1rWu1ZTSqgA/1Pph36cpmzlkMnwfr9aQjxkTKXTOfia4B4tnS/jvqgMFiJenUCrS2yDH57pFxloxy3gPnUKwbzw8J8RU9HknmI7k3oki2j/o/aMYGT1m9Hd/ylwAhF+GJmhyZwW/D1n3cHiY99nNrAQK2rtDC2/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3vGw98T; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2ff8d43619cso519883fac.1;
        Thu, 17 Jul 2025 00:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752738477; x=1753343277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+UzCB+lQ41hrIIOkXc7xt5gfiM3qc956A0xJdVPAA4=;
        b=J3vGw98T+NCCUpYrzA2TyT/CrGoPMa+GtQlWR46LiBwNVlZ5iPdXlOD32EmyozM3u8
         ShMy5BzJ+/f1B5s0SVzZAM+AGMyl6CH9OVQu8d0V+BumcZEQjeaaPb2ldkZpLYQ8+5pd
         jocRbeoxWSHC25RXuJid5wybJYt4vb5IAHgAT69RhPSJuhQr5qyeo2q2jLE7RqfCjQw4
         oIk9BmFTa7DpJhn7zSxY4JVJnW1h9/AqUTU98TxiDDbHyNORbF2uOnfaBclOhTpa4lYs
         0u8URXq80RdKfPzD/MgPHZA/WveBXPebU0vkg0ZpoF0I5o9VErlaPBIBOcuxhxj1rU7i
         PJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738477; x=1753343277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+UzCB+lQ41hrIIOkXc7xt5gfiM3qc956A0xJdVPAA4=;
        b=Sl5L3OqUk33rIFm2KZ7By7hDaYawcqxMrNcZkg/szWPAtDsaiKbmjCw2PKnE5KOpU5
         vt8zQcPCkdXy/Pe6caGuBarrAIQf+5eq8oCnbd2FDrxKuBvFO59iDk/Z+3qP5SpED941
         1kpPqp0ZO7BYH1QDQKhxOmRZI2lkVGlzV/WG61RpOImYXQ2wxX6xqXxgHM6CHaToI4ZC
         oQhg2lJk0Oanewr7wmbBJAjRQTyAHs/ktPI8OQGPEr5A6wkbFRPnLwC1A8/Efx43njbb
         Qac3Q09it236xMwcDqdHBhO4YTDx03fWuuXilxG80ciWlLdxXtXlyoGhzv6ZDBX1X2+m
         6Nzw==
X-Forwarded-Encrypted: i=1; AJvYcCWKbyKEQtL/bRo5xciUCqZnP6UY9HupmRKkVHdhlVHb208APIg8LE0eg8KCcBd4LD97mEFz6ij1AxPpDv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaW17hIHB59I07vH+vkVPaLDJOcPkqjjHRjmQUoRH9DXb+Imb
	0sdjQEI4/tGoxO4Z9anCBSoEKX2Vl8HgSIPxjQB1xdlcuD7yJRegJTFI
X-Gm-Gg: ASbGncuAyKyBPHbPWG/MpzYCNIDDp11ahu5XapfFlUOsPj4pncr9YWUk05Z0/SL5DW1
	2Lh3CeGI8XJStKCMdFVsibeqVPN9bLzQ4ce3nMEdfkNguCEJ5KqafVDHMtHqPIcCkXJJQ61FM7s
	g6L0EA0lJVJVcfztZ32Mf3CDbESgXNqPglt1JgtoOsk0D3y4BI0xmI1qlqYFHUWO5mGkXYDyPsL
	Ju54XR0UCeG+8BxR7hvoA+SFxxuhdhbQ2QmCiGObOLRUl63fsWRTece26jcu6A/44ju4GBVTk3y
	xMrdrCucNQhrBQQuyl/972VMOTt++4GzbufUZbhEEEtb+V8rDm3VaG6M5rtA3MeOyk73ATBBuKA
	/bo8LrmTPikuBOCSWHvTPZiw+EGTrtbMOo/T6N9KuVHg1Kduv/s+x
X-Google-Smtp-Source: AGHT+IEjF60Rn3xo8x8GdcVuVHGDFHQh2dggVbWMzGDElQoKJLnTxBKI+KKFFklA5o/MwIjPPCGUEQ==
X-Received: by 2002:a05:6870:3e09:b0:2d4:ce45:6988 with SMTP id 586e51a60fabf-2ffb2233b9emr4794215fac.6.1752738476580;
        Thu, 17 Jul 2025 00:47:56 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e44f2fb4dsm2470232a34.49.2025.07.17.00.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:47:55 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] Documentation: Add patch-validator to dev-tools
Date: Thu, 17 Jul 2025 03:47:45 -0400
Message-Id: <20250717074745.8333-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ignacio Pena <ignacio.pena87@gmail.com>

Add documentation for patch-validator, a comprehensive tool that helps
kernel contributors validate their patches before submission. This tool
catches common mistakes that frequently lead to patch rejections,
improving the quality of submissions and reducing maintainer workload.

The validator performs 21+ automated checks including:
- Patch format validation (subject line, changelog placement)
- DCO compliance and licensing verification  
- checkpatch.pl integration with enhanced reporting
- Build impact analysis and testing recommendations
- Common novice pattern detection
- Git configuration validation

Also includes companion tools for finding first contributions,
testing patches safely, and validating patch series.

Link: https://github.com/ipenas-cl/kernel-patch-validator
Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 Documentation/dev-tools/index.rst           |   1 +
 Documentation/dev-tools/patch-validator.rst | 287 +++++++++++++++++++
 2 files changed, 288 insertions(+)
 create mode 100644 Documentation/dev-tools/patch-validator.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 000000000000..111111111111 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -32,6 +32,7 @@ Documentation/dev-tools/testing-overview.rst
    kunit/index
    ktap
    checkpatch
+   patch-validator
    coccinelle
    sparse
    kcov
diff --git a/Documentation/dev-tools/patch-validator.rst b/Documentation/dev-tools/patch-validator.rst
new file mode 100644
index 000000000000..222222222222
--- /dev/null
+++ b/Documentation/dev-tools/patch-validator.rst
@@ -0,0 +1,287 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Kernel Patch Validator
+========================
+
+The kernel patch validator is a comprehensive tool that helps contributors
+validate their patches before submission to kernel mailing lists. It catches
+common mistakes that frequently lead to patch rejections, improving submission
+quality and reducing maintainer workload.
+
+Installation
+============
+
+The validator is available at:
+https://github.com/ipenas-cl/kernel-patch-validator
+
+Quick installation::
+
+        $ git clone https://github.com/ipenas-cl/kernel-patch-validator.git ~/kernel-patch-validator
+        $ cd ~/kernel-patch-validator
+        $ chmod +x scripts/*.sh
+
+        # Optional: Add to PATH
+        $ echo 'export PATH="$PATH:$HOME/kernel-patch-validator/scripts"' >> ~/.bashrc
+        $ source ~/.bashrc
+
+Quick Start
+===========
+
+Validate a single patch::
+
+        $ git format-patch -1
+        $ validate-patch.sh 0001-your-patch.patch
+
+Validate a patch series::
+
+        $ git format-patch -3 --cover-letter
+        $ validate-series.sh .
+
+Find contribution opportunities::
+
+        $ find-bugs.sh
+
+Core Features
+=============
+
+The validator performs 21+ automated checks:
+
+Format Validation
+-----------------
+* Future date detection (system clock issues)
+* Signed-off-by presence and format (DCO compliance)
+* Subject line format ``[PATCH] subsystem: lowercase description``
+* Version changelog placement after ``---`` marker
+* Fixes: tag format with 12+ character SHA
+* Cc: stable format validation
+
+Code Quality
+------------
+* checkpatch.pl --strict integration
+* Patch apply verification
+* Build impact analysis
+* Single logical change verification
+* Commit message quality assessment
+
+Best Practices
+--------------
+* Novice pattern detection (console output, TODOs)
+* Git configuration validation
+* Debug configuration mentions
+* Testing information requirements
+* Static analysis recommendations
+* Performance impact assessment for large changes
+
+Additional Tools
+================
+
+test-patch.sh
+-------------
+Safe patch testing workflow::
+
+        $ test-patch.sh 0001-my-patch.patch
+
+* Creates temporary test branch
+* Applies and compiles patch
+* Runs sparse/smatch if available
+* Automatically cleans up
+
+find-bugs.sh
+------------
+Automated contribution finder::
+
+        $ find-bugs.sh
+
+* Detects spelling/grammar errors
+* Finds checkpatch issues
+* Identifies missing .gitignore entries
+* Suggests debug configurations
+* Integrates syzbot reports
+
+contribution-checklist.sh
+-------------------------
+Interactive readiness assessment::
+
+        $ contribution-checklist.sh
+
+* Evaluates community engagement
+* Verifies technical setup
+* Provides personalized action plan
+* Scores knowledge areas
+
+validate-series.sh
+------------------
+Patch series validation::
+
+        $ validate-series.sh directory/
+
+* Validates numbering sequence
+* Checks cover letter
+* Ensures version consistency
+* Tests apply order
+
+Common Workflows
+================
+
+First Contribution
+------------------
+1. Find an issue to fix::
+
+        $ find-bugs.sh
+        ✓ Found 23 spelling errors
+        ✓ Found 45 checkpatch issues in staging
+
+2. Make your fix and validate::
+
+        $ git format-patch -1
+        $ validate-patch.sh 0001-fix-spelling.patch
+
+3. Send if all checks pass::
+
+        $ git send-email --to="maintainer@example.com" 0001-fix-spelling.patch
+
+Patch Series (v2)
+-----------------
+1. Create series with cover letter::
+
+        $ git format-patch -3 --cover-letter -v2
+
+2. Validate entire series::
+
+        $ validate-series.sh .
+
+3. Add changelog after --- in each patch::
+
+        ---
+        v2: Split into separate patches per maintainer feedback
+
+         drivers/staging/driver.c | 10 +++++-----
+
+Common Issues Detected
+======================
+
+Date Problems
+-------------
+The validator catches future dates (2025 bug)::
+
+        ✗ Date Check - Patch contains future date (2025)
+
+Fix: Correct system time before generating patches.
+
+Missing Changelog
+-----------------
+v2+ patches must document changes::
+
+        ✗ Version Changelog - v2+ patches must have changelog after --- marker
+
+Example fix::
+
+        Subject: [PATCH v2] staging: fix checkpatch warnings
+        
+        Fix multiple checkpatch warnings in driver.
+        
+        Signed-off-by: Your Name <you@example.com>
+        ---
+        v2: Split into separate patches as requested
+        
+         drivers/staging/driver.c | 20 ++++++++++----------
+
+Multiple Changes
+----------------
+Patches doing multiple things::
+
+        ⚠ Single Purpose - Patch might be doing multiple things
+
+Solution: Split into separate patches, one per logical change.
+
+Integration with Kernel Workflow
+================================
+
+The validator complements existing kernel tools:
+
+Before checkpatch.pl
+--------------------
+* Catches format issues checkpatch might miss
+* Validates changelog placement
+* Checks git configuration
+
+With get_maintainer.pl
+----------------------
+* Reminds to use get_maintainer.pl
+* Shows suggested recipients
+* Validates recipient format
+
+Testing Integration
+-------------------
+* Suggests appropriate test commands
+* Checks for testing documentation
+* Validates CI mentions for complex patches
+
+Best Practices
+==============
+
+1. **Always validate before sending** - Takes 30 seconds, saves hours
+2. **Fix all errors** - Don't send patches with validation errors  
+3. **Consider warnings** - They indicate areas for improvement
+4. **Use companion tools** - find-bugs.sh helps locate good first issues
+5. **Document testing** - Include what/how you tested
+
+Tips for New Contributors
+=========================
+
+Start Small
+-----------
+* Use find-bugs.sh to locate simple fixes
+* Focus on staging drivers initially
+* Fix one issue per patch
+
+Common Mistakes to Avoid
+------------------------
+* Don't mix functional and style changes
+* Don't send patches from the future (check system date)
+* Don't forget version changelogs on v2+
+* Don't skip testing ("compile tested only" = lazy)
+
+Follow the Process
+------------------
+1. Find issue with find-bugs.sh
+2. Create fix and commit
+3. Generate patch with git format-patch
+4. Validate with validate-patch.sh
+5. Find maintainers with get_maintainer.pl
+6. Send with git send-email
+
+Example Output
+==============
+
+Successful validation::
+
+        $ validate-patch.sh 0001-staging-fix-typo.patch
+        ======================================
+           KERNEL PATCH VALIDATOR v1.0
+        ======================================
+        
+        === Basic Patch Checks ===
+        ✓ Date Check
+        ✓ Signed-off-by (DCO)
+        ✓ Subject Format
+        ✓ Version Changelog (v1 patch)
+        
+        === Code Style Checks ===
+        ✓ checkpatch.pl
+        ✓ Patch Apply
+        ⚠ Build Test Required
+        
+        ======================================
+                  VALIDATION SUMMARY
+        ======================================
+        ⚠ WARNINGS: 1 issues found (patch is sendable but could be improved)
+
+Contributing to the Validator
+=============================
+
+The validator is open source and welcomes contributions:
+https://github.com/ipenas-cl/kernel-patch-validator
+
+Each check is based on real rejection feedback from kernel maintainers.
-- 
2.39.5

