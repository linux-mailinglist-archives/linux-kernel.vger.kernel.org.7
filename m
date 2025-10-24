Return-Path: <linux-kernel+bounces-869340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16812C07A27
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0BF3B57ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF9034FF4A;
	Fri, 24 Oct 2025 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRMTlaKD"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5C34EEF6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328790; cv=none; b=gmCA2GRfUu9hSj86U4ZmQpq17sQJEL5X+qupuOyCA6LPt3HKwBX21WUm7sA/wHsSOiiqTDd87VfHBlWaslJemKObrOGso2NmGXvI1WbUhXlSrKIjNQg8AZV/89L8Xf55UwNdWHEuBe0WilecCOIZ4ha+C2kSDzrMNxiatZDRIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328790; c=relaxed/simple;
	bh=yAXsZhxvHyHEQLXos94jIHAJ3UZbjk6e3qIEtM58ctc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=P9npUTefogzmAADbTj4/BMAJCMBo2w0AwqXz6KzplaHe1unvfipfve9rGpTvRQm4vohOTcn5TpNYohYTB+WQVoG3vyq3xyBLieky7C7jq5davqAU9sC2lbYD+6OOIm35d+yMEaqk1VPUrStvYDU8RZimv7DeDy3tFHJH9soVA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRMTlaKD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befc08so5017383a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328788; x=1761933588; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+GqPNh/zh5jE+hbuHQPcYDyfHhHCRzurjNcqVZkY2gg=;
        b=YRMTlaKDCXaJjZWE/GVULI7UW6UzTbOREPsR+ErTuoVR8Ch1gLLVGD6yqM2stBcI7E
         sYAXjcxPLL58ZhhP+YjsLmQJS4GKHvpk1XQTg/qGU/8qI4EnwV+1lPaUGUbuZMQKJ8KU
         tSluW4dIsIiQs5pdT7SVpPczyfLMM9ovFL/051Rl4kthfiXKRn740b6myXGaTNdFkB+F
         0Zd1YBv5WWV2SVBYI0DqKYtydMWJeFWKeQsavTD3+chmo06FDlwmnZZG70a/Qj/5mfej
         QVcy3fiFDZbRZ9k336PclyqSNnKof1rG+lXM/t8SAkr3SsMx2YH/gT3HWb/zUFqNDNdC
         vJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328788; x=1761933588;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GqPNh/zh5jE+hbuHQPcYDyfHhHCRzurjNcqVZkY2gg=;
        b=XzX2w5+8gIy8plzbW66NkmTgRatnc/Lb2f+gFNj0uG/5x1wyvnUtusR6/CE7KwJHgY
         HuGTRLUiEnBRR5I+7En55+QURsvK4iAsg1olqkJSV+LaxAqMvtki9CpjMkvDVYIW47vz
         pfhGnlDh03YF0XScz4ofU33oth/TYQOkXpvZPBFyus7YTVSAGBzhhs1SltoZXkp/FuP9
         0OIyHgaeyE6b+rRdL3RycoTcyPCEH3kmPWzYc/RjDVrVO6jtLxUhNthfZHK98CF2yRrD
         FZTCYm0KeghT4ws1FNzqQUSG2NlQ3WG1gu4OGn8+XVURPNioT3ViacZf8C/s+v2afQxG
         9mXA==
X-Forwarded-Encrypted: i=1; AJvYcCWZTjD0q/jAGlebkaOflwp0I+t+VxIw5zokpOAMiMSXP1ZnjBFceoN+04dwlyrJyWLCoQpAZ237qAInTv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvL7WzEOfpVHinvf9k7Jc0POMhd9VBMan7YXaDgFEXlPj3xb7l
	ySKnHYf+OejbvtK1cyPvpo2ETzsvIp5jLIpAGujlFgUO6l4nChjTN5kDFF68dF6FYRWJKbZKcja
	89BqLQE8aqA==
X-Google-Smtp-Source: AGHT+IGI97mAtuqdO6OgV7iYK43SUTMj0/LhdECvBdjMp+FRWjR96CthVK9UYiaa2g7HS9K9cguw9qEme2CU
X-Received: from pjbmd3.prod.google.com ([2002:a17:90b:23c3:b0:32b:35fb:187f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d60f:b0:329:ed5b:ecd5
 with SMTP id 98e67ed59e1d1-33bcf8eb21fmr38489811a91.19.1761328788381; Fri, 24
 Oct 2025 10:59:48 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:57 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-23-irogers@google.com>
Subject: [PATCH v1 22/22] perf test stat csv: Update test expectations and events
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
	linux-perf-users@vger.kernel.org
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
2.51.1.821.gb6fe4d2222-goog


