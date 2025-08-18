Return-Path: <linux-kernel+bounces-773718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C114B2A780
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446936E04E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46C3226D1F;
	Mon, 18 Aug 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvFliavW"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB23225413
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524617; cv=none; b=BoqcD12W5Pdh/mTUJ5h2oPPjqkKPfr2FcNUouENYuHs8dkqzmVW/rZ213tb4cD2sOKs1TJ5W0i4AA5bifoTZ/kREYsBqSmbORrOk/LuTM3Za8q8uXvxFjYayIe/IYMx6P73JWLw8ho7vQknNARwz6rA9/gIe3+kY/mIuwnsURBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524617; c=relaxed/simple;
	bh=GY033kBcdEgxbHngwDBH/yn9YX39oDLKhFn0sGJGqTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKCiRU0xlsZI6NcCrpGFtvVS4l1r19mxkYuRdXEuwJ8SmsK5DVTtLnse4uF9Sh0agJ5z5kb6pDbaBT6QM4KyzJ0IfXbHgAwYQiI8qEtRbaUCxrN621iA4nz65UILHhCvk/cSijYDnlCeTF/QNdC/orz8dtcFLfvOB26lKzL+14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvFliavW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32372c05c5dso719095a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755524615; x=1756129415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qFXybMfT0F7pfONRtaANHA6qK/whFnwauoDe2iBodg=;
        b=YvFliavWVKepM6KZLaDbZ5/tFbC5E55T9GkRKNzftcgC5B2jk5SPqDbrilb4VIgD6Y
         glwYSN5Z8bK6e9M1MgRqNE2M7sN0EaBN6YEQih4Gd4alT31nIHUrdCXHNLMUEwIYxSho
         vZIkZdl2TYfI8LTto5qAgd+gqCW8OkNJ70JllYFEO0MOaY9rZwYb8v/hQefzcCw8RkbA
         8l+lgGyrI5Nn7w7ZnxDqONDm96djO6+Uls7xdM7vpxhMuH6EM8Yaa5zyKN7Kry7pCUhS
         K1xCoS67kcgJD6rYIflAm1ME7vN41Y7yvZWzlDep11qAs2oCApfnQF6SeWMVcjLgJpBI
         PPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755524615; x=1756129415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qFXybMfT0F7pfONRtaANHA6qK/whFnwauoDe2iBodg=;
        b=BUfoHtBY5J0F7nV2j9EsE5s4cf1YCZH2nSBDWSY0mJgebSIhsJQvbCFM1mMeogx1Tq
         1HgukePW1AxNW+63ub4jVYPcyv8jJVYZBgB97+ThkgqcQqHm23UrvTf4NiNEYo1TcEQU
         c6kEGvSpKLQ93hAVCkfeUlrhRxDGE7szEAuu1pehGAhS57R32u70uYzzmnFQOBVmXBQI
         kRr0oRZ7TvoQX43BB0iuqwEVcsOEK00KwRchp7nJMjp+Fu8ud4+ZGf5A1ESsKkkdsRyl
         aM1eFiSEpU9geAik5EwU22Bn3uaLkY+8KUEAeA846O9ETBGFejjSVs4LDLCkVrA7Laep
         6zaQ==
X-Gm-Message-State: AOJu0YyhrQ894bmL5Jkzyo0QmlAqdpi30vJHuZ8jqMsFqjYby4aSbw8y
	oGVEeLIlLWLU2EUTHe5OXEBcvKr8XS6HSwkS3knf71iz6kJITA64na0B
X-Gm-Gg: ASbGncuuC/5t2X0JqjmaQo/FAYRJi37xRDM39LJLCnoHZpjhovNddsqPnqi8SS1882P
	CcoH8b8hKEaU2L4quSIL4u0nY/1Ozoe5iVOKR49pZMN8nu+TnfuzREXhhmYTv2VVQdevBIWm7Gq
	n4C8C5ocIWg6BI6r8ROGtVPWoj47yEPnDkXONLrJyhmNW4MjEhJeaxhCzg6vo8xcraOM8NmKw5f
	gKV3FOvvTIl7Eb3uhJLxEqAEXCURpOxfIgDQZhRAzPOXyLiybrNiFK0RIG3vhksJZUewBdTKxyD
	fGceTth7kwEHcKrzAC5KMKcqRo9L2dFi0U/+w3x44PfqL/dp6gep4/F2zqENV3PrgkOMquGTflR
	7LuwswH97Pp+VASqhMsKViW4p2bTwkX49+t4VU4IoRTy124exg4LRNVTQMO8DPAO27BazsboaeV
	0CEsRNpvWTx+cVhkW9dyyJpnY=
X-Google-Smtp-Source: AGHT+IFUXtRL/BV8OhH7u51d59Zn+qQRMyYHv+mUm8SHWdo4AoKQhhH4kLrCQLItXf+EwUjuKYY8MQ==
X-Received: by 2002:a17:90b:180d:b0:321:7a2f:985d with SMTP id 98e67ed59e1d1-3234216190bmr16631104a91.25.1755524614790;
        Mon, 18 Aug 2025 06:43:34 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (111-254-48-124.dynamic-ip.hinet.net. [111.254.48.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76df62sm8122707a12.41.2025.08.18.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:43:34 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 1/1] signal: Fix memory leak for PIDFD_SELF* sentinels
Date: Mon, 18 Aug 2025 21:43:10 +0800
Message-Id: <20250818134310.12273-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f08d0c3a7111 ("pidfd: add PIDFD_SELF* sentinels to refer to own
thread/process") introduced a leak by acquiring a pid reference through
get_task_pid(), which increments pid->count but never drops it with
put_pid().

As a result, kmemleak reports unreferenced pid objects after running
tools/testing/selftests/pidfd/pidfd_test, for example:

  unreferenced object 0xff1100206757a940 (size 160):
    comm "pidfd_test", pid 16965, jiffies 4294853028
    hex dump (first 32 bytes):
      01 00 00 00 00 00 00 00 00 00 00 00 fd 57 50 04  .............WP.
      5e 44 00 00 00 00 00 00 18 de 34 17 01 00 11 ff  ^D........4.....
    backtrace (crc cd8844d4):
      kmem_cache_alloc_noprof+0x2f4/0x3f0
      alloc_pid+0x54/0x3d0
      copy_process+0xd58/0x1740
      kernel_clone+0x99/0x3b0
      __do_sys_clone3+0xbe/0x100
      do_syscall_64+0x7b/0x2c0
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix this by calling put_pid() after do_pidfd_send_signal() returns.

Fixes: f08d0c3a7111 ("pidfd: add PIDFD_SELF* sentinels to refer to own thread/process")
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 kernel/signal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e2c928de7d2c..fe9190d84f28 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4067,6 +4067,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 {
 	struct pid *pid;
 	enum pid_type type;
+	int ret;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
@@ -4108,7 +4109,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	}
 	}
 
-	return do_pidfd_send_signal(pid, sig, type, info, flags);
+	ret = do_pidfd_send_signal(pid, sig, type, info, flags);
+	put_pid(pid);
+
+	return ret;
 }
 
 static int
-- 
2.43.0


