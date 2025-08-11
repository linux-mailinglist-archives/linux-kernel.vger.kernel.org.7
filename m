Return-Path: <linux-kernel+bounces-762231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208ADB203C4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348FA163B55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631C2DEA72;
	Mon, 11 Aug 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOyCkbIl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC8223DF0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904766; cv=none; b=GHduzfmNLy/MWAOFoFW4tthDny5rDBz0ypRK2vnd8Rr9a4e/oaWuNmV0M3gH/s+M6I0Gpz1X2L3rx/xGSYOt2Pt31hVrMlGQv3uRRAs8yXIsultBK/cqzJEbWF55HncvGZbDz90bXrxx4V84ClxdM7mRBprsZoyI8Vdied93PaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904766; c=relaxed/simple;
	bh=m7ucCcGVN0FUBECCGdzVEI3m8S2GTPWLCEum9ShUMNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6o/NeR2lUbPJEgT61+8qJD2ITGZXoblwzyUH6QZQz3APBsVvdnm1y6H7RSp5Q3XY+8hKKTsvdyea+PbI+TEkConiILYRGpKH5tuRliCxYjAfUEM+I1K2LDmBT5DXzrFZ0aXggNx6NTyfd94DmebHfTPIbitBILyYS9OuxkN9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bOyCkbIl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a0d5e4c45so2082065e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754904763; x=1755509563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GDsN9LxSDEitQ0pzvRQqf9bGA4AutUNUEYwRrkhQ70=;
        b=bOyCkbIlQGlaaFvckPGg9UK/kyDTwKtKG7AHC5+YeUbp3TfntVNJ3nXrItmFgixAp+
         NZZkhw7zgyL4TTXafNkqjvo25tmBZW62Nfisn5btteUQPxRd1ot0vXkbnhZoJ3TQTt7w
         d7JAodKnFY75Us+QSnAUI2Gkx2CxrNrgZVHNCesydn5F+s9Qn5TYdViybWRAACOySflg
         FlZ9tb97+HMR0U8i8y1qUmUbJto35VufmOBbllB8smXW4I3mEfnD38DwkJc1PANgRZuA
         WTCO7uyEBBAANyxIReAR85bRblqi+BZSX/OXmGw4njWcw3HL1owKUnbAMVIGQV3ugK7k
         VBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904763; x=1755509563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GDsN9LxSDEitQ0pzvRQqf9bGA4AutUNUEYwRrkhQ70=;
        b=C9cVik+eJBOa4qdtjkDcxDpxTGU8b6uz0AgqCifzTSdRkoxPIR6FVfI9XP/mwJjP2i
         7xrSQUKo2NIVaZavMHmrHhN3zjSclbzNUNHrkNpQPqGRrjGT7gcgdsYBEdrZdYe/3Wxr
         IBCMHEQcTGd3U5ES7SdmBiEftrRUNzAGYv+bTOxxZ71+G3YmiqU4dbQEO3Zrk4TwoEZE
         59h5hfMTqjwBkCk91ykYRvs1YQPWN4Nw2bPHr9MoYlGqHiMhJ5d6hGU7EuHJBNgODozS
         BGAlhYq6yG+PEwMjqMiqX04VXcfBLn+eDJJFZ/apU1cbn6QeHx1GQcJjQn3I5xrJUd1i
         zg8g==
X-Forwarded-Encrypted: i=1; AJvYcCVig2MM77gfRNsvY9BD2FGVrRJKmIZrplSKRLmnxosQrjn82K3YhREDxm2TYLwOnrYLqPt5nLcbgMLhZ7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwloFv9V0OJY/VnpjaY/CiTQuqIZgJX8JDUBknOBWrSme40/INt
	HsWIuFJ28BlDn5MCP95LU1Op/hiHAw+JKy2qM3RJJ2J7oWbr5bL4izQ+sAZdNqOmqlAS7FAgV5W
	LqMrZbaM=
X-Gm-Gg: ASbGncvB1plbyxdrEkRnRsfqQz9/Pxd+2VkaMran27TyfNcebdGYVWtcgjTTgZMEXGA
	55fzg2YIe9IbCQf1pAnsV7BQ9ee71hn16KE3RDklsfW8N9xjCJERHjukdYVxUpGYE7CFUI25/1J
	/BeQwBi56L3iwTjLxjlvtRT1HBJGpmf0V8TpDKGAN3CYXUUdykPLpjOD4U7SwD5I0bzoKijvVSt
	rib2jeJfnbJsROKdziXZYxZw5IbS4+6akZdDactb47L16kjNRb9KzA3IV8ImRbTZAb9kRVINhRP
	/Z53eJDGJZxLqBahbBh6TwxJmeKknSp0kuvrXwDCwC+AmJ/Gzw33rBLEO9TJ+pYQMRIOP/dFVaJ
	Tw06r5nMrPi5N72UM9BWdk3G+LBWLbrQ=
X-Google-Smtp-Source: AGHT+IGq+ywQDRPYbHWh34YnCQ/IpGU3if6J27Zgp8ZmTttsheGYVInR3KO4d/MWZnAmbDz0jxuqcA==
X-Received: by 2002:a05:600c:450e:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-459f4eb5e2dmr95609655e9.13.1754904762901;
        Mon, 11 Aug 2025 02:32:42 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm39904799f8f.39.2025.08.11.02.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:32:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 11 Aug 2025 10:32:08 +0100
Subject: [PATCH 3/6] coresight: Repack struct etmv4_drvdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-james-cs-syncfreq-v1-3-b001cd6e3404@linaro.org>
References: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org>
In-Reply-To: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Fix holes and convert the long list of bools to single bits to save
some space because there's one of these for each ETM.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 39 ++++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a355a1e9606d..1c67b263b01b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1020,29 +1020,30 @@ struct etmv4_drvdata {
 	u8				ns_ex_level;
 	u8				q_support;
 	u8				os_lock_model;
-	bool				sticky_enable;
-	bool				boot_enable;
-	bool				os_unlock;
-	bool				instrp0;
-	bool				q_filt;
-	bool				trcbb;
-	bool				trccond;
-	bool				retstack;
-	bool				trccci;
-	bool				trc_error;
-	bool				syncpr;
-	bool				stallctl;
-	bool				sysstall;
-	bool				nooverflow;
-	bool				atbtrig;
-	bool				lpoverride;
+	bool				sticky_enable : 1;
+	bool				boot_enable : 1;
+	bool				os_unlock : 1;
+	bool				instrp0 : 1;
+	bool				q_filt : 1;
+	bool				trcbb : 1;
+	bool				trccond : 1;
+	bool				retstack : 1;
+	bool				trccci : 1;
+	bool				trc_error : 1;
+	bool				syncpr : 1;
+	bool				stallctl : 1;
+	bool				sysstall : 1;
+	bool				nooverflow : 1;
+	bool				atbtrig : 1;
+	bool				lpoverride : 1;
+	bool				state_needs_restore : 1;
+	bool				skip_power_up : 1;
+	bool				paused : 1;
 	u64				trfcr;
 	struct etmv4_config		config;
 	u64				save_trfcr;
 	struct etmv4_save_state		*save_state;
-	bool				state_needs_restore;
-	bool				skip_power_up;
-	bool				paused;
+
 	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
 };
 

-- 
2.34.1


