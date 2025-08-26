Return-Path: <linux-kernel+bounces-786505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885AFB35AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9BF3ABBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369D29B8D9;
	Tue, 26 Aug 2025 11:06:44 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBD25F99F;
	Tue, 26 Aug 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206403; cv=none; b=LaejObPYbdYChV57Nqf+R2dOBS4DD/Kgvcb/6SbCb7ijWIFDeR7n7U8dMIpWuJy24wbSA6nM/Y0ypODV5BGnhrb/nHWa2iI64dgG24lc21J0YhY0kHK5//gfvdkPGXzCTGZNfeNm1DSkoTNpVUHNMYFVtN2QYLExq1C9I9Bw9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206403; c=relaxed/simple;
	bh=0DD07lInfMmXbGN+5tYxPVIh0qblkS1vxdwi59jO87s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPSqdOU4rLebWmD/eGCpg/FZSaW+DwAYS74CkBjIwT9ippSCkOKqCWqnKjcC3uGOl6QIE3TvUVzY/cH9s0VFkuLl6iM4P0Et+e9sbJ+fspB5DLZZf4KX62jhv4zzVmyWUxiN21kqpDrkzf3c7hQOFAH4UdXHJYL6yXyIy/QJJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgC3zg8sla1o3ObDAA--.48651S2;
	Tue, 26 Aug 2025 19:06:23 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v6 0/2] Add driver support for ESWIN eic7700 SoC reset controller
Date: Tue, 26 Aug 2025 19:06:10 +0800
Message-Id: <20250826110610.1338-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgC3zg8sla1o3ObDAA--.48651S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF15WFyrXF1kJFWktr4UCFg_yoW7ArWUpF
	WUCry7Gr15Xr4xXa93ta1F93WSqanxtr15Gr47Jw47uan8Aa4UJrWrtF45AFyDAr97Xryf
	XF13uayF9FyjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

This series depends on the vendor prefix [1] and config option patch [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250825&id=ac29e4487aa20a21b7c3facbd1f14f5093835dc9
[2] https://lore.kernel.org/all/20250825132427.1618089-3-pinkesh.vaghela@einfochips.com/

Updates:

  dt-bindings: reset: eswin: Documentation for eic7700 SoC
  v5 -> v6:
    Add dependencies of vendor prefix and config option patch in cover-letter.
    Link to v5: https://lore.kernel.org/all/20250725093249.669-1-dongxuyang@eswincomputing.com/

  v4 -> v5:
    1. Dropped EIC7700_RESET_MAX from bindings.
    2. Add "Reviewed-by" tag of "Krzysztof Kozlowski" for Patch 1.
    3. Corrected the link to previous versions.
    Link to v4: https://lore.kernel.org/all/20250715121427.1466-1-dongxuyang@eswincomputing.com/

  v3 -> v4:
    1. Remove register offsets in dt-bindings.
    2. The const value of "#reset-cell" was changed from 2 to 1.
       Because the offsets were removed from dt-bindings. There are
       only IDs. And removed the description of it.
    3. Modify copyright year from 2024 to 2025.
    4. Redefined the IDs in the dt-bindings and used these to build a
       reset array in reset driver. Ensure that the reset register and
       reset value corresponding to the IDs are correct.
    Link to v3: https://lore.kernel.org/all/20250619075811.1230-1-dongxuyang@eswincomputing.com/

  v2 -> v3:
    1. Drop syscon and simple-mfd from yaml and code, because these are
       not necessary.
    2. Update description to introduce reset controller.
    3. Add reset control indices for dt-bindings.
    4. Keep the register offsets in dt-bindings.
    Link to v2: https://lore.kernel.org/all/20250619075811.1230-1-dongxuyang@eswincomputing.com/

  v1 -> v2:
    1. Clear warnings/errors for using "make dt_binding_check".
    2. Update example, change parent node from sys-crg to reset-controller
       for reset yaml.
    3. Drop the child node and add '#reset-cells' to the parent node.
    4. Drop the description, because sys-crg block is changed to reset-
       controller.
    5. Change hex numbers to decimal numbers going from 0, and drop the
       not needed hardware numbers.
    Link to v1: https://lore.kernel.org/all/20250619075811.1230-1-dongxuyang@eswincomputing.com/

  reset: eswin: Add eic7700 reset driver
  v5 -> v6:
    1. Removed platform_set_drvdata() function.
    2. In probe function, defined struct device *dev = &pdev->dev.
       Modified &pdev->dev to dev.
    Link to v5: https://lore.kernel.org/all/20250725093249.669-1-dongxuyang@eswincomputing.com/

  v4 -> v5:
    1. The value of .max_register is 0x7fffc.
    2. Converted "to_eswin_reset_data" from macro to inline function.
    3. Modified EIC7700_RESET_OFFSET to EIC7700_RESET and eic7700_
       register_offset to eic7700_reset.
    4. Since EIC7700_RESET_MAX is dropped, used eic7700_reset[] without
       EIC7700_RESET_MAX.
    5. Removed function eswin_reset_set, and put regmap_clear_bits in
       eswin_reset_assert and regmap_set_bits in eswin_reset_deassert.
    6. Added usleep_range in function eswin_reset_reset which was missed.
    7. Used ARRAY_SIZE(eic7700_reset) for data->rcdev.nr_resets.
    8. Use builtin_platform_driver, because reset driver is a reset
       controller for SoC. Removed eswin_reset_init function.
    9. Modified eswin_reset_* to eic7700_reset_*.
    Link to v4: https://lore.kernel.org/all/20250715121427.1466-1-dongxuyang@eswincomputing.com/

  v3 -> v4:
    1. Add 'const' for the definition. It is 'const struct of_phandle_
       args *reset_spec = data;'.
    2. Modify copyright year from 2024 to 2025.
    3. Included "eswin,eic7700-reset.h" in reset driver.
    4. Added mapping table for reset IDs.
    5. Removed of_xlate and idr functions as we are using IDs from DTS.
    6. Removed .remove function.
    Link to v3: https://lore.kernel.org/all/20250619075811.1230-1-dongxuyang@eswincomputing.com/

  v2 -> v3:
    1. Change syscon_node_to_regmap() to MMIO regmap functions, because
       dropped syscon.
    2. Add BIT() in function eswin_reset_set() to shift the reset
       control indices.
    3. Remove forced type conversions from function eswin_reset_of_
       xlate_lookup_id().
    Link to v2: https://lore.kernel.org/all/20250619075811.1230-1-dongxuyang@eswincomputing.com/

  v1 -> v2:
    1. Modify the code according to the suggestions.
    2. Use eswin_reset_assert() and eswin_reset_deassert in function
       eswin_reset_reset().
    3. Place RESET_EIC7700 in Kconfig and Makefile in order.
    4. Use dev_err_probe() in probe function.
    Link to v1: https://lore.kernel.org/all/20250619075811.1230-1-dongxuyang@eswincomputing.com/

Xuyang Dong (2):
  dt-bindings: reset: eswin: Documentation for eic7700 SoC
  reset: eswin: Add eic7700 reset driver

 .../bindings/reset/eswin,eic7700-reset.yaml   |  42 ++
 drivers/reset/Kconfig                         |  10 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-eic7700.c                 | 428 ++++++++++++++++++
 .../dt-bindings/reset/eswin,eic7700-reset.h   | 298 ++++++++++++
 5 files changed, 779 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/eswin,eic7700-reset.yaml
 create mode 100644 drivers/reset/reset-eic7700.c
 create mode 100644 include/dt-bindings/reset/eswin,eic7700-reset.h

--
2.17.1


