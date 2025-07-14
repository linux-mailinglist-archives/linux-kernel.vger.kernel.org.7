Return-Path: <linux-kernel+bounces-730128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D118DB04081
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80473AD2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9122325394C;
	Mon, 14 Jul 2025 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs9++FUC"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA1253F2C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500789; cv=none; b=vAinWwnLvSkwan4EMj7GH/B59XFoFkI/qUZJou+zLElYYHTohQ8zeaotlALlSRCmjfCGHLnZddw+vM0t++5WLmsWDNnQg1/DT8hDibR8EhvcXrg1kplIHRa7apThGDe45jdD38I3ulmjYQ2httRQLLwC+DR5DVlyaFu8L4B1oUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500789; c=relaxed/simple;
	bh=UWzSca5u9tiBU+W9UUwhaW3+bszaRw65dQ+DZ4fHHbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjemwTyx7yXrzM8RSHOUAXBno6DD3mACczj1p6hlpcbahOA3aLCH6hi/mZIz3ynojpWKb+GDIn+DejKkjFkP11yXihWfgib/a7NzsT/ancvnFAcB2i/MNPcPck8vmXa/O/Z8RiQYtDDvqZy8rOWxms9DD+qQN824w+/ygoohuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs9++FUC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-708d90aa8f9so37769747b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752500785; x=1753105585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r6Hbz92/x9FL+FBlPeBNmgTh+QKbNYeF+ROETx2CnRA=;
        b=Qs9++FUCv0e6vB/MAgMnw4bL1np486iY+fYuSlfDNdtnKgiRo2SqudikjWl5HfnNGM
         6X8kdN5O7XmealFzEtgxEpEHJKjMZI52XnRQBIJmHVDOoCZL+dREYLl2vJVGiZnfjKqT
         MTeLo+0CdAlTRIAqN6+cfzwT4jjaGEcnI7DxXc0rNdcuxa3BkUjYGGlyigkbdw6vrfVH
         gjQxtbAoA8bXuuU5yAbrjghtDCt6AOdQWy4BdPggJltpFDtgtDNdXCI2ZrKr0JIr+kvd
         6klmMOH56ombYpf+8dhw5qocOzrjdcExNxld3+XTkNvMlUv7K9birCaS+QBSh5bW/bus
         8KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500785; x=1753105585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6Hbz92/x9FL+FBlPeBNmgTh+QKbNYeF+ROETx2CnRA=;
        b=oiSvF/3FpzI9+DD3IYTFFGsxJnGFEg1QOJ7Y7jPFOeFzQpK0Ul3UkH55y4SuJMWvy2
         LU2NdznlEMHpMUhDZH/eRSKyLrt7KaSdCBxmLH5B84LPebgPTXTrotuLS8TSnMVW6UeT
         HYLLOg/xKggowe3wpdNc1duc/XhnCpOdpWLWrL3EIPk35m1mDYQUXut0cxzMaddFPtSl
         H6O+VernFSEWPgCecn2Xk5TbZColZBaGl1r//7T8FTEyzh2nqA1m/KF6PRg8XurRwv5K
         cDcYJdgMtsZdedOzzZL8YGn6quoTHWFpVr2xoafyhsCqMl9+l2L+eb39MzDM42IXIMDY
         5RAg==
X-Forwarded-Encrypted: i=1; AJvYcCUbJbYnWnS2xn392ZD61SVRo5g64uyqju9TGX0RNgr3zpqRd+T3NyIFcl+vKqfPyN4A55/lH6l0yC0wwzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8BfoDtbmwdztZwGZZEVa/5kKekQ5CrivLNuj6lJLISvRYvJC5
	1YjRc2jo3OmRF1VL2je7Rw6e+2euo/rIz0j70mMtaVxGd0Uzq6+Azx/j
X-Gm-Gg: ASbGncuixeI0gKq/bep4WUm9Xc9fzqLCDFnO8oj57zDYOA9Ff0mzyioXboRfFsaneQI
	cN/Sd6LJHlwU6+Zl7yiusZOkBaYInKWav8WHq1cCtBdFc+Q7d/cKXCwJQ25stTA7o4z1oReeTBp
	sBXw8KZ2Ixz0QBGUlFGq6lnFJXeuY26lp2g8ctn9SojVVkI9zDRt9nUTLy7w2qVybYX/VRVT2Lc
	7apbUh1HUyXNJhF0ikr4ybKvHRxr+FEAJIBe9n5COiS+nK/TUWNs9y6qk18ngRT3GooDSLkqsZi
	sll8elK8DL6o4nboXyohCB138jPV+jZKA7qmgwOy3LUosetRRjOTiADU2nBxDveFlOEbqox8ez3
	rnyb7lfoCtzxG4o+MDFpcR9cghfvyot+N+56BtmSo+ZF5kUN1yAs=
X-Google-Smtp-Source: AGHT+IEjFQnYc3dX2wC/TJw+1x2lmoR80MZ9iengzJu2U4aQJIm7eVy+DcNW7hsQ+5G1kVVNvKQ+2A==
X-Received: by 2002:a05:690c:c09:b0:716:69e0:bb85 with SMTP id 00721157ae682-717d5dab701mr219868997b3.18.1752500785259;
        Mon, 14 Jul 2025 06:46:25 -0700 (PDT)
Received: from elitebook.4.local ([2a00:5881:3041:2700:8626:7146:3329:ad67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d891fesm19722487b3.52.2025.07.14.06.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:46:24 -0700 (PDT)
From: Andrei Zeucianu <benjaminpotron@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com,
	Andrei Zeucianu <benjaminpotron@gmail.com>
Subject: [PATCH] staging: rtl8723bs: hal: remove blank line before close brace
Date: Mon, 14 Jul 2025 15:46:11 +0200
Message-ID: <20250714134611.119442-1-benjaminpotron@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch error "CHECK: Blank lines aren't necessary
before a close brace '}' in odm_DIG.c:374.

Signed-off-by: Andrei Zeucianu <benjaminpotron@gmail.com>

---

Hi, this is my first commit/patch in the Linux kernel, I would
appreciate any feedback! Thanks!
---
 drivers/staging/rtl8723bs/hal/odm_DIG.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index 1e2946a23beb..f10427abd849 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -370,7 +370,6 @@ void odm_DIGInit(void *pDM_VOID)
 
 	pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
 	pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
-
 }
 
 
-- 
2.47.2


