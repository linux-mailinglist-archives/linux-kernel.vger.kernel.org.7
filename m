Return-Path: <linux-kernel+bounces-760154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2520DB1E728
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B181896614
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F578277026;
	Fri,  8 Aug 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaH50ZvG"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C3275B00
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652238; cv=none; b=m8DwB/HUXxevqN2ORgsOFZrvP3RKbqHZbHxo60VdPhmhWhpqPLyKnH0O/kJChYgOxwRNpY7CUeVCx4yn2UCQVsNYvEkz8FgGEJhk8LOi6RHAfHOyVSTX00lpb9/yqBCvdYi9VPUB+dKuRnHkP9v8nCiREu7P5IBbxZS0WKgqQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652238; c=relaxed/simple;
	bh=3yjrpHkX+aMdTK90nxuOJyMh4ajXQ8n+rTYB1GAa/ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKXCDcGDZtb6pEVYuXBXQqHwdMj3AE8sNhe7MaOWi2pu5ltXzlyzVIX53OU1Yhfst3e8u+Q5uC7HU6RMuak3OO5qMIyJ1zwxsVsL7C9A9+uxGE2BWWjXWbaiaUAD3s8WrtrTKHBYOAS5bzU3I/u82O2SBPOToHTFz2+I2p0gKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RaH50ZvG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso13287615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652235; x=1755257035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=RaH50ZvGPhQ8bMszL2JExGwns8Ohq4uLiS7Fwao37U496oSk0c/4gs2SAbUq/TY86c
         ux459xL4OGPmGMoDDCArqmhbE+SHf+5SS5RYAgoiY319JSiHokUYptKbbwn+zEhx+zXO
         84et9TN4ZeRQA5G9xecY/5qPI2Al1ojBoK6nGGmlV1wwor87U7oLKNFo7xKpVWcbr9SQ
         RdZ21JDLFeQYw/jxDx815vU4FWNO0kMhFG1lY1uPkyrZJWpgzWhuUyWVLAWrBnCULUro
         f7PskndpE27012BDb29GDh0Xn39gqPJoFjp4tJCnzKtiHJ4cj6sOtRVUIYRotOqInBSn
         3r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652235; x=1755257035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=WCwIFRbXhiK+MVV3GJpH9eR7eWV2LldDVsd3U7oLIgas8wLatmlzuo5qQQ8V8THfaw
         X2wxxTRJZjJwrAPZQFkRr8qCkr8xgLFXsAtjCJq7rwrOKuQLRV9r6FvlV8Gzcu2AUScn
         7oWi+8dCFxTNUMSADOCCO8R+JznV56+raLfp7MaCP7Id38udBOI7c3vvIkhMQQJeY39Z
         z50k8hDtIlMJnjQR49UCdu2Ydc7gYDNUt0nJ1DQMP+8+QkSMDjIZjQsPkZCt9Q4Swyw1
         eDc4P/Xl7tzMsEBAQRWUFs+5jp4QnrSwwU1pPNSaaC1vbxItcdR0vHXwk714aSiC04DL
         zMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXImuE6aKthR039F9fioCzakH57HyoRpLVaad1oQzkwPGUwNBhPmgkEBIkOvxKwF8tMPiD4ke4cXGOBE+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRo/8EeaX9BU5LGRvfcVmSeZn/bCps6eoGnO3+6hM011JMyqQs
	Mxs1Dxc1RgdKE9UmfsvuJCcUCVfV/GM0UswVf0OTZrVv2yIylBV29FfmJj7+hcuXamM=
X-Gm-Gg: ASbGncuCZeHPY8XWrR8O7h/ZWCJv7ANpPkXpA/tp3LsSQsq41qmpu5iG0FZ7+28kQL0
	f0z9j9nbkIwPfLw6Cvr6qwc8zIxmlohpsPjfOYXIPNA6Pf8pxda+RYY3oVuaWjyKlVhZ40+W2/5
	J370ARSaboszk+hxXvx9h3LRe5oPVQ9FH+8uTKK70bEDnYZcknAZ1TONLgbRBIATagheneBlOsl
	VzdMJ1q+IOd01bcvOiZKYCJyLjbhfhv50fatqtbpHEXZxV6HwTStMtzWOBf1KVWRHMN5TagTAHD
	Dk45tIFycDRWhP1eGTCXF1W16QB/Zi8rvs5b0J0ghl1GFx87ihLM6I53MOlYuuKYO7ogIyYIM6K
	wsCCiL2R4klHtDsZQoCX9mVKuBpCmR0Y=
X-Google-Smtp-Source: AGHT+IHOQ18gbVsDEVyKCfZAIEJklPYVqKw1aZ8vUXtA3WE+OW7IGcXWNxJyWSMYhUVtrh63ytt5Fg==
X-Received: by 2002:a05:600c:198c:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-459f4fc3a9emr26503515e9.31.1754652235388;
        Fri, 08 Aug 2025 04:23:55 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:55 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:05 +0100
Subject: [PATCH v6 08/12] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-8-6daf498578c8@linaro.org>
References: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
In-Reply-To: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
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


