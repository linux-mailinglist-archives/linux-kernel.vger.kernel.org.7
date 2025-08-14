Return-Path: <linux-kernel+bounces-768425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB386B260FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B401C22121
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0392F83C2;
	Thu, 14 Aug 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZx4yWid"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8CD2F60C8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163571; cv=none; b=Fy/6ggvKuza3avVff9EMR+VnZA5ALer/q+yY54lsOa7QcP6Sz/oyzC6ZEJWDEt1UbWiYhKawjLAjZ9ON4DZBVsRprprISs1DnABeAJH/RzddUIfw8w3+9/KTJRJ6GvBENrXekui737tXfPnRKBlME5vjgx23imJG2A+bMkX0x1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163571; c=relaxed/simple;
	bh=3yjrpHkX+aMdTK90nxuOJyMh4ajXQ8n+rTYB1GAa/ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m92R5sQnz4nTF9RG9du83HjOnt8vzraDL9LOL1MvO21eJ0Gi5EX3v5B/8i/+ESxzllzW8D0l/BK3XzPEmb6TN3F4PJaNeOyWd/zPvtSzlBnbRwoXKPn3Y+pT9IOXN1ToHoCuPytnBnTIePZA3VgTblE/5DOHZm8aTIjKI0bNMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vZx4yWid; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so4566035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163568; x=1755768368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=vZx4yWidLDoaeNiJDRNy5ZUp/YxpLKFArIBE+g7IRIuFFt4POqkE+zq67r8HdiaQyG
         u/89EthjxuD9iIs0D4fnKivkfLSThP7BMWSJerQG8+e6eR6f/Sv9jLttTSrwpC/rd4Bv
         o2P207ammyRTSn1Q5reoMGFZuJE8VuL4W9w2cCxPKbvdayE5lbT9f/nNMoK4pB5x2J2B
         d/WXWqHMzJ1s6rByHA2GxE9lsBD085p30QFLkvv5dpSHZNh3e7KKuopT/EJcOwAhhbjE
         rdy2zR7aAsROvf46NPrgqB+rbf91qOH3V8e5CHARzhvZ9Y3/KGmWH5/2sXiBSRaNShQ2
         /bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163568; x=1755768368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=bic8GH8M1UmYwFVgOE1t9OzRqgOyIFXHpfm0TeZ0qhwOvONYk5IUjly11fxlXckH76
         iU4kKryFAjG3EgUxvACkqoinQMRGliTDS6QCClbkNbtSIQ2Zld6PakdrueljP6eG9jWG
         psneIJYS+jG3iLhMfaUFcoPi3FgMDNdbpwuhF9EETtkPvfmexayjL6yfominbqtzIoro
         S+dnug38dvYMIr7Yaxx8ALNfoXkvhZOttSXPMNOrWYp3Rx7shEpG+jp2i4k84noU7XRY
         /22kWK30IreNCbP5CZiEqdIYEmLr4sS8rc127IJpIPmSv5qsLttGu6Rpf1sFFByoLDZ9
         Zc5w==
X-Forwarded-Encrypted: i=1; AJvYcCUKbiX84fP/MJa7PIfT/PrCPjuM39slJmI/PgxME6vwjcaM9f7wrbBdDSjHTIvx9pVFaaDJoSdzAU/2XqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0Qv7+UNmBqYCcfdioiwWiFa4ve22/fW2gn3bXhDEPpSvXNWm
	9pkbu4clw6vd+lhUht58IbEwjjeObsXswI3WhclATlvT0/QELtaawhihTfLd9Y+V6BY=
X-Gm-Gg: ASbGncu3L4J7IFr2YRGS1yu75kEgMYi6yUhbFpTfYoymiibWOuZCEr7Ut7gqxWZmRL4
	oHRnGI3iJxVCs3p3wQXNhlIGT2v3+gUIoEaVFipzu6NyI7Wli2iBlys/WUoCCZsZH2E+WI+OLZc
	APM4jlOsH6EDNkgsrbdXhnFpkyskmfIrccIJUOX1KC/mSdmjZx13hnA8ITbVaQ/PaYG+O3bbTyY
	l2nzNSxYJQZNFbHkb3du8xTMNHv2LzEXJQS2iX2rGsrr5vZ9PFOobKjG2In8MPNM6Zts7yvnP8L
	K/ycfLLUOBhQkMDi2oVbvloC6NOxaLzRapvjDw39rBa3S+pMbjcA+bS615ONSMXtpeR3Sf5NSpq
	H8PQtFwfPVmAnAT4p4NOU4X4bgsq+QNo=
X-Google-Smtp-Source: AGHT+IEfiNAJpBqr1EBOXZKivbX12m1SjqEMe6qLmXAWuSO2UYgUUw0TISQjYJI+9nhScFZ8SMs3Cg==
X-Received: by 2002:a05:600c:1d04:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-45a1b79573cmr16522705e9.6.1755163568201;
        Thu, 14 Aug 2025 02:26:08 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:26:07 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:30 +0100
Subject: [PATCH v7 08/12] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-8-6a743f7fa259@linaro.org>
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
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


