Return-Path: <linux-kernel+bounces-794652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED854B3E4C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276FA3B47DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2B2765CF;
	Mon,  1 Sep 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2o0kfkE"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADA2749E9;
	Mon,  1 Sep 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733074; cv=none; b=eZ0mwSlznr9lu64GxsHM/k3zc3sHhCRSSoOb9YO7kuBrwZGX2p6jIVlNr+r0roVAQf9s1I01LQLc5lSE7jfMlSB+wZTuEaOlZuw5AAyf9ahzmb63Qr7wXvNzwftZRBK+nTycZtIgYiferKWWGjFZecJmm4P9g4qAU3Oxww0Qsx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733074; c=relaxed/simple;
	bh=6cfI3DwLE9E9SAfgkTqlf+6mrBEBP+O6XCNBkhssvfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jKEfmqHQXlA0ZcN6l4G0+5JP6gaNpG52gMUfHcBO1uGY97HoPJjV3tdXDtnV9x+ajGGjMXsRtYfr7aVYvoCkCsbPvboZPYgZWV2eEqSfxjEITpY7+zH5xmtyPTFZf59plI3CyOPkAhllhP6sf/bOOjR0um1l88lgPU6cQFljVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2o0kfkE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso11167275e9.2;
        Mon, 01 Sep 2025 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756733070; x=1757337870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MIDNnIwbSHuzGfQVuyM2agKWSWdZtsoAJRl1Qc3beg=;
        b=T2o0kfkElRopjXlXrfoG689BaizO1MyYB+1kVq/urHwi+Nz0j/p/7w7fnN2TvX+gcW
         Z4qJsGivgxUdM4lEts54RZs3X3uatbgdO3oUxoEoAFgBX1l+IusHNB8G7qf7DxrcBVi8
         BBtZk/AFUASv8m1OT2ZfIuRBaTWUhxhFsi73kzKSnPCEXRWCll68FZRpaz6NFdXptFZa
         GGOWt637cYPvqaKQZYcFPPNK6IgWhZTDukVRiMap5rChPIgtBL8H00AeEkhp2Jh9R4WP
         73kAohz4+L7D5L7NoWeTaQlpjg0TyfqkK+E/qu7oXcaFVnBeNfhKrqA7v+Duvgb+1VOZ
         tmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733070; x=1757337870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MIDNnIwbSHuzGfQVuyM2agKWSWdZtsoAJRl1Qc3beg=;
        b=dCd0E7wU8SKgw3VrUt9hyUA3GeqQ4wPZMDXwL8Wy0z3Z920moNtNNqcO9R18HLTk/0
         f0XGTtr81cK/i+cJRDmOgVdZqa0hJrtVcAH2CvRwaYFF1Vw1siGZjegsbvQb/NkmZmhk
         GXQshWeSl8ZhGNa3zT1IOwcf6MD0eiWrwkVxy4mueLJl1gBMJs0e6NMbzA+958n2h87U
         rMfHgwDXVBWg0r0+kxOzN61OJBU5cc0J6SL1q1zuoVqz9Gue1AtKA81hvpzHALpuuKBs
         zyhQt49C/e1K6Pfoeo1k0lWY+iolWqGQ/jcrth0pfWmLTF6xjcPsJpv/HZNN6weApFpW
         OYMA==
X-Forwarded-Encrypted: i=1; AJvYcCVmLxzfBJ9pJXOQzePLkqHf3xPwX+temkzW3A0da2IzcZD0zq9oYCh8L7oDuOv5KIEHRhK/80pPsHET3Miq@vger.kernel.org, AJvYcCXQecCCmRHul+MuqyedDgAdWfbhoMlfiFssK5ofwka4PXao/FjznIVnd51AzjdzH2MEAshPArdN+SNC@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQZwVZkTxC5mMyhCS7ZUmwvL8IY1uyAXNP6+oN50321bdbov6
	T7EQt43fbP6UcMelN79V0quI4O1OyXJbi7oAXcAvV+sj0TmgiOpEejEWRC+kxg==
X-Gm-Gg: ASbGncttb82ZpTfLgXyL+a/SDoSztx/7nnUlcodoYDvPtye7X83+JLp4q2Wlw5nsxaJ
	tJTABHfkchgVx6RGpSwZnVTAXNNC3b9jBaD+vSnXI0O6klU6XlSNcL7nni8za+U4981I/+mFG/j
	P7046rSvkQryyXTlBc62twZTDZ222+5qVEu23IlGB+S+JYaq0sXsNlHfD//rFQT8xi3JUJGEeA6
	eFOgAlrwuAS9aCEU2eANZ035k64zxiX8qu0dNK5L9hyruxSIGx60KrrAO5kQcceUpFWHSxqBOZJ
	XQOHz+N1I0oavyLmwE3SiLNU+vPd8ywnzzoXRzgNvnLXJxvCPgeYIMUxn078p7xHgeSHzP0Sz9n
	T/4zdtNDi2C6UI9a/vSQD57obtbbo3hXJnsmYtyE++omU
X-Google-Smtp-Source: AGHT+IGEbizOeslpGdzsgB8Vl8U5tpt8scwfYKa2tgc8UWG4ljvw3Aex7d2kx3CT8e1CwTEmLfUkrQ==
X-Received: by 2002:a05:600c:1553:b0:45b:7608:3ca1 with SMTP id 5b1f17b1804b1-45b8c90299fmr30802995e9.23.1756733069861;
        Mon, 01 Sep 2025 06:24:29 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f2d3c88sm24359635e9.19.2025.09.01.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:24:29 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	joel@jms.id.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH RESEND v2 0/2] NPCM845 reset and clock device tree updates
Date: Mon,  1 Sep 2025 16:24:24 +0300
Message-Id: <20250901132426.3081648-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates the NPCM845 device tree for the integrated reset and
clock controller using the auxiliary device framework.
Patch 1 combines the reset and clock nodes into nuvoton,npcm845-reset.
Patch 2 adds a 25 MHz refclk and updates peripherals to use it.

Tested on NPCM845 evaluation board.

Changes since version 1:
	- Tested in version 6.17.rc1.

Tomer Maimon (2):
  arm64: dts: nuvoton: combine NPCM845 reset and clk nodes
  arm64: dts: nuvoton: add refclk and update peripheral clocks for
    NPCM845

 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 20 ++++++++-----------
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  |  6 ++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.34.1


