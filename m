Return-Path: <linux-kernel+bounces-822729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDCCB848A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7673362808E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0B1DDC1D;
	Thu, 18 Sep 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RJfTU5E6"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902F36D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197839; cv=none; b=oO6ok2Hz2FNdiy57HVaNZUvsjyfOqR4zQWbrQvWgGE+I3XeNfEmV3RHs9RkbwNv10plzgc3wmUVtxHhwr7eAfiR15fxijCqiLKMp6Fj014K/QM/L5+T2yQs2sXs0aldTUVc06g32PHrf0blhtRcpsxUwq5K2Zjz9Hq4Ss4KD7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197839; c=relaxed/simple;
	bh=3HTdFHE1nOnlBuISAA1vPVTn99dilijNsc7PTZ/Rej8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kmKj//D9bV6V45n36fFSNUurfAHdTB2dffmWxuj4wS/PYM53mwoCjJPH388hozv78IaI+UJeCVLVH/eRUYGu2i8uwWqVa4w+WNBzrHohCL/MB4LG47bM9UphdAdr6eSly6iS9wNjDpiSccsKKhM7qKBvrTHi7b6VecFOEzsjqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RJfTU5E6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77b91ed5546so800955b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758197834; x=1758802634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jatDnkKAY0zA3/egfMgLsSXpfyI9PR3+CVwZCbKLIFA=;
        b=RJfTU5E6HCbEvFZDmlZyUaFg7a+olv/lbMXcGLtj6ZGbtSdGcA+q617+1FRBVJxHvC
         cWet5jXlMZ/Zd347fXruZNKUWL+yltUU0cOdJow5VdpejvNYqukq2ooZBfirV0omu9xB
         LRF1m6a5DG1WGLaK5uT8y2roqglZVVQri6HrTlBafnWMT3BptW2C8NL3OHFlgMA0bEmE
         KATQoYrt2iJt1mYCjpxzWJsRvvnuxd+NbV/IJpF3WZ6NZiDMUbsYZfsZr64J4eQpBeRT
         66LQJSbJdgM0I8YD1gqAwpO1Qfi2BlaLHlpr+Oz6HuX25WiFz6emzkMoagX/pJ9vz895
         Mwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758197834; x=1758802634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jatDnkKAY0zA3/egfMgLsSXpfyI9PR3+CVwZCbKLIFA=;
        b=Mz23TXo8W0nCPsjD8KhTs9EnjBp/F/leCRQQkErOt7rcL/vfaKTKJvy+gcYS47Y4u1
         NovMS5t5gXC+rL4BXtqowZJ9YFWqmoiwyelgNgK6C4gAC4ZSgGvgkKeQoUnI033NW/p2
         XBJl9PBRy/6eT8J6S/7rPeYAR1Ep8xzAv/AEfqKAXveHl5GrOLITGwC5zIz7iN04Wa/6
         IMJohwe7fVD0f29xg9OcGEszwTvrpoRPXPFLoqfsNRge3TBljTkY6WE2d1/K/TmqpPwi
         O3ptCx9GTJpXcfTihBrUeszVAS694WgldckEOjOwbFuMuB+npXRV2emlVh4bQwk68ctt
         e0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUGLfg4dPn1CvTMiHmoXpEAqSkssTPLGOKrh0aSqa56LTHjO6o2UTrOUDaBHc5VBZtkY6ZaY6972MVS/vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtz5kKu/tZ1AZRruXsSIGt2tQ6H+RAK/4k6Zd7OkoEad7Srsa
	2koGk/G2FQQ0me3fqnEANbPZta5AqAiotaIa5NEbAKgNmU4On4bVobsCAEQD+eabpM0=
X-Gm-Gg: ASbGnctM3h7IRwQdToLjJRTqMoGxBB6FVFxFmRx853MBNBvL3LyEd2MFIjPEtzFOkUg
	UMrAfGFeb3yTenQ3SNlZrqO/OjMLQxjFtJRuidqTqxxitUhIFhvy1HTtdWUN205wRLyE801UrkG
	CbyMY4/xxA9Vv4/RPLFnNLK3Z/gXY/vMVHB/2oI3xdH1c0ynTogLyt4r2Jj/n4EIqG+25O1TTl2
	BSADavpn1dx6k+oC5spmtVqjHY38jHVrvp5EF2QGvh1ZLB7hWYp3lxBNlSxHLF0zAo6m4J+Ofhh
	rUYWyyPdEgtrfgtXLMKr2GWCW2Aya4YZWtFyrkmtNMlG9reWGIjmLfZA430nx9a7JMnUaV4r0ks
	3W/DQk5mqYuP2yB0qWTAL+O/ezNoygjx3mGFWm6fm0urXrBXULA==
X-Google-Smtp-Source: AGHT+IG4rqckA4W7pc4nGdg3+s4HGjiQFkvQqmFvGUjzXj+OKrljgWz6KGWOYSNvOTvazqcm9w16Og==
X-Received: by 2002:a05:6a00:18a1:b0:772:78e6:f61a with SMTP id d2e1a72fcca58-77bf71cdeeemr7119344b3a.13.1758197834388;
        Thu, 18 Sep 2025 05:17:14 -0700 (PDT)
Received: from L4CR4519N7.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77da44030besm1168023b3a.0.2025.09.18.05.17.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 05:17:14 -0700 (PDT)
From: Rui Qi <qirui.001@bytedance.com>
X-Google-Original-From: Rui Qi
To: tony.luck@intel.com,
	bp@alien8.de,
	mchehab@kernel.org,
	james.morse@arm.com,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH] EDAC/skx_common: Fix allocation check when adxl_component_count is 0
Date: Thu, 18 Sep 2025 20:17:04 +0800
Message-Id: <20250918121704.45116-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

Use ZERO_OR_NULL_PTR instead of simple NULL check to properly handle
the case where adxl_component_count is 0, which would result in
kcalloc returning ZERO_SIZE_PTR rather than NULL.

This ensures correct error handling when no ADXL components are
present and prevents potential issues with zero-sized allocations.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 drivers/edac/skx_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 39c733dbc5b9..768d787813ec 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -90,7 +90,7 @@ int skx_adxl_get(void)
 
 	adxl_values = kcalloc(adxl_component_count, sizeof(*adxl_values),
 			      GFP_KERNEL);
-	if (!adxl_values) {
+	if (ZERO_OR_NULL_PTR(adxl_values)) {
 		adxl_component_count = 0;
 		return -ENOMEM;
 	}
-- 
2.20.1


