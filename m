Return-Path: <linux-kernel+bounces-897542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C99AC5308E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F197A3510E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05386338F5B;
	Wed, 12 Nov 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4yaMC9Z"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB2F285C84
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960954; cv=none; b=uIvgjUm7v2eLbNpsM7wo3dTuCHiAP7tRcCTa3tnTRHZvi5/I3vwqY/1owWGWWpyyfTdekY+1fgK11M9/p1BmNjhjRB4PeaFErb4IgT3cSjmO0wngJNH1CmX1Kaft32hZduBozp86MUKzMk1cre3g3okLCJUNHI9jd4qBPmYyfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960954; c=relaxed/simple;
	bh=OwkdKB4I5DhVWVGSI73e7fFifbHjwD0w7111SvrRlUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1Z+jPOzxsyH8pZugSXQpW10aWPJpuAwQQ3+E3geI9sAekyX4FTj+4XmO9EL5VzJmYRegCPsKQGG0x7sNm2uNhOJ3nhhkbhM64PHcb602v57vXxl0ZLLdQ6Bywe2fpJU9RzYBrZy9eUXxRavqnzYDIHL1RLOD8LPOY0ESl7wSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n4yaMC9Z; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso514733f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960951; x=1763565751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzxatPwaT12t+oimIyPlP1cYh9Rjm5+9wuJjQjgausI=;
        b=n4yaMC9ZDRX7T0jXeyvQaK+6uXNxf9Md2b0AZQM9/lMWDKUjWveRqnskc3ihVV/Xhw
         p40M3YY+XIqWkJ2bYtxl5pCsEP356GxrxpFs3/9jqoZ907U6J8e6EXmyVBqgsV6RPJ27
         4CUjTu7km/mBU5RY8T7SVAQiznB+5JUyj1hQfk555s7QaPFBkU+XGomrtx/i96kJsOzB
         6kxqvgFXQOqR7Y45o/eumg8ZjS90CQZ9p3i07haY0v4Jo832pD24r0OfAatiJL1EaL+W
         qChiPVRR84FWPpq7hyTncKh7gdlaCsCc1C2P15Y1glrTUNLKo20YOKURq4+UcGxJ9lIJ
         DnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960951; x=1763565751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bzxatPwaT12t+oimIyPlP1cYh9Rjm5+9wuJjQjgausI=;
        b=JoHFv5t9Pb8WxZztdTQEQHrLqb9/1OjCYlA+zXkYxLECS9qk1cqbiWWwUU7gpQbdLi
         hawXp9MfY5lT3D/bukW9h1oT83M8XEZgddQ49ut/arB+fgV9l+/xVbAxSIRIFQEXaBl2
         esCqXNWgFf3ZmeVY88XxDcGfN3oAscz+3Pke1Hv8h04pF4zDmmvq946M1Axd1Qkwq0ig
         7ssx88J2LmZWoLSG0dIXzgOSMeTGwvg61UUkF2HgvsSZz6O7KWJVRxxeR1+uEFdL2jhF
         yvHedeJ79jvb4JqjKeTLNXilxtKrlhwuWtgWmD4zrPeGnv8r9FzmtImh+ysRCq7LUmWE
         ktEg==
X-Forwarded-Encrypted: i=1; AJvYcCWXlXcmslu1tLaMRNW4wzx2sBnIfvJzQFKrEYj3o/Nk1xtOs1X9uWAPcjk/yYLPzyilkgbZ4qot1PRfPlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhqJWPR9haWkU4Oa4mnGo+z0VPvGVWX6zRkUPjuNz4V8Bcj1F
	WtERoK7N7NS6Tuf/Rtx6sEI8p5wnQ+B7urn58T53SanUpqvTUY75UMUP7D+/FcPKdwDmLzjSUVs
	jANngLRk=
X-Gm-Gg: ASbGncuo3LCAi/J/9gx+AhNIML2ifXNZsk2Dd6uc+Nr/V4o02EyE+Dd/ijisONreY8M
	WYH825j87TuHUgfgypxFLLoFV5tEJdHU3+LKYKB3uA14Mhw3WModsPFZyJzDssPWl/u8S6fl2hc
	ZG0Q8DHvOUUp0doro7u6ejYqWifx3Eq5Tme2iyByDoc5gEWau/4rLQlQSsqZx1+SgJE6FtvVdQg
	JdrQtakP5GDNDOZDAanI/UVNe2vZ5QXOm9EpN8mCYoFX/CSFDrVlh2Ak25GXHdlbVoq8FRC4Sft
	h2iwylNqxL5OqpEizzofwI+Sj+kqXYPYxihHKx9qok/N7Hir2gFWevkwg5+CLVnRQaPdhvzQyTN
	ubDY9uVjgRw4mVfnTdWtEJOf+fYD2aONxqWfnLRDon36BNWyT0mvnbcMWUqAJUPlCv0l6xo4JoF
	dTWI8KwSeG4w==
X-Google-Smtp-Source: AGHT+IGB7ysGckgxYCnh4ScRny7zYE81+b6VpNLPB820Ao4qDE7C2hKXOhk1d2vMPEvdwcsZY1zqmQ==
X-Received: by 2002:a05:6000:184e:b0:429:c4ce:eeaa with SMTP id ffacd0b85a97d-42b4bdd625bmr3030116f8f.60.1762960950859;
        Wed, 12 Nov 2025 07:22:30 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:30 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:08 +0000
Subject: [PATCH v4 02/13] coresight: Repack struct etmv4_drvdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-2-165ba21401dc@linaro.org>
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

Fix holes and convert the long list of bools to single bits to save
some space because there's one of these for each ETM.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 37 ++++++++++++++-------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 56a359184c6f..8f546764908c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -962,26 +962,27 @@ struct etmv4_drvdata {
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
+	bool				skip_power_up : 1;
+	bool				paused : 1;
 	u64				trfcr;
 	struct etmv4_config		config;
-	bool				skip_power_up;
-	bool				paused;
+
 	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
 };
 

-- 
2.34.1


