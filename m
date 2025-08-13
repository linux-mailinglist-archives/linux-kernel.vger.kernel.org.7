Return-Path: <linux-kernel+bounces-766333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CABDB2454C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8BE580BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA82F1FE8;
	Wed, 13 Aug 2025 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="zs7x1EGC"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E936A2F0C4E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077017; cv=none; b=ZEoXxT9x4rayErQczr0LmDMgGV6gxu8zksRx3XoT6ZBSNr0jCC0xgsehv0nVF53kl1b2boI4iKeElrFV/P5AGjrAkMQLUuSR73BdAcutKweWlFbaP3Ti151/3zbMrV1oNiebRjffiEngixs/mFc8hgXP0n/ebKPNgWnzyZ/FYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077017; c=relaxed/simple;
	bh=nSnlQzS3Oijb3uuQVtZaTkeoC2ip6X+Cu8XPFNiTPn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXpoOzOn1H0jK6Lps0XpDlpq3iwKyv8hjCwV9RIPLe/FiaklvQGjUmlHtz2Y9JdV75hKygACaht6SKROsh6AAWc/WqidZAPDigWo/bNb+IDq1kRV7Akf8ebeCHe0YkkCTFTLjcdIvqo1xqZkmQT3mC9frZcsnVKoXKvMcT4QxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=zs7x1EGC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78315ff04so5386076f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1755077014; x=1755681814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TEyolKpesJRN4enzfkBag9GEI6SkLDls4Ifg+2q31hc=;
        b=zs7x1EGCn8ffj7DYVYo7TFkqrPsYCNvbrfpJ5V1DrCEQFMxcBgf8kmR76xD2SkiPWU
         QshGB3Bl1Tx5ndWclqiWQZ4H0El3y4n7yRFEN/PrcGv9vIlJDuWD+PEwMnf926NHEROe
         6vZltUaViF7q3jroc0kvY/6BdF2yrQYExgSYQy0WEZ8sLiS2iBoYShuE6+KbaFFsjdy7
         p+llBRJHjCk9WUKmaVzfVphyB3kmOh9gZaEU2kxwvXHLi0N3G8D2M1unSxI/2YnCPTIP
         oJH9aNc7y8fvLoKp3TPkqCjqfvJz+sHWVgh61v8SE4UQ46HGw8gtct7W748Vf8NSAAyW
         HwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755077014; x=1755681814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEyolKpesJRN4enzfkBag9GEI6SkLDls4Ifg+2q31hc=;
        b=CgQWBD5V1xnsMNITmd0JjQ4gbqvCFoZMpWMWh8PwTwo+UscC0blwzpncDn5orOZRmd
         PLjATimZQy4yfbL07oycmuZeaWyfwAgerIr4qEyTKaGbtBZqSRpF/gfDbTva5MGPJg5N
         jL48Ru6TPeVY6xiIYe1W1iYQ//viMhHriNTM6xXpILDReTINB8Zq638HhjOCS80paZzJ
         CwOcU+5GkC3KAoFyVhXZIboHtUXHbjosDQ4ZAuEyHmlq6uRFm0d//ytt2SifPF6e8iji
         los88NLbwznTgBcV9ipr2fHpAfKlAWCqKnlgCl2cUo73SgSMbNuK/6Q1ACthOoteFUyE
         q/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWatWjp1GEGwdF8A8tMJdUJT4Hj2XWH/F21ZrFSK9ZnuNtKhCSolSN8S9a0p8g7Nu3L18m/62M3O7EAqV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFiEVMIgdePYbfEzkomW3p4LM13KU84cfhA5nr1Og4plLWf3rm
	B8Ibw+V8enQ4GpgDcOUJCeAoMyqdxRSlrYX8nVme+KibMKere0cob8sJTqFBNN+W4Fw=
X-Gm-Gg: ASbGncv4A2LSr/bsKohBDPUaCb0d3TSEJMPr00zoYW9IuqGsBXp5bgvxxlz7nQOXd9K
	z8XxCauoJA9B/Db3v9cZiK9qCasg7VzW/MlGRUj5O4/GrgtO8xnwrjQmJxrpXtJKNx7LXgPPfQp
	vNLsWzDLP4FmaPWfqRh4tPjwu5Zo1ux/WsbpupCskf11iGvjsSZ5J4EqmoSs3dLs8+IUTxlOwUM
	TwLIIY6ka1givNU+C9MpMvEfR9/lE9l4IsgZETDeDjzhk6V/1Nu9WnE2rqo4i+rgo536fSBYM+P
	WmFbvU7v+sHmv5IuL4R9qDFkXYeXElm3wBWNVaAbqXqvKaDJdFclgJkswamYQpTkrbWOD6iAf1A
	46qZLjVk6Ya+cmBTypRhiK2ffJCddu2aotI4FQN8NPI/nyE6W1g==
X-Google-Smtp-Source: AGHT+IFxawn2hn81XiBMFzlp9R7LXDt7IQlnw4bYwjrbGUdm+VKiMtSVAcwLlkK3/1f3t/cZPUZtdA==
X-Received: by 2002:a05:6000:40cb:b0:3b7:9b58:5b53 with SMTP id ffacd0b85a97d-3b917ec345cmr1916488f8f.45.1755077013860;
        Wed, 13 Aug 2025 02:23:33 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:d33c:e682:2af6:3c3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm47966077f8f.4.2025.08.13.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 02:23:33 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	palmer@dabbelt.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH v3 0/2] riscv: dts: spacemit: Add initial support for OrangePi RV2
Date: Wed, 13 Aug 2025 11:22:38 +0200
Message-ID: <20250813092240.180333-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds initial device tree support for the OrangePi RV2 board.

The OrangePi RV2 [1] is described as using the Ky X1 SoC. Based on research
and testing, it appears to be identical or very closely related to the
SpacemiT K1 SoC [2], as suggested by the following:

- Similar integration in the Banana Pi kernel tree [3], which uses the 
  OrangePi RV2 and identifies it as the SpacemiT K1.
- Comparison of the device tree code showing a match to the OrangePi RV2 
  Linux tree [4].
- Locally tested the OrangePi RV2 with the SpacemiT K1 device tree, 
  confirming it boots and operates correctly.

Patch #1 documents the compatible string for the OrangePi RV2, and 
patch #2 adds its minimal device tree. This enables booting to a serial
console with UART output and blinking a LED, similar to other K1-based 
boards such as the Banana Pi BPI-F3 or the Milk-V Jupiter.

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Link: https://github.com/BPI-SINOVOIP/pi-linux/blob/linux-6.6.63-k1/arch/riscv/boot/dts/spacemit/k1-x_orangepi-rv2.dts [3]
Link: https://github.com/orangepi-xunlong/linux-orangepi/tree/orange-pi-6.6-ky [4]

Changes in v3:
Improved changelog: Reworded relation to SpacemiT K1 as presumed identical,
based on downstream sources and testing.
Applied Yixun Lan's Reviewed-by tag.

Changes in v2:
Patch 1: no changes.
Patch 2:
- Added aliases section to the device tree.
- Removed the memory section, as it is populated by the bootloader.
- Updated copyright header.
Link: https://lore.kernel.org/spacemit/20250718084339.471449-3-hendrik.hamerlinck@hammernet.be/

Here is version 1 of this series:
  https://lore.kernel.org/spacemit/20250711183245.256683-1-hendrik.hamerlinck@hammernet.be/

This is the follow-up mentioned in the previous version, sent now that
v6.17-rc1 was released yesterday.

Hendrik Hamerlinck (2):
  dt-bindings: riscv: spacemit: Add OrangePi RV2 board
  riscv: dts: spacemit: Add OrangePi RV2 board device tree

 .../devicetree/bindings/riscv/spacemit.yaml   |  1 +
 arch/riscv/boot/dts/spacemit/Makefile         |  1 +
 .../boot/dts/spacemit/k1-orangepi-rv2.dts     | 40 +++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts

-- 
2.43.0


