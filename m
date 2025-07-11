Return-Path: <linux-kernel+bounces-727856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1ACB020AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA562765786
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13E2ED171;
	Fri, 11 Jul 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gtHREV1U"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D902EE26F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248555; cv=none; b=QmOsfM4W1VRmjnuiR99N8aoA0YgkHUV7ySfUGCKbG1igN06O6j2C4yxE+pJgO5DAOMHk8EZe9YfvaASOxSo93OuLmpuJEsLK05A5J8bvNILMQ9pNP4deHfkWP7hJuNwl/NAptYY+srqrZD1bZV2cF0JSmEvFFTlbv4h9mkX2gTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248555; c=relaxed/simple;
	bh=iF8ihvJBIUayCH7M+0g/FxeDaHneCHPNV7PdfMD3EjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLRiKiX+XCK47oVa1E2CYbD7cLLPc777/9OpNvGMKgyFvxM6WwpeX1MA733+e56263cs1QAozD9Ofo0hCa1x0ZRSY+H6r9bGSB6kGpGc0522Bum/ptmIZ5PUyWbdKEnScN0Bf0VU2QzWMY+D5++SD9Z4VV/UZFt3xLWVPMwQyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gtHREV1U; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2206982b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752248553; x=1752853353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7skpOByzW+hOTXagKwoSr9X/HjtkTFtxhdBwxlew5M=;
        b=gtHREV1UN0iNImAXaqVLfkwOSS0oYfzXpQdsx35pW498V5lEPuY5ytmaRLMym/+6lr
         vzNtxX+Mlf6xiiOeN3eYbs41DVi6z6DjHvshe6cpO//imMI1sHb6jlEFPjdmz2OhYFu8
         oLAUArWh18dVFFtRV+yfLdHbGhsz40n5Hq7WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248553; x=1752853353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7skpOByzW+hOTXagKwoSr9X/HjtkTFtxhdBwxlew5M=;
        b=rlQG+gWUUl6g5wyUKlGCny1f2vTQgk83o2fEJkX0MrJfw08XljXMCJG4hnAS0Ghs2m
         aLCjseH7opkw6moaWMELN+6MkrMN1AbNjTiqia3Y6nxHh+iCHURyAMbabKk2hKtuV4aW
         AvOQgQB5Vh3wnqFtc4hxror8FLqYQ0aAm+GxUOunpxnU/f4rFJGglve3L4IjbHF/JOo3
         FIjTCX5my4gClNrydjoEmZt5xLbE5hK+ExvL9qoE0F5obn6zKhBzRKvaT5duW1YYkDV0
         rLWoUN4b0TOXYf+/B5c6rHftSCo5TWQMghd5frg+MHTLaR03AW5SF7ikrma2QUXtB1DO
         EjXw==
X-Forwarded-Encrypted: i=1; AJvYcCWpvgaFVM0oq2ojBxm1PF7gJ6E8qoiCcz5bIWBnXkJyKKNfLbuKx2KbgeOCbDJ+IQS6RNnhyjVsNjCxx7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDBB6IWNJrZsnXDl7Xl4KGNdTuJ5lMF78xRV9f+fB1L4H98jE
	lI1eN38qSPJ8n68pgZ6Ux5gozdbM6Ceyb4mzGB2RfnukyxNOqkE83QfL+f9HdRe5Dw==
X-Gm-Gg: ASbGncvnOMej/L8iOX+JAZOimAAL9UaGhUflkkks0LXscxewjFxcsWKaeloSRIXMpNm
	B58Xvr2HEipEtOHPL3cnhoeC6w0I9dJqwAt8N4wTRfnpZVkrr7OsnT0pHrOBl2kY9PFEiifoHnC
	OY1ecGvONv3AiP271CcRG/ph0tpxG1Tk4eYXW2m0oQH9ydTnWMtrnNs1nYw7P8rjd5Y3/8jiIoU
	FB+P1pN/phuZo0D/KsQYWGYfOyT1wcwN2NAgb0Uv6DwLf7zseAgan5W/Squ0EtbjUdUJQYLNPo+
	hmlu0Ps0puvvt5mcXDT5tzK6FSQTWpalMC98Mad0Bo8OPGBaPTJyypMi4tyu4qxWko+eMG9qUyJ
	4SPwAX2VK9/x1PR32XBaUBaAVH2KRXrTEfxb6zmtOZ7ypjHM4ypOHQtxX2A==
X-Google-Smtp-Source: AGHT+IGDEkar+diQDXAFzWseo9mmENOlTrd0V0FLWObaE74a9KCtE2gcym2rmo5BmC5WxmqYeQa0ow==
X-Received: by 2002:a05:6a00:188c:b0:74d:3a57:81d9 with SMTP id d2e1a72fcca58-74ee0ab538cmr5458867b3a.8.1752248553448;
        Fri, 11 Jul 2025 08:42:33 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ccesm5762420b3a.27.2025.07.11.08.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:42:32 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	kamal.dasu@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH 0/4] mmc: sdhci-brcmstb: rpmb sharing by claiming host for TZOS
Date: Fri, 11 Jul 2025 11:42:17 -0400
Message-Id: <20250711154221.928164-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711154221.928164-1-kamal.dasu@broadcom.com>
References: <20250711154221.928164-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support to claim host for TZOS RPMB access and synchronized
access to the controller hardware using hwspinlock framework.
To achieve this Linux OS and the secure TZOS make use of:
- shared hardware semaphore register
- a set of SDIO shared work registers and
- IPI interrupt registers 

The currently running OS that needs access to the controller puts itself in its
slot of work register and if its next in line it can try to grab the hardware
semaphore and complete its mmc requests. The shared work registers indicate next
in queue to access the controller, and current agent in the queue. Next agent
queue state is changed under the hwspinlock is owned by the current OS accessing
the controller hardware before release the semaphore, send and receive IPI
interrupts between linux and secure world are used to indicate completion of
transaction to the waiting OS. TZOS has its own RPMB driver which accesses
partition when it wants to read/write RPMB frames. Current implementation
assumes Linux and TZOS as the two work agents.

Kamal Dasu (4):
  dt-bindings: brcmstb-hwspinlock: support for hwspinlock
  hwspinlock: brcmstb hardware semaphore support
  dt-bindings: mmc: add brcmstb share register and hwlocks reference
  mmc: sdhci-brcmstb: rpmb sharing by claiming host for TZOS

 .../hwlock/brcm,brcmstb-hwspinlock.yaml       |  36 +++
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  29 ++-
 drivers/hwspinlock/Kconfig                    |   9 +
 drivers/hwspinlock/Makefile                   |   1 +
 drivers/hwspinlock/brcmstb_hwspinlock.c       |  98 +++++++
 drivers/mmc/host/sdhci-brcmstb.c              | 243 +++++++++++++++++-
 6 files changed, 413 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/brcmstb_hwspinlock.c

-- 
2.34.1


