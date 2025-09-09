Return-Path: <linux-kernel+bounces-808672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C50B50342
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F1E1C646EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326135E4EE;
	Tue,  9 Sep 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCne//a5"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0CA35A29B;
	Tue,  9 Sep 2025 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436801; cv=none; b=s4Kx1/GRa5tCmfXfGWit2GJx+fWwu5mFgrcq0QkRVJlRZJfX9p7McWy4JIrXPW286fNLOV6eg9PSaHLMd/Bf1wrKPDFNRWZrpDxWPNF4+P4D3svdVdX+x02z2SfPZSn1TQ8QHnelRWyS1vdjrMG5GD4KoZtO8k7MFK1Gy1uKUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436801; c=relaxed/simple;
	bh=3ngI3i1BG0C9azbqBN/4q7nJ2yCSJxmqD7ABvsTPKbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEQeyJ7M15UoSGbUTveEjPt+FezeANq1MquK3MyyNvOoAq1t/Qogk0dtPyuWaV2jELuQfjjzct8j2vHw+A4EaqXFq5j+3hUe8drxZFUtti6ftygBPv2wDPv3R9SgSFLX2f+1bnmQP4m8FJp1g/BMK5d1JtJdfzdgiyWS/ivw3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCne//a5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb5492350so38355555e9.1;
        Tue, 09 Sep 2025 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757436797; x=1758041597; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m97kyP3HTS70kAnw3EPRct0ZUapkHpzYxU+r81cO+AM=;
        b=gCne//a52umQfl2IhSEp9Ub/EuZXvWGbCx89sxNQXS5gqwWCkJNt0sRKHAN5i5YpaW
         z2WMD+5laz6VAT+kLM3UXDyng0AbUutETNAdOQ3vYSnneTzniLNwaMR8ZH2gbuQgFU3X
         NHbziM05Si4elmBkufG399UfqWQfPC88Schu98Qhu7KQnf82aWLE0p3jJXqAtPFIS6Qc
         cKeziDHH8F+JF/2L68doqbNB4eibFh1HEdh/DyBwg6HuOThvNv2uMxOY+frLuQ6vlGy7
         4w++SIDysdaJA2MsnkH4MyW1VGovYFWiC9y0gV9s/IlhyPPmC3w4/M5PaQy4wVtVxRO2
         LN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436797; x=1758041597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m97kyP3HTS70kAnw3EPRct0ZUapkHpzYxU+r81cO+AM=;
        b=wbdVvycSH8ntaqVjg+DzFVrcddbEgrRTI+jarB8bM5Kd93QXjQjWgoTtGBODAhLguz
         yFNcIkEi2JF0hf2UnIdXj5UaMkNvgfNB3gHU30LmdVZvjylerywbPAqL9lbhypiuGq3E
         MJTaLXDUKu0//NS4ufqmi4/zX6wIRdgtKMs3CrjqhnpqK8q/Xa809X1cfHBZ4aLuta6v
         UPsYEca+nOTVXKgAHnb8KJz8Q6QdurkSaIGwlkqx7bUB9EeDCLtWvHTe0SPZ6HwMG/0E
         OAfBCA4f36FUY97hj5pi3syPxzCPO6p+yT0EQajih+xOufhRD4hEn9TbqobMX9nknMmx
         Krlg==
X-Forwarded-Encrypted: i=1; AJvYcCViMkOczbVkLk5xdvEWS3CLobDKbpZ6LEWme05E6xRXdqRnkPbYQrotT+PE8WAAzWacKSg23UuZ0Egb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WykScCAuTO5hlaYp35l+JZuWhiTGHGs0L21XvHP66+9IvMbi
	nI91weo7EQQug8FpurPTDE+uIGU3wHUsvQ6duKWoRQgqP+/MjcBnJ/PK
X-Gm-Gg: ASbGncuo/46BUvpSjADatvhOgmIMJGiTPwNf1NVRmBGuksh0/1hfU3rkHecobzxwFfJ
	7SgIAm8KhzUqXio0nNTaed2bOLgiRxqRCg9eMw8f0CEm3tiW1yfB9juk5ws9GFJWroXIMNaRYw1
	yEVMpyWWIFIM/C4/4BQKyyDv+bu2VcPpuwHjh+7/ii99tjfmKk4n5ChH0Tnpxe4U1oBkuNIYRB2
	hxfK/Q4Lgvu5yNP+mjc4tSEwSQfAxoRp/TNoZS6lFAFU3TwkMNi42Boh5AWkT31WlstPfdGbAZl
	F8q1yDcL2H1FkdtyUyZReIRIMz4AZNRKOSGMYDUV6A8tFECUbCshM7fkYDzOk0c4h3Xy2tv+PYE
	t3hTiYjmQzrqCpSo9HsHCrJWrcbIpQmqHm2ON1hsLW1fFg6h6ZWKMBkg+qUCHdmjY
X-Google-Smtp-Source: AGHT+IEqBRl9J8D3sxXoUKww47Xb7qU0+nNIVTgF1/LB1fSoYc69LlXxBvnR0fTOpf1FSeIqKxSZEQ==
X-Received: by 2002:a05:600c:a08c:b0:45b:8a0e:cda9 with SMTP id 5b1f17b1804b1-45dddf22ecdmr100621285e9.2.1757436796956;
        Tue, 09 Sep 2025 09:53:16 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.138.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9ab7c7dbsm314379085e9.11.2025.09.09.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:53:16 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 09 Sep 2025 18:52:45 +0200
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for Sitronix ST7920 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-st7920-v2-3-409f4890fb5f@gmail.com>
References: <20250909-st7920-v2-0-409f4890fb5f@gmail.com>
In-Reply-To: <20250909-st7920-v2-0-409f4890fb5f@gmail.com>
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


