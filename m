Return-Path: <linux-kernel+bounces-865204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8DBFC7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729A918C4054
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623EF34DCE9;
	Wed, 22 Oct 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UucIpg2n"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796734CFB6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142901; cv=none; b=ITGkP+AT45PN/X11vzACfxdc/cT92J5XOuv6D6aGnRQlik+ggfnWgz2I3ffnxpqK0PGn3DiTfm+5hLRw8oRHeDBghY4LUWG4Z9hxqvUZzxlLqmfSgQgqWBJrwSBEiIoRVS3b8eomwI6s8IbjEQ0jqqyQOv+mHGiij+Pe9SLYmW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142901; c=relaxed/simple;
	bh=unhDWU3j7HXm8tKnMiJwHfKNJbf2ZhuKuePm6ASfLQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFjXB4/wMRrtZPTBAFhLR97UVahFsRLd8+EKYCrNA566pnKvkLwqjynZxZxKRkGc4VjZNXk4+AS8JV658hd9BtPWZYDy4Hjvo16vCQr+lKLjsPNiDa2j4iY64RFVnmH6TYsp8xWo4c1GMMuPm2AeUsjMxEPbRTf6ri1WIcjoYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UucIpg2n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4711f3c386eso36399405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142895; x=1761747695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAO9OwRfZdFmlMl3mS0tub2HzSBi7qv3ODFvIZHKgFU=;
        b=UucIpg2njXrElxJXn0QVRH13QlN1mvRoiWg0ERm3uZvdhE50xg5vLmw3mwWc3qdkcp
         WjqWpoE0C3UDFjRfOuMJ3Kcek05+mnxMAuVWw3EwVEOMx0vRm+lRuk+zfxlTMsLsrxTB
         P77z2S1TPqGH/CAH60uPaRBO6QrbIi3e2CV1XXiRE8ug2ZABlinb1BMlLFE+KP8mpPMY
         nuSqvCckxpnXWdzgOHrkI6q42+NtqQReoIWMrWdcp/2vGf4+PKGVH4f2/HG2TXpDmA6z
         aq49WcEjPYH/9QzJdcshTXkIVN5GJZg4VB6lHuYFQKf4a/aJjIfZb69Gy77RDP3gybA8
         o/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142895; x=1761747695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAO9OwRfZdFmlMl3mS0tub2HzSBi7qv3ODFvIZHKgFU=;
        b=DfPDDQaX7tTxZqqtf5CFDk7SUcaTRlZ58Xvs1RUvQuSmESlxMe+/Tllnga/27x/O10
         peD7sOiZWmjN+OcULcjgDrWWuPnyneScJXRKKSFmROm68XoUQL94Z9ZKbWdDJeerCBXV
         05/xYB50Qu++d3swdESlDzxYym/PJi0F7oKVH09KfDE6dmf7U55EjdROym/N2KNotfCP
         0wOO0gXiVHyUcoHz5qoeNSkaIrz3thOCuT5ce5km9TJ5A3njjOkro/NA2cV9uMpYnQRB
         Kp8e87QKN8DDletoWDdFGsYyPslZsp8QfftrD6AEMZTmy3mk/tOOtHQYxAscgdjc66fK
         ZzSw==
X-Forwarded-Encrypted: i=1; AJvYcCU417duspKXUkmW3W93P0f7WnqXFYwEs996nISmG1EsAMUFMRDFEwjyWOUBAFMBKdU4HaZ7qnb3rE2uj54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+PHs4Cb9PTdMizPDXqGnCmMDm2wLS5EDeh7x4KUXqIp1+6AZx
	IUdqL1cJvLoMdmPA2ier58YnsgAEMjEMv2zCsYkkSANttJpSxhoxSI9j
X-Gm-Gg: ASbGnct0UU+FeimMVFfSkO4WkGIzy9jLI5PsGk0E5LlIqRxUlSwjSqluzinj1YXL86C
	c8SFMvJzPGCLvm/lwTE7ZfOMJGcau2bDqZQPPuI1fnRPIe+g8rxJPAXaPFeMEHzySFyR0A3qP/2
	dSpUgq9uy5SyO38JEqDXbJ0QMhOw4v8Ewvdqwf9OKGdDJRS+yLQIOv7hgaNjQdBmK2x3OstimOW
	dxeIHfEogb/t0cmR+zGq2MQ20xqHfyOWRzyc8C3kkAuuVws09+JxTtI/XWzKz13R8X+3hHQo6iY
	dTmOFUB8zQKggjhxuN2wLp0d/K2R16n6Jj7AaF5DWF60ytYH6eKWxtjdlJMkmNeSPXMaacFGC/w
	PFKKqKuh2yzJZJnlO11t/RXHSEYkhyZx983J19QkxlWa8P05xI+N8G6BaJInZHAAMHiI+JvcTyX
	BJAQ==
X-Google-Smtp-Source: AGHT+IGaJGEihzS9F6fnNyhHVGRwXCsOXdE9dlWNhp4wiYwBqGQCgmFf5u4C0KR9SkCEnEJDDokDBg==
X-Received: by 2002:a05:600c:8284:b0:46f:b43a:aedf with SMTP id 5b1f17b1804b1-47117925da1mr126433075e9.38.1761142895124;
        Wed, 22 Oct 2025 07:21:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm24803518f8f.19.2025.10.22.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:21:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v5 07/23] staging: media: tegra-video: vi: add flip controls only if no source controls are provided
Date: Wed, 22 Oct 2025 17:20:35 +0300
Message-ID: <20251022142051.70400-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022142051.70400-1-clamor95@gmail.com>
References: <20251022142051.70400-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because the current Tegra video driver is video-centric, it exposes all
controls via /dev/video. If both the camera sensor and the VI provide
hflip and vflip, the driver will fail because only one control is allowed.
To address this, hflip and vflip should be added from the SoC only if the
camera sensor doesn't provide those controls.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/staging/media/tegra-video/vi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 856b7c18b551..90473729b546 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -961,6 +961,7 @@ static int tegra_channel_setup_ctrl_handler(struct tegra_vi_channel *chan)
 	}
 #else
 	struct v4l2_subdev *subdev;
+	struct v4l2_ctrl *hflip, *vflip;
 
 	/* custom control */
 	v4l2_ctrl_new_custom(&chan->ctrl_handler, &syncpt_timeout_ctrl, NULL);
@@ -986,11 +987,13 @@ static int tegra_channel_setup_ctrl_handler(struct tegra_vi_channel *chan)
 		return ret;
 	}
 
-	if (chan->vi->soc->has_h_v_flip) {
+	hflip = v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_HFLIP);
+	if (chan->vi->soc->has_h_v_flip && !hflip)
 		v4l2_ctrl_new_std(&chan->ctrl_handler, &vi_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
-		v4l2_ctrl_new_std(&chan->ctrl_handler, &vi_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
-	}
 
+	vflip = v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_VFLIP);
+	if (chan->vi->soc->has_h_v_flip && !vflip)
+		v4l2_ctrl_new_std(&chan->ctrl_handler, &vi_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
 #endif
 
 	/* setup the controls */
-- 
2.48.1


