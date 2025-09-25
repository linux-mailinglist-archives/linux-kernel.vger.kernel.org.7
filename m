Return-Path: <linux-kernel+bounces-831485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9FAB9CCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60CF3B0F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069BC625;
	Thu, 25 Sep 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wtFEaTBO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MSzhA+pQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wtFEaTBO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MSzhA+pQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F01367
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758721; cv=none; b=T1knPaquuabZL316YN1axIYQtSzPAibhhr2Q52BiF6l+0T7lebgFaO9QOTqhbxd5v6UgbR69/5rRXwCKdyDaA0MeW4AP6085N9nItxZ5IWMK45PnBaAtW2UPOtCZXdb1hqmHuc/Zf3fQrA2tx5oK5CrDKVlHRJ5YUwWcGFQmdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758721; c=relaxed/simple;
	bh=hcyZjaQkIyzACf+jXrMXY8I4re3IS/UHj+lJ3IGqgXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C01xvc/gSI5yFFcC+6HGJWcalS63KXxw7+xRPqd/CfCeZjm9VSm6kCLhj5SBrMIKlzSjuut+XsBl2xsk5Bv03akyCPLaGONTxvCyI6qiCyVKZbsuuLAVUU3Fg4lggHDvLgVaXOaHWK9Hcj67i2ymDnMNZxDL69ZNooiVY4m/lAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wtFEaTBO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MSzhA+pQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wtFEaTBO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MSzhA+pQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEAE63EEF9;
	Thu, 25 Sep 2025 00:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758758717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PxXXH7kpELvfYY5/wXkAikODv5sI+30bpti3onSO2Ug=;
	b=wtFEaTBOpvWYZy4Uj8iIlwMrWupwmE6VZ4Hk8+c7n2CAlPOA+xPrE3B3eNtII45tbgA7F4
	8hfIHUZmuW1tuX/T4a7Nlw7Aezz3MzWKHQES+2e8l12VILurYdNBsR/yRYtXiOH6p5dXm8
	vacXTmbcJvXEZQY1uiswPDJqhuIFsZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758758717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PxXXH7kpELvfYY5/wXkAikODv5sI+30bpti3onSO2Ug=;
	b=MSzhA+pQDu7DzMYmVCTVhdZXPGnzQSBRXCuPhYcmZ8CVYEdwBK0zJrsGGv168J461D462G
	CCWL2TTI9tGNgECw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758758717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PxXXH7kpELvfYY5/wXkAikODv5sI+30bpti3onSO2Ug=;
	b=wtFEaTBOpvWYZy4Uj8iIlwMrWupwmE6VZ4Hk8+c7n2CAlPOA+xPrE3B3eNtII45tbgA7F4
	8hfIHUZmuW1tuX/T4a7Nlw7Aezz3MzWKHQES+2e8l12VILurYdNBsR/yRYtXiOH6p5dXm8
	vacXTmbcJvXEZQY1uiswPDJqhuIFsZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758758717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PxXXH7kpELvfYY5/wXkAikODv5sI+30bpti3onSO2Ug=;
	b=MSzhA+pQDu7DzMYmVCTVhdZXPGnzQSBRXCuPhYcmZ8CVYEdwBK0zJrsGGv168J461D462G
	CCWL2TTI9tGNgECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC9D61386E;
	Thu, 25 Sep 2025 00:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wls7LzyH1GgdNQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 25 Sep 2025 00:05:16 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-hwmon@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 0/4] Add Raspberry Pi's RP1 ADC
Date: Thu, 25 Sep 2025 03:04:12 +0300
Message-ID: <20250925000416.2408457-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	FREEMAIL_CC(0.00)[suse.com,roeck-us.net,kernel.org,broadcom.com,lunn.ch,gmx.net,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.net]
X-Spam-Flag: NO
X-Spam-Score: -1.30

Hello,

The following patch-set is adding support for RP1 ADC driver,
and enable it for RPi5.

Comments are welcome!

regards,
~Stan

Stanimir Varbanov (4):
  dt-bindings: Add Raspberry Pi's RP1 ADC
  hwmon: adc: rp1: Add Raspberry Pi's RP1 ADC driver
  arm64: dts: rp1: Add Raspberry Pi's RP1 ADC DT node
  arm64: dts: broadcom: Enable RP1 ADC for RPi5

 .../bindings/hwmon/raspberrypi,rp1-adc.yaml   |  46 +++
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  |   8 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   5 +
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi  |   7 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/rp1-adc.c                       | 301 ++++++++++++++++++
 7 files changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml
 create mode 100644 drivers/hwmon/rp1-adc.c

-- 
2.47.0


