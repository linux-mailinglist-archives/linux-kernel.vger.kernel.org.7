Return-Path: <linux-kernel+bounces-764453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA4B22333
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31532188A4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686BB2E888C;
	Tue, 12 Aug 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5d5YYNc"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490D2DECD8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990911; cv=none; b=cqWD22OPZvf1N6Bve/T+7SXiVBRqp2Jadws343AmwM3jssH7JyPR7MBmsIzKsxkoLl23QT5ExQ40TZwcG3+HySSo88cek95TDGshl8UKc3WURi64f7CrM6oEv+/4IINpGPbUV5Kv3FZmNAHefLDN3zeO8TxHRILqPwDgskXBik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990911; c=relaxed/simple;
	bh=VDkdBnoKzSFPcEcIcOOsNxcToj2WBcBBYHhaQlf2WOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=soaH2Ua74CDWAUIafAhaLQfMxLSqV73LJyzzMDdu5ToUy/ELLvAFjMiPuDa97b5uOzBQ8vsiW/dJZk7IZjv1a8WoXvCwh68VYMqK+TE8br/GLDcZHdKxElGgOVhoIxqzUgd6zIecg1DKaw6AVAS1ZpWTCMxTvZ73R3fpAoDnP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5d5YYNc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso5515513a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754990910; x=1755595710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOnpjr8QJ/n8t29OPk5AwXqGJw5vhg/RK5xcaM/Te08=;
        b=a5d5YYNcA54YPTR52I7ibGdzLI4k6cNRCj7KbNmXNsxAjGwl+JQRvDw8dpUO2p71M8
         6lIVqftwl7L10Zq9QqS27/NJVEHEbP9CowN6oKkopzze1JsyERKVP9jMU7FeOg79BNsk
         UCaiXv43e22wu2EyomPwXxW0xW++6uba+6mNfpU6sT8/GEJ9Oc2IX2PiWqtb2dazPtju
         opSMZVVwm+5VyrKnnpQU4H+iM3emGbYUpXLT1GajQP6xLdbRjJXtEE60HuaW9g9cgIRU
         RTSSwr169YTL/N05RvFriUjN2VESRcVOzrNhQeSvyw+yZmmwI1PJ3craRZj+/GYrM1FW
         tbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990910; x=1755595710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOnpjr8QJ/n8t29OPk5AwXqGJw5vhg/RK5xcaM/Te08=;
        b=jA2fDXNzbNOg5mk4WfMVqe6myaYJg1QnMi4nQiL/PvwyxLA+shS4rbEsHR93gVsxeY
         meMLkGzF+RflsG5Te8MV6Ml+iak1S3+zLZv2SJbXi775B9a5nC9Zv2q51PY4VwDOVy8n
         TfASn4lE4ulEldWLRVPFB21HdwaXEakhRYQe/sPFvq18bqUL8BGMgqkMpp05J2RN0tRQ
         n1xkGwgb2KC0/0HVZOeVF+B/Axqkysl4KK98ZYQOiOkHLzroBPoq8mdY5H5gKUpeuZ5P
         AfycEo3jwuxziwX7L0VeGTVInCwYgPRw8m6MmGTSCeK6XN83cW51bCQ0GlS468uQdAfG
         DJtQ==
X-Gm-Message-State: AOJu0Yw2KeLcMvYqXjab8uuj13iLIGowWRcJI3Xp8fAPPTSGI1MPnLSW
	lZxkzyN+aKZdEzOP87asyue09klA+ssMa3TYZMO6OvwF0kn3sXgyRTcv
X-Gm-Gg: ASbGncuOkwtHubHYdweZKM2Q5HNAZ1gJdUDSuRjMfnO4C+ZEO75rhM3ddaO7J3zqHl1
	Itzc8zPNgVtCdxlrXuHd+TZ+I4wRjDdGetOyAeTyCXGnEptrKE4UkilrA932Wt5MHlLlC8P3mJI
	IX0HGLstH0C/ttpthaa3+MT33eVhC/yCaEjlZFRAM72Ql45h3fT+gdol3lUrlxhY5eN3ggSWNiU
	vcqLz28uzwko2mjbCHvxxmlNCeG+mrBCiTqCyxg+UBwT2v9f2gqdJIohTDTCL8oABmkMORZhy6O
	trxvnLqnGMGkCT2PbqevfAfQ9gHEzrhQNMAN0Nzc3r7bkpMqQmNmZIqmm4S+TpT6TsRn/CSrjvc
	NoyAtzWdZSWWGSIL2Kw4/fp2BmDMu96CpDCf4mpFiUQ==
X-Google-Smtp-Source: AGHT+IGW8P3HWJi6K927FtmKBoZlpB3AyQsjEUlzdKncYzfwMVJ87zxGmmuUozLueF9h8dd3XwKFDg==
X-Received: by 2002:a17:90a:dfc4:b0:311:e605:f60e with SMTP id 98e67ed59e1d1-32183b3eb58mr19975301a91.20.1754990909599;
        Tue, 12 Aug 2025 02:28:29 -0700 (PDT)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe29:0:2:4699])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b429920ab6dsm9973915a12.58.2025.08.12.02.28.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Aug 2025 02:28:29 -0700 (PDT)
From: yaozhenguo <yaozhenguo1@gmail.com>
X-Google-Original-From: yaozhenguo <yaozhenguo@jd.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
	yaozhenguo@jd.com,
	ZhenguoYao <yaozhenguo1@gmail.com>
Subject: [PATCH] sched: change MAX_SHARES to NR_CPUS
Date: Tue, 12 Aug 2025 17:28:10 +0800
Message-Id: <20250812092810.38728-1-yaozhenguo@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ZhenguoYao <yaozhenguo1@gmail.com>

As the number of cores in modern CPUs continues to increase,
256 * 1024 is no longer sufficient to meet the requirements.
Therefore, MAX_SHARES is being modified to NR_CPUS * 1024.

Signed-off-by: ZhenguoYao <yaozhenguo1@gmail.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..5c219e34f48d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -510,7 +510,7 @@ struct task_group {
  *  limitation from this.)
  */
 #define MIN_SHARES		(1UL <<  1)
-#define MAX_SHARES		(1UL << 18)
+#define MAX_SHARES		(NR_CPUS * 1024UL)
 #endif
 
 typedef int (*tg_visitor)(struct task_group *, void *);
-- 
2.43.5


