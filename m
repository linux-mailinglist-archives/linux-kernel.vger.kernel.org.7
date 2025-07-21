Return-Path: <linux-kernel+bounces-739298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE45B0C48A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1BE4E5276
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1F62D948A;
	Mon, 21 Jul 2025 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzeReaVt"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59902D9483
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102463; cv=none; b=W7YDzMdRDkYn+RIAbMjtRtvJhjah0rtGw/7CohZgWL0+RHoJT1YQM8Ql+x+inQQwyvDbNJAxhBWTiqWv4S/lZCJNrvfoILAaTD+iMV4OiP0nYM2li8f3M91J0pUlL8KBmhmwnwi96Nmj7MLxltsHtY/eMdd/NAuBaZ9j94XseB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102463; c=relaxed/simple;
	bh=luIKfiwgtXeAFEj50ve3W9I2lyEw3hMNW0iXhyMCu40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uq57oUkLpVzg8iYDS8kOE5oJ1djbKygD2IUBqj1HKmyktgvBm/D1omo6tBYQ2K/MJBsCebv/RbdmSJdA5P9X+grY9jIJlIbLkYetEzgVeJwbeN++yZr/XifDRVYbR9FKTN2VIdS+ZvU5qdyQz9VdLNKX12ED4S01F3UZkjHlWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yzeReaVt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so34973805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102460; x=1753707260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9Rue6bPIg/trhgv/sEGIp6PJe+iLR+ZUbz2D5vC1ck=;
        b=yzeReaVtC1gTdZ22qQr9laznUR9VsPBzpt83ldD/JXfdyYsctknu8lvST5EDOiWss/
         cwj1ui61wPe7h8HomQL/vIhHSThTeJnHmx+ZPpHdgXN/tILKuIW8K+vGo08KuTnezV0p
         AtEoqWjfqUuxaKto73hsk80vMSm8GK43NpqZgSKlDFHz3f7DdDmHaHrMBCj5xojTXGeH
         Fc9tQxS7FrvZV8QPVaVz1Q9XyvMtDuJR9J/6N5+dY8V2x+ePF9ZDPOqhD8n7Nw/sK0Im
         6e1abmjwv6Z0uuBw5DDGtfLyD0B2PAyHlF/za77nJlKXaB4VvXifxQCIbVHRaVcUr3QZ
         Lxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102460; x=1753707260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9Rue6bPIg/trhgv/sEGIp6PJe+iLR+ZUbz2D5vC1ck=;
        b=Ry1X7ooaNOoeBj2PVwYJv4ebkJv28hRM5FxwqeioGhu3iQW8LZpoXmwm3W81CuLG6H
         8cjlTiDhpQSNz0IQcL61e1pMbhsnIC6kfsqsOFKimSM5Q42B+Es3K1mgKJKGbxNXfg5R
         IA1HoE1kYdgw72BT6+g38D/ycNE0p3XRnuPmNv9wYz26xyjSQH4Byb89YLKSy08crtjB
         T1YBkC+UmwFee+b10EqfaxHXttrjVf1oUvFqPlFHqg87RBGcAmrINq5BylLrX/Gd28C0
         W+zz0qsBoQ7/sG1nC6R/zsPBZhoB0KXI0VszYCFXXYjFj4QGBYBGvSQI0hpjtppVacg2
         U7uA==
X-Forwarded-Encrypted: i=1; AJvYcCWzprY4sV+FmHKeklFpyOZ4VHamd4sIMMyQgVS0FCPXM6hsNeJ/GHStZEPeqhH5mxQCbcGx51Jp7QcEJ/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6BRFVp5BJcPZQt2CrBJ0ZLCVm7qjbFh5jaTl5UgRPKtcn6HOX
	t5P5YngJuMUT+WuJeabtjg2sNtTQPQ15xVzA5EtYJPqC6Xr9WVwfMjuvGbl3l7KOi30=
X-Gm-Gg: ASbGnctWIs/WVukV0kQcAIwnE9jo8KZSRuGmPmh9qBig+lXQvaNzFO5piHyOo9Wjc4e
	udkrTZdF1srNODODqJ28/5a8TxxBREC8Ne669uAlVbI+qVdMicoMtBF/Ds0IjrbtSxu1AgBlQO7
	N6fLSI2ZIQyjq7PB6mp6NtE5gQcWXVHrXaeGe5JYNkXlm5yZcBnEUabAvFna5yap9TlnJqm7SGA
	5AcWahXI+aocaNcWgg41Nw+QJhXzfzR5DF4ns8YR50Y6OtDXMfRlV4eS4HE0GJS8I2IKcb3niwY
	hfWpvPJOgwWYS0f+yAw7Yp/WAzQ2jMdQ0EbplmK25VL7f/HDbvkPs5npp/sbJPznRYodVshDCzT
	05Red8Cl2iFODWpNv3lhOPWSM2ouqwKYNMhOlepajjw==
X-Google-Smtp-Source: AGHT+IGxBZUjqF1XoJ+We5sWi+shDrL0KCK0BKEfbRSuVRqaPLjbWwQUIAjCsxGeF4Kf4L6TaJ/XuA==
X-Received: by 2002:a05:600c:45d0:b0:456:21f4:a0a3 with SMTP id 5b1f17b1804b1-4563561a6c1mr160172795e9.5.1753102460225;
        Mon, 21 Jul 2025 05:54:20 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:19 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:39 +0100
Subject: [PATCH v4 08/12] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-8-0a527410f8fd@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
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


