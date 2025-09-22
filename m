Return-Path: <linux-kernel+bounces-827732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C488B928F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344142A6913
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810F731813F;
	Mon, 22 Sep 2025 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxJql1Ig"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCC31770F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564542; cv=none; b=IR+KOC7sXZFXMWNhfay81UhGng0+6PmmXYkAJlG7KI+7MpeGN3h0HM6rARD/EygJ/nmuR3f7Jxdi3+ZHfX+O5miVWBTVZSmZINPmsgbrk7NqtPbMSBsZuwgTEHwU8mlp3ocyw4+v6ftyfhGxOHaS7pPfBH86UA7+vcbYJdc6hLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564542; c=relaxed/simple;
	bh=ClvKFZ/b7716ndh5rkOR1V+bcY01pXI7j9WIQX5fb6I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K4J2POJ9xbIub47/2SJPHGHaLe1LcpEjavrOgZV3h8ZG65J7tLLa+nrzE/mu+VMqchN/EULfA8geD9rXhE3N/wdMf0BL/XRcevZnARVJApsW6uTTay6EyGNVDKizZ8d2ZnbM7Wqm3ZgjL/+y55UJ+MmhrDzyzPfEQQQhySXU5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxJql1Ig; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f207d0891so1580021b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758564541; x=1759169341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToEoYspZoDukL5w/NejXRw07/Byo+3irLVr2SZ9SWds=;
        b=IxJql1Ig5JyaUkC4cripVkz9kEZCY4szO/xE4hRd0ltfyIKUXbdyfXwGZFwFbdws6R
         1LGdZiTvOXpFKg47Mfk81js4OCc9O+XaMWsfsh33bsymUqy7EmZGNbwF9WMK/cpyUjUX
         9fDhsH2YNVHrIgCO7ib8wvPq+EH3qzJxWVYwkcfabtNXLiMXgZNMeAZRfhLIiAVTar7P
         TrbO+R89tcOKHvKjfEH5U2uDA7HU1cU9tJzM0tEvBO9CKvxXOtKRYopl8Al9V7YdmyXQ
         tbleZ/FrvBxnpErYMMxMDOSUeLH7eOaIDEXUH9GScijb9MWWO3Gd60lbhgDP5gVQXXes
         +xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758564541; x=1759169341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToEoYspZoDukL5w/NejXRw07/Byo+3irLVr2SZ9SWds=;
        b=tthK3aVFRvM+CDbapF7Q23k4Pmt4vD5SME4RhB7L6wjUMH4ql+EQS/eqNW2tPQjlap
         pQ6DHKRaPdykFk4JBtBchbcnL+72tm48luEBS5urIt/uW17X8z9Yw0RlMEcEIDPhVq5y
         EUwwQchfCKKPz0ndO1Vsf/+MUtg/IPk16zCW9huLYYRHa4Hu1PGa9SpeghjiX513/VHM
         +LAYxlr7RHNt+xCgTofGnoRtd+DZV53cpBYtps3Jmd9z0w18L5PDsg0kOQlDIrOWml8C
         RKK1N9s2QusJRPBo26B8NmdQaCvQewsqpmnmB4XWAXqoYsc7t5o0TsmL5xO3X4+rbHQH
         w0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVps+CujZpLkfmQ3zAKEEiYGmFjy3ZoK5RBTHGM+68ExasBdu+mq/NOzPiaAKutBaUywuAM9vW89iiS3oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbwYMePovwWUBx4eYIBlqQnb7H65XfPPMzWJihn4B20PbA9/Td
	Knn2pkYn5vJcJxYU0WofFTma29FY9VuwIShUAdSmu3D2LVmHffucnM2J
X-Gm-Gg: ASbGnctX078Nl1GAyjzfs/Wst/T9czEwX34zWFz7tI+Ci/ta4HZPUEwpmgkuGl1DbXu
	3vVJrFCEl23FjjHtxH4II0kpwxxlsJ0JPSI6PWL/woWOEe0/g5KMAuoy9CHKs+A+EZUYtatu8Ek
	xn/nzie0/OTpPlTwwAcd3C/j8fkx4/YI0crAGr3blyAwxH7xlx7DF1qNlJ7VJ4HoScT+zi/qrbL
	qkI5uaK9mWTk+ePARcTM3P6ERrowrr5P+QIWEFket8QJDSayLncsM3je6232sDyeErFobmown9S
	85U2hL2IjHUjSV3hyFXc/TDnJ8i8CZFPVPmr6KZSJVW7Lc2+B0wcq+0042Vh+rWwyjuVYPyOheg
	P4SSyHg8JIfMghKzSIIV2LVVHqOsqCs8vueY=
X-Google-Smtp-Source: AGHT+IFZXZ1PyVy0iEuxUGNtkFvpvoD2o14jNC4/NMrkx90+TPiBtYnuHYVnqH1dcJoEet2Vv52Bww==
X-Received: by 2002:a17:903:90c:b0:24b:164d:4e61 with SMTP id d9443c01a7336-269ba40a0d7mr185701835ad.13.1758564540683;
        Mon, 22 Sep 2025 11:09:00 -0700 (PDT)
Received: from ThinkPad-T490.. ([49.207.194.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e14f1sm136155565ad.71.2025.09.22.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 11:09:00 -0700 (PDT)
From: Faisal Bukhari <faisalbukhari523@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf parse-events: Fix evsel allocation failure
Date: Mon, 22 Sep 2025 23:38:34 +0530
Message-ID: <20250922180834.1744399-1-faisalbukhari523@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If evsel__new_idx() returns NULL, the function currently jumps 
to label 'out_err'.
Here, references to `cpus` and `pmu_cpus` are dropped.
Also, resources held by evsel->name and evsel->metric_id are freed.
But if evsel__new_idx() returns NULL, 
it can lead to NULL pointer dereference.

Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>
---
 tools/perf/util/parse-events.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 452f12191f6e..02e7ff94a2d2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -286,8 +286,11 @@ __add_event(struct list_head *list, int *idx,
 		event_attr_init(attr);
 
 	evsel = evsel__new_idx(attr, *idx);
-	if (!evsel)
-		goto out_err;
+	if (!evsel) {
+		perf_cpu_map__put(cpus);
+		perf_cpu_map__put(pmu_cpus);
+		return NULL;
+	}
 
 	if (name) {
 		evsel->name = strdup(name);
-- 
2.43.0


