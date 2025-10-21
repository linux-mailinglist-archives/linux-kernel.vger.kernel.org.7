Return-Path: <linux-kernel+bounces-862738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0258BF60EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253AE3B76CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B732E73C;
	Tue, 21 Oct 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1Jvyzj7"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E432D451
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046257; cv=none; b=pNEUSBdPBx5K9BbcZ6se0Emcsrq4dh2tTKJIoi9dNsK6XGX8oT+OIaDKrJbV3fDRaZI515I76IYUZS+WcfKEfFQjsq1loFU4ozuCDu5kXtBIvFYUU4xdjLlTnnNDw211998S9lL3O2rjto4EMl36zOVqPoQkoNqzLmhnh4eVfuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046257; c=relaxed/simple;
	bh=Qqm6U43PdFmW9mwf9Z5RG2Er7n238UN+kS2H6VmO340=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gyMiKzlZSXZArR14ljyn5ddKVRf4F0H5HAAxzWzZ06Q+e1W2LRweV8pTHeA/jyKpgyWJMqz4Yw0o1Kwug1pSBas77t4t0MYUWL4nR+vdY4vL7UAgiieY4LHCB27HKBPmznKPQurQk/epVR5vRkpnxn5LdMw8WbDSC375Opxy+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1Jvyzj7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33292adb180so5442474a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761046255; x=1761651055; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O80w6uBNepx97qYpZjIrk9wRlGMkcThPDiRTm+gTRIE=;
        b=Q1Jvyzj7uEXRVtnx27qBHNGBMLpaoLzQtW78EVC7/KyPniiH8Cax+lwj8QtkSBSeTb
         TUB/5XjmP9sVtdfCjkcOtz1/LqejY1z/a3oXuvqplIYr/X0APFKJG5wLKnvKZAiWMaic
         eNsI8DuBTAPFXhcxVr/8kDTvNzV2tOaQTb4UXRv2wWGyDfz0ISzE568+nCGR3D8IzVYR
         HESKBnF/xd4IO+9XssY9eBn4KH3IGSi82eUXknnAuzSNW48qRKh5Dl8CSWkV6xX2xl8b
         K7sSGnqYDr3Nv0H1MdinE87RpnKX3OZXaeWkcYnsCNvsPnMXPjPqXpb/02zUFiWLVueq
         uGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046255; x=1761651055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O80w6uBNepx97qYpZjIrk9wRlGMkcThPDiRTm+gTRIE=;
        b=n1owoagw83IGBDZC4LHsIenqOuCg/Q/Lp6CA0LN1YXlarCdHgyldbe1bfBhnYi82k7
         ALHgQ/zpwApxqeSoooEmEPVTLK3kP5RMnLCF4lbTjO2QWVOo7h4wwRaFcPt2Tf2D87n6
         hsaHHjbSz/gfDSg88/n7pK+ZYKGTOknkliyWr5HvZoKaZwg7y05Y4tPYS13/3tG+1pPu
         seEo3MVL13cEW5Vo1LcA67RSRYies+T/+k+eZntgGy5PEGbttPNxli2QSzYW4Hbnn2gJ
         xBfYd7xoOBvX2vcTyx3MQL6nPaUOLGzpaxNpuEGkSfmzFqg0tfyUfzdNERF+GdvrrMMU
         LmiA==
X-Forwarded-Encrypted: i=1; AJvYcCWHq8wiuGK/P1Gn4VKNIDyxd0EhBd8KiPQ3XPWkkjILUJzlqWZ0wlpRg8gCL/f5Lv5tjU4GclivizroRvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5OintH7lY45s5D7o1A94DD4BmkeHILutx7n+PX9ZcPRBvrhM
	LwCGuG1fHT3nEkl5d012t0eaaoI2IRjv4joBUtMqXxCE0yohEUO3KaeT
X-Gm-Gg: ASbGncvnr//fQs7xH/DDB2stZK56JWjXyW3JvN95kr8MewPBcKBw+A8at+u44G0t1BC
	NCiICh0ZwfGA23YglgEwADUfOEiVn3b9idlb/3ExGqSaBP5t/1XXxbqYOLUSzoNdXVVH66ybgU5
	AoNkwda1k1o0OZSuwZzya1CQl0+JLW1ocC36T7oKjt50KwtdQ8QwenPYZCQCq9R9N73jWNPkV7B
	n3bHSF58QP1GPdWde+fOdOHZSzHBbx6jLWmnTyVUddvLngNO1yKMncZWYhyebe+J5wuHJX0VjW4
	dsmImKHhlDWuE3KVHKGsM1cZO5/vP9soTH3zYaLR667Xy38V9QZATA56hnsbyNu1072hFgf34I5
	pB1x+xGkJyZO5t2jb+U66sUzmG8EffO4vMqynIbStFK4KMjEzJc6ic0VDk5T+w/2NSkaUjd5T7A
	ISFArVL+pW
X-Google-Smtp-Source: AGHT+IFJmCSxAjrMISKkiBnZ4DKViFivlnMjzatYMYNY1Wsgm3nb2nGDtUzXGh+lfz7ieyS6UDWOrg==
X-Received: by 2002:a17:90b:2495:b0:33d:a0fd:2572 with SMTP id 98e67ed59e1d1-33da0fd25eemr7531901a91.22.1761046255417;
        Tue, 21 Oct 2025 04:30:55 -0700 (PDT)
Received: from aheev.home ([2401:4900:88f7:8f:303b:1c9a:7aad:191c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm11098221b3a.53.2025.10.21.04.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:30:54 -0700 (PDT)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 21 Oct 2025 17:00:48 +0530
Subject: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOdu92gC/x3NQQrCMBBG4auUWTuQiYSiVxEXYfrHDJVYklrE0
 rsbXH6b93ZqqIZG12Gnis2avUqHnAbSHMsDbFM3eeeDOC8cM7CxZui8xFUzv4sVWy0+7YuJUwU
 46PmSxgBxUaiXlopkn//ldj+OH3+pWJl1AAAA
X-Change-ID: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=Qqm6U43PdFmW9mwf9Z5RG2Er7n238UN+kS2H6VmO340=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDK+573alT31YHcnU+ttnaxVBr7F6z6EX/im4fU1tuywv
 MqMNatqO0pZGMS4GGTFFFkYRaX89DZJTYg7nPQNZg4rE8gQBi5OAZjI9BmMDGsmhFhEdApPnZNY
 cyRt1rspk6Z3zs78xGt7eHHm6rkHnS8w/NMtva77btdep39pvz2Ud/LzhLgue7nnk029FM+Kdzt
 PXOMCAA==
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

uninitialized pointers with __free attribute can cause undefined
behaviour as the memory allocated to the pointer is freed
automatically when the pointer goes out of scope.
add check in checkpatch to detect such issues

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Test:
ran checkpatch.pl before and after the change on 
crypto/asymmetric_keys/x509_public_key.c, which has
both initialized and uninitialized pointers
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
index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..33cb09843431bebef72a4f5daab3a5d321bcb911 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7721,6 +7721,12 @@ sub process {
 				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
 			}
 		}
+
+# check for uninitialized pointers with __free attribute
+		if ($line =~ /\s*$Type\s*($Ident)\s+__free\s*\(\s*$Ident\s*\)\s*;/) {
+			WARN("UNINITIALIZED_PTR_WITH_FREE",
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


