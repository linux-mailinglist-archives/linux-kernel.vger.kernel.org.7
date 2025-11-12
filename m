Return-Path: <linux-kernel+bounces-897558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5A5C537F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4FE56540F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32732BF00B;
	Wed, 12 Nov 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8crMwDP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA13342CB4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960964; cv=none; b=rPWA3FL9ZyJlEN3v8+MAOCRYqoBD6qKeW3EGbfRl4NR7j1WNLa7m4b6IrKzNMTe41M+tqwzb93pVQoGoHHqpJNElqKsYDO81K1/7eAr9ru7H2ZP8qC0Fa7SViy2CbNQJQQnou1rDnYlOAlWaeNlRgsWpbS27k4Qd2FaWxswYFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960964; c=relaxed/simple;
	bh=vIoSuKUIgKlvMmrNCjvc9BmN+EVbN2mv6N8L+3PJiaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uB9hNmP5LmJbFDDhQAFxzqtT7KlXpRJ8yQUA68fx4w5JbRF0NsQURVakBDBvNNzJuYqeydoW/+o6Tjl3LBgwJVq7ZtvWYeiVluAiH1khJ4xMpSjRybSag3niwlICPTlpbyiQePML67iIQkqnV6lJ2/ZDHAiH2ZrPsVZ9OsQfXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8crMwDP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477563e28a3so5975085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960961; x=1763565761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDsBSlb7WeG4t+Zz0qQoWGyQAvxf7H4neeIGYfC2zjY=;
        b=R8crMwDPpFAUn5w0IF4ncHYxxs9Iu4PIxV7XARy1fhlPUpxtPysJn7w7Y+fnWWjwn9
         +nxwTfh8EOvlf6OJkX2OKNerRCFNB2XvsmojRgmbFp4t2eKXRX/df8aMHTdrGvnL8uFF
         KvfrqFB/YgGhbdPSwhJfVL+9bt6VSqSumHkCYf3wj7jG1EHDxCyhiQY9I3BdpTzilXup
         CMcMStDT4xhtpDnQHhxtT2lSH+tut65rJ+R9F/cYrwIiCtfvipQBKl9eQr8/ASh9ysMX
         zrZafXqGcMN7e92FHsMRtZGwmW9nidrORJSds8lej5/TEGkS0GhXtWYLxzRyH+iDboGT
         BKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960961; x=1763565761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDsBSlb7WeG4t+Zz0qQoWGyQAvxf7H4neeIGYfC2zjY=;
        b=uTWhnp+bRXlu8j74eO2ZWb9kaMlDpQBLjgFzB9LMlq/wP2N0YNRe0Pj2JnP7jY77MG
         8SaG3x3qk48jsQUWddS2cEg8ZpXM7eWWcKaEjbc9qS9LvbYgPoih7e+P8M6Vj9vmJTLg
         bayT5eDdnSpoOBlC4zPQnXbVvCY2GGrWX8xwugfGts+abBY3kgQS3qqFyZz8z+9NUULZ
         GvS5W+HXrrWJCNSe+iEL8kpDwjIur3uVifMLdEkuAyp02Vf1ys65POlInIiziJSGUINY
         /cU4vAkDk1402VUtD37hOIrS540UcbGaKyqHfYYSwMdNU2hbTjcwDz9CkrGNgCElqcj+
         kSDg==
X-Forwarded-Encrypted: i=1; AJvYcCVaYc9rxsfSrL5kK8o08OUlq+OU3KAoOlclwG15xvbBECgJxLHSue91dQ6KV0jM7Q/vQGyPRKx8W6zAsJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGEDsKY7zSQHHZW5HpuFG5RiOPc5aREIeyhlXiGq6lcftswEUC
	xjmvs6SeeTietqWdvRsSsBlqXftisLBTwxaZZwBMz3GgVZ/Al4zrrA+yy6Yk1YYETLSQ78f5Mae
	wGVtgfxQ=
X-Gm-Gg: ASbGncu3VptxQmG7txkesqoX3dP3rbOMeyK+MFlmev/7yTKKgnOmHFJYX2/cVPElqp1
	iiNRW0taT3ge2N6SCnc34P4EpNk0VZMVO0mMhGl4gyBdecqcemePvmCO7KEtfiDSpLHoDh8nkMM
	xGxZRXYUc6W3PvV5vC/EYP0qoSSizXPtC95l68ur25+SYqxRj8Rj8Wfp0fNvy5sNZVn/ZGqcBMo
	5rHfyfSmc8eAuvc5MmwuPInvzoSXLJhswi98wCEAVLTdHTHBGmAQbuNA4FFaQ8jywJ6I9vdj+qc
	vJIuHIFUenOeiz5b4phciwdv5yzmPO7WdfRa/m2L7fYmr+lKVZ8sQIk4bPnZVcZx7yZBYipIySP
	gRuQHgirMmU/13M4Oxrsc8kbSgU30WB49i2wMlD0Mzn/wST0TehqsNoZfHePFS07HsaC9gPCZaB
	QTdEpmTIV6og==
X-Google-Smtp-Source: AGHT+IEuc3bgQChegQeV43CchL7U+HtACup7lJPgzLmedOPZfHtTOSw9g16bfGt0TS1oBLr+C/CdKQ==
X-Received: by 2002:a05:600c:80c5:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-4778142013amr40810085e9.7.1762960960555;
        Wed, 12 Nov 2025 07:22:40 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:40 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:19 +0000
Subject: [PATCH v4 13/13] coresight: docs: Document etm4x timestamp
 interval option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-13-165ba21401dc@linaro.org>
References: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
In-Reply-To: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Document how the new field is used, maximum value and the interaction
with SYNC timestamps.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/trace/coresight/coresight.rst | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index 806699871b80..80b5ed09d69b 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -613,8 +613,19 @@ They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
      - Session local version of the system wide setting: :ref:`ETM_MODE_RETURNSTACK
        <coresight-return-stack>`
    * - timestamp
-     - Session local version of the system wide setting: :ref:`ETMv4_MODE_TIMESTAMP
-       <coresight-timestamp>`
+     - Controls generation and interval of timestamps.
+
+       0 = off, 1 = maximum interval .. 15 = minimum interval.
+
+       Values 1 - 14 use a counter that decrements every cycle to generate a
+       timestamp on underflow. The reload value for the counter is 2 raised to
+       the power of timestamp interval - 1. If the value is 1 then the reload
+       value is 1, if the value is 11 then the reload value is 1024 etc.
+
+       Setting the minimum interval (15) will disable the counter generated
+       timestamps, freeing the counter resource, leaving only ones emitted when
+       a SYNC packet is generated for every 4096 bytes of trace.
+
    * - cc_threshold
      - Cycle count threshold value. If nothing is provided here or the provided value is 0, then the
        default value i.e 0x100 will be used. If provided value is less than minimum cycles threshold

-- 
2.34.1


