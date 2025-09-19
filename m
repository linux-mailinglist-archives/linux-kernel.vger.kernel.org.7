Return-Path: <linux-kernel+bounces-824580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139B3B89997
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CF56212EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551830EF75;
	Fri, 19 Sep 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PpOulN7u"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E030E0D5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287204; cv=none; b=TCdZGDeiBe967Tq8q9FyoUKsa42xPsWQQ7odGK5ZuKymkBInlVRKYw93fycVYlScXsZ5Na4+zQnTfoIwRxulh9Tmr4B25Svo+rY6Xepu5BLzjdRa2OOCrbHjeCrVjhgaYPENF9NCqr/SoXz+uCH8TzuXx4PzMuJK6d5HY0Szg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287204; c=relaxed/simple;
	bh=0lV9n5XumzOmt5g4UMlg/xhpB2acjFtIiesr6EkRr9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouY6wtatrRDo0K1+c2lr0CT8TIUs7MHMyhPxfEjKHyg9NRGIyB/DRoVuoGNSNiyGUhvjTblZEx5BzVQZRhuD1gWDPtj0RXYu+EECouxDlZHXXVbtzo0hxsaf7X2Xfw7FGjTvvG/rwMUL4T96PeB+l4tMxPRzOQnJU/YHkQaJAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PpOulN7u; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f0efd84abso243969b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287202; x=1758892002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5qgH2nc8AqvE/lFKBkchQmBG3HVN139FltrQBIQhUQ=;
        b=PpOulN7uki5+hzQz4US5ghDrAzEDnSF7m0uH6Ut9rAlx9Z3+9mC9T4E+pvXD9cd5s4
         31Z3G9IXMUYMNjbFonZgLP2Bpm2BF2p1VeMz69xbeyFxCAa5QUIlNgPHYRnnSEGAb78E
         VLEAuGahP/K3GZSCblpcVe0WJhgeKQBWZJrx7QPler5UHdRVOZaOThKoGa4VsBTYbNFh
         n3JkSWf3Q+wkrHSwubByJ/XFrVFrvYJ1KMO8kblzsocE8hq6Tz+ApqjaMWbdLNam5ugW
         uEoVaVlET3bXSVUv6kc4R3jroa/vvcEtl1hb9nP+sJyv/yZFTAvuxSGBkaWTOWcOLrEG
         7F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287202; x=1758892002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5qgH2nc8AqvE/lFKBkchQmBG3HVN139FltrQBIQhUQ=;
        b=BmRbkAXCXyjH7+YNcOJajO6trK0k7wcEWXUSvjgfCchGHIMBMoBTOyTaF900zrsA9R
         jP+F0xrSY9JbnYf0jbmm1EPSg6rtMhPZPvl+xpJIAUGRfJ6QZweD/1EDFe+2+CsIHdBW
         32B3EjFtuXl1A7j4CXz+0x1RUgkQLqYSnbk6sWlcA9QvbF5Z02ltmdGM15RciQLmXR2e
         ovvB+e9g0nYZWIFV9HvKtLYYJxEe4K/j7A11yEtHAw7CFnKShNrGmIUrIpMU+nxaiUvV
         734DAD5j5qXcWpDknMx0OXCvDWlC9DT39qHn9ChbBFPMa/49Pt4+I+fu5kOKvubD3Rd3
         tUSA==
X-Gm-Message-State: AOJu0YwdMgXF8ZM/tV534wP9kUnUvvt/me9AizME0yoiT+z0RLwp5dSa
	K9QNVfBYqqfzKMkrx8Q3+wQbY2NhcT/QabRIfrP5faGng0WvyZFTLI/IavrNywe+OFP6MIYIi4j
	1cvqH
X-Gm-Gg: ASbGnctAXMNH9ca4QNgKAd1n/MAFeVxIua3zciokdfoWfea73oWgELhSexvRj/SPRmN
	+mvKoCx77J1I1zxWbB+If+pVxMTftt2+uCGb1uxCOMjMvV3JCHEsoYi1y6ULvDOuVB4q75ZIm6e
	RoXhEBD6CiVAYDS3e7FtMC079FZZJq9UPdAhi04qnyHmNzO4fD+Ghhx4Qg2mFXd7UM/Obp8vpm3
	bs8uHHn7HGPsE0iXkCv9lodBHIWPKkEn7Z+m4U8nSY/zKhP820EPbQevaUKeqxCQ6Nd726HXe2K
	bw2WQyqlno4bMjf/IjsH1ZeNzwPzMBeZ9V9I+repDY1iNeTDwtu3tMBXL1WO2s8abpkdPKPoZlK
	R2+8yLw2bl0Suslru9pL5aXL/suoKEkG8V57WO1mEd0Ikv/6Vtl3uwNdDSw==
X-Google-Smtp-Source: AGHT+IETDD2d4OAR9jhdP9S0YCuERWs+SfZaIxhjukdFizllZQ8yfT5HmxT8Qc7dOByRbeeQsSjHOg==
X-Received: by 2002:a17:903:1b68:b0:269:b6c4:1005 with SMTP id d9443c01a7336-269ba552560mr39859765ad.55.1758287201584;
        Fri, 19 Sep 2025 06:06:41 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:41 -0700 (PDT)
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
Subject: [PATCH V2 4/8] mshare: selftests: Add test case shared memory
Date: Fri, 19 Sep 2025 21:06:16 +0800
Message-Id: <20250919130620.56518-4-linyongting@bytedance.com>
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

This test case aims to verify the basic functionalities of mshare.

Create a mshare file and use ioctl to create mapping for host mm
with supportive flags, then create processes to map mshare file
to their memory space, and eventually verify the correctiness
of sharing memory.

To ensure these tests can run on any server or device with minimal memory
usage, we follow the steps below:

1. The ftruncate size must be a multiple of the alignment size.
2. In the ioctl(MSHAREFS_CREATE_MAPPING) syscall, which determines the
   memory size occupied by an mshare instance, we use 4K/8K for normal
   pages and 2M/4M for hugetlb pages.
3. The size used in the mmap syscall must match the ftruncate size.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/basic.c | 82 +++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
index 35739b1133f7..54a132a8116c 100644
--- a/tools/testing/selftests/mshare/basic.c
+++ b/tools/testing/selftests/mshare/basic.c
@@ -3,9 +3,87 @@
 #include "../kselftest_harness.h"
 #include "util.c"
 
-TEST(basic)
+#define STRING "I am Msharefs"
+
+FIXTURE(basic)
+{
+	char filename[128];
+	size_t align_size;
+};
+
+FIXTURE_VARIANT(basic) {
+	size_t allocate_size;
+	/* flags for ioctl */
+	int map_flags;
+};
+
+FIXTURE_VARIANT_ADD(basic, ANON_4k) {
+	.allocate_size = KB(4),
+	.map_flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
+};
+
+FIXTURE_VARIANT_ADD(basic, HUGETLB_2m) {
+	.allocate_size = MB(2),
+	.map_flags = MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIXED,
+};
+
+FIXTURE_VARIANT_ADD(basic, ANON_8k) {
+	.allocate_size = KB(8),
+	.map_flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
+};
+
+FIXTURE_VARIANT_ADD(basic, HUGETLB_4m) {
+	.allocate_size = MB(4),
+	.map_flags = MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIXED,
+};
+
+FIXTURE_SETUP(basic)
+{
+	int fd;
+
+	self->align_size = mshare_get_info();
+
+	fd = create_mshare_file(self->filename, sizeof(self->filename));
+	ftruncate(fd, self->align_size);
+
+	if (variant->map_flags & MAP_HUGETLB)
+		ksft_print_msg("Tip: Please enable hugepages before running this test.\n"
+					"For example: sysctl -w vm.nr_hugepages=2\n");
+
+	ASSERT_EQ(mshare_ioctl_mapping(fd, variant->allocate_size, variant->map_flags), 0);
+	close(fd);
+}
+
+FIXTURE_TEARDOWN(basic)
+{
+	ASSERT_EQ(unlink(self->filename), 0);
+}
+
+TEST_F(basic, shared_mem)
 {
-	printf("Hello mshare\n");
+	int fd;
+	void *addr;
+	pid_t pid = fork();
+
+	ASSERT_NE(pid, -1);
+
+	fd = open(self->filename, O_RDWR, 0600);
+	ASSERT_NE(fd, -1);
+
+	addr = mmap(NULL, self->align_size, PROT_READ | PROT_WRITE,
+		       MAP_SHARED, fd, 0);
+	ASSERT_NE(addr, MAP_FAILED);
+
+	if (pid == 0) {
+		/* Child process write date the shared memory */
+		memcpy(addr, STRING, sizeof(STRING));
+		exit(0);
+	}
+
+	ASSERT_NE(waitpid(pid, NULL, 0), -1);
+
+	/* Parent process should retrieve the data from the shared memory */
+	ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
 }
 
 TEST_HARNESS_MAIN
-- 
2.20.1


