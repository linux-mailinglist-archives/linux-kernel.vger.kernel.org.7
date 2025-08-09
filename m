Return-Path: <linux-kernel+bounces-761096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D916AB1F453
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6013A951B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED42272E7F;
	Sat,  9 Aug 2025 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4bLd7Yg"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98E1F3FED
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754737941; cv=none; b=PG+ACMVvmrxo3H6uTFE7wGaP+aVAIxcu1/O7pQR8pxKErFc4AStouO+5+lhKtEqsUZWYjFdL+C+sNJYA7vfvhFaq08D/tn2+ShV1wT/L2TRKw85kkzDRv8GUiwQGEczsiVlPtD2mYYjLACBR09KnbI/r5gOgSOx639Z6nUOujms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754737941; c=relaxed/simple;
	bh=gN1MIuTnzSQMDEWF2dpOhcvXN5nDzF24d+3PpF3VceM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDXAIscmJsTo/aCoLkP2BlcoqyNPQqqWdgSjpUGrnr4MycocT/kK1CCAU11r0y5PoBxSQquuNAPYGVOwmPGq0GHAGCiQLawCF5IPvAMpstng0BOSv/K5sodgdcp2Ww/CdwVkYW0YM3jGVj9lywevZnBMGw+af6TVlT1BVAUzrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4bLd7Yg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so18362675e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754737938; x=1755342738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNqr2noYtj5/iKHD8yrAFo9MADN3PbbGdwwaImthjec=;
        b=W4bLd7YgXv70c8AV5LkGDe+DIhKcE6tSJsV3CGO5BzMyykt2xmT8qounciAKc62nIi
         napWneiW4qSncKJVBdeGxLPBx1eXFxCtyUyW55fCfpNO46gMkD8pvjwIw1nCxz93L31U
         nSPxfQpO5sb7qNxpPIk4ih4nQM+ubgNpC85O5PBWHH7lpxqGTJ/HVlijFvn82uprFUy7
         16SuslesJogdbPB+N7WH+Huy3nY0X/6N42Go4HxRdr0o6Jva+Un6I/LQTYPEihQVD9FJ
         2gT4hmh1tZPgCTGtQdjHG6RLocf9G0o5XqkAftnS5RL5gt9ycPGKjFNWog5iYZeCKoX0
         ci1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754737938; x=1755342738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNqr2noYtj5/iKHD8yrAFo9MADN3PbbGdwwaImthjec=;
        b=vxOJ/19fE17MlNSDB/4EPGb4FTNr9T3NrGfFaK72Yt0byVVpYTwagECqCzA+mmzPbT
         X2URy9vvduz0nb/+xH1m3O0h3BzKCallO3fYZU4nX3KeUQJ9nxLnUqc5300ZSyqH0ZoD
         Bt5kay2IAJqVrfi6PJAAC68NR97coBmieuleaQgb9D+90QLtaNIpcoN8ZyO50WaIXlKX
         j/7M282mYv9DEbixXG5jCcBjcTii7AVamSS72bnGMrLivxN7FDYtKyrxnXiGiyt0ZV6+
         tW5YO4L7qNrM15kS5p/4YXqGTkvi6fzOy/ehFcyyxM1Ogr+MZ4hWk7SmYGWWoR7s/wKQ
         590g==
X-Forwarded-Encrypted: i=1; AJvYcCWs+nY8ieBWdHD76a1pM/l63AWPXRaRsRJPdKFds23xeSYg5XUsJUE0h7i6nThqJ/XnoBBa0bauEEp9UDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6BK7diH90OqWFcJFJDO+SCy2IGwn2vDtnDL/h2qQ0/BT3Km9
	tASQXZ1loV5Je5E6spZ4oCCkeCypa/mpmqwS7frUIefj3sx3gAIXVs7b
X-Gm-Gg: ASbGncu36kKTq8apR0SRc/+NdLJoP7hL8+Dp7q76sbB2e6IzIUyt5MbYV6INwf+8uRM
	tEZCxGEOKecitMTHFo4VZpyKDiahmQ0TEIsik/SOCxa07fN17J98UOdTgl7qeldHMDyLBoAhnai
	5BOal53cHu72Cos7lYfjRyPaEPBWvmbLlG0L1r5u+y14z37xNcMnzNHi73amIFFNwRroR0ypc8V
	wFW7UaypxifeL6EUKNG5EklSrkUpbUNqAYp4PUnA4WUKuTC2/UIwHIPAA3FPhQDHE3hvX9tzV4K
	vURrS54ByhS5c/lbXFvbkx5Omo/Wx4gFI7FbUqTAnLg6zmBPCfK1L3/cxhzUFxnUEDGQBk+e98w
	2gbrwKQC/nvfpb8gkWHYnlRhYfuCEM391UpKB8wc=
X-Google-Smtp-Source: AGHT+IGmd1/DibPEbs3Ynld1GabCFw3/aExk+KV6VBw1GEk4585Fs9anirjuYo29usAS7EZvYyVlOw==
X-Received: by 2002:a05:600c:45cc:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-459f4f2e6d7mr49925915e9.1.1754737937597;
        Sat, 09 Aug 2025 04:12:17 -0700 (PDT)
Received: from burak-MiniBook-X.. ([2a00:8a60:e00e:10f7:a1c7:d533:5228:9a11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc2647f6sm122340435e9.2.2025.08.09.04.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 04:12:17 -0700 (PDT)
From: Ibrahim Burak Yorulmaz <iburaky.dev@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	hdegoede@redhat.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ibrahim Burak Yorulmaz <iburaky.dev@gmail.com>
Subject: [PATCH v2] drm: panel-orientation-quirks: Add Chuwi MiniBook X quirk
Date: Sat,  9 Aug 2025 13:12:00 +0200
Message-ID: <20250809111200.10086-1-iburaky.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Changed subject prefix to drm: panel-orientation-quirks

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


