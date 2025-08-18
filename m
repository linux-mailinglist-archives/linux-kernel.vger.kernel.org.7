Return-Path: <linux-kernel+bounces-773188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63F6B29C82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BCB4E158C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94C301491;
	Mon, 18 Aug 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOVrXwoo"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20339260590;
	Mon, 18 Aug 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506606; cv=none; b=Lg9wvNo0MhnsQGjigPdQtkY7959aU3pBykTdBs51oUNYJUZ7111Sm0w3XA75agk0qc5Hg34m/fki7v2AIMyCgcPBRnmiCMuYNPOnNHD9IXS8N8TJLBpDwALuS56vpz9ni1WHE0aPVPSniKfnw+7iXUx3nedJmno7XsBFKjQq0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506606; c=relaxed/simple;
	bh=h//OnE8xjMrdJsTFOXyv+oxSEG4dfiZyYKDlv6KTGHQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WjF6L7nGSGZVK3dBS9Hgom0Wy21r2HUgLGJKYckYcDsOXOEG0OxN+WIzECVYuaoSh/DLnZnvAU0TueGpihC8v9iYf8VuZLNljkR3iPak33wpAwwdvhG422/Q1CBWIN5V/fPmj3jRQ8z6BD60bluSsQvjyjPkW1bTuKJY9YGh6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOVrXwoo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47405591ceso1158617a12.3;
        Mon, 18 Aug 2025 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506604; x=1756111404; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bx8sUIY9aOtvP6bPSKF1xVFQVSXOtKKcBX0gwDpJVCg=;
        b=gOVrXwoo9em8U2R6nc+THkgpOM4CqTqwAJIdSku7vrEUNwnBmiVyWtyd+dVItR0pry
         HAoeEhKANSel/59YQQxDV5DMd/YZMbHrDRET1d9d2odHcxxNFcUbI10g1Wzbm43pqvua
         EiRjruUY9hf1dc6pnhFSJ35Pry8BiIVaeTpj2WX1HWdLtIzNGJVjatNjxO/PbV0ROX8/
         fXk/Yi3eYp8ZN5dhq7x+xN6LhkwMHEH1+KcABpID6RqOHUgDWDwnlm88iz+9n2/R3ban
         be80H844UykUEBa8Za4oXJFE1bbmmmKpklcsIjgvpIE3+imngSOuB3E/Sc2CZiMNx043
         Otsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506604; x=1756111404;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bx8sUIY9aOtvP6bPSKF1xVFQVSXOtKKcBX0gwDpJVCg=;
        b=fYbmKHNkFLz/REhpyu35SPzrq+btwnKAx3up0gIIsNV3m2XKODQupVzZGoa8xLSOLY
         eWyv3J16WFRKy7oK/ZHfbUQb3X3SQEmIGGjULufDEHABA51uWXlUoVzwc3weX08cuXEw
         kysoi9OwtQW0JtXnzB6jdsQAmkcV9ujGACurv4ZOer8rAKospmC2qU3FbS++N33jXM4T
         L1gQ7O8aFhqNAXWHS60jt6q9YDPo0YurRFqFKK4EKGk46xhlvOe1/arsp8RkTJUCJBm/
         mCos0iSQOCcuLXjL2JTDMYp6VrrqxxROD6/wpTmIYwBA/ai7Z7lqEV5QG73GdjJmrjcC
         LrAA==
X-Forwarded-Encrypted: i=1; AJvYcCVS996ENFbPnrmEq+VvRiHK/pamhwq0tvQd36VHkUgw2BGnFbr3Q+Lt1tELskXJU9oIFfNhDySoZpqb@vger.kernel.org, AJvYcCXEGXS0SIyNANgokrtQ3x6vQGmdVdWbLRupO39HHc/pZlXE6MrFVQB4p3Jmo8Fw/gcJzDCnCXrO7TRFwr08@vger.kernel.org
X-Gm-Message-State: AOJu0YwsA+ElsVm14ctxCQO2c8+DCisWxBAneNFHhnPFzajXTfZFeG/C
	vfbFEgJ5BBXoh+exUWvWToLQGA0uiGe5Q+DfWEsXBj9Kui9xcDwYrD4v
X-Gm-Gg: ASbGncuEXMa8fnMbSynGWWJDGChA+cNvINz4td0Fqd0zZu8UjjNRG6EtPvBXPUYVeu8
	iI1xyVykkA5R9rzYXCPBuuFsXxibo1/UuYMTvbQxiDsomSKRfFjaxGUzOG1X5VpvppiINO7hxKV
	DKgRq2+4NGSnP8dz8VINuLoduKkfWeRAEiz4umlt6PkFbPblkVgLc6+lACpeonrlF6N3q9uRov3
	l2778lr7O/GhAg98ieijL45qobGdYC49PVzeSw8T7UMfoteXQwICkJazbWuhjnfrst1aeQJCiZo
	bEP+x9KnPQDMjQkb2931IcfB0c0NC33LV6KDLBFo53qYSr5wjOOreQkjbeBxlkAKJ+rFdpZ23+Z
	fkYbDK5vHViJz48ovo62V+tjxm4TGg0YzxgyDacOlbMOs0fI=
X-Google-Smtp-Source: AGHT+IGr+QvXGo3/T80TEtk8GucqtvAHkHyeZ3j5ycRlwOeaTV8Fhjp6M6C6LOuR/Yh1gB0/IdKRSg==
X-Received: by 2002:a17:903:4b4c:b0:242:a0b0:3c30 with SMTP id d9443c01a7336-2446d8edf38mr141753015ad.43.1755506604217;
        Mon, 18 Aug 2025 01:43:24 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:23 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 0/9] Add support ANS2 NVMe on Apple A11
Date: Mon, 18 Aug 2025 16:42:53 +0800
Message-Id: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3nomgC/03MQQrCMBCF4auUWRuZxIZGV72HdBGSaTtgWklKU
 ErubiwuXP4P3rdDosiU4NbsEClz4nWpoU4NuNkuEwn2tUGh0mjQiM2g1GLJgUR3se3ovFXae6i
 HZ6SRXwd2H2rPnLY1vg87y+/6Y6T8Z7IUKGi8OoVIXWu7fgqWH2e3BhhKKR/numlkpAAAAA==
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=h//OnE8xjMrdJsTFOXyv+oxSEG4dfiZyYKDlv6KTGHQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouegHci7I26tBuTw2954p8e1MuDA7bm7+1HK1
 MMona/pAhWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnoAAKCRABygi3psUI
 JAnAD/4sXJEJsWnJXyEtUrZyoCoNIoaFwJzZuTYIWftzOPbeFpexvXqlVwu+Ysc2UNrQQr05hco
 kF3AFRksFtzPz0VxvuisoNbhvv24NdsTvsxs/z2T0ofzyJ0UQ1BQL54uiwLYgiqMSgqRqCu7SNY
 isS+k8QYYwt7W1idiosA7W9Sp/i2WEyNu6tSAXwIJF+eykXAeSVFeZyIf3Rw3FDwFXyRsn+rGWM
 ABGTsSP2o1/HPNr3FobP3WuJ4qZAP+9n8PsOi2YcvFsF0wuwcFiZ4xs8aIswtAWMNKWXq9tDv4X
 DzqFDNu2iUpjlAeB+LfCBGn9fdO4F5dp0UZqXyg7tV47ryOVdfxTHslC/02UAmFBrszw2hqM4RJ
 SSFTzvF1q0qb3hnPr8PVG8IPYj5LyPa9+gzsGuPnGYRhFUeqhF4KQwyyOaB2rlHgKO+qgRgVkWR
 ChSqP7W8hyV5dm4fOwGFwSlO3gyp5lOFnKszOPsmwekqQyfg9/+27TIF1oMnbsDYbK5XG+hukG9
 11Dn1/TwCIjN/yPyOMYt9/1nwMo5TF/wu17jwMSkXo3jSCUAPYodPLwsq+Jiv3hlIS2ukSQLV4j
 RUfcSqUk1TqNXjgtLcf9VJhX492IkA4ALFmSVle3syy9efPFNB71Hz5cT6nR1/bea95NZmn+wiE
 v3Ei+Fu+gPBvyEw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Apple A11 SoC comes with an NVMe controller that is similar to the
NVMe controller in M1, but less customized. Notably, it does not
have NVMMU or Linear SQ.

The controller is wired to an older variant of the SART address filter,
and uses an older variant of ASC mailbox, so add support for them too.

This variant of mailbox is also present on Apple T2 SoC.

This series has everything required to support NVMe on Apple A11 SoC.
However, due to RTKit protocol version support limitation, it will
only work when booted with at least iOS 14 iBoot.

Tested on A11 as well as M1 Pro (to make sure nothing broke).

Patch 1-2 adds support for the older mailbox
Patch 3-5 adds support for the older SART
Patch 6-7 adds support for the NVMe controller found in Apple A11 SoC
Patch 8-9 adds the required device tree nodes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Remove bogus command_id decrement followed by increment in apple_nvme_handle_cqe()
- Split apple_nvme_submit_cmd() into two functions for t8015 and t8103 since these
  two code paths were not sharing much code.
- Link to v1: https://lore.kernel.org/r/20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com

---
Nick Chan (9):
      dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      dt-bindings: iommu: apple,sart: Add Apple A11
      soc: apple: sart: Make allow flags SART version dependent
      soc: apple: sart: Add SARTv0 support
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes

 .../devicetree/bindings/iommu/apple,sart.yaml      |   1 +
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |   7 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  15 +-
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |   1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 ++++
 drivers/nvme/host/apple.c                          | 198 +++++++++++++++------
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 ++++++-
 8 files changed, 267 insertions(+), 68 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


