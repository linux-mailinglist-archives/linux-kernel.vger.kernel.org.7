Return-Path: <linux-kernel+bounces-871933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6DDC0EE4E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2523A516C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF03019A3;
	Mon, 27 Oct 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtT8YkLa"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11890749C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577738; cv=none; b=qlAW5YN46g5nx7Z05OARBsZd6DZbj2m3xjkNysc+hzHHYqzvldE8aWEMTY5OMDDGt1sNQlW6esYzIumXvvoIbrURSyIeRc15nkK7xFAS49wBG2hFhWn5zgTInAccYm+XNI4eQUVtFBcQ0/EI7TyhNZY28LS0mE+15gzN8mmg5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577738; c=relaxed/simple;
	bh=E6TanHOEWRAN+pm6bYT8hZApuV50k09I3qBAuiVZgYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgxBbEvzu+ikl9bsAplB5nzF+OVMST+Kf46OikY8xjCfi94NMbSHddVRdCBhiaAUS6BuUCEKEpzWhivhXqhf1dV9DjtaJu6qewJAIEcJk2JTPi+6SFQwc9jHkthJsLT2pKA7vnd0wWBVTOMM3XlmtEF9ybUMU9J/gp4foI1SfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtT8YkLa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26a0a694ea8so34160625ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577736; x=1762182536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWC5gkPdxGSTgxFMIx5rrToJ8P8ezVw3vUIN7VkwkFM=;
        b=mtT8YkLaF20/D627XKTVaexicqyuPSry97S638w8M3Pv6rEIFZb52oEHUiI97c1cS2
         gzkRyuVa5qhodO48bqXGfRmN40FNV7+OUZeeKs5Uku+5sTjSeGHXeFnbnKsQS11MLYCm
         LM4/neskhqzXvSDnUdWRKs46yz/glsqfd5WdH1nuRvt16KGgpRc9JUbi7jD7VsMOUMP5
         XOLXY+2TVyrKcpuBe516tYlVF/fsQjxflUe/4OR6aVtINDLrlDZbjYGIATpqD5MHZjIB
         fgCr9VnHMAO4CJ0K6uq0riu812ZaXAd2dpzjsAl839oyme0old1ZTHQSu7gKZutQ0pcK
         K1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577736; x=1762182536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWC5gkPdxGSTgxFMIx5rrToJ8P8ezVw3vUIN7VkwkFM=;
        b=w6td45yAw1OGg1+JxcRNn3SjXdxRXLYA75L6/RAx9lsSitTvATD5xAwwpCLxfzM/IQ
         kEX1H1HvYx0Bp9UEHngo1qpVL2I0zn8MXVfQiGzbPuZSMWb4ERb+UfQopph8bN0Qukr5
         ECvDe48DUa8IZVS1077/9SKjchtY7BFOcqXchAnSpF3I4CFwCioQ/F2dkJeD8ecrL/94
         dEMOYk0/5yfcFWgT4P7y3iF75Hmqpx2LSSk7fCHJ2ZUVEyyxMBm+f1NcDU84084aOuCK
         Uu39RlgHS3M2K3wLLk8ZWhSEFqs2O4s+HRRZz0B26klxl8yFvvjagIsgWeOltr7Khuhi
         DS2g==
X-Forwarded-Encrypted: i=1; AJvYcCWvAC8dQS95hPY99s6cUPEsk1msvdgr7lf6WvihIbsvTob4GBDdURpH3V/fu0I56g5ggPZMdQh2nDZW04Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwfmmRPTdKJJb/fFXJGE9y9JTDNyUjaVomhXqhgvwB7yEugs5
	iozsD9bSuS6IFzDqGkysvMI6BzxdiXFmNi3t5JIbGRJecGvp+7gyGvF2
X-Gm-Gg: ASbGncstY/IO2dedyUehqF25EVQKAb91nwr+gaFHjxEC6GjeYKBml4uUkgn57iMFVm4
	cuvmwMSFxgrMtdVoKVxUaQweGi1Jhvj+92QKBUaALOAYDiByKpQAzS0eXUxiS8Zg6hWHGL9ecCZ
	Rs5sz0EGFiHgj+3kvMxABrmZiSLjTNSSoqjcjqJiKaADegYEoF88u21dQy4r70ApyZyq2rraY0k
	7x6lcxoQ3jo7yDSJmiOL0H+75JiASYxuqwDXN2iMtoWF7It8XWi3qFI6vMQLqbPDGUO702TBRiQ
	g4fYhrawQ11NFU8BRiqiWRDdWt5a8xg01sKd/YI1qVR2vBK4zGtMH8hadgzj9UcPbOWUEJgIk3n
	A8hD334y+Cau1IkajiiABA03yfhzAs40UZM2oTxAfsBLYWkfhkajkp8kcfKMvfE+FNyx8PpFeo6
	g9L1G33MvaAQGAXLDdoiZeEMZIxMYbu/1j
X-Google-Smtp-Source: AGHT+IFHIscxo7imWnRY5urYdW89HjcRlzIelV1JJZA81YcKKcZ25FMolijoFKaqSlkIM5bdPfTYvw==
X-Received: by 2002:a17:902:f68b:b0:27e:f1d1:74e0 with SMTP id d9443c01a7336-294cb37a547mr2902695ad.17.1761577736199;
        Mon, 27 Oct 2025 08:08:56 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf358fsm84405955ad.20.2025.10.27.08.08.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:08:54 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] s390/mm: Fix memory leak in add_marker() when kvrealloc fails
Date: Mon, 27 Oct 2025 23:08:38 +0800
Message-Id: <20251027150838.59571-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function has a memory leak when kvrealloc() fails.
The function directly assigns NULL to the markers pointer, losing the
reference to the previously allocated memory. This causes kvfree() in
pt_dump_init() to free NULL instead of the leaked memory.

Fix by:
1. Using kvrealloc() uniformly for all allocations
2. Using a temporary variable to preserve the original pointer until
   allocation succeeds
3. Removing the error path that sets markers_cnt=0 to keep
   consistency between markers and markers_cnt

Found via static analysis and this is similar to commit 42378a9ca553
("bpf, verifier: Fix memory leak in array reallocation for stack state")

Fixes: d0e7915d2ad3 ("s390/mm/ptdump: Generate address marker array dynamically")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update the fixing logic to prevent memory leak in v1
v1 link: https://lore.kernel.org/all/20251026091351.36275-1-linmq006@gmail.com/
---
 arch/s390/mm/dump_pagetables.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9af2aae0a515..ab0c1fcf2782 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -291,16 +291,15 @@ static int ptdump_cmp(const void *a, const void *b)
 
 static int add_marker(unsigned long start, unsigned long end, const char *name)
 {
-	size_t oldsize, newsize;
-
-	oldsize = markers_cnt * sizeof(*markers);
-	newsize = oldsize + 2 * sizeof(*markers);
-	if (!oldsize)
-		markers = kvmalloc(newsize, GFP_KERNEL);
-	else
-		markers = kvrealloc(markers, newsize, GFP_KERNEL);
-	if (!markers)
-		goto error;
+	struct addr_marker *new_markers;
+	size_t newsize;
+
+	newsize = (markers_cnt + 2) * sizeof(*markers);
+	new_markers = kvrealloc(markers, newsize, GFP_KERNEL);
+	if (!new_markers)
+		return -ENOMEM;
+
+	markers = new_markers;
 	markers[markers_cnt].is_start = 1;
 	markers[markers_cnt].start_address = start;
 	markers[markers_cnt].size = end - start;
@@ -312,9 +311,6 @@ static int add_marker(unsigned long start, unsigned long end, const char *name)
 	markers[markers_cnt].name = name;
 	markers_cnt++;
 	return 0;
-error:
-	markers_cnt = 0;
-	return -ENOMEM;
 }
 
 static int pt_dump_init(void)
-- 
2.39.5 (Apple Git-154)


