Return-Path: <linux-kernel+bounces-732645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3323B06A07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3953B1AA4DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7782D63E3;
	Tue, 15 Jul 2025 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgpuZN/Y"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527D78F54;
	Tue, 15 Jul 2025 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623178; cv=none; b=FYc8rApRLHqPXqKQR0TmJbilIQOhT5ueQmOM4BqQdObgCtRlgCsinVRMzEUjwR51Jx+CgqDRHyR34bzWqPkKNCFLz1UpZkWIkDFkJ01YbyrsQi2zuFHiHAUFAs7L08DSQu5K8H8sqjPYEu3nNLEQmgG+4KLF53jUcGmxygPj4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623178; c=relaxed/simple;
	bh=DK22arM5piKpRcUBPz7s19mi4smGWu8ie6hU90x/a+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFXfHhORr1oUEuTwmJRkZQTQf71tqV5xKg26nVQD0fBlsdXQS6x0/pWZFvcn/Q5B60zyQ8ylYr6TVxV+AZLr2ZHvWvgxvlkPf7D2T1dc6JO03tXxOH6Vm2tyl4ATrLPlL9bWF7rfcoy8rdX3+Qe4ORikTrL9a944vDpNKYaEqQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgpuZN/Y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23dc5bcf49eso74174325ad.2;
        Tue, 15 Jul 2025 16:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752623176; x=1753227976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6uOqHc0cBkDfSSkTti9Y6rMxVXpjXOlcebych3I3Jc=;
        b=bgpuZN/YPrxvU6JJf7OVUCdHM5IvWiONfiFw6PWlWgis3GL/b5hkXtolbvg41FZpIe
         hyT+xPELb+jOkRhYYxdEEJXhWyz8C0ww+3wzXtGOs7hJhgrw3S2wZmH+3vHl/oHUxYcL
         eWXFXZYl7FYKhfWU8Naj8oKsfsTehW72AcT9MtNgaQbBPLc/R0fq7NbVirmVJd/luqe9
         g+dCQuB1ekpB4ygQ6Y8JHnWM4RWpbuyPpq5KECKo4cFXccrPTFLLhIkrEpTQ5KSndZ6J
         WRAlc/hFYrXrQMdT+Q4xWQolBjhC55815iQBzOTHuIvZfBKoBOdxQZ/naPux2m7IQMiS
         7RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752623176; x=1753227976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6uOqHc0cBkDfSSkTti9Y6rMxVXpjXOlcebych3I3Jc=;
        b=JWT17oY6GGQ5bSzjDSfQXTcVyjiXWHS5prI3FMUZ7X0QGh7vHhfe0GJkziS2IZHUFh
         VRCgLdAOqm5HYyY2xOBCe+26Wwu8gcN8ptSigcIGInv4sVxZLa6X+8yHdjI7HpaplWSb
         J1+zue/Bfuu7RCvsWE2G+NW02TtUYTus2uMjOBojUb0Aek35RQoFOuGTowVLbUOQbpgy
         c+8ohn8VZb1emgHEZhVTcRNh21mFp8Odcpsc2szbCn+/8u5Fwi3+FgebhZ/ysAvJZQ/L
         TG0gTxv+bh+SRBYuNWEfrmF8OHwND9Dvi9JaOVR443BiuG3Ax4uT8BnMZ/jEcgNQr+25
         rWDw==
X-Forwarded-Encrypted: i=1; AJvYcCV8UqmySlvehHT/htUikwszwf+PUpIcbXaKN0jX8JMFevn5INvsfAEK6a4N0mGOswwS5324iMCgks8tdS2N@vger.kernel.org, AJvYcCVlUK40payRY5Xq63WKLy5pKoY410YPJriU+/kV5hA8ubvxL6Ac43wIqFkRBvPikILkLMV5kxhq0VhX@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCWSzMm7nNwDqHeX6J6EiFahLfU5LDtNg82Cn5TYLtAknbTXX
	LPURvMCyMQarQ2u6iZrv9GrGInIO9jR0RCYoVBMl0/m1b0ysrfsarR+0wTTvvg==
X-Gm-Gg: ASbGncvpwlc8PROgD9cmfpsxy1k4UNk3/BQn+nuAOtX6N2QysewjkY3dNcN+pzDudN3
	C3nXfMcmTddjVV1f2hMXaSnNAk36JElqmh2x1fPG9T8owwiI2CyDXR2Q/gGBtCnfyT5ohqMGyFR
	u57beLYIF9bW2gNkiAHGtGr8E2ZlvbDkOzmRb1t4MBaY5SyqIZ+mfLGeRDENk4k8P4NS/d52ze3
	u65MH02FtsQq3GM+JxjjMRy0VGrGcixwDrTEA/rE/DGWPjVom2rxe1H+XnZrj58c51PPjvCYrSQ
	F/JyhnM18d/C2TRL8FtQPpzeDkusmS1SSyXkgH3+mG8QdPEfCdiVYgyivJZ/fqith3ruO7ulNAm
	YybTPmonOmoNCJFscYozizpvj9Hun34j/A3L+QZgf
X-Google-Smtp-Source: AGHT+IGOvzlI2x9p9FNOoR3HZVeLsk9c29hCUKe/4zx6nEl4C9WoHp/vsN6AG4v3bedvx46Iuy2Egg==
X-Received: by 2002:a17:902:db02:b0:23d:dd63:2cce with SMTP id d9443c01a7336-23e24f5524amr14555175ad.40.1752623176478;
        Tue, 15 Jul 2025 16:46:16 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b28a6sm120031265ad.87.2025.07.15.16.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:46:16 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] reset: bcm6345: add support for internal ephy resets on bcm63xx
Date: Tue, 15 Jul 2025 16:46:01 -0700
Message-ID: <20250715234605.36216-1-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm63xx SoCs have a register in the gpio controller that controls some
of the phy functionality. Some of the bits reset individual phys and 
need a driver to set. 

The other fields in the register configure phy power and will be set
by the network device driver. 

v2:
- Drop SoC specific patches since bits are sequential

v1: https://lore.kernel.org/all/20250709024740.194520-1-kylehendrydev@gmail.com/

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Kyle Hendry (2):
  reset: bcm6345: add support for bcm63xx ephy control register
  dt-bindings: reset: add compatible for bcm63xx ephy control

 .../devicetree/bindings/reset/brcm,bcm6345-reset.yaml         | 4 +++-
 drivers/reset/reset-bcm6345.c                                 | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.43.0


