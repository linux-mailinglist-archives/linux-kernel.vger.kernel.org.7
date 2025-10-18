Return-Path: <linux-kernel+bounces-858874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F8ABEC1B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8802D409B02
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30AA165F16;
	Sat, 18 Oct 2025 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGVikpJR"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A54C6D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746052; cv=none; b=WK3Zsjor1qyD1e/7V6TE3LVNTi2wTFtT+UdG2UMV00kEGkYJ1xze64IOieH7mZuSUhefOptb5PXjmDomeH03sc6EvFMj1GcsoVWsUwxPj5kWanV+GjLBZf2RVMh309uXwZHTThW3X/8v9auG/nVOUNWoD+oAThETsSOBglqgtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746052; c=relaxed/simple;
	bh=afY24gYMOzFwsN2znmzSRT26NkKpjbP7o7rl1ElinpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6Tj5n3KjQp9QNoVLg9swnArqIsc2Zg63NOYlwiHo86vN5z1Pv/3UQ1afhRhZ33EdocX3dhbENh4p7uc/8pAj1zDPUR8inlUQnB6mSZXkbWkvc9OhVy3Cw6/oonji8L/TXt67MQCc8TxXUmB99/LModU6j3XPYawDNntzIlU9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGVikpJR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5535902495so1508417a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746050; x=1761350850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNSocxtpFlgaY+aG50c0yJJqecHAawBvtAXPRByH/ak=;
        b=oGVikpJRWfx1eKWBOyvjW+yHfgyLS2+dTuKRql4FyluA9hkvehtSSNiF79yNJzxvd9
         pUcrGsKrXbrVJOk1ZXZdKndVgyeLOMah8CL4EhBIxZokaYg2OGYcuYKBnYknHyPxU+rR
         Yc1mM94AsV92yh59xPsZ/YKhiPcGAKAObpfNvQU23eRSEeZ1CDF78CkL6iOdeZiSJo+9
         3GRvd3a9cSjozKjBqOeOGPJxvjz05non/WPSSONS8BMug2Z4tsjnCQUyRpGM4xIlAmJt
         BbPXiYopTghsMWxCW/Dgw9L4aPtPn9tsq26ALCK9JbRbLoxdEkwCLRs1rq3Pmn6GAF2P
         OL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746050; x=1761350850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNSocxtpFlgaY+aG50c0yJJqecHAawBvtAXPRByH/ak=;
        b=QjaAvJFpTV6K6kWGjUVFgpvgSknfrUOGPMIx8K+wJ/3NXPW8nUNDe9uhajiqFHB7rF
         HitfLpXbeQW2IlJMENjus6AVVIuUbWSTJyqRtHoCJRXICkUsPvfnVgCBk0714FB7wCuw
         QZeoZ0AS6k5p8RIAe5UJjPWdcMLZIJeL7ksREks1E2fJ4zZ0js7B3BEbXpOSwAbdNE9w
         M2pmKx5Gpehi0im3h1V5gzrdy+Ur0r773fE6Vtbpo+2oKvLVK6RZcFIJk8FNo3tLUqfm
         N7uNii4s1X+zq8wb17Ey6xoADs+UTNKg0Eme9TT9WlTwtQAi3NHS5QgN6QU/QupLksbq
         OV8g==
X-Forwarded-Encrypted: i=1; AJvYcCXoSEa5KoRPOXGzfK/8a+1ymASleKA7FlAZFMjGv7xe9H+JW26Oad7r9FgV/ydTuiKsbX+bwFEAfPVe+RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFS6lPlRWUzeu2/ef+ryhfTGUKPlazr1rvLWc0E8WfOZAONOTI
	R6ZLnR2xBkiyEGfbpnIzxDosL+vffM060k2ieKKUNpZyP291TAnmuEnmmuCe+81nAMG3O7TPee2
	pnKmNmq/inA==
X-Google-Smtp-Source: AGHT+IGw3qLr2xyC1p/SJ0aBXpD18mw5iWsbxD0rBPbyjKzntb2EOMPX2k2cG3q5ct1J4a+SmbU/supTz48u
X-Received: from plpd3.prod.google.com ([2002:a17:903:1b63:b0:290:d7ff:80f8])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2411:b0:26c:e270:6dad
 with SMTP id d9443c01a7336-290ccadb0bcmr53515935ad.60.1760746050041; Fri, 17
 Oct 2025 17:07:30 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:06:56 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-5-vipinsh@google.com>
Subject: [RFC PATCH 04/21] selftests/liveupdate: Move LUO ioctls calls to
 liveupdate library
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move liveupdate ioctls call to liveupdate library.

This allows single place for luo ioctl interactions and provide other
selftests to access them.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../liveupdate/lib/include/liveupdate_util.h  |  2 ++
 .../liveupdate/lib/liveupdate_util.c          | 29 ++++++++++++++++++-
 .../selftests/liveupdate/luo_test_utils.c     | 18 ++++--------
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/lib/include/liveupdate_util.h b/tools/testing/selftests/liveupdate/lib/include/liveupdate_util.h
index 6ee9e124a1a4..a5cb034f7692 100644
--- a/tools/testing/selftests/liveupdate/lib/include/liveupdate_util.h
+++ b/tools/testing/selftests/liveupdate/lib/include/liveupdate_util.h
@@ -17,6 +17,8 @@ int luo_open_device(void);
 int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_preserve_fd(int session_fd, int fd, int token);
+int luo_session_unpreserve_fd(int session_fd, int token);
+int luo_session_restore_fd(int session_fd, int token);
 
 int luo_set_session_event(int session_fd, enum liveupdate_event event);
 int luo_set_global_event(int luo_fd, enum liveupdate_event event);
diff --git a/tools/testing/selftests/liveupdate/lib/liveupdate_util.c b/tools/testing/selftests/liveupdate/lib/liveupdate_util.c
index 26fd6a7763a2..96c6c1b65043 100644
--- a/tools/testing/selftests/liveupdate/lib/liveupdate_util.c
+++ b/tools/testing/selftests/liveupdate/lib/liveupdate_util.c
@@ -38,7 +38,34 @@ int luo_session_preserve_fd(int session_fd, int fd, int token)
 		.token = token
 	};
 
-	return ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0;
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
+		return -errno;
+	return 0;
+}
+
+int luo_session_unpreserve_fd(int session_fd, int token)
+{
+	struct liveupdate_session_unpreserve_fd arg = {
+		.size = sizeof(arg),
+		.token = token
+	};
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_UNPRESERVE_FD, &arg) < 0)
+		return -errno;
+	return 0;
+}
+
+int luo_session_restore_fd(int session_fd, int token)
+{
+	struct liveupdate_session_restore_fd arg = {
+		.size = sizeof(arg),
+		.token = token
+	};
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_RESTORE_FD, &arg) < 0)
+		return -errno;
+	return arg.fd;
+
 }
 
 int luo_retrieve_session(int luo_fd, const char *name)
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/luo_test_utils.c
index 0f5bc7260ccc..b1f7b5c79c07 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.c
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.c
@@ -12,7 +12,6 @@
 #include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <sys/ioctl.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <errno.h>
@@ -25,7 +24,6 @@
 
 int create_and_preserve_memfd(int session_fd, int token, const char *data)
 {
-	struct liveupdate_session_preserve_fd arg = { .size = sizeof(arg) };
 	long page_size = sysconf(_SC_PAGE_SIZE);
 	void *map = MAP_FAILED;
 	int mfd = -1, ret = -1;
@@ -44,9 +42,7 @@ int create_and_preserve_memfd(int session_fd, int token, const char *data)
 	snprintf(map, page_size, "%s", data);
 	munmap(map, page_size);
 
-	arg.fd = mfd;
-	arg.token = token;
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
+	if (luo_session_preserve_fd(session_fd, mfd, token))
 		goto out;
 
 	ret = 0; /* Success */
@@ -61,15 +57,13 @@ int create_and_preserve_memfd(int session_fd, int token, const char *data)
 int restore_and_verify_memfd(int session_fd, int token,
 			     const char *expected_data)
 {
-	struct liveupdate_session_restore_fd arg = { .size = sizeof(arg) };
 	long page_size = sysconf(_SC_PAGE_SIZE);
 	void *map = MAP_FAILED;
 	int mfd = -1, ret = -1;
 
-	arg.token = token;
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_RESTORE_FD, &arg) < 0)
-		return -errno;
-	mfd = arg.fd;
+	mfd = luo_session_restore_fd(session_fd, token);
+	if (mfd < 0)
+		return mfd;
 
 	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, mfd, 0);
 	if (map == MAP_FAILED)
@@ -134,10 +128,8 @@ int restore_and_read_state(int luo_fd, int *stage)
 void update_state_file(int session_fd, int next_stage)
 {
 	char buf[32];
-	struct liveupdate_session_unpreserve_fd arg = { .size = sizeof(arg) };
 
-	arg.token = STATE_MEMFD_TOKEN;
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_UNPRESERVE_FD, &arg) < 0)
+	if (luo_session_unpreserve_fd(session_fd, STATE_MEMFD_TOKEN))
 		fail_exit("unpreserve failed");
 
 	snprintf(buf, sizeof(buf), "%d", next_stage);
-- 
2.51.0.858.gf9c4a03a3a-goog


