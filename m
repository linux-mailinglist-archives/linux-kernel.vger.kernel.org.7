Return-Path: <linux-kernel+bounces-824581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6801B899A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC73624132
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854C3101CE;
	Fri, 19 Sep 2025 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Lv+f3nZN"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00BA2ECD1D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287208; cv=none; b=qs4O4vy37BSVTU+yl71Jfoo4xh0wS9u+KzUoDgDz81JBHZLiNtb8UCe9vovSa1ptswfoAgwxl53kfsLcC0KcWrsAvL+RGeqUDaXW1BhUVAaFwouvqDJEBcBXro0ZJOfCAA9xzNubZjJ4d1G/MoAP29w5veFirfWzrXdYlqszLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287208; c=relaxed/simple;
	bh=zK2ErpD/lYmYPzqN8aF+TKv2E5RRqIF06vvCc4CNo18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ue7XuHXnXx5GnkQyHc94pbb5URcce/m3Jcb2j1tKymMdlok+jCmLlcTiunq/1n5sLJJ5lIvHJVGdgPTtgPlt2Sa7WjsHHf3AYNrQEXb/F97ynhILl3ijA5WAt04hEMxUBpIjU35CH3FQgZr6+WjC6lzIkOBaVDmKZEE2icyPSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Lv+f3nZN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26058a9e3b5so15791525ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287206; x=1758892006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D2gBtzp3mLNn7VCJeOcGuzlcq9LYd+KGJxoAWDsv6A=;
        b=Lv+f3nZNjMu0FY9ifpGj/EONH9QS5niDii6AjW4LqIyjGw6XFNnujfmWlIidsTNgRM
         fXoLHsFJDS3u4eSZi5n9qk7C7Bd5KBBxr8zxT6Jc7dL6AMJdrFpcP0CRej9CZButAd2/
         fstiYUBwNa2cGbpBHP6yDHa2KawTu9FqqLTb5RE824N1tWZehZH8JA0vnt2wssT/aPbO
         efXt1RLj900BI8usiLmvhAcgsegBOE84lwrFbL0JoWafkD884ew07+6PQcjQ2Ne9KRmU
         4Z9pPwjSL6SzRVznQUxe3uH4Nvb1bfT+db7XuZgnGWe/Re0gd2m0G+mJVC9SwI9wI6kX
         so8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287206; x=1758892006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D2gBtzp3mLNn7VCJeOcGuzlcq9LYd+KGJxoAWDsv6A=;
        b=G16F+7a7LcfY462DR+B5kQ2oPfPaEG68INPUQWE4wnCrbSSKX7sHqFtqxjHFzn79W2
         uR2Avd5A+OpByhbVkxWGYOL6x9JS+BjI/o8ghThuFLIV7kyxIdaHJCzjyrY00oiJDrGo
         D81cII+DrZ1esj14AdxITJyVkYX1m2hziSs6CFxabloknRm3S9/m6a/D+VzSn/SZktbp
         1925cJNP8Q/M1ujrzxvOJqgQRV3AAi7gblytQ20aS4ddFy23QNXtcpTmnx8thS+7doUg
         1dOJetw8K6iBGFuB3PaPFwPXG9fBwbk85cilPyLNcqWVMx2wNg30qekVp2Wp0V2sbvph
         AUNA==
X-Gm-Message-State: AOJu0Ywn6SE0ioMIuPh2qWpccdsYA2EZp4Z7S346jJk6QD/PhomzmEAr
	laIvT4c6tBLB9DpH14PA5ev0wqFWvSV7Rl8hBEy+65+3tyCTaNIBQc5aca6MHUPa1UI=
X-Gm-Gg: ASbGnctoqNtEQCJqht5Yreda2MXXDwDEzk+3sBVR6xMz2uI8G+vweGunisuQJF9pPej
	oPz/DKdVCutzj8U/Ce/2MI7LK6fRsMdbXvvUkwXJGyu4k//1UaMnpHFADKYGdU3eAjeeGhGG062
	tJ1T4APulv25pFYfuBekIkzA7+DuosTBzxfqnX7Gm/eIywdt2toB4wO3ty8SBOcHXoaXVWQMUPS
	V6lkAYV9gD5PEznPdHJTjkq2SpwwH6ece5RoL1d4gw9K+U0zFJtxJ09UCtzoekdKqfq2LvGu4F7
	xQP9V8/C71pFcbrNPqxIyzzyv9fe5k8ELXg1/KBTRSZNGQ5XO2ZiK7MvN7sBpg3GlNffTj5SGoE
	8uce7wW8DMKSMKvFd40O5FtwkqS3gmV/wG+idRSIK0XZCAObMfhcwJApz2Q==
X-Google-Smtp-Source: AGHT+IG7fMWI+kljj0ibuMWdDKEsXTDgf6PpZq6UXhyPEeUouJT4wes4hsUgSHy9QJ4Nl57jS05FAw==
X-Received: by 2002:a17:902:d2c8:b0:249:1f6b:3268 with SMTP id d9443c01a7336-269ba44c38emr56802445ad.18.1758287205777;
        Fri, 19 Sep 2025 06:06:45 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:45 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 5/8] mshare: selftests: Add test case ioctl unmap
Date: Fri, 19 Sep 2025 21:06:17 +0800
Message-Id: <20250919130620.56518-5-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case aims to verify whether the guest VMA will vanish
when corresponding VMA of host mm got ioctl unmap.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/basic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
index 54a132a8116c..043d1f3e1e3e 100644
--- a/tools/testing/selftests/mshare/basic.c
+++ b/tools/testing/selftests/mshare/basic.c
@@ -86,4 +86,24 @@ TEST_F(basic, shared_mem)
 	ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
 }
 
+TEST_F_SIGNAL(basic, ioctl_unmap, SIGSEGV)
+{
+	char *addr;
+	int fd;
+
+	fd = open(self->filename, O_RDWR, 0600);
+	addr = mmap(NULL, self->align_size, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	ASSERT_NE(addr, MAP_FAILED);
+	addr[0] = 'M';
+
+	/* munmap vma for host mm */
+	mshare_ioctl_munmap(fd, variant->allocate_size);
+	/*
+	 * Will generate SIGSEGV signal as ioctl has already cleaned
+	 * shared page table
+	 */
+	addr[0] = 'D';
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


