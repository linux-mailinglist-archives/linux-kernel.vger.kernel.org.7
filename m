Return-Path: <linux-kernel+bounces-773138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638FB29BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC0A16A9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA62FD1AD;
	Mon, 18 Aug 2025 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcLvZodf"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F662FB965
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504906; cv=none; b=IOtAKzJ1xe1EtHHBggzEpRS6Ou7M7lpdVPrL1byf2FJbR+AzRAkjTGwNetIO3Me/9lDiLj+HWJZItogoWyEzsYDXM4E6uijCZSQUNbo9JyYhRJ0F5YiC2xurmAllqrXZcfaXwy4sl04yO7AEqGqekqwdehmKLWTkN1BIgbwpSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504906; c=relaxed/simple;
	bh=FAuZm45PTXR0LWoM+PcA07+5sxHDHoee2jh7K74eHKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W4YCC1bhU5EWiBFKCCdhF/nhzvnLkm7ROJi/HjtkaBttacuBwGSu+S/nDi5A5m5mWf0+pkversShgbG8ZbBH/JsFyyAe4P6vitPuHn77yPgm7xaZNTFqZjn9/+totNGpinZBNGrZHkjVE2Rhfw0+hLdxosvC+H+qd5x8pP7HBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcLvZodf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4743621044so523910a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755504904; x=1756109704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuEzqJOVVeoeTBUIUIB8tmvher8Rs8pIZxy+DUFvxQY=;
        b=LcLvZodfXS4UdZLislpuXZvhCi4hhAcMoKklV2bzXxYqZbAt6K9M0zv4OlKrrJdltw
         X8fv7RIpdkgVLr00Dxc+081BtNMxJCPwVTx/dt8LEzbTC83eozxAI9OmQADIDQO9FSGr
         aMezV/7XqQrqV8P7pezrg31f9Q9CJj4OpGNfPATd7zyaDSIBP9ojiCTEIXg1nXd70Pvp
         NBts0QFEq5JGUta2ymat+8EyUo67RQll0zx4XW6uFlsU3lGxP+JAuS4eCJyocHvXzQAR
         8k4psdFVR4lJz/eXRrOVtZUXl7AvncmJr87yAl7m2Oz7TZ5KK1VNIWols68yjvtcW8Sc
         etFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504904; x=1756109704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuEzqJOVVeoeTBUIUIB8tmvher8Rs8pIZxy+DUFvxQY=;
        b=o4CRcrnif9TzoVPbZcyG/7qGbDfd2RqzDfqtADBCpVUYBhkrrfokvGi58m5Cd8Kz9L
         2K8jEj/bA+Lqg+JdlXcQtaoDuQfhjrpzzkG7le3cRuOh7mrwxWRAauiWVQNJUSPH8Mrs
         e/g2bkSWwCcx+m8/Pqh0AM2Jb+XfwpQ33qvw/urmDcF7aMNrgmE3gUHg0ZIq9W4/pqll
         Ojfz62GgEAIyPAUWJ+u7u+rypedGLl6qrrFG01moG0Rt7+QIR9K5a22rSt67+HGVxy6N
         0d5WCoTZJkxmio7gbuYGTvqj7QJAUDaZQ5nwrr07ywzbmGOM0gFUD0BKmJOvd2BvoJ+2
         n2iw==
X-Forwarded-Encrypted: i=1; AJvYcCXsgM4pF0hNTg6U40l9WQQkf0b6Tat+96Ng3RsalAxheyIBuIFaziu3gLyBgZ6Bq53ckAUdU/2VnRtwB4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/YH0zPFPQIV/NSxENchsayTA2d94IhvMBETkS47Iv59tLK3B
	ydikGdB/Atu1vSDwTm7CCrthYOQEq0lV7C09jUJtpGs/kspd9PR1MkJH
X-Gm-Gg: ASbGncvohK89PKROkfYF9xB1BDuh/uPF7Df6rg3gjyS/538XSC5YET3cRQsyO/BMteb
	ugaCPBDE4NF8mEzLmYD5+UjkaS4MQxpQD5rwWjMOidQHJVABFnrCpUkMzQLR8NjCUODbrUWMker
	asn52i+Mv7yvk0Qx5uhu1VSYkKa4OjX2zLqB4d2kQ00jnzaK1AusoWOcGBVsGjREjbxK3SUU1Tq
	VA5naqEQCJsr10j7kMdtYoiFzOnZzLlJYsvohKpYwi/+kQc/T6x086cEDONiQvjybzTk06WnaIa
	r9A8FdTsmsi0sbnqES+SK1kojD5OeraG8zq+PLrju/2hQeMvkwwaFUcw0jFmagzhfahIVGTafKP
	ImyfttL2oSiNOUV4=
X-Google-Smtp-Source: AGHT+IF5d9GdHdsxE2rDEgrRbfrYCRgqS/5cJIpwE71E5Ox80mt5mOaSYEhoorB8K282scsSk1ttMQ==
X-Received: by 2002:a17:902:e790:b0:242:ffca:acff with SMTP id d9443c01a7336-2446d8c637cmr154405605ad.33.1755504904324;
        Mon, 18 Aug 2025 01:15:04 -0700 (PDT)
Received: from localhost.localdomain ([47.76.234.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0635csm72749965ad.53.2025.08.18.01.15.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Aug 2025 01:15:03 -0700 (PDT)
From: yaozhenguo <yaozhenguo1@gmail.com>
X-Google-Original-From: yaozhenguo <yaozhenguo@jd.com>
To: tglx@linutronix.de,
	yaoma@linux.alibaba.com,
	akpm@linux-foundation.org
Cc: max.kellermann@ionos.com,
	lihuafei1@huawei.com,
	yaozhenguo@jd.com,
	linux-kernel@vger.kernel.org,
	ZhenguoYao <yaozhenguo1@gmail.com>
Subject: [PATCH V2] watchdog/softlockup:Fix incorrect CPU utilization output during softlockup
Date: Mon, 18 Aug 2025 16:14:38 +0800
Message-Id: <20250818081438.40540-1-yaozhenguo@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: ZhenguoYao <yaozhenguo1@gmail.com>

Since we use 16-bit precision, the raw data will undergo
integer division, which may sometimes result in data loss.
This can lead to slightly inaccurate CPU utilization calculations.
Under normal circumstances, this isn’t an issue.  However,
when CPU utilization reaches 100%, the calculated result might
exceed 100%.  For example, with raw data like the following:

sample_period 400000134 new_stat 83648414036 old_stat 83247417494

sample_period=400000134/2^24=23
new_stat=83648414036/2^24=4985
old_stat=83247417494/2^24=4961
util=105%

Below log will output：

CPU#3 Utilization every 0s during lockup:
    #1:   0% system,          0% softirq,   105% hardirq,     0% idle
    #2:   0% system,          0% softirq,   105% hardirq,     0% idle
    #3:   0% system,          0% softirq,   100% hardirq,     0% idle
    #4:   0% system,          0% softirq,   105% hardirq,     0% idle
    #5:   0% system,          0% softirq,   105% hardirq,     0% idle

To avoid confusion, we enforce a 100% display cap when
calculations exceed this threshold.

We also round to the nearest multiple of 16.8 milliseconds to improve
the accuracy.

Signed-off-by: ZhenguoYao <yaozhenguo1@gmail.com>
---
 kernel/watchdog.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9c7134f7d2c4..5413aa85e8a4 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -425,7 +425,11 @@ static DEFINE_PER_CPU(u8, cpustat_tail);
  */
 static u16 get_16bit_precision(u64 data_ns)
 {
-	return data_ns >> 24LL; /* 2^24ns ~= 16.8ms */
+	/*
+	 * 2^24ns ~= 16.8ms
+	 * Round to the nearest multiple of 16.8 milliseconds.
+	 */
+	return (data_ns + (1 << 23)) >> 24LL;
 }
 
 static void update_cpustat(void)
@@ -444,6 +448,14 @@ static void update_cpustat(void)
 		old_stat = __this_cpu_read(cpustat_old[i]);
 		new_stat = get_16bit_precision(cpustat[tracked_stats[i]]);
 		util = DIV_ROUND_UP(100 * (new_stat - old_stat), sample_period_16);
+		/*
+		 * Since we use 16-bit precision, the raw data will undergo
+		 * integer division, which may sometimes result in data loss,
+		 * and then result might exceed 100%. To avoid confusion,
+		 * we enforce a 100% display cap when calculations exceed this threshold.
+		 */
+		if (util > 100)
+			util = 100;
 		__this_cpu_write(cpustat_util[tail][i], util);
 		__this_cpu_write(cpustat_old[i], new_stat);
 	}
-- 
2.43.5


