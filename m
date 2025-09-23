Return-Path: <linux-kernel+bounces-829599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7749AB976B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9944C19C244B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A320A5C4;
	Tue, 23 Sep 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC4JlHUM"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73015624D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657068; cv=none; b=LhkWHTOYs7O+pKZNlZYJGL5Hc1Q2BnDYDlCTeX4Q4DjJ9pzLGcbAuH1dTq5xQcOADHsmZlKJ1SGJns175aDnafQEbqApI34g7iSWr/OwmnzRVLzaX7onc1I+1odDD90PQE29YASja+ZBCPxDs/gZyNjZM7xatvyuH9vwKmAuUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657068; c=relaxed/simple;
	bh=wVcA+K5ounMINaVwH/f/1I1XGykS8fRjVmSEYohPCxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BoBpGN2CqEmfRHDteFLVbywa1oKty9MdrVguUOvs9U8oaj3iu1vp3Hu5xNvGVjgfeIpWhKUqnJOOBZ8XkrGPRj25FcaDEjR5gjTnSOumpvmDZw+asDCJjr+T/DnFlAgfSPt+9TCRkoOMyv7nIgMmf4I9MWnWyxCX+b+M1Ug5KEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC4JlHUM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b550a522a49so5197773a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657066; x=1759261866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ehAB6FDec8ZClTzkqi6qQhO0SFHIZCiWE6qrwdH3NY=;
        b=cC4JlHUMM5D8QZqHXqStOoizcen4sj9nEutMwksnaRLKOqmIXPJC/nJF+SrtlVLC4e
         piW+2vBsVGY6YhtElljMVaJzku/TBXeBnOA5HQ8e37mDMOefhJl3WdjDFlNL9FHG9+o9
         SCiAKdGG92K9VdAnV1nt7d1Ix8j1+vFZx0afk3RT3Z0lXafKzb3nlADHNE1MU7JvL7np
         smzXqjmPRwLOWB4IOtxemaZdpETHaEuct/mU5N89TOrO+79selZoSsAQ3VJGPR+2NN9y
         sLwiZNdmvS8NnlbBbkYSR39zAac210+YajbKojDavfOERmK97mQIa2l6RZ8MI9mE57c9
         LAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657066; x=1759261866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ehAB6FDec8ZClTzkqi6qQhO0SFHIZCiWE6qrwdH3NY=;
        b=QUocnOc3Z16z3XiYgJ4/savY7d0EkDkSXjmMpto4w4Z51HjfrLAWamRrTqIfdbL7hu
         hldCX/z3q0X1eWPB9BToJfYaF4wXbrFa5IEuxriBIUPSJYNpqW2hUn+5tDx5E1UFfWf5
         sTirN0LKn5W5ESzG20VfUAXgugR0QMLbYr6050KSDbyNIgh9fdDh8Myv3i+hN+ErBFyr
         lH9lq8IVqGrhLC9DrjGDe+OF+N2gHY8/9KJ7D4fcldoKP14z5E5nK8kTHrck4UIJGWBf
         Zg6++UmltuwR1kujprbLvoAeP21mOzwOpCHJNLb4UemkLznXa1gQ1OTkUgm2BIB1R1++
         XjXw==
X-Forwarded-Encrypted: i=1; AJvYcCXr1VuTbpwFOtLej1PXHY7oPukHNIgF/Ajp4joXtQcW5ERw0QvkjehYQoSLylvVVZultDUPAXKCKwy33Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSd7WjGkO5+yVZxZOPFhIya67kGR1X5TGCCkCyI50qoxYuUjd
	MIpqJ3qkfKMJca2nwJlrmyKvy7ZQqMkMLHJ2IYzEluY/zhUNq1V5vREb
X-Gm-Gg: ASbGncuh+yb0dEmMzyv4rnm4LBLxLjTKKr4HYI8fEZVb9U2jiRy99+RWufzzSP757P8
	HTrPgMKf4MxBk3XK58JqamFakQ2ghiBC1mYvd6myz/ekHeYUz/UJ5cg8oglUiJaVh12HQnjNWwu
	+ENgHyjgFjhWwny/UNzbcS2sVZrR0LFd0WNVyU7Tma7XnZRz+Jblrb5IcrhZBSA3It/9OKkNjxw
	GYJBpNEBZ2kAwYbHulFyxd8SoLLDq6UB0Unx3t9UnROeC8hLWMiZ+/sDFzMcUSE7/MXU8G16ckp
	V4leePTcrvCkrfiHQM9875N4gVTSynSxAXc59nlQ/hQvceEF6kWtb9sQnqBLyR/SQAL16krYYy5
	FVFyE27xeH1zQ5wVdvq1x9qzJ
X-Google-Smtp-Source: AGHT+IEv/yGGrlpOdfY2cliSiBhQF6mMtksTl6D3DmZd+ZV/JQOSaJhhtwrh4WbSv9rczttlYVIw7Q==
X-Received: by 2002:a17:902:ce81:b0:276:9863:44da with SMTP id d9443c01a7336-27cc1570dffmr41713785ad.8.1758657065909;
        Tue, 23 Sep 2025 12:51:05 -0700 (PDT)
Received: from archlinux ([36.255.84.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698018d0fasm170974755ad.60.2025.09.23.12.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:51:05 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: jani.nikula@linux.intel.com
Cc: joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] drm/i915: i915_pmu: Use sysfs_emit() instead of sprintf()
Date: Wed, 24 Sep 2025 01:20:51 +0530
Message-ID: <20250923195051.1277855-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 5bc696bfbb0f..d8f69bba79a9 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -895,7 +895,7 @@ static ssize_t i915_pmu_format_show(struct device *dev,
 	struct i915_str_attribute *eattr;
 
 	eattr = container_of(attr, struct i915_str_attribute, attr);
-	return sprintf(buf, "%s\n", eattr->str);
+	return sysfs_emit(buf, "%s\n", eattr->str);
 }
 
 #define I915_PMU_FORMAT_ATTR(_name, _config) \
@@ -925,7 +925,7 @@ static ssize_t i915_pmu_event_show(struct device *dev,
 	struct i915_ext_attribute *eattr;
 
 	eattr = container_of(attr, struct i915_ext_attribute, attr);
-	return sprintf(buf, "config=0x%lx\n", eattr->val);
+	return sysfs_emit(buf, "config=0x%lx\n", eattr->val);
 }
 
 #define __event(__counter, __name, __unit) \
-- 
2.51.0


