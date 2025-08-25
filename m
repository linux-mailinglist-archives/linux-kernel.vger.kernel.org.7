Return-Path: <linux-kernel+bounces-785032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAEAB344EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DC416D47A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87B302772;
	Mon, 25 Aug 2025 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QYjzM4hG"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DD30274B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133901; cv=none; b=YFRTt5Jnyy7k5MNS5AAYZ/3jpyrXVCIKitI3899YgrGxQ/JK66aw3vlTQ1PjTFaBYtmMBrQiLQzvtg6HfKDsRyb6f+YxlUCgUWZ4SYqixgOxBrnHQMpRDoFRtUcuIRW4IkUZpQv8nYGSSpKkz8Yx/2U1v5by9AV/ku8uGep6WRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133901; c=relaxed/simple;
	bh=xY16xtdVzGEfaeQq9IN656McbF+sKB7TIBPK2joy6Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MeobsrmVttseBZY/tKMVUo9CJXczLSaS1VAPXhjT2SiQWVn+Opl8pRD0KThW5MoLJsN6IjCZJLiO34jhvy1EkY5w6azZ5/vEsND9erpKX8e6U4SECLYp/3Ki6xghxI1zWzqcqhTNREYxa1GOsPoh7cf1vovlc9BQYDUYzq0TEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QYjzM4hG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-771e987b4e6so632752b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133899; x=1756738699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4tDabwrjUnjyF2pNuKY+D/uJFltgF7p2tl2gzeMXdU=;
        b=QYjzM4hGHNZs0ObFLZZCcPYDz8SHcYkJHMjkYal3qyfKgytxEGrLnaq+YNI0A31hQO
         Lr63gk52wkvzarussEVjdS0m1m73vjsFVBA0d/dWIPB2QYUS12+U+ctexj/1/nGO27Qc
         UmQ3oKOabZjI3GUETskRKSgZ63Vk046DQx271f39yfd2ISYbZJF2P0A0Ecs3gMjH8ztw
         UDRhAInwHbQZggVvBiJMgL7DqPOGKoC0FEYwIetop/PMVeUvI69yMzfAWlDfEJG4OD5U
         KPUSpClOKkCNqSDAtnJ0+rXrAcItVXMo43xvShMl2VM8XfrBD0YYTExgTBbo03kFQWWI
         mpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133900; x=1756738700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4tDabwrjUnjyF2pNuKY+D/uJFltgF7p2tl2gzeMXdU=;
        b=Ce1Y3CXnYvWjkQS53qQpgRFTCGA4GXMYT0++6flwsfsi0LtEsHDZ/axM5IbgVI6w9r
         KwH6Ub5zvSkUMLLIeaY1OveIpjVNsbhT7QQQq0YlKcIJIf8JXx32yZGU/RY4jo+hnmsF
         FJa/OU5o91xP0WH84PtK/oPfN+3OlUFKO6M0inamdr1CYoCfcvU5wmMjsqyJp/wqFi5Y
         cgCN4d4hFNRFfmPzQqHvRm5Yf4a88RIaZ06PdrhGdjUhd7EJnvPc+r5X9t/GmrqXFIsD
         DPlIxVCIL+O4YZev0egYIgoOzQsFVhm+AbOloPPnGNdMkm3gZc3U1yODunRG3dAU6ghw
         Vrng==
X-Gm-Message-State: AOJu0YyCqioBP4fVqcYmHVvkw5DyKP8L7zSGe9akzdU4/4WjRcuv3Spc
	ZakCgA8AFrV/EcGmE8lz/zP9+j8opO0riLkwB3m+5MBrHf+vCECVfjs3jC/nlYJUqIQ=
X-Gm-Gg: ASbGncvwtl0XBcpKouB7nN2KsFr8in279EZrjMlZSywZTIxHk+h4vm+eTqipYnEh5H8
	vhnNnPTkI9rH4UGeheAr/TkFBckN61WpXmV1RQFpR/7piURfjbROFs2wHY1+XIQMfRFwREfjXz7
	+Nqq/dU+Q63F+AMmQL2VZvSRFvLYrX5vBQxDHT8Y0qMVdjkiBgh6RaSMVa498Gt6gTqiwwPsmEz
	f6yq8PQixD61LXspPGfF3XSqQMUfSzFLmDhZYCShc3hszDcBTfjS3O68r0PQ+6S4YKdJeIVwb+e
	/lfFvDM/enuUF0EvfSiAq0ovia21F+daF2Ae25QiewDn0Rq9Yb/0BaJkmgeQtCCy47APRWh+cLA
	+tbIvJvZ7eaDm4Ihtcu6bfIIBM0ioXvWTyNaDzDk4QG2yZizmSFrZvRueE6Tp
X-Google-Smtp-Source: AGHT+IE4HBpFp2FjPR/VhGO77A7Hf4iGpyorA58tgjMrbJX3zjiUolWr1Fp2pgViqY8L4woXW+eoFw==
X-Received: by 2002:a05:6a20:7345:b0:240:195a:8333 with SMTP id adf61e73a8af0-24340bff9bfmr20854855637.14.1756133899572;
        Mon, 25 Aug 2025 07:58:19 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:19 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mshare: selftests: Add test case ioctl unmap
Date: Mon, 25 Aug 2025 22:57:16 +0800
Message-Id: <20250825145719.29455-14-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case aims to verify whether the process with guest mm will
segfault when VMA of host mm is unmaped via ioctl(MSHAREFS_UNMAP).

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/basic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
index 2347d30adfee..16d1f63c3ebe 100644
--- a/tools/testing/selftests/mshare/basic.c
+++ b/tools/testing/selftests/mshare/basic.c
@@ -85,4 +85,24 @@ TEST_F(basic, shared_mem)
 	ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
 }
 
+TEST_F_SIGNAL(basic, ioctl_unmap, SIGSEGV)
+{
+	char *addr;
+	int fd;
+
+	fd = open(self->filename, O_RDWR, 0600);
+	addr = mmap(NULL, self->allocate_size, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	ASSERT_NE(addr, MAP_FAILED);
+	addr[0] = 'M';
+
+	/* munmap vma for host mm */
+	mshare_ioctl_munmap(fd, self->allocate_size);
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


