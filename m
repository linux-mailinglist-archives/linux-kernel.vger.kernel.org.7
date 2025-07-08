Return-Path: <linux-kernel+bounces-721215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B79AFC633
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C60481A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48792BFC80;
	Tue,  8 Jul 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjmroEvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFD2BF016
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964741; cv=none; b=ipQ5cg8bniYLv7ZsFvLnzXhmBzHu5x2oWE98fKIaRC3ShWAlb/J/P/w9c/GWnAvB4zselPZeuOue6wTayd9sReeTcRA8A4hUwxprksYuEeuslyxzKayJ/duEr9Je8zXzVUHZwGzJFR2ykrZcPg2fSsfNYWG2zAQ5rd6+hB4r248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964741; c=relaxed/simple;
	bh=BSVHRxRLMFx5rMeJ/BkvsNjbrXj2x9tNMDRCvByqmBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CERrqF4qUqIWCbYOF+ixrCMBS4kADH9zybtJuGa0C7DtWorMnz+gVDraT3PddpyrYNb6kaOgxMOXh3isksXeV+taUmNQCQUcV0fhKHcjdDQs0z5ipfdyK4ELj9E5SuqqRuYnfMwIxN8uX3QsbnvJo7qfSl8VdjVHpgbCjeFchks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjmroEvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19A0C4CEF0;
	Tue,  8 Jul 2025 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964740;
	bh=BSVHRxRLMFx5rMeJ/BkvsNjbrXj2x9tNMDRCvByqmBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjmroEvo8g0tqzcmsCu1MlR+6FKQd8ao9JNSZhOeL+aY/0csyqCC12AkPuLo+E41M
	 sYSzarU6nRWXKe95H8EJiNPQwcPv3KQpWiNprojvDkdm57KIhKSo7oSF7mwuayDo27
	 Un4cJriwCUJGh5K3rK0exD5AaMovVoVijf6khuwvMGUsge6DS4MPMilQiu/5Tit6XK
	 F87+qQgUyC9cJc0/OWbwx5I/pOFwGtX9hsjF4v52Ft52v3SKj8J9OEG07QWaUxsJ6v
	 TakYntM4yGVB4KQU68wbYtIGhd+qsdrdbjDXvFhZRXwayGTaBJAkvE78Hfui+VbTZr
	 hB5a6OmE2qsmA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZ43g-0000000042J-2JGA;
	Tue, 08 Jul 2025 10:52:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Douglas Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] drm/bridge: ti-sn65dsi86: fix OF node leak
Date: Tue,  8 Jul 2025 10:51:24 +0200
Message-ID: <20250708085124.15445-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708085124.15445-1-johan@kernel.org>
References: <20250708085124.15445-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the OF node reference taken when creating the bridge
device when the device is later released.

Fixes: a1e3667a9835 ("drm/bridge: ti-sn65dsi86: Promote the AUX channel to its own sub-dev")
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index de9c23537465..79f4d02f24cb 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -467,6 +467,7 @@ static void ti_sn65dsi86_aux_device_release(struct device *dev)
 {
 	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device, dev);
 
+	of_node_put(dev->of_node);
 	kfree(aux);
 }
 
@@ -490,6 +491,7 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 	device_set_of_node_from_dev(&aux->dev, dev);
 	ret = auxiliary_device_init(aux);
 	if (ret) {
+		of_node_put(aux->dev.of_node);
 		kfree(aux);
 		return ret;
 	}
-- 
2.49.0


