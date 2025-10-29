Return-Path: <linux-kernel+bounces-875145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4146DC184E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AF775024FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E92F8BEE;
	Wed, 29 Oct 2025 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nbw3OGJo"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D102F12C7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716071; cv=none; b=uGscmwjtLQRaIL2xnSSVQrlXFhlleAyvgAtLfn+JYbW0pfWeCC1VzQI8Qyr0jhZnnDw0vvxgR/j+8dbqwVVbgebUowYxLZM9OtnynrpCCPvqxfM/mO535gBpo8qlnSmZGjguhDnZlL0wsqwjvVPs6avnDKWgn9euqR3VD2sQo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716071; c=relaxed/simple;
	bh=KYZYhoiep3KHKYom3Zxs1sXwmI85jni0UlVUbeI2XEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R7gRaEHjlwXI+GsifVep+pL5ngtwCIQOxP5VIij3M0uHVoV8Wx7RQ97ekUs1jT684ERTuedDPCjSRT7EIhPjsCXu9BBzjnIz7/AndIhsD3igYHn95KfWpT/yb2SXShqHNeTonPNbvheZFkvpB48sBavfukzD3Yd9Yjrt7chCfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nbw3OGJo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-294880e7ca4so120509085ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716069; x=1762320869; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pW3iPoPH/G2JC3s4g+WDYgzHzmDlxJjv1jy/9KHXcKA=;
        b=Nbw3OGJo+rnt48QSyZgtHZkbDavdtp9pHR8BGGvWAV/+9xfD9Hp0ZVkMN8P2ltWOaz
         hficBc5jdLiDC3bU1JYwVaYGttw++/B9Sfk2Jur+2t3D+Fcf7MhMYghWAv0dUeaTojWW
         hzsybNWwuK3exBurgQtqjtS2HwyJM0Z48O+VTnTQom3zcWbF1gaur0V9pS8ctRapcK7M
         I+nxrvbkkY1qZIq8oVjvF6G64xdKYdJ7idselo5T0kfGN6KcnoZ7QCWwH3DugrCek2V4
         EDE25r3CXzVr0NUbR0ZAB0UQlYKR03CAI9l6KYqwsOIjDpKApgcy1PzOThs9ZpuCjHEC
         f/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716069; x=1762320869;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pW3iPoPH/G2JC3s4g+WDYgzHzmDlxJjv1jy/9KHXcKA=;
        b=KbRtPnXR892tJggR1DQvM/1ucExrgwoXh6M4UkV2WM5s+2f9eu/Ves+jBfGm9WnIQi
         hnXphLTQwvPFdq4ZwxOcL6FFivWUvW0vzwRbldn+wAI9GRvn2+l9Fs6oi4iduhDMHe5A
         aukl264oBsjg0pVdfsETVeaMPe972Dsr5W3YTea8hiLEzo1WV3p5KDm/OW4kgjVaPtDF
         E3tdeM59/UL4jUuHKVgdsP7RDlB8Xii4JjFjrB+l4DHAn+fCWrK/u3qnAHMyPCNtYryU
         dKqu44IwVqzNEdxgFtWZsfnMtIzfh515sA/4+roZ44JOWPxjgGyjku3zf9d/X0TrnoB3
         FcTA==
X-Forwarded-Encrypted: i=1; AJvYcCVrS1YmSJhWd0X5l6mJ/aMf50MyugUZT5nAMh8k9yfUCg3NwfeJNYEizpPQ6f8318n2Es6siaYJ/+QpVo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+Fj24FLj9Q/D58kaoe0Y5/Xb3WChDnQpSpi5b0tvOtvnqxtV
	nMKZWh4hNcWwfbAtnfOy2T36dIyV1SxAS5iHBuGocA1Ss0HxS9VPB6RTy4W8hzUjCQ2N6ywnLLS
	fz9KYVh0Sjg==
X-Google-Smtp-Source: AGHT+IHkOM4Uz1plX/1V7B8s2UzjmVdM7pC7uU+GhzKDrWisEtFUM/NjdRl5/HzXEOoYBKFOyAOC0WdbgzoV
X-Received: from pldu20.prod.google.com ([2002:a17:903:1094:b0:290:ab6a:13c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1585:b0:26f:7db2:3e1e
 with SMTP id d9443c01a7336-294deeed0d9mr22357265ad.47.1761716069136; Tue, 28
 Oct 2025 22:34:29 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:04 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-7-irogers@google.com>
Subject: [RFC PATCH v1 06/15] perf python: Add add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #include of pmus.h found while cleaning the evsel/evlist
header files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fa5e4270d182..0366142184d8 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -15,6 +15,7 @@
 #include "evsel.h"
 #include "event.h"
 #include "expr.h"
+#include "pmus.h"
 #include "print_binary.h"
 #include "record.h"
 #include "strbuf.h"
-- 
2.51.1.851.g4ebd6896fd-goog


