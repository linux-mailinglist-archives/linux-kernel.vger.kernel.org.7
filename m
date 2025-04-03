Return-Path: <linux-kernel+bounces-587793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE97A7B059
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA1B16C367
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0AF1FDA66;
	Thu,  3 Apr 2025 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="fipwsY+d"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15901FCFDA
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712484; cv=none; b=khaKk7rCHpkcFrI1crgG+K9GBpblGigI0JR1m9w4eqjC0uhui63qkSesOoVk5/gyeZtGyMc5dlZibg/k3VUhwENyDUTkPdbZTnT/r3U6E9a+xKfU5o2D8SkvaJu2RWymqrRGwMy2Ak2kolZx0d9zgBG2yoGwUmrhwyRdUUfqLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712484; c=relaxed/simple;
	bh=xB2C04uovpv4skICAYGaB52QAvjvmMm90YpbPc+QSWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rNcTAL6wQku0QM3POP3AidNFj7E35wsGP+q6shKTDJR/xX0KFqfIWhxAJov85ycJG8YJbEwZK648F0QnTR3XioCXIC0ZLxaSq3QzkQ187Nhj7FjOQ3yOvpX+Wlf58Cu81bp1HoDtnW/E3Xjw3cmAoxA5x2XBAUGrufxR5h6ByBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=fipwsY+d; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1743712480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UDfYL4ErdunlNmstrEsdYuv+0FhmfCu6RIMjgekzhfE=;
	b=fipwsY+d+b6rrvO4vtfMK74We5DLTRxmJZCjFxcOm517hPj64VLEIduGp6NAUPREU89bjd
	xZyKMR6nFCAMifx9XV1LmHzDsR58ZHEpgkfL4NkP+YcXqsECMzDYu5cQOnOEs/sUaH9WCw
	ukcacLOEs519U2x8Xudi91EKa/cOBqF6WZ3YK8xvOjpS0qw7m1lnGoaB9bFBtJj7rfyaiJ
	jdKLSDWnzKX12KL7x71yizY4dCcT3195iwvxltXgU7Q31Xyvw/0YkVQLNEmuAXzopXQl9u
	hkfS8CjuyPo/Xascx/5iTJ2qdB8qF+NiTZrWIn+LWV/Zk2l8svIVyF5ej0JqTA==
From: Ignacio Encinas <ignacio@iencinas.com>
Subject: [PATCH v3 0/2] Implement endianess swap macros for RISC-V
Date: Thu, 03 Apr 2025 22:34:16 +0200
Message-Id: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjw7mcC/13MQQ7CIBCF4asY1mIYKCiuvIdxAXRqZyE1YFDT9
 O7SxkV1+V7yfyPLmAgzO25GlrBQpiHWobYbFnoXr8iprZtJIbVQYs8T5VB4fjrP/QG8bZx1ATy
 rwT1hR68FO1/q7ik/hvRe7ALz+2VArJkCHLhqjJbYAaI1J8IYKLq8C8ONzVKR69r+1JIL3mrlT
 Wuct6D/6mmaPuSS1UflAAAA
X-Change-ID: 20250307-riscv-swab-b81b94a9ac1b
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 linux-arch@vger.kernel.org, Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Motivated by [1]. A couple of things to note:

RISC-V needs a default implementation to fall back on. There is one
available in include/uapi/linux/swab.h but that header can't be included
from arch/riscv/include/asm/swab.h. Therefore, the first patch in this
series moves the default implementation into asm-generic.

Tested with crc_kunit as pointed out here [2]. I can't provide
performance numbers as I don't have RISC-V hardware yet.

[1] https://lore.kernel.org/all/20250302220426.GC2079@quark.localdomain/
[2] https://lore.kernel.org/all/20250216225530.306980-1-ebiggers@kernel.org/

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
Changes in v3:

PATCH 2:
  Use if(riscv_has_extension_likely) instead of asm goto (Eric). It 
  looks like both versions generate the same assembly. Perhaps we should 
  do the same change in other places such as arch/riscv/include/asm/bitops.h

- Link to v2: https://lore.kernel.org/r/20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com

Arnd, I tried your suggestion but couldn't make it work. Let me know if
I missed something in my response.

Changes in v2:
- Introduce first patch factoring out the default implementation into
  asm-generic
- Remove blank line to make checkpatch happy
- Link to v1: https://lore.kernel.org/r/20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com

---
Ignacio Encinas (2):
      include/uapi/linux/swab.h: move default implementation for swab macros into asm-generic
      riscv: introduce asm/swab.h

 arch/riscv/include/asm/swab.h   | 43 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/asm-generic/swab.h | 32 ++++++++++++++++++++++++++++++
 include/uapi/linux/swab.h       | 33 +------------------------------
 3 files changed, 76 insertions(+), 32 deletions(-)
---
base-commit: a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
change-id: 20250307-riscv-swab-b81b94a9ac1b

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>


