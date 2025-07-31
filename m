Return-Path: <linux-kernel+bounces-751552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5157B16AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9672B6242D0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F023B619;
	Thu, 31 Jul 2025 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="PeG5+NLr"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191A2397B0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753932232; cv=none; b=jW8CvkgBcbYZbgrZ8yBkTp4PvIoaj3xN+EgQ/GZmqrs3HIXN0QLjvOyIGzy3molOC6uvpkGdY58IgaYRRIs9IEI/pFuSvO1zBZXeAd9FqMZqpaAnDpCPNpZoAo9yc8Uo2hJO7IufmaSUw9+btEvMe6Ma9oxR6LKGr2lhSEeWAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753932232; c=relaxed/simple;
	bh=XxMNf+s+au9pzXX5Y2tRQ2TxicTyQrqJ3gGr+HCCcZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWfh1Ykt/pxoXvOuK9GHl6mZN2jswvnVImO86HtTcuxxcIEThwakq43OK14juVOrRpmN16N53+fhzEeQi+Zm7ff3+zapxSO2DnSelSf6H167bFeb/x0g3i2AdXGjE78nXOp6w12clJOSYl7e60C8+oZ9k/mX1Vcx8IgwdFMlyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=PeG5+NLr; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b390136ed88so358599a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753932231; x=1754537031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98acdjAVPrJS4Gqdzmu/lk9sXTEBspyDUAMw8EWioqY=;
        b=PeG5+NLrnizXuc8avN2RiqcC5fdBEvaPXzEW2gAxelQIsvUe1TW4Yqw24DYQ5rhgZY
         Hn+Tkb/j9ZToEDf7LGr5SXyk2KQFb+gqVrVITMf9svoLborKXglcGBzKDjjYoWMWK401
         DSfCTTWDhdrzsUuflNKXEXx3dEdpSAX5RPgtM+0CIk+aEgFolQK868gLDo+zrQNGYNjV
         N4HlKkj8kQCDNM9pcGuifS/FRBBVhBDH19BOxerD9SrQ2VAIYJqb3BjrVOA1TRJTzvyr
         YgwSC7p1hPnl68GXVQee0d6QvUokp8miPA4SDR1d/jTpNEF0UzVIGdwHaJHHJVLAOlhX
         UXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753932231; x=1754537031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98acdjAVPrJS4Gqdzmu/lk9sXTEBspyDUAMw8EWioqY=;
        b=HTRVy2Nzu2j16akQIkA8BwJ+4MNPJ7XJilrzLiANUKcjnHfJaWPqhBClDSP0CXETrI
         sYPuR9R05ulx2hLXtfmaCwq0pZASR8YxilWggBScyjhDJOiIGxL/p69VSSQrqaiUbBEN
         +J/K+ClShHDbFViS/UeHXpKkzHW/1aMLo/bYh/69oehg1BgoB17xFX5R3hGzTLahp3yF
         IwG5u3bXRWKVloQMNhdHNrZXAPmP+jozu7DTWoDWvZ9TaxVw/N+yVTbcOXf0w3eGvrpm
         FLEu1gM6zHwa1QEXEb6BUyl4M67rokcum/idT4ssZLi/vQHL91CxihBFdVAc1oHrpeva
         IddQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+FnMA8ErSnfRy2kYvOthFOk6MvuFhPVYXWm3Yvc0iOQEpy3EYqwZSv8YNEqzzaNRiiVkPiXH7TuFpq2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYu88LvjEwrcdNTOS9lDRf6rZzwmUOzhgfYc8OnAd+esxJ59n
	3wu4YamEa6yn5Qffqf2yk8DZJnbUnCPljy6h1F/qajsOk/tNmDeLbwbifAuYEGqQEig=
X-Gm-Gg: ASbGncvnxoh+5Nc3PCSCmkwFyH0pVm+PXzjWdDFIwi0KXIojdSr8c8O0BOBV/uqM2g0
	WHP6g/i9WqReKvR83Jj3i3pYaOUd23a23LdV1e0T39oqKNQn1BA17cB1NnZWaPlt2U622o54p+z
	VET0Z7L7Gp1f0dUYzWTExfRAuwuM5jMAn9NqKQaBDdO+7+oO/5GjrkHr7DXs+8sYs88AhNHRSoI
	TT6gMIGIfY65m46SvQSbFSakbPtKnBSHxdcQEsS2a5TZOhL/ndBfXjf2gh2gNXgmQV22Jb3wBYI
	EDOkHVvctTZ2b6hFvu4k/VegH1u1oIbm+IVyAzIilyMbBn0PHOsFrnMzSlzsqzu9J+CtCf+4jWA
	o70+UkLNkkMqHsTs1Gf76YQb5RALIKDQG3dm+3ZfaT7HCe8T0lg==
X-Google-Smtp-Source: AGHT+IG7cxswJdJ/7tpMHzX/PLpF1znLcf9i4exYcEFax9LRUgDC4Zu20SehYungolPEBKBedQbYCA==
X-Received: by 2002:a17:903:1aee:b0:23f:d861:bd4b with SMTP id d9443c01a7336-24096a63f17mr93878045ad.5.1753932230738;
        Wed, 30 Jul 2025 20:23:50 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f15092sm4854795ad.66.2025.07.30.20.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:23:50 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linus.walleij@linaro.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	sam@ravnborg.org
Cc: dianders@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v4 1/3] drm/panel: novatek-nt35560: Fix invalid return value
Date: Wed, 30 Jul 2025 21:23:41 -0600
Message-ID: <20250731032343.1258366-2-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731032343.1258366-1-me@brighamcampbell.com>
References: <20250731032343.1258366-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bug in nt35560_set_brightness() which causes the function to
erroneously report an error. mipi_dsi_dcs_write() returns either a
negative value when an error occurred or a positive number of bytes
written when no error occurred. The buggy code reports an error under
either condition.

Fixes: 8152c2bfd780 ("drm/panel: Add driver for Sony ACX424AKP panel")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35560.c b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
index 98f0782c8411..17898a29efe8 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35560.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
@@ -161,7 +161,7 @@ static int nt35560_set_brightness(struct backlight_device *bl)
 		par = 0x00;
 		ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
 					 &par, 1);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(nt->dev, "failed to disable display backlight (%d)\n", ret);
 			return ret;
 		}
-- 
2.50.1


