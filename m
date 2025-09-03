Return-Path: <linux-kernel+bounces-798282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A82EB41BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278516815D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017CC2EB873;
	Wed,  3 Sep 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiQ86Q9T"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AD2E9EB8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895283; cv=none; b=IUX/vsh7NRCtNXaxqDHP/UkqLYD6CAglomnT+1bUycU4QxHpe11E2XVj6Nla3zxe0cvtTX4maFWYck2SXezL6MM3unD+bq9XFlvIlYJLf0RPvYiEjemEnWaspXpO3KiK323pnSCW17pQyu+NKDexa1nZ4d8towqPhoVw+6AMu9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895283; c=relaxed/simple;
	bh=le66QlMuZE7hH1oOfQ5HrC4Y1Tp6IgLYo/j2eYYGOLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYXsDaRkr3QelqqRZHD5b4wTbds7wBHZqnXs4Na+cRQBMwTFtYOK+M0wmSp6lvGUSRIecU7WprL9zk5YwUAo/gDljCf1ip/b+5jYMkAY7PLtz1829JjzUKporPtAgHcW4KuMGqL5ItAPWDQhI7J1RuzyxrsQ5NNkPGgWLgOfLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OiQ86Q9T; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so4332740f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756895280; x=1757500080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1WQS2V0Aq4ymgCMCBADFQC3VfxKGm3mbnfHsQGlDKY=;
        b=OiQ86Q9T7E4GYTCLRDAUAmriq+r22M+C47vmvBnvkMX0CKzPO1AGokAPLEmUEtmyAK
         vnLXIrs7jVxYLNZytHx6xNfBXGUpspUfmrMkPoopmyqLr+Y2BkUZhcvEecn/Jcp9u0y5
         +OmabEP68JmE+bLBYUDbLNej3ArhaF+6fTEDH6axrjFKZE3nZuaOTUOztjxrouCXROnS
         4hLLOG535ljYscVDVVteq999Gk34Ka/X4XuqyEZVB+dwzmvDNfHbImO2MCnkv1bYIDzb
         YB/xFFUTNRTkf9CbEjOrrSLVvQBSctUw2R3KgrLCbPG1n3vQ93NR1s/WhTd/ontzznIw
         6lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895280; x=1757500080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1WQS2V0Aq4ymgCMCBADFQC3VfxKGm3mbnfHsQGlDKY=;
        b=AQflTFub1j6agxxVCgb7KuF5ScqjDH4tx8qRNbattCDIK17DnmyfJ2B5v/nZniRyPM
         RMsFlzSrgo6wugNpxWkmbmQnLDqmRj5PLJEkvmWDhCUGgsuQ6qoNIhj/mrun4x2E6YNL
         iDl4a7MhdhhAzWKaBQ3yOA9aGbx9uNvKhBbdnzNt6F1THeFLFcsPQDzsKn22cfAjckRr
         m2yvbgZ7GOJ6NSp6pbkso+WwDMTuEXayuKF2jrhQjv1pYJulONUPuwRiDywoT+tbhuzM
         HGJL8oj9GkJ2kOs2yhKXmO8IlNrsU/FsDorrg4a+yBGuj1LkSYxzqxGrIoGmP8bWfduK
         ePCA==
X-Forwarded-Encrypted: i=1; AJvYcCXy1xuE66HhSw/WqB/rL+OOP54Zu59NemY1fZ288T9VSmdHEtAoQMYCg4HKJChqVWBqseIibR928aVbqhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKpTnxJpzWK7gHp7G0TsL67GJzDPu+l3mj0FTXPmewMUhGXQ2
	3atVxJBKYmeOZt1fOXf/R0Asx7K5sl8TChuwYzVeoUG5k8Gml5Ob7fP1MtzuCtC8kP0=
X-Gm-Gg: ASbGncvCh1gXFJScj2YNgZU8N8GjvwzAhteVtFlfPOWVlX7kSTBm+Jaqn/ve89gUo5L
	RMfCZXkjc3dGDm21F41Dk2sMjHV6gE0wq3WUQ4e7s2OVnwuAJ7f2YkhMj1c1fmp65NA3qyvvVYy
	cKEOn8RLQyRm8kDMMDSyaSci/U6R1oGdYMWMoSKaPt1GOpao5Ut6dgDUpB+d/RjBPrJBcd5vtEp
	Rlf/NexLEHQByqEQpBsv3veLdUVowKNC+S1bLbDx4I4pzMxhmSKB046J+2ydD9zShyomOY6VwtN
	ogFBbtmI6+9teOZz8stuEQUXV+WE/85k3xmr9JCeNDYux6du/tQc2hopa8KWFWF6cAGDZjct0Bx
	uTGzYu4LHSztBvuKB1XCw9LCslKYKPi52/M3vpGAZ5ZJyqsK2hoICQQ==
X-Google-Smtp-Source: AGHT+IGUUt/nsQbBtMP9pzpPTBYBPoasAKJzS5Dkyri2rpl0+/sHhf/B6Fxwr6gUabi0H0wXSYBQiw==
X-Received: by 2002:a05:6000:3111:b0:3db:c7aa:2c4a with SMTP id ffacd0b85a97d-3dbc7aa304amr2579469f8f.42.1756895280034;
        Wed, 03 Sep 2025 03:28:00 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2a30:223c:d73b:565a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9ab7c7dbsm55992855e9.11.2025.09.03.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:27:59 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v1 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Date: Wed,  3 Sep 2025 12:27:54 +0200
Message-ID: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G2 and S32G3 platforms have a couple of successive
approximation register (SAR) ADCs with eight channels and 12-bit
resolution. These changes provide the driver support for these ADCs
and the bindings describing them.

The driver is derived from the BSP driver version. It has been partly
rewritten to conform to upstream criteria.

https://github.com/nxp-auto-linux/linux/blob/release/bsp44.0-6.6.85-rt/drivers/iio/adc/s32cc_adc.c

Daniel Lezcano (2):
  dt-bindings: iio: Add the NXP SAR ADC for s32g2/3 platforms
  iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms

 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   |   68 ++
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/nxp-sar-adc.c                 | 1046 +++++++++++++++++
 4 files changed, 1128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c

-- 
2.43.0


