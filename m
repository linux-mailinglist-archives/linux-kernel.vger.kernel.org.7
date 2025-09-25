Return-Path: <linux-kernel+bounces-832780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6206CBA05FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD2D5E3EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F5A1E503D;
	Thu, 25 Sep 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB032AgS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0042E3B03
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814100; cv=none; b=BUb9vMAVD+Lp4mG6zGW0PWuX6dj4o3SLj9iPqub81IGs4PrjMBQp2vsMRIl8KxAA0xOgo7oEM/IFhoxEV3iLQFTi9OpETKjEeu3Pnz+tfbIt0nhz71Dt6KeZX0NA0XylGGYWmhLFReyJOIOcGtAX800/aNgi+uDCn4lUw8Xc5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814100; c=relaxed/simple;
	bh=R+wFbRH8+5hnaBVtC0tbh4Cq5Xw/tKS5WxUE9yvqlX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyGbeewzyARQYTr1Ju1BSysWUP3h8wwrUDqJobrbo1MgXca+TmjLbGBE93cJCJRvd/VGLOxh9dlJ7N9tkdyDFri5w3FetVe37KeCmW/OxJAeBU2YdohJgRh3IZKYIPGUNWDmG1tfyInCAHEGAK1gyZvKDs4PBhCciax52l9PCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB032AgS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-367444a3e2aso12575131fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758814097; x=1759418897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/ajMaAZHsmNftCRY3dTAxu5sXZqeX7gjwGITMB/lcA=;
        b=dB032AgSlJ8ThaULwwEgjoiOYmrqXpCAxvKftPWOAzdtgdrRF1fbZi1OxBZRs00BVu
         lLj3NWBl3HtXrZTn3idh0EYnGcIRQ0hJhcVwEjJcaYhom3iEaZFO6lqxT4Qb/CQQNVBF
         JokNd5wW8jSSZNnLqau8pIMoMVze22RlCA9+DqOJ4O37i67q+6F8XdZUfl8xL7RWzQrr
         ZrTox9tfuDbEQKpNNolCzXss++RvWQpFqSzQfoFa2GRY747K9+6ICUhVfRe2SiSw8j28
         Xlcd/yjHEd2fU5+sYumU1Q9u107i9KaiZ+9rwFgNPfROZNs2uxqnDxBu3bcs69MGzaIt
         +IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814097; x=1759418897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/ajMaAZHsmNftCRY3dTAxu5sXZqeX7gjwGITMB/lcA=;
        b=RtoBXZJgVQcRCmmBKMb8Is/Hlicb+lRVfqlcnf1C25LiingRQQXRW0mcOQGX3amoe0
         JfZaFmE0OOGv+UNJirlwyBbawvAI1LGuJLP48iBK6wlP0ZD2U4VWFMAnvCewtwXXO4CR
         cG5Q1yrs5SRJIpbTqEzQfWfpt/0god3YRgUK6vcmlOZM64Nqz9zk068oHoBcU95NAAfH
         BMTpKEv7Cp0wQo94Nf95WKEOqFQLu7rnGTTUna8AA/wCePrg/UCpKlPnOlJkn1JnGaGi
         K253qomO77CAvb+pn4jV0LEv8ZEhHHqCQI4tclmYQisO6qLvFhNKjJ5QrEXDa+Pdoh29
         vq6g==
X-Forwarded-Encrypted: i=1; AJvYcCUzWQuwxjbLIeg9sJ0rhAJfDdPk1FPhJNxP4+HXN0fMOz8Zc+Rhnt18aAJAH0AeJaKNaOlH2Q/nc7pV4ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9AhgiavfoBJMK7vkTmo06xpxtPlXB6S7wkoiSWUMUhj2XFDNy
	JFvKCBgkfeqvKr8PLVJE2bjVVXdfKSWXDgGe6astXcHZE2u5NPZfRbD/
X-Gm-Gg: ASbGncu6aGdHrk31H9kANVW/5a25zSpEKWJoUBnX9PmW2aGr3Wgmu2AkiG1BNz5S7wt
	uxI3Z1G3gA0wlBS2QUKt4i57eKIhMLaV3PdEuzcDt3naw7qalme1kvIV7aCrT8zehzlc2G/mYem
	vE4+R3S38Fkmqt4HfibSn5ATcSU7k3u/gMC0+oxfRjJXd7LEXMNfAv/gi994fDKsusrUgVEcvMG
	5DVxtWFVsyIpGYqx7lu90iHqWy4L3hl+IkZhL2V89XLM7VztZnZarbJJpbbC2cKnHhW/5Uw0Mrn
	Pn/ykvg0PL42aWhk3JnbP3ON/mG6Xm3rT9krRfOQAxcU4gEeSwLGoEgFdYQ/PMHKYzYWgqRnx2Q
	czxHIBzatOsy2Ug1lzpEK9h1p
X-Google-Smtp-Source: AGHT+IEjLl7C6LVh+5ZGIR/Naf8q0lU9twFamYJR/oaj9RedlrpgokXUd1VkW4REFITzmwWy5TLJdg==
X-Received: by 2002:a2e:a10e:0:b0:361:774b:8b45 with SMTP id 38308e7fff4ca-36f8020b691mr13255001fa.37.1758814096768;
        Thu, 25 Sep 2025 08:28:16 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4772c8asm6347801fa.4.2025.09.25.08.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:28:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hansg@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
	Jingjing Xiong <jingjing.xiong@intel.com>
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] media: i2c: add Sony IMX111 CMOS camera sensor driver
Date: Thu, 25 Sep 2025 18:28:04 +0300
Message-ID: <20250925152806.80386-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver for Sony IMX111 CMOS sensor found in LG Optimus 4X and Vu
smartphones.

---
Changes in v2:
- added nvmem-consumer and dropped eeprom
- switched to unevaluatedProperties
- dropped flash-leds, lens-focus, orientation and rotation since they are
  inherited from video-interface-devices by unevaluatedProperties
- dropped assigned-clock* props
- improved code style
- adjusted colorspace definitions
---

Svyatoslav Ryhel (2):
  dt-bindings: media: i2c: document Sony IMX111 CMOS sensor
  media: i2c: add Sony IMX111 CMOS camera sensor driver

 .../bindings/media/i2c/sony,imx111.yaml       |  112 ++
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx111.c                    | 1614 +++++++++++++++++
 4 files changed, 1737 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
 create mode 100644 drivers/media/i2c/imx111.c

-- 
2.48.1


