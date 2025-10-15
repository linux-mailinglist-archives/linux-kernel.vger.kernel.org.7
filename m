Return-Path: <linux-kernel+bounces-853857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE5BDCC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B66554F9824
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026AE313285;
	Wed, 15 Oct 2025 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEHijYNs"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1B313262
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510659; cv=none; b=jtxakvnVvtnwJiJfyAR41bhik9MO793RZC3Ug9FPckPL0uuAuylUpcBVmX5NXt/Qh47sY/fisY1tJHU4C4FZJ6MLPQ7umuXhPk3Lb8qFOgJFbeoSzXewGF6xyEdV8wU5BNSSdEV5C8IPmpK2NxhpgQICVWRhIrSHtEa4s7iJ8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510659; c=relaxed/simple;
	bh=oakTPZ4dPHYuPOiBxt5TQsp7X4a/ClthMtVudvoGja8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAevsXnXMLmKXvrcCZ46xUPhHZj8KI+GQUMgAwQjEduwNQkeMxPmDoMB0wC/b94Seu2utCcFpZ8gymw/S7PGD0YtkN4DRvBNMsgpabQGJ791R2S4FSFf/RzOr8Vsb0rwV1nMlm+Xg2uVAyVnOnpuWYvJ1w5QNS4kd7DQyX41gY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEHijYNs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27ee41e0798so98282285ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760510657; x=1761115457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1h2ZB5tEfXNExzSYRgqaGZiEFO4eGNTSW8hgQwq0KJE=;
        b=OEHijYNsVSGWFum5JkFBekOZAm79fv8/zIuWmzqhyKq3wVfLeVFSAqOIU8xpqROdWi
         JUq5yciJSddytkq8LX+F+gtoLXQk0AfESm9LT8cn/J8VN7P4WRyTib+Azt/lUGEBHfKI
         iTTegMmKNhINp2rM46Jjrq0d3nw4RgS1qIcCMohBZ2OZbjwbiYzsSSmP29rkdlw10c61
         XbgPpcdMG8u2pjAkWSpahp4B73RPm4/SHbg/7lyo8Az5iYJuFVd0GfZ2PmDt8/dT2F8h
         HILCodzXaLr5koBj8ZYSfKJtOwFNHGBFIG2tS6BI8U/EEx0LDIZKxjYc3q9yQPvd8gAw
         uwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760510657; x=1761115457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1h2ZB5tEfXNExzSYRgqaGZiEFO4eGNTSW8hgQwq0KJE=;
        b=meCQwpT0VmVs9oxSvGEFm0fug48MGXWXzfkh8taRTx4VgmUS9tV5Md2hFSooQbjXSN
         rf8KovEi/KPvoQ4Q4Ok/tFzqeRmBgGAbUSjs26V+OUqqtaKIzYvGgShxU7h80pkg1FWd
         K4Wfxv7ib/TGIkR3wMszLul6z1qrsBmOZztkBAfPDTbr1hH3TJFNYNZb/Euq+YdSA2Mm
         cwnqpJqZjdaRijF2GhawUUJVu68rpmO/pjveGdbp5G9FS3rXjv96PQlzdNi0CPok+PBo
         tHqVJYiHbCguP/5+2D6JP+7zgkXu4lrxVIK3v1NDPxWBZtOnLJ3boNACZcq9SLZvH1Ih
         y88g==
X-Forwarded-Encrypted: i=1; AJvYcCWBkey/Q2PWzKU1dd9oLXnhR0Nh/VBfLuWFsgsGrpIPrkAKVXCs24CU3DS4+4l7YNQXJpWIlqCnsjj+Fok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVxMecitUtGFn9CNGM6WoIUBXK8LM0/jcqUeAG//+gsCw0k2I
	BApP3w5jxJS0/HrjwpTdF3IomWmAasPPi//MgDFjUjUC24hWWoLnApCH
X-Gm-Gg: ASbGnctXpfjrW3YNGSvnd6ypYBiwCLp9z3dH/9dr3NLREagV4x77lNFimZ4DQiUMjDf
	FXpUVTF2pn1YADsun+P1xOSSMTedKBAWiOjVve7PGoPrLFgOsVufGWITpZAQpuKVr7dG22JmPur
	FQ2NXygojz7aetPH4l9tg0XTkhJfNI+hlABp+1vUYQKnbwIiU7Shkum1/pSjZRdhgJgez2t4BTq
	o8qgbfjJE1/QNjZlQE6sU/2yfQz3aud3YGidFDZlBzAPeDiasoDdFquKlQ63YzupGWOaped/NGl
	SIXTfCPg2cEYRgVwZFtAJX7bQF2aT2aK6G137bzuF3Hv++RB/Lb3iuKr4XOryvPM+AVqy9rvxL7
	dTPpvdTULimEp7ugIRJJdJuTcM9d6vJr9CAVrKcDCNfuaqkch5cLctj6y9QYrHIpGJNRVnDxIZP
	HlxuHRCkgfwnaMAYR5oPANdEY3dA==
X-Google-Smtp-Source: AGHT+IFo4GkQAR4kQ8Q0IeCrlZ57EjWWcL/UzLVqG910m/3rZAgcNeInZAE64rrfXWrRydS69ZNpxw==
X-Received: by 2002:a17:903:1b64:b0:28b:4ca5:d522 with SMTP id d9443c01a7336-290273ecb07mr350160565ad.39.1760510657134;
        Tue, 14 Oct 2025 23:44:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:1896:1396:e40a:cbdc:d4a4:cc3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e44ef9sm183712015ad.52.2025.10.14.23.43.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Oct 2025 23:44:16 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	wang lian <lianux.mm@gmail.com>
Subject: [PATCH] mm/khugepaged: fix comment for default scan sleep duration
Date: Wed, 15 Oct 2025 14:43:33 +0800
Message-ID: <20251015064333.31274-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for khugepaged_scan_sleep_millisecs incorrectly states
the default scan period is 30 seconds. The actual default value in the
code is 10000ms (10 seconds).

This patch corrects the comment to match the code, preventing potential
confusion. The incorrect comment has existed since the feature was
first introduced.

Fixes: ba76149f47d8 ("thp: khugepaged")
Signed-off-by: wang lian <lianux.mm@gmail.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e947b96e1443..449f983b8891 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -67,7 +67,7 @@ enum scan_result {
 static struct task_struct *khugepaged_thread __read_mostly;
 static DEFINE_MUTEX(khugepaged_mutex);
 
-/* default scan 8*512 pte (or vmas) every 30 second */
+/* default scan 8*512 pte (or vmas) every 10 second */
 static unsigned int khugepaged_pages_to_scan __read_mostly;
 static unsigned int khugepaged_pages_collapsed;
 static unsigned int khugepaged_full_scans;
-- 
2.50.1 (Apple Git-155)


