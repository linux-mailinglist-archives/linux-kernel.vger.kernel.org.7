Return-Path: <linux-kernel+bounces-783542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 389ACB32ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1001189C6E2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3844726AAAB;
	Sun, 24 Aug 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l46VhBOe"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A18266584;
	Sun, 24 Aug 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027663; cv=none; b=l1V1MWbrYTV8G2aLbFxRXRtYi3rkFBb3vjm33FUvMC3Y08JP4KiJ2b1xPy771IREYNItgNuPWlLzkCdRP+Uzun4I2BcZKFIGUVNFz2W9Hr/ULUFUvqMvI+lBXkrDB2MljJbCYNrq0rRm9/xFgAYkguf3+WKzPMUnUj8cVcGdebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027663; c=relaxed/simple;
	bh=CGhXW5tXeDv53QOS8bvvPoirWCGA2+4uVX2vcW7fVz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIR2vjl7zRFx8acQcI/deLLIwi5lFwFFhWHQFzmke3c1bdDzAFbbP3zOsmW34eEurOabseCqKPxGC07vo3vBRP7aWr75pDftCUNcTXWsnDGAMXw3mnIZ3yUjdzZBf0OGLVtWRiAFMqCREFCxst1Pj35vKMlzOy0w7xrn7gMc0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l46VhBOe; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c638ab6c9so15627a12.1;
        Sun, 24 Aug 2025 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756027660; x=1756632460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QAnF6RQJWxSSGLUa+yOoR8YIWrn+p1dbQGhI+0L21k=;
        b=l46VhBOe6Hce5M3iBb1ZmeOs8JE3TxCEnXNgpVbMoX+FJURdVFijoPBciDs5AwUlyp
         OnJhNIKfKwIgcAaVmDRdS05XfgB/WGRoUvOHrKRtWrhEFF+B5119a+Mhbwv1DNbFdNhZ
         5oi935PPIWc/n/RTy7ewViHnT7Y5A3QTsYaJ49YIPGZgvHm6+RrewMESS1fpsNghjUBJ
         u1B1nHUIlrBxE9wsRd7mC1arjc7qvuX+1s/xx2jBxpvnw4bRRoGVUKZEgvr+wWnlSp+m
         GeYSIoWXs/dKYKcgfsO7ySq41eBIZQxDhsYaZT7QvifZZ74IyPmjuNmXdqF4sKq3TmPd
         oZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756027660; x=1756632460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QAnF6RQJWxSSGLUa+yOoR8YIWrn+p1dbQGhI+0L21k=;
        b=tlAK+Hwpa2gugE5G8pDyveKSz8KpgHEEnhJ7WzyggwzvvPH/hefZGL5NssLi0NQHNu
         RfdHAWdCmWQMJbGV73RSOPDU/4fK0YxNtbP7Iopx4Tfaf+9wqzRcnJ8pNsDQGpzVIev0
         K2WbH+ny9qXK0sL69izsXrIHKK/yrEigp7qUtx8KThbztOaFzA2HPZy/r3lS9s2Ra40I
         Q/Erzt513C/NSjm6EpSvVxbS7JhUm93EsSlfLmkMYcdKWQLseRY6ApaR4KXL+JD1DNxz
         QfmXTtG4mvpOW/QejVoNwT7xNhhPYQhxvqITUOF4DxNDyZts5ImgKf95WHXAKz97YWCT
         cVYw==
X-Forwarded-Encrypted: i=1; AJvYcCUXfxm9i1pD9No9EsTac6pDMsNmT1eyFdIKV96YLwcXq4IZ/2VSURBAJG9GsmiQwuGLHyogw2JV8N0xDuY8@vger.kernel.org, AJvYcCWp3P/fCLdcelwU+L9OXrujyp+q7gY/B68GY7Y340iTlLSVdNN8HV2B6j3ey4TjpyzhOmloTWKpSw/N@vger.kernel.org
X-Gm-Message-State: AOJu0YzZDWFHm9d7Uo7YSnwcsg/Fubr9ItLrg/NQe4kb/9oNknzmOMom
	+E3zd3Rhdm6EYRwXizIBFhQslQkT3px0NfJPqJT7WRa/P9R23cr79ZsB
X-Gm-Gg: ASbGnctpnlaVx4o1nzqttfaNbA1y9WLdZQ1YZojlBQ1/sc0L98Luou/TEVkNILWV1BX
	lX1oofhKdCZb0Zt6UssV46kS+sS9DF7EGN7FVr1nzQVVmf/wDatV+QLK8T9QMpf5+YjuxfvKdvg
	U4C2c5wySWBdTUSWcSoQ12TUb2Nf1lsQfYdOPI5JId/EU5nRlX1rLJTgbfUJzII16o5/dg+CDDY
	8Qa/XoP+3Z3SBbWqbCPKKFLxCazaHVTo7ay6yoUWaowYyAzCTGgYPgBMBgIZrBILt/wbfFKXVlx
	It2JA3h3P26VYZcsmoEWTfxN4BOXInEZQyK1y+/Hmoc0vjHBiuFAM/yycEgO69tDD2wIFJ3gvyU
	VZn51XT4sDJN3QaXtD/H8hv8A
X-Google-Smtp-Source: AGHT+IFRDj2zIEpy57OjDTZdxkDbqj2s6MYrtw/nnV23mOyecpb6Y/xhuaCvm5jFN32fJDOfIoGI+Q==
X-Received: by 2002:a05:6402:27d1:b0:61c:5272:a739 with SMTP id 4fb4d7f45d1cf-61c5272a7e4mr1604664a12.2.1756027660198;
        Sun, 24 Aug 2025 02:27:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c316f503dsm3035391a12.31.2025.08.24.02.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:27:39 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3 RESEND] drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1
Date: Sun, 24 Aug 2025 12:27:28 +0300
Message-ID: <20250824092728.105643-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250824092728.105643-1-clamor95@gmail.com>
References: <20250824092728.105643-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Schwalm <maxim.schwalm@gmail.com>

A simple HDMI bridge used in ASUS Transformer AiO P1801-T.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index ab0b0e36e97a..948300378cb0 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -260,6 +260,11 @@ static const struct of_device_id simple_bridge_match[] = {
 			.timings = &default_bridge_timings,
 			.connector_type = DRM_MODE_CONNECTOR_VGA,
 		},
+	}, {
+		.compatible = "mstar,tsumu88adt3-lf-1",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	}, {
 		.compatible = "ti,opa362",
 		.data = &(const struct simple_bridge_info) {
-- 
2.43.0


