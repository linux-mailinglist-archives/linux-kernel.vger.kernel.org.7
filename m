Return-Path: <linux-kernel+bounces-788078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C324BB37F81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00ECA189710C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CD730F926;
	Wed, 27 Aug 2025 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="H4jpo4EL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76042AE90
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289294; cv=none; b=Lxpe14iP9yuhHAmB3XrWUh+RtuVmxZfqZY8arBXSFZ9HXwTpnt+IlxI4NrM7aEQoFNUVxwXiBFOteeKP/N068D6W24H3dB23RROrKwxGB/otS5NUtNr/q+9lLM8gUsAQLNYKIfPEKTMA5D+ojt910CUHaR7rAgSQ3WIlTcLAgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289294; c=relaxed/simple;
	bh=8g3LHa5yiSyBWmJY+w12ha7ZYg8HBqxyOXjkVHt3Hjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTw3uqtI8jWn1qE9WOjbZNJ9hKxCPsnkXNi4AxaxDtUEohB+CJvuyXvj9fWvd/x6kIUFBs3LJhhiWQv9H4AmWIL/SijOr7OPmSy7T1Of+QBPuklLH6u+RlGlekdSQ7rksmhLQ2Ml54s4AvmbLzJks98rN/unmBOzUjf2/j7RSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=H4jpo4EL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso35249485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289290; x=1756894090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXT1+ZhdRYw9on7KamKzgM97PHmPN2Js9ftnngLmHdk=;
        b=H4jpo4EL7kk6LEWUqFMScxle4zwI69VcgnH46ZMXJB7eNq+Va49svbP0jZj8+nyzwr
         az/9ydptZTu+QdaizMQjp/7NSB4liuHO+EmGQ6wM4DYELZPCNbXqYQ6oS38NCy5AnA1K
         L5UUK5X16um+VqeKGWwEzHL3AS9DqXBpmKvQ0bSFdNSoqXSFLflYUN7zXZLDtNk3nvt5
         rG4oEZaBD+DvB/uS3VqINCfPIN5r/bs+1nWfwIAVUrEL9jm+RguF9YQCV4O08hpAB3yV
         PtF3x4xV2eS1HqAsVZRvYCroIN8RGgNJ/Gf0OeVCuF3fTtN8VajuOoDHkrd6ZvnLDMc8
         mpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289290; x=1756894090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXT1+ZhdRYw9on7KamKzgM97PHmPN2Js9ftnngLmHdk=;
        b=jDES8o35Ffwsy0KjwVdh8CrGTDLx77Lxzi3hh6wvgdH6itcWYxG1+6gUnDZ8typQLD
         hOYCHmy/cLYQq8iS6VCMY3Q+eS1YYcbwS02JvhWD/xbyQXOYE3hRF8K7Lz9keaXUShMu
         cIPhP809WLaRWFfc1A5g0IZDRUdv3A6TFuT9OqNKEP2yS5QTYYw8OHVtccfBl72CkHaG
         JYiHShnRvuucKowcLvXXr9/IUviU9RMyeTK3bK6UmLJdHBAWBWweLvhB7RcGnhnfGrfd
         wraqm6sU69ci7wEHNiGXvkduHDIb4tcW8FU834FYDHjTVYxadDCCEky2Qkp1X4qaw1Na
         Nklw==
X-Forwarded-Encrypted: i=1; AJvYcCUegMF2FiYZ4csEbla4abgisEl9fUyVcP1/aDVxzAIFdyiF+fAYOjP4pczUpyWA9LGsGYPuRCi6cXUY+VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZt3TfCO5WjH5VW2EmtCoPWHkxhEdxI//bI8Nm10aig2sqboh
	QtH/+dKeiOYsUvKLGvAsHKDAtuHO/xZLnY+fotrkmdAhDnVgarSYaoFIUbMKeS0b6oM=
X-Gm-Gg: ASbGncu0FfjT+h6JLE25RZvt2vC+fWhvWwY09lcT2aAW9iWvzBZrYezMTiyjd7VfRQ9
	hTXm66tIlD/n9kll2SM5IxcorJi6hIQXbI3SM/FcH0r7+5IgQbT1QYz8gKvb5xDlcAzJ/IrXq6Q
	EX4KkfSuW7yVKfIOKjP4GEHYbWJbH7XTIa9SACQt6V2OZghydWuiR0bZwW+YXxFH8fg5yPN2/Y2
	PIDLv5d0aj5OsYzESL2mlMLgWYftCK21s0fiFQx9PBoL1wREm3VbofdvtLiGnP4L82dR1QVUiqZ
	Ok6D5h641owMkUisu1wVd5aHiSEoR4CfM6bgFA/UwVohzlJDifWL1McQfLMPsTf/iq4+PPPMJCq
	MGeKSXJxgOtl3JMQ2FOuDRqEouGDsfJ4rBziUiulZZ6Ue50GA0CxQDzKuflXQ/XyeCD+VolPN60
	mHtq4Lze8/Z6FMZl3t
X-Google-Smtp-Source: AGHT+IGhD1atCfo4ZwImu6PpxS5A/Aon596DElxCkBAX5H/h4QkS48jyqdKtBal8nCISAnOuiKWemg==
X-Received: by 2002:a05:600c:1c87:b0:456:173c:8a53 with SMTP id 5b1f17b1804b1-45b5179cdd5mr133811985e9.2.1756289289948;
        Wed, 27 Aug 2025 03:08:09 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b723a1ff9sm16471855e9.22.2025.08.27.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:08:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	claudiu.beznea.uj@bp.renesas.com,
	saravanak@google.com,
	treding@nvidia.com,
	ulf.hansson@linaro.org
Cc: claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: display: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:08:04 +0300
Message-ID: <20250827100804.926672-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/gpu/drm/display/drm_dp_aux_bus.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
index 2d279e82922f..191664900ac7 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
@@ -58,13 +58,14 @@ static int dp_aux_ep_probe(struct device *dev)
 		container_of(aux_ep, struct dp_aux_ep_device_with_data, aux_ep);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to attach to PM Domain\n");
 
 	ret = aux_ep_drv->probe(aux_ep);
 	if (ret)
-		goto err_attached;
+		return ret;
 
 	if (aux_ep_with_data->done_probing) {
 		ret = aux_ep_with_data->done_probing(aux_ep->aux);
@@ -88,8 +89,6 @@ static int dp_aux_ep_probe(struct device *dev)
 err_probed:
 	if (aux_ep_drv->remove)
 		aux_ep_drv->remove(aux_ep);
-err_attached:
-	dev_pm_domain_detach(dev, true);
 
 	return ret;
 }
@@ -107,7 +106,6 @@ static void dp_aux_ep_remove(struct device *dev)
 
 	if (aux_ep_drv->remove)
 		aux_ep_drv->remove(aux_ep);
-	dev_pm_domain_detach(dev, true);
 }
 
 /**
-- 
2.43.0


