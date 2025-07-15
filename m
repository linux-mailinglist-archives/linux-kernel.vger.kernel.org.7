Return-Path: <linux-kernel+bounces-731798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF08B059AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE57564003
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C32DA748;
	Tue, 15 Jul 2025 12:15:20 +0000 (UTC)
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79611226D10;
	Tue, 15 Jul 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581720; cv=none; b=CkIjVsCnBUGzm5vlZ+OtGpcywndPypgbHiATU5dvnHm7C+HXUPDUeg8Llq2x9SEdvW0I9wR1wBTP+a6aseodFjHz8UhQEDXj/cFYVhG08lN3xZkfVZehSm7DIYkrjI/jHN2LeycVuAYvE7NOCsjiLYkHRYFmTNSWSsZADFgvObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581720; c=relaxed/simple;
	bh=rPgIL4GPayU+6uUo2GNI6vJvd+9xIlu/D2lFyANBU1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M4RAtS2Ou7C+maxWVvlE6aBP0pMobf2QeGeHLUhvldTX+bMYJv3DeBLJ2sVXifr12JOXOkTzhPVb/66k/0vDB0xA4PBDHELF3kyRZJOEkN0fhP7HEkla77qCW+wqYrm9roaxJJ1GwD7g0r6LKdyKiKc4vFciC/VVyNtuDyuML08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgB3FpUtRnZoh1uwAA--.52568S2;
	Tue, 15 Jul 2025 20:14:39 +0800 (CST)
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
Subject: [PATCH v4 0/2] Add driver support for ESWIN eic7700 SoC reset controller
Date: Tue, 15 Jul 2025 20:14:27 +0800
Message-Id: <20250715121427.1466-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgB3FpUtRnZoh1uwAA--.52568S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18JF15Xw1xtw47XF48Crg_yoW5tr1kpF
	4DWFy7Grn0yF4xJa93Ja4F93WSqanxtF45Gr4xtw47Z39xAa4jqrWrtF45AFyDCr4kXry3
	XF17u3yF9FyjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Updates:

  dt-bindings: reset: eswin: Documentation for eic7700 SoC
  v3 -> v4:
    1. Remove register offsets in dt-bindings.
    2. Changed the const value of "#reset-cells" from 2 to 1.
       Because the offsets were removed from dt-bindings. There are
       only IDs. And removed the description of it.
    3. Modify copyright year from 2024 to 2025.
    4. Redefined the IDs in the dt-bindings and used these to build a
       reset array in reset driver. Ensure that the reset register and
       reset value corresponding to the IDs are correct.
    Link to v3: https://lore.kernel.org/all/20250624103212.287-1-dongxuyang@eswincomputing.com/

  v2 -> v3:
    1. Drop syscon and simple-mfd from yaml and code, because these are
       not necessary.
    2. Update description to introduce reset controller.
    3. Add reset control indices for dt-bindings.
    4. Keep the register offsets in dt-bindings.
    Link to v2: https://lore.kernel.org/all/20250523090747.1830-1-dongxuyang@eswincomputing.com/

  v1 -> v2:
    1. Clear warnings/errors for using "make dt_binding_check".
    2. Update example, change parent node from sys-crg to reset-controller
       for reset yaml.
    3. Drop the child node and add '#reset-cells' to the parent node.
    4. Drop the description, because sys-crg block is changed to reset-
       controller.
    5. Change hex numbers to decimal numbers going from 0, and drop the
       not needed hardware numbers.
    Link to v1: https://lore.kernel.org/all/20250514002233.187-1-dongxuyang@eswincomputing.com/

  reset: eswin: Add eic7700 reset driver
  v3 -> v4:
    1. Add 'const' for the definition. It is 'const struct of_phandle_
       args *reset_spec = data;'.
    2. Modify copyright year from 2024 to 2025.
    3. Included "eswin,eic7700-reset.h" in reset driver.
    4. Added mapping table for reset IDs.
    5. Removed of_xlate and idr functions as we are using IDs from DTS.
    6. Removed .remove function.
    Link to v3: https://lore.kernel.org/all/20250624103212.287-1-dongxuyang@eswincomputing.com/

  v2 -> v3:
    1. Change syscon_node_to_regmap() to MMIO regmap functions, because
       dropped syscon.
    2. Add BIT() in function eswin_reset_set() to shift the reset
       control indices.
    3. Remove forced type conversions from function eswin_reset_of_
       xlate_lookup_id().
    Link to v2: https://lore.kernel.org/all/20250523090747.1830-1-dongxuyang@eswincomputing.com/

  v1 -> v2:
    1. Modify the code according to the suggestions.
    2. Use eswin_reset_assert() and eswin_reset_deassert in function
       eswin_reset_reset().
    3. Place RESET_EIC7700 in Kconfig and Makefile in order.
    4. Use dev_err_probe() in probe function.
    Link to v1: https://lore.kernel.org/all/20250514002233.187-1-dongxuyang@eswincomputing.com/

Xuyang Dong (2):
  dt-bindings: reset: eswin: Documentation for eic7700 SoC
  reset: eswin: Add eic7700 reset driver

 .../bindings/reset/eswin,eic7700-reset.yaml   |  42 ++
 drivers/reset/Kconfig                         |  10 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-eic7700.c                 | 454 ++++++++++++++++++
 .../dt-bindings/reset/eswin,eic7700-reset.h   | 299 ++++++++++++
 5 files changed, 806 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/eswin,eic7700-reset.yaml
 create mode 100644 drivers/reset/reset-eic7700.c
 create mode 100644 include/dt-bindings/reset/eswin,eic7700-reset.h

--
2.17.1


