Return-Path: <linux-kernel+bounces-854799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB25BDF6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7241896A62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC604303A11;
	Wed, 15 Oct 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih5k1QUB"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5834274FD0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542654; cv=none; b=cj0LKYhdca3D8bdvqvwFFiddsyk3M8BqMyvic2CSzVRbNfNR249EpR+sYKNmo8mCgfaAdrJLR2WhffMtI+nT7uRoFUB4HbfUXe8+4ClYX5VsJw/8g9sElZUqb7mmQUErsULIzL9wbKZi030qQMRPakyKjON/l1DnJ2xLqpRXlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542654; c=relaxed/simple;
	bh=aLlRdlh9FDUPd1JAE8xBaQc227ypKkHoxuDPxDr9ql4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iUDZv7sZVovhX+2RucsBtpqRdK4IGEnR6zEASeLIhQ6O57tJzsEsyQhvb9XdhP0RlHPmR0yM6e/XaLi+cxunqTTDkkiGkmqTtc/CInUugMuT5XmNmG5h+t9QeZzM/7p2neq0vDBIZSzjw4lglkc5HpQ0w7RaPeiTpAO28cCLqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih5k1QUB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-271d1305ad7so105629815ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760542652; x=1761147452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hn9avPxUFptKtiboarOpoGxvc9w+QcujEJ396q5eQtA=;
        b=ih5k1QUBkcqYqtgLFsRSYm3xAcltkjkYyVMNP4riod5hCzyKwFgHs3ayC2N4KQL2I7
         f9z1tj1nZo9u4pX6oaLc4boLXSyhEmk41nXZoFwhV3kwKJql5mEcCjUEyFttpDsynXiE
         NaEi3XE4DEh1Bn7hDDIyU0CuT2dHG/OPtFLA37YaeLYYz9AdnsS63loP22lczp1zrEnr
         zuTZFQ4WV4xBrb+zVX1Wekl7M58ohkFRLdUmxfQ/JXOVUB7iMzlE/kSsR4F5Ua/pBeLt
         A8Nos01jXzbN1i0whfYYcuGk4ohs3lvQB/+QNhhhD+65On/SU6rrs3UXAWHI/xaDAhjw
         Tn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760542652; x=1761147452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hn9avPxUFptKtiboarOpoGxvc9w+QcujEJ396q5eQtA=;
        b=k8Dl+KrSKGBPdF3vf/xJZG4uNbt+AuPBU67725pxU67Mx4lc7MXfV/lySwW+k+7bOU
         9G7wrozbmqhjISWRyWJQWYnzMzbdVsKDZc4t5kLjV5J4zoDWJQYuu9/bFqoVtL/3bDkJ
         V3rAwkzqpN/NpQMitxYtqR9kVFXell+O7Z2f/Jx10nDg8DfvcP1sMiYx8W0NvrguLtNw
         WJVbTAcdzNdb8nVH+iMIwko0upz4PXL9vfef/tOCIuYGWJ+q1bGrHIJ0+BsUbfQnGcwq
         +9fx4IeW8D/WWRc5wI4rLCAt75UzcyMDuDUqYdj4QmGmske1N9kp+WG7rOgZj0/FYN7A
         HdCA==
X-Forwarded-Encrypted: i=1; AJvYcCWPOTkxEYVQk7tedGvJD0KL2xueTw0AU9sYL2/dfvCYRRBju0VRLikHj3347bOwiWO9B4WHcJJ0z4/ShnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4ytGarU1BaEi3rauHBrVoPuZf3zbMIJ2PYMju3pZjMYVHcNr
	FlzND8Iy3TMH9UERoXLFRxHRgB4VSi7S+/lyRg6og0qeme88JDlaydyIJ1BFrPHOfSA=
X-Gm-Gg: ASbGncs62oVZvzf4+MsV48DVGSyNzOGa0krNPhJ0jFo4lb/Hg+51X0a3rYr4FjvY3ka
	xlUjMLIHO3Pz9oHc73se29hfvF2XttycvIHCfGcU7wgv2IIKUiehGifssErmFIvRkVef6+dVnGi
	wj44t21rRkq3Koi5FAMTdcZQaOFfWL2hKd0a5YDW50UiNOe7DSW/RUFcit5k0K3hlEOlzjNQghA
	0Uw6xWuA8N++ghYIbH00gJxwDYgNWg8duqnA/3ohwXSupkChnNV6jY20ntmvm56JrX7m/JEaH0e
	OWonocErV8zsL+s9+2xBIJMiQ9264lbLTvE6Ukph5c572QLXX02DApjUsaIvxsN8LZh+BED/cEt
	WXqu11pTTt3JYg17pLvQyZvoYxcGhVKx/SjbQxS0h3mx8hDiWeZ7XiQr4Xhk=
X-Google-Smtp-Source: AGHT+IH+yHJj6xUqrD/D2julKj+3TgI0zyx5td0Q6jzoMKQ8APWTNss3bNdH/1RhbmHAbB5CH048bg==
X-Received: by 2002:a17:903:3c66:b0:282:eea8:764d with SMTP id d9443c01a7336-290273ecb72mr398634825ad.35.1760542651777;
        Wed, 15 Oct 2025 08:37:31 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f87b23sm201655935ad.113.2025.10.15.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:37:31 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: kimseer.paller@analog.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] htmldocs: Documentation/hwmon/max17616.rst:4: WARNING: Title underline too short.
Date: Wed, 15 Oct 2025 15:35:27 +0000
Message-Id: <20251015153527.1646111-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following warning encountered when running `make htmldocs`:

  Documentation/hwmon/max17616.rst:4: WARNING: Title underline too short.

The underline below "Kernel driver max17616" was shorter than the title
text, violating reStructuredText formatting rules. Extended the underline
to match the title length.

Fixes: 1fdbb3ff1233 ("Add linux-next specific files for 20251015")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 Documentation/hwmon/max17616.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max17616.rst b/Documentation/hwmon/max17616.rst
index 936447159f87..a3dc429048ae 100644
--- a/Documentation/hwmon/max17616.rst
+++ b/Documentation/hwmon/max17616.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 Kernel driver max17616
-====================
+======================
 
 Supported chips:
 
-- 
2.34.1


