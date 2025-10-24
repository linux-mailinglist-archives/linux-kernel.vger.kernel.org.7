Return-Path: <linux-kernel+bounces-868516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A748C05623
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49F13BC26E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B977930B514;
	Fri, 24 Oct 2025 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="dWr3lOSs"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191882FE04A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298659; cv=none; b=haYt8qw4XiR3uOAqi3S/8cHSHbmvZv7I/d18W+R7kKlND32b5gZfripEoN88dzb84oUFYbycuM0p5VPNI8GNe3mNMA9vVeEavYt/6QcBc0g+JcSUQQ/T2ol/PJ2nJYIrA+pbF4Om1lH7r6qlHaKBKjpof1hO5DKt4fIAmhLcSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298659; c=relaxed/simple;
	bh=/Cbl4n0yrdtsgnDtQir6yB7F4/rJakM2sUOcZ9UhiFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqYHQoieWyy9NRJQqTnG8D56Lh3hkWfh+nYFBiBDvg24jnLiTHj7h+RTArNWSfweDY5Iaei+eTjjhkQRrKXkhoeYVWFh8n+DLa8Ix38LLi8dSPudNC8NlhJjE0JEzqyuhpriZnopf1CGq5TWFLdMAOAtLUhnQjk/48mBNChA17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=dWr3lOSs; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so1347450a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1761298656; x=1761903456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TluK3MF0nWIoJUSNiEPuReJVhgVvccO24FAbWBod7M8=;
        b=dWr3lOSsaSdXQ/ArkM4UvzvcF3Og4kvW910aqfBu/ZcvAzIXDPSOaRUXJqchCtH9Uj
         YHvEcwFkx8cAtoBMmTzklwVAKlU9RkGc/OqW0lmjXxyhEoZAeGNZ5P1XIS4YPPZBhk7q
         8+do2MfqSfs+XQ9J/fc0IdBRWJL0omSngtfNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298656; x=1761903456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TluK3MF0nWIoJUSNiEPuReJVhgVvccO24FAbWBod7M8=;
        b=V9BVoN7QJLkpdIzPHT92UbIBOLy9AEXoebwpiEAX4wOjWoHBDmSo6yuKytpzWQaTbo
         pnqMJcCxokyFp1fMPX6XQH3UvlmN1ZDMWlJ67PoDZPMoI2DZYJV8RLD77tBkRnIQwqgb
         dfrUTunsTFo3wRfu9YVAuG1Odn94OPNtR1GHlUGYfG3GDzkopxnpBEDenZTSmVHplLtU
         8PIqeU0/dS7brb4c8ZdooUJN3RdFAFootnLPyoDk6+WcU8HrZVL9PwiOr/GZPisPeG/w
         GYYcT9PL7mY4xv+p67dUeBxA5OusgwV5LjNrv3wzaxVJAAUGeh65MtvdKOZ8oyD9YEg1
         BbYA==
X-Forwarded-Encrypted: i=1; AJvYcCWj98cMEB5srffnuhW0QgLCCzYYYA6ELFZNX6AOuRnfuAGVT3BaVjujlOOY24XVa8kx/0WXs2v4TnZSGKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+VOCd6owD6X7QsGr76Aal+mVrj9OTq3is0WVHZNeLf0cpVSK
	4T+xOinome4xjQTdczOrlzoPYhUBhjwA+tgJeR2pr646cteBXAYbIMTeD/X0niZyp8A=
X-Gm-Gg: ASbGncta9Ai0x7z6FsxpSvhD4eFRVPp1T/IdVgz1yZ/DUNXWrqRgNfpFB+TClshK/Sb
	+WiJYy8gkK5MFvB+CsOfL2LaBZ291K58CMcyXPfpSDt72xkqCOjTNsCGgi0zM3OjyIY6J6Ro3aa
	uWeQVx1ajodPvJXPRVUjNM5rznK91pDqzLfzWdtWUcyFCQHFDi6/iZmwieu97rmsdvVqvOjmU2i
	XePZ0O4uyfcDj5tkXZejwWj1wvmB5Y8LGXpy2g+FPeIvHtqjZultgx6kVPyQZUIEljQLC8mrx6W
	p30KhhIITb8uXSLkttTysS/rqK7jmK9PR264N5UOa8nF+k1yHUveLvQcYMsUzMNmL8VTZAzlEnM
	PgMkrad9RlACLBv72MN+1JBu3DzbqHMBLalfDV24mgEhh3kqcbd9OwsdWS/VV4SOt71QoqBFzIT
	HQM/Gdu9p2OzzGexVdhxjvKq+GYS1uIvvnsjAWO1gDdRJYRtGYCUYY7pfpP7Mtiw==
X-Google-Smtp-Source: AGHT+IEKtLA3XRvvshIlIg79q8hd8Y4gzZ4mZdxItUorXlFdB2qoWeLIZZW4BUstYBazD2NVXVoh/g==
X-Received: by 2002:a17:903:1a4c:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-290c9cbb12bmr378539265ad.18.1761298656100;
        Fri, 24 Oct 2025 02:37:36 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.222.3.188])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2946dda72d0sm49975485ad.16.2025.10.24.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:37:35 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de,
	linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] fbdev: atyfb: Check if pll_ops->init_pll failed
Date: Fri, 24 Oct 2025 18:37:15 +0900
Message-ID: <20251024093715.4012119-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Actually check the return value from pll_ops->init_pll()
as it can return an error.

If the card's BIOS didn't run because it's not the primary VGA card
the fact that the xclk source is unsupported is printed as shown
below but the driver continues on regardless and on my machine causes
a hard lock up.

[   61.470088] atyfb 0000:03:05.0: enabling device (0080 -> 0083)
[   61.476191] atyfb: using auxiliary register aperture
[   61.481239] atyfb: 3D RAGE XL (Mach64 GR, PCI-33) [0x4752 rev 0x27]
[   61.487569] atyfb: 512K SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
[   61.496112] atyfb: Unsupported xclk source:  5.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 210fd3ac18a4..56ef1d88e003 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2614,8 +2614,12 @@ static int aty_init(struct fb_info *info)
 		pr_cont("\n");
 	}
 #endif
-	if (par->pll_ops->init_pll)
-		par->pll_ops->init_pll(info, &par->pll);
+	if (par->pll_ops->init_pll) {
+		ret = par->pll_ops->init_pll(info, &par->pll);
+		if (ret)
+			return ret;
+	}
+
 	if (par->pll_ops->resume_pll)
 		par->pll_ops->resume_pll(info, &par->pll);
 
-- 
2.51.0


