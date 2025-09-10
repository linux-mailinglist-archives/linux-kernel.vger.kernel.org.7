Return-Path: <linux-kernel+bounces-809709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D4B5110D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA6316E392
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C030F81D;
	Wed, 10 Sep 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPb91wjc"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34BF2C3265
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492225; cv=none; b=uZLV64Vn8YouxLxwu80QqHeF9V0O+5Yakn9kyFr/5ZHBBmTnCoGddY48C7Vrllz0OqYoxd8t472Cc1tkoAsZ6xuTdrp4eFM/UCM+7FnDNpBoX9e8aIkxOocbnvf7yONVZdWh8p5CDYuymsn6xMctyH5pfwCoSRbzXEE5QYeOaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492225; c=relaxed/simple;
	bh=KOjiphgisJMVOeo3WqDUr35Ur8iTvcsuVIW0dUMZJ14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpUBZKIMqUDsrxuxzwbBne0OzVBhi1rwVS5/OPCq3vFNspB0R78bV7gm6ziuJV2LlE/Iczz5uYXTjjKjk9bUUUhL2uuufJbqwO8hvIPT5DSTRm8W9eA1LkYdUuqnHHXCs9387b9daWaMbN3GiLw0j0eGgHRpYX2LkzRg8srjg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPb91wjc; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7725de6b57dso7538367b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757492223; x=1758097023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKGq4sFrr6/JKMiNPfIQDFzLBpI89tdYL3reENKMlt0=;
        b=BPb91wjcBjwXLj4LX9g5g10jE6D00zEkfmBzPsu6R+fbNNG6q3+zFNtjf9L5pG0LGE
         m2OTzWyqL9G9I2u1cwx+uDEo6Wg9kDNQDGdaya1+BUUxx4dBpTpNktEzIo4+zNgis9WN
         Ckxm15RRpvKmuMDNe/orHz5iH8ZUfNzpnNImKblSfml+Wy1kzdRZsm0cw2vUKGHiY640
         Vo6XgRq27L5CYgiqw8Q3rtLkBEEN8bmwhE/7t1OjHdf+ZhR7xVLsNohVgWScGfs6Gzxb
         opGy2KqKKUHwu7leYDuG/5fjYAYKqj7eFwWG+029RVrWaddM3DNTy5PPxQq8bsfkc8/C
         Msng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492223; x=1758097023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKGq4sFrr6/JKMiNPfIQDFzLBpI89tdYL3reENKMlt0=;
        b=wvjBhj0r8KrKERZL5OSA2voRx6BPHhaWAT2cco4KLMJpnSelkaVVlIoFdsFRhetdcC
         lYrnkdEWLBl8ga1y6cQvlrus6shcRwvqwkAUEL4+n7kiOvyNrEhuOWenpOrsQFKBwtI3
         y9UxC2s6rF9qpH9Itb1mI865tfSQI+899u0c7+o/PatqUZj0Luf4rjIcZLqc5Y+UxYna
         89TwXcDEc9Y96jKQDfswE44l/y2yWhjNXwFIIClHyRWziThFS5MHNTdrCYnrYy9KyASu
         YdUaHJytMn69Ayxw55nDHX0YHr6jufwAhpDq+N4ah4MnLc9IM2cxBQqLe+L6Fh+ysbow
         aOTg==
X-Forwarded-Encrypted: i=1; AJvYcCU8MbLVgxtZC13W0snZ3xLN2qyJ35fDqVgb2UQZ71B+e1NJwu9mGkp+pKaRrXVPVP68PzJg7l594+Ag/Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sQ/RZ9JZaqkt4jtCHHd4H6LLWtXeQE+YX97tA4lMGiJzNZI7
	gFAELRBKkL4XwBp4NYpWLfWD6f79XgwMS/1F3BmPfZUxPDK+3j7udJFP
X-Gm-Gg: ASbGnct9GFCvCjBB/t66hDhf9Mj57cNFcvtTePVv0CcuyHlnm6SZnKLyI78kJpECngM
	+7Xtnzu5chkndwPlwtVRq1SQZ98y+UVDqYVH+DS8tF27AwdZKHcCaR6iM+Pokq1FYy7Xq+BTNr8
	xzhA2iUrJsv0CfCV4k/Xz+z+OxQPNUG6Bsw6pSzMwDdTByQNvbFT5T0PMKXXLRBcVEjOJKigtnU
	vx/AHqAbWVgxGzhdqc48Kl02w+6gNfXFm01SS3YAQW3OMRCekJIVismMdsIGMKyzUu5eWFXlWDz
	7xUzMcyF9Ss1BBGtyWQGA3yd/Dncl5J7THTv2RAcozKFQZF+Cy7No4d4BTO/OxyGiVeKB+SpocC
	87gNbtAH6MYNjqTPg4gSbEaa29suZp7IjJ8aXpp4=
X-Google-Smtp-Source: AGHT+IFgwYh6/cLL47cBF/4+Kpv1HnSm3Z8Bvn9DbldL8ursGju/GzMAEeltjkJMU9n7hUpLMoKBfQ==
X-Received: by 2002:a05:6a20:1584:b0:24e:9d94:7b17 with SMTP id adf61e73a8af0-2533e8532f4mr17692470637.9.1757492222628;
        Wed, 10 Sep 2025 01:17:02 -0700 (PDT)
Received: from HUC.. ([202.43.239.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb31458dsm1644487a91.10.2025.09.10.01.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:17:02 -0700 (PDT)
From: hupu <hupu.gm@gmail.com>
To: irogers@google.com,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: hupu.gm@gmail.com
Subject: [RFC] perf subcmd: avoid crash in exclude_cmds when excludes is empty
Date: Wed, 10 Sep 2025 16:16:55 +0800
Message-ID: <20250910081655.355971-1-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cross-compiling the perf tool for ARM64, `perf help` may crash
with the following assertion failure:

  help.c:122: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.

This happens when the perf binary is not named exactly "perf" or when
multiple "perf-*" binaries exist in the same directory. In such cases,
the `excludes` command list can be empty, which leads to the final
assertion in exclude_cmds() being triggered.

Add a simple guard at the beginning of exclude_cmds() to return early
if excludes->cnt is zero, preventing the crash.

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 tools/lib/subcmd/help.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 9ef569492560..ddaeb4eb3e24 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -75,6 +75,9 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	size_t ci, cj, ei;
 	int cmp;
 
+	if (!excludes->cnt)
+		return;
+
 	ci = cj = ei = 0;
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
-- 
2.43.0


