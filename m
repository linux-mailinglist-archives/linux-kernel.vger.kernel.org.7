Return-Path: <linux-kernel+bounces-877673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE33C1EBA3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21403B4109
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85811336EC4;
	Thu, 30 Oct 2025 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeIBdFMO"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1332F0C66
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808936; cv=none; b=k9c76TRdPLBLcZUSam+aaypFPL4Oyt6umUoZ2mzaewzAgw7DiG3y8BVst67iEqEx/EByz8iPC2giEUa6VNRRz6RnRlttTt1cqhraOHRtwiOzQmQ7usZ8UjDpO9MFaMG30MUjdnOsciqeH73PjtRcphC2mTvny5HltzQtBqyjMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808936; c=relaxed/simple;
	bh=BK9QyNasA/qNf+VmxCdQRMf4FU+qlzDQIVRA+LFxeLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VwybUFhVSozvqt+VnfMrY2N97prcENOX14RzFWAofEdUP98fCHRZ9ug8GPFDg1mDY9S0EVncj0T9S67mlYttYeApI6iG2LIf/bFY2TbEReSF/7LeX46XGPFoGIEnq1GKpURPaX4yP2Jiu8z/9bVtP0W/8c0mR5ZlZ8j+CJBX1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeIBdFMO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso421437a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761808932; x=1762413732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N97xtuGiZGCwUUKE2UkiFj9jfFMfd7Q45BsFB44dQRc=;
        b=VeIBdFMOyNnzytW6z7wmEMpo4U4u9D3bbb02YciQYyYJBuMx8RZ0Xhedz1pVJEKtx5
         S+1t+qYNEwqQDDU1c65q7nZO1LAXELE8Qwl1eC5AYHqGy2C0qed4+T4FI+bIFxe7N/6X
         1mNGM/dMf5GWt108wPWBf9R+oXxpCDhK24/LPT3YEBeR/88Zc59pK0cjbaLpa1yIEqit
         q7OqYvv6fQbf+7a3RHVEA7OazvTxP4sPUnOSfAWP+BpzhN1xXJR3Rd7HpyQEU62XzYrt
         qlSR36qicwNVp84yhm4sLbGlJrreqNy+TGz8r5eXBWWX6byMXPfJv5/PgFfGbe5riOkf
         JPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761808932; x=1762413732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N97xtuGiZGCwUUKE2UkiFj9jfFMfd7Q45BsFB44dQRc=;
        b=T4hkNkz8IInf6ceDutDRyhnlzAGMT6M6NIekB8G7OXkJvGA8E3kJ7ncjyugO4l0lfI
         GT5Bz4Nm+LBfIYuKEMla4n6tjQOf1X4+0olIqYvnnpUt7JJdeNJI14W+5L78kT+lRKjw
         BQ+xyMD6+gmKkQhrVqp0nYdBmb5HZ5mUBQWrbogeCHNpqyq68Y4Yt3BzCyy6Zwn8Kpxp
         wVekynHcZyCY8nAtZvYJPRe9Y1vyKKeQy9Rv2+Z3CWWOiIrQFRfQNZWSeOcZKlHYkwys
         SD6WBIL1llwEYHhPCyhftjqEfj3qywsUFDMD8UX7aEuYBy/ZQYQH1+ry3AKN9Q64Cxyh
         8HSw==
X-Forwarded-Encrypted: i=1; AJvYcCVnsiheYC5idg1yDb4+7wMAiA0Ikhv3CXP6meleAvtkHJ5wPh8gCRAh3k6GUY6NdizpSBqziqefw4lWDxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Z1FmnmmjRfaAWFEbvFW3/vtzhUySH//C4cM3WcEN9pVn7u6Z
	3W+nGUxaFfGQcw+1IS29gTpKhXSho7Pp0RfxdzXmDFI3WenB64k666YN
X-Gm-Gg: ASbGncvVg6gSL6oSdD+sWcF1VmdNvjD9EfuyZF2j2GnBPAkPP1PLTsrBQGL4+w6Y9HO
	YD22wsurJD/FCexBZ/6JOr20Id3xG9MzGAjy5LSAWuiWfG+eYUQ1PAnJ7ePoVoY20SGwB6M1TAd
	YJ9cvyJqEhSpxGJQbojFuY3IckDA2ijoh11hcShyQXe91mpz9f5wRj7ksaqhssfGQJVWWw3nOpw
	1sAn7+9QujMA6wbK2l4aHRIElbTX+HfmjEtj5tP4cnV8T5plW0KrjIngCNGyizGJ/hvRh1RvUKL
	D319afAypTXPL8GsvqTsCHJI7jZXdtZ3nRKFxrpP6p9lHRkyHTgNqsYKkwxxMQVQaSA5II+mjH8
	p0dWZr/fl5Krg6hB/WTT1kLIiPIqInf8elNYJ7/IyQMmw2reL9nK/NDg4c+/wnuDAK0PZKtcCFc
	YHgXVxZ3ACCcr1PWY2vK0GYQ==
X-Google-Smtp-Source: AGHT+IEJzjadnlIxV5ulJGWrPrx9myLqREBJf1yyP0HpGFqWQhdbyL5hCkrJAnTltkMImoRPFo5a0Q==
X-Received: by 2002:a17:902:db07:b0:28d:195a:7d79 with SMTP id d9443c01a7336-294dedf4305mr67171885ad.5.1761808931687;
        Thu, 30 Oct 2025 00:22:11 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d23218sm173814695ad.51.2025.10.30.00.22.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 00:22:11 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lars Kotthoff <metalhead@metalhead.ws>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] sparc/led: prevent buffer underflow on zero-length write
Date: Thu, 30 Oct 2025 15:21:53 +0800
Message-Id: <20251030072156.30656-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix out-of-bounds access in led_proc_write() when count is 0.
Accessing buf[count - 1] with count=0 reads/writes buf[-1].

Check for count==0 and return -EINVAL early to fix this.

Found via static analysis and code review.

Fixes: ee1858d3122d ("[SPARC]: Add sun4m LED driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/sparc/kernel/led.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index f4fb82b019bb..aa0ca0d8d0e2 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -70,6 +70,9 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 {
 	char *buf = NULL;
 
+	if (count == 0)
+		return -EINVAL;
+
 	if (count > LED_MAX_LENGTH)
 		count = LED_MAX_LENGTH;
 
-- 
2.39.5 (Apple Git-154)


