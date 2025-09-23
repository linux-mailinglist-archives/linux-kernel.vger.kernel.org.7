Return-Path: <linux-kernel+bounces-828630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9CB950D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFDB1902079
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F131D393;
	Tue, 23 Sep 2025 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEYP3n4S"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF02EAB61
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617039; cv=none; b=QsLMY0ZmfM6cVaFrh5RP3t8Q5Vf7v5fWl7DDoC+p9CkEbmYOW1pAF3Dghv2/CcDXnvESeivdZQU4Cl44W9ZLhQrBKFERel95HYw+PrWyZMr6JWVuE1f/olLx6L91g7K1aQDqmbX7g2yFqPsKUlfsXYTiq9xFOeGtc9fgV2tw04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617039; c=relaxed/simple;
	bh=gy4uqxOCIGLwvs84h8NOCEWXZqQgcCRkqfRUYk238eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWiMJXiyKhBHm5jbCTfjvmKVfckbHn7sClSt5dvOBLQm+ndwWcncdAQamZde7vLQsP+u7Cgpw+JrOwUH8+nBECVfifxifdPWSW2TOXb/le3jQ1GOxOcGPpq+1UMyND9QWBfpQQ+9GDNhU2LAgwGSrZHteStSqyrFL8eVIBCBzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEYP3n4S; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0787fdb137so809706666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617036; x=1759221836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/mGp4D0/N7zj9lqu2hqSY2BaksNmyzuS6a+IwtNsiCQ=;
        b=gEYP3n4SnylJ6HmgLWL4EPmvr6WRgIuhlPf5K2vcl4Ce7Glm/itR9cPjv6/GdXk6Fu
         6H28K+0qOZ5wU0gpHf7O3Qox/eUrk66lozP2EYmY2BPI4u93mundKgwyga3mxoPw5VAe
         EoAs9tPOpiDl5TPDz30VlDU6M4HRBPUkKpGVjr1lNvME5sfjbCppZ4qJmUxqZ0qPxVtj
         KZ6STeMGCfDIH8OiTuQF4fM612dbjNx749DfXj/tYIdcBb/W/4UdSK9xqnp3fX2FDuZQ
         Dhd/jtGhNMHWsYr3Z8vNanPNV7OZogODuY+5qOuQfV1bjDO3mxR9jNEqKXg/lKu2nPgw
         UMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617036; x=1759221836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mGp4D0/N7zj9lqu2hqSY2BaksNmyzuS6a+IwtNsiCQ=;
        b=plEaZHxH1x723tjd857CTKQFMojWn6/MQ1UZ7qvqKMNGtIPyepg9+fNkscRkzH1+MQ
         oASljI8feeOQF8zPFNXXD+Dio8jN3usjmFfsvPG9IjGQKo1siV3hTKpcxAD15kScJH9D
         VfX96BzkXwUFf132ahRLpaxOH6VhlmN6SkPrvISPd9fdUUe2RBHEFHlQhyI+5uUsYCSd
         ZyabtLU3p8C4FtrxbNoHIigDbkMZ3/EQXQc+IC80XzYAD+6QocPHyWKhHBS7pfFtGHDJ
         hBYrtTkOKDgRxf0sXJohvSBthqv/mZd76N8JPwLJmPSaszoEmgKXOc2eKdoShaL081uZ
         LjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2fKCsT13rde2nXW0hfl4jIQJEk2GqdjSpcYHg2hcPdgp9XcVGR/wqg/NMXZnYr4VrqJFgPzrXDHhM9g4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1B93wElkXVM039hMELFD/SPFZK1R6Sifufwml2TEtxpMZGmCT
	6ZxPGhpQthDtRsaZENZ7BET+KfrLqQ+2Od+HW5lzPn9qgMPdk9NonwLV
X-Gm-Gg: ASbGncvlLmukYWJM2UoJj925qWC7lnRiXqeOkf/XBC5BIz2/k8j/UoCk6t2Yu1fU1Pm
	lmQYjBhQnj0xkjsp3/vZy5Ln6DK+eWprquYiVTcny+4IQrbpHM2UhkL+eoKBbfNv6XIXW+KNdtO
	Csd3Wia/IVcfLzjszU5wQo59B+XzlFQlqFaJLP+/8e7MLQbowaE+Jb1QqR8pd8Jhz2M5kv6PBNz
	sout2MOIGgzH30jlgz0H284aedjC3kMWX2P93IAehdVOJ8aEg/9s5qnE4WZqAn1pg2d8aqBcnyD
	bnls1oN4V2MQ77CbheQry7sek5whrmoHuyuWMWBhrD/T3kxaM4+rvgvCLtssnFKTiFLi7RZtMNt
	JZ9KwCqbq2OmJFGg3e3A/Uz4Vug==
X-Google-Smtp-Source: AGHT+IHZf6TnZmvJ/kWnGmv0GcPcYtIPGdUTBRc/Tnmg6bn8o3PfdZRyuZLiArXHvkr85ZYF6HZWCQ==
X-Received: by 2002:a17:906:dc8d:b0:b2b:62f8:e490 with SMTP id a640c23a62f3a-b3027a4ace6mr168920566b.27.1758617035386;
        Tue, 23 Sep 2025 01:43:55 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b261bdfe8d2sm943936766b.58.2025.09.23.01.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:43:55 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] fbdev/radeon: Update stale product link in Kconfig/FB_RADEON
Date: Tue, 23 Sep 2025 10:41:50 +0200
Message-ID: <20250923084157.11582-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous Radeon product page link was no longer valid. Repalce
it with the current working link.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c21484d15f0c..3037455adf48 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -949,7 +949,7 @@ config FB_RADEON
 	  don't need to choose this to run the Radeon in plain VGA mode.
 
 	  There is a product page at
-	  https://products.amd.com/en-us/GraphicCardResult.aspx
+	  https://www.amd.com/en/products/specifications/graphics.html
 
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
-- 
2.43.0


