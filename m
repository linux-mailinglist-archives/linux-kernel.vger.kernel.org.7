Return-Path: <linux-kernel+bounces-736323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A96B09B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA747BC8FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163681FBEB0;
	Fri, 18 Jul 2025 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQlDcrd3"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BEF19E97C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820706; cv=none; b=J8wvEbt4NPR/BC+ggXU8tKyoavYaVWZFx40LnXQrZ8EaSI8V1kEDN/heY8CdE6RbUvy++lCVx7tSgq/78+XLjZSkTBMb6OwdkW9MybL0uH/jxu7egs698lMnzwyD6AWkNW8hFYTel8SglkrgcyFzfbGIxPJAdHI5RfCl+USUn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820706; c=relaxed/simple;
	bh=75PHuRvJ7DY/suTDA5uC8Ijj5Mt9JPobnVNsKDAVtMI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oUz6Oo6rMrUAkFn8Tp3zQiBK4X6QIjDRUDMA/Or67f5ALj4u6/6yHqb/CC+LUscqpP4cMvWRZg69Mz2WH+WYk/hfh6lG+zLtNM7noTmviqY2UcE3JkWP0D93lWnsvMkFW57cuUH5IG0rFvj4cupZX+PVEEzPIk+9z9taXvDfUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQlDcrd3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74931666cbcso1618173b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752820704; x=1753425504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwdSPh4JvmFHd+Iv/wF6gcUfSJNt2xnQHwuiHcjJGJA=;
        b=AQlDcrd3iC3eb3ANJgzSrOf23mLpGU26pfP0DylB6ZTE4DMGCgVKmzdEgsnh2Tgmqc
         8XnLaaKt771xe1DbRMn2W41w0N2CFi4s+ZeDJH5QQuz+1T8Xp2YkWuJk2zyF0sOPe+aJ
         HmA38zHIIvH37B0Gf9rAn2kCB5hphYcEfF/FoYg7EAkRphaWZPZFtK7cZjsbGEI/6loc
         m2xpn8W6Uwi/ByqB7EYBvYHo3fwXhBHUYSaofbRNsmkDuQIuVVca0fIaicWiVmG1t8f4
         VhG3gtnRohE2VRWGVObNsQGsMBhgR9OpyPxr12ngeFhSsDpwOd3DUk5/21FmkDAdtCkA
         mEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752820704; x=1753425504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwdSPh4JvmFHd+Iv/wF6gcUfSJNt2xnQHwuiHcjJGJA=;
        b=n5l9YxiIJxXO3q3FGJXYBzbx/U1UT42tXhLQtnsf3qVmh9+5KkLGOpG0TlD1Funn/f
         bPcZQmDLqDHkRUlOYNhEU2xqXGdDERsafXAwRSL75mi+4MoFlFbIW+AsL8xPr3VB5xxJ
         7hYSGXaIYbD2Dz5VpGRLIJU2Pdo9aGIBzew1w0KW0F2s9EZVEPOoYRZldzvcBFlJll1l
         Te4nAaa314lAer6eneCs/Y7eOLaL+NO3CHo/mTa0vGIF8jTX//6NRTSH2UnVl33VT/NS
         KYioi8TNwvII3v2txDGzGZhsOfumrITgPMFXJyEXzqZmkFYzJdAlHzWsDFQ0J1vrmyho
         3skw==
X-Forwarded-Encrypted: i=1; AJvYcCWBaNS9V0U4MV7BIuCuBw32cQduiIlhF4dnHSvCVz2pC+GEVSY/GMCOJXZqyPVBV21fqz7EYLKOoNssPNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5dSDSGvM8QQgoDkyYBwrHC5YdLEu5iJs4dhcnsVkm3sstN/s
	/bz3APERH5joGBTNP0EdgOzXXmdXzlBXHZksxn5HDTZL9FUQk6XPFJKz
X-Gm-Gg: ASbGncvO0/fVRRTt57ACB8uG8TSVAxhiFiiisAj2v4tA+dDynG0pk7Hr2JqcK6wn8IA
	hfGElgoflopOA2qRGOyVvclUUmNdSi284+O7Z6oXRfluJX1eMUIl/MWA4YFBM00NxgLaXPi1VSi
	wmgO5INjsUb+ZPypGy7OGonevi2Ymwh5pGsYEnS/rfkRfSiuOHTHVOnOiJV5U4wIMikE5msTutb
	7/O0P4odEdy5lUz6B5t6S1ph10tC5uPw9Pw3TEqyJMLenSeHk3C+cbIwVxMKWH2KtsH+xorAgIQ
	JHP22rEKEky33lMvA+zHkoRiuBjptwPgE9RvprQDjgkoueNfKCuYwshU6TTlKFYdm2YxLfE/94u
	38XkKF0MJ2EJhZl6etCduy2fSBwEFfy4hdK3qYW2XDUrUDQWBQTWKtjpG
X-Google-Smtp-Source: AGHT+IEZ1zQnWI3otwhr8y5LlqoEUCJegDnSK/x/zcL8x+MwvxlKyS+ojAWhWHoDTHssrGqPUTARzQ==
X-Received: by 2002:a05:6a21:1709:b0:1f5:79c4:5da6 with SMTP id adf61e73a8af0-2390da529b1mr9223362637.5.1752820704230;
        Thu, 17 Jul 2025 23:38:24 -0700 (PDT)
Received: from localhost (212.18.125.34.bc.googleusercontent.com. [34.125.18.212])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759cb155d77sm576969b3a.78.2025.07.17.23.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:38:23 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] panthor: print task pid and comm on gpu errors
Date: Thu, 17 Jul 2025 23:38:13 -0700
Message-ID: <20250718063816.1452123-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series saves task pid and comm in panthor_group and prints task pid and
comm on gpu errors.

v3: fix new kerneldoc warnings
v2: save the task info in panthor_group on panthor_group_create, rather than
    in panthor_file on panthor_open, because, when the two differ, we are more
    interested in the task that created the group.

Chia-I Wu (3):
  panthor: set owner field for driver fops
  panthor: save task pid and comm in panthor_group
  panthor: dump task pid and comm on gpu errors

 drivers/gpu/drm/panthor/panthor_drv.c   | 14 ++------
 drivers/gpu/drm/panthor/panthor_sched.c | 43 ++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 16 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


