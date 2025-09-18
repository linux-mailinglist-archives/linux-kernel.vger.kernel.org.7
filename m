Return-Path: <linux-kernel+bounces-822899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306BB84EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20EA37B5CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBD22A4FC;
	Thu, 18 Sep 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFSvQwzu"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38830227EA7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203814; cv=none; b=jFYuXI3UYy1MQv+h1nsGfMpz46Xq5/8cwunhbzlfp3H8taCgZyA1ZHpHmsHa0HZMZtkOfnZEqiCMQBdrCSNw0ExXiIVRi1MbJk96ZVf4TSca1i3Nv112e4pjPh0T79oT/fZktjc287M1EcDBbaBFooSyneycoEnp6LEkJrL2xHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203814; c=relaxed/simple;
	bh=NEzzxKBDdqFQLfhVjZohirqq7fa7nDjncux9WxjLShM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1jaR+4negOT1vfMJ3fMr55+DJQGNcevI2cmsWFZfIKXLnwloHNnoIPt70BRLL4+T+fi0pKyqguQlcV8E9BaCjNd+5yV1k7xt/GtlQmt3+2e+ty9Vj349iviJvASttf9Vy0o7ts/+nVuXalIJj87zBL6xDG8eQ7kf48EqJMluiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFSvQwzu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77716518125so564530b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758203812; x=1758808612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7K9ht8wqxFgnc1Z8YPXX/7XbpSKNOobNT9NVU2DNjlw=;
        b=BFSvQwzukxVAVdloBMJWqw2pP86emcxJUMzqRKQ7L5grURAaxoTxZ6gc2dli5wvfnR
         czwSpMqkaWC2nLWrGCo/k+gOgDnd1u9I/Qwh3RHuIN6yYnyRB4RugbjELkPrtM9cgDfi
         14JDcWydAF3WUqtT3qUVvXR4gTuGwCqWx0pvHpqB/S2AJqhot59zgyYKF5uBpo2rFAwQ
         W5lVeNC+M9oAQGINCaRawg/d3byJY75GlbFvgo/juhowP+Y+ru7o2Y1kXyZxOA48qG2D
         +SMuDBDRoTHrPPe8grRAvtR/hFORS/25wXF5CfhK++//aeN1zP/pv9PxS0dJHHlnZmx5
         kMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203812; x=1758808612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K9ht8wqxFgnc1Z8YPXX/7XbpSKNOobNT9NVU2DNjlw=;
        b=bpRIyo+wzKO0rzpryToXXIS7gwCnsNTagS9iUFKsG/f/J5Cv5wC3yPcCabcFtQgcN4
         Ly8P2L3Ey28i87qjwXqUeBNvHXqNqnjuXGzq/2ZuzfTqsv0zPBYE/4+deH5CUud/nhJR
         YtogENLx/IHyV7SvixAx8P8bjidKB0YpvnQIpQ21eXMyLGs3T2PNdaN16a94D5nQK33u
         kpc6hmeQdc32ckaVmAqffqy5wn0t+8XqKTx1+GSIC4W4TPu/X9U27TVCB3xUht4hRIm8
         8hygayma+vxkAAbN5oizTniQn3sA21e/Bz6yUZrp5bln56pBpA40uaX+sRY5M5wC030V
         IpUg==
X-Forwarded-Encrypted: i=1; AJvYcCUKhgWo9Qlaha8xOg41DMxDH/0JRvPP9JqR2GQW6y0ekfodbSQZTpnBzBcOEN2+ts30LNphI+WR+t6Knqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9FLHOn53BHabZOHR9dU2VVobkhrHpSuwSOZE0pxtX1Ri6TpU
	UEclScCvEaE7QhFgEJJe+24xbsc+h0GyzUaN/08GlWuSKPsdjCTNqRxr
X-Gm-Gg: ASbGncsZzUWQqXQHLeFYtWj6zV28h9XYlSuqcmhEqWnJVnh7jkhPh3r9gOnUqb+nBzn
	HsCWT2OIVPKrjr0HCo0/Awjn3AzRZrtz9abodPpoTFy1g22BZJias9fDtqUp5X2r+DKwZ+Qd+6s
	txCHB7jOR5tdnM+oJKDwO0snRg9eiyr/2x94dEzM5qMsYAXEGD5KLII1ztxgtMpH21SVIQFe3H0
	f3bW+YJkFH7kndNCtw74i9xBPUpovQ+HNmPCJT+CmcMcQ6RzDxxVhzU6Nm/wTbHB+K4w59wwnol
	Rd3nBVKNvaiS1vc8gaSrsA6QYDlAa5/HM3KSwYu7gHNmGkE3u5UUGCZSFteUNhRARXrRnIsjjro
	QJyRhlqdprl7g87pxnpCzyOYeJEPqu4DXMTnUdjR7P0OuDPkuCAyQ
X-Google-Smtp-Source: AGHT+IFM5PbYICeKL5KtPY0OGrSYfAyL/yLW+1e+dl8Ua11+SgxW+x8+VWlbzbax8n+vuSojVrJdxg==
X-Received: by 2002:a05:6a20:548d:b0:263:b547:d0a6 with SMTP id adf61e73a8af0-27aa5b7d846mr9490474637.36.1758203812356;
        Thu, 18 Sep 2025 06:56:52 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:70da:6ea2:4e14:821e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff373380sm2390718a12.13.2025.09.18.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:56:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] ASoC: Intel: avs: Add check for kcalloc() when setting constraints
Date: Thu, 18 Sep 2025 21:56:27 +0800
Message-ID: <20250918135627.3576836-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcalloc() may fail. avs_path_set_constraint() writes to rlist[i],
clist[i], and slist[i] unconditionally, which can cause a NULL pointer
dereference under low-memory conditions.

Add checks for the three kcalloc() calls. If any allocation fails,
free any previously allocated lists and return -ENOMEM.

Fixes: f2f847461fb7 ("ASoC: Intel: avs: Constrain path based on BE capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 sound/soc/intel/avs/path.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
index cafb8c6198be..cb641d37d565 100644
--- a/sound/soc/intel/avs/path.c
+++ b/sound/soc/intel/avs/path.c
@@ -135,6 +135,9 @@ int avs_path_set_constraint(struct avs_dev *adev, struct avs_tplg_path_template
 	clist = kcalloc(i, sizeof(clist), GFP_KERNEL);
 	slist = kcalloc(i, sizeof(slist), GFP_KERNEL);
 
+	if (!rlist || !clist || !slist)
+		return -ENOMEM;
+
 	i = 0;
 	list_for_each_entry(path_template, &template->path_list, node) {
 		struct avs_tplg_pipeline *pipeline_template;
-- 
2.43.0


