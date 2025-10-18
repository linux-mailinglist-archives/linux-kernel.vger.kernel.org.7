Return-Path: <linux-kernel+bounces-858925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FCBEC441
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A14F1AA56EF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B42144D7;
	Sat, 18 Oct 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2RRIpWmq"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560911D61A3
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752916; cv=none; b=GKciYCWvB791PVB/Kt83T7ioVa3DHXbycBPbOXJrGRrEB30yBXi+jkrGTDhzdkGAf56EVqHVe/ErpmWIJjOYpqVlSLO/ikih/BiWY5XMYdjq5QhbkyfUJrKKzCmdYz68ssK/mVGqQhfuRYxozbB3jx1XLMGYUQG/GhgJQ6j3Q1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752916; c=relaxed/simple;
	bh=gn1dFtDuTIsqMj8v2HvytQlrUom5dRjvfBu0zKRM9Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yqe4Yx5D8J1Q93V27gybYxopOu+hNZigAt3zdXHe99sOwqzGFpjMWWz8R+8plRiJjjZf7BTYmSe7u95IgD9K3sR1VdIr67YGJdQC4ZKBfJZe78lD64mCjbCwh70Cqqty8JuhCWLo7s68+79LP7Nau7HCjyaD+oES1IM/56oByns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2RRIpWmq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8FF1B4E4115C;
	Sat, 18 Oct 2025 02:01:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63FD560701;
	Sat, 18 Oct 2025 02:01:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21F27102F2374;
	Sat, 18 Oct 2025 04:01:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IWd8MEnu7MYdo1XAQJUp9AjirYXBeykWt+5fZ1PTMBk=;
	b=2RRIpWmqxmwhXoiZ1DZsBfDp7Yeo/IDz5ccvEqIKRiG4XLWFNwK2+huCVWRNUwSRk+m48t
	KA1y/XYCygnZfBf5zrpOSOg8welopT+ypXDpphiGt/FJdOHy5xble6hFAmlIDgQSZQfl1I
	udV6P0gCaR/3DRZv7fcuxc2KVRaxi+LfGGAhghDvISBnUM+WQ7v54nkf5IzXisPpgDViuN
	p+GUevbE3pSDxVIEoLB2LpjmCtvnmxFjOZJQj8ksdDVRj7WsJ8DKig79Iw+8OXlB3+R/Dl
	r7AaCxE/GfHpp9RvF1AKaeB3Y0TuNHZKp9rtwNylcFz5V61VT908d+o4Ln0Vuw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:02 +0200
Subject: [PATCH 02/22] drm/vkms: Introduce configfs for plane name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-vkms-all-config-v1-2-a7760755d92d@bootlin.com>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
In-Reply-To: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=709;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=gn1dFtDuTIsqMj8v2HvytQlrUom5dRjvfBu0zKRM9Ko=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT9jLLPBYDiM4Vcw5XHlQXCeI6iAYkdBdx3W
 5KkpL2ihI2JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/QAKCRAgrS7GWxAs
 4hpXEACpCvTcjmGIZqYMTAju6yjWUWyUkikb2iWoD2Dw26Kmr5lJErTqKiHATWqw5MQcGkQFBk4
 6O/0VeGSnfMY7/OBO7K0yAZztVRtb5ZqvyFtnfq5Z9p/5q8mK9qr9rMcJsiHp8ytbAeUwdfZBmS
 KeE/zOotuD55SLWaJyQCSmUiRb0GYosRklYqFKPPo1NVcmZzUxPSsRsBTFsT01gcv0DyQHLBjHj
 GobWIzi1t9vo0pbquyVf2eYrmLeNBz23t8Ub9C5XE0OEeZhc7w9lkoT+1zzPnuJlfrwpeaboibZ
 m9pID+hbueWbVZCgVrj0RxgE0GLDGdznfybFW6ZJDf3B68n4aMZNLYbo4pw9EWPwGcCM5xginW7
 AXH0UNHuADtHdg+/VDII7aYAZQd//Ga+Y7kXsNx7RXfkpOsul22xRbpzVmiHmmSMILtvapdSRBz
 iW6R51IBEFVqTeriY6EmWi8RBghujY8TfZ8YnGIqvhhUBA3I6zUCvDklOFq+kO4vGLEGcgpSS9H
 6aUNW7wSnmrZWSQ1iPrwe4eKweN3PUEk3AFZFMVVzwYuPwBHUK3feZGHTjIDdYvI3XrqYyUkxJG
 KXSIRp3WanKitGZPG5ByQQeXFchnPUZZrnla6f55wtwWZotTiMI9lGoF+xrvA9AWiYHm+3MKWR+
 p8In2xo/2gf1lKQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Use directory name as name for the plane.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 07ab794e1052..ea245e2e2fd2 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -376,6 +376,7 @@ static struct config_group *make_plane_group(struct config_group *group,
 			kfree(plane);
 			return ERR_CAST(plane->config);
 		}
+		vkms_config_plane_set_name(plane->config, name);
 
 		config_group_init_type_name(&plane->group, name, &plane_item_type);
 

-- 
2.51.0


