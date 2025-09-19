Return-Path: <linux-kernel+bounces-823695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2981B87380
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9740E7C0D12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B152FCC04;
	Thu, 18 Sep 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mxX1xmFV"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C512F49F8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234128; cv=none; b=Vn9Jc9saeYXNK1tkv4v9a1avMctlEbnODWPwhZ4UG+ve0U11Ce/M1xKJo0wxR3PlxoNRNuAkn1tpebOSw7DkWRAz2+6k27W4+yotLIhrceZliQD2+dZnHnR0DVhtHwSxHyjyQZGgHmisNdvhrVbrxQdjedj14pIdXslibvLghi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234128; c=relaxed/simple;
	bh=uRFw3Dbwduh39YHe6G8403XqTqwe+3wxVmEb4w31I4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=aUaQP7RqRRIEQrVnREFAX0P/LD0RscHyEu2ppJr6RZ1wi2nt5AsYUGVznbiY17hTZVH2gWLN6oXfyTv9BCrrYKN/sLrj4wdRx3v0GD4NPpa+4NwaTyoybsF02LpWFwesH/hu0ghNsvBaZY5GApIveMV+m4cDtlod32TohC3Skac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mxX1xmFV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77e4aeb8a58so230206b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758234126; x=1758838926; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wCx7yhcArqhrw37loxpfN7gk6Bk2L7+1/0aDUKoLv/k=;
        b=mxX1xmFV9NbBD/uTSfMF+2N4wdqEkNE7gZLRXL5oXL8PckBxUJi8qTP1NG/wFMs/V1
         t7G8s9HxtJ9gdbAFMTxL+mI3jwXs8H4ZGzMz1IDSnfiLGyRV+HZ9oKB80eYfoLGxylpD
         nxG0DPjAcBhwYkd4HI7raABOfE5bkAlyNYBxSNuIIvk241n9ZmG/rBneP+yeuf6GqOXL
         0xlsfNdH0NUqrG7Hac6HiYrnJROILcp9qegQd2RLui6ibJg91zRDIMvuCwNiQE567XdW
         k+I/jh87iz9QCeRxGyqadBYRM9wvVsY7X+2vMp/B5pOTvSVHBwaTXBRplKA4plVeBAbi
         s8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234126; x=1758838926;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCx7yhcArqhrw37loxpfN7gk6Bk2L7+1/0aDUKoLv/k=;
        b=Oa31LTrXuDOEaA+e9AEeGj/oebuUO2RFw7Vh0BpmjLlCHgLH8aIpR4MysMK/xIY9rb
         Fav7SkxGRM62KLLMAQP/N+dyofNdC4FLLWRl7M4l5iX1/oUhmi7mAPDsJGV2R0Vwi7W6
         fozmdE1X+MdBM7fmZNoyKA9MBaHPAb40R0yoPSmsZeDyrmaioW7668Akx1I2ZLY+EgKx
         nCGnM21sCXSXtsKmMCmKZxDG0YimeHbKHXooxCzCg/aQOLSpG3vBuSTR7HPp7J1ABOi7
         py0QByVmb19sOZxfWhqr0pgjnjGhNsZFtTGTb8KSmeA8z7y0QhWlk/Z/yxkwNPiWuHnl
         HR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKkARQUbjyLrXpjVjEHa6ywSPNX1Y84XVur9CJ22EtGjTLmtnaNV6nZx+KGpD0SlQE+tMIBtxJWboD9Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6l0W45cc3bxwEaAVapDEKX3vDrGZNe1BgMnZk2P3cjbpNYMv
	R004yGC+uiqHh5X1raQ7fkrkJbniI9oIgHrOFqB2LS524V7sNzKZaD9lCnKyh1q5EHvkW+15A3r
	cWp5lRd0Nzw==
X-Google-Smtp-Source: AGHT+IFCDgkTgHIVgxHktbPWbLrS6oBOdXm/Q4cBamDIgi6qpMFgBaL3H+qDbKj2wCDti317zn/Qe9apa4/1
X-Received: from pgal189.prod.google.com ([2002:a63:3ec6:0:b0:b55:734:6b47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f8c:b0:24d:56d5:369e
 with SMTP id adf61e73a8af0-2925a78e058mr1582829637.3.1758234126189; Thu, 18
 Sep 2025 15:22:06 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:21:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918222202.1353854-1-irogers@google.com>
Subject: [PATCH v2 0/3] Test/uniquification related fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Failures discovered running as non-root and with v6.17-rc1 changes.

v2: Fix uniquification test when running as non-root. Rebase on
    tmp.perf-tools-next where the first patch was already merged.

Ian Rogers (3):
  perf test: Don't leak workload gopipe in PERF_RECORD_*
  perf evsel: Fix uniquification when PMU given without suffix
  perf test: Avoid uncore_imc/clockticks in uniquification test

 tools/perf/tests/perf-record.c                |   4 +
 .../tests/shell/stat+event_uniquifying.sh     | 109 ++++++++----------
 tools/perf/util/evsel.c                       |  28 +++--
 3 files changed, 71 insertions(+), 70 deletions(-)

-- 
2.51.0.470.ga7dc726c21-goog


