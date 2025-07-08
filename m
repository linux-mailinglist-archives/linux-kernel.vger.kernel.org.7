Return-Path: <linux-kernel+bounces-720705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B99FDAFBF74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8841F1883DC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DF71C5486;
	Tue,  8 Jul 2025 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww5PToOV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A235963
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935685; cv=none; b=O8L9oTcdYKbKRtl7SeBkx5jEiLq0mCEnSv9JXt0MCjc7qF+kEeU153tOh0Jfd1VHJLvYbYm01gaJx6Rswdtn+D2tzNfpszKNQuUsPJIEfe2mj6ucjf4BptaST993As28a6kgkt1YCK2bQQk9VFn625OXQ0D8yzWe9ECqdc5yJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935685; c=relaxed/simple;
	bh=EIOFw1JpPec+M8E90FwZPh1tRqGI4xNcNqzDJ3XD0Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qn1OWMAHaPgDxpFbHc7uOjqDGb4EJUuKP4k0g8KUdpcG4LKXN7ItCHYJaAT5u6jiNMFSWL5Bf0Hd5ld3sMPj3WmUKEtgSgts+KPAjFKbDYnbnMP2CbF6ZBmR4w008HoFZ20iHpNPueRv6yjq8n+QzlAhtEWGmW+emmXwmj8kfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ww5PToOV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453647147c6so35326035e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935682; x=1752540482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSn52M56yjzHQIR5J828LB8d9xrk3LfotYJtBZIJgRI=;
        b=Ww5PToOVxaI0A3F/MZvqupZISfEXvc4eKpfGV+ZOOTomGThmZbbE/UbP3Ko9UN3VDb
         wmA3I9soyN2jHwAnI9D7ljxhdrTDIgcMMxCMOYzLGBMTUSaAa9EZzE2izQmSnt8TmstE
         25CUnUhUZxc4SdzFV/G77inVwDf4+6TL+oGCJfYDDPVuu77pUB0yc4dFuEBQ1ZtLJUV7
         HktyPCaYwxpFjxpXuVN4wg5qIlJ3hbipt0WHrSfRhFoIZlUlivL9a1I6ahCy9uNJCJjs
         g/xY8dnFBspsFAT68nwDWsyiQlH5yE2khUdDkzfxweSQLBTQQtXob/FUgW+TZXhqX8Wn
         L+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935682; x=1752540482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSn52M56yjzHQIR5J828LB8d9xrk3LfotYJtBZIJgRI=;
        b=luEaGF06ZSW4gRvNvu0FWeEpcnFz562MV7EGTRmWIKHU/bapbXmhpctWkAST1dfuE2
         h8yvLFxWRREU1mjlyJYE9bMs1eC8irT29YKucqRk8pvB2LeoXx4WT6vhhP4MDoppP+F/
         LVjmzEmeoB87LEOOyfBNSgtANQGUXWJbHJ8hYH0l8BCcZ1Hc1NxYI7XuLrXN0PndwSoe
         P2Vwn6vgN0Eool5bcpDYbNSweL54gO0bAzvYBrXmGoHzAmhp6cJzpT78ikuZ7E04edVC
         OpVLphgkkwHVRTIEvAUwM22JTZH49rUFn3zwnEbAQPy/aB6SKmEOBFiiTjFORwv2ZaFi
         AHBg==
X-Forwarded-Encrypted: i=1; AJvYcCWYBYqeSqP8QYEc7ScxC1h2qpyvjYshkp1oS5E1BejGLstou+aJsM0phzqHBpNC57ix/BTguxbRLGySL/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0d/L8JnPRZEwBJewNqPBlpv2iikl8WhqHjWgkaVDAmyL0MyTI
	HEIQQM/oH771jQJTu1vZywBJs63/NrgyS8ZTB6UvL8KzXubzLBFL1+1B
X-Gm-Gg: ASbGncsAd8kKY4y0KgXlwBma67L4Sl73+zBDE2E40Mo1LDNesoKwH1R7RSsRBdCjKuL
	ZtLaq0XMZNsS386WeqxsMZBNlEzas1i4yZgiiTjMsAj+J7XDedd14k5rM3qNSknQxb+5mAQFSGZ
	FC+h+4KvVBry7OR4tfb9vTW6dC3bGLuR0TE/ITWeLdswcj0BScE2q3Utz4guCF0kqJGZsTkEQ4a
	TGqNgGz9iIrYwhQFw5VFOoh80hOSElVszuMxKcF6SYW7C8ltqjeS+r7hAI/Y87O1EhFHu5y/etc
	8ozze6uSAFRJAadXdXwDRYkOn545/E30C98WdMYfoAGCOwDjjxYEOn1Ndx2xiNHN/aEPNu24CTh
	rVF8=
X-Google-Smtp-Source: AGHT+IGJ4dP8w5g6hpev8HIQOasgA+wtMF5Q7BTmSBjCSF661zBqxSTmgFB03VmUSIC5zOxHBrEonw==
X-Received: by 2002:a05:600c:3b26:b0:453:2433:1c5b with SMTP id 5b1f17b1804b1-454cd4baf8dmr6686095e9.5.1751935681656;
        Mon, 07 Jul 2025 17:48:01 -0700 (PDT)
Received: from burak-MiniBook-X.. ([2a00:8a60:e00e:10f7:92ef:ff1c:488e:a26e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b966cbsm11354484f8f.49.2025.07.07.17.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:48:01 -0700 (PDT)
From: Ibrahim Burak Yorulmaz <iburaky.dev@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ibrahim Burak Yorulmaz <iburaky.dev@gmail.com>
Subject: [PATCH] platform/x86: Add panel orientation quirk for Chuwi MiniBook X
Date: Tue,  8 Jul 2025 02:47:39 +0200
Message-ID: <20250708004739.9792-1-iburaky.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Chuwi MiniBook X (CWI558) uses a tablet screen which is oriented
incorrectly by default. This adds a DMI quirk to rotate the panel into
the correct orientation.

Signed-off-by: Ibrahim Burak Yorulmaz <iburaky.dev@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index c554ad8f246b..c85f63c42bbe 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -282,6 +282,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Hi10 pro tablet"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
+	}, {	/* Chuwi MiniBook X (CWI558) */
+		.matches = {
+		  DMI_MATCH(DMI_SYS_VENDOR, "CHUWI"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MiniBook X"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Dynabook K50 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),
-- 
2.43.0


