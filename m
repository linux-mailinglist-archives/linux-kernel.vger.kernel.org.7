Return-Path: <linux-kernel+bounces-897549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D02C53177
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A28D3355329
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B0A341657;
	Wed, 12 Nov 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wy6wRMt4"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2EB33C539
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960960; cv=none; b=S36L/5I+sKSZ/yZ4C1RxmM6GTjif/QQiP3ImkJwHI9R7MgnvZ09bjqvjoAknBJh9oKEKmiT6bQ/PppJhGpXbXJpCm35fjAtna8tNic3ZeG1y+vQBcDhG178xr6CagZ8Cr1vt1vktjLOGF/uCe5HUj/+8UgRxUgw9kASOBi1KeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960960; c=relaxed/simple;
	bh=1D6ao/Bm/0EBOm0yR+7qj+Q6nV0W56TWm4eeVFjArZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dn6fX/0HzX+cKus6jY4oWStuDuiGdQ7Ci6k0Eeu72bPP9G2LvkS7u/5JEXWwW45YULl5VdFwvn8frW5XAJr6AY4mQ9u4aba/eWE+Nl0hUt2BmooVnOAILHYMCqeejMd/0EC6+x19rbN5FqbhaNVIOFvS3xRlsdGiBrzFPIkrt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wy6wRMt4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b32900c8bso550682f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960956; x=1763565756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUj0j3n1vb2Wu9GInL+qCS54uhf2SL5HLPcj1zO45w8=;
        b=Wy6wRMt4wyQ0Rg2ay/ZNCnfCZ0lrmTskbgXDkdtRR7gdc4KmTpS92Ty3g8UJHRpkpY
         XXYtJNSRCOaHPYzlLpJ4eXgFWZpU98stod5MpYQfGFTXvMFzhdZ0Nbhx64S0m1jqrDqx
         RuJCgV6Fj2RT71XC8oDdmK+/UUPMvqg06I539pppM9vX0K7M+SmRULo4grf8SGy6CCTl
         UalSaEUb/oe4PPmdbGu7N349ejpi9vsUMmxDAzcsxCdQB/nylWy3NEgp/67yrdeErl3P
         37DKmzwn69l0/1BYpfeNq4yTYAO0w174quaAMIAKjgFsau2FOtQzxNataMqJp+aTGpmp
         h3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960956; x=1763565756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cUj0j3n1vb2Wu9GInL+qCS54uhf2SL5HLPcj1zO45w8=;
        b=DAP6BKGl3LruP3/jZ1UNOhmZ1QchFpNvRyhbfLHmTiVpCJKqtfAA4PG8uObaA6Bqph
         oxYlmzsgqhoaqz0O1JGRHg2JwF8iVlY79niyZXZMelJwyiMXVxob455pSoFFKYAIHCoE
         5yEMaWGPMeKjhslUzvK1VNuO3hY8/VEBINMLrpfTpWeo7VZRMAoL3te7kIRPvNmdVYXO
         p26mErQAB1BdCGVbIiRvACAQkhGGyMS4P57M3eSf4PAjDbxn4NfY43DwmPYuz8HTiF9A
         cdsb28FqiCpuZNuWu9J/poHBDnrBgR+DXn61xl4HtUrBgZZvVGf7kSWhXkBCbW/zmzoO
         7DBw==
X-Forwarded-Encrypted: i=1; AJvYcCWHJp/v7AuMSj0ePgGP+EKTv7AxWuV7/X0ZtlGcJsz9rkBC0Qx8Bu1DMG8JJDp19ILWy5La8yVEMnj5+zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaT2XcB6XjqT0jvDKpo66pLoEkitNPJCZcXBWJxoVp17SCLg5j
	NHjQmYma/trc5czrAhK6Wy+Cm+/LqWqrp3JXBgXN3WrON+eGpw9hl47TfbIh3KOEKP1YOTgbsEn
	zG3DBSkY=
X-Gm-Gg: ASbGncv6leQdQleFhobu2lZiIzXvviZLXDWI88LGcunQUmfUnb3jATgsyqYyJYZCcgq
	2ygXwWywYmnG8atA32TqIdHerE0aDW7P6R/yRNTKupfkJ4WH1NQ39VPP5o+uVNRIgE6mKkGM70s
	hEnzXEI4QURLiynYTsfV1VuBoHGZc+00l0Z4BY5wYDYd4vsmj1AZelDmLBOBuJ6TJRrRTK6J5Tg
	YOkDDSJQ8rGh4rAqJjqcE+8yHmN8m7BJW0ea0ur1r/A52YUvX2/ruiBzIyGh3iI5EE6H2mdnI8o
	E005vFTZHlLejuiz3hcEonToVe4LWJuuUALEYhHuCG/pfdF4szKPWprp5srZvwQvIPBA+vG1Cg/
	/6mSzoRUyl9t+V2TkQPkySoM7o6wMnqnqmWBKBtuiJgdG9Zh+bGpzl8tiD0HgNIeylb92tazdIW
	1CVNQI5G3Q4Q==
X-Google-Smtp-Source: AGHT+IFlw5Lz/ACVGaZYBTkar+BWPh1yCKM0EeqPcMg7SFjnpxyLc8kUfqQFePDdrWGjsDSOCoDNlg==
X-Received: by 2002:a05:6000:2509:b0:42b:3e20:f1b2 with SMTP id ffacd0b85a97d-42b4bb8b8fcmr2593627f8f.4.1762960956140;
        Wed, 12 Nov 2025 07:22:36 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:35 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:14 +0000
Subject: [PATCH v4 08/13] coresight: Interpret perf config with
 ATTR_CFG_GET_FLD()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-8-165ba21401dc@linaro.org>
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

The "config:" string construction in format_attr_contextid_show() can be
removed because it either showed the existing context1 or context2
formats which have already been generated, so can be called themselves.

The other conversions are straightforward replacements.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index d19e2568a0d1..7272e758aebf 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -80,12 +80,11 @@ static ssize_t format_attr_contextid_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *page)
 {
-	int pid_fmt = ETM_OPT_CTXTID;
-
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
-	pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID2 : ETM_OPT_CTXTID;
+	if (is_kernel_in_hyp_mode())
+		return contextid2_show(dev, attr, page);
 #endif
-	return sprintf(page, "config:%d\n", pid_fmt);
+	return contextid1_show(dev, attr, page);
 }
 
 static struct device_attribute format_attr_contextid =
@@ -334,7 +333,7 @@ static bool sinks_compatible(struct coresight_device *a,
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
-	u32 id, cfg_hash;
+	u32 sink_hash, cfg_hash;
 	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink = NULL;
@@ -347,13 +346,12 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	INIT_WORK(&event_data->work, free_event_data);
 
 	/* First get the selected sink from user space. */
-	if (event->attr.config2 & GENMASK_ULL(31, 0)) {
-		id = (u32)event->attr.config2;
-		sink = user_sink = coresight_get_sink_by_id(id);
-	}
+	sink_hash = ATTR_CFG_GET_FLD(&event->attr, sinkid);
+	if (sink_hash)
+		sink = user_sink = coresight_get_sink_by_id(sink_hash);
 
 	/* check if user wants a coresight configuration selected */
-	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
+	cfg_hash = ATTR_CFG_GET_FLD(&event->attr, configid);
 	if (cfg_hash) {
 		if (cscfg_activate_config(cfg_hash))
 			goto err;

-- 
2.34.1


