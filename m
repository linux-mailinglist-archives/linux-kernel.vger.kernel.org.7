Return-Path: <linux-kernel+bounces-805751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D633B48CFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327607A92D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFDB2FF153;
	Mon,  8 Sep 2025 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJ92GMLF"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6742FD1D8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333446; cv=none; b=Xh0bOgqfaZblC1SuuKn3UWkEAQk74Ms1C7vQpgCOv8T3jndPqhrKQqp9eT1OrVlEGBOGp3IMEDA2c4CeTP91lzZ33mH6TnUsg95Es7fTmpuNqW+oajA8v8MDUfIObKq9cZ78egDDwi5sUcXdPUkf2ToROCj8+BsniZf7CcO+eFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333446; c=relaxed/simple;
	bh=IJd6xGKn2wTKzeTG7OBOehcaLPe7DHLOeBtwLK/5d64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dA0WbrAv2AjAsfeDtjpyzjJZHOLz36pDmR8j3X/d3fXg45HcszL4WVK54aiCdu0pTCo2s9T8KxBHVNm7mshUuyFjmER/H9Zh8D48WlJXPcgOSJD0BVckhNwsrElrreIqV3BpDJGRSQocZuWeRuk1HSYVbmgIPmOClOJFUhMoBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rJ92GMLF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de287cc11so5971725e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333443; x=1757938243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkedwrzQI0rdKjNe52sGXdchQDXaBvZiPmkIP1sVIaA=;
        b=rJ92GMLFE57Dp7KrQt6tsUDYQCdfGNqB18dEodOCQzFRdRJi+uiXMAtn6Qx9VF3lr3
         y6r5T9alrQacArDlrmWRgJaQ+4IHqlpykeaW9YCVGNL91EdHiIl1iPQybMmwxOSxlBrx
         zIdG2kEM5quN/J7ju5193JOXb5/8M58bSPXqUcqO0qJI1+UZyMODtDdND/vYgvBTzrmj
         lBY+XbN5mmM8YWG26aL3/ItZmnXNwUpH7XL/IOBYPqg2WHdfj8LsVwKg/raHfpg5t9pN
         cqJgq3XzWTYoZV2AXOjw4NWk1YR30NJk7MCe6r7lBt5nF0RKwLiNvWsdiexgInIb2dQj
         SyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333443; x=1757938243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkedwrzQI0rdKjNe52sGXdchQDXaBvZiPmkIP1sVIaA=;
        b=NUt2H5tGE2Ew9LfxVl/YYwniNpxgfcUA8UBAdlqsBFsPcCd5O9T2sb1AI0A7wMI77+
         ESbJ65QQioQgRgpgrNWgEnHwRxQjJhSqKgYgngZ1uiNTSF0ce3JQ/XPvsBvnHFOBUK9M
         lzYLDP3bg8tpGb8mk39JFXaENqEpFKq4pxFNFcOVAtjOhRl2JUDzHy5+a3VzxNwob1GD
         w4nPaVsBAFvyVKjmS/SjWWpNnSGscdnpJXuyYn3d16cEZ5i8GGayxsBIC8VTqL8cIn75
         93ejEZXikB9NPpqMtqMs1DF5/qkEaqZnxCBe7pVjGYpW0hw6dwN0BGNYZvNZy/nhy/54
         xPZg==
X-Forwarded-Encrypted: i=1; AJvYcCUs+XbpgaMCqSpHDJ7MidIvGA8MuAH5Mms8Xlt7mBELr3foasxT0JPiUJ6NmsoTADleS1gtkOR14ebOdA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEeJR4wZkD3DlF3LOhvFk0ZbBEyjAmtofAwZb2hqPRTA6gS0Ev
	Jje+aPSs+C1R7F/y/ZdO5loepQhWahUCc0fOieIhHQHH+iNfQsJjVgL+uWmDPvZAwdw=
X-Gm-Gg: ASbGncthPS2xO4nrnNG6e0Qbj6sfi2ut42ARXQyVGdVcPdfBPnYHnx/LiGc2UcR0eBd
	vK/qNNPAK5yX0/DwPPwQxaVrUw28BnVtc/bf+IzznBrPBYSYcnGA8oNUM8qMm4VbLlH14lsTF0j
	4WhHxHM/1iuaDXE4w+Mozw2gZL6dYOTIIBzVqk0cAqCexG0oYo/HzBXg4llqUGHlIIhLvIER4v3
	RhYAKXcU4y4NaINOOJdnRmCJVt07KSvTusEl6wXZVB2jLKKnmNCP/MrSsFWPsmcvMY4WEkfCSGw
	n02DhsV6XVwiOvVTT1/GaCao0ojrh52hKyxsr8ARXzqM5GmcQGxnVxbhfnoeDW7gNkk6OIO8p57
	ECixT7LJtYZqu9o1kHz1JtttKjbeZHQG2wn9Vma3QQA==
X-Google-Smtp-Source: AGHT+IGak0uuuS5pIGUifYYsbhCa22YIqe9IhScFSAOd21dRmiIc9QfW//Nsn1rfDOPnEaB1ex4tYg==
X-Received: by 2002:a05:6000:2385:b0:3e1:a74f:f847 with SMTP id ffacd0b85a97d-3e627a7c83cmr6685253f8f.6.1757333443258;
        Mon, 08 Sep 2025 05:10:43 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm41397825f8f.50.2025.09.08.05.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:10:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Sep 2025 13:10:20 +0100
Subject: [PATCH 3/4] perf arm-spe: Display --itrace period warnings for all
 sample types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-james-perf-spe-period-v1-3-7ccd805af461@linaro.org>
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
In-Reply-To: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>, 
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>, 
 Michael Williams <Michael.Williams@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Currently we only display the warning when the instructions group is
requested. Instructions are on by default, and the period applies to all
sample types anyway so always check the options and show the warning.

Reword the messages to be more explicit about which flags the warnings
apply to.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 4c81518a033a..228ed52e653d 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1742,14 +1742,6 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	}
 
 	if (spe->synth_opts.instructions) {
-		if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS) {
-			pr_warning("Only instruction-based sampling period is currently supported by Arm SPE.\n");
-			goto synth_instructions_out;
-		}
-		if (spe->synth_opts.period > 1)
-			pr_warning("Arm SPE has a hardware-based sample period.\n"
-				   "Additional instruction events will be discarded by --itrace\n");
-
 		spe->sample_instructions = true;
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
 
@@ -1759,7 +1751,6 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		spe->instructions_id = id;
 		arm_spe_set_event_name(evlist, id, "instructions");
 	}
-synth_instructions_out:
 
 	return 0;
 }
@@ -1877,6 +1868,15 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 		spe->synth_opts.period = 1;
 	}
 
+	if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS) {
+		ui__error("You must only use i (instructions) --itrace period with Arm SPE. e.g --itrace=i1i\n");
+		err = -EINVAL;
+		goto err_free_queues;
+	}
+	if (spe->synth_opts.period > 1)
+		ui__warning("Arm SPE has a hardware-based sampling period.\n\n"
+			    "--itrace periods > 1i downsample by an interval of n SPE samples rather than n instructions.\n");
+
 	err = arm_spe_synth_events(spe, session);
 	if (err)
 		goto err_free_queues;

-- 
2.34.1


