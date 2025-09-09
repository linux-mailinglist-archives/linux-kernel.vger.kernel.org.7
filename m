Return-Path: <linux-kernel+bounces-808151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DE6B4FADA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3AA188C6A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A123D7FB;
	Tue,  9 Sep 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S6knxmHL"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252518DB16
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421041; cv=none; b=JxIi9jWbmMLxFBmnhp5gKEBOec6oyLoa2bnB6PI98PNaRjAa//ZIzLVY8f9pCvVvzGpjBDhzIow6ndveESadZ1QLHNZeHoOdauCxKy8IszzFgePc5RfZK5kLevxnt7Q3AfS3DNWqjU1vOXtO7utceRlyeSoS0Keuug7iy4Ww8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421041; c=relaxed/simple;
	bh=TfgD91280mBYMbtyc2gQAhw5K8G243a5cAzgwqvOrWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZMBx8Ye+iYiRF/OR9dELIlaFcNGLA95+hCrQJH8UNqo74wcS2S66ByQ+9P1UXxgmwxASh9lNhtkcfFD3wspY6iXM8AmyovM7tmj1DKSAds+JWRFyiobqpKsJqo4i1UuzwJvQQLRQ5ukPEr06siHBuiyiZuBOuyHQGKXyUrmX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S6knxmHL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6237202020bso5187592a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757421037; x=1758025837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGGblSmY23n3+zeJrFP+XTBfpalkEjJ+yTGcmc0kj3M=;
        b=S6knxmHLDTOOkGkG+JM6Tl0al/mGsZwySLZ5FT/NOZINOuXTSAx3h9kkiaIge2Fhw3
         HSHTRbHSZgSccsG26mfcItetDTkQdwYs0IpayX5cagSjgXLy+YW8A86/SJ1wvkqiFthn
         oPdGwY3himbP0thsAgx5edWaOLVpD8u2iH6xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421037; x=1758025837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGGblSmY23n3+zeJrFP+XTBfpalkEjJ+yTGcmc0kj3M=;
        b=r5nltUw8zkX5j0er4OCsLZbeIpWc3jF+R2CoxnI9hxzN0dx4p5DsG1wXJauutzxYsj
         WZisfp+jxYloGcb9kN2oEC4PRtCBxbuolt/Cpk3fEy21d5wkcJMgZ68ychPVe3qA+2x4
         o1sc9cqViqKaONXdUHDcByAptrf8IKCYxDLKxsjjWD60m3LBi0NlUbx/9x6m7+JDT0sT
         F2YxsayyTI6xP8sg7qaBZbEjIEOnoG6+iDTiReUXWh5S+m8DhxwvW6qsBa4PAU+j9r7f
         VFFOitYF7ZjXOYiYs4aatpRh/RAJjUU1+Kjtz9cdkDH3ywyFq+352/NFkWkuLMdKN7uu
         yIVw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2B3aYIZoHSPQVZ96n3EezRsRhZo/KAms/j+LsKAeEL9+VgV3cwaxu7MvyNOreoohR0jQMe9ptbtWnHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+Yrp7lx0mXqNtQEHloLHEaMKV3vBhliPP3kQzkU0QyDbvePZ
	KrnAh2wMXOrfWMRNjAtUTPHCeJmI5QOAEjjvIGQWlj9yaAtBcRuura0kvHT9F943hQ==
X-Gm-Gg: ASbGncsRb8FCv5jgEXCgpprzfL9xypkPXuX8JXglppeF91O8ry5mfUwt+08D7XMMGEH
	B7Caeb+YmM77mIiusyjGMmx0Byo2SOaxIpsCU9niQF/lVyw2HMuhmqDqFRpJKHcWJtln28eyB4O
	qRnpgfVt+tndqXMcdftpQJyUyIGGFaN44FRri6XS8h54L6FZSFCt9mwFXQSblDyQg9Myg04bw1i
	h+1UNS7KkbzPzcLf34fjZE39xdHM9AKOtwfa0MTsDrK1PjHOiAumNDD5FriojYISu/6fAwKztA1
	OW+M9dPMH8W8MPl6SmJtDyHJqahtgDndHkA6WVFP1Y2qKxMYOqqu7jq+G7Xt7gBuKsXhLX4JUmb
	TMPww1fVzqyBo7f2VgkcGr/2ngSdg+1J6ZBVaHWjzE8KLFvmkrNnOlyG1720DF/ZDzqgD4snGuk
	impDop6rzb1QTw8JM=
X-Google-Smtp-Source: AGHT+IEP5lq99tnWBWbz1GGVF0Gt4go+YIyrowIZeG7BiR/j4Mlu3jscXCr+tcpjkuM3py/ouJ5XJQ==
X-Received: by 2002:a17:907:9342:b0:afe:e745:c3b with SMTP id a640c23a62f3a-b04b13d20dfmr1011225366b.12.1757421037456;
        Tue, 09 Sep 2025 05:30:37 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm2409702166b.12.2025.09.09.05.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:30:36 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH RFC 0/5] USB Type-C alternate mode selection
Date: Tue,  9 Sep 2025 12:30:23 +0000
Message-ID: <20250909123028.2127449-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a flexible mechanism for USB Type-C mode
selection, enabling into USB4 mode, Thunderbolt alternate mode, or
DisplayPort alternate mode.

New sysfs `mode_selection` attribute is exposed to provide user control
over mode selection. It triggers an alternate mode negotiation.
The mode selection logic attempts to enter prioritized modes sequentially.
A mode is considered successfully negotiated only when its alternate mode
driver explicitly reports a positive status. Alternate mode drivers are
required to report their mode entry status (either successful or failed).
If the driver does not report its status within a defined timeout period,
the system automatically proceeds to attempt entry into the next preferred
mode.

This series was tested on an Android OS device with kernel 6.16.
This series depends on the 'USB Type-C alternate mode priorities' series:
https://lore.kernel.org/all/20250905142206.4105351-1-akuchynski@chromium.org/ 

Andrei Kuchynski (5):
  usb: typec: Implement mode selection
  usb: typec: Expose mode_selection attribute via sysfs
  usb: typec: Report altmode entry status via callback
  usb: typec: ucsi: displayport: Propagate DP altmode entry result
  platform/chrome: cros_ec_typec: Propagate altmode entry result

 Documentation/ABI/testing/sysfs-class-typec  |  11 +
 drivers/platform/chrome/cros_ec_typec.c      |   9 +
 drivers/platform/chrome/cros_typec_altmode.c |  32 +-
 drivers/platform/chrome/cros_typec_altmode.h |   6 +
 drivers/usb/typec/altmodes/displayport.c     |  19 +-
 drivers/usb/typec/altmodes/thunderbolt.c     |  10 +
 drivers/usb/typec/class.c                    |  37 ++
 drivers/usb/typec/class.h                    |   4 +
 drivers/usb/typec/mode_selection.c           | 345 +++++++++++++++++++
 drivers/usb/typec/mode_selection.h           |  25 ++
 drivers/usb/typec/ucsi/displayport.c         |  10 +-
 include/linux/usb/typec_altmode.h            |  11 +
 include/linux/usb/typec_dp.h                 |   2 +
 include/linux/usb/typec_tbt.h                |   3 +
 14 files changed, 516 insertions(+), 8 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


