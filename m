Return-Path: <linux-kernel+bounces-769325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9685B26CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7EEA25EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ECE1FE444;
	Thu, 14 Aug 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEXhpExP"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7988F49
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190305; cv=none; b=hVTcdLWSSYlDgQJ/j/1tzhrWIgWwJ1NpQNxV3Ade8jctABRnfSV02W4c/3w5YEP7WLnzoukfQAKNiPuAi1Vm5yXQwjpan0rQuj0oo4pLLFKwGyYg/fcH9cG2PjA48eu48LU6U/uC3nOrr+TEI/sQmOWwyvgvHwT0vcbEhs4CPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190305; c=relaxed/simple;
	bh=546+oPUnHFnZfa6yi5axZ3GmMVDm8GXEXOx1Wrgr4Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVTT/BNaSONZu9DZO+5jKu38zqPHUE0wyIgsVVhfVBjZyepoZOthVLnVFzzGFt4pj8YGGxuXgg37VFxUplC/CdR6CLrEnwqWHOv0b/m3iYdioHtarvL8emAP+VoC1rfJmj+Imzk8TRVLm+pzMBQYnlCUuugbU+p0y4C+YS/ZIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEXhpExP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32326de9cb4so1087862a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755190303; x=1755795103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYjGIGZKNjSwwMMePRBYpKkbHMPvIH+4uqVdBTFlwQA=;
        b=KEXhpExPbiqaT2O78ETvQbeBfK0r5cU0GieM0M84MwQ9RY875a6JSw8cmsLR9TxfWe
         zph1TI8D6bNfLaAygXs+RZuyHCktEZ0HxYIvhsyCDQoq0ID0kBvRYrRFLXLRN0uYZl2k
         chiy0MEcHaP+wUbnqw+zqm89jmaOoCjurGGCkodLtb8RJxmYwi4yJbf0RwJYM4b3xhSz
         nRrG3CeEfMA8tmDZ4n5CAaaOW+3NdvJrpudckg4Gsv7hlrmevjheknoMavNJZ1VUqtwo
         dy8M773ksZ4qqRWqqzLo0KE5lXy00KBoKjasFK/eh5aXde/ih07So+0VOblPnxyRYqSb
         oKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755190303; x=1755795103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYjGIGZKNjSwwMMePRBYpKkbHMPvIH+4uqVdBTFlwQA=;
        b=LgeScC/RS4KiVhvYiY5qDvh3KFREcBYBlx9sF+3YmK57HosxGlK4IynDmrbWUKiNun
         pFdl5sPvR7vPMds5XoeCMy2LpINyhec+6Bhqm2qlfoZkMSls3MuZkJVJJ/bm1OuHbk0U
         zcPhxZDQHuskvhID2ZcAICoz1yZdXZQCQm6SiM+X22PtJMjnjsUrM4/EGlJwwhr3vhld
         jBtMKt2MxIC/i2HHoqO9DNEZgwgSDU37uDFE3WN9udU72CeMdnMSOAQLTDZ2rtKLtJi3
         fQg0UJS65eYtSe6bZoW7UmhURLrRtKlQxF61FDYbWpUN5mjkDKP7hYxQfBb9e1b59ybL
         0K+g==
X-Forwarded-Encrypted: i=1; AJvYcCURe6YOw0oMgZaqwafORO6y+j1/KJuckQPCN+NBiJEEqzjAa4nfmSShhKBLkrtSJ8Df7TD+TX/1jMsG6TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztQpgr+f/fTqQE3DWyUDontuhGzo+9m7HQJ2pHblMyFXO6DlPJ
	hkOPrRYLDraxyoDoZ8/nJQG+DvHLcxQygpmfKUTo3RQA7SQf0dGWbInZ
X-Gm-Gg: ASbGncuoyUOLH/dRABOS1ws5ZEnWEGkjabNXCkZYoildgZgVXEx7WVpx8QP84RXH8bt
	8OZzOJez1dwDJUO7WWhrba3zmCqBlbztEBYXCJ0KJI7bMawQ6vyy5lJfxThb59NddwOqXAwu7YV
	ppd51dBLMoYtfg+CsUkrW97UyHVuaQsc1Ru/EFjm/I5PGhQw5W0Z0YZ5ScqoZvpXPvufHSr1vNh
	vfvRLTJsypwnbtHv7IhyU1jwa+v8Bifm/fShXdt21SbMc1bGPm2b99BlZUsd6RPlMaNO2qXvkQL
	XCGD2jR36T0h/HpJLjUz/t9XHLQBsduzYSv3kMr95aQS3PwMJyd419OxKS/Y/kSHVGF2mAlDC18
	5AXGWzaDLIGsXQwAMNmvyR/TKOuS4Z/K5uBisu9EbMGCIJi8O/G0n7SA+3YACo0fjXOpEQqzo57
	c=
X-Google-Smtp-Source: AGHT+IH0MiMwWgviaw/mGxe0R76GtgG7LKjx1+p4CKRkJ7nnW7Xepyw7mwzYq4K+Ze8wJkhejlul8A==
X-Received: by 2002:a17:90b:4b03:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-3232b2c6659mr5225771a91.21.1755190303196;
        Thu, 14 Aug 2025 09:51:43 -0700 (PDT)
Received: from chandra-mohan-sundar.aristanetworks.com ([2401:4900:1cb8:7b85:37eb:c20:7321:181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f9297fsm2375904a91.4.2025.08.14.09.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:51:42 -0700 (PDT)
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
To: jyri.sarha@iki.fi,
	tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org
Cc: Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] drm/tidss: Remove unused value
Date: Thu, 14 Aug 2025 22:20:56 +0530
Message-ID: <20250814165058.615884-1-chandramohan.explore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value "ret" is being assigned to zero but that statement does not have
effect since "ret" is being overwritten before being read.

Remove the unused value. This issue was reported by the coverity static
analyzer.

Fixes: 7246e09299455 ("drm/tidss: Add OLDI bridge support")
Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
---
Changes since v1:
    Fixed the commit message and Fixes tag message formatting.

 drivers/gpu/drm/tidss/tidss_oldi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 8f25159d0666..7688251beba2 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -464,7 +464,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
 				 * which may still be connected.
 				 * Continue to search for that.
 				 */
-				ret = 0;
 				continue;
 			}
 			goto err_put_node;
-- 
2.43.0


