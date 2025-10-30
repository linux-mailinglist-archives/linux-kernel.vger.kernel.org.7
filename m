Return-Path: <linux-kernel+bounces-877772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCEEC1EFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A333B7E92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C75337BB4;
	Thu, 30 Oct 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwfK1cah"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B033436F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812914; cv=none; b=Pf5WyXpdthNt52ql+m6zCTsXUZCWHrdKXQOunZZa3M4MGy0tKVqaUKCrS8KXdPBiZtMyRwoMKb8i+UtYl/agNxZrCzkNN7i2LfJeanZdHHm2+u1CG0Utrkbd6SEzLu5NgzzNsll52peZ9EdeiVyCVxl/MbBEHlxJZ36WUNkQakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812914; c=relaxed/simple;
	bh=qWXWKO9UahqGtH7SLvJAco+7/04+WSzbSFogIfV1tXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bn1aXcCS90q4vU+ImlAlJzm9h9n8VJutjvNucRDaYe1DiHSsLdEuVC4jk0oioF0F0gpHmQwrItuCSuJkplNjq9wL+u7xMHp4VCIHD4sf9FkyjXjVjqrEoioFatq+sLMNlEnZLvcnPEXobNLzYXiGoeVhcbogeKoAOgo3T4YVxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gwfK1cah; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711b95226dso9434875e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761812910; x=1762417710; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mjv/mI5BFccldzshy5MSYEzFfXICyD4SC9MV3bSUtY=;
        b=gwfK1cahdwiReI6Pd8BOdcLHs+aBnDgUzBRe+eQmTsn5/LuDHJ5pITd1sL+sAjzt0J
         iuz0aqrbPxl9aR82Z7DYLO5KbhigG5WHYskn7iZofJofJ4fP+Ds4OJ6RnrxKQksd+UZx
         p3i0mS/9naI07iLWW5Ft6mULlQ0G0DmO3HOkSHJ1chakPWFZf1uuK/2Dc4RjOOYzoxuH
         TyJX63Z+AROaB+I4zUdVj2FP76PE0N9hqVmCrPfFFC8CG3midsCCtyf+bGtUzTISwu4C
         c1HkJYPiGJVpXqueBzgJ2zYBmBq1WMiwahvfgAzD1Y5pGz4F6LtWCJcDstX5mKtT23y/
         Q8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812910; x=1762417710;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Mjv/mI5BFccldzshy5MSYEzFfXICyD4SC9MV3bSUtY=;
        b=qy21XZos4+qwK6n9cvhfNfVzby1gLMv2KmYv4SXf/dPxDXD8XYq0Mdoi/bI5j+Gyur
         PAn9qBoyKYZcmMBnHK6LKB33yaCK06PGqqqasztfMhK7QaGysFrXW4Av8DvwgWefehwg
         SBjwIkuatSKfklRya9IKZzxtwp6LIQskmv6fCXsAIksxRGZUsbzae9h8/+wMjLlIJFN9
         YJJEWD5dR37G519A2rEIPM8UGCWf+ltJdSMIeL0TBg1U+qIHzZrmItN/Btng1TqM5o3a
         gZOENeszjkhtSSgzigZj205Q9XnreaeAzB+FY/CYQ+X915tfCwp8c3fv7AEbZd7kjbQF
         zmhA==
X-Forwarded-Encrypted: i=1; AJvYcCUhEN+cyj9o/Iksx33qid7QIg9nfpL1q8I+VwjNDWVXFL/apoAAMTQgvKktFoKoPWEM9mACymxmAqlv+hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSj7kg4xEUv8sEILs8/DqK4S0YnZiUxFo+GCWxt//3edSp4+0
	S1hDY5S9lEPllioOjIvfefIiSFLiMstBLiA90/5HX0ymMiIk1f8VWfi1C3wDXeuCJO8=
X-Gm-Gg: ASbGncs48pp5emIB89cQRL7r+yFeLiZApVk24LzJHIFDXUSgYB+6cgjDPCzVCjWD8jJ
	u6vzuGkXt9eFqkRZslnQ0RRvwikVkyFRydL3r28oqmemK6bC5o4CyJCMcwH37ukjTFxqqsCS9h9
	ZgAjCSq5cxrpPbRtEv2Yq1vYWiKDoQUkmMw737ZE2KWmE/yTvnYX0eHie3v780Zf2ec7dWHS+UV
	1QkBobKqUuB0fHHi/1eUdIXEo9J5VbMvKH+KT0C2kN5v1FrgxQzu6+/A8R8q5Doj8EPFRM97bFd
	VkYmS5S445rNGXHNeKT5ESElCXTTFgei5NsIW93e8SaBLLfX6UWwTp2E1exL7JaQ+HUGh6aglvl
	o5coyR4VlIgXWM2VvhAgXUA/xRCwSK5/mRnMgkZjWuWKrt2uLt+n50pHQMLjQ0PK6W/6VyQX/gd
	N/1hj9xKyAYYb+dD7BZkHT
X-Google-Smtp-Source: AGHT+IGczJn/fMEIsl/rHW5yoJK+KxbzxustnUgQyyE+F3jHyHlmTynOUlbxPX1LfVKi2syKVAQ/sw==
X-Received: by 2002:a05:600c:8418:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-4771e3f0015mr48851245e9.24.1761812910392;
        Thu, 30 Oct 2025 01:28:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728ab375asm27376475e9.17.2025.10.30.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:28:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 30 Oct 2025 09:28:28 +0100
Subject: [PATCH] drm/panel: synaptics-tddi: fix build error by missing
 regulator/consumer.h include
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-drm-fix-panel-synaptics-tddi-v1-1-206519d246e8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKshA2kC/x2NywqDMBAAf0X27EIeVrC/UjyE7GoXNIZsKC3iv
 zd4HBhmTlAuwgrP7oTCH1E5UgPbdxDfIa2MQo3BGfewxhusR5aIVHZc5Is5JN5QfynkKlGxEgn
 ysNA4TNFZb6CFcuHm3pPXfF1/1YcHlHQAAAA=
X-Change-ID: 20251030-topic-drm-fix-panel-synaptics-tddi-e4fd649c2130
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZZhXi05WkmNlGkvmP9vNdVB8Wq9Bva4vLNsdz9mU/9k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpAyGsY7RNnpoDJFzOE5D6/srtKrtYKnF9n65eZvvE
 4qpPJQOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaQMhrAAKCRB33NvayMhJ0ZHCD/
 9YGGZTJgC+wXEy9I8CFzzWN0xi4NFX1vnZ6meY7qz8RotVLOcacu5hFz0MFpc2HPkzQg+KrwykeR6K
 /KeEFMPi+8CuVYOFXrvcStvaU15CRQ4Lyu+QpgutoC660B2euoX+683Fk9jM6tMzO4Jea4vd4FOygQ
 KI1/KOZFgRhp6awGU+JxY4HYsA9NF/VutDX+AK/y139To/VHIVsMYrAIPdYufhJ9/mvm/WxyMYtYbO
 Ur7UwO/cjwMtHT+aNdybET95rW+fi+8mFyqJlTkMeNXnlxaB9mu7YcxNF4tPvjEljKag3JfS4R/yww
 y5ePXeu+XfAAgkYF6R/yNqWvKooG59mCHQhPaQ8inozVIdphEZBA8WHSnLRw/p8E/3yyPj64H31NNd
 QHYvOmdRy4G7inuFWScuEYo4zNeO298K41CgPD3l69nO5qixmlc/XKToWiLSQhUXK/AdVbzRqXq5ZL
 pFgtCykBFnPvI97p/VNGlBQvgTYmllsr/loP0pfZILQBROcSFpkYe+5QK0Cbp/Co2rk08Bp5zsLyh2
 1wsrFYcTOuw1l78QG/fKjpqSsDaRD0ns8tsA3wyyKQkzlo2dFF7mvyCbDMVaKZKF8bGhLZ7vJqOvDJ
 qqLgQ+Y4ntHuM+HCYoGrZ1eEwlW0P8e5wwduHW5zhmUSh40KblKJWGZVhKNw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Stephen Rothwell <sfr@canb.auug.org.au>

Fix up for "backlight: Do not include <linux/fb.h> in header file"
interacting with [1] from the drm-misc tree.

[1] commit 3eae82503f4f ("drm: panel: add support for Synaptics TDDI series DSI panels")

Fixes: 3eae82503f4f ("drm: panel: add support for Synaptics TDDI series DSI panels")
Closes: https://lore.kernel.org/all/20251030151428.3c1f11ea@canb.auug.org.au/
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/panel-synaptics-tddi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-synaptics-tddi.c b/drivers/gpu/drm/panel/panel-synaptics-tddi.c
index a4b3cbdebb6c..0aea1854710e 100644
--- a/drivers/gpu/drm/panel/panel-synaptics-tddi.c
+++ b/drivers/gpu/drm/panel/panel-synaptics-tddi.c
@@ -9,6 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/regulator/consumer.h>
 
 #include <video/mipi_display.h>
 

---
base-commit: bdaf9fa04946b9d1086d69b7269c113ace8e9f76
change-id: 20251030-topic-drm-fix-panel-synaptics-tddi-e4fd649c2130

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


