Return-Path: <linux-kernel+bounces-879786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D9C24068
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82FBA4F126D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4B1330B13;
	Fri, 31 Oct 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPZsEXln"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555CB32E755
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901544; cv=none; b=lVfw2u/Y81AnonFnXoLZMyUptliDwyO/ZrwmnlsaxIb5PEjaAemwycP1p4C/kNo7lOlC3LSDt/XR8J5R6WAW/SqLjhuko26ARMu/peqHYlNBvJlxjmu6cBvwIJ+v13UhQBSdHWaruXxbgro9+aR0vQoq5wWXunROStOFepV85sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901544; c=relaxed/simple;
	bh=3ngI3i1BG0C9azbqBN/4q7nJ2yCSJxmqD7ABvsTPKbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7MEWLwrYIygKgnVL9T4MyJTKAzApszflvMLsUJlIouD27QLQjdRCCpaTaAjfBGD+K9NSDZ6emSsviSjOV+FJick6p690wqwieOcjRHB1UqbvVTo4ddj2wnjaj112beQ0Tm9eo1VVOidfwgjLMDcXNXpLgVS2LfkAO6UT9PdjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPZsEXln; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so11108095e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761901541; x=1762506341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m97kyP3HTS70kAnw3EPRct0ZUapkHpzYxU+r81cO+AM=;
        b=KPZsEXlnVmIZuIwDkpzhvf+Nnez81AXn7aDwJVAyvcTzYtE3IjUfgw5IGQbMc1W4p9
         iVbX/6DOnCKWDbjl64BkreB5ihQVdS7Q2kUh6kx3Hy/gra7RQ2gQ97fAdsxRVFDS20UI
         p2vcv5a4/xSyIbVWDuS+eW2a7oqtQBCBiX45zaVFfVNi/afiiD8rbSaf8OB7JltOzEtn
         DzUjsJ3hTrpID4P/qoAk57n+VHagqMlG0Mbkamihcp4QL3bTONzYcxPHH27S8srR6ZUR
         3jlFPfEPaI5LRNSPR+8q8cFFkC8Pu9Jm2upMZ0Md6Yp1ngtUtjowUZox0LPEGz+YvSkR
         GTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901541; x=1762506341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m97kyP3HTS70kAnw3EPRct0ZUapkHpzYxU+r81cO+AM=;
        b=dPW31Zvd5epj7OlgLt0rc2hMB5KbguNoLKbdnrEKWrZOMY5SvJHRfjgPbnZNEb8nxH
         UNjHghpMGBl8rBKYO47UIUikT002MNtf5ccnppEs9OWancd7unOzB6yunUQ7PrzWlaLm
         q2GX6s70LXoyiUKPxGPL0oMF8m6XQXub8+04QvqM7jl0F24GyPoZoRr/cZSPivyydaGW
         KAmfd3M+6ZnMpSESaOWLzVwRe0b9qqfCmLDMHGLEGxFvTvFasVRWASuT8g/68wxPu9cV
         QyyoyAIZ7t2+0Qx8qXX5FsOUDV4HaUpFO70sRPQXckoBY4z/qWE47fuP0ABznpLqUy4o
         B0Fw==
X-Gm-Message-State: AOJu0YwJ/SoZIOxm4A6Qcb6Cr/mKpA8lIoie2p9Yws+MbvgOSTst//7Y
	3yJbF7i2DciwPvxK0TTWBW9m8CD3ztM349gzBSFKLXoyYsX5CSpD3kHK
X-Gm-Gg: ASbGncuHFTl8MVMADLIRpJPy5SWx+hDvIqbZ9UXGJmkY8wixgr/eEBpvC1xSGcRbM1Z
	s3xgKGco7y3nSJpTp2Kv2lE6ePA4S9zrPA35GTnwc7RXud3Cb6E9bUw7QRxOxARJbNHkQOo0d1V
	iMy9hEzE0kksw4Y97scdSZ19Iucrk341npcFmSFGAq+YomHsVV+dke3IAzajryLQAdS1/OK4XqD
	i600ajlfxRj4Ku8zcX+WZUFj2V+1g4QLzz9jtLJ69HdcMuNgavJ5l+QJofcblnalwHodJFfDFVx
	tD+mdZxq5ONbJvhTaeLwV0JY48bLCqtTMhTBDOU+28VfWaCLjUq6SJkFRoJ7aIDauLmgLF1z4tT
	vTd+pf8KXD259JMAtLUniyeWT1Bn9473mk8sDUnnT/z6UNPWynHqlykmHauB5F8R9RaeBJ+jNxD
	ZfhnWVUuXDukpkj1NuN5X8kNwyrEeZXaOgzW1iDH6KkNcg5W9sgRYX
X-Google-Smtp-Source: AGHT+IHaEdfxWwYT2zJAyLRZyUAgi4BdK3quhN7NkvDh1BylxO25NofIDcQ0FfuX8++X59NClzV6hw==
X-Received: by 2002:a05:600c:1e06:b0:477:1be1:9afe with SMTP id 5b1f17b1804b1-477307b879bmr22506295e9.9.1761901540395;
        Fri, 31 Oct 2025 02:05:40 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adaf8sm93454475e9.7.2025.10.31.02.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:05:39 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 31 Oct 2025 10:05:19 +0100
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for Sitronix ST7920 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-st7920-v4-3-35291f8076b2@gmail.com>
References: <20251031-st7920-v4-0-35291f8076b2@gmail.com>
In-Reply-To: <20251031-st7920-v4-0-35291f8076b2@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Add Iker as ST7920 driver maintainer.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ddf37f0acc960039422ef988cadfa7176972fc5..79b8a277e38b55ebcff05450d6c565c0d87c6b51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7861,6 +7861,13 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
 F:	drivers/gpu/drm/sitronix/st7735r.c
 
+DRM DRIVER FOR SITRONIX ST7920 LCD DISPLAYS
+M:	Iker Pedrosa <ikerpedrosam@gmail.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/sitronix,st7920.yaml
+F:	drivers/gpu/drm/sitronix/st7920.c
+
 DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
 M:	Javier Martinez Canillas <javierm@redhat.com>
 S:	Maintained

-- 
2.51.0


