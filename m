Return-Path: <linux-kernel+bounces-750207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D1B1589F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB7D7A9A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000721EB5D6;
	Wed, 30 Jul 2025 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKTHLIlH"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B1249F9;
	Wed, 30 Jul 2025 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753854908; cv=none; b=e1xIkQI/PXg3h8zct2jID0IE0Ra2SNoZxmzFB7wPZSCGfkPyOgGar+RXQygkefHdQ424ywXTqfBdviml0EPGeTt1y9KYvfLNhz/1s3a6iIYQq33nChXhtACdZRLlKoCFvkJOxeWn/x5UEv5oDM3zzOhtEAqC+xjt+VrwLSiatro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753854908; c=relaxed/simple;
	bh=+4EkPOAC+jo3nBTeLG/ZDMlpH/1kxXxzJRqMDzyCsfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekIa1rTXu33Px32Of8inI10L7b0kfz6by+fhTBgNLnlOG3h2AGOFSPCZtKlHfFHHsSBAUmFUIWzvr8l7NJkS9kDCxSW4oqvNwlHQcg4weiOss10WHguw1UTbZTOJ/ZHpHTSLXAFJS0/R5Fkiz/kmbEnfR4bfcO/cluW2pou0KCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKTHLIlH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-615378b42ecso5652410a12.0;
        Tue, 29 Jul 2025 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753854905; x=1754459705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEQjQUYSKvzxJm5N20PdRW2h2XKmpKdlgrVQR8zsmLo=;
        b=lKTHLIlHOIrfGh7lvt21om0oQJmmv3pCCiwWkLyHLYSzvEAYCv65B9aNJtUge4vPrA
         TBuvAfExDlBfE+M9TIcF8tz2o8M5eBMPD5WCO5trtWjmirXUChzPZnGTO9fFq6bOsv5X
         IDjZ9o2jonlyiW+KwdhU7rJnMWqeaf60ESq+oC2377i6s4tN+FKTU3ebgzII9kMS4aHG
         EdWG7bFXzwplAE2fwvs+xidTstoUf+m6ZaLDW6eysPUetmBLNmQhU3xQ5+G/8DKKdnvM
         t9T6ee/y6rKClsItx7qAHS3iW8F7SgLmtfsBJJRUz8HY+0wGqKwHToEcgQCZEuPwe7a8
         Xzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753854905; x=1754459705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEQjQUYSKvzxJm5N20PdRW2h2XKmpKdlgrVQR8zsmLo=;
        b=AJWAKcppYkwP0sWOhXFw7L7fA+AazXe6CI6Z5HcSgkDLTItKJ2L4XBwYUER1SprM77
         o0I2EduaTMxaAQpiBK6QvAC970CFyzm62yZn/8y02i3m+cfSEhVkgMT3xs3wu8T4Y+Ls
         ycKXMjYN0POztvkvNGY1MNDtwNOtaGNNzdnbZk90wrW7cf6n7P93p2ufgFQZBU9acZDc
         dl9StX66nYKywkI5schEbru/JxQz6T+qxi6JDhaULq8haN1HpieJnXRXbQkjvMogEPaS
         uGmWFEN4bEeU3fj512T3qnk5YMixoegdZglh+CEasEr63qvBnZ444Ixh2uLF9nGEidAr
         FCMg==
X-Forwarded-Encrypted: i=1; AJvYcCU79aop9E19ydjQZitdoc5ZAz7AfVMuEwB+84+ac/cki03ayQQev7mXAFMTFEPYIKNU4ItrIJJfG7E1@vger.kernel.org, AJvYcCVVFKsSbc8Crtw6DCJOO5bFImt7HoWRrHPv/m/Wtk2GO4rgqMpBbgLijOw77YzMyGvx4KfM40dMG8jCNsnS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz69NdI56d9Fxfvcr2Ne0PykYGpIyhLJbl56hDFaOTToIkb18H4
	nBBRXSNj3C5ETzbcjGfNeiI1wkF86q1hnMgdmqvSt7FVbIlaGUZcxoJl
X-Gm-Gg: ASbGnctavIJVZQf+cqvRDFNAHnMj6lWA1ZXZoRhYH6NzlSUc1XZ8VCh69/7L4CywpZK
	YN01XS5YmpGiRJEDHp0TNzOQfFiN9pwvi0KPNhEYBp9/JC2HO2KdVMYgyLxDbhc0VqlWS//idhZ
	bJg0ALpcQ8NslGMEmcoOFAmDOCIRJAF/o9VkwIyvkY7faL8DHwXGEwHIwwou427C8x7ngnHe5fR
	qTVRnUym/t8azJK+cfJiMS92KgTIhNF6gnJCNv9ILfdGS2ctIimmjRfUCoapBNIGjxfgtZm2nPD
	vpbCgj5TwtpGv6iRbqF5L03nE015Rb0e5EbXq0y1TsHVws+Z+cy+h5nYRVtr7QHbuHjP98BsLVn
	PsGTQExG5kzNE1A==
X-Google-Smtp-Source: AGHT+IG8T0ZDzRB6oewO94j2PhAHhqbgoT2vO1y0rMUH9KlNOXkJaaxwmF/O/Ub/w2NeS9gfw8MUWQ==
X-Received: by 2002:a17:907:7216:b0:ae0:bbd2:68d1 with SMTP id a640c23a62f3a-af8fd95cabemr204331966b.37.1753854904605;
        Tue, 29 Jul 2025 22:55:04 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157f2d6b94sm1014803a12.57.2025.07.29.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 22:55:04 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Heidelberg <david@ixit.cz>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2 RESEND] drm: bridge: add ssd2825 RGB/DSI bridge support
Date: Wed, 30 Jul 2025 08:54:22 +0300
Message-ID: <20250730055424.6718-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P880
and LG Optimus Vu P895

---
Changes on switching from v6 to v7:
- removed enabled checks
- configuration complete quirk moved from host_transfer to
  atomic_enable
- switched to devm_drm_bridge_alloc
- removed redundant dev_set_drvdata use

Changes on switching from v5 to v6:
- set correct module name in Kconfig help
- return error if spi sync failed for reading

Changes on switching from v4 to v5:
- rebased on top of drm-misc-next with adjustments to fit

Changes on switching from v3 to v4:
- no changes, resend

Changes on switching from v2 to v3:
- added mutex guard
- configuration register flags parametrized using panel flags
- removed unneded debug messages
- removed unimplemented modes checks
- added check for maximum pixel row length
- use types header
- remove ssd2825_to_ns
- shift bridge setup into atomic pre-enable
- cleaned default values of hzd and hpd

Changes on switching from v1 to v2:
- added description for clock
- removed clock-names
- added boundries for hs-zero-delay-ns and hs-prep-delay-ns
- added mutex lock for host transfers
- converted to atomic ops
- get drm_display_mode mode with atomic helpers
- parameterized INTERFACE_CTRL_REG_6 configuration
- added video mode validation and fixup
- removed clock name
- switched to devm_regulator_bulk_get_const
- added default timings
---

Svyatoslav Ryhel (2):
  dt-bindings: display: bridge: Document Solomon SSD2825
  drm: bridge: Add support for Solomon SSD2825 RGB/DSI bridge

 .../display/bridge/solomon,ssd2825.yaml       | 141 ++++
 drivers/gpu/drm/bridge/Kconfig                |  13 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/ssd2825.c              | 775 ++++++++++++++++++
 4 files changed, 930 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
 create mode 100644 drivers/gpu/drm/bridge/ssd2825.c

-- 
2.48.1


