Return-Path: <linux-kernel+bounces-768631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8AEB26376
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11D73B5919
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA6301025;
	Thu, 14 Aug 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zBdbMAJs"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933682FD1B5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168689; cv=none; b=AZLCoLny6Losej8m5u3ydvZmMIfmW8sAVbIs1X3PavH9VJvyAlcm2Zou5WcosGGGF48KSkXmTAPJ5e0MvIY/B3TlqB8mjqZ8/UM9ka97F8O6FVR5zNqAwns6U25Koz2dH1dKPH5P2/oXoMHV0WRlFC2CzRANZMO6aEwD1ri4SXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168689; c=relaxed/simple;
	bh=o8uIpvdm8rS/o+S1mykUYGGLHkWfPhCsX3cg0yw1X58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLaNrtRdDfM0J5O5upRNBT66kcJGoqOtd+9WbuZV8W13TvOATk2MNcYwL5cnZkDJdvL+9G7AmeQMgElIHKhvZjs6QxfB16UW5SPaD5oJ5ex46LvPkV7uFffGvyvyP6HHJtdRN3kmOTSybKfFeZotXaB2DuMsN3F0dxBpEJ4hg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zBdbMAJs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso3986105e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755168686; x=1755773486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S28JNZPWK+3sAmARH83rSsyGla0uTsZRncPjJTp9toA=;
        b=zBdbMAJs9CCm85BjdAfc74UUMg1aS1BRv72lP5XEfJ2MdK4TkcC6mninks4lzA4ZnF
         ScPR4mxDiXyAJuGHSfi57AZjJl4HHdBeENXsNnwYNIZQumInYrjWtxDZIq5SmkWLpvFw
         TVnZV+IC3ZbrYnj6tTvTjB5wq+5WgM93J2OctEMrQX2nWiKRqZzlJGpmjCwS+82mKNLA
         i177iYLDLG3Y+/WRIkKd6B/Ub+sa482ghzzGM80S5bCFyvXx1YOvNoLunk08eK7hEiK3
         JsoUcak5mPGDMx/cuGqbUmokmuMQUAfFX4dyW5VZI3rMvE8evkcsbAwjZFQTGiV6pfkK
         9GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168686; x=1755773486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S28JNZPWK+3sAmARH83rSsyGla0uTsZRncPjJTp9toA=;
        b=lHyn2bb35l59/2JLYaAWKqCSggbc3opz+rBebwi91GzfzQ47KMI1Fh9Qvx7jaU/dbX
         j8pVkbvc+DhWAj9ZquRgUUzAQ+57Qfqz6LXwxzpRgpVaJSFo69AQIh26zCeapqfDazgj
         jB83FCoagEqw3i4DuUG0U4KGbwgrlX+h1maOSSTeYgu+VdyTih4sOFn+jZy4ePy6t5A0
         JRXLfcg2vJ3a6YdjF1DT4wrf5XmfOmKNpCn1L6tFND62TrLpGuWARdxn0GENtxtvYUtR
         5N1tbRqJItyOIcKkfobsPu+Zc9J30nRUU599WL3LHeHTNg8GbL3Li0uBDGJv+cEAI+dJ
         Zlag==
X-Forwarded-Encrypted: i=1; AJvYcCVsY2/0X5B5C4tsR2+ko8XEVjhDQmjQFeI5MDx8K0GnZIbpAqKBC4s949T3+zB72JxF3tAPCTmK3bgWXVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15IM7Mhsdfknb5Wh+OPLIT2ztThznD8Dy7BA4IB25ff6zy3JN
	L2bJE5PJfpeY1I0IPtYtILkCLg5Rm/aBMO+zsDqjuKpN0vfOC8F+619UCLBo67AnpAQ=
X-Gm-Gg: ASbGnctG/izBn12vAUhj2nqUz8mHdJ1+mo9jt3ibhlnpyP6alC15AKme+QpuLH07v4i
	cjs99yW3dsQ/BRfjasRklL99yev9KmmU1Z9g+/WiklwpYrCZRr79k/BZkjElzb4ayt/Q4VzTCgn
	spQp/b6w7vR5tJJlP2qd83YBsrDT3R6sUllyjAvUEXEcRHZGc+HrzlEPKTRy/vMOKB2k3AUnDxD
	QrqUgBz+gQRJERT9nHzhkEvTeUHi2eTMW/BVs/e9SkrcZuGPLvzubmJIHfSRZXQe+sAUVQa9UPZ
	BNgqQnJaG/X4G/egBfZCkhiXJSVWaUbMsvLIqxrp0MYLNj6ls2gxTLr5KP1282nyvblUxQMkv00
	2haYAHJ9cgr4UP5Jy7LYgHjr3K9mABic=
X-Google-Smtp-Source: AGHT+IF68KOqRUAOMHDKBpVY9t7uVgR8MmpK7ImpWi3/zcrlNC+5/ptZ2W1zXkHPP+sNnqPRzwGUWw==
X-Received: by 2002:a05:600c:4708:b0:459:e025:8c5b with SMTP id 5b1f17b1804b1-45a1b674677mr23813915e9.30.1755168685858;
        Thu, 14 Aug 2025 03:51:25 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b226eecsm14228345e9.1.2025.08.14.03.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:51:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 11:49:57 +0100
Subject: [PATCH v2 6/6] coresight: docs: Document etm4x ts_interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-cs-syncfreq-v2-6-c76fcb87696d@linaro.org>
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
In-Reply-To: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
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
 Documentation/trace/coresight/coresight.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index 806699871b80..0cd83119b83f 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -619,6 +619,20 @@ They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
      - Cycle count threshold value. If nothing is provided here or the provided value is 0, then the
        default value i.e 0x100 will be used. If provided value is less than minimum cycles threshold
        value, as indicated via TRCIDR3.CCITMIN, then the minimum value will be used instead.
+   * - ts_level
+     - Controls frequency of timestamps. The reload value of the
+       timestamp counter is 2 raised to the power of this value. If the value is
+       0 then the reload value is 1, if the value is 10 then the reload value is
+       1024. Maximum allowed value is 15, and setting the maximum disables
+       generation of timestamps via the counter, freeing the counter resources.
+       Timestamps will be generated after 2 ^ ts_level cycles.
+
+       Separately to this value, timestamps will also be emitted when a SYNC
+       packet is generated, although this is only for every 4096 bytes of trace.
+       Therefore it's not possible to generate timestamps less frequently than
+       that and ts_level timestamps are always in addition to SYNC timestamps.
+       Timestamps must be enabled for this to have effect.
+
 
 How to use the STM module
 -------------------------

-- 
2.34.1


