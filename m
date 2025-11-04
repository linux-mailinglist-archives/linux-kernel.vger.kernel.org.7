Return-Path: <linux-kernel+bounces-884898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F772C31740
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1657E188677A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB032D0EA;
	Tue,  4 Nov 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="e6Ifa/xI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC4221FCC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265530; cv=none; b=IuTGYx/y3JTd3rgP2LXK2J52gRi7c/xPuKm/UhurzNqJFcu6h9KUvj7Ce/M4ooObwJ9KEi4Xn2P09H7/CS4eoWsNbL966Qu3cLkJBJ6jVzrqTVB5RY7CE/vUAFSvLQcwgwmWAel5DtB+HUGGa5LZu5fnve7nZcUd2MYI+8+s6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265530; c=relaxed/simple;
	bh=PPiWkwLZfzpUKKINJK4JW8yE/GYuOpZBnm5M9hOrdak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YeA9AEHQIXY/QF+XBR8SKzKobvVCFoF7kdkH4Px69n98+WeNxhplgJpYbCn+xhcp9et5YKlvPi2JO02BPSfFi549hr/Lpt6qNlj+9lIFDLQcTevIjLUKBrnPEgDSY46FrNqyvYPba9AFADl+DddJ9R8ZMHugCfA7OS+GD0SursY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=e6Ifa/xI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47755de027eso5220885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762265526; x=1762870326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/trNHTcNj2oZzYDiffhX3l1sAkB1xmIMnTsuBGEOTQ0=;
        b=e6Ifa/xI/RczoQrDrHxSHxZxs6KA77UcMGL5p3qpxUclc9lStRxmBqR1cVbgx/awdi
         FLe6BGtAYngmiXGMKy8Gf8G9BPLh7f8hmisjLQRKHq5ze7av2lIMTiOQlPD6S0eKKrJN
         0JgqKEJNy/HiQaVn1q94VRjr+fIW95a10ZtJzwxkgyA8/7aaszhZe95HrxRCEasoGwUv
         Fj4Zc7QX9OEayJtXl2mCaMb2YICVDuQbEqkx4z8oTkokEraErba/gaCzX7uWRStq/irf
         eqFfbPdSCKXCrUWNCdB5qfbLeQISqShAIkEcfi8inxTWIqOVlDDUp36RQSxgBCWuSzg1
         733Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265526; x=1762870326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/trNHTcNj2oZzYDiffhX3l1sAkB1xmIMnTsuBGEOTQ0=;
        b=qNM9k5qB2U8ozUD++K++Tj2lkUgyi3OUcn3F3XZBE3BwpH26rOQY1tX9mfqFRJrLFF
         ObnyAxTCr9s8vZKrLQMeAfSLS6Sx1D6KuijwFXsbG9zEXZWfl2XDx0NzQAsdOD1cZhvk
         0ZrFtsEb+34EUvRuzxx1r/he4Ru16vknGAmThNpHqYZ8C5ZMzrPW+3GyEHeeCPw96PZz
         PVp0TBMHjp4QG6P+PEw/ET8TAVvDr0NGBxenVhaDuFO21t49v82F4SoWcJYM4cozMIxF
         Z0uukdstDnF9lIxej0dRFoRu+kuqizJCfJ/DMPqm1J31uJE/7IaedRO2tgrB7rSHoeIk
         +4lg==
X-Forwarded-Encrypted: i=1; AJvYcCUVtS9bNpbtY/4e5Hyp86l3xmZePUTrA/NKl3zatm0f2dHBuwOC2C64POh7+nQU/UwmoTAMHLbG+aS+6EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHHw5x7+2nxlRqgAOmnoglhzBMKQnbHYz/9mw66AaDbeCE/ai
	AUH9SmfDCNrmH/7fTJkvy7YSLM8sBSBDn/67EGklZ5etnXnZbSmcthAJ7iTUtAQVVyM=
X-Gm-Gg: ASbGncsLM8XED/ov5OjjGQwKEr4MWN4D0f+/LZ50Y3dLOC81hcLpbhwt6WhIpyvmXEI
	G554IKA/8zSrgr6DHp3YrWk51YjEwvT9lm1jlAjcAiYGO57CxfglI83mDB4aly9wCXYCBDX9Dkh
	zUTdiRpX2y9wF8amQRShufXOb3i9h9z9c54Ufno3Orl6eVi7vkqtbKbcMJjoIcRvafsfVtiQpjC
	xPZ0xvolgWW3jOSjwMxrMxvhKBPB96UoUIZXM8SEin5Y3ixA8yvv1gH7B0G21pHn8FNev0+ft76
	jb9GYhLJb8ErKmpbX3rU5K6WlT76+oUB9fdXRSwTnhtFERl3ms5uKEvPLi55CkXUi+9V1oX1kUc
	dYxfFX8zeHkwaC/AdE6rdFChRDhBR0WzZJK4wRCE8gy47A9k2N/Wtsw+e7e4pK7AA3dJgYdjaXs
	bnZidYQcA3Dl893cDB2xLCNW4wnx+z2Q==
X-Google-Smtp-Source: AGHT+IEdlrhro/dTXAOyxOHGqemT1j8QaxkeVCtOQCBl0nf9g4eBQBRJrGzSMNhT1VXTufZYU7Ms2Q==
X-Received: by 2002:a05:600c:1c93:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-47730794401mr148414025e9.4.1762265525341;
        Tue, 04 Nov 2025 06:12:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm4903630f8f.44.2025.11.04.06.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:12:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	ulf.hansson@linaro.org
Cc: claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2] drm: display: Drop dev_pm_domain_detach() call
Date: Tue,  4 Nov 2025 16:11:52 +0200
Message-ID: <20251104141152.2323788-1-claudiu.beznea.uj@bp.renesas.com>
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

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


