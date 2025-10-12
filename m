Return-Path: <linux-kernel+bounces-849342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 252ACBCFE33
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 03:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A9084E21FE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 01:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D91D5174;
	Sun, 12 Oct 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7H5XCnB"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727C37160
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760233629; cv=none; b=MNrzTloj7xBtG7WeJkIG1EFB0SrPcG72xsu3ijQuZ0XGRDBUBQwSvP9mYFyzh1LTJz2HnjzH9AMf4dmmlqCiJ/LRzO5vpFqYhp9dV15RjVSHD6w9UliTfqaEw1h6vgbON9EF1roZluZDfJLQr4YE8OYqbegpqFkj80beIa4jFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760233629; c=relaxed/simple;
	bh=KYbEOZWKrX8qPsvFbYgylfuWLs26ZJ9jrLUaztAw1EI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iO3uYcW0CztM1MZ7BWu/7KTMJt7MqJcn0iORzevydK+KoiTb55+RbihFwk7jFtYgWhzQMFNYqhW6LoPWhAwRCO7NqNoMwBvPbm2boP3SPeRj/Hct9+SlGa0rnB15pIq4Mu9l+Msx7eBuZgwpFVapcjQM6udkBynjzhZ6qWyH2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7H5XCnB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so2519933a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760233624; x=1760838424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYbEOZWKrX8qPsvFbYgylfuWLs26ZJ9jrLUaztAw1EI=;
        b=Z7H5XCnBNDgdAWcqG7fbaIFRVG2lAn4UiuXx558qr3qMc56etoVZm8uhKWKeOgo4XL
         NPpA8pn2eIT73RwGRr7dkwFeJCnbzO4Hz/d3FrOSjNvtzPKYNXMZ3WjUVOxRUsH3rG5L
         C/3p/zb2NlmdqWZM00SyKmNeeISVGvhIxozSg/q0tu5BPAG/fYiuWbh9WMdK6GtTujDA
         Nek1GGJGcqot1jOt1jQWDLjV+DYHl5P/AYV666An6KhNbf8g4n+ZHghN0YP3n0odxyke
         d3KTr/txZzN4ibeOlVY+IvSQRhYOo9wGMOaKKATRws4cK8g3rJEPXuQe2xl2cE1CJntt
         wBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760233624; x=1760838424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYbEOZWKrX8qPsvFbYgylfuWLs26ZJ9jrLUaztAw1EI=;
        b=PSIJI1ZLtqqnjyAH2XoVmDk1OKlxRh0euYN4msxwTQs6tkXRD4UfpRQWePi//i375d
         F5cinu7Vca8y8yZW5YiNYjhQKdvusFMVXn3Kh+wjYVN9fkwuffj4uQ5dpvXwqIuclcYA
         79FNCtzmRQ2K4PGzK+2nmnhDPoq/iTYa38JlwVuvQU0DHriFf33goWYFyOq3XloJxAqE
         uUu0wbsKTPGpNyi21bg1FD29CuOCWoBD3QYubz8CHilb8kWqE72tLx1BO1eLG3CN1/0J
         uX7UAt2tkEm5NrmHfFeTSGOWNiyb7t3pNCwIpoKygFy7ImQxn2CTnxb4BV3YrLCUE2dm
         toWw==
X-Forwarded-Encrypted: i=1; AJvYcCVETnCc49yHF4HdbjPJogVdLYKBkvCLCJK2Dzwwd/s1vlE8r1mKEIfTqPl1LiTXWcRiXgqcn6UDp5NZ4yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZCi8T8qR2hjGLDzfQVEHvdFbG/PVfba9lgod1kLCl9r4G3jo
	2wZaufF7WBwdykiMDVSw2SA3wvz9DVCJuhCsJyKTM/OPB4GMoaQc857b
X-Gm-Gg: ASbGncsOGjEHZQnGLXVCZcXV31YW/+8frm07jXqBBxsiKa3q8ofb8chmzPP+5forjpi
	he5nUovnaliUtO+3gpm6Q9q1IBCraMHULBQ5oI90Zym52FC0FQfRgnMQnP6Lihs6rkxq4LcJdMn
	EHFXwEyjJQS6Frd22tS3o+hiJCkCVCi7sGKzVo/cM57DhmYeOVZTZt6Ou8Qt4QcYri13izNXsFD
	WKZZNhGbIzuMH0s2JH8eq8J4P4pvgKxlLfOYFDyplcRWmtj+txwqjE6ZjXKTnIhwDfcIHBXfW7V
	9MWbrqT5B3b/iZp4ofM+qQt34R3v7ZLR/5tWJpAJDBd2rOg2E2rmh+k3I6NUXv9I9ylbyoV1kIZ
	+E9y8Uw0BnhZ5A/ItGbKpB8GPgQET46KfK7vKSb5I6LtBhy3NRQw=
X-Google-Smtp-Source: AGHT+IF7fdQ4DpLL7d5WN2b5Q4XZzmynuin15/teAqQfYmvPl8vAgZO5oduNg4XTy9tWmKlYPreuFA==
X-Received: by 2002:a17:90b:33cc:b0:338:3e6f:2d63 with SMTP id 98e67ed59e1d1-33b51117433mr25555653a91.6.1760233624523;
        Sat, 11 Oct 2025 18:47:04 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33b61aab6eesm7712060a91.15.2025.10.11.18.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 18:47:04 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	Eric Lin <eric.lin@sifive.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Guo Ren <guoren@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] perf vendor events riscv: add T-HEAD C920V2 JSON support
Date: Sun, 12 Oct 2025 09:46:19 +0800
Message-ID: <20251012014620.799046-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T-HEAD C920 has a V2 iteration, which supports Sscompmf. The v2
iteration supports the same perf events.

Reuse T-HEAD c900-legacy JSON file for T-HEAD.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 0a7e7dcc81be..d5eea7f9aa9a 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -20,5 +20,6 @@
 0x489-0x8000000000000008-0x[[:xdigit:]]+,v1,sifive/p550,core
 0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
+0x5b7-0x80000000090c0d00-0x2047000,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
--
2.51.0


