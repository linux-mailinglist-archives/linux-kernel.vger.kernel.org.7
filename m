Return-Path: <linux-kernel+bounces-757805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA3B1C6E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D27B1725DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D15218ACA;
	Wed,  6 Aug 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdvgN5Nh"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6228C2B6;
	Wed,  6 Aug 2025 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487511; cv=none; b=uDKQdLGoP4UQwXIEcWdAbJzyYzkbDzD+7KLy3wM+r+SRL3Etw61FnLkQxFeefFY9LBIhxFojVmreoQGYDntCyWzWYy0LNTs37M21JOV0oP7DA0S+Zk7ubGt5zzG4CyyVVB5AE9R+LQci932dAXhqwKuxn9woM/jKnurBuvHefjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487511; c=relaxed/simple;
	bh=/1gBzi59LU1FpVeTQMr8A9/AcnzkFZ0Hci74mudEZmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZExerlOUn4SiPX4BaHYXKIWEbnh36vA255guevpYYkHSh8EjVFp66DRfgonKZWFE1LFgbCj4Al5gHHvMtwQxvn3yU3l/etUPjim7q7rr2ZbejDAI1mEaU5t+/MTRmWq1coedCXtrU0YJLNwOqEYWNXC2cqaBa1JC3PJb2ECxVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdvgN5Nh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso11546118a12.1;
        Wed, 06 Aug 2025 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754487508; x=1755092308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpB+PfzuWs/TM6R4B5yVrE9x1IKZVmu2ttqHx5YHmbA=;
        b=EdvgN5NhJgU41CnzNSaaJfF4Tw8jc1GDpYwcrMu65D7lRvi073HUvEz1cz0VqnneEz
         mCS8mPiy/8DpppnIQSM/4OqP56/NqMgNR0qkpYjoupSpUlrW45i8XJir8XMy9WKBshFQ
         Acbm/4k/xXzZ9I9S3gUt6KMl6RTnDKt/YTeNElzWH/fMkQONg3o342LrEikaRaA1ZLpx
         kq6oIzA8UkxU9jKxa+I3HD2+h2OucTC+9UDYshpUvt+e+fvg0fByQQzvv/inGfGbXaAf
         mFXbGl4bOVeYAChQ2zgEQBiFEQBume6ezwX5TCpYk1RnWqSOFVXf7RBjMX6I+3bwZUcf
         AR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487508; x=1755092308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpB+PfzuWs/TM6R4B5yVrE9x1IKZVmu2ttqHx5YHmbA=;
        b=ngSEJfjcrTHqeqJ4xd4qWzv9FwRtm8EC9gNODpuHiUbUSblGIfrdoy1RBwxsOYesLq
         P0jHxuqjam2KO5QXqtfWjo1qFx4ObJ7o1BdWPBTY+b3sKDq44k1HXmvme886UDJHbgHf
         /aTgQyq01np4qPOq8wrABhAW9mEEdwe1t+5nDYi6XJ5eCJhltJorfS8pXGmVVMstTQVe
         dWVpv6yKlamrrzaExr46NslZHTJJ1bt2pzqHw4ai86yFIwc+94RuQDMtPpvkjO1X27DE
         PGPjJeQ5V78chm0E1FGlOPYs0F/gKKtIWE17uxAeTl6hD4//vES3U25nIheug7XMp0xM
         FKjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi78lJubmPDS0g9UMcRhoQXOUZPjC6kz7kVxWyOSKt0/A5b9uQs+Uc+y/IiVRVYZDwz5C2OGFl14GTPQO4@vger.kernel.org, AJvYcCXeFXRxfR2zkXKRynE2SOHIPcmnAYsK3YXjfA4lE1n+LYbG79pP9Pr93ozn0Jx5dUngDUXlU1P11gug@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OTE7bB58DbqgOsxfKS16aYgzitApnuKtgaNtNEUAwHVOAh/U
	dJ30uVpu430hgaqtRytzEWL423CTaz6dZeD5vER5oZSgTmKR6vh7zfFV
X-Gm-Gg: ASbGncvUSf4MdNSdqFKFGtfUJloM6jjcNYmRvibRM9mzq0YbhBtqqzU79c3eqXZ3Lxq
	NYHkIaDdt6fVL/HlpczGr0nYbZE1dEI06bKjdETIuGyoUJVDvWTqgfPzDsHLAtTV6ztpAqFotQG
	tBHCSkkOYKV6n0O7pzKyYkdovBSRzvwcpIkkus82cS848Fmmaqz4sW7iA8O7jL7xkl0QZISWz8p
	isQ76i6FUg4bYmg9SyRy3imJMOaY9z86mXtVU/3HPoahEX3kTRfwh7ZJNYLa3eIfLn+b7Evjft8
	cQ+7WD2mk6+KUhjJPsEREWDzTX5vTRHeuo+k9Rs+MqW9uQymcRc8yCwzOdtBkHOAGzjBoMbQovK
	712Hwry5dzJo/w2cvIBZXv7YXrb+abJ/rGCXB+RfkyxZ2Hgnw
X-Google-Smtp-Source: AGHT+IGei8vPsctsojGNv2hAMLvUFfLXGEm+CbuctTYxSQujN3sBsnPBDJoEEmvPeoL2QEoXA5JJdQ==
X-Received: by 2002:a17:907:7ba4:b0:ae0:c690:1bed with SMTP id a640c23a62f3a-af9903e69c1mr287290466b.51.1754487507913;
        Wed, 06 Aug 2025 06:38:27 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm1113170666b.116.2025.08.06.06.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:38:27 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] phy: rockchip-snps-pcie3: add support for rockchip,phy-ref-use-pad
Date: Wed,  6 Aug 2025 15:38:20 +0200
Message-Id: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility for the RK3588 PCIe PHYs to use an internal clock instead of
a clock provided on a pin of the device. This allows boards that don't have a
PCIe clock connected to the reference pad to still function in separate clock
mode by using an internal reference clock for the PCIe PHYs.

This was tested with a CM3588 compute module on a custom PCB.

Without the new option, the default behaviour (PHYs using external pad for clock)
is applied, to keep compatibility with existing device trees.

Differences from V1 [1] :

- Documented the phy-ref-use-pad option in the DT bindings.
- Documented the extra optional differential clocks for the PHYs in the DT
  bindings.

[1] https://lore.kernel.org/all/20250715105820.4037272-1-rick.wertenbroek@gmail.com/

Rick Wertenbroek (3):
  dt-bindings: phy: rockchip,pcie3-phy: add optional differential phy
    clocks
  phy: rockchip-snps-pcie3: add support for rockchip,phy-ref-use-pad
  dt-bindings: phy: rockchip,pcie3-phy: add rockchip,phy-ref-use-pad

 .../bindings/phy/rockchip,pcie3-phy.yaml      | 21 ++++++++++--
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 32 +++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.25.1


