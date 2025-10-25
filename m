Return-Path: <linux-kernel+bounces-869847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64396C08DA8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200203B9C1D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D7291C07;
	Sat, 25 Oct 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJRNee8n"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DA287257
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761378987; cv=none; b=IMPfD7K5/5WH5ourHUXovfdHgzmSVMB2k313bc7xrU4LvzJeZMweoRXXkxd7hIpmLuTfWvVf7HnZ7ETCVuoqlsZ3Rl46Gv1W1sg3c8Mkt2By2my3noc8I92brgm9wsXmEZaj7Q3MONH1+scRJ3z32NpRq9ncU6AIxUL+s5Ku7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761378987; c=relaxed/simple;
	bh=8gVKaVr7mQmOCkjXIqbeVzWh9yXzYrSkI1/lFkAQbAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WZKhCIBd3PUz+5K4EsG3Jh6WstTEPaHlNoi2p5muVjErgoR/TO9AC13I7XX0OsnC23vHZ7dnJcvhODGGpQvakkQh/7UTGd9JgoSNRDyg2XsuKkyTAms5eIcIKuDUiBhJi72esAHvrxKmETCA67kDL+biaWBMIbJxTJdzN/SqkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJRNee8n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27c369f898fso45742915ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761378984; x=1761983784; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVHEeVvTfnJjIr7f3Y35GS9oBs/K0+nn/6SC3ws73x4=;
        b=YJRNee8n9DdtETcheWWK9DAAMmmpVXlSKbKke9bNZZ8RBXadnfNIzrNkJLjN8m5Su0
         M67cLAndjhFvsHhevq2kCF9aC/+IqxsBHjPZINIcS++u5SVRMgihEP3ftVOwP5zmbSPS
         e0rAU9hRV6q0TxK7U7LAkljCrK5OtalWSSnu5N/NmL0tkWd4Id988balyoatENTdSQZt
         umNw5Xf1jFEkrsYgQN4uTdXQqcsMEMKoAVirCPYJ7Kdu2N2SKJoPvCxoPf3Wdj58Qd83
         jP2YP9WULeVc5X6H5TMFtMyCDKVmezHf4uXX+YS+kpNHsrQ/YBRVSaBmtAOVnk8JNHrW
         mT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761378984; x=1761983784;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVHEeVvTfnJjIr7f3Y35GS9oBs/K0+nn/6SC3ws73x4=;
        b=pCl6zjfO6jlxeiNXRV+DlqTp62vBKa5YCUc0ah/FaMPeBUMUGG5IoX21hhey2/xGQf
         7wSZbEJ0SFcw4Fo1OCZO4jDDr5PZDhkc48WQblP3fE/gaiX9NGOg74WqJzYZG6EGrIZ0
         nv02sfrnL5ol0cT0zWk+6vaGnFs8Pl9OjM8icOl0Wm1w5qgSZZJAPzEvySEPdQEXxd8L
         /64Usz6b1gFGCKiBGSc/WWeS5Xx9shCvhD7/4OfDCANUotRd+abb1BFddtWWqO9mVNmp
         Wtj/m6QFoUaQxWEeB1+zyyeVSaryrmxGGmBWNF3Aw4rS0hp+VE62ltQfIEy0ZA1qwa7b
         /d9A==
X-Forwarded-Encrypted: i=1; AJvYcCWOOziWnf2lbTFoPmXDqr8LHzuR9tLjlObj+6Yj/kIWYj4fE1vjOYRRtIM/Wjjedrd5KwiQ2CBAAnyXt3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5aY/AtLBaV2Pii6wKVUXgb3a/FA8R6q3OhrwIAdg0HEcO2d4Y
	jRBDA0Z4CfvkUdRbMkycjpcVjU52JKc5Uoa2S2KDHo2BzNXhvPWolHaA
X-Gm-Gg: ASbGncu4Rvw143JqtD8G4yyvkotX9MpGQuPeuR4briKxclNCvuZDcBHqBFgStnztNuT
	1ELJnOoOt092wZVm9cTZ9H1oXcyMHBmZhXwiOFHIzoiCgfZpV+TaWqZCHlXIY+AsCrh52GJIDaN
	R85FlN7dCtpYuB0rf+DgjpnnNlft+lF/jwQt/RzYGAdIsYcy1fFREFRKzYkSgVC86Yo3xNJpqyW
	L0sFe34GigK/j/DX3rWUvqjVXrYaDhAOh2FG+JMnxP9LFce1XVvJfmXhaBDpOJZlqPzpXMD//ta
	B5rjwlez1zx1EQN8ArT0HTaVkv0I58vBwLlJsgPdlvxgG400NGybAjLB7yaN97AAsvYHObZGMNx
	mhlj4z6WPulUkJc3mKaJXtk9VB9uIXjoZvb+hDAky0fhYjvike/7b0YywNLNFXS7o+1PmTAcW8C
	U=
X-Google-Smtp-Source: AGHT+IGwvkVJVftLc7N152A3XNiMYQcFGtvvfqDROQl6klMasXSEkx7383k2P/ZS1iFavUlMTbLlyA==
X-Received: by 2002:a17:902:c943:b0:26d:d860:3dae with SMTP id d9443c01a7336-290c9c93ac6mr393490305ad.3.1761378984475;
        Sat, 25 Oct 2025 00:56:24 -0700 (PDT)
Received: from aheev.home ([2401:4900:88f6:d7b0:443:a828:b6ba:688d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2333fsm14806285ad.50.2025.10.25.00.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 00:56:23 -0700 (PDT)
From: Ally Heev <allyheev@gmail.com>
Date: Sat, 25 Oct 2025 13:26:16 +0530
Subject: [PATCH v3] checkpatch: add uninitialized pointer with __free
 attribute check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-aheev-checkpatch-uninitialized-free-v3-1-a67f72b1c2bd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJ+C/GgC/5XNPQ7CMAyG4augzBjZKeVv4h6IIQ0OsShplZYIq
 Hp30k6MIE+vh+cbVMdRuFOHxaAiJ+mkCTmK5UJZb8KVQS65lUZdEmoC45kTWM/21preengECdK
 LqeXNF3CRGUpb7N22ZEJDKkttZCfPeeV0zu2l65v4mkcTTd///ESQb+cqpMpuzNYcr3cj9co2d
 zX5SX+b699MDQi0sbhH5B0V+G2O4/gBfu11rSoBAAA=
X-Change-ID: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3095; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=8gVKaVr7mQmOCkjXIqbeVzWh9yXzYrSkI1/lFkAQbAQ=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDL+NC26H2nLc7Uj8V6vE+M+NhPOxze5JdqevlmxofwPT
 5PvHr/FHaUsDGJcDLJiiiyMolJ+epukJsQdTvoGM4eVCWQIAxenAEwkYSYjw5q9EzSu7MjpOla/
 ck3tB+cC/3M/vSJ6bZLKq1Kcb6wPiGVkaNr5ZdWWds/3zE+dY3+2Sk+80qK7IPban6u7znnW+f+
 8xwAA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

uninitialized pointers with __free attribute can cause undefined
behaviour as the memory allocated to the pointer is freed
automatically when the pointer goes out of scope.
add check in checkpatch to detect such issues

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Testing:
ran checkpatch.pl before and after the change on 
crypto/asymmetric_keys/x509_public_key.c, which has
both initialized with NULL and uninitialized pointers
---
Changes in v3:
- remove $FreeAttribute
- Link to v2: https://lore.kernel.org/r/20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com

Changes in v2:
- change cover letter and title to reflect new changes
- fix regex to handle multiple declarations in a single line case
- convert WARN to ERROR for uninitialized pointers
- add a new WARN for pointers initialized with NULL 
- NOTE: tried handling multiple declarations on a single line by splitting
        them and matching the parts with regex, but, it turned out to be 
	complex and overkill. Moreover, multi-line declarations pose a threat
- Link to v1: https://lore.kernel.org/r/20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com
---
 Documentation/dev-tools/checkpatch.rst | 5 +++++
 scripts/checkpatch.pl                  | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324fb2399a5b1bc99c891ed1de10535..1a304bf38bcd27e50bbb7cd4383b07ac54d20b0a 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1009,6 +1009,11 @@ Functions and Variables
 
       return bar;
 
+  **UNINITIALIZED_PTR_WITH_FREE**
+    Pointers with __free attribute should be initialized. Not doing so
+    may lead to undefined behavior as the memory allocated (garbage,
+    in case not initialized) to the pointer is freed automatically
+    when the pointer goes out of scope.
 
 Permissions
 -----------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..e697d81d71c0b3628f7b59807e8bc40d582621bb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7721,6 +7721,12 @@ sub process {
 				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
 			}
 		}
+
+# check for uninitialized pointers with __free attribute
+		while ($line =~ /\*\s*($Ident)\s+__free\s*\(\s*$Ident\s*\)\s*[,;]/g) {
+			ERROR("UNINITIALIZED_PTR_WITH_FREE",
+			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on

---
base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
change-id: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


