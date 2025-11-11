Return-Path: <linux-kernel+bounces-895314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1671DC4D790
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B221898B21
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86292E6CBB;
	Tue, 11 Nov 2025 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkwRqYON"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6A35772B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861114; cv=none; b=SGwNlAFDigcRJj5EoL+YEkpCdiEZZ6/fwGCuGcvgWMy/sxUS8hOlGZwBmDu/HhOiKsPf9jaiNjIlNMkxAamwh4s1+Ax8PBHnvRsmrPxNcxI1LKO+pAY57LIj2q6Tf3hBWZ5q6I1usRzXb+KYnawABi7GrfgccX4L/CJd6Bj1y4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861114; c=relaxed/simple;
	bh=x95u+IAe5V5q3kdJyo2Q7B3yE503oFrO1P0dSeyIme8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVCR5F0fVJMMIY1YAOkMqCbglUh1wCHhBGiZ3i53/O801inH2UbaMoJw1kiTLbUGTeviKNNxQfAXAKq6IJyNakbzNqyNS8cM+tXmnsHzpyaAXNoDi0pyfnMtaTFltOutw80j/b4M2hNpZMgtkqVo3OMaf0iIIK6OShV+Km3E9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZkwRqYON; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632cc932so16458455e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762861110; x=1763465910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfuWM/BYuIKRAqpYoUgwQd7cyFQJ3HADoloFiEPlZDo=;
        b=ZkwRqYONLunVmEc9PIqNrVtCbI/1N5gLB7N9TnqRc/9xnoA31Ejn6steSAtkZfzfOm
         Y9ZH+Ca8t5IlBWW+ATJwBv+VJ5Nmgl2HmP9cDIWrIdkkOp2df/K7bMinIxZyprq26UWw
         4sGVB4y6gvLDXoFXpjHU4/MuvTZsNSCVysrYoagHQBZ1rlEIkJtNZ5qGPSfrcyNvBUp/
         7bczIxUMf+YE3SJ+MVotPoRprFI8VAU5X5cvtmMsLW0k/fz6lU7l2kMYp49JwC/w1WCX
         m6EX+/Il7RiGc6JysB7e9wrJpmnN+Rs/K2NWEf9ZYex8qOeI90C+6UPTOWiEzjgO8dz3
         Wu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861110; x=1763465910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hfuWM/BYuIKRAqpYoUgwQd7cyFQJ3HADoloFiEPlZDo=;
        b=MgsO9eMNV6gIW8+6HOgCmrsY2+W4X2cjAB4ETXcVVeheynznr6FhkpXvfge4D4fny1
         QChllo9IDovcwczvYHfLaTYTwIYsj0vKFAEoF0ZyZqp17ksgngrtS3SZrlDK2QG6vThy
         g5vHB6eVLWNooz3bE4nGrcBUp1E2qC9rdFIelCG6rYX3rHBtoDNyi9NqrNm037U0ga3R
         R/PXA9jj1yxfJEXkI6ZAet6hVOXTe54Fxiko675wGwpKwu2Bnt1F+TQw2Wx/LRuuqfU7
         6DcnWEmbR1mUbKdfa64lbMLzMc9JP9wgBA1vV6qdE6d8t8bE6ssLfCpehGSjpKCcifI8
         9PiA==
X-Forwarded-Encrypted: i=1; AJvYcCUcNW+pKGPtSKhynpbz7jYTFZ99cyxg06ugf2kTe7mUDmYcAq/Gpz39qKwtgtcNDEJrp3FzC7pn5jx5h2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywubm4prNdNlXdhT5kRXp9O84Hx9Q4MtO7ElxrvenlsLt4Ulk83
	baxJzkwUD+Q8XVctvvziEdFMGxPmedZHzZHJpfTo0fUgZ0HeJNJkHoYrfWqrV6Fx/6g=
X-Gm-Gg: ASbGncsgamfDBzLrKHv7wQ4Q2cmYmgjAAbWo378ftHdSkzbLbT3KBqPcX1S5H1o1wqT
	5mI+jrsCNEHdFUh18gDU5hzx0PyLuyxrsH3rV/R5790+g5n6yPp0huxVWdss0hCmvzXzN8CD61s
	4X+IVoDkFyg2GndXCss2L/dFY5SBA0FW7hjPCXIWYzZT60EQzchINuQ8FxBQ1izQ0ikz1n5P1U6
	Kjr/rCDU+kI/xG4b4sqTRjTb4IWI7cYcAEVdlSbdOzSbMqKCOx44r6NqG0sx8I2CakvbWKZ3UTT
	MxriED56CquF/Jbs8bkxYmzjsmAsY1vO+qCePDZfljyRf0cQ9TjFr4S4bUmzj96C0wToH5Zhor0
	5SQp+vIpeJJ5XAla1BKzEAw5ez5MA2W03TFFFFi3xwRrdlzxf1KwCIoFlbzuBOG56USYCZpGMwn
	J5x7EnZEPtLIYKhvjGMl3OUvCxg/YJQ7A=
X-Google-Smtp-Source: AGHT+IGYPR7rqVbdbF+k3EWMkcQQ1XUolXYoeKsYoPvyE020LtvRy4kS5z2d7QV4g2hQ3KZfV9KU5w==
X-Received: by 2002:a05:600c:1c15:b0:477:7c44:c0c3 with SMTP id 5b1f17b1804b1-4777c44c1e2mr78464655e9.40.1762861110374;
        Tue, 11 Nov 2025 03:38:30 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm28133486f8f.22.2025.11.11.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:38:30 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Nov 2025 11:37:55 +0000
Subject: [PATCH v10 1/5] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-james-perf-feat_spe_eft-v10-1-1e1b5bf2cd05@linaro.org>
References: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
In-Reply-To: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
packet using another 64-bits of event filtering control. As the existing
perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config4' field.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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


