Return-Path: <linux-kernel+bounces-836257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B29BA920D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437571885F72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF32FDC55;
	Mon, 29 Sep 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bveEvQhO"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C44224893
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146898; cv=none; b=jsXKfAl35hAhK6zs5KGwwzmPbDSx1xru5camf96NJxDtfEpwODzNcxUH7WICGak04ftB9vnoM5XhW6I25NEgIY1hAjThnB8FXiyBHrp9P/vqc0B+amN4Z8m/DvvDS2KmXYmROzYv+L81QoO240clxJzasZimr980Z14VUVZSNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146898; c=relaxed/simple;
	bh=vkwL+PGNZASsXf9M09tTQFZ5+KuEzqyB7R4nlUavslI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tusIu6jamnXbPyXagiUmUivp2TqaMI+GxEQsLuU10i88eJgcKV/Q6+82BaNj/gxzcaRM30W1Hrcu0+B8YsQRpibPDBK/NCqyhz59vbONsplJWRgbkHsTBeSJFKpeFj/X30g0k0bp6dJ3KBOouhPRPcY3as0Qem3eFAJKgZSWUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bveEvQhO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7800ff158d5so2909177b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759146897; x=1759751697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nxMwSBQwOydmRinFjGwKZjIbNHBnsDSojBIvT19KMQ=;
        b=bveEvQhOjjJ3Bc7Uf5A7keCApcES4KA8zMtydq0Pi1fZnl+LOJmx3C4UhjruueJ6DN
         FWgomqp0REIWDp6M6NMdgFY2gzShPQbjS94bTGCL1Gpid5Lyp7TUV0GJuHEvg+Gr1VnP
         tSnCMC63s1B8mSRUX5mM5NdHNNJ7qfPCIrIrlQxE/Hu8MU0LIBe1R4fioXbPCHkgCd27
         lBofZLfESaKKdkrBKNquZuiU0nWf1yZ0mlnTxyLJf3018SNviC1yUz+EjXQuLOIDU5jd
         wkeVNWbNhmu2oSyzPWL+FqHwExtj5C+PAdvsLRsZ7ZB1ytNtFgdxezu88d2NVgOhXGyh
         Gysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146897; x=1759751697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nxMwSBQwOydmRinFjGwKZjIbNHBnsDSojBIvT19KMQ=;
        b=xKYu7gC18+XgLMTUigZnuHWY04BO6MCN1JXxLBKKYtGLnW+iLulFiUCGyQhMemM/Ci
         BD+iz5nuxUcfUd5vsOigpOIDPuu/BM6q/75RZx530egAdC0OCMy9PeCvWj6Ow1BC2Asn
         bUFWUPNEzI93BkaogW59Gg5R1fK18zau/9zPkApHMmY/4BsV8i6SMVK4BNtJLBEEZzSm
         HSCPu/HiHzhmQc5f0BqEltvxe2smaiPAMnPEjWW6eEeZlsmnh1P/KQG9JpGFYvTqYaz7
         iis3onAb/0tkhwyTwveaQ+ULhdjsK5jsDNuJ6QNoOb/MwNlxC8k4AaL/HWqjYA2FZuRC
         ZKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7URsRThd8JDLaHJACs9lBh/aeXh3e3vwwU+cEB22Q/U7A6iQLOCcQJ4dSPrtXU9VY/bD+Ry1vnLJwaXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7c5gpjzPeAee+RIV/gq1Xsbo45iPaL9OPFgkqgI61q8LA5p+
	3VPG/JpnMom8o3D68O5uN4M2Ewz4hL8uflQJ/w1M1RqxJTLPuKN3eXLU
X-Gm-Gg: ASbGncsnHqdW1OyJeqT35rOrNB156JwoY3O2ZjA7B3AWmfUvBBMIhyKMXakr0f5UeiL
	l2Eq9LycriTipbblNfcfD7bFxeLQjcFmG5d0r4345nhtJCgB7GrYiW2uf2TZ0YcBBCoHklV+4rw
	ZTclbYAlN843HrILLlD4CtzvqK45qJgQ1dFasF2KWB6gqWqtEZuQ7k63VkyRwbK2ec2FkOegkIo
	hEHnj+bkGbjFnsQcoc/Dpz1w0Q04X8JsKwI/4/x0pLhKbKPBIsSRBEOgO77iv28MGlD7TeS+nBj
	Y2BxX927WAsF9f9iGBsM7rrk+QGxfBy/HUnCcCoaqi1UnYFMmTEhH+I2qc/1ErxO+uGxLpCrPqR
	NzMBzpdc/V7WfUzA+7hd46tgXBju1
X-Google-Smtp-Source: AGHT+IGZZNUqAN5enffrxbMWSeJ5zzoNuwdSyjXDEWzGn3w9G1pwp20etolI1Qt0978OXhgQfd+jHA==
X-Received: by 2002:a17:90b:33c7:b0:32e:753d:76da with SMTP id 98e67ed59e1d1-3342a2abad6mr17486517a91.20.1759146896814;
        Mon, 29 Sep 2025 04:54:56 -0700 (PDT)
Received: from y740.local ([2401:4900:1f30:25ff:36cb:10ee:ba03:839f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be384c5sm16983570a91.26.2025.09.29.04.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:54:56 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	nathan@kernel.org,
	shuah@kernel.org,
	morbo@google.com,
	justinstitt@google.com,
	nick.desaulniers+lkml@gmail.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	david.hunter.linux@gmail.com,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH v1] selftests: cachestat: Fix warning on declaration under label
Date: Mon, 29 Sep 2025 17:24:06 +0530
Message-ID: <20250929115405.25695-2-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning caused from declaration under a case label. The proper way
is to declare variable at the beginning of the function. The warning
came from running clang using LLVM=1; and is as follows:
--
-test_cachestat.c:260:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
  260 |                 char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
      |

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index c952640f163b..0305e736f2b8 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -226,7 +226,7 @@ bool run_cachestat_test(enum file_type type)
 	int syscall_ret;
 	size_t compute_len = PS * 512;
 	struct cachestat_range cs_range = { PS, compute_len };
-	char *filename = "tmpshmcstat";
+	char *filename = "tmpshmcstat", *map;
 	struct cachestat cs;
 	bool ret = true;
 	int fd;
@@ -257,7 +257,7 @@ bool run_cachestat_test(enum file_type type)
 		}
 		break;
 	case FILE_MMAP:
-		char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
+		map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
 				 MAP_SHARED, fd, 0);
 
 		if (map == MAP_FAILED) {
-- 
2.47.3


