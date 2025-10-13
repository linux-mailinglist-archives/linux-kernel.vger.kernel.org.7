Return-Path: <linux-kernel+bounces-850422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB0BD2BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDAC1889CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE8221703;
	Mon, 13 Oct 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWGMWH2h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A50222587
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354160; cv=none; b=epzv/HkDC+r4grOhceCCrtTW9QOgEiwQuNJ+dp/e8dTzjIGwMdL3JgJ/hWhqONUmkEnDf1DD/8FPsrpW5G+6B1vFQ/WcYZWbbma+byKSlaaz5Nocv7fgEqbnuoiUR6YAO9d91ZS77PYstQgmOlAvSVOVUNwFafBL5x2O8N/cq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354160; c=relaxed/simple;
	bh=6uTcdHxYS+9AhbbL5XzNRgen8py51uCv+FaWnKGhkkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZGhqBedFVwTBavqdOsAoG8LPJQuikgzoVciwbH7p490ddwQFtaTyXLc6NIFfvQNrJkKRIbi3sin8ylj5A+xdBOoCAQxwPl3H+zBjYA5beobO4KJGR/WjV+N0obaexIe91E1MzTP/52+hGkDmXt15dwU+8rL1NlrMucBpOGOMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWGMWH2h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760354157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=61Utvg9LwLcHKeJsFrKrzFO3e/IAfbPbmM/8491Uo7k=;
	b=PWGMWH2h+iBE0n5zi6pX8Ylf8gkIdyxewv8YJW1hjXD1TMQwb4UYOSq3dUarf22gyXoEC7
	BLM8rHo4Bpz4MNCVzMdyHme5A3GHluG6LMTnebJr5d8AhCwsikq5+HS3ZTpHyJycJh0U43
	ar6ByyZRbTDWW62ileYzSIl98PsSxpI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-QA-vt4VCNvCMUEvdrCYjNg-1; Mon, 13 Oct 2025 07:15:56 -0400
X-MC-Unique: QA-vt4VCNvCMUEvdrCYjNg-1
X-Mimecast-MFC-AGG-ID: QA-vt4VCNvCMUEvdrCYjNg_1760354155
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aff0df4c4abso566270866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760354155; x=1760958955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61Utvg9LwLcHKeJsFrKrzFO3e/IAfbPbmM/8491Uo7k=;
        b=kbd941C5Yo/ZfNrPvFpBP23g6BOwZde5JveTiz1UtBoZRLOHutvIDlxbt6mWd+OvJb
         5YM+VMHZpIBxB1tagbyg4Fhezm8h5o3bkKo6macVMDqV18psjuKMwHLD4LdfglGHfwG4
         35BH0xGvKW3h/IPhoOdn2S+r9+Xty1RjQOBohImkDc2eSVgwq3DsaggJ5Ne7D/Fy+Xdw
         bZRm2Wghuk5GYQetnZeCPB5VbtLz2obAYydtK9MfwMYq3MIqrYUTNofl3efPGCe8cf4o
         E+uT0HxLO9xDKfP8OtvT0kNEZPuHD3iXwUFcJU0gmFob0mHHBI8ewPl5fJfAsmYvAEM2
         Ifcg==
X-Gm-Message-State: AOJu0YwenDAHHVmRwkcNraWw3F0tik+Q4gHo61mls6UcxDV0QtqmbooZ
	UDKEgiEeD9yiFmaYSSMBSTD/WGVaWlyQhwN8v9DsS3qSlvblkL6MPr1dfA/CsHSGbOx2Y0nMUQY
	T4x8k0kb/srHoGA84LpAkltxNAWt8MVkqLcxr3eCL7Si6Gj4Gz6KANhd4SDlmx5tQHgoxYWa9Bu
	/6E8A/vsZ6OawPOzk5xwsKXfNDdm14KRI+pz4JGzWc0k5bjwBxZWsh
X-Gm-Gg: ASbGncsn3SgbglsepoXp30S64w0XhkBqedwVu1QtgXIC/1fUoLMsKuav44/W1gcnPUO
	jcaIPUO14tz3j0xHZa6WXPH7nJUETfzc+RV9IH/gNEcu4se61DqYj0GXYRRzq7wapOhXRF11+Tx
	Slu7e5CZL+RK+cGSDKGhWqLXNj6nmP4JgAabJbFMXo8n96CwGpJtu8ZTkfeuJVn+8Go6Lq9RmO0
	ytZhrRl2HM+tJoSLqJ+tPJZwArk3lflFPxeGoVS+Y5NSCsY/cYrdtzHy2XxjEM5q5XjjIdorH8Z
	fQX04WrSJCUvTgteoJL11Sgg2XEUXplmhUIcEAW/JJiH
X-Received: by 2002:a17:907:25c6:b0:b3b:4e6:46e6 with SMTP id a640c23a62f3a-b50aa393beamr2047105566b.1.1760354155256;
        Mon, 13 Oct 2025 04:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUqBMHoqhVV+uP7cey3LAt770FSA4Et8Avsavd59CQxq+OTW7LvyN55HaT1Bq0FyA9hJprYw==
X-Received: by 2002:a17:907:25c6:b0:b3b:4e6:46e6 with SMTP id a640c23a62f3a-b50aa393beamr2047102566b.1.1760354154847;
        Mon, 13 Oct 2025 04:15:54 -0700 (PDT)
Received: from holism.Home ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad8adsm917336966b.7.2025.10.13.04.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:15:54 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] Add UltraRISC DP1000 PLIC support
Date: Mon, 13 Oct 2025 12:15:35 +0100
Message-ID: <20251013111539.2206477-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the PLIC implementation in the UltraRISC
DP1000 SoC. The DP1000 PLIC claim register has a hardware bug where
reading it while multiple interrupts are pending can return the wrong
interrupt ID. The workaround temporarily disables all interrupts except
the first pending one before reading the claim register, then restores
the previous state.

The driver matches on "ultrarisc,cp100-plic" (CPU core compatible), allowing
the quirk to apply to all SoCs using UR-CP100 cores (currently DP1000,
potentially future SoCs).

Charles Mirabile (2):
  dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
  irqchip/plic: add support for UltraRISC DP1000 PLIC

Lucas Zampieri (1):
  dt-bindings: vendor-prefixes: add UltraRISC

Changes in v2:
- 0002: Changed compatible string pattern to SoC+core: ultrarisc,dp1000-plic
  with ultrarisc,cp100-plic fallback (suggested by Krzysztof and Vivian)
- 0003: Driver now matches on ultrarisc,cp100-plic (core) instead of dp1000 (SoC)
- All patches: Added submitter Signed-off-by to complete DCO chain

 .../devicetree/bindings/vendor-prefixes.yaml      |  2 +
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  3 +
 drivers/irqchip/irq-sifive-plic.c                  | 83 ++++++++++++++++++-
 3 files changed, 87 insertions(+), 1 deletion(-)

--
2.51.0


