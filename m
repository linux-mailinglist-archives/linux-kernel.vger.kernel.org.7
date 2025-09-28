Return-Path: <linux-kernel+bounces-835180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D2EBA672D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F403B9258
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB9266B40;
	Sun, 28 Sep 2025 03:46:29 +0000 (UTC)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051A711CA0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759031189; cv=none; b=qcbgCbzXhIYSG9GiX+l/YFAJLwZBRt2JDgJQ0EE2gATQ5RlfHa/7yTH0/5kEYzMkZyw3p/WmeD33+niEXbihDT3q6R57adae7Njxes5jwC+TS60M74f6kJIsPCjsU2hjwBPZMAqXDT5U3Ex7Ypn0vg8Z+rdXBAQppMqpOXOfLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759031189; c=relaxed/simple;
	bh=leAHyipuOrrNM/GHdGoDUYGJ6EFVBQ6TUO5UvR4dHaM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t39UwWZNUOh8nRebO60ffp1lP/zUK1xhB4XWTRmfzd2951id67PV4xpeyJ8K2sZQjwUzjJ0OOhcaf1Ec2BIvQR7AVzPRFCgmaSJxpVZvqXTuKAvMdkHzeRj3aE9yooeKVGhyc+HFkQ3j0nbbCo0GPpblbd3DSopOHOzaWD7dUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH 0/2] riscv: dts: spacemit: Add initial support for MusePi
 Pro
Date: Sun, 28 Sep 2025 11:46:14 +0800
Message-Id: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIav2GgC/x3MwQpAQBCA4VfRnE2taQmvIgfsYBK2HaTk3W2O3
 +H/H1AOwgp18kDgS1T2LSJLExjmbpsYxUUDGcpNRSUuGa6nshf0YUd3KOa2cGQGa6nrIXY+8Cj
 3/2za9/0APJ4m42MAAAA=
X-Change-ID: 20250928-k1-musepi-pro-dts-546d20c442ab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759031178; l=997;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=leAHyipuOrrNM/GHdGoDUYGJ6EFVBQ6TUO5UvR4dHaM=;
 b=KyplklxWO12GVPU+bp0gZ7RAp9WhOAzlXhFOisv8yAJsjTObE2dUqJ6fdZAbisASFR/pKWyjm
 aH/L3CB9hIKBWAuh4KSRBKXJRrNG8EHIcAP/1kCZ3Ix/O6pdpBAZfHD
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-Migadu-Flow: FLOW_OUT

This patchset adds initial device tree support for the MusePi Pro board.

Muse Pi Pro [1] is a single-board computer integrating a high-performance
RISC-V 8-core processor, storage, I/O and expansion capabilities into
a credit card-sized 1.8-inch board.

Link:
https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf
[1]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Troy Mitchell (2):
      dt-bindings: riscv: spacemit: Add MusePi Pro board
      riscv: dts: spacemit: Add MusePi Pro board device tree

 .../devicetree/bindings/riscv/spacemit.yaml        |  1 +
 arch/riscv/boot/dts/spacemit/Makefile              |  1 +
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     | 40 ++++++++++++++++++++++
 3 files changed, 42 insertions(+)
---
base-commit: 0f084b221e2c5ba16eca85b3d2497f9486bd0329
change-id: 20250928-k1-musepi-pro-dts-546d20c442ab

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


