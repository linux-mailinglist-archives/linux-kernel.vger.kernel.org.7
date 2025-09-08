Return-Path: <linux-kernel+bounces-806265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27773B49463
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08647AF4CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873630EF8F;
	Mon,  8 Sep 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQoimeW6"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06330DECF;
	Mon,  8 Sep 2025 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346914; cv=none; b=gyGzSIA+CZEMa1TgiWrDsRH9IT/19/Mg95652nUbv7F56xee1iSoOBZ7Ek61REWcktXbaN0nXO81fwTaxcv618MS87HdOQZuy66++RNbrz3E6YCFK1lX00wek/7Jj5J87SKb9/is4fpB/FH7vMIbTxkaAu6KrAawZt8rHzI4R7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346914; c=relaxed/simple;
	bh=UEw4F4LkD49VKclwQjDUiuUfQ+Jf1njAT51SLNuYO2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7YpGJekepv7xtaySZEkMjKTm5I08nNLEQVxMTo64G+L+CKljlEGANlmOkgv7cKc3mwtLH5ADzbwxZdSAgbcQmyGOAg+Hjl/Lrnf8bcJ00dZLCbsBZAj6e0xuoRctk77LHYnbOD6QMXifsoqybq1iya6I7jM2svffYz6LFDaTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQoimeW6; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8b96673653cso240704241.0;
        Mon, 08 Sep 2025 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757346911; x=1757951711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIrWIgaPrpXvy15ltxr3y1zTh70BAC5HdpbmwVt7Qmg=;
        b=ZQoimeW6/kvXdKbjTb02xhSiZEM9zx3lZ8eZPaxj2YuHf2xwmclfvdZm1y+7XLP0on
         deOjQseezXm8V+fEsqRSQKBABCAgkRNg5qywd098oRyyK/A/SYPGpFSzMfEHv50mk6o2
         sbSTEgTi9qO5lU+/OteP6G4JYzCAJSzTPr1StycY7oIbjM5el1WbG1Qw/Q9JloZZBkpO
         oOo7k+ZE9RcUJNWoaBfe3hvCUZs8Rje3Wxw/kEcoepvckhq/pu683iJ55YuGGrxOMmV2
         JqAowSr7/W+d/52GRkgMxeyJLnKrt8Kn9QWEMsOysV6QN0gk3bkHic27v9ZhU8lkIYgU
         1yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346911; x=1757951711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIrWIgaPrpXvy15ltxr3y1zTh70BAC5HdpbmwVt7Qmg=;
        b=FP4pgG+MbwGxHJa7DAu/FOE4NK0D4cq991LHPhGdKmHqKrNdVPjK8npBqPwrOhDzaV
         oL3zYM48h/SxM+lkOgVHpxR56h8p+uCOHXBjAdSKpv3VNSG2THVseBju1PIXW7wZosUE
         2G0yTUqis5x6D0ZYlcfB+q70LwyMCPtDj2AWIpT+NuLnEs5qFWV/uOTUCSS8d079iaom
         DVoh+y6RXl2Xukfth0mPaiNO2ycwczSklBjokZKrOV7RbWRfmiuP0ISdE6ikxKJgZw5V
         O0ruY+PYDjv4J2U6O3ezMFp6OO7u6O2PSHd/2MBHjsyghFMLCCUR32/IGRTv5FnqGO+d
         7MrA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Bl3URvvhYAWRaKQyL4YAKx7gpRMqxrWhl/wnIitmRXl07yG7av3jlk6f5tgxJsObeOzkcGQNAjCB@vger.kernel.org, AJvYcCWzdkyFRW4xi5p4zPFAdfLWnvXjD5AY5fAL5fi07y7PO/lzPCFxg3pbZjZDJr4MD32gTwemWiV8pUiV/qIZ@vger.kernel.org, AJvYcCX02po3uM/UGvn9DH0GQNmaC3y/LPKLjkgh89DnKE29+n5tDBsFDicJxes0hJDUOUoYsyJbrByNHTk9@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVf7FuqF9grdeO3YOX0PhBE7M7WWLkdTM5q2unkTR7qh4cB2n
	VUdLCry/iDI3Vi+slBoswaduTSAf7lXYTOvZvX9zmPhsAB2AqDTvHCHTdOE81g==
X-Gm-Gg: ASbGncs7lC5m1UZ92eWq1/qAvGhq7QttskSYb7dcqdrMp77Z687OPj07g4IquaGmdlL
	6HNE1/s+gCmPxX9+NOm2RQ8MJD47dCRQp41nT184L0sr0JVNvlw7/HGd5lNzz6YfpdQiqfeIPU0
	ZZbo0gk3j1uD4szg6l3yr/1M55rghJ3kgVs26iYoR66pSsgQsikBguoK95hWrznzsrI6M57kT8a
	e6S4mr7xBWn/8GcSWCwYSnICyvg14oGCcivwZwRTdGeLGhlvHy81B+379r+lOFaABZhxsrsz3up
	dPZOfhDX3uvwxdK7ffZv7vUfO4PtagFbVS3peUL/+BNZDHDSQjmDJ2ZIixd9tOz3nb8lQGYaDyp
	Ftb34emsHJtPBsgKpRSJ4VJkh
X-Google-Smtp-Source: AGHT+IFgPMlHLzn9j7bvzTbf4/KMwdhKHekGVQ5fmekqqoLsh6OqnZg5vInmZkiknnBUhSjlehGFNw==
X-Received: by 2002:a05:6102:6a92:b0:518:9c6a:2c01 with SMTP id ada2fe7eead31-53d148c0bbemr2139585137.28.1757346911229;
        Mon, 08 Sep 2025 08:55:11 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89601b67070sm8689299241.20.2025.09.08.08.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:55:10 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 08 Sep 2025 10:54:49 -0500
Subject: [PATCH v4 1/4] hwmon: (sht21) Documentation cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-sht2x-v4-1-bc15f68af7de@gmail.com>
References: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
In-Reply-To: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=UEw4F4LkD49VKclwQjDUiuUfQ+Jf1njAT51SLNuYO2c=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7/kSvymtPuy/+vtvEc8+b11vv8Z6TvnBkQefxTQG1+
 ZVPuyVndZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEPP4zMmwXXXSZQWzfEnXd
 HDeFojThJAs7zenPV2ZxHXp4ckv36umMDEfzPX+f5xM46b/IY36K5alFj4vUc37/9+rhdVI4LzL
 fnxUA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Drop extra empty lines and organize sysfs entries in a table.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/hwmon/sht21.rst | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.rst
index 1bccc8e8aac8d3532ec17dcdbc6a172102877085..9f66cd51b45dc4b89ce757d2209445478de046cd 100644
--- a/Documentation/hwmon/sht21.rst
+++ b/Documentation/hwmon/sht21.rst
@@ -13,8 +13,6 @@ Supported chips:
 
     https://www.sensirion.com/file/datasheet_sht21
 
-
-
   * Sensirion SHT25
 
     Prefix: 'sht25'
@@ -25,8 +23,6 @@ Supported chips:
 
     https://www.sensirion.com/file/datasheet_sht25
 
-
-
 Author:
 
   Urs Fleisch <urs.fleisch@sensirion.com>
@@ -47,13 +43,11 @@ in the board setup code.
 sysfs-Interface
 ---------------
 
-temp1_input
-	- temperature input
-
-humidity1_input
-	- humidity input
-eic
-	- Electronic Identification Code
+=================== ============================================================
+temp1_input         Temperature input
+humidity1_input     Humidity input
+eic                 Electronic Identification Code
+=================== ============================================================
 
 Notes
 -----

-- 
2.51.0


