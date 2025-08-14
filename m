Return-Path: <linux-kernel+bounces-768493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D7B26177
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228CA7A9395
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDDA2F1FDE;
	Thu, 14 Aug 2025 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPX4rjeb"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F220E33F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165041; cv=none; b=eZEgwj4Zpy7lM56MdWuIOZmRmV4fxqb1AKp9koSDlDqZrAF4QtUzMjxA8RuklZ8RtDx+5Cu73mkVB9qWNgSbubo2WFxzTMk2yFAdL1JP/PZWR3dLt7AqLL125Mm9Qd22qFxBQgsL3DVzk4/R8eIOhEPIWFQk0v2BfsSCvNnPqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165041; c=relaxed/simple;
	bh=ZzJM8fYJYo8JZhjrneuRlmkWMf+IZ0fjcN6v2K1F3pI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qf5Yd2iCjd/wKIGyZyA+EkfLb853bckoZziSRNXm3ymla7eN33Tf6doNdNi/KybUQwKESU3V0qT7sXODyVOC82opIMMFKBvNYuAJDgx+TSXcY4scv2tMbrmYe/ugu3M0VWGVbybHRyc8rjTlKq7ayHc0GUSmBBjPmuSCJ9ttD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPX4rjeb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so603121b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755165038; x=1755769838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NHKop36lIB2wzW60ahZRKPocqmOdNEX36xn6iDkZcxg=;
        b=HPX4rjebP/ET/r3p2ZOKWo8kzWUBTFJCq0Oqw+gjrtJ8uUBny0bR4W5UZwi0J5ElHp
         oQMIrG+RDG2b8Ls5kbSmK6xlU8AUbONt+mERLMnw8UUnqDhImCs4K7zfzoMo8X212Ds9
         YhQlxf+Av5C+WQ7Mr6f8at7pRb4rw1FqutNULsSBSIXGjKz0BFOIa89wKBXT4V9t4ti7
         q+x3dBGMEuHOWcFxCYFgFALzSSs2r05R7aNnEVeG9mmcCt0suYL4QfJ/XJHvQoKG9Kix
         m4sDtj+w6k5xrxpGUmcnQ35+NG5tFBu0yXXLnRBHP4Ay6aO4/i1pCFhzrjC3wz890TZS
         R5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165038; x=1755769838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHKop36lIB2wzW60ahZRKPocqmOdNEX36xn6iDkZcxg=;
        b=wI8cpipHaemHEnB+h2IQ7G04QGT8HdmdlGzuZ9+r2ffukPBhd8xVpzRvEzn5lUzzul
         TwwOc9bwNVhvStAzQr38pjlk2m4rrPF3ZsV9NUv7yJbtOsfnkhZcV4B36d3sjLRmXK2G
         rUEc3UeGwMVzF8mlmnipAtp9Qw9WdTCI/uwK5kJQBsi3twLywIAu/pmvWKAIoBZQEg1r
         ILHlpavVV2kmqmaFt0MC9H95wW30MIEX90aUL4iV+MHap79RmTi3CsWSvKQF9Ypujh5E
         UUFDzQ/tflrjlFJhG3eavATYUsG7iKOnAEbaEB65Yz8wEhJnoqvqdGEq46DgkH4AxUKe
         LdfQ==
X-Gm-Message-State: AOJu0Ywp8wlqqdWK0dTjFyVnHHwJZlCTwachChycwYsHpQ+bTQR+eblS
	vxrXHGedeLw3lj6eLEk8FWjASlD/JmpY6yirF6ckQ+bJ13Z+KG6ffdyw
X-Gm-Gg: ASbGncu/iz0vhDqKdxvJB3qDw1SVt7/GA0ATMdm66d1Tqv87Z1rfN4WBBz03Q3MK8dy
	KTL/w4AHa2yr2kHK8f2vCpcvGV1utkJv3BTTedLcl1xHTzdmNDEAfnVis3UmfMgZxzQ/T4GLUsi
	nWvMaSs32+Eha1qtjRcRc7wMgFpoixxDiJAHI69ufF7YUo7K/pZOVqibXWSyZiTX8wNBnp4zvZ0
	A8ao8hDLPwoLh18Biw/StMO7N+XSyog3yCfR0YEE2RtM8ZInuRiEmVUHBGQCmrogKXLbeKbziFk
	Qh5qa5N4+1cJdKuUTorDN9gQioJHudSmme+XUJDW8+dH6LWbpbikZ2OkFVXsKudC5L/D+INDuh5
	BQA1f/81LY0mNhrj5WtarsALSvD1IqbQDDgX106JIAnSjMDMairW8DRFG77qVNMw=
X-Google-Smtp-Source: AGHT+IE76cFsCFvDWKG2kTprT0Avs3FwFeq5vXcWUCfxow3CbAdaBDWHg4lj4Xywp2Z4YqppRCYFng==
X-Received: by 2002:a17:902:ce8b:b0:242:b03f:8b24 with SMTP id d9443c01a7336-244584c2125mr41930795ad.2.1755165038143;
        Thu, 14 Aug 2025 02:50:38 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b491sm348870975ad.131.2025.08.14.02.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:50:37 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] test_firmware: Use str_true_false() helper
Date: Thu, 14 Aug 2025 17:50:33 +0800
Message-Id: <20250814095033.244034-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "true" : "false") expressions with the
str_true_false() helper from string_choices.h. This improves
readability by replacing the three-operand ternary with a single
function call, ensures consistent string output, and allows potential
string deduplication by the linker, resulting in a slightly smaller
binary.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Compiled test only.

 lib/test_firmware.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 211222e63328..be4f93124901 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -26,6 +26,7 @@
 #include <linux/kthread.h>
 #include <linux/vmalloc.h>
 #include <linux/efi_embedded_fw.h>
+#include <linux/string_choices.h>
 
 MODULE_IMPORT_NS("TEST_FIRMWARE");
 
@@ -304,17 +305,17 @@ static ssize_t config_show(struct device *dev,
 			"FW_ACTION_NOUEVENT");
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"into_buf:\t\t%s\n",
-			test_fw_config->into_buf ? "true" : "false");
+			str_true_false(test_fw_config->into_buf));
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"buf_size:\t%zu\n", test_fw_config->buf_size);
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"file_offset:\t%zu\n", test_fw_config->file_offset);
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"partial:\t\t%s\n",
-			test_fw_config->partial ? "true" : "false");
+			str_true_false(test_fw_config->partial));
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
-			test_fw_config->sync_direct ? "true" : "false");
+			str_true_false(test_fw_config->sync_direct));
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"read_fw_idx:\t%u\n", test_fw_config->read_fw_idx);
 	if (test_fw_config->upload_name)
-- 
2.34.1


