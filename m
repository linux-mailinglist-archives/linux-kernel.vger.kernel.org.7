Return-Path: <linux-kernel+bounces-814358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0748B552E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C95C3AFE56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552A324B1B;
	Fri, 12 Sep 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZypKfUU"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EB322DC5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689849; cv=none; b=q2K9PkoyEovMPlorAgSc+seIBhGp8I6rG9OCOXW+i5tEV/hAxPzzU6xhKMdWDvLfMwlxcAGmFBK6yvot2sMFW40Esb9+0dbvKujEaWFeT+5l64b1/bwCV5MDeAVTb0I6iUmt4Hs2r1vLoB1iLPoOngZKRafpDdYloG7daV9m3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689849; c=relaxed/simple;
	bh=/BXmkvpKDtyn0qN8V/YK7rPLmRpgpvD9OPV5hibBmzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qddOCHcvaH6kZEN0SNvSbwqsL3BY391LMLQYfZqv84Jc327T21CSkyhRIu/lRGc9zVc0CdAP7BO4dS+5GIK3GUn4MsktlwQmYoc2dwBXRHytS1QGUUa3NBK0xz4rFTOMHjlwbyOHExHkajPAJb+5jOzokISfCM1rsoJv9SrOReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZypKfUU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-723960ded6bso13973337b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689847; x=1758294647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvjoC9HrZ6XyeC1MmkaG/lWnbuRS5G1sVQIYvweJDZo=;
        b=YZypKfUUilMWvSOC5tKJEyTgzwdJPYqeNXJf9FaJuF+EXB5614ExOqocoFR2zokgth
         z3v+NG9SaCReUJAEdIU5jm6VnckPGRDxYmiM9LwJagc7Bpa5LgpuBr7qnGwepz712IiT
         mH8TKsy2EmsmpRajtRjKlT/mJCeGbYpwZvepubkvev3TsBNjKxOSdSFlSd1w6aEuZ8Vu
         GsoRgc6QC8knFhDDZrEYduQSljdhI9SK3vYc/giECpsxh7v/aR20rIV4kGmo+TLP4xsp
         laTJy7nJ6KfD276gyuuXGUDUPP7scjNJRSCam+HDlAUrGAz0C9rIOBc0q2Ixh1snPk6r
         Avzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689847; x=1758294647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvjoC9HrZ6XyeC1MmkaG/lWnbuRS5G1sVQIYvweJDZo=;
        b=fS8Y890HXVL3f+Uar5s83thSJ5o+G9pUaROXvwFyq3slyEfkCH33Qx5PAZYmXbDgR7
         K4AMAuA5XO1MfH5ctBlF41H4Rr8WBjn8gM4W5mrMO6Fz2YP8gKJAEoAo9Mf4x46/T4J5
         Z1OrVfZ+ImS9yyCAEjG09MqOgEHDZBllIvH7F6g8nJY7kd5bIT/PWIhXC8qjMs9qsgkW
         TxJdpl1OaVGwaWKxdbZ5AYz0x/8jbk7m2VhbghcThzq+ySj3gSGyzu1idft/SoCzfipB
         sZV1b/GZfzu/SBP1XUBRIPvjSn5S/sgxX5wLY1WjdAKb8IZvyOVLoeXIdYF8qTjGnLjM
         MVQg==
X-Forwarded-Encrypted: i=1; AJvYcCUXTZTCZj0K9QPjnCgVExnbY0YxHK9/c9ZlgHQXuXDIbJ2Nf+22RwpxEO83qfK4OI8XjIWDwWiaOXl/XEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUIBUYDRGLRnRE14LaRW1Udb1Hnr0KV5wCtOX1fwLoLwB0X2M
	l2TlW6RTi1VAn9Ec/FHm/WCVh/J9WldRpDIAL2B9OUWLWxWl+uZ9rFaX/O0H1A75jOI=
X-Gm-Gg: ASbGncvkFUWTtGsL06XQrlSqTbrrYYNukRTCqVYprz5ZE8+KNMonIKnWFS1H/D2BsGm
	V5IhELmtPfxkQQsLqxcwYJ5iUso+Q71iecPCFevRkRbq2Ueyht/dN/uWMBblmrP9vK1+8fL9Hex
	NK+D/+P+aYPhIezaMwRS1+Jzossw+wUHQtNifJ/vqu4AzdU2Sp+0bv1tDTgHYldZuEZyx0m0aov
	Y8WhwyNtxY730dcAy9ZHTKq6Y+U0S7SjPrkcSJYjVJtRa6c7bSJ7QsKZLDU0CqlcIFOJohTK7RC
	D6j8Fkags0WUeuTmy1StEt12KmziQBVqS4POn7lcwdry+mQsQJLBuzGGdy+qsjzt3IirkM2rDv9
	p1HYpkRj/a8R447VSAehl+H+l1d/iv2Uq4w==
X-Google-Smtp-Source: AGHT+IG0Y2LxTvBY/AtHJvp89fVFaBOgxCKmySrObEvM5zSsJDKwSvyDpIHnZ+Ay7rKBasM7LP2xug==
X-Received: by 2002:a05:690c:768a:b0:731:1bc7:7830 with SMTP id 00721157ae682-7311bc77c1fmr16987957b3.23.1757689847322;
        Fri, 12 Sep 2025 08:10:47 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:47 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 11/16] mm/swapfile: Have nr_swapfiles as non-static
Date: Fri, 12 Sep 2025 18:08:50 +0300
Message-ID: <20250912150855.2901211-12-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_swapfiles is required for debugging the kernel, and needs to be
accessible for kmemdump into vmcoreinfo.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a7ffabbe65ef..2ef51da2c642 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -63,7 +63,7 @@ static struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
 static inline void unlock_cluster(struct swap_cluster_info *ci);
 
 static DEFINE_SPINLOCK(swap_lock);
-static unsigned int nr_swapfiles;
+unsigned int nr_swapfiles;
 atomic_long_t nr_swap_pages;
 /*
  * Some modules use swappable objects and may try to swap them out under
-- 
2.43.0


