Return-Path: <linux-kernel+bounces-882656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4958C2B0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1085E4F29F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D712FD1DC;
	Mon,  3 Nov 2025 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcnXu2vv"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD412FE073
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165758; cv=none; b=ELjvtiZg7jueUZwNzAxxFeZrYgrdGXnjNms6zRTydd8cwhyQD+BMP2iBwwoLBkIWfaMw/8W9qi8NDsJdsnPRchIXd80GHIdP6tg2ZT2VKYQo5n2YsxWkTm2wbsmAtymBEWkbCQReZV22CjyZcZFdl7ADRTSiJ+VKk34evjE2fwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165758; c=relaxed/simple;
	bh=NNFu8FBzQ7flDo1wMWMBNvwk5Y9qE46G4PK7oo92saY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IB7L0baOkoxZ9ZEHn6Ge1SAgkQ38ZsURApRyDYxBELdWixMEo0x1ETy13MSBQF/U0+1oVN+cO4I59DHkvOOI0yEzGAkyikrPkXNLNF5Gof9jJs41vdrSGdk6U8KPC19BueUm+0l1P3TDHGdF3qqEA8Qvoohr1QjMFG1p/EECBHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcnXu2vv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a226a0798cso4002403b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762165756; x=1762770556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oT7JNNonqIXijYSYJSkPdGEq15DlEW2rrYne5voLd6E=;
        b=NcnXu2vvi12xq3YOY0od1i6frKmqXRGwP82n7v3fiDV95/IfxJJ5XyGq00U7046XHt
         kp+0HKzVxe29DpShAQfc0Wb1Yrc8vNLLjxt12FWsHJYNV0vqMcflyWRi+SmI/p07TcgS
         qGpIHhcqTmM/R0BpghG0PlYiXt+1/zW40wavPiYu5AY/1yvlrg2AwKvprr+BY9RpzJKa
         PDIegBZ61MfmYvKaPuQbHqJvOLm9s6scTSWXdp7Uzy+qdh4SIzUZ0xiKKpUbU0cDaPGg
         a3VwFBwRGz3NW+VVYdLRrbSi2wddPG8ON0tH5Y4FrHV1GJ8T7RMKMvTRM73DN/gbaq+C
         WV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165756; x=1762770556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oT7JNNonqIXijYSYJSkPdGEq15DlEW2rrYne5voLd6E=;
        b=TfVTMpKesvgK8i/v07D/wOUDqKHHDtsDlaOLAkySrS/TanRRQ1WGrur7H6uVTwojn2
         nMaEaIYHz5MhGLkHmFVbxpDEEl6b49grXO/49ebkyj7B1rdcJABK54fsF+mDflhilaFx
         +/9AnCv1UmECYMoyxHv1kMlxyfpzxi6KUuwTM56iVEUlPAvsJgaLg8SzZIA8jDY8ETZ2
         c6qag8PrtFpln+ocgAaYKzimkJ1g+CyWFQmBgF+8l1mp3VvfTLG5OkXpF2HyCZN3ms/T
         SWnZo56RdyfpP9j5cJpiVMR1WacfJ/fjYYrDJgJBoFu8wxINxLIjBqMy2ucg0pzZEoWS
         f3/w==
X-Forwarded-Encrypted: i=1; AJvYcCXFsukGKrqavxuVNVQxWoLn7VscV3xxIGsvjxaQ78TW4MBBx1zcILPeslfBMLHI/epKKnFHsT39LSY3EeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pXfCKAwL+t4jS28Ig/5VS5UvITblke6BMjU4MbKYvtdmNsjq
	GPSlNDr3iGtjF/JvW+i40AjooGtQzOwSchZDOp5EPAeUgWB7onU3NAH4
X-Gm-Gg: ASbGncu+fUQw3TjpZjN7fM1XioIPbCWiBqSxEvROGKx9u9B/XZ3IJxmYhUCJ9zz1ntE
	5+0MRkhM9hY9+xS8Kn3fYlrpO2dM7VBOek4QIsArrt1QI8ttpsgY+rZ9eZzFJfROjz564dYgxQ+
	GvsgggwUTFZ5Wm7CXxu3+wzLEIRr5cn0M+fHAk+kMfqwqCUKfq1QSrFQsKFr/3xZ+odrhFPc+Ck
	VOvptnfPjDhlS8P0hngY5CWbTDwtlO5LRWZHTnSqb4pjCwCbUAzEmy7Bej5kumaM6b+Bfz4ihRN
	rhDsuPHdzpMg5abo1Yn5P9RaZ6g7Np6BHZcDsGvVl1/3ixAx/cnufp1HFqyrZ3r1OiegCXZTilQ
	5CSAOX/BX8lapb8PU9nwUsKBsChZEUEGL3CUhOoB/irmWMqaV26tVpyaG0cC1PHviGm0YJGUnX+
	QMPi8Y75OhuUnz/0olRjzBzvcX
X-Google-Smtp-Source: AGHT+IEzv22mg3fp+d55W8s3yELsWcQELBClBsKMbm8jJoz/IFP4+WzoTtXgJKI+8eKWPdXp6/78Mw==
X-Received: by 2002:a05:6a20:728a:b0:334:a15f:8d2d with SMTP id adf61e73a8af0-348cd21bbecmr17080637637.44.1762165755846;
        Mon, 03 Nov 2025 02:29:15 -0800 (PST)
Received: from localhost.localdomain ([116.232.39.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8c8eb03sm9798250a12.15.2025.11.03.02.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:29:15 -0800 (PST)
From: Mingye Wang <arthur200126@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Mingye Wang <arthur200126@gmail.com>
Subject: [PATCH 1/2] Documentation/admin-guide/{binfmt-misc,java,mono}: Consolidate into one directory
Date: Mon,  3 Nov 2025 18:27:43 +0800
Message-ID: <20251103102753.462-1-arthur200126@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binfmt stuff has potential. Sorting them together makes sense.
---
 .../admin-guide/{ => binfmt-misc}/binfmt-misc.rst   |  0
 Documentation/admin-guide/binfmt-misc/index.rst     | 13 +++++++++++++
 .../admin-guide/{ => binfmt-misc}/java.rst          |  0
 .../admin-guide/{ => binfmt-misc}/mono.rst          |  0
 Documentation/admin-guide/index.rst                 |  4 +---
 5 files changed, 14 insertions(+), 3 deletions(-)
 rename Documentation/admin-guide/{ => binfmt-misc}/binfmt-misc.rst (100%)
 create mode 100644 Documentation/admin-guide/binfmt-misc/index.rst
 rename Documentation/admin-guide/{ => binfmt-misc}/java.rst (100%)
 rename Documentation/admin-guide/{ => binfmt-misc}/mono.rst (100%)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc/binfmt-misc.rst
similarity index 100%
rename from Documentation/admin-guide/binfmt-misc.rst
rename to Documentation/admin-guide/binfmt-misc/binfmt-misc.rst
diff --git a/Documentation/admin-guide/binfmt-misc/index.rst b/Documentation/admin-guide/binfmt-misc/index.rst
new file mode 100644
index 00000000000..4ec76f7500d
--- /dev/null
+++ b/Documentation/admin-guide/binfmt-misc/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================================================
+Kernel Support for miscellaneous Binary Formats (binfmt_misc)
+=============================================================
+
+.. toctree::
+   :maxdepth: 2
+
+   binfmt-misc
+   java
+   mono
+
diff --git a/Documentation/admin-guide/java.rst b/Documentation/admin-guide/binfmt-misc/java.rst
similarity index 100%
rename from Documentation/admin-guide/java.rst
rename to Documentation/admin-guide/binfmt-misc/java.rst
diff --git a/Documentation/admin-guide/mono.rst b/Documentation/admin-guide/binfmt-misc/mono.rst
similarity index 100%
rename from Documentation/admin-guide/mono.rst
rename to Documentation/admin-guide/binfmt-misc/mono.rst
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 259d79fbeb9..76eae29c5d8 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -108,9 +108,7 @@ documents are ... old ...
 .. toctree::
    :maxdepth: 1
 
-   binfmt-misc
-   java
-   mono
+   binfmt-misc/index
 
 
 Block-layer and filesystem administration
-- 
2.49.0.windows.1


