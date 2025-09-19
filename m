Return-Path: <linux-kernel+bounces-824413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF7B89255
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBAE188DC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70179309DDD;
	Fri, 19 Sep 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdYT4Wjt"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62556244668
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279004; cv=none; b=QEK/OwamDYW4c4dr+gqsgYutxf04t1kvtJrPOj5gINnwoAPJFSC1kANIp3JhcUA1m1lT67txAespUdZC0uCOfyMKbDe5k3AWaCALbrLh8yj0rKBSDurhSYvh5zNxG3nZ6jGEus0E24LoeZGun0UoiKzJX+kMJpEE8RfxBcU08K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279004; c=relaxed/simple;
	bh=rKZL/H7ypymzwpKKnbem/RnOpyiC4W0s7l9WUy2A9xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oypBwX2p0+sSyIS6Ve77Pq5IIREBUyMiXunaTdw4fg8fO4cLOYDlgN6PDslEhAIiQGlshBJlXidXHE4o9N9d/LUmqn32Jq4W+QnXoLjRXpqGv6Pj0s7awueCcXLcTiqQUU7XdaXh4TLsqVsDEab1MPmE4Ep9pJngFHEso607nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdYT4Wjt; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77e4789d71eso84617b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758279003; x=1758883803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nlPaNwJCwFBeS5h6NPn6J7B9IvDaJFfkhCJEhtD3j8=;
        b=MdYT4WjtSXFXr/13xf4KqDcJmd8iSPe3OfSOD6xFdmwBMzoR1SXuzIQXJk6lZqngLe
         LEzX1mE6aIImNbtf+wR+Pa0hVArdhrJF2DGqevfVx9uhn4tn+P1Jxqz03hTNF6uVTnxS
         PIs/OobPpTU4gaOQiLhRrp8j0cqzvqbJtsIVxdjDfkUr6NRerBUVzmvtVW0vLZfW49GS
         xodywCOljGlCRdjpsjApunyDbBsf1DhD+88rk6x1nhH/HB1xVvqnYYzjYZtN3La3+XI+
         x2f/TY69zoMK6pWtkeQFL5LZg6WLOiKuEuL4ZP892sLFRvhOx33IM7DVML9ZOIDeEXbk
         5JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758279003; x=1758883803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nlPaNwJCwFBeS5h6NPn6J7B9IvDaJFfkhCJEhtD3j8=;
        b=we3V7VKvxDJZzEUHNEpd9uZl7f7yl/SuXf1XxcUh07J/lx8u8E7R44HpWs1YspeAW5
         sE3xO8WzmiH+3z5IGVsJ3hiETkyMW7T75ITKYrMBQdw2IfeAzEXnJGt8teP4urKO/4OF
         rZt43PYo9O3LTteY9458YpGmR9ajOjVF4jVNQ9dCvABnwze3Fa2hOmpFIkUN2h8vmYyP
         qqYZE+g1CU3WE9DucbrYGgWnsDSV5MgykVCEZX7GlzBp6G70vhmxmBtk4hNzn9IfgYUl
         sxNgYWQnlTltRy9LrWqbqL9VcvilBdDvZN8d0oECjqkELTdF/An33WZklSN8y3wZAvPe
         8rbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWrFHHz9wUmtQo4pWB1MU+r9CMqEBGkha6opi4yrWzZc1AeoU6UsAV9YrU7lWMJ1zhHd4JGtsBk4UQJ0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVNbTEhF7LeiTkZ8VKs+2YuZR/pUHhUTrfp3och25xhQjFCww
	p6OrWx+oTTQa2Msj0QoL/CQA2NSPmyffVkgZIlFAp+9B+KQSYMx9f/3B
X-Gm-Gg: ASbGncvANH/hpeSEy6ZgUdUZ0z7KNXuiGmdzawYUSyHQtSLjXK6c5KJYv5obo/IWvgM
	zATCSCykJVSYRv5nlAZBg0hQdB/G5dDfobMhlbR8SUPzCK9KMQnZjNU3VXloWhKkkPJdk+lcz2R
	8BsxNLWDd+5diwS/fDvxO3kWoJFoXVd/qmK2uFo26j/XSCVAALLiR+LcB3BXdFimszbcaMBcF/E
	K6JCmJ5WT+z/sSYrI96/PDUFCPLqyvBMNcyZhnLbaVMxO+8TNUaS5ZrsxD4cNUgOgnQDWxKnhuW
	G5QxRcigtJctF5pjcQRKMTJBx9w2EIwxCfRR5Rz2viWswkWw2kmQ1rW1fecF0o/uv0vA55VltDd
	IltM14jWJGCJztR+MCdPLHW43pTu5
X-Google-Smtp-Source: AGHT+IECnXLe86m48/eNbqrv24RB5ihKOoMDR1ROIy0Zofq0xXtoRiDRdz7E8E8BkgGDK3ZZiRM0Fg==
X-Received: by 2002:a05:6a00:14cb:b0:771:f8c3:1d1b with SMTP id d2e1a72fcca58-77e4eaa9a33mr2093467b3a.3.1758279002531;
        Fri, 19 Sep 2025 03:50:02 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:8a46:5008:3da:1c80:3e37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e87fb4698sm1408850b3a.96.2025.09.19.03.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:50:01 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Ranganath V N <vnranganath.20@gmail.com>
Subject: [RESEND PATCH] selftests/filesystems: Fix build warning on anon_inode_test
Date: Fri, 19 Sep 2025 16:19:47 +0530
Message-ID: <20250919104948.67953-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang warning null passed where non-null argument is expected.

anon_inode_test.c:45:19: warning: argument 3 null where non-null expected [-Wnonnull]
   45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
      |                   ^~~~~~~~

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Adding missed mainters to the patch

 tools/testing/selftests/filesystems/anon_inode_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 73e0a4d4fb2f..f796dad679db 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -38,11 +38,13 @@ TEST(anon_inode_no_chmod)
 TEST(anon_inode_no_exec)
 {
 	int fd_context;
+	static char *argv[] = { NULL };
+	static char *envp[] = { NULL };
 
 	fd_context = sys_fsopen("tmpfs", 0);
 	ASSERT_GE(fd_context, 0);
 
-	ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
+	ASSERT_LT(execveat(fd_context, "", argv, envp, AT_EMPTY_PATH), 0);
 	ASSERT_EQ(errno, EACCES);
 
 	EXPECT_EQ(close(fd_context), 0);
-- 
2.43.0


