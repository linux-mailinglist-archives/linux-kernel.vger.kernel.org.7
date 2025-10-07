Return-Path: <linux-kernel+bounces-844019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C7BC0D84
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 192514EFC76
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE02D77FE;
	Tue,  7 Oct 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="o/rzLmJS"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E002154BF5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829016; cv=none; b=Nvhn6IwPCwpIQIF0SH+n10SMJAB7YH75x5ti6QStodBi6zYd6UAZ2Im2mmt86JeLgAqcc80APTrgcUCV+Inw4YU3prUWmrSNILITYqXr8npeZriGdzffHrXUNdeKm0K4NeMU1Yx62xoG9piSvDimw2BRZ/DUUyP8XpibYv//A2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829016; c=relaxed/simple;
	bh=OyjOTab8mpNvoOfusTuJ3kewJnbeyW2Tdc9RzvHdAeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q59BXHFYyskPS2QixgOqK+Bak3U2mYHJCr8YdTr0yRngKVabYFxFsHGr1v7IOimVulT7IEPSKXaWtsrhQvUxjSVK6wXxWmji7c0jh/OE4bcgp1x41/yR2aPOo+si1hYIA+9kkizk3SkvbqTFMDtBlpCuDBIw/f+eTAQ2EiB5tK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=o/rzLmJS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f67ba775aso7936740b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759829013; x=1760433813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BMrreGYaM+ETQ7wh1dqgwXsdvPXSRmjMBiX7/QH9P8=;
        b=o/rzLmJSzvU+bl/b5A83rPIePTO1rSYrAurGBRr9Kb3MfK0vwefQYDA8jegUJvh69w
         UiGz020TWipS40Lx58rOw5pzRqQK88NYtMb+Ktwzqj7vbiMYdgHrTNNgJNrpiJTQ0kwu
         f+hb/k8KNQnGxHEZGFMwU7zPqV6m+asSc7c6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829013; x=1760433813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BMrreGYaM+ETQ7wh1dqgwXsdvPXSRmjMBiX7/QH9P8=;
        b=di1OF1DRNZ1oI1FV504pwrp6kUz4ODidMcxL7Ek3mTyreGjwzrsTGScEF1WlGuS0As
         DjnXXRA26X8i0M5oja1Vx+Mhh0EnMpk4oHTWFZgqOjkO8GuW7lTklj5vI0x3nfyiCNUt
         Ua3KADbP2fS/7iZ176NGd3MwPuu9HTnCHpEUEGsAtVfY3cPe/UP0DJz2McUta/+I+W8+
         nZQDk3bI3Wqy3P3pWl3wHdotiKFrelbg34DO6Z5Mcwlj0IQw3PYFWHA4bvhUKfIWvR4R
         JPpHbZ54HcHiIzXXsqQVG4WqFkOTmvLjSj/5054E0/2ll3FjiZ8pKbP8+BEdnGFbRHqx
         euOQ==
X-Gm-Message-State: AOJu0Yz/iySWQbqJkyMVOl5y1Pxny2X8MJ1h7IAXzfvdE88FqkR0i5E7
	Tnu0tthLSI1IjOoAFHnpjDC749r/9+vGMaFOy/XIHXfgycuwsdeSuDvzERCAd4f/TOA=
X-Gm-Gg: ASbGncsNAij8UaMJQxAxfAd6HSTaSx1gwYDylnE5O7dE07P/F8p/9Ipp5nlnMxJoS1g
	zr3EOalX/N/Xg5jQbA9nDt8evaegz7W8avh6Ioz+KtXLSfthq2ti1A760C0gVVJKv17EFA9rka7
	sB3mVWkcSQDonJHXJYMLaapKX2QVDHCGaL7tEhV8ob5l0tbFEPClwx00xWztosgqpay2h7W52+f
	AGDz1pERtuNuxBcWln45/fhXIjvKIGo81Fvbz55h+PFO8RfnaTVIUF7JBH0UwIfhhBss8qnwKs2
	wHSkGSk2RVN17c3h5nGeoDQe5stRGegD1ZYvdttS7AshS/bwqwgPXq71hHvB7mOCYqIYP5RBSiz
	lErvBD+QmD3auKVw1UuaQpyL6RYzNlcLvOAeZBuD8a4JM2oHI4O+y5459nfPZK56ZXIA9Y+hENt
	msitTIlp02B4Op9u9VbqjRuLuIXfxsnlmYEDQ=
X-Google-Smtp-Source: AGHT+IG2M1roqWj3uq0lJ8nnzGjIVwpT4KjTyGoeZ+ChvFAl/lA0gtYsMYOlp2/3j2ZlBG1u6YV22A==
X-Received: by 2002:aa7:8dcd:0:b0:792:52ab:d9fe with SMTP id d2e1a72fcca58-79252abe295mr2218766b3a.0.1759829013136;
        Tue, 07 Oct 2025 02:23:33 -0700 (PDT)
Received: from kinako.work.home.arpa (p1522181-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.198.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm15123273b3a.5.2025.10.07.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:23:32 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-m68k@lists.linux-m68k.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 0/5] PCI on the Amiga 4000
Date: Tue,  7 Oct 2025 18:23:08 +0900
Message-ID: <20251007092313.755856-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a driver for the Mediator 4000 PCI
bridge for the Amiga 4000.

Since this is my first PCI driver it's probably awful
so this is an RFC and also there is one interesting
unsolved bit:

As far as I can tell the Mediator 4000 cannot do DMA
between the normal memory and the PCI cards but PCI cards
can DMA between themselves. In the AmigaOS drivers a
bounce buffer is allocated on one of the cards that contains
memory, like a graphics card, and that is used for PCI
DMA. I'm not sure if that's even possible to do in Linux?

I've managed to use a network card that doesn't need DMA
so far, but I'm having trouble getting a Voodoo 3000 or
Radeon 9250 graphics card to come up properly. I guess
no one tests their cutting edge graphics drivers on non-x86
machines. ;)

Daniel Palmer (5):
  m68k: Adjust the pci io range
  m68k: Increase number of IRQs for Amiga to allow for PCI
  m68k: amiga: Allow PCI
  zorro: Add ids for Elbox Mediator 4000
  PCI: Add driver for Elbox Mediator 4000 Zorro->PCI bridge

 arch/m68k/Kconfig.machine                 |   1 +
 arch/m68k/include/asm/io_mm.h             |   9 +-
 arch/m68k/include/asm/irq.h               |   4 +-
 drivers/pci/controller/Kconfig            |  11 +
 drivers/pci/controller/Makefile           |   1 +
 drivers/pci/controller/pci-mediator4000.c | 314 ++++++++++++++++++++++
 drivers/zorro/zorro.ids                   |   2 +
 7 files changed, 338 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/controller/pci-mediator4000.c

-- 
2.51.0


