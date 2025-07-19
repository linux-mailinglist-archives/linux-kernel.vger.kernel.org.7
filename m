Return-Path: <linux-kernel+bounces-737911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F903B0B1DB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373FB188D336
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA4287513;
	Sat, 19 Jul 2025 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeVZ6WE7"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D2626B973
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752958452; cv=none; b=KCXIcr0JjGaZ9TMUYK6sBF75UdCfpF7JihFpBEZ6JRT0QQPA46UYPbhxKZWlhPqM37Yn11/iPsRKqwKAlw7maTj7X/SSFCSbtB89b0fYKzdAzkMpEGxZV+/7DuhWt1gfOihi0CKmgtKt9O63ne6XS1rYXSMtgM6bemOAdcA4Hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752958452; c=relaxed/simple;
	bh=F9dR/06NQQK5cIEr9/dQvdYAl7ZskEFHUjKsIFnqP1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtc9Abe8JYeo88o1jXdrsHkpzXf2A8ZM4qY/aP2q5r2TjluZwhWih1e5DP5aHLTjx3MkNZoVVJr9QywxL+JHbfmNswuQmC4x9QsVb4vQ0CFDeLes+16cNpHCmL3vJWsv9/IbGM/adgc9kXGIEuG9e7P294phORXNWnbIlfddfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeVZ6WE7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74b27c1481bso1998368b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752958451; x=1753563251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rh/gKiBm4XBBFuYSnL2aQensUxJV9POcMInF7gWpL4=;
        b=NeVZ6WE7GhPrV89LA1cAdie+jHW5zgw3cZfnsTgYE9wfBBPMCi4WG81oED+Aa5RxgF
         Ahr15kycwFMibgz3Y2ODn3B1LeiC3F7slsUA2cT7yIB6FMXkp3YwRxayVvOHKm2DQoVu
         SvS65rXcqO2Zxd7x8mUBsEC/9/CP1NS2ERXloGt+vxh1iIjHInWo+qM6eEEMcXFb/fdF
         moGi9cL3y5I4NFatac96kQbGS2Giclfm2ZXyUD7ZhiqsjaO/XE3Kd3nLiLgmOijozKqg
         J5IOR1oRh/EcVR9WA9TGMmz8LWM9tLStVC7BFWnpPnFc23eJO95NFEbQG4i0apSZAbtj
         5qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752958451; x=1753563251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rh/gKiBm4XBBFuYSnL2aQensUxJV9POcMInF7gWpL4=;
        b=TwuMVFzb74FsHSesMNlgGUBWNkzd4SjlkF/3EuPTgnwLOSOdGY4+XWxfY93hKjO/mQ
         HlAwvdTXVMpgMBnkADVuDybeew5Z9BdHx/MkiAAOiMSko0wJPPcnDgk7mjxGRwlWRFCv
         cIrj659StjgXKlJCmz6axh+SIoCOCG/zb5pJraqI3pgKbZSewN9F1sCofio9KGX+tF3h
         Dft1rk1xiG3vjc8Du2LDDhBmHbTsVnwCSITpNcmYXfEFvJ9O1MY5Nbqme4aiDh8MXMmC
         AdqqjWLaNiHqJ9M2ccVG+aBCAZ69xK5yCumVEa2B0BiCZmhioA34NCGXYsI/Khc+cTfz
         QNfg==
X-Forwarded-Encrypted: i=1; AJvYcCWU5NZK6p/MjyH2X9ENXDL98biae4MpRvLD0HJb1tmfZAl+dLwe9mB9VePvgYWK/bjtIHMbvYEReWY5eGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyooJ3QJ4XGDXetk2I7nW7Sfa6t1OUFdeWmZn0ySo0wLSTbU8i0
	lGoZZ8k7xpXbJElkoalPC5z4kVwIVEV+mDcGxPZZaz/3i/dfsCeXrm8VClTZAQ==
X-Gm-Gg: ASbGncuyN8ap69rWFIOk25qhVP7BLazd/GmKwaQgfdzwNNSgGL6H9Nbral/5FX4MDdk
	EOUT1ak+QWApH4pgWyJUJumRgl70ChfHHQZzwlmmwHBPe76twy8rOwDZl9BrF/XolaHTLLyJTkr
	7e5tzzWq2A2yVPJbT7+CTAISD+LxkcYcId4LGHRcUMHg08oYkjTXpqXuJS28pJOCeYLFU1mpQ4k
	OsdBJ9qrnMzpZiNFxys1WO/Gz754gN4Y6uTi+u2SDv6tlOkBCKVTffvPWaLWRyBeQ+ymbyUl2Jr
	bZ503+FM2tbWUrx77pDGS/ZhJi3daWPLUFpD9WEgpevsLO87lcNgACidph8EtnCTDeLouE+WnTC
	TqKFA6sKUSl5s0Jg+rKbQr4OBdEV5WgwR
X-Google-Smtp-Source: AGHT+IGGZjDSUu3QXQ7QAnkK14/dT6Wde/ltNskHSmj9/1Jt/wCzsCVsHeeyFL1ArDcrsxI/edyocA==
X-Received: by 2002:a05:6a00:2351:b0:748:fd94:e62a with SMTP id d2e1a72fcca58-756e7acf5c8mr19411380b3a.1.1752958450831;
        Sat, 19 Jul 2025 13:54:10 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e27a8sm3273884b3a.21.2025.07.19.13.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 13:54:10 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/2] mm: cma: simplify cma_maxchunk_get()
Date: Sat, 19 Jul 2025 16:54:00 -0400
Message-ID: <20250719205401.399475-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250719205401.399475-1-yury.norov@gmail.com>
References: <20250719205401.399475-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

The function opencodes for_each_clear_bitrange(). Fix that and drop most
of housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 mm/cma_debug.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index fdf899532ca0..8c7d7f8e8fbd 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -56,16 +56,8 @@ static int cma_maxchunk_get(void *data, u64 *val)
 	for (r = 0; r < cma->nranges; r++) {
 		cmr = &cma->ranges[r];
 		bitmap_maxno = cma_bitmap_maxno(cma, cmr);
-		end = 0;
-		for (;;) {
-			start = find_next_zero_bit(cmr->bitmap,
-						   bitmap_maxno, end);
-			if (start >= bitmap_maxno)
-				break;
-			end = find_next_bit(cmr->bitmap, bitmap_maxno,
-					    start);
+		for_each_clear_bitrange(start, end, cmr->bitmap, bitmap_maxno)
 			maxchunk = max(end - start, maxchunk);
-		}
 	}
 	spin_unlock_irq(&cma->lock);
 	*val = (u64)maxchunk << cma->order_per_bit;
-- 
2.43.0


