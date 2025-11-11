Return-Path: <linux-kernel+bounces-895777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A11C4EE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 701444E5063
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5E336B06C;
	Tue, 11 Nov 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqaX+XIi"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585736B04E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876593; cv=none; b=mOZZP/SAEjFSUiyohPUzb5DMcuBCMH69gr8F8gdU2N+drvu+2H2G2dhNYrYy/6E4kX0hlw+SrOgt0STJmzG26zrcCGs4HP0sb/UoAxaw/ln7rbiT4WeorFGfIItnHs7dRJKtU6/IK3pGSOglKqistqoeHHRb7smWKr6sWrkfcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876593; c=relaxed/simple;
	bh=R/BxvRnYDhmJfrosntBUW73LUr2aXcwvJAtyfPOFZHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/Iw4BFRDLI9vC6oG0etaaeu5R8K+AjHFcGaIZoGMODf0m8cVgme88MXp2mUOk/MqeEZ1oqQU0jwdYKM72grQHRMFHj72Ydqgw/w/c+uwammX0R4uZDw9ZzmNb/SdhYONtsnZ9SLzikX5nm16cH+TrnCybnR7wqTtuRQtinInOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqaX+XIi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b32900c8bso1525731f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876590; x=1763481390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wn1gmvaI3HpYNhR73OUUMc76SwfBuC0tr7WC7he5oYo=;
        b=VqaX+XIixQFuymwyNS3v2erA4attzBLFXoOwmPv9ZvZnimenfEtc/JIvX8J3e5iItl
         gNQ+GoHnNSi/dTBLnc1+ZtLvc9s0PDVnmgpnrSRpGG3ftPCNJpARLTqYGw0h0SNtSK4p
         jnwWc8sWxi3pYuNI9IGw5EHp0Bi9vDUbwwUW9dMGxMD/T2Bqwy/jnppxO6pXdG/cT64x
         9/6vyJDq1IgK9FBoSARs9a5UOcD7VHp7Di2QD5loYuMtFctYdYy9qT7waxPEYRlWlxi7
         Qy0OprpeIJ/MP2wFmVuBTdhT7ddNl5TIg5wLozH/2G1UGR5ewyrfiYtxJ6KzuIta5iU5
         wIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876590; x=1763481390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn1gmvaI3HpYNhR73OUUMc76SwfBuC0tr7WC7he5oYo=;
        b=jNsNPKa1hOIXkhhLi/pZAOc+v47xP00kdOVp0kMrdzd5vlC+f+LUpm+EzGs2yPHAkd
         Ra5g9lrKOyeYAfAcLxjmDFe62G3zCMpZZRgy4A6w/PbsTZpbf+xNXKCYIIG4Ud4DvLKZ
         hGU/cDWWno1QGL/w10ewL49mAbZE3DZg/p03uluIZXuHjWJNQg6UutiLai+WryE8kn/V
         kDGHYq0djFa7mX2As1U8HDuokDwhKz4eDE4c/GN4j3Ry7AQyKdtlZTXN/sSV1b6HPzT1
         sYhpdmTJi60UDrkSaPkcTojq9sPkTrmw/KbKneHocwPm7MIBJzn7X6/yL5LHp5TNTKsU
         jXVg==
X-Forwarded-Encrypted: i=1; AJvYcCVbEI9fuPfA7DHigME0x2Y418AewP9XxzOBjro2cWKjvl1KBmJHfKrZjdhFgSrxgPqznHYhTtIlGuXOFy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgNiT4WhP3EFHOFyHgcVMNGY2sIdov65LcrBUFdkgN5mJByUv
	SkMyeHZF5gs7ICxAkDf9SjwmDK0r/p0rRNXLy9r8/hsQNHagLAp81wNS
X-Gm-Gg: ASbGncubGNEcLnvmOfoIRu/xeLb9ju7J8KKQ06UBzC9RAWZMcwbtcvi4qhKbEpctWsp
	7AalB13TtBNewIT011RP7vILUxfMCJEbSPL1XWNxRMJxy0SVQuA5p5Xh7LNDFCVIJ/2QC+p8pSy
	iAb6WQJQ9lim9BVfppkNcp7Z8xNPX+Vwsps8t77aUkpDJen6+F168qwdanLgvYO5MgOKQfUvlJ6
	orzz8kdw7COo8DKjyFE1oEy9Uxmz4LRoNnn/M0/cIU/jeL0mTlZKDLK6tL1945wXsJmMZv/Ex7j
	TXPc54/Zphr3YwWV2/umDntYmjWjLJmfeOa4uAGKZzCLgR4MTtpDzc+cHRx6QZaMIGadASvzt1a
	ylaBPXxcLH9Dn/SMvol6jcDx8OBdV+9YudPDeJ1/cCGlSXYdM29TOG7e+7RfcgI2wWTKiaROXz5
	dOxZB1ck8fEHSyBAUgZXfONWoQ3AXmQtTVuuCBiKqR
X-Google-Smtp-Source: AGHT+IEWa4s/O/cpurErrQ/yBB0qj+qI8Pv0XJdBicVTkdR1kfMMMCiO4Ga983PAXfh6QAJiVG/gdQ==
X-Received: by 2002:a05:6000:2302:b0:429:b9bc:e81a with SMTP id ffacd0b85a97d-42b2db828edmr9435347f8f.0.1762876590240;
        Tue, 11 Nov 2025 07:56:30 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe63e13csm28676766f8f.19.2025.11.11.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:56:29 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 0/5] clk: add support for Airoha AN7583 clock
Date: Tue, 11 Nov 2025 16:56:16 +0100
Message-ID: <20251111155623.9024-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series introduce some cleanup and support for
clock and reset of Airoha AN7583.

The implementation is similar to EN7581 but AN7583 introduce
new reset and more clock divisor support.

Changes v4:
- Add review tag for DT patch
- Fix clock patch to use en7581-chip-scu compatible
- Drop PCIE SCU SSR write

Changes v3:
- Drop .set_rate patch (will be proposed later)
- Drop chip-scu binding and related patch
  Link: https://lore.kernel.org/all/20251106195935.1767696-1-ansuelsmth@gmail.com

Changes v2:
- Add .set_rate support
- Rework DT to EN7581 implementation (clock driver is parent)
- Add additional cleanup patch
- Merge binding with schema patch
- Add chip_scu phandle

Christian Marangi (5):
  clk: en7523: convert driver to regmap API
  clk: en7523: generalize register clocks function
  clk: en7523: reword and clean clk_probe variables
  dt-bindings: clock: airoha: Document support for AN7583 clock
  clk: en7523: add support for Airoha AN7583 clock

 .../bindings/clock/airoha,en7523-scu.yaml     |   5 +-
 drivers/clk/clk-en7523.c                      | 538 +++++++++++++-----
 include/dt-bindings/clock/en7523-clk.h        |   3 +
 .../dt-bindings/reset/airoha,an7583-reset.h   |  62 ++
 4 files changed, 468 insertions(+), 140 deletions(-)
 create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h

-- 
2.51.0


