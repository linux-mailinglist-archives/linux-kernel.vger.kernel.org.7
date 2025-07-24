Return-Path: <linux-kernel+bounces-744410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504EAB10C86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574F717094A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE842EA16B;
	Thu, 24 Jul 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtHD+ISg"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7C2E4986
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365402; cv=none; b=pKJnaelH+Wh6ZnRsHf4VC38txyaXpptk15iKmvcNEGfychld23Bl0cL5Ckur01g7YzLdaBMArU9YsU79dZ2RTYlVw3ygu0Ikl0eF8EOc1nSFLKgDJaAAP95lthUXiUMF132DIHx3tkraN2T6qvLN+xGDyfC0ImyA4KSUuvvredM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365402; c=relaxed/simple;
	bh=kDQ1UVsh8/N1GCc/zzfiOopIyL3CRcZ04ezY899nhXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UooL7S3JFaWwqgKmWAqgiOzRrRGzuTejm0Tj3Zs63GZWfV2VK+5V5fNXsx6yCeFZqJ7Oe/Abqr8hwOLd9ZOYrC520Obk7ccrzte5QdKL5zK7d7kfaV0xMLeQDzn04Bwag/Wu0NfKkdubtborh/rbjhhJHArxOEUWCmpg8KuXWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtHD+ISg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso10931375e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365397; x=1753970197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX4Svte8gqoaTLJ1gLDVO4a7qJdtBtTgEqouOAtsRZg=;
        b=mtHD+ISgSM+SUfi253ZtmszbOMyw9ORPp7cADqLUVvtUQSh+F2uKGW/HoI+6/G8h+b
         sgquvAhnD90ntjDcj493uMRFktkg0EB3wJdjEsJffTHNTqZvaBbR4T6UlnV63KAgJu50
         m8mhqe8AUSug1EtN8ewwaTIHIaTaMF1/2/ELIKaNg7AZaxcfN+A1nTo23afrhhqnk0mc
         yzsgOXEQE7HAgnyWUvWTbiCJPteSDFEDgILZsOtDaEweLOzn4WmfwXgGka8te1qf8YjK
         qRU+D/j+Wfz273ZqaD6mk4O8BQRoVRpM4s3MPjVrrTna5m6Vj38zKVqQHrOwG1Uq1xQr
         d6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365397; x=1753970197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX4Svte8gqoaTLJ1gLDVO4a7qJdtBtTgEqouOAtsRZg=;
        b=fqvxfy570gEfhOeGgFYQztkCMxKxQu80GEW3p9QGrd8WtjN4pNAHHMbiQdLE5RIfCA
         lIDVfnROhXUzJOjNfWr7qEWHbQO4se+f2ssEkM22dTS6icetqlIYIhlJo5p50aTrJI4v
         Ns5pFfXNBucHl0aqxd0UFhaMlFBYw//ywOAd0CREQqanKGymVaUu0eequQfCm3NIIwIu
         f9O2Xfqchq7tVIUx10TsXMJDACNhr6IUO79NaDyYYdwUiFZDobk9IpCphPW16mWw1Qr9
         eTjBQ9aX9F92uSyXNskZ9NsS5LYVzayEsK78ifwKhUrcKYT1/9rYjdKJJvelmqkZz5Lw
         kj/A==
X-Gm-Message-State: AOJu0YxWb5z2x1j9YAM661odW1bEas5WCpF7+NNyMk54+niAgYEoTYOR
	zLdJOoLAye9MGkjzTe0Tg8+CRT6rCqOZFnJ2JaTOsvz0r/NN9qX0IILxnLuPtIQTG4p3wlpTdxZ
	+nY/MWd4=
X-Gm-Gg: ASbGncsrTU92zU3vsPy9xzqza7/bNHxiRZZLQhSdWBrXyTdBpwC7BA6hBmfIj0dFPXW
	sETYSU7QWjpx1IeJwj0c3a3Tl5TFWdFQgC+o928Ty7CmOGOw0FYqi9f3CTktGBzJtmPjzIeQm+e
	P3cV0mCU3XeC6oNfy6XJFI1enkq9bFc3rH2OqH7ir1fZV+fEpKQ4Zo3eegi5GqJj/qllDvwDKSI
	22qmLPB09FyM6+VJU8vSBcBEe8tuEI4L2mPYAYHbwIhkVpA2NwgTUvpLn4pKxVQdcFnOouP8e7q
	Y/gVyeMEyEBI2VU8FVEJe+NMGXI+/EjORz8/faucPcgj/0OlJ4KVXiCTYQ345bztB/Ldak8d+fT
	gTXC+Ai9gI1yJLaqHsZUJKYhVS5r73DExke2tU0Nqf/SDOx4lUSsWhi/5xs3D3wOoMMbkw02IMi
	7ZJvsx817Pk3IUED53ZPniv6U=
X-Google-Smtp-Source: AGHT+IEQVvnmK8e1EDhTYEG0c9433X/scuppejD17sDlP6XiymAvLgXWbUNkWttS4mn1l7PUSu9quQ==
X-Received: by 2002:a05:600c:6090:b0:456:18ca:68fd with SMTP id 5b1f17b1804b1-4587118251dmr22564675e9.10.1753365396747;
        Thu, 24 Jul 2025 06:56:36 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:36 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 16/29] mm/show_mem: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:59 +0300
Message-ID: <20250724135512.518487-17-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - _totalram_pages

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/show_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 41999e94a56d..93a5dc041ae1 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -14,12 +14,14 @@
 #include <linux/mmzone.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
+#include <linux/kmemdump.h>
 
 #include "internal.h"
 #include "swap.h"
 
 atomic_long_t _totalram_pages __read_mostly;
 EXPORT_SYMBOL(_totalram_pages);
+KMEMDUMP_VAR_CORE(_totalram_pages, sizeof(_totalram_pages));
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 
-- 
2.43.0


