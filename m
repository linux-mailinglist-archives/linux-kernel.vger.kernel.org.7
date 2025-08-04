Return-Path: <linux-kernel+bounces-755684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4EB1AA5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49231892158
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427542153CE;
	Mon,  4 Aug 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaKGNeX8"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01B1FBE9E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754342981; cv=none; b=YwQtGykmbDOzfhOOsYAkaoea01pxpISs9JuJwW4zpMVIBfiC03t/7iMAN9eGDR1QDUHn4EIviXZowCeZ8mlpOXay9yUOENO/4IoEqbJAI+D6GEIJiZDjQTQXDFLszMsdeb2MtsCt++vTm7QBSnxMLgjYEn8P8/zo+iF+NwzaK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754342981; c=relaxed/simple;
	bh=HLMC0BDZvpfPdEhOFSmgt6KiKuI6WxwjYThtWbOkZ7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJ4zL7oRIs5QTblEY1SiA2Gs1hrSlBHTfJV8dgbdEd9r9g4UXMmfrkAlcJ/p5YY3JmuZtj2Lv/1zG+WHzeR0Z6GXrgVdeAHvPDBKJJ9Gm93AixoG/MX2PXt4sPTAZOySY7Rbbwlf+gfFArWUOp2uCxF8KdpzFSz9gqT3sJ8lvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaKGNeX8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so2363948f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754342978; x=1754947778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnAv+EkxtMe6sOgi/X80+/azh3A8nh9nT/C3VYMPy+M=;
        b=TaKGNeX88LmO6Uu58PfXp4Iboc+p+e2giVfxUWPnTk/NYGrBsyMulwVbqUw3gu9Cit
         kK93ZoDhMKb2r/1fDoZxwcOJmyCDsvMCpYGmthTzHy+UxNtjQgzYl33PJOFrdSTePvuE
         WXnfYKuZILmnctLYVDOCTHz8IfSSAheAI/j0xwcYnmO9hczespdWKewRqZB0423mvzgG
         S5vP3z8+owSnoFDSLhJcvRlbFEEPl8uOP24A6YCPooO+g76S9MGBcX3FW1Y7jFhOJPg4
         h7jya6uLg1iz3B3jW3lA7ZGAO7e+vai2qyxFgl3JdY52ctOjGfQHYiOWuhGui60SrHr+
         0TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754342978; x=1754947778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnAv+EkxtMe6sOgi/X80+/azh3A8nh9nT/C3VYMPy+M=;
        b=MpUMneqq9lmQmOa1pNyts6h0neI2bWg5j6pko1r+UD05AuMz64bs31ooUwgDYk7ysM
         Lxf/nBRX7zDY0FEoyi6IO3n5vbs47S3S8dWvsYgBj5x4SK1P7yLt8i2CWZFQehWNL2UI
         eDXpnkD71rKVtDQ5YDW6eFd/iRAMrco1uQ598MLBBMBUBPQtlhsa5l47tedMyc+eFynk
         lkVpZPKNhxzkBBz9ci9jiroFcIcLb57/XoaCMXqFeV3Q7HVflABeYUMfPr5xk/AuV7jh
         iZZ7NW+GKbV+xVWjCypYk3Mz4K3X/mwRkAxccKwkARY+Ox6Oqiy98cNfsO3dqWDiqm+d
         9Uxg==
X-Forwarded-Encrypted: i=1; AJvYcCU9nAWh7TvUGJjjfx3VmwEbk+1oqJoCcIPnYFBLaek/qvNNIUpibgo6b/pPCw4/ixLEauRfaOqLhZlXo0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FSA2BdMXkAETuVkX+ueiUK8iDDARe0Mhw7TDQEtOlgOiVRE0
	tJNhKle6jKnQCfWYh05PyUMwV5SG7i0GEGfAw/FqGKdIdV4Xbql+lz9veE/5CKji
X-Gm-Gg: ASbGnctkuK2AOgT4N6w3fjmwrU3UFWMUURyALFJwSmHUPksSNfjUQ2lLi+RrrAp+ToF
	5bkERJjyg2Z2RGTMJoJ6LPmvudgYDvR3RwuVpvaFZEowzQshFD/aidjaCTXTDkvAQXtErjmAwnI
	tq1zEv49GPzGmO5Qof5il90S1Cbva2+M04KcjIymtWesF5msmQ97DmnHD+hbACR+WzfYqYQ8RJU
	tvT8F/hJoeeB9jLgMA2x+GPqQ+vtFE/CxDh40i/MxcRRRuAtA+XnRXxbCEc6kzyVG41LRSSFoWv
	t4We7fJ66cltC9to1NMPjP4E3Y7/3T7zkVZnaX8Qsfwi0i94owkFlQDcg/1Niy6h482iNJWQgjq
	kLrqZjurl3vSrSquqjF2Z9npHA7XJYSa6KUzc/ganl4dqnkRwfhzBrrc=
X-Google-Smtp-Source: AGHT+IGBConCSeAXtT5CM7S11KudJt57JA5mhifRnsIXMElN7scg3DGiRYRMN/MvwC24p4tTvJ957A==
X-Received: by 2002:a05:6000:290c:b0:3b7:97c8:da97 with SMTP id ffacd0b85a97d-3b8d94baa99mr8936813f8f.43.1754342978164;
        Mon, 04 Aug 2025 14:29:38 -0700 (PDT)
Received: from fedora.. (109.red-88-1-15.dynamicip.rima-tde.net. [88.1.15.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm17056704f8f.4.2025.08.04.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:29:37 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: Javier Garcia <rampxxxx@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Add directive to format code in comment
Date: Mon,  4 Aug 2025 23:29:02 +0200
Message-Id: <20250804212902.22554-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the warnings:

  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2444: Unexpected indentation.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2446: Block quote ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2450: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2451: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2455: Unexpected indentation.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2456: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2457: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2458: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index bbc7fecb6f4a..74d949995a72 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2432,6 +2432,8 @@ static const struct drm_gpuvm_ops lock_ops = {
  *
  * The expected usage is:
  *
+ * .. code-block:: c
+ *
  *    vm_bind {
  *        struct drm_exec exec;
  *
-- 
2.38.1


