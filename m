Return-Path: <linux-kernel+bounces-761900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2705B1FFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDBD3B860E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D742D9EFF;
	Mon, 11 Aug 2025 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpPWb/4X"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207662D9797
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895613; cv=none; b=V4WTVOusTh0tX6zsdigSRYFWFaE04FipLz4VLnuXQ5z6Qpn3wLysXwYv8G9tSMIfFJ065e9lSrEf8HFXAIhDtoNnX5XNwet34GF9D2duowAW7NSmQ3VHqoylOHRwRujTs3vbYuEOjJqXuj6GFa2M4bE8Ek/0Sji0NX7CMOjLxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895613; c=relaxed/simple;
	bh=c89j4EY7hDQL8ksYXICLyPLxPExiEVG6FrPm7HouZf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyXPotDyfg5MRwHLE7va1f5bmjU1XQ51KyZ2P6vrNK4nE/di0Ws/BTKFuC39q3ee6BZpz1kQs+RrGjxy4Iq09job5gtt7bWF88/FBP2jNIcIIVDNGBKNgt3eJPDzounsuRlb5PsbaZ02JnB8AdMtViA394AFgnp8/Pq5D3NijI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SpPWb/4X; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6182ea5a6c0so889493a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895601; x=1755500401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxFM3KEowHZ9Np37d1Ahrypz2fgPPBHOq5fRBicy60E=;
        b=SpPWb/4XMpyc/tJm6w0I4KWDxAEXCvXX2MQsyD73mBRogeOdRlOMGdunrqZpeBtXYX
         qhYu428+HytLyl+7jUF6dmy2MkAj1/2AvIoCqlAqL0g96yepeWXT9hY082t5iGDpyX/m
         hrioWQGfj3V3/UJTPQ4XTOzhfwrAnZ7bgwBrmWLjtM5MBn81Bo1JSQyp81x+8hh/5aO2
         KECIyQIBVUZVBe2vHc+dUH8rFXTfMjaPxVrNM7xCRsDocJImxMQXtHeEVcn1swZkaWgF
         u2z2ZGijGRhuzMqOgIxslwH5F2hqUN0vkY0l1HcRaM8PopobyhNSHMX7iOJeTbTKLRnB
         Qs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895601; x=1755500401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxFM3KEowHZ9Np37d1Ahrypz2fgPPBHOq5fRBicy60E=;
        b=TBC4i47ljY0dQq6wvF748MyicbFCQLz9vIXPWtA0b2s3x256LZj92VOHwvOGwrl8QC
         CuFafh9zJXmTz1JaaPiVEBU2qd8OAFLgGUqg/sLhSuVZ32mWpX3LWb7XVhIWlWZ/gqWY
         Hr30ZnlATcPIjLAK4x2wM2vq2kD2d6BqSRgUJ9UJMgGCTjprRDwRpRzseQMOLOd5HjA7
         7dSO4qN0fPTx9ozPdoOCggNSVTtyhu8h8mexk4DQiTWjbMd+HUrKz3fzrtvNyMqoDwfx
         HjjTcq9wgYAi497Biq5RkBcpdb9MwH2E2FxdMKIczsuFYRprX+2gCpwNovPDYu9V0Ppv
         cuuA==
X-Gm-Message-State: AOJu0YxziRC4JHPnC9yBzEuY0FoVrG5aGx/va4A/UNMQRnFrHxhJ2dxG
	avn5g+j+M5BEPJKue1x4IuDDioVqwHxsN5Es/9dduIrLQ5VD1XJRyh902uC3iodxyFE=
X-Gm-Gg: ASbGncuUL3Et9G3djDJdPh9xoIdjgo7KyZx5LFIZcL/AqksVlCvbHjyHYoBTKqv7eGM
	xhqK/GavOpiw39jwuosqWOJjxmu6v4HMVF0EV7266enmt4vO2ZBY9c8QpImqafR2HajUT1uHF45
	l4gINkpxUzYQPr8H3jTxF5eOFZAGdPWtKRe9wAgHyFFQqbgtWhAUY0Bbio1QT4K03tFFhJ/Slwy
	z2MR0lR4JRgVW8uYWEhDXaxBntyMHb3qix+gxNsOKIZCHt8axde+xi3UGdE8CiFY8k7ZX92Av/k
	OTAtwbhxhwpwQ9Ooh15nzdjFlmUxNGhlhUP1k+CXXiA5D/O2/1u700Tkki5gr9zfuS6cttVBt0U
	zgJYBoxw7lMuP34SfuQikdkHg2AcShEY=
X-Google-Smtp-Source: AGHT+IFStzTtotqZ1x8RtkFHasRBLezl/MmS+Mh21B3OJrF9cx9oMuSnWhZUtyCl9adlZ9MKETng5g==
X-Received: by 2002:a17:907:1ca9:b0:ade:405:9e38 with SMTP id a640c23a62f3a-af9c63d47a6mr1133777666b.24.1754895601414;
        Mon, 11 Aug 2025 00:00:01 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.11.00.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:00:00 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 5/6] tools/thermal: Fix thermometer/thermal-engine thermal tools dependency
Date: Mon, 11 Aug 2025 09:59:14 +0300
Message-ID: <20250811065915.3333142-6-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811065915.3333142-1-eugen.hristev@linaro.org>
References: <20250811065915.3333142-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thermometer and thermal engine depend on thermal tools library.
This lib should be built and installed accordingly.

Fixes: 110acbc6a451 ("tools/thermal: Add a temperature capture tool")
Fixes: 077df623c834 ("tools/thermal: Add thermal daemon skeleton")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index a4f5577210f1..9cc71b302b19 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -108,9 +108,11 @@ tmon: FORCE
 	$(call descend,thermal/$@)
 
 thermometer: FORCE
+	$(call descend,thermal/lib)
 	$(call descend,thermal/$@)
 
 thermal-engine: FORCE thermal
+	$(call descend,thermal/lib)
 	$(call descend,thermal/$@)
 
 freefall: FORCE
@@ -150,9 +152,11 @@ tmon_install:
 	$(call descend,thermal/$(@:_install=),install)
 
 thermometer_install:
+	$(call descend,thermal/lib/,install)
 	$(call descend,thermal/$(@:_install=),install)
 
 thermal-engine_install: thermal_install
+	$(call descend,thermal/lib/,install)
 	$(call descend,thermal/$(@:_install=),install)
 
 freefall_install:
@@ -207,9 +211,11 @@ turbostat_clean x86_energy_perf_policy_clean intel-speed-select_clean:
 	$(call descend,power/x86/$(@:_clean=),clean)
 
 thermometer_clean:
+	$(call descend,thermal/lib,clean)
 	$(call descend,thermal/thermometer,clean)
 
 thermal-engine_clean: thermal_clean
+	$(call descend,thermal/lib,clean)
 	$(call descend,thermal/thermal-engine,clean)
 
 tmon_clean:
-- 
2.43.0


