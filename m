Return-Path: <linux-kernel+bounces-864872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE3BBFBBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95A724E2501
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3B33FE20;
	Wed, 22 Oct 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAfOlSCa"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57925EFAE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134232; cv=none; b=k8TYKsaAATRwWQ8im9gpGQRp1JkmcQW0ghmbVTIU3aMuNx+LFS5hX2SBcJPCTxf0eMFSQjiwapZZQaOqNERS8PoqNgb685B4SCIxDQ+DUdbr5wQZNK7HsWXSarkAwWh7IOGWZwZrLEu4xVO4AbRqQdp9QL+X1LFId78WIgIBfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134232; c=relaxed/simple;
	bh=URTqzJkAAJFoQOPycXd7kEr7wppHxat1qLacnS1FCiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HB5hPTCuoeIlwJcmBYNKDogoPexh78p6m+ZPcuIOrNSLLH7Qy58lz4ab3caXM2nJElgjuncNE6ViUTQ6IopsZwpJRKsfKl9RNLlEwJ39Z1189xYaGAKzKe4HCIWO5IOSVy2j/LoT/L3aS1oiP6jYalhrfGbqNNC6rh9vMcFYF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAfOlSCa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso6198561a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761134229; x=1761739029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WzfUG+BqfKD/coIQsN8R1l6DNO8bGUEyk6UsV4mKerM=;
        b=JAfOlSCaYsES8eqnvLfEbXJcW6WxBP77WG4g8H3pSYshm1aaV5ND0ro4E4OHDTS8+G
         Rq1Op7BFiCWw7iyrjpww+F/hdTU3cS1ZuK+Gw96SdUuaKQMLzf66XjdwCw+FqEYLKBXH
         EcX3rk5okm/EdxPgi5ml2rtgXZd5a4qweNmZeUsK29hK86xT90KSPE+//HsOmtH2+8Zd
         eOnH3x1DVi/nwETowceEGoDCpMrm1llsvcjfn3LdOUBHTAaHjMnLydTlvfu4PLes4Ldk
         7l29PpssC3+PxWGvp1rK9InHT/YmGZSebA/jPCBvo0Ly+JGO53VR4efERbXBQg8XUAHu
         Hy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134229; x=1761739029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzfUG+BqfKD/coIQsN8R1l6DNO8bGUEyk6UsV4mKerM=;
        b=MLlHA4N+tKU5B4erIM/7Ihrgk+MG8ey2EaENUguc6U4AD30/vTF9rzujdEujyNcUiG
         CKkCGOInS75zuoRe1gwS6v8tYH3/ONwHl44Nroov6FP46PKWDDmRMOejI023zHLdrQhf
         3H/s97kQ/lY+r2vvdUC6BoWkudCZMDl6y3NvWFEKnCTczeLQYTiGMKmSlc4yWpNYzA0R
         719+l47iW8ZnMeQt3OI4WjpgEUw3j2tPJEhnGiMWl5nCWJZJRA4uFB/H7ed0Y/FD4XuG
         ReurfvQqH0Wq5/3rci/HDFVItF/hUQX8B1lAl8NmnPC2pzdXbkM/30l3rWeWGhoHM1ij
         5w8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJy/FZYb71LoX8tjPteqTXx71QqZLdYx9Jx61eIlLnGlNyfV/woHRIeTC83vwgdHw3l7RZCDzl5reReSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACkNavc+FtStSSZIdJlzPTBAZOy6DZiCUOhZ3nTmvlcOiiX3l
	FF4E+38OKRcu8+EX5YYW+OZf/ceKLDp3tnUFw499jNqxS4Bgd1hrOqbfHI8pXJGWlnk=
X-Gm-Gg: ASbGncv/tljAbues86b3jw4Oji+t4KAwAFxpZdNc+a6i7bAwvrR1MSb+3x+GGzerNZL
	eOagxVDk4jYJL20kCUOsOMBy/q/DRZ5CUdmppqHfQqfNhnAImDQqnxUhaocA33S9lxqhA4uaB65
	352Rhtfyi7FQ/+WTM3rR1taU0/wlUeVWWVjISXimY2r/p+qF0NHbjwe5mA38aNnmI02UdNPF/pG
	4VDbZVsxwKmRPrNCvxIS7rXzRCzWoAIrT/6AKZPYT+VbHJzeuvagsRdHsA3ZDKmELg/0MH7kt8S
	AdKpbRSLCPoxhOjUJy/JYdZ1a3ZlokQ1mGM3t8mVtDNpqN08/vqNv9ly4mWcPHarvSUe2o4zoeI
	VHSTXRAanV0gVxcgcbUWFY+EOAhQ+FsWDbVh69UWnR9ZhXqjIKz2kBlDVn/+2CIIFbS1Ps41XHp
	sJwEUTlzRtCgGtrTMNNpxOm5bJc9C26e2aodunkiGRkEDS4ZE4gyUGBq6bKQ==
X-Google-Smtp-Source: AGHT+IEubD0OvI6uVVM+gnAPZHbQP3Rz7U+Y/YydXiR4UWw4SnGLju39L4qJ5sYEmZqdZYH8YZdr7g==
X-Received: by 2002:a17:90b:1dc6:b0:339:a4ef:c8b1 with SMTP id 98e67ed59e1d1-33bcf8f7802mr26421431a91.22.1761134229471;
        Wed, 22 Oct 2025 04:57:09 -0700 (PDT)
Received: from localhost ([2405:201:c00c:2854:21a:7bd8:378:3750])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e22428b1esm2401348a91.22.2025.10.22.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:57:08 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: ltp@lists.linux.it
Cc: lkft@linaro.org,
	lkft-triage@linaro.org,
	arnd@kernel.org,
	dan.carpenter@linaro.org,
	pvorel@suse.cz,
	jack@suse.cz,
	brauner@kernel.org,
	chrubis@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev,
	aalbersh@kernel.org,
	arnd@arndb.de,
	viro@zeniv.linux.org.uk,
	anders.roxell@linaro.org,
	benjamin.copeland@linaro.org,
	andrea.cervesato@suse.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid errors
Date: Wed, 22 Oct 2025 17:27:04 +0530
Message-ID: <20251022115704.46936-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Latest kernels return ENOTTY instead of EINVAL when invoking
ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid).  Update the test to
accept both EINVAL and ENOTTY as valid errors to ensure compatibility
across different kernel versions.

Link: https://lore.kernel.org/all/CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com
Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 .../kernel/syscalls/ioctl/ioctl_pidfd05.c     | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index d20c6f074..ec92240a1 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
+ * Verify that ioctl() raises an EINVAL or ENOTTY error when PIDFD_GET_INFO is used. This
  * happens when:
  *
  * - info parameter is NULL
@@ -14,6 +14,7 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 #include "lapi/sched.h"
+#include <errno.h>
 #include "ioctl_pidfd.h"
 
 struct pidfd_info_invalid {
@@ -43,7 +44,22 @@ static void run(void)
 		exit(0);
 
 	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
-	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
+	/* Expect ioctl to fail; accept either EINVAL or ENOTTY */
+	TEST(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid));
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EINVAL || TEST_ERRNO == ENOTTY) {
+			tst_res(TPASS,
+				"ioctl(PIDFD_GET_INFO_SHORT) failed as expected with %s",
+				tst_strerrno(TEST_ERRNO));
+		} else {
+			tst_res(TFAIL,
+				"Unexpected errno: %s (expected EINVAL or ENOTTY)",
+				tst_strerrno(TEST_ERRNO));
+		}
+	} else {
+		tst_res(TFAIL, "ioctl(PIDFD_GET_INFO_SHORT) unexpectedly succeeded");
+	}
+
 
 	SAFE_CLOSE(pidfd);
 }
-- 
2.43.0


