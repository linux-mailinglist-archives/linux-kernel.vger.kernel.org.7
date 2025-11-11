Return-Path: <linux-kernel+bounces-895002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EFAC4CAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D12B4218C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E422F5302;
	Tue, 11 Nov 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="o1M2zbtW"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDF252917;
	Tue, 11 Nov 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853428; cv=none; b=YGkIsm8QNDp9+kK+VXUtLv2KmhkAHKFZGEQmC8BD89kLuafQGE/x0shcDweN54rD9QC69odrKgbxi0smCgff+zJZDl4adKnsHTZjNJF8Yqsj12ikkM/RNZ3vXpLuSiUmEG52MPy7ZwwK+uQu2EtLDdYZgdj5ZvEacu93J5pp9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853428; c=relaxed/simple;
	bh=wZlXKpo31e6AwXUa1PoRqZsQUj2wSTY2D7ak9f58Epw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bfDTptjSzQMC2M0EF9cnSZNlpQIqrDCIddX+NyZwUr6G42JhUsJmuYNAQifDZaYgdNgjDrHpZmg11WB29ZGibA/TXhlCUCvM54xdHtStlZlIyzt4OigRfpXEAS7ixFErbcBlXWjtFYRqrhM/AfSk/6Sbzl2ya3gtiGM9PS7K+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=o1M2zbtW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB9Tx3123459970, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762853399; bh=zeWT3GTJIw4w5COTfo8dZqC5rvaiOYf+o0PYphGr73M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=o1M2zbtWcPQCoSDoG8Qv+TDygGAPd8fsew0wqyWi6KPFDY4XxBL25rq8GdhOUQKH/
	 4hBqdC5SM26Gbgr0hkYFiBxHCXUuUOeVlCUx8V31xAJW6hwpNCMgNms3MPEdLaM9UT
	 wyVN68JLGRC8UfFjwFHrqfx+S7558kU9kSpFYTxyPLDvKkqU1M6uPV50/SQ3A/shI5
	 pybEiyewyk0aLGBeGEqs2mB1DEkxD4n5pA4i5BwG8CISabUgQOOFEdcNEao5BpOG7S
	 7VuD0p5OztASMrR3/QaVM8XbdNnMK2OJN1ayVUpmGMUtO5WZgyFXhdsR7CfAfKAZup
	 VgslO6r47+1nQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB9Tx3123459970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 17:29:59 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 17:30:00 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 17:29:59 +0800
Received: from ww-haowen.ting (172.21.177.97) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 17:29:59 +0800
From: Hao-Wen Ting <haowen.ting@realtek.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <jinn.cheng@realtek.com>, <edwardwu@realtek.com>, <phelic@realtek.com>,
        <shawn.huang724@realtek.com>, <haowen.ting@realtek.com>,
        <cy.huang@realtek.com>, <james.tai@realtek.com>, <cylee12@realtek.com>,
        <phinex@realtek.com>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add Realtek SYSTIMER driver
Date: Tue, 11 Nov 2025 17:29:57 +0800
Message-ID: <20251111092959.616089-1-haowen.ting@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the Realtek SYSTIMER, a 64-bit timer
that serves as a tick broadcast timer on Realtek SoCs.

On Realtek platforms, CPUs can enter deep idle states (C-states) where
local timers are stopped and powered off. Without a global tick broadcast
timer, one CPU must remain awake to wake up the others, preventing all CPUs
from entering deep idle simultaneously and limiting power savings.

The Realtek SYSTIMER remains active during deep idle states, allowing all
CPUs to enter power-cut idle states simultaneously. This significantly
reduces overall power consumption while maintaining proper tick broadcast
functionality.

Technical details:
- 64-bit timer operating at 1MHz fixed frequency
- Supports oneshot mode for tick broadcast
- Uses standard TIMER_OF framework and Device Tree integration
- Remains active during CPU power-down states

Testing:
- Tested on Realtek SoC platform in ChromiumOS environment
- Power consumption reduction verified in deep idle scenarios

Patch organization:
Patch 1/2: Device Tree binding documentation
Patch 2/2: Clock source driver implementation

Best regards,
Hao-Wen Ting

Hao-Wen Ting (2):
  dt-bindings: timer: Add Realtek SYSTIMER binding
  clocksource: Add Realtek systimer as tick broadcast driver

 .../bindings/timer/realtek,systimer.yaml      |  54 ++++++
 MAINTAINERS                                   |   5 +
 drivers/clocksource/Kconfig                   |  10 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-realtek.c           | 173 ++++++++++++++++++
 5 files changed, 243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,systimer.yaml
 create mode 100644 drivers/clocksource/timer-realtek.c


base-commit: 948b99877bf5a1cd58bee930e455b7574daba5c3
-- 
2.34.1


