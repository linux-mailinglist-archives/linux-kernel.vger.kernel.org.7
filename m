Return-Path: <linux-kernel+bounces-744420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6F2B10C95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6258F1CC6260
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A662ED156;
	Thu, 24 Jul 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0iRzo/H"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142502EACEA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365411; cv=none; b=NaIGsyXfVEzTZUkl7CvGs4mcQYqZqupgsj+PEl5UyFnbZkfCb1Rlb4f+W8QYJG/sc5dlsTF07PBpUgqWlbV9nt8u2LXodW+kY83KxitN8kMchG3hCnorMGdGZkjgT/hFEmbiL9IsUkmxCB/l3XlHvoEbXUsaOsTKji8VUCHJlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365411; c=relaxed/simple;
	bh=wEuXEElSEoeDjBLwM+2PEoqxG10Mf5YuozE9z8W97nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2I5aUU4ohHaUaKbtGwCmZ24GzEa+nQzdPXd0CW7WLwb2IKceMye04RhC2UfZwvA1ZcsXW28EoBkUOQ6oJJAci1ZSqdm7TkHBnG745oqtpSKCXm+ZId0zNqsF0KGyxQLPJyA4XPIxTpOCfdagSk2WNb3LYFjxhlQNbKph6cjn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N0iRzo/H; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d7b50815so6724125e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365406; x=1753970206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrjIGy29vhQmG8TWG3X2445EHE3hkTtQk53xAku5ZzY=;
        b=N0iRzo/HSw4GpGt17bXx6b6/O6ZuRBfug9PwLPcIbNX++v94NlSmli3aFPaEPK7H5r
         iaY+TKWGEB5SfGBTAh7kaxb3R4rulLXH1c/u705kGj2fk5OEnziJZSORD+5Su9Df9h77
         SLXNpM5LJtstYeKvG/AH0aSMHepM9tbTUo5eL/B4hyAAksFCeDY9CAq9DFQlQEHRxTmV
         frlisfgdDdcs9lsDMmzS2iHl0vq2a6XGezRMSPMqVjbHSEIx3xFWhpPwCvrtRI10jRXY
         fC4BJZt4VUx3H60OGMoh0qoSCptGcgPQlwoEEPuFQKolRFeRV/gh7d0hfkHSSyOK/4y6
         sl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365406; x=1753970206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrjIGy29vhQmG8TWG3X2445EHE3hkTtQk53xAku5ZzY=;
        b=u0d6hkknKTk3YvtdWRexBP/QZzCWWUfqQSTTmlgF9+I+Hu7BD3ApT32/W5cTjqiQxe
         PvscV465aktxNSYDOidhh5uxd9qzwPIbieDh8G3Q3kRoSQNcudT2+UO9rFiC3kGWUyXn
         /xjI/AK4CNQtIKSoFpnCtGAnGoG7vRuHCFoymhdnhLp5OcF7toRap3gPprNMZBwJYKij
         lfKlZOXfgfY/w4JMx5vb+7CSqDLKlwSjSTWO2yGNFd2Ggr009vJEF6iyscWqwogLczfq
         xV86+tecWYnrbyAhmTjcs5kNQG+lVdtXeHsJXwxL3AR2MVmRurp5wbcfx/gOtM4D3rSW
         5/AQ==
X-Gm-Message-State: AOJu0YyoGS00u+2HrYx2eWZ79RXt1N19Oh1866He/Y4ClsE+fk/a+bno
	Xvlc709W0S3yyPm2ateMXSMD9h2J7PdMvvAVrgO0ozQ/IG6186n2K5ryPa5dPFgvWGUAykMwSws
	wgH87mI4=
X-Gm-Gg: ASbGncsYWlifiiAk8yv7iCExzASzOZg5oQb7djenwxBdUt6XcRhIK202BhPcA3wNy6l
	NE8z9YlE4VQZXtakZn/JvpDf0RUVzbKFsSS1um7mIcQG8V0yWUnB2Hh+rqWN5NdDWx98fSTK5JG
	i2Pmi2oM/YswDNGqBWJDNEY0QzM/qTdceI8dyPGBkbSrquHm3gRZun5j+mGu/exibo68Ev0ggSg
	mANReAx7g+CJ3G3TT6yoAwJo6WxCBrRPxVKaN81kVRwx5kimMeiRrhWUt1b1uuFHfNzDOmTxGrW
	6G/scAagH4+01TvmmRFw8Hll5Vwjmt8RRNO6bH42TNDbDuG6KN+mEptUzVjKU3PPKCFMNQC9jQ3
	6vPM5Kiml6TbHqZyI+It0s+Dq8xPFWTPTP6bdZWVWpRL5CYQGiuW+0u9gdTHUnlAYI3+jVm2wXE
	SZDN0o7SjG+gEv
X-Google-Smtp-Source: AGHT+IEVcqWnuyhtVrHKBupbieg0QvSQq5CXC89YW4ucbe/Xkxqrak9r8AlJ1/jdx+SIbeQvU+walA==
X-Received: by 2002:a05:600c:8b70:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-45868d2c4cfmr54619365e9.20.1753365405757;
        Thu, 24 Jul 2025 06:56:45 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:45 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 26/29] init/version: Annotate init uts name separately into Kmemdump
Date: Thu, 24 Jul 2025 16:55:09 +0300
Message-ID: <20250724135512.518487-27-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some specific firmware is looking for the init uts name region.
In consequence this has to be registered as a dedicated region into
kmemdump.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 init/version.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/version.c b/init/version.c
index f5910c027948..364e7768da68 100644
--- a/init/version.c
+++ b/init/version.c
@@ -53,6 +53,8 @@ const char linux_banner[] __weak;
 #include "version-timestamp.c"
 
 KMEMDUMP_VAR_CORE(init_uts_ns, sizeof(init_uts_ns));
+KMEMDUMP_VAR_CORE_NAMED(init_uts_ns_name, init_uts_ns.name,
+			sizeof(init_uts_ns.name));
 KMEMDUMP_VAR_CORE(linux_banner, sizeof(linux_banner));
 
 EXPORT_SYMBOL_GPL(init_uts_ns);
-- 
2.43.0


