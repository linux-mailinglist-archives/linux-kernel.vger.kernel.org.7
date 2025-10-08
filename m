Return-Path: <linux-kernel+bounces-845263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A7BC4328
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644303C6F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39652ECD1D;
	Wed,  8 Oct 2025 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRHZBPFu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C412BD035
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917082; cv=none; b=U7+1MYNTZ3bvanlpR9sfDbjCUj1+iGT9Hw1kzpeSN/7Bgyca8p6p7XHsWZmTktdJFpZVwHAFF+6+VR9SiRW4xUZTJHumYv02D6wsnO3sXPpNVlbtGG8uv2OmEXO4CoCw0mZjhdnVfkLKXLMDGC0qCupYhC1h1wEDNjTEx18io9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917082; c=relaxed/simple;
	bh=x5nbI9AkIsrsiz0hS/4vrtpxaRXtMX8vw+zw9R23U8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmIOBgAgkG3IC+EGs0g5J+hMgoQzyL0UnFBgghjw0460VShXwzgIKi5IhDj1PJD9DzrBLgMvgtMbUU0Viamxfoj2xMBHZu+LJm5f68/3MAenDANWEMd52BKVT82m/W1CuG7/H4GXwvoEWokECW5qiNU75VLyLP5iiyC0eu2t17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRHZBPFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759917079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EYv27Cm4bmfghZ2+pFJmEaAynMMJr8WvQrLSP3odbZQ=;
	b=SRHZBPFuWM3Zr7MHxHohQ6+jol4/hPk+wILXG9p6y/HCgMRtX8rAREXdTDSC4B31VLrYwX
	8+a51Ct8o7rOXEBQ6belibstzffPKENXCt42mm0UBDwU7fsq1bIfsamhRanNcu8/UmTeEV
	sl7MvyyJ6DHF1XB1pPgSpry8WshZtr4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-ImWfnLN0OHinoyBkO0vhoA-1; Wed, 08 Oct 2025 05:51:17 -0400
X-MC-Unique: ImWfnLN0OHinoyBkO0vhoA-1
X-Mimecast-MFC-AGG-ID: ImWfnLN0OHinoyBkO0vhoA_1759917076
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso3795961f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917076; x=1760521876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYv27Cm4bmfghZ2+pFJmEaAynMMJr8WvQrLSP3odbZQ=;
        b=bOz6T4MEXjjYeKnTx4+GXqmAR3nLszxSLFXAg49kyJ3uMumLUUp6Q86tM6txdILDoV
         OHrIA7JICj0u2PnXNV/kHvcoZo/QdZqhMN/zrMfXohJRS/BxTyCJwLiescQ/UrV99KEB
         PQ2TQ4nDQ9Es9As+NpVjkxklZLBPevS/knbFFxGgLWuOUgfyJ5qbc8b7uLAW5008BMdt
         YdWypM/ME0CcOGY7+FRA8rAeunCbOLvie62kapvlPM8VEcC32ezzbg1E4VjBKgn+UCAf
         i8DlbqjzS8Jff0wMDPjsJujUsFlGNrzzD2iey7HyY5TkYMIcZuiavc16xdMZOnVnUnR7
         UzSw==
X-Forwarded-Encrypted: i=1; AJvYcCXB7EahA+HZdPt5V1msdtcHFJ0brmiwU5Q0k9OYzGoZMDihpgBYD9Dba/qW+vswZCUn8QgqCwgI33of8bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoELlVFP7e2pAxoZOT/GkivyxlqCqeoWA2XJsYQPaDr2i7+RE
	+2qK0jIfYSfgGMb/EkGfCeyjCrveL4vZqk7gfb9k1K0Pm0HzxgZq25phzupY60lUB2OccloQ2oa
	0GItFXl9+QnnMGBSBhvX7JTcMeNn2GiN5+9gRZiO0F+xZGMNeEERB0kM9w2EUYisgyg==
X-Gm-Gg: ASbGncuRd/KmFtiXzpVgYRdnYk/d0dMpw5c/2/4dvZ61Ca++onBATvUXbyxqwMk3pwf
	mlWXcHNQ4etv3R0BxXLa5VxBgUqyCTU4bDHTBCTfVIh07yL+8DBPb94l6dzuRYkU3nBflL62LOz
	ie7M9ZNJAsmY4s8/BTSpSoUuWhBtkB7RW3eqno4StUF8zkPwvWq6ZUPzV0C09dkOyv8fkBB2hRQ
	q3ToxiIud+KSR4HyR3QBU7hpLg0IJXniUM35Mqu2t2GvG+kcewmiU6s2fsp3Db1T2AS6U7rk0Us
	dG6+e5EXSl7NS4S1O32hU4gD4kY5m0HEYjcNcNDofgYNq3TC5riSNOwJcw7sZ0zX0UldGO6fEbB
	siYG+LQrjhABc0AQGCVY=
X-Received: by 2002:a05:6000:2409:b0:3ec:b384:322b with SMTP id ffacd0b85a97d-4266e8e0802mr1458700f8f.46.1759917076080;
        Wed, 08 Oct 2025 02:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENsEzpnWwGCU/M0XivwrkdfnYW40qXyMKMvxtHr7XN7VKUUIvpOrhP5t58nBFFuiZGWfQk5g==
X-Received: by 2002:a05:6000:2409:b0:3ec:b384:322b with SMTP id ffacd0b85a97d-4266e8e0802mr1458678f8f.46.1759917075663;
        Wed, 08 Oct 2025 02:51:15 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b005dsm28753409f8f.25.2025.10.08.02.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 02:51:15 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lukasz Majewski <lukma@denx.de>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: update entries in ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
Date: Wed,  8 Oct 2025 11:51:12 +0200
Message-ID: <20251008095112.104995-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit e5ef574dda70 ("ARM: ep93xx: delete all boardfiles") removes
ts72xx.c, but misses to adjust the ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
section, which is referring to this file.
The BK3 machine support is now provided by the device tree source files in
arch/arm/boot/dts/cirrus/, as pointed out by Arnd Bergmann (see Link).
Update the file entries accordingly. Also add Nikita Shubin as maintainer,
which is proposed in that mail thread as well.

Link: https://lore.kernel.org/lkml/d125b5a5-8118-48ec-8af4-243a217170df@app.fastmail.com/
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
Arnd, please pick this quick administrative fix. Thanks.

I noted a year ago, I will sent a quick v2, but this got onto a pile of work
and I only now got back to this. Sorry.

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f41dbfecec91..e6e615954c6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2558,9 +2558,11 @@ F:	drivers/net/ethernet/cavium/thunder/
 
 ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
 M:	Lukasz Majewski <lukma@denx.de>
+M:	Nikita Shubin <nikita.shubin@maquefel.me>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/mach-ep93xx/ts72xx.c
+F:	arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
+F:	arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
 
 ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
 M:	Hartley Sweeten <hsweeten@visionengravers.com>
-- 
2.51.0


