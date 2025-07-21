Return-Path: <linux-kernel+bounces-739326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63497B0C4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D74188ADD3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9C2D9483;
	Mon, 21 Jul 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+8ZXiqL"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A79F2DAFD3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103124; cv=none; b=twRmVYDzn2sMW6/yPkpCCh50U2EJjQj7RDLNHb1YvhKg2RzKPn3MoJsa76ZOwt5gLoaDTLJ8wYZUeZ8DFFWZ0Dqm+fHWwnGY+vBDmnmdoMG30HTMJIbj4KFRi0ROrxStPbEhSyFnhOW8CfvqT+8bbDGhu3I7kS4XD37oVWGE8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103124; c=relaxed/simple;
	bh=3yjrpHkX+aMdTK90nxuOJyMh4ajXQ8n+rTYB1GAa/ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m000w5Z7mAmXMggbE5jj4ny70B8i3oU1OY2ZsM57sLPRJSUxQcSxh1QoETZzjO/9DycyxsTp/h53icVMRVtmVrp/mhrvZDlZUWdpLkA/eCP3+4R3qLjzZgrjzwG1Xrp6kIvDXdhzwtWngwAGi7AcV5ba5M2keRwINX1lI0L6KyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+8ZXiqL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45600581226so45096795e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103120; x=1753707920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=o+8ZXiqLRLXZX5M3emkvo3y3nwYFHiT+xAeP5lCWkA1tkX1lPvKNQXdoQDMx4UFoul
         U7kUGQoLkxAQnlrYz+9fPDuG5HQ0pC/z8GRfRSQEusmbwNPRyQO/AYGgdf8CyaBBlbzT
         0XcUOziZNR7fY83Jf2YLxfM2+tzYoYGY6e2J8teDjEYNxxkfVtTGa3cWfOwAeJOJpLFs
         F1eyfK3jzIyBLVb716H8s2+rz4D2b7sKijqKJCbKy1ooYWThtdxUbDen6bhnJLSuEmip
         1O+jekZKlJrehNe7G1RcsYpUR+IlOXHJyd/VorDjbdywo5BdzN4bdLmxaJxRSHDAUuYb
         zgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103120; x=1753707920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=dr2JsrrRP5GKHcc9ZBVgzK19x8xx3XGvFBsR1kD+V2bPEZdxV4M7kAX3AoVlrM0c39
         5tfQNJbsD9650Ronl7SQI0mB+RBGRx18P48OWE0hmgBc5C8WReI95IaoMQdMvHJ003lB
         Dxtr6mM4Z3ht6odBQmhXlu3Q2ZrcbboFp/gdveQhm/mQcw3nRvaUKaADm0sWmErI+o+U
         eP57SpXKf/x7jrvyY2g9yI/iJ8LEsT1fpb4O3gsI3Xwk3RFqxJVJO5IVj8JwJQUPJlaQ
         zbgHUOqwdtz4w7HNQjW1+agHrJGfdiP90jjtv/j7JkM72otgtTf/T+Uac5EjnHzCFA0i
         amTw==
X-Forwarded-Encrypted: i=1; AJvYcCX7ews7GRZaYYeFkE3z7TFt947JshboNQI0x/1+u/RWyHK570gUe02Y/h1FyzxV+t/+AKCXX1oCltFZQHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygj7NbAgu41Qncwyw+ghheQEp1Cfhh4N7Kd8nUxmRvzVX3izrq
	QwadHP78tpjr6pjpWCQwbOxehaJedBrfpwFppqhGbnq7JxI09TWpfesI8CXin434A94=
X-Gm-Gg: ASbGncv+O/iOT2FpjIYnMQjVOPDnBuXNoIyUmtsOyU89qctsJO9MjgJKpvIVNdFFzj+
	mzM1eokwFWczJiBiE5Y/d75+2S1WrnrDirJO5PMEk/wmFbhJ7OtsLg4aCbuPs3xiAo1vcHIM/qC
	Ls1w/N/0B/be8ZgsmPKU+gFTkyw+vnWG3pzyyics3UJ8gi+YSuHQj+ExFK0uSKxqLsek9eoNjmp
	uCtKtxf8h3sgJNUJkfjEJr19LZI3iRfX0jP7C2hgxeNkMh/LMhHEu6aUvCEh3Qq0+2zervW1Mji
	FwBmqJYGyo95WPx0C6bz+UxEm7W9YZIb8YzOjXfF+aHKudkPBuGC3PZ/3JAlGRHKu1UL/coOCe3
	4GT/gmzJKKD2uBuK2qCFUcvbyguG+SPw=
X-Google-Smtp-Source: AGHT+IHcC0WWzrKqr8+Igj35NnjWFuFj+8E1KaR+jWoua9xbcKUEBeLY4nnJZlnbhkk4+Th+Kwau9g==
X-Received: by 2002:a05:6000:4022:b0:3a5:300d:5e17 with SMTP id ffacd0b85a97d-3b60dd731c4mr16367288f8f.29.1753103120265;
        Mon, 21 Jul 2025 06:05:20 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:19 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:05:02 +0100
Subject: [PATCH v5 08/12] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-8-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
packet using another 64-bits of event filtering control. As the existing
perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config4' field.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b80027..0d0ed85ad8cb 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -382,6 +382,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -543,6 +544,7 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+	__u64	config4; /* extension of config3 */
 };
 
 /*

-- 
2.34.1


