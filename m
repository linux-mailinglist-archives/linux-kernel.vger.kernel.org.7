Return-Path: <linux-kernel+bounces-864574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F80EBFB16B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2933E507DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00E83126BA;
	Wed, 22 Oct 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GPMIzeBg"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929513112DD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124242; cv=none; b=OH5cTRCdNtfjRyAEl+xbf74Aik2QJ4AiemEUWOocijzj2OudnRx1jlyED4+sC7HZhFmsfdZUhj7GtKx351kcPKRUZap8Plpk+SeM/T5wLt0QO67qpFBa0YqUmGLKQ3uYkFZgaC3al6L5yO203f9a8eipde++4BYMab/oANprHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124242; c=relaxed/simple;
	bh=Ne41DopDkEHEn146Cc5k2i50YAlbZrFosgJ0KMVVNHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SAi9+oGsSr4evYGaJrhzTvLP530OkJ6NQd5fffYYeCF8OCk7+awb6rVXqW6HGYECY0aoNdYL4+cn9U3QUttzqBsHkcDGhJZJQ6nKVAPbMRTOUSUT4Igr31N/44oTcQki/joAjxlmr16Sn5918cqcLKhGPMMBmKiYi/KVmV9ySx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GPMIzeBg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-421851bca51so5397897f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761124238; x=1761729038; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUfI3YbDp39oH+7zB4MP4DMz6clC8xu1EIq8OYaS2x0=;
        b=GPMIzeBg0E/sEgVjUYvIDlsRaPsfgtABACJHbWcRb9KG2B6ImuTtqkypcTvZLx2K5d
         U9m0fGKOR9+7bts4V011XE0NPJ+pXVMgEorKzDIzAER2P/RVSCdYzFXgasz81XxugQkz
         VX5+HYQSw/xfHLw6zjpP/stZj2cBmZDoIN+OUGbkkJeIn/M2+d1d43WzBp7xzGq2Ng7W
         k+nraE25SnzHr+5c6i3JMi2JUG92OuyBOWzEoOd5/CH0NVd4lSddVUFMARbrsTSqX2IL
         k54bhrG1LeHJCR5MDuAXATTtJG/FrUkVZwhSMdgi6xJX++QR6e0UsJ4Pe6JXHn5aPdnH
         Ab2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124238; x=1761729038;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUfI3YbDp39oH+7zB4MP4DMz6clC8xu1EIq8OYaS2x0=;
        b=vyfMrW2t2cpR8Y78yphdQy2eMoRsMCBDm4yl4fa9YtrqDYrSbED7+Vy+293hClYX66
         pDR8d0MGCX714uKvWwuRVyM824qIFX44pZb3toPDGzzHeUta6Eix8zabDb2pDmL5QT1C
         vHKhAl8xu4pT2APP8cn8YmQzRXX+ZcYhwddpT+SnNkD2ltuEo01lbv+3YQeTmxA2DvPf
         yJCqpPvm7D9U0okqM//rNr0CPUtSrgc2klnfAsyQPNEgtWXiv2Rq7VEyQ23lZafeh3fi
         bzAH2sopDhX9yEqbVBagk+MdOC6iT4UXMaRdTQWzzHJPPJRX+2h2cX3zAir2pYxONu4z
         +1yg==
X-Forwarded-Encrypted: i=1; AJvYcCV0M2oUnN1IdtEPxElJfBdnL5Qb1fBC0kAAS0cWd+XXbVKD0vvJ/ihI7DJ6xajMWvrlwu8iL6FraWkGBJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqSEakU1GHeO6zxgCWT59c9lRlq+aZyDyzaib6uSMNwEvet3g
	bf8RUYJaQ6y/WKw2yDsH66/bWB9fpPXKlI6/HdAGjwkamOAt6eop9oe8+ATD5nIWLdI=
X-Gm-Gg: ASbGncuKrTDqCPY9NjZtvkzpRlU+Pv82O+x1Ufemm6ScbmQWaS2Co9LoZRUT8uDWh6v
	fbXqNo8ozjGfTO1URaIMxv7zP54gytYPWbE9EoyZuh2Fgs2S6UDoK+yZwrVUJcvMyNKpvQjsiul
	Eto9zJQY/VTaxEO31qNbOBhE0pHCVG2aWZw8ULd/G+9j1emCUq6+7dHdDs6AFfzAgSUQeBT97iw
	r43ru893Fsu7tzhqxGe6vx0KoeY//0k/P0K//KX0pgGy8f5lDnLyi/XPHz45Jy76HotehdKw3nD
	0eOJrau5JMZ2QOXm5CtapPE+7yqrIWqwErOLYHtaA0orr/06CpjKSmQBo1ECx+TRaQo1UmvqlW1
	RaVGsYAqR3iAUIdvlxuLsP1fOTHslIUIVV8ExDlaCEni8UsXZAqHaa8wTUzBciMuEhxZ2Oy0k53
	eUMKmcvS4I
X-Google-Smtp-Source: AGHT+IFXchXy7AXbqsYBs0JxSqwzJdd2K7cx69MVVUm8mDXm/wFBZ0mFrLR+xZr9csC3yEcx0Jru1g==
X-Received: by 2002:a05:6000:2c01:b0:427:914:7468 with SMTP id ffacd0b85a97d-42709147731mr11189262f8f.15.1761124237772;
        Wed, 22 Oct 2025 02:10:37 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5a1056sm24015295f8f.2.2025.10.22.02.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:10:37 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 22 Oct 2025 11:10:09 +0200
Subject: [PATCH] MAINTAINERS: Add myself as m_can reviewer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-topic-mcan-reviewer-v6-18-v1-1-885ec5e43493@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHCf+GgC/x2MQQ5AMBAAvyJ7tokupfEVcZDasgclrSARf1eOk
 8zMDZGDcIQ2uyHwIVFWn0DlGdh58BOjjImBCtKqIMJ93cTiYgePn88nBzxqVAa1oapqHBtLJaR
 +C+zk+t9d/zwvApbUBGsAAAA=
X-Change-ID: 20251022-topic-mcan-reviewer-v6-18-582447fe8c23
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Ne41DopDkEHEn146Cc5k2i50YAlbZrFosgJ0KMVVNHY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhowf8xulD5WIaul3Nwdz3N92zLK4/M313FStREvJJaJzZ
 IXzNFU7SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCK7DjD8r1h46Fb6okSdP5u9
 /pyK32rVfu15FAP/z4UiwsX36mLcKxkZGosuJ0/gWNGuW/yv757zpr8qL7vm9X76lSQ7O8No8WY
 7XgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

As I have contributed to the m_can driver over the past years, I would
like to continue reviewing new patches.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..835dfe1a16c975fb3ab46bc7ed736cde61ec0bf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15394,6 +15394,7 @@ F:	drivers/net/phy/mxl-gpy.c
 
 MCAN MMIO DEVICE DRIVER
 M:	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
+R:	Markus Schneider-Pargmann <msp@baylibre.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/bosch,m_can.yaml

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251022-topic-mcan-reviewer-v6-18-582447fe8c23

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


