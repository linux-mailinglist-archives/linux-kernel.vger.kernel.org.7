Return-Path: <linux-kernel+bounces-863187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5417BBF733F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91D9425BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F79340A58;
	Tue, 21 Oct 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="pI0TZdY1"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C4341662
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058634; cv=none; b=byhXlrT6Z+WeYAc3Wgkceu5hOYp0h8vLdVlKmuun/kG1cnEbhpoXODqmzRQlqshX6Q3JvEq40eBCPERvsu3UQ5l76M2J0cNXl+VwocjfG1YUQ4mKQ3DinFTn4pwYnZt+YvOYsnJ0ZFChVngA0mo2dxQ0EqQQOOCBQmejObAZmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058634; c=relaxed/simple;
	bh=BCgAaN0BWhahyAk6b2p7M+li52kCdvSEpUSlyuh2Buk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5gzk58FCKB6l+89pe5kdPFa33/Gpj6iUaHsxHhZf+9SdSVRIBKxL5msrjrARhRpaGuFUSgJxfNyE04joRFWjDyaTZxTfxP6ZDcXIBtJVh9dTrChJBPXE/b1XTtEjUYPpCzOO2W3v6YmttfXwzqsscKgojGjv3MTAq6m/Y3ehbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=pI0TZdY1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-292322d10feso31292375ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761058627; x=1761663427; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9b1g16UQQ4KDJWDE7yFsChb2icUfYNi6LJKUZT7f/c0=;
        b=pI0TZdY1eCkxPY8blxf2o5SuaSHqJolmywHKj84OXutHFO4bqPYxjn2kkoNwIXdqjE
         TA1WD2fI9zb4IvEOhCTLwPJHaxbWodvbkaJnMG1yHrx0q20MpkmfKMMIHDOlxASEhmgs
         ROkMa1dA1FCJO5E+jNKagdqkMMbmJnST+LiPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058627; x=1761663427;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9b1g16UQQ4KDJWDE7yFsChb2icUfYNi6LJKUZT7f/c0=;
        b=D1V+W7LmxgwEmrDpLxVWlj6R45CMeS6gjorO+JXERkdeIBpORoqWsqTUYDgZcIiuek
         heruXCInz1ODnFMheT/Vd4SnhFX8PyHmlX1LRFQBRlBDZrNU/XjLRan9Xao3jLhtUkK+
         ieFCY1+8S8nDblSwHpJguNsK5FV3xJnhMBr/pbxZGiGXxTpm5alcWFKwEjAuGG4vHTXd
         9SClUH8oV17TfHlWIuwsEISyG5JU0G6N3FwLmxHjWsZls6x/G07Tlh/ZYrR+SW8DBNpE
         xqkDEzcqvBUDWQwC28dhGx9CltqdnsaQXYtjpS3ExGidQ3fCZri0LUz5RwZcOCFJJH6U
         e7BQ==
X-Gm-Message-State: AOJu0YzM8i/2NrMylYVOpaB91CRgBeprQPsHkXYMtImAg8shsmHgdtRy
	3qptRIRYtDSzhuR1glVidstRqyZodHhlzipi4mTjvC0eaSZGhomuZqhwoMkIvuYow+sScpD1xlt
	39ckH9k/KbacuTajKCJ/mkrI3FlH5q8zNBPi9tbiBhrfsv8jN6rJTbzxDvdpZkaG15bftJp4BB7
	s=
X-Gm-Gg: ASbGncsQCuhLz5LRLBqsz/U4DwHCrU2utNt4YYMeBLqKf49yjSfkO/n6lw2hNRhaQ0x
	NxNMWlU1y/mozeRVeKD5SHcMm3OxOD2Lk9l39g2QtFdnRMiWcheGsjK/AEXK2yp8wu1OSciU6aL
	ZdTTz4kQk1LPcmiYhzyxE8XaV5Ow/8QBAHXPe2m3J04T6+UuBkhmyh+C2PIAbxuDLn1RA2753A7
	aN92meFpLqs5Z8cdW4FelKbVebb6mLTa9JTtmw/NptzL2tQRiOg1K9SjYT5iN2cEWjAwMoARVVW
	Q6SjnlqEq1qpWUyI7nJYVdtapGfaP+Lmc1CI0HTAhmbIDOadI+uBC1k2nAjZdnZtsbvM5w6x1mA
	DHPQM1c456uc4qb3KsBr4RImEV8cWvOgYL0jiTHnef5xuLv+L400Ldar32F6Yn+rLkC46mO5aRK
	dQ1iQ8IiyopIZz3MSsDvmoFIIgwvXqfTjWJAbBm+EwXU8duIAGjMHhhHVu24ackDhKhn75dAK56
	pEzzEMIrSW2ilM=
X-Google-Smtp-Source: AGHT+IE9y8vXj8XgETFLghucBY0+zzPJTy+PSW+s7pwJlsWGh+xBBF3gRYHs2fY5nCDjjxF1oWS9MA==
X-Received: by 2002:a17:902:c40d:b0:262:f975:fcba with SMTP id d9443c01a7336-292ff819282mr688065ad.9.1761058626489;
        Tue, 21 Oct 2025 07:57:06 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472193acsm111645195ad.108.2025.10.21.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:57:06 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] replace strcpy with strscpy for safe copy
Date: Tue, 21 Oct 2025 20:27:00 +0530
Message-ID: <20251021145700.38374-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 mm/shmem.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b9081b817d28..6e5a5d6fc7e9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -657,17 +657,18 @@ static int shmem_parse_huge(const char *str)
 	if (!str)
 		return -EINVAL;
 
-	if (!strcmp(str, "never"))
+	if (!strncmp(str,"never",strlen("never")+1)){
 		huge = SHMEM_HUGE_NEVER;
-	else if (!strcmp(str, "always"))
+	}
+	else if (!strncmp(str, "always", strlen("always") + 1))
 		huge = SHMEM_HUGE_ALWAYS;
-	else if (!strcmp(str, "within_size"))
+	else if (!strncmp(str, "within_size",strlen("Within_size")+1))
 		huge = SHMEM_HUGE_WITHIN_SIZE;
-	else if (!strcmp(str, "advise"))
+	else if (!strncmp(str,"advise",strlen("advise")+1))
 		huge = SHMEM_HUGE_ADVISE;
-	else if (!strcmp(str, "deny"))
+	else if (!strncmp(str,"deny",strlen("deny")+1))
 		huge = SHMEM_HUGE_DENY;
-	else if (!strcmp(str, "force"))
+	else if (!strncmp(str,"force",strlen("force")+1))
 		huge = SHMEM_HUGE_FORCE;
 	else
 		return -EINVAL;
@@ -5679,27 +5680,27 @@ static int __init setup_thp_shmem(char *str)
 				goto err;
 
 			nr = end - start + 1;
-			if (!strcmp(policy, "always")) {
+			if (!strncmp(policy,"always",strlen("always")+1)){
 				bitmap_set(&always, start, nr);
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
 				bitmap_clear(&within_size, start, nr);
-			} else if (!strcmp(policy, "advise")) {
+			} else if (!strncmp(policy,"advise",strlen("advise")+1)){
 				bitmap_set(&madvise, start, nr);
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&always, start, nr);
 				bitmap_clear(&within_size, start, nr);
-			} else if (!strcmp(policy, "inherit")) {
+			} else if (!strncmp(policy,"inherit",strlen("inherit")+1)){
 				bitmap_set(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
 				bitmap_clear(&always, start, nr);
 				bitmap_clear(&within_size, start, nr);
-			} else if (!strcmp(policy, "within_size")) {
+			} else if (!strncmp(policy,"within_size",strlen("within_size")+1)){
 				bitmap_set(&within_size, start, nr);
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
 				bitmap_clear(&always, start, nr);
-			} else if (!strcmp(policy, "never")) {
+			} else if (!strncmp(policy,"never",strlen("never")+1)){
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
 				bitmap_clear(&always, start, nr);
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

