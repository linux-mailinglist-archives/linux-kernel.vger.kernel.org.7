Return-Path: <linux-kernel+bounces-878342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF84C2054A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAA23B66E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6712222BA;
	Thu, 30 Oct 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LG69tbqm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92241A9FB5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832007; cv=none; b=gYZLTQ9bVh4fNCHXNBYVSoaYYQyoe25V6I2CaUKAWUUcmgftLDKyhM11mYZgq6wa47oK+Abma57D6+OIiikA57lv5yNAJkM2J8JNs/8tnncPyCfqh4zX6xNSzJiNIPV9FHP0IYFjv7GZ13HaFVH2lRMFJ8SeY1k3PImq6iVG9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832007; c=relaxed/simple;
	bh=m/qQ+Ye47boxFRojPi93NDRLf547F5zOAg1Vvu5tBSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGkSwzvgyuv/i0LJ7L+L2Y6bUohuFkoAS9/fNJ75U9IcpWQk6LyU7LaY+4JOQ81FfczBGx2YOXJDGumSYZsIV1+vFr0RP8yO6Sk9VDlentLmYQ7CjD32qdvSQG2RDooD1Xq7PKeO1IjA09HKZNF0GVlYCAVQP4kVAYJZFnAA07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LG69tbqm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761832004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qXVeC5x4UjvdpdxBQtQYDv2PCBr6tJQZhEasSYJVqpM=;
	b=LG69tbqmsarS0cLiVVpoSmkrdr4Mfij6gcKGsrrRmkDxqBmMvnl55TSvDTTp2U6GzI3OHv
	r39v27r/kM6nWlhQFPlmwhnnalkiVojDql6jnXiNRTuY4H/dsTBUKBmgd0MUFBhipRjJdH
	rrrHaEH4YykmbcOyWibFPf7Sviw3RpQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-LglKcT9cMkue1q25L8JxlQ-1; Thu, 30 Oct 2025 09:46:43 -0400
X-MC-Unique: LglKcT9cMkue1q25L8JxlQ-1
X-Mimecast-MFC-AGG-ID: LglKcT9cMkue1q25L8JxlQ_1761832001
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4283bf540ceso595703f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832001; x=1762436801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXVeC5x4UjvdpdxBQtQYDv2PCBr6tJQZhEasSYJVqpM=;
        b=s08sCTE5aJkuYKHUkAL2R6vZS5JKWz+8wqnQQ9XtEReVuXGJlkpoLrkCENlwBbcUWK
         N0s6ANeUQQVzrsvuGN1w92WUy7Mf12qD9ifl5aI7ecuJ5GKmbW9PZdjz8XUsWMKcasm5
         Tw7e4KAsEq5DJVrvA+f1OqZtTuXjophoEvqmbXwSyVtCckDkgF2HRpdl2cANvSzTRPZW
         GimrwiqeR3MVsht4HAn2arzbdMuuw0/vI0TCYFygZmit1vJp49S3ZFBbBhK7Dh3vDFA2
         oyPjaHjeo9p+H3FlwgV0PYRYPZBdAjy1qLi92PBQOBQhuLlcii4aH58Gr+12h0rMRsdO
         yQfw==
X-Forwarded-Encrypted: i=1; AJvYcCXUGuzeFLnP0jiCYQQ7zgXcjvYRHK6NYWZZDJRW8zfqhbw7xWwUXWW/Q14DTS63ZxJMNM7pEsU1BJjvytE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLHWKJPxG5Vr1AvnlyS16Wqh9D0rIdgJOpW/wgCOj7EjZIjX4b
	sm+UGH25CN/pWy6YLudbDtV9S7Jpv/8xVB+CIQjhG10c2mCCW++1sBwz7E0qfErZYod4pAhhp5F
	WF5YbaZ+7vQWYyni+AmyxDpK/W6f0gfe90/TOxsox6SzslBuSk2SwAMNnjLSeCSIB3w==
X-Gm-Gg: ASbGnctu2pkQk8dDxU/SLvxGRNgfwaUREDPUE/G6nGTRoG9naOwhsh9gqZUgLnthKh6
	ya/sro1OFM6+iBbs2AEotkFlknyXwEM9Tj5FaTYIDLac6lT8GX2+S2tnisdV3DDuVssTU4P4uzC
	HtNyqswPC9H84Q6XbKKD/VyliZWfSP3F83l4eCedAcTydKh8w4pQjc3XOl+EAD4gE1PJR3AGrgp
	bSjl9vGopCJLfxidyWpWeVjGjTVPapCcEEu5bwDvzNpdzd8yagj4tUgB/eiJ/yxDQ17RI+mBqLZ
	Jv8EAdgVKSrriBgM+fCX0EvUnduGv11FVShrozGejog0K2vOESDsuycbbuVGX9CMlChOVNOxpw3
	hxPohqdJI6/R+IvpeWvrlyczFqWcttCAqhmnCnOoQJPArzWmy
X-Received: by 2002:a05:6000:1786:b0:427:6c7:66f8 with SMTP id ffacd0b85a97d-429aefbdf05mr6876972f8f.52.1761832001287;
        Thu, 30 Oct 2025 06:46:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/4DJxIB6GKcBndXz26LErjJv4VyAkibid3kK/z0tZJxHwuSAecj/C6Y3Ult2UaXNcOJzYMg==
X-Received: by 2002:a05:6000:1786:b0:427:6c7:66f8 with SMTP id ffacd0b85a97d-429aefbdf05mr6876945f8f.52.1761832000863;
        Thu, 30 Oct 2025 06:46:40 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm32483487f8f.8.2025.10.30.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:46:40 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Tim Harvey <tharvey@gateworks.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	devicetree@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in TDA1997x MEDIA DRIVER
Date: Thu, 30 Oct 2025 14:46:37 +0100
Message-ID: <20251030134637.134024-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit c423487bf667 ("dt-bindings: media: convert nxp,tda1997x.txt to yaml
format") renames nxp,tda1997x.txt to nxp,tda19971.yaml as part of this
dt-binding conversion, but misses to adjust the file entry in TDA1997x
MEDIA DRIVER.

Adjust the file entry after the conversion.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f7aa6a8a9a1..4d739e18aab6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25233,7 +25233,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-F:	Documentation/devicetree/bindings/media/i2c/nxp,tda1997x.txt
+F:	Documentation/devicetree/bindings/media/i2c/nxp,tda19971.yaml
 F:	drivers/media/i2c/tda1997x.*
 
 TDA827x MEDIA DRIVER
-- 
2.51.0


