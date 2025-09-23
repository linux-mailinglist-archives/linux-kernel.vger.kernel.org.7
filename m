Return-Path: <linux-kernel+bounces-829400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F761B96FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CF07B3648
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020D274B23;
	Tue, 23 Sep 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/d4uUN4"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13A1E8332
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647670; cv=none; b=uloqllpCGHN8+rJGPs59NQUziD0yhP2yJG+t8d6w1rES2YPxIGOnBP3cjiGOmshZgYis5wIuDQEq8Jfpjx5idVx37JLDGs7LuKVJuifQDH1nmjg3CscwWCSBNawDAuXUjCOHRawnZ7TpDqjOtzKZb2r3p/V5y4XrfwMzmb5CgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647670; c=relaxed/simple;
	bh=Eq1AOZS62E3U426nVTK/WCGChMfD99wRr7zuaKWdzzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/45XjqIWZOTeop6sLWyPJDyHaknpqHS5T5OsKQLTPuk830gLVrB46ET0D2G2uXVzintvvqyXqzK+Bw5Kk5wqGkfpGQY/2CAMwEXeSvcpA/J+NDiC3z/9dwq+zqe9aM90sKhLdkbp0bX+s6IVp/476bvf6L6KVD+uyr79ws6mNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/d4uUN4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso8404660a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758647666; x=1759252466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXqXBnmiXImIakMVKpGGeYlSvR6C1NJ+HVUMvwnxdDk=;
        b=F/d4uUN4h2UHvet+h32/A9jiWw67ksJhqX7aMqi4CJkj0JrRvRXkU14ezj476DdTns
         0s1nyaLgt0X9YU/eHddqKCKlxpeecLs/lG2XCMrNvER1szzeks6UC9BmjEnh/t6i/Inj
         /5f2K/szSECXG62W2oiukiA1nKr+yOqeFALkuWd/G1Vg8kKFxfuRQqv2KKBibypozaSy
         sxM0/cpcozEXqPvrhGEFiHIGZZWg+NAvRhq1e1uj7w+WTB6nk8KAFm6BNFnZWkim/dDk
         pOWLqUwL6XaCAjYXsjj3SD6PnrhjowCr9V0o+2CVoLZdCzQBNBdr6K4VjQUlCMMtBHE0
         sBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758647666; x=1759252466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXqXBnmiXImIakMVKpGGeYlSvR6C1NJ+HVUMvwnxdDk=;
        b=ZkdNdf6klzAGB1I4s6B8OP/Sic4sUsg/DKxrUwWrgFeIS8CYWvlSWLFqTqTVmWb3uL
         QKdCaRGCAetW5rbXjyMB/lUdpiG4kW7VVO3IXnmm8OGsEy2k/EuiAjtQIY8uuEF/kLB1
         o6c5y3NBWOPKIVB+GjUq6j0I4cUamNoMeuCpsopink01QRUueebLGSLsYxGumTAzOgq7
         ghZqnBPwiQi4G7xKhJoC+GS9yFL1ozfc5A0XE+NMyNy5CLBTvh9H9RmJzMyGDJY4kPM9
         c97N+pbfmMmJswZZH/L2y+MM/IJddRKQHQot3NyDUUN+SPNzc6YQjA9Y9EEGWgrtjQi2
         R3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGi4i7JGPuliRZ3Fad0H+8eWcK98YJg8KBlgfCzCNN4HEAhDmzHMM12v9TF34XnaEPv1takWfMQ8hmF7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVv9aDj7C96D35qcpiKt4uXbpZbHqZLCqOmwt4yogR4XySDIbS
	yHWc4EiULCAv5Kfb9yDN9idVbyf2GKg4IUXuo8ImNSGRhnRYSuRlq5bV
X-Gm-Gg: ASbGnctLuEgcLjQz9Z1aP1UwSuRFzEV7Nx8fL+eMsVKM4Q/HatFF1Hcjo+mCPGJzTfY
	K+gnVPJxTM4E+LjQ4A5EnE7DK2yuTOJ9EDQAL9XSCwr5HtzFQ04R/1VEh6atTOndxJ2fAHbrlkz
	c7oSGjQk9BokF2GsHgoOkwOzWqRW2gZS2eGFA6RK+u/kX0/ojn10HioLf6WHPkV0jaLo0yWblAR
	hYNR87i4i6Cfdz/oUf7tljJ/rBKP4FU9NQyleVasl3cBYiJiERExFFjKvnzirpy0Os6BdrSSG+A
	OfdfohF4rVOvzmhDcIIt0dDyeHVeMABdyIEk9XAzJ1VgnNNqTeucNKHd0ZjHmbykxI6c5QDRZAM
	rwt4dDNMjB1WaK4I=
X-Google-Smtp-Source: AGHT+IGSyRbCpjt3M6fPL9Ny0dbed0xWG6GvMzBnFnctl3j3KrQXRZZdJVYOgLoC0uHRbRnhxPV+ww==
X-Received: by 2002:a17:906:ef04:b0:b2a:7f08:23cd with SMTP id a640c23a62f3a-b302b5190e7mr331780266b.50.1758647665932;
        Tue, 23 Sep 2025 10:14:25 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2636394d79sm1043812466b.38.2025.09.23.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:14:25 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH v2] fbdev/radeon: Remove stale product link in Kconfig/FB_RADEON
Date: Tue, 23 Sep 2025 19:14:04 +0200
Message-ID: <20250923171409.25927-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The product page referenced in the FB_RADEON is no longer valid.
Remove it to avoid pointing to an invalid link.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
Changes since v1:
- Dropped the link entirely as suggested
(See: https://lore.kernel.org/all/CADnq5_NHu5=esJZrgy_S80jF68ZapRRYX4_L70DwDDSN3VXitQ@mail.gmail.com/)

 drivers/video/fbdev/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c21484d15f0c..27639b2590d8 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -948,9 +948,6 @@ config FB_RADEON
 	  a framebuffer device.  There are both PCI and AGP versions.  You
 	  don't need to choose this to run the Radeon in plain VGA mode.
 
-	  There is a product page at
-	  https://products.amd.com/en-us/GraphicCardResult.aspx
-
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
 	depends on FB_RADEON
-- 
2.43.0


