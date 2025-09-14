Return-Path: <linux-kernel+bounces-815797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7244B56B34
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526E3189C161
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16832DD5F3;
	Sun, 14 Sep 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URMTlT4y"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F12DC79E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874547; cv=none; b=l0xn6yDqPgYq0Uio4LEFJJ5Wku+CoML6uFcMZO/40y+uCSQS3t87pJuDPYonx17GtnpB2NYqXs/mqte/LDXHHHEL614dJHItcHKlnp52/zIRo1ZSkHjkzekJYGXpI5pvQasQLtkTWbwXl2Zjo6IRLTxX8tKtjCNXtTnKTGGSW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874547; c=relaxed/simple;
	bh=y6Qp+G1zT3Ln2PDwystdpi61j4rF8Tlwlp1QHuMBIyo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ulltmmkrDJWisrt2q3HYWtwr0Gz9f66va0Lmrt/LGTDrKy3juGWkLYm8R5kSBw6rdBZt2E3qiR48rAy1Nz8ytjmoZT49AxYoqbEvQq8ymDbFKpmbU9rgAWy0t/gTj2C659b1bbyRe9Ng/GTZppeyXRAZdDWJYvOEfB6qCroqgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URMTlT4y; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b5f6eeb20eso137855821cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874544; x=1758479344; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rquQJL2evsCzXK6bUcd8di9MOOXgvPL9hkrSF7CsVao=;
        b=URMTlT4yQ9BGuVEe1U4/fRxrBiBd1rvgxFosnR0LoMjUOsyZ5Yr2V/idjDVqmDPNZn
         F4T9vEMT26z71Pc0DjeBQUIbUAE9AmASJBNTshwtGkkpioQ6kEH31gImorhnniV1i8jJ
         BCfB2ku4uF3+OguDWVxBWuCC3URBkqYpZzBV0GASCRF54MTNa3QU3p7o4UopIJCszziG
         21A9C16wO/BsX2Ooy7jjnkEGFMkbiT77pJ/pXBmWFPvCzb+ctHPYbRPfBKU51Dof+Vf0
         iQgOdMZBqFRFsn6JyEsZF0Egsca/z5kNNgTiOcd2dN9qzcRTQZdrtTnDyreCqsjJP1Zx
         X5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874544; x=1758479344;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rquQJL2evsCzXK6bUcd8di9MOOXgvPL9hkrSF7CsVao=;
        b=jz/WjHNf87NshIBEqMCvO6JEnppZlkA8S5xbhwaKz+7w/cgE4hakA6RPep+r9wX4Z4
         RrQBUS58DLE0PwJTNsnsmuyMZIIhNAraNpbqQD0Ar2NjWllwQ2CRpjdjgrC78B7G4k1H
         zURV44gBS3jmadFUM8NB7xiKc2fXiwqmN5mP+EaPGIzDLopR4ybRaGgJZWcddOcqEdSc
         IWhdP6kD+DfYs6wwOKddBoiGM5HI/h377IIH88xURnFnopWb/GLMuD16l+joHZRUg3SG
         rjMFlGYk3bYLCne+8Y2z8XiDHIj45+CmLe/diPh0sMIzd1eX0Cv4tOry3wiXZK8vSu4O
         I0tw==
X-Forwarded-Encrypted: i=1; AJvYcCX5nQOELBKDzT2CzNUYIh5Iha6U6ul3QL92s9RUNcNQSD27DOb2Okiih3ByrSHgM497Z//NJ6tq153n1AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyctzcKbq9CC6/uLBMOOVLQ3PV9ILsOnnZ9kGxdK9XmXWPG+ZS0
	W5a4fvOGwLHzomPJPxdoTMeLhzZMwzi6Wb5AKGQyy28HqPh0gWPJvn8fJ06yR7d5YZa32fqh8TC
	dnSWOObE9RQ==
X-Google-Smtp-Source: AGHT+IFbVR+iIE1ccbHzJMOYdPr9VXWlSFOa8u5OXqRL9y3cY51SJ1YJ3R7euJutU7WAepatYdrhuYHZu5pu
X-Received: from qkoz27.prod.google.com ([2002:a05:620a:261b:b0:806:b8ac:63c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:4187:b0:4b3:940:e41d
 with SMTP id d75a77b69052e-4b77d0847abmr119904891cf.69.1757874544492; Sun, 14
 Sep 2025 11:29:04 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:28:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182900.1960567-1-irogers@google.com>
Subject: [PATCH v1 0/4] Test fixes and debug logging
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Testing in a hypervisor guest showed some issues that these patches
try to address, or improve the debug situation upon.

Ian Rogers (4):
  perf test: Be tolerant of missing json metric none value
  perf parse-events: Add debug logging to perf_event
  perf test: Don't fail if user rdpmc returns 0 when disabled
  perf stat-shadow: Display metric-only for 0 counters

 tools/perf/tests/mmap-basic.c                       |  2 +-
 tools/perf/tests/shell/lib/perf_json_output_lint.py |  7 +++++--
 tools/perf/util/parse-events.c                      |  2 ++
 tools/perf/util/stat-display.c                      |  3 +++
 tools/perf/util/stat-shadow.c                       | 11 ++++-------
 5 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


