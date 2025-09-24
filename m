Return-Path: <linux-kernel+bounces-830381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8EAB9983D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5231B242F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C72E2845;
	Wed, 24 Sep 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JcUYbTzf"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE02E03E0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711522; cv=none; b=HlbguzFS77Jo4uloZ73t62TU4SA4z/s8dxi6SuLQwTmXrOHtRUQoXyPKa494qCfegvhGHe81KPllUXKRdYjgiilbDTU0ZRdKErT+xIZqPPN+zvBfitnaaiqh1DoS9wWcRRVcsWFRqkxMpyKn0WcieINYUk4vEwUd8QTI03B6tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711522; c=relaxed/simple;
	bh=9Ay94YFsTVubdxh+6Ed0S1oJNPwy19LTYgvi6EFID38=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=DeXttnKIMTE4m672chwN2lJePjR/AteaIECUqI717EYqui/c51SnXSQbq6g5wG0AWsZj7Pbcp93EjYBEWKLzUqqpre4JXY3BlcvNAa82fbDzEzHXRGnnowchDxqhFDtm/W3d1vGm//Wfo8XOVtq6l9Ap5N+3iZS8U0e7bTO0+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JcUYbTzf; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758711512; bh=fRFsnJ40e71aBJkNjV/i7/Hq7grzH+57bG8oCWourQU=;
	h=From:To:Cc:Subject:Date;
	b=JcUYbTzfURZ6QduB7abuMs+reffWZI8wK8cktqMcGoptQ1ernKEUvwcozE/9/93HD
	 C0f8+jCvnngbPnVh5HWpysZjx+145dq8kmNAw2H5mLqF++Rt9EEOWQicOoZf7gGKY4
	 9rFiKWcwAOCcP/60lBqF4C3oigKf09/d5cVEsllA=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id E9EAF8B6; Wed, 24 Sep 2025 18:58:30 +0800
X-QQ-mid: xmsmtpt1758711510tfocsxz6a
Message-ID: <tencent_A8BB4A0E44BDCF1DEC33942D2144C521AF07@qq.com>
X-QQ-XMAILINFO: MAcVqULX7QQ1oqsUFJVBzWZUCyaAi+Dw31URdXL0LU4F/EGgFWDSg7XGQnER1S
	 Qj71FkoTXFhBNU5rBRZB/HzfMhdS4BK9lVgX5oggzw97ILRs/ePR27lQQFOEA6UXC/PhwLsXyo/D
	 J1SG1R6vvYluC7Y8BwGrQdAqHYCph3qBv6W+hOfcRB1IyNRCBH8dESldg6paCm9A32J3xTBI1xdf
	 abPIG8rVKY5ZH0HMMx+0yeVEBgslX5clhuQof2xrgE7ChxUjRniKA1UDZwQ6InFJReJo1MEDmhFt
	 kVDyanaHjFdeeecLo5hgxBpSiOmAwQbZWe5wjYj2JEJzAlqTqqpl+wqkTaBultba22UrpP7Yn8Uh
	 uRe5Ai4wL39syAMYFrykIi0Tok7hEXWlvFdGsKJ01yQ+gBDqiWzzJYT+H/AT6e3yDQ7Upbyj47FM
	 vU4jwCTr30Ex2KrMWI+G0je7ohmnMQeUWv3EEZZq8iokr4o1dybiuA1/mouwxh9nakn1/mFMwJii
	 ztNlwimDnxEItIpPeEZd1TsalKe5t0DumxUnRVmJ7M51z2VK4HrmXCcobF8pE7hnGzAAQWIY05PI
	 tdwh0XO62guBhYJd86G9S5DQl+nmdKUFoL9/t6bML6A02c0EzIPX2/if6wwHF6Q+DgHHb7Be1Dej
	 eeeJmBzCLVepb38R4K4t0CsnfzOcKxEveQ8Gf+LgW33059U2dinSUfbng2t1ygw25Rv1hp/4GPSW
	 ZyqU7Y/elDrCVYeTjKVbl6AcRlSUT49yOJQFMS8JvPr+FBFsLF1DS5H11CPos9/W9we1MdwK5K3w
	 XNBAuE+JJimHjScChfTs3kn4ht4wSWeALILzfz15Gv5NoKzAt8y6YMCxvAGjBCCsx13T3/8hzk4c
	 6aBdELlTzSZhGct+mYUBcD9bxcx2z3zbF23kuaw/ZHaB1BuIq7Af+OBsYaKtODTdwapWXR+6xJbq
	 UGf/sMyVyk5ckeSfhohiNs/Oy14StUt9sB+iWIVPI=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: 2564278112@qq.com
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wang Jiang <jiangwang@kylinos.cn>
Subject: [PATCH] drm/radeon: Solve the problem of the audio options not disappearing promptly after unplugging the HDMI audio.
Date: Wed, 24 Sep 2025 18:58:27 +0800
X-OQ-MSGID: <20250924105827.880992-1-2564278112@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Jiang <jiangwang@kylinos.cn>

The audio detection process in the Radeon driver is as follows:
radeon_dvi_detect/radeon_dp_detect -> radeon_audio_detect -> radeon_audio_enable -> radeon_audio_component_notify -> radeon_audio_component_get_eld
When HDMI is unplugged, radeon_dvi_detect is triggered.
At this point, radeon_audio_detect is triggered before radeon_dvi_detect has finished (which also means the new state of the connector has not been reported).
In this scenario, radeon_audio_detect can detect that the connector is disconnected (because the parameter is passed down),
 but it is very likely that the audio callback function radeon_audio_component_get_eld cannot detect the disconnection of the connector.
As a result, when the audio component (radeon_audio_component_get_eld) performs detection, the connector's state is not shown as disconnected,
and connector->eld is not zero, causing the audio component to think the audio driver is still working.
I have added a new member (enable_mask) to the audio structure to record the audio enable status.
Only when radeon_audio_component_get_eld detects that enable_mask is not zero will it continue to work.
There might be other solutions, such as placing radeon_audio_detect/radeon_audio_component_notify after the completion of radeon_XX_detect.
However, I found that this would require significant changes (or perhaps it's just my limited coding skills?).

Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 drivers/gpu/drm/radeon/radeon.h       | 1 +
 drivers/gpu/drm/radeon/radeon_audio.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 63c47585afbc..2d0a411e3ed6 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1745,6 +1745,7 @@ struct r600_audio_pin {
 	u32			offset;
 	bool			connected;
 	u32			id;
+	u8			enable_mask;
 };
 
 struct r600_audio {
diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 8d64ba18572e..a0717895cc8a 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -212,6 +212,7 @@ static void radeon_audio_enable(struct radeon_device *rdev,
 	if (rdev->audio.funcs->enable)
 		rdev->audio.funcs->enable(rdev, pin, enable_mask);
 
+	rdev->audio.pin[pin->id].enable_mask = enable_mask;
 	radeon_audio_component_notify(rdev, pin->id);
 }
 
@@ -274,6 +275,7 @@ int radeon_audio_init(struct radeon_device *rdev)
 		rdev->audio.pin[i].connected = false;
 		rdev->audio.pin[i].offset = pin_offsets[i];
 		rdev->audio.pin[i].id = i;
+		rdev->audio.pin[i].enable_mask = 0;
 	}
 
 	radeon_audio_interface_init(rdev);
@@ -760,6 +762,9 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
 	if (!rdev->audio.enabled || !rdev->mode_info.mode_config_initialized)
 		return 0;
 
+	if (rdev->audio.pin[port].enable_mask == 0)
+		return 0;
+
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		const struct drm_connector_helper_funcs *connector_funcs =
 				connector->helper_private;
-- 
2.25.1


