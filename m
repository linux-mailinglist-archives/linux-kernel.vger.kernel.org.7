Return-Path: <linux-kernel+bounces-841652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2ABB7EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072F03AFDE0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416D2DEA8E;
	Fri,  3 Oct 2025 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4y9T1N6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0643987D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517407; cv=none; b=jDckBc6YE23cIlpLbYZEWiGuTwxYLFdIwC7/PTgB+/GkQEBRWiKWANQzZOczx+N9Xy6YdgqDPaDIEyuk6omMYd6VqDrrfRu+SW8OR9kcBHFJKdrXYo7A0McbZcPErAeIi5mPWe/z78Bb51xlRVAxdjXsonhZJe1WKH84B7l+feM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517407; c=relaxed/simple;
	bh=ywiJuy3pmEwKeorAfmmSATa6Sd7OYA3LtfXbIpEBw5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DFkfH0zi6wU8+B/vT20xP8L2DrvjIqd1yw3RCxcKUZ4kv25d0tPOx+Xo/eKaf/dFoYD/JO+jQeRr4Fgj9qyF+/FWEgR1X8VhVFBsG5tsujoYDYrmbz4YkMGzFHgQje33n4WCCYllKpgtHrzTt4Qd21eaUnffD7siyS2O3sv+VQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4y9T1N6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so20729405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759517404; x=1760122204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8e2Y8kozAGCLrKRppo5kaXt5Ne+CwrCg0AGCxQGa4iU=;
        b=O4y9T1N6dRQHCUFirmuBEggbIPsa9IPx2IrEVIe4akFL4833Sti/IOif7fTUIp/SrV
         v1gxbKg1CzPNKA7TcwfGfJ5InS42lW84aVSVwlylzh9MnIvsgQBvx+1uXg+gum1slP3T
         zJv7XFJ8ewP8+e9ruspC2qNJtoE9RBj4v4Z5gASWuQiaQcjRr4vw6yd3bZXNxkdL5daC
         Vn4AOAzyY58OHPHfr78MB19ceP6acZdnlQhUUppY6LGDFx6/N5fwrfAezTNz1iSw8omV
         iqI0PEsoAzuMVbau8ziyhve9lPyfzJveeUMyFONLUzxY03dYTBH6ryphyNOfadRsAT88
         4s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517404; x=1760122204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8e2Y8kozAGCLrKRppo5kaXt5Ne+CwrCg0AGCxQGa4iU=;
        b=hw1b1gm2qzlBAqPyfNNJ4TcqDMdEplnCJEH1f3cbiybcHUtEJIt8v5UsgioIj6Cyei
         A/UaRuMddnGb/AISUQZn1so5UYOQXyTqDQQpS72LGDWoHqssh04SrH7+mQdiYpLkZQGX
         ciYckZp8/eT032b7FDj/ff8ryF+xsRRtKWhWBXx+ImH2K5BzYHm6wZIZeAZJoViH6Tgu
         FLa2w+Dusqm6IPbXBOo+kbvyVSNk+Z76dBcYmJZXGLLAp41x5zxj0TdCLN0vG093ZFNO
         fqZo05EEPUIk/EuqX9RDd7VHOXSHI8c9MHVWhDyHTQ0cUPw2DrCKhdbAf2DNEUWcpkI3
         1eQw==
X-Gm-Message-State: AOJu0YwLSDaMehU/Jons0EhHjA7JE1h08ChynIktJdjvEendU5oxGHm3
	ElrEe3KOUx6DBqaxsi6EFuKJfiHTmuNbSj64QMMGjQ+L7K0i+jZjHNqEsP61eHuP
X-Gm-Gg: ASbGnctAlEIit9+iEwJ27/qXyuwS0G7q6Sf7o0AQCvyd1lTwc2WVHfQs0M96aF3scd2
	Ke0xHUkLdN9DzImdl6AhH+CJBaNwxCUQCF+V0vnqUEp6I3sSMIehOw1vOXiWNV75TX7A+m9TCT5
	BkskYdmMPk70fnSatL5YpU7FOb5yn9DIYKKRBpEqKhPdVAKVjzAyeI4wNztirnJhI/7m0joKUUj
	bziCtj0Ck8HrVoYemL+oiM7Ly6lBi9vCMRNZc3wyId9jFPL8DKwTi+q1rAPhvgak1BuRLggNLi+
	bg0467MM3edvvfx703j+CnMpZsLklnvxlWg7W4evTXFBuR4apzcNQtndNz1A6YVoBKscxkBqUii
	c3gDaHfhu/f1KLIocRw6mTL2hkGAfuihx3smE6EGs9tm/IYhUmTR8oNpoZxKycA==
X-Google-Smtp-Source: AGHT+IEgME5bYkEgfz/T2ZtHL3Pwl9xYIPrKdRMudCiAH8y7dfmZc8ndWPPFdPqrOP0ghZNalxyWiA==
X-Received: by 2002:a05:600c:37c3:b0:46e:6a6a:5cec with SMTP id 5b1f17b1804b1-46e76871edbmr11187935e9.2.1759517404373;
        Fri, 03 Oct 2025 11:50:04 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b577c87sm86877405e9.0.2025.10.03.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:50:04 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH] MAINTAINERS: add Denis Benato as maintainer for asus notebooks
Date: Fri,  3 Oct 2025 20:49:49 +0200
Message-ID: <20251003184949.1083030-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
DRIVERS" as suggested by Hans de Goede and Armin Wolf.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Link: https://lore.kernel.org/all/8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 156fa8eefa69..81bcb934748d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3841,6 +3841,7 @@ F:	drivers/hwmon/asus-ec-sensors.c
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 M:	Luke D. Jones <luke@ljones.dev>
+M:	Denis Benato <benato.denis96@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 W:	https://asus-linux.org/
-- 
2.51.0


