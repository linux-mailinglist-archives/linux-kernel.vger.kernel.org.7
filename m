Return-Path: <linux-kernel+bounces-764273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36760B220B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB9F7AD7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E4F2E1751;
	Tue, 12 Aug 2025 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4eOCV/H"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D969225A59
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987142; cv=none; b=Y/DcRj6gjspJU7YtnHe74/uJFeSWzLRhJrb/jPXS3xWlKHAZ7K2my9GElLcofqRyrTm5j7enlFsIiMwHVNR47bKAoE4DJX8/bVAgq/65CNan/4mh//yiVCWGSyG3MHsv23I1ZQIdRVdSqyH6yb3jQQL03VBBiZ+TjyTcUndc2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987142; c=relaxed/simple;
	bh=js32FIpA4GruiS49feA+nh/fpXBlFmHkE39lG/5Fikc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S7jf850JHE9BB2E2zvzNhwZ93szJpB61rJ9XPDYUxuyM7Vu+Ez2HOM1im8wrVmN/HanmT97tkyUBxO5h8t0L45ztTzuYfzJi0WYS9UlFOxUrOxLRsZdyjTY+7ED5B1SooSfDWkedMnHE61CuUyrshxwYkfVGMYdaE420GJx+r58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4eOCV/H; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2400f746440so43261405ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754987140; x=1755591940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VBKTouzb9zVyT0NEzPET84Kjpud/5/zvHGbDZ3mAKJI=;
        b=U4eOCV/HQEJ6A9kQkFmCoojDKIN1+WjbUzKkI5KYhkjX1YUQfLWjEgDJ5zpwhMo+FN
         oeY0wZpSj2jNivaAbLdPN5nKviRMzpuSbybE8JAjN6tZNDIHt9YFbTX2PLx48Cln1nFX
         TpB5A/yVXTJoZC5e2I3zPW990lVsY/OSJHJzu8qOav6QSB4MtjY0kb5H0MMK7/PeIpWK
         uJx4pz8oKGRdTVdZGS1SpfOdp9wOCF4uV2yNjA5TcAW2iPGeAdKuQ10a/VnRPPfl1tI2
         UqwjJZDY91a3UyYW5HleRbvMnYK8eG54IuGpj507aZ3JvaoBxsIz5b/1cqgUYKrUcNqY
         GtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987140; x=1755591940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBKTouzb9zVyT0NEzPET84Kjpud/5/zvHGbDZ3mAKJI=;
        b=fxFlMDlpcmm1+gIyythb+xwcLXKAOfcXP3G6dKKScmCcjqOXJdXBhpglEzM49coG6v
         vq7g0L3YlMM+AuOcvzZbpquMhNItnvr2yzP44cNztpsEjgJERJn88d+jE3zGsKeCbU9J
         c0kgn1KeuHpDoHS8Duou7ITdqbVUQaPL/i79a37gp98cknlUjXFlQpqfjRjYwu2Xp7M7
         5UKn4lNhY38D1HVGlM1l/NpGGsUzb1VTPSFFECntxyR5RS1RLC1uayuxscZjpKpVdh5C
         cRrkxtbNqOwQCRqbff+++3g4ptjTk5tcRdXXbq/Fvt6/Ic+9dRF3/nX1aTzswh41GFoI
         7x8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFawGlMe8WS7BZnuYhlMbium/lCTB4ZDBACnCGgmkSarSrp1YaM4BmWGxVp4p8UvLAD/aBGQj56W8BRBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIticI433sEa+T0OsC/sblzZk2A/YGZ83VrAeFNruaCCLmnIyh
	f3+usJaJTb4ZdyaWXji3uKk6bibtQ8QyRBFu014PGl87G6aWzYRSRlAf
X-Gm-Gg: ASbGncus7oj1x40DQKbfUBs9LIS60WuEqmjf2V/8esTPP2oJ90FSPgGdcQUCKrqqQxR
	lb5v2u0v9UIuJXbB/uL4I8wivMmikfwjkye52UX90IhjE3PjWv339sQEGXbbjZqqZQuV8Z5A1Lw
	hUB/yTc7fD7JEIN+z1HA2+W88GyJrLyq3vJs8vSetNTrwKPLf92ZDCNTVtORw7gRdT9XU3O0TKU
	fThzZmcu1fOx5E8sMt/oSIGHALQdDtRYcc8i9+WjUi+NvLvvc70vbdy+eC4T5K25bvQn/ZE6KXj
	l4HVck2Qjw0DvY97CrysZUB1Gpm6bpN3jp6wAIIDpOboNpl8fXemgsjUyIot8Qq1moR+7vzu+uz
	EXlKATn7PVV7M0Y/Se1MErc6hYI9K
X-Google-Smtp-Source: AGHT+IHBcRypzsJ0IagOxKFTQrLT1bEYvZZnDiiqpkXRrlmnr/Wgdh/YYe8EgX02o6YmyTpFoabqGg==
X-Received: by 2002:a17:902:c943:b0:243:8f:6d7d with SMTP id d9443c01a7336-243008f9b18mr17751435ad.50.1754987140390;
        Tue, 12 Aug 2025 01:25:40 -0700 (PDT)
Received: from localhost.localdomain ([152.32.169.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242bc894dc8sm110692525ad.72.2025.08.12.01.25.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Aug 2025 01:25:39 -0700 (PDT)
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
Subject: [PATCH] watchdog/softlockup:Fix incorrect CPU utilization output during softlockup
Date: Tue, 12 Aug 2025 16:25:10 +0800
Message-Id: <20250812082510.32291-1-yaozhenguo@jd.com>
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

Signed-off-by: ZhenguoYao <yaozhenguo1@gmail.com>
---
 kernel/watchdog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9c7134f7d2c4..29787996c69c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -444,6 +444,13 @@ static void update_cpustat(void)
 		old_stat = __this_cpu_read(cpustat_old[i]);
 		new_stat = get_16bit_precision(cpustat[tracked_stats[i]]);
 		util = DIV_ROUND_UP(100 * (new_stat - old_stat), sample_period_16);
+		/* Since we use 16-bit precision, the raw data will undergo
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


