Return-Path: <linux-kernel+bounces-756728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405A4B1B862
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FDC18A498A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B41292B33;
	Tue,  5 Aug 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nc5M2gkK"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85111A23BB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410919; cv=none; b=R5oikDpfMODag0WtnNItP4svzTbIw88jin4ou8f3y58l0irSzntrOlM65ONi5Sj2R1GBUnqDEe26gc3l3iTzALcz7S9XsEFK6GZihD6lhG4O0z7I9ZkKlX93hPo4ipu+IqKRMTKoxaKCrC+wt+8gV2VNgM4+2q2KFjv38xFGSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410919; c=relaxed/simple;
	bh=b2dhbaF/pk/NFPcdxLdEyKbE+xfcHsMrSQj7Hev2whc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hYP/C7Mw9KrT59C2MUZxL4Kcj1kFsfZ6yUsEMwLe2LFmCmen7SL2VGBtKltdRP4k0YZVRoklOey84cujbSamRgMnKHOilRSzsZzlq2dsAfC7uWv5z9jYSNXMDOaERFCGBDRArwOpWw8ZabYj4v19SL686C2wpGf0ZQ68uASjlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nc5M2gkK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bb73b63d2so5532104b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754410917; x=1755015717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=36rRNVwGvNB+pofkD3n2pIQi/fX7BoFaKjjYFA4l3XQ=;
        b=nc5M2gkKcABCotNaga0bPyrrqqD/HUMaGAmaFkFINWj5umLoEa2qrtd2XAAH2zr18t
         tHSfoLJnyfcHryyQiVN2yjyGdjQG02t0Eg/rsP8jMkTHg+AKKf3oGNmFUHs9u5k0wNJ7
         WgjorgJDnezchEzPl1cX01xY2oqYjzKSs0k/i4Dmshnex/hgnJd8dnyFjS5N50HOMOwB
         oo+h7HBNmtq8Ih1LxJThXITOv0YHeucx60pIDp3hVX1FUr15Pnd+H3/V9QcF2OAz49Cp
         /FeVCROvXLEKx03jKc6cXbB9b0QAw3o85ObALgETuCLavS/BFJhZA80G9pOr3LxRwWDe
         B/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410917; x=1755015717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36rRNVwGvNB+pofkD3n2pIQi/fX7BoFaKjjYFA4l3XQ=;
        b=eCCJF8ZMEwh93euq83cT/hrX8IyDxi88G4qQgv07yIHBjH1RcqWzoIRHhWfNg5Ij05
         wZZdc2+lFPZB/DVt/1V/DpM+UvsoYLj8beNYFsxbZO5+Gr9Gs1pqDWd14qaj+Ns8IWNz
         82zJrnice3GFWn7acfs3Dwb4p6IQiHJ9INCaYtbXsSxpmRMZ+9t8QThJT39rjqv6LIm0
         Wjn09sn/NmbP2fuDqvum/ILV97q3wtPeezWVL7hOtRL6uGOLgusErb0tcLB26Pt73BUW
         9zPOc1eTmtk6yPRDS5q3lnKxUViUUJC2uZghg2d2P2mzDR3vTBtAj3L3PJkbMzzV3lFt
         GKyw==
X-Gm-Message-State: AOJu0Yylh6h3LBatsTehnWfQPimutlBNwwSwNm0zXLxEi8kjb1jP5Dn+
	eLIpoRal5AUWepuq5d+61v7A+Bof2UVKLcwmV2GMC9KrRwv7kibz0r7pS9VGeBf6UTujLdFNaEf
	NqA==
X-Google-Smtp-Source: AGHT+IH5QrhATp0WCD7uvxonfSLxedpAQyiufvtJEilNswrIwiqKRnjZHsZ8Nh4aaH+sfHB7nbmi5JmkrA==
X-Received: from pfbmc8.prod.google.com ([2002:a05:6a00:7688:b0:76b:c7ca:49ed])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939e:b0:240:50d:4285
 with SMTP id adf61e73a8af0-240050d4b8cmr14866691637.38.1754410917060; Tue, 05
 Aug 2025 09:21:57 -0700 (PDT)
Date: Wed,  6 Aug 2025 00:21:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805162153.952693-1-wakel@google.com>
Subject: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
From: Wake Liu <wakel@google.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The constant NSEC_PER_SEC (1,000,000,000) is defined as a long literal.
On 32-bit systems like arm32, where long is 32 bits, this value can
overflow when used in 64-bit calculations.

This can lead to incorrect time calculations within the VDSO.

To fix this, define NSEC_PER_SEC as a long long literal (1000000000LL),
ensuring it is treated as a 64-bit value on all architectures and
preventing potential overflows.

Signed-off-by: Wake Liu <wakel@google.com>
---
 include/vdso/time64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/vdso/time64.h b/include/vdso/time64.h
index b40cfa2aa33c..07641b27d139 100644
--- a/include/vdso/time64.h
+++ b/include/vdso/time64.h
@@ -8,7 +8,7 @@
 #define NSEC_PER_USEC	1000L
 #define NSEC_PER_MSEC	1000000L
 #define USEC_PER_SEC	1000000L
-#define NSEC_PER_SEC	1000000000L
+#define NSEC_PER_SEC	1000000000LL
 #define PSEC_PER_SEC	1000000000000LL
 #define FSEC_PER_SEC	1000000000000000LL
 
-- 
2.50.1.565.gc32cd1483b-goog


