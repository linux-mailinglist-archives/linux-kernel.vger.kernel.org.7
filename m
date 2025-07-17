Return-Path: <linux-kernel+bounces-735343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF9B08DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0B61A674DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7842E49B4;
	Thu, 17 Jul 2025 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9dQag83"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709152E4995
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758405; cv=none; b=OvngkbIenuYSLUEA83BX0sOrotEObeaNhW4Xrl2R5Vc8lHS+aKFOrhgkcCPZLc9m0U6FIf3hW+1118/xZRMk9JWNDvY6UfuP1dNOi0PER57BFtftkQKn04LasCgeCp2P6mBnPElz+0AGuVQ6/zGQXz1sVP7mepEv08SbAkF5EjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758405; c=relaxed/simple;
	bh=Ht/AU7qX96DgW45jQv8wCyB6rZkYr7yWkNTy8kdn7Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgPiyhQ7y8Ole9v15HFdfPY5Ku8x1rYQM46o0RremhyuUfcEAKdPXxv2No+CtukpqB8pq7UnRUpuIrbx4QJ3SdlmFSGMuHROidF50KTjP1hRMAtRXGXLRbCD4yn1cz2eg4cWbWEqUoua4jB472NX76vHjQxOqQtw2vc9ACTC2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9dQag83; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23c8f179e1bso8796215ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752758403; x=1753363203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmGTgMm0CwlsfF7pgZGjy2MuT4lXG/yPFB4+SIA2w3Q=;
        b=b9dQag83cYCSvqSP9L7Q1dT0ptydzpC363iNoy7vQLAosMO7wHv3vgm65q7b1NEGmR
         GxCbZBEsFFMopplGwYaElQk8poIR824iBdpxtLJVmCW52CoY8WJ+mfne1To3YUuqX4+C
         3oInP1hvb2ecZ6cetJLnCpZwytxA9mOnyP0SqlQOlLSrCMiD5T5oxU0+2YN5DbdiXn6S
         QuC0BtkiAsZOaauBMK/jASnXfyevQZAJoVsX9iSiOCYhW8HfXoRMz4zEMfNQFiFP0/he
         Y5sEqpZyf2aEqTWuwVWnMAeD0SjwpcQQWzw/OtPQ+0zwI90kVZ4IWg2cdgqRBL22Xp0O
         G9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758403; x=1753363203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmGTgMm0CwlsfF7pgZGjy2MuT4lXG/yPFB4+SIA2w3Q=;
        b=bUjHSIO6Pj45Lh7ie2JqJvVZXvOfIfnQ18Y/Dgg8NJOs9d++n6YHtB7urZRsjuz/vg
         NHTOtBgZmALuwDSMU8bqOUxLDI/Z7/qOLHlUDlJV+AwJCtxIJm1oCOQ4of1exu0iW425
         /bRMslNEBPFFxLdzNY4euzT4CObxql6DR0nOdE+w4kx7jwfq+yUo1SMO2GaJzYeRn3a6
         PEU8SwyTweUAwD01WHPyTRT3Ud/6CTPPDroYn/I3tjfFMU67N/SFEUKX40OziHbWqRGD
         +TBRvH1x20fzRSidYqUFvabt2ns4Zy40jLGvt0y/+hB5IJSyjkL/egM78/obiP59nBMW
         jutQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGdVEStYJa+naO8CIDJvjo+xE+Kug052kc0CnchHhV5bfxmGAOSKfD/YVZg17Ks+6ObE4pjeuCa/EZu+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFM9BRV4Zw9VfRI2Jwgr3v2txssoPF4m++FXPm4Rrl+a6Ge6dJ
	RCROms5W6vDyfNq3fHtRgiU7hVvrX4JwUSTMUSPi+gp1/J8SyBxtFpww
X-Gm-Gg: ASbGncta6kaX1lWSSaMFVBOc3s+fGrkKGGbdaXaFdn3ESc+Vg+pBtdUE9JLTKk+Cs0j
	BB4WXMVLcQLjKRQqy9HKuMGXIeIIjNG0ImkQ5ird3FDU+hXRGvigbOd7kHu02qAP3rfWYQRVWn3
	gG+4dvN0RFDUfoAhtKiyuXphnziKdVNBt3841p+A2YZXpISGpF+3TDWiXmLOueurEBCsu0puoER
	xOtug+YxVY5X1E64/lE/K8Phpp/t0MxJ+jJuImYbzFDlurI62Gcw/+wQ05dJiObDHoG2MwHS0eH
	85LNfo7B/UVaVTWplHzPP7SGgBa8bCHgDAaP75AnoKu0AYn5zI/tplPWK8uu7EWLzbq2YKAYYAZ
	e5n6Y5vWnkuB22vMBhszpCFHzSDC5jVKZXfvbN0TvBEmb6ikg
X-Google-Smtp-Source: AGHT+IGWHeMY/uZ12iEvzQuqHtNmXdFjvZF16itZG3Iod/MC+opDHAiiRjYrodtsw71q94XoI8Cd9w==
X-Received: by 2002:a17:902:e841:b0:235:f3e6:467f with SMTP id d9443c01a7336-23e25693861mr107257555ad.2.1752758403474;
        Thu, 17 Jul 2025 06:20:03 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322e7fsm148053315ad.93.2025.07.17.06.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:20:03 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: akpm@linux-foundation.org,
	broonie@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	sj@kernel.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: brauner@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	Liam.Howlett@oracle.com,
	lianux.mm@gmail.com,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	richard.weiyang@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: [PATCH 2/2] selftests/mm: guard-regions: Use SKIP() instead of ksft_exit_skip()
Date: Thu, 17 Jul 2025 21:18:57 +0800
Message-ID: <20250717131857.59909-3-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717131857.59909-1-lianux.mm@gmail.com>
References: <20250717131857.59909-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To ensure only the current test is skipped on permission failure, instead
of terminating the entire test binary.

Signed-off-by: wang lian <lianux.mm@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/guard-regions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 4b76e72e7053..b0d42eb04e3a 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -575,7 +575,7 @@ TEST_F(guard_regions, process_madvise)
 
 	/* OK we don't have permission to do this, skip. */
 	if (count == -1 && errno == EPERM)
-		ksft_exit_skip("No process_madvise() permissions, try running as root.\n");
+		SKIP(return, "No process_madvise() permissions, try running as root.\n");
 
 	/* Returns the number of bytes advised. */
 	ASSERT_EQ(count, 6 * page_size);
-- 
2.43.0


