Return-Path: <linux-kernel+bounces-896204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D6C4FD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347573BE8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963DF36826A;
	Tue, 11 Nov 2025 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yl0sNGpF"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153336404D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896172; cv=none; b=d0oUz0jwEUWt15c72pQvtRc5shU9xTDkQu62xHBvA43ysjz90W9HWXd5DEVcpD8Gs14IcuU7ToTS/dUEsQQxeutALiFxDu9MMkJEqRmznf5zVuvCC4ftJMiamEmmYjrlqrXj21DmVZj4L+pGLtVN0Unq0H0aFgYfTzAb4/biwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896172; c=relaxed/simple;
	bh=sWmDIev9bpAFqHQEit38MtJHcI5r4PnZTO5Rq4PESvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OmnkkSLtF4E1YcqYIhHdB+8aVJCgJ20p9efiO/LQ60w1shKkr+uACXuoRZvWUXHX/E4JuCyRv6RGQTgkwhfIM7vvhT8Mk/5ILYzYyqJ7JeTYCUEyaAkGzkBMJtpjTM4xat40PCMYl3kmi6yJKmup4spF746xs8qo7kDlR7awCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yl0sNGpF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297e1cf9aedso4007455ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896170; x=1763500970; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=Yl0sNGpFWcZfAn6hsHOA4+RKIEq8KLLgJFB7K+0MqwVk6hnyCoru6G5f+NKPAStHS/
         3Rk/2ewm99lY0jbFai7eaE3m9C5P5zjdk0y0PyIyXpD4UEX58XS+2Yc7VXf/shMHZMmW
         i/LLR+BtZ5mU9OGqB2GsV3dhteHmscTseiAf10TDpVXL+DfMmF3W6XS+MEGkpf5m114Q
         VCvmOIadXrCJwOO5WXtJvuGaSpSSrBEc+3X1pT7RRBGGDDS6Irzq7f+ji5kxa4KpxhDj
         eVrfDgAHWv+9LoU2Hd6h+HMAtoL83T4k70WiRcGDS78lcu/YfPLcClMiCs/hc2r3Qn0y
         /l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896170; x=1763500970;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=qK2NR5qobc3S5KQdS2FNR9p1T9JfZamh19ah2zyUqEVpR0P8uJe78+UBL2oxRgauL3
         Y6FaJqJGEN+GaPu4NAqne6vW0b38F+tUMPftJbrX9cbE+Ay7pmTdjpDQl836E7C/P4x1
         jSqQ8CU8H4T4IJAEqk0kNJp6s+Cj8Zr075ZpT6RCaPhl/LqXx2KiX0nY0SZSmXrpKasE
         Enpl/DQp/oq5ZtxBFy5zQ4sbLpI9aA284vZoRlg7+cNZX0GZ9uW82AUDaiO6aCAw2dPw
         oaKPm51LpJ58uyvG+Sjsn5bQGabIYdvGivhUEEHGdUvifZdeGbIYw4zsu2WMLWNa8AuF
         Qntg==
X-Forwarded-Encrypted: i=1; AJvYcCV0q6i1YQtTxK2gnjEPy5mkn+WxyCkq/LZdhXOc5oX/K6Cmjly//OmR8H2rtRUaV+AChAmVjzD7CUMdjDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3djU2bXeVuqAvRNqkhwf1lc/Z6pnDanabwYEC1lYVxQLsjLD
	z7VOssAYgpbgBIUQh3kgiIwJ5X0QfPw3ge7UmpOMcngoPPcr5G0sNnbSVrioJ9Q7+lpqANu1bP8
	/83z6tCM0DA==
X-Google-Smtp-Source: AGHT+IGa1PP5X8ELy/S04L/tdAuInta41DDPrTLa3E5LR9MCE5O7NiyATGZSAleEAa6z/AFamcPHwu6JFIoG
X-Received: from dlbrp11.prod.google.com ([2002:a05:7022:160b:b0:119:78ff:fe11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c0f:b0:297:c0f0:42a1
 with SMTP id d9443c01a7336-2984edca7c2mr7947525ad.44.1762896170041; Tue, 11
 Nov 2025 13:22:50 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:05 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-18-irogers@google.com>
Subject: [PATCH v4 17/18] perf test stat csv: Update test expectations and events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly use a metric rather than implicitly expecting '-e
instructions,cycles' to produce a metric. Use a metric with software
events to make it more compatible.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/stat_output.sh | 2 +-
 tools/perf/tests/shell/stat+csv_output.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index c2ec7881ec1d..3c36e80fe422 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -156,7 +156,7 @@ check_metric_only()
 		echo "[Skip] CPU-measurement counter facility not installed"
 		return
 	fi
-	perf stat --metric-only $2 -e instructions,cycles true
+	perf stat --metric-only $2 -M page_faults_per_second true
 	commachecker --metric-only
 	echo "[Success]"
 }
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 7a6f6e177402..cd6fff597091 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -44,7 +44,7 @@ function commachecker()
 	;; "--per-die")		exp=8
 	;; "--per-cluster")	exp=8
 	;; "--per-cache")	exp=8
-	;; "--metric-only")	exp=2
+	;; "--metric-only")	exp=1
 	esac
 
 	while read line
-- 
2.51.2.1041.gc1ab5b90ca-goog


