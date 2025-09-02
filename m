Return-Path: <linux-kernel+bounces-797233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3923B40DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F271B61D87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781B33128C8;
	Tue,  2 Sep 2025 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyyC2kLZ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3B33EB17
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840808; cv=none; b=IkopOBYvFDdtoZXoZNi/WvbPgE+kDyERYpngWIzgat6NvITYidMdBKRW0saMYRzWJdum2S+/iyTkt+LuskIcNvJSA1J/XGMKlGHIsKR28q8hB932Y+MwGok6WUC3GxgSiajBAkRsb/cjbElfxjOP2EWkOVmT2VWuka9Mb2lrdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840808; c=relaxed/simple;
	bh=6pZyzZHsYKZxl2sXOCFCxJglvK7bZM2znWDlWQs/tNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mE1oOL6wfhhyQKGoKIqBWsql0kkjSklmh5yVvtpKmMOzKTgv2L4K1MPT7kITq0w8lrwd+fLK0KBZkmdnJIsvqhTPq2FSmvKuCZcyt4LJIMdhXI6luik7lLHE63msQqQ/aG7DnIB5l2iBDjhl9krH6oJbIdWbMwL1LP4Ul/V/3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyyC2kLZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4c72e4f1b6so162259a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756840807; x=1757445607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqk5Vefs2rKeCe+6cqHNXCOBv4Tg9GxL1mkV6VFNW7I=;
        b=SyyC2kLZCMzy3yqMMKsBW1WrUJqZHAZr6dtQ4AEfyGCuyol5ThKbjLrVQNRlKnuQqo
         B0eeMWjLInwX25tlmGBNKOXGHbLREEN3RjK+XOzN3wJAILwPHQcf6h90/DUz5eo6YBYb
         tqtQMQuFusdSk2duEIE6jSicF7WqAyZCYub1Ivqiu5d/nmVBTgbwt+vA6IZk47DhBoDD
         4ui6wLV2o+EAa6PXgHVYCPpHSXzw76A3AGHooi7cjSAMNhqm1GGWuoEV/wpA5TlP5e9R
         3uBls3TZxCnVSbIHNB9tPXgPbuRPgI9UoppX+5ihovB/CAfmMwYJ0NMQcbIuOvhBW1Ia
         FROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756840807; x=1757445607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqk5Vefs2rKeCe+6cqHNXCOBv4Tg9GxL1mkV6VFNW7I=;
        b=nw1fDBDeOUJfKpBm71wDx3xOLKl3rrmXQrmyUKVlC0meBzFyzYrkiXPN9A/tLLwgQT
         mHYpFevNWiDccMSOso2/C/pxEZzdphr1hQHlQOKDz8k3kxyBAykHjInA0OyiRNVIEult
         wlo0Ab61qBG/pxwNRToJwaNnOFvv2eu0ygC0G9lc7keZ0F/ff/ASGHDnrYTnnZa8UrD4
         17pQVHH81Cah90USNlw711d3a2im7/Aoez6PgMlM/L2xJB5TLANcvLVzNq64EEK2tBSY
         K3l0tHtt7CtF6healR58UOTioq89tEGQo5Flltc3brRiJb3iYh9h2DNmAQrqqg+bnocf
         FpIg==
X-Forwarded-Encrypted: i=1; AJvYcCWNkzEvUgYsijiC1os9j/XzAI+zCmoer310hnIkvK+Rk0Be6o71+0pTTUP1WGCdVpfyCqdYSc2s+qj0X2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaazWnFyydJqMsbpe7DUlDMTnzJn7r3e/NaM3OYdVWU/iTmHXt
	+0rHKjuWGiUXyhyuHi1pyb/0vuhOHOngbC0vHtrXS29J3SXPD6AVw3+6
X-Gm-Gg: ASbGncu55d0x+tVfEjxqPXEk9NdrxgOPr5TWz3Vmv65T3v24IPr1hSCYgFZ0EO46XsW
	3jIQaMoJLz4U9khTN7sJW0a98XCg6ihbphxvMk05o5UgMC7kwxd+2vuU71AgBgP+trQKaZRmhI4
	HGX2FCZjFYnBlhLsw/S4Y7MgnW+PKTP9zPXyxR6q9U0SW3WtBRwFilHhBLKDITk53qy2qgwtg1Y
	O14QBYE6idrWTfMb+GAwcKqm+0ZslmnVpYtHXgOzhvqMLorZH2vya8hwSIl4jSp3GWHQn3+vOoI
	E1L6X61KV8saIc4CRJEa6ZVCMzjSeNGDQB2tfl85rR6ZfQbLE8z9aVIJ255d2ThZkvVfeF2LroQ
	WydI7QgyLjnBpXR69Q8P9kxhssp6FWkS0+T959LjV4tZIzJJxm/HVWu5p2FgJrFJnxtdja5QFdY
	PBmfjIC+O3UT+s2P0TXRKV
X-Google-Smtp-Source: AGHT+IHVRhUinMr0NXVSOtf58/Vog13sqczgF9BAwS+1PRiZbHywe42DldsFcFwUkyLLrJ/DQcf1Kg==
X-Received: by 2002:a17:902:d50c:b0:248:a642:eeeb with SMTP id d9443c01a7336-2493ef4dc88mr177979855ad.15.1756840806409;
        Tue, 02 Sep 2025 12:20:06 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2490359f808sm140966515ad.0.2025.09.02.12.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 12:20:06 -0700 (PDT)
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
Subject: [PATCH] drm/panthor: validate group queue count
Date: Tue,  2 Sep 2025 12:20:01 -0700
Message-ID: <20250902192001.409738-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A panthor group can have at most MAX_CS_PER_CSG panthor queues.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ba5dc3e443d9c..249ab889ca91f 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3473,6 +3473,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
 		return -EINVAL;
 
+	if (group_args->queues.count > MAX_CS_PER_CSG)
+		return -EINVAL;
+
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group)
 		return -ENOMEM;
-- 
2.51.0.338.gd7d06c2dae-goog


