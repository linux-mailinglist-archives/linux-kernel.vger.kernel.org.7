Return-Path: <linux-kernel+bounces-867394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F270DC027B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9B61A6859B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E53396E5;
	Thu, 23 Oct 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNfANo6B"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B44314A94
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237848; cv=none; b=sfed6lyDJTNIo1qQg8qtSbaI3MpcOuGU23qDQtc/1vLcD2aM9lIFfZpbjIswc/WjdScdyFntSPy4+0jric+JT0qyB1uIyENGF8DetuvKChRuQAJUmw/TpXdImsjngwc0Y5J2WXVYTb4KRdrzqMKam6bt8e32U/qfbSDhKkv1m20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237848; c=relaxed/simple;
	bh=8fIX7biSbEZ4B4b77XL+f4TS9/Jp/xnQ/nE2WkTPmO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5GmCoNDfdLsnsFnCElDdoqCeKj49Qx62ocsP/dVyqblAEx4lQ4sz1jRQHjuKNNlW6BKue161xZsSO8ZI097SGaj7/M0VouZyuNPnjMFMMWKzj0Ybq32SjKxsza/2WWhLvVKAF9gWQos7OvKjOfXGOYdSaeG+5tCRWIDcCEQ6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UNfANo6B; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so920523a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761237846; x=1761842646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBSNSnNcjQaKaCnCJuZwnw3e0fnN82ayIMOAkE29L9Y=;
        b=UNfANo6B8NSVzy8e1ma/B97PuCjyURVP7TRevV1niwA32P0DuFNbUX+ZWb/htdYPgf
         KCUTcWls2F5vwBfCZ2kQ0/LfYASwdQdni06efKEmlvBPpETt8DZ6cm6DuuBmIBvLBT3B
         8ZsMmRQsHRs7vFUp/gCXetMYabgeiddOMDnyjT/vilJDmf96i+RSlfIN95b9jSjDmQ4T
         i1fnBQ7GhAYxdFnJrCAXKl7t9K7JWBLTlkTWKV62wEQxsGs5BAmS7YhCKu4b6WHAC6QN
         iNNcVBTRZvQmDlPPzpdC8nCRtHg62OZJkqM7R54QQ3DD5W6pxF2Goz7lGnybBXSzDZp8
         okMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237846; x=1761842646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBSNSnNcjQaKaCnCJuZwnw3e0fnN82ayIMOAkE29L9Y=;
        b=uJjD3rA3L5g7ntTmXFwxa0HLiIT0N1OjoN92BPFvdI7NLii1oXrAOWtEE6BwQfx/0Y
         717OHHjSC+87FUJbqemgWah5UCBTJ7y7urHnRf0opOHuhJHkxYpsOio8VOy8riGOvJf1
         JAC5m0SsJZDiVUsYpdyGdatdHDn1BJLlNxbh1W+NB0kmpLBIE2rpcN1hTffc/sf857Z+
         e4qzyaftqXjhlSwMOFhA2mLVrWjnGVC6vgE+OaDOhJlf6eIwMLXWKsPa2eK1N5jg0R6C
         anY1b6UFy9qwy3qMTAd2kVnDiB6g1tnESzDuryn7CqdQjaOjEUciXqUlYxM/rPyTfjLD
         Jr1g==
X-Forwarded-Encrypted: i=1; AJvYcCUdrYyJrJHY79uARZK1rqv4KGBXhYMW+j4t3U0baM+J8oTL9imRD6c/wFRzpuciurCDBGJhffyJOe+m4ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5phT08LSzsVcDX8E7HntG5thHryPuJpuXRNxixsI24Ha32wqg
	CpxtQiatA+LnTOyGMiX7lc1v97aAwqGSQmxeRxA3+m5X3CoE0fJXI0mTs9AgIRm9J/c=
X-Gm-Gg: ASbGncsW3va283wsHAC/khqBdaZ3kr5xCQCZ/6gy+Muhql51XSHJlNckU5Ici3oPXe6
	xVKQ0Pzt7GjDz1D41la8jGsV2IPvDbgq6O6EzBj3KPSLdS/6At5oZKdI3cAFEVKFojMEFx/O1rU
	2GHFGLrSr4fFZUtqnQrQDKVjEwS8CTGi0wTx0aiXyZrTEur4wt2vIHavciM/NKoPPpKiAgzoYuW
	/GOoUu9WvZX8P0HgkA6vyHMREMrlC0j/DbIeoLoxXHPhabPeI4oK5gxe0TQslVOWn/X2sMEWZej
	qM8rkGmwcIgX5zvgSRYkDPP1zKJzcBe9pnYze/dThEcDjzB5mSpGlz/mLskCFzBC28ZcSACIPra
	i9Ahy7TNr5tHhkfKwsoQWMokYFZ/5XBPjCNqW8OJ/6Mm3gtP+6fK1fYmtupRGCBc3dEiNhoD1l8
	vC+YportiMxC2dfqIEZGGhHvLxn6S1rL74WBa2QUJd9FYz4EqvxQ==
X-Google-Smtp-Source: AGHT+IE4pFFH1ySU5m3ad6i6VUzfPRs66wcF55zEy8vDarPljKErMuGfeUnYnh7PBCKkJQkt4U7EUg==
X-Received: by 2002:a17:902:cec2:b0:282:eea8:764d with SMTP id d9443c01a7336-2946552521emr61649525ad.35.1761237845759;
        Thu, 23 Oct 2025 09:44:05 -0700 (PDT)
Received: from localhost ([2405:201:c00c:2854:d184:69e6:58bf:965c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de0c894sm28713685ad.47.2025.10.23.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:44:04 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: ltp@lists.linux.it
Cc: lkft@linaro.org,
	arnd@kernel.org,
	dan.carpenter@linaro.org,
	pvorel@suse.cz,
	jack@suse.cz,
	brauner@kernel.org,
	chrubis@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	regressions@lists.linux.dev,
	aalbersh@kernel.org,
	arnd@arndb.de,
	viro@zeniv.linux.org.uk,
	anders.roxell@linaro.org,
	benjamin.copeland@linaro.org,
	andrea.cervesato@suse.com,
	lkft-triage@lists.linaro.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH v2] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid errors
Date: Thu, 23 Oct 2025 22:14:01 +0530
Message-ID: <20251023164401.302967-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer kernels (since ~v6.18-rc1) return ENOTTY instead of EINVAL when
invoking ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid). Update the
test to accept both EINVAL and ENOTTY as valid errors to ensure
compatibility across different kernel versions.

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index d20c6f074..744f7def4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -4,8 +4,8 @@
  */
 
 /*\
- * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
- * happens when:
+ * Verify that ioctl() raises an EINVAL or ENOTTY (since ~v6.18-rc1) error when
+ * PIDFD_GET_INFO is used. This happens when:
  *
  * - info parameter is NULL
  * - info parameter is providing the wrong size
@@ -14,6 +14,7 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 #include "lapi/sched.h"
+#include <errno.h>
 #include "ioctl_pidfd.h"
 
 struct pidfd_info_invalid {
@@ -43,7 +44,12 @@ static void run(void)
 		exit(0);
 
 	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
-	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
+
+	/* Expect ioctl to fail; accept either EINVAL or ENOTTY (~v6.18-rc1) */
+	int exp_errnos[] = {EINVAL, ENOTTY};
+
+	TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid),
+			exp_errnos, ARRAY_SIZE(exp_errnos));
 
 	SAFE_CLOSE(pidfd);
 }
-- 
2.43.0


