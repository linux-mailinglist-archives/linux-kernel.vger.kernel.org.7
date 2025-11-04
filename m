Return-Path: <linux-kernel+bounces-883873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243FC2E9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B5B1898CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20441DE3DF;
	Tue,  4 Nov 2025 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="SgrADH5w"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B01A2C11
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216406; cv=none; b=ut0pIlMhn1FfDysh3rWzJwNPMldVj+Hu7YYT0mOv+b81ehLU0HlJd9Dh/KgwwA/jP5LicoJ00iFsoOllyDSVzG3EOYqyadf+hQdjkJHFuuS7eKJbtfM8/ULHRG7Dh1OkcFg8vj8um4Bdrz0nGjSFJtx309u4lMrIROOYTak0gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216406; c=relaxed/simple;
	bh=TcYju8n2wQ920cf5z4H9pMb0Z3+C7so+Lr81+sHREOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYHyMkInT6VvW4fUTR50OhFLP7Xq4T6+hPywizpxvBL1+u1qZ8I3Cfe3GeJDNVllPTu6dVGyUIQBp0+hP6JdBGvKJisrAg28YHSlPca5lOBTip3n8yZOhIBz7sFhzeWeYwUnzoBr2GqvD4pJnfhTPRlooxud+NfBiwFiHdXQUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=SgrADH5w; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b9a6ff216faso1629615a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 16:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1762216404; x=1762821204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HXCqgHkp/y6Xvj0pMaw2k9PHANDsHwn/e45azlj4aMY=;
        b=SgrADH5w4yXGc36mKpk81GvbjPUHRY5rwD0u7yX4bfWqHMSc1o6YUY1VBu8ZVLPaTp
         DYxQDzzwSLlrR7NGLnozsnaL8E6bgnv5XdMY3DDsDFC+Q1PcqNmJtUyuQWNXiEnbXCdb
         kxHPxgOYwjm4wtaCklx6hY8ki0Uk8fxDoGKDGeeRY19sQM5y7YIMmMiXDw0COKhmlIp/
         KP7Q307eoUpsYoNbDjQUzyFbSjqj7FfQ3RCP8pu0ugPGSeE9mtFZq9xhvACXq1x/4EnQ
         m1CaTr6E0UQrZ73zShZzHqjQaf4QPIp1JzUOY5rkAi3zq7dv6LBjyCsWGIJDSmTH72+c
         gLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762216404; x=1762821204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXCqgHkp/y6Xvj0pMaw2k9PHANDsHwn/e45azlj4aMY=;
        b=g+vi9gSS41EYdA3tGR3O1HTSo1jVrlwCsZkEE6CJ6iyz8dlydfuMiYPgAjDBpIH+pB
         1JxI/ZS+QP0V6RjO0ik46eV+JxYWEEhxs68YJCGbQU67FuA3IiXJte+Ixa1zeOO5JN/G
         eKuq+w3gnbdgB/SiZfPqoyzPALnX+K+wAQkOm/H7FlfOCKMIjvsL1TJYk//Nibq9X6Oi
         alpu+mx0b8k3QF9UwJGnYmxjtTnaYTjjA1b1gQOeRV5fTu3kODvDDZ4WsTw/5+nQA0di
         HP/xHegXr9ODVxFjk26ngYxsitm/O1vSZgUuE6MBkhfMgDWUzewC/US1v/MF9wj+1czb
         pCvA==
X-Forwarded-Encrypted: i=1; AJvYcCWP6VYGom3yvRtlE4hS8LtB+MP+/qgtlD5WLyQBuA4Sm+d6ByD6PL/JcB+J9wR0Fr1FqQAWDUtVRnNena4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyb+Oa7qJLC5YpFzMo44OtW0qnPSgSWRzyJJFUlq5ynfDTgZH0
	NHNvvmziqFb/3Cy9mO1n72PbITCJloH51pyh8g+DPjndQQOSkx2MySvPXqfJREwf7UQ=
X-Gm-Gg: ASbGnct1aTssE3Tp59wA/hpYuGlGm6TGxdoxJTvTrdP4PAEo8ZVeLI2YA1yYW+ayzqU
	0fErNL7J/Zg1X6xeG5DXuMUQe3TGl7To5AQ0t8BDmCBoBfjlLnI6XiyP5fzPR+xI6tWNpPpFRJb
	MBvY8/LunWp01SNKHZlepqE2B+dxr/37xY9NciHb8OC6Vychk4fx5wp8BsL2FFjfFEC5To2rbj/
	WUBu16PboMuGm6x9rKcUOWKQyFJK6cbOh6nGYee8yArdxeht7At0KAfAtY8ngtYVipdbPTWIZrD
	yOvVxmZecJ+b42f0L7pFfSLR+56fYXjFVRmFWVP2cWpn9Vd2KTK081NiFzjLeEUTdUzB/Nrinyk
	4Gcv6PPUXBk+eb93uE9ZyzFm/3n6RWl5yvJjGr94mFvHDSeeudOeeOSzLAQandBtxVNwPkMh5za
	LDauSv5dGl8MU3rAA84g==
X-Google-Smtp-Source: AGHT+IG5K9xuPSs6yLpF1b4AqM9fFQ4oDhiSJtrDt8p9KL3Qz56dNNylWn90xNwGiCETSOBSEA0SjQ==
X-Received: by 2002:a17:902:e749:b0:295:7f1d:b031 with SMTP id d9443c01a7336-2957f1db28cmr98709205ad.52.1762216403710;
        Mon, 03 Nov 2025 16:33:23 -0800 (PST)
Received: from z440.. ([2601:1c0:4502:2d00:6127:c8ee:79ad:a4c2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f9615c9dsm360123a12.36.2025.11.03.16.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:33:23 -0800 (PST)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v3 0/2] hwmon: Add TSC1641 I2C power monitor driver
Date: Mon,  3 Nov 2025 16:33:18 -0800
Message-ID: <20251104003320.1120514-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the ST Microelectronics TSC1641
I2C power monitor. The TSC1641 provides bus voltage, current, power,
and temperature measurements via the hwmon subsystem. The driver 
supports optional ALERT pin polarity configuration and exposes the
shunt resistor value and update interval via sysfs.

Tested on Raspberry Pi 3B+ with a TSC1641 evaluation board.

v2: https://lore.kernel.org/linux-hwmon/20251026065057.627276-1-igor@reznichenko.net/

Changes in v3:
- Updated devicetree binding to include optional interrupt property
- Added shunt value clamping
- Changed limit attributes from lcrit/crit to min/max
- Improved limit handling to preserve register content,
  (current limits might not round-trip exactly around extremums due
  to inevitable rounding)
- SATF flag handled properly
- Misc. small fixes

Igor Reznichenko (2):
  dt-bindings: hwmon: ST TSC1641 power monitor
  hwmon: Add TSC1641 I2C power monitor driver

 .../devicetree/bindings/hwmon/st,tsc1641.yaml |  67 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/tsc1641.rst               |  87 ++
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/tsc1641.c                       | 748 ++++++++++++++++++
 6 files changed, 916 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
 create mode 100644 Documentation/hwmon/tsc1641.rst
 create mode 100644 drivers/hwmon/tsc1641.c

-- 
2.43.0


