Return-Path: <linux-kernel+bounces-735868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873BB094BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18DC1C4676D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630022FEE16;
	Thu, 17 Jul 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5CUq6ez"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B82F94BC;
	Thu, 17 Jul 2025 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779807; cv=none; b=T2+wlV5ydol2hogZKLkXEx/28VsfZGkM0v/IIMgeiiG/NjmKg07mIA4YclAUZkXjZwgZrNGg9hwOkbqHDEADPwIws5ctFB9iVS4Zzc9GjsQBpqeC7xKYWaBw0sHN181JHmV1ngK9azKpbJdea0rW9ApUodYTFS3ok3zuhALITkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779807; c=relaxed/simple;
	bh=Ay3UjBLijGxD3y8KzxOLm+Clcmu+dKkj0LPDEulYkuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIpYLMMF0ovT69MuoHNNJWhSQe4G7zuwbw/DyHnwx8sw/s3mYCV719vw3nRF8zd4BSUST+STw654Dy/ppJmNbMTgn7ibttq4G13nlAdLv3aH8ixespv/xmGREUM0JEA2IMGGVbBqbY5GXn9ohveXJjlJrhXhkoR1vTQsLu8M6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5CUq6ez; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso7070685e9.1;
        Thu, 17 Jul 2025 12:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752779804; x=1753384604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuCA5OMqgALuEAxLsCpNRECi3es/sBRCGgKqyk3kQIw=;
        b=j5CUq6ez1vrkXWdb/1W6W72hVH86DoPYoLfbOo5ZeKRAPURyganjMnt6o/Hdml/fx+
         OsKE8X5XdTc/hagyEESlKTlBR+4IP+trjZvEdp7R95vnba1WNw8NbPOOc7cfRL7KJ1wZ
         JiHrFrjtuy4U1mmCgIoTdtyje+J40T5/3CuyXnRZj2dWAdPmkJm7R+pNtb9a2fBabeYQ
         zyAWjN+I5U0o2tfPYCBd5Xxj1gOzjX+7tTltsepJ4vWXRy/B2z9L/4IiH53MoLGbwrQq
         p8H6MD15guTn9qPt0yzrGcOjL+iDAUDq9It2o+XdI9ym5mnuW4yca+pvhVAIvZrwsXgT
         +PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779804; x=1753384604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuCA5OMqgALuEAxLsCpNRECi3es/sBRCGgKqyk3kQIw=;
        b=m3v+Y1cU4mV79eejie+GGYHUupzctpPJccDWdVsWIiOK75n01LDgJL+ZqLOOzrIq0n
         ctwdcUBKSgz6PuHc5LYYyQGW/NtcbtoEHSGcrSV2Xp0t4pY/xO5BEQmXOO2V51igIDkT
         XC2Srqc0g2qvACyfIvfdhXm3zHfNFbKktz4/qnFtzTk690TUykRsw1QCp3w7yOSbvSay
         HPRkFkVpTxG4gUzZNjsl9Urnfs06ZpFwV4BdASz13UMP+ONCQPKyZSVVSzVAb21erYC6
         8p2SJx8W6d8cjnQnF4MPa0tRH5PJ76TwU3Sz8lPVrJpr6TuSBfvbjJ3WO/rXgehePq2Y
         VrFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjSW81i/x9rwPSUNQeD1lOiwF1pN7Y6K7AEcPD6YpDotb3IfONRedV70Sxox9VFP8Wz+mOB0aKlYvkrpcO@vger.kernel.org, AJvYcCWSjEipqe9MynASj8LVlCYLn9PkJiF3hepcIXR9xgvwDjWbjp88BDm0iL3ZuiJasJJL3h6TwP8xFp4q@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEH2pOo88jqGV1qnrd738mHlUprGaU1+NQRYFR2ctpJZ+mMsD
	fJf2uk8JE0H3m4w0UIZI7Up+13ZI0/w7oiDRhDI/kd4Y0RZ4DYjD9YYk
X-Gm-Gg: ASbGnctfBGPFKPueZiCLqUy1M8xvFr25wTmZLwxsQCKOm6Ra8flkmju4WF9/+Y4MfC/
	1Pa9pB4MiesV7Q1zgwwfRxDO30jmoJuC6Mc9FIbrELxxg4G3zhvjtiE9gTv5hcn83zpIJ6Lia+i
	Xyr64ntIULJ8FQmlAq8SHXmVSkpo69SVhw/mdb/ZuaFSLhFxb2RRD1kl7S4MbVEk9weXCqsjFe9
	wMsX+HnJFj0U178NmBY37zbDI2Ir8dAtb/RdSmuypfOH2PAL/BcnXenKIPqISXCNtsOFWukGyyC
	c7TQa5TBADSvGlS+E0WxdmtsKQ23NoQXI88tnmzpZIFYCNR3qAU3HhxRvj8XVTLmmb91/wO9Xw0
	AvRexEOTg/bck7OYuMi2bCcIUvp7fqDVt
X-Google-Smtp-Source: AGHT+IGnGahGt2U5htIhFXVjft18mH3zp4ADziGMeoajJetWxt5b3F2yGd4T5BahFpHifeth3xCKfw==
X-Received: by 2002:a05:6000:642:b0:3b6:1630:9204 with SMTP id ffacd0b85a97d-3b616309230mr2341095f8f.19.1752779804161;
        Thu, 17 Jul 2025 12:16:44 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8e14d07sm21680436f8f.66.2025.07.17.12.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 12:16:43 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Thu, 17 Jul 2025 21:15:33 +0200
Subject: [PATCH 2/4] drm/sti: make use of drm_of_component_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-sti-rework-v1-2-46d516fb1ebb@gmail.com>
References: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
In-Reply-To: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=Ay3UjBLijGxD3y8KzxOLm+Clcmu+dKkj0LPDEulYkuo=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoeUwYtZuxKSsScyK2pzLf8SqC21JbxA2n0N390
 OV4UO/qtsmJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHlMGAAKCRDnIYpo1BLC
 tSl+D/45xwrv2JRM2TfersBnFNba4wWf/30fpVnO86yL3QTGzpnTmJ+8TEqSd7aeAnTVhtUmFfq
 YwnwcYjn8wII3X/ehq4g54mVqxtGDNgpAK0+D/vPKmY8PbATXjbnuU0VB25VRDho/Yq8r4fV+Cw
 sA2IbkZzfQMKdU3Jy8VuxXymjWmmD9DztwVI+c9C1j8Rhyu6M1BDmxTxRXNRih5NtJILNYNN302
 82ltvcFZYAbtg1l/sirhPFyqXwCZG02w8gDGifjjehLKOFAVTGr/weWs5fIeQ7sUvJiVnAm+JCW
 DsnOv18XbPzwQKQU4imRG4BNE6EnzPb1CeWGuSQYTHYpE/iUGjFQxO4WbkW07iKDft6usDu4buY
 HPTGrVuuiCjCcinCeMIVbMkuOD671Dy7R69FrO2Mvkiycqmp/2rPlxhD4G1eUOriS8qg81Lkg6B
 4a8eYX9dH5kv5boL6CbyzVIfPBQ2hHIIjXczmSqAIWSTB/x1zqRXlNqpmbQLLIrC4+BSf/8uyW5
 jq3X63ev8G8kFPfRAwzGH4KbP+DoLZtbfCPyVb1b9Dftf2GMmJSrKtxPcojKwiwGYVYimCx4mAX
 4Rpc11seryt3l+RF/kWJBHZ7DNGJBwKktL7a7GcKf1YDaOOZVqwAC2PBM6xPtELSvErm624w2bW
 tkLZ1e5Ec7B4GGg==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Enhance the probing sequence by using the ports property of the
display-subsystem node.

That done, it becomes possible to handle the display-substem node
outside of the soc node within the device-tree and not have each IP
blocks as children of the display-subsystem node.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/gpu/drm/sti/sti_drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index 42f21ab91957b38cb9aef012b6ee7f4ae1683edf..9d6a7c8fa0759c0b6fedf87169b18cff3684be46 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -231,9 +231,6 @@ static const struct component_master_ops sti_ops = {
 static int sti_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
-	struct device_node *child_np;
-	struct component_match *match = NULL;
 	int ret;
 
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
@@ -242,15 +239,7 @@ static int sti_platform_probe(struct platform_device *pdev)
 
 	devm_of_platform_populate(dev);
 
-	child_np = of_get_next_available_child(node, NULL);
-
-	while (child_np) {
-		drm_of_component_match_add(dev, &match, component_compare_of,
-					   child_np);
-		child_np = of_get_next_available_child(node, child_np);
-	}
-
-	return component_master_add_with_match(dev, &sti_ops, match);
+	return drm_of_component_probe(dev, component_compare_of, &sti_ops);
 }
 
 static void sti_platform_remove(struct platform_device *pdev)

-- 
2.50.1


