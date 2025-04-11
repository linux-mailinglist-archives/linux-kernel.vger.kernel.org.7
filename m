Return-Path: <linux-kernel+bounces-600907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27FA86620
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 21:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13EB41B81CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4B27C142;
	Fri, 11 Apr 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VfxAjSzI"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE71EDA05;
	Fri, 11 Apr 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399202; cv=none; b=dFFK3UtlJWJlwl+JqHdKozTjD00crgwbp8QcbrprIXpRTCEYPSfoxVfR475JAI30l2LlLarvZD8Z1TwzS4+jKLFqeZEydWdfseDhJQ06nABNUPaPA5gdVp1n4WjHtgIgj3TYtapledWzjtKRdvHlWId6r53P8FIdtjUY/mZbtBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399202; c=relaxed/simple;
	bh=qYerzF/cdMUIx0P3v50QR4vUKuSy22/vJobDutje1Jc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hF3Q+gkpIeZNABvWD/g9mKZm0mvkAD7cgJu8Aj924JalBny5ILnitAnHJSSc4rOSwMBAyRlAkJnXlJ/9U2wJe/vHkFA8BM1DLYrDtJhnNg9QMbU2xPzO+FFv+2LKe+s0gJ1a15LP2VrnJGQisims8yEPcZHANwQWDUJDgkpRAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VfxAjSzI; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F4EE43ADE;
	Fri, 11 Apr 2025 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744399192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVUpTdeC6nDu0r8hpDYQnT/emEPdMbOx5LO+AECagUo=;
	b=VfxAjSzIQMoeqZ8Veo8Yu+72x5N8jo1LfS/O+LT/ChJOQT1nXbvrKnt0uw8XSUgIwsZPl/
	B+9QHmh9GM+OLX9QiUcIy1C8p4ioT2AaAsKst8aYWtRbRX72zVhW7uQcH8e3v/1r5tyt2J
	sJJLiyb4dRY1PfnpxRYLN52/1Js3vGhCxqGSHgBLrpZG/cyNlLaEh+ZAPFaauCa7ghbeFp
	/WmaLQlsaKAYH/Iz9ph9lmdsTcvyiJKpyBcffBCmCFPL+9n/jiVzXP9UPsMswqCt6PBvI6
	ZC5VFF8g0adUQUYHbspnPr9DSzlZafmIoAnPh3eCzLWmgwKGijpsUR+u1+JjFg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3 0/3] drm/panel: simple: add Tianma P0700WXF1MBAA and
 improve Tianma TM070JDHG34-00
Date: Fri, 11 Apr 2025 21:19:43 +0200
Message-Id: <20250411-tianma-p0700wxf1mbaa-v3-0-acbefe9ea669@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9r+WcC/4XNQQ7CIBCF4asY1mIGEEtdeQ/jgtLBklhooMGap
 neXdmNcGJf/S+abmSSMDhM572YSMbvkgi8h9jtiOu3vSF1bmnDgEgRUdHTa95oOUAE8J8v6Rms
 K8tSgUrZFW5NyOkS0btrY661059IY4mv7ktm6/gEzo0CZEQxErUVVw6UJYXw4fzChJyuZ+Yc5/
 mR4YbBFZaQWVgr1zSzL8gZ2J1i4AQEAAA==
X-Change-ID: 20250307-tianma-p0700wxf1mbaa-056be88fdef9
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 "Pu, Hui" <Hui.Pu@gehealthcare.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgieetkeekgfdtudevueffueffveekheeiudfhfedvhfeukeeuhffhtddtvdekfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjfhuihdrrfhusehgvghhvggrlhhthhgtrghrvgdrtghomhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgto
 hhmpdhrtghpthhtoheptghonhhorhdrughoohhlvgihsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshgrmhesrhgrvhhnsghorhhgrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

This short series adds power on/off timings to the Tianma TM070JDHG34-00
panel and adds support for the the Tianma P0700WXF1MBAA panel.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v3:
- add Fixes: and Cc:
- remove regulator delay
- add R-by tag by Dmitry
- Link to v2: https://lore.kernel.org/r/20250407-tianma-p0700wxf1mbaa-v2-0-ede8c5a3f538@bootlin.com

Changes in v2:
- Rebased on current drm-misc-next
- Added Conor's R-by on the bindings
- Link to v1: https://lore.kernel.org/r/20250307-tianma-p0700wxf1mbaa-v1-0-1c31039a3790@bootlin.com

---
Luca Ceresoli (3):
      dt-bindings: display: simple: Add Tianma P0700WXF1MBAA panel
      drm/panel: simple: Tianma TM070JDHG34-00: add delays
      drm/panel: simple: add Tianma P0700WXF1MBAA panel

 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 39 +++++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)
---
base-commit: fbe43810d563a293e3de301141d33caf1f5d5c5a
change-id: 20250307-tianma-p0700wxf1mbaa-056be88fdef9

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


