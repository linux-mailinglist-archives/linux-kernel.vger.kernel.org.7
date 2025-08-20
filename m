Return-Path: <linux-kernel+bounces-777826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01726B2DE47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54305170786
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28031E1C3F;
	Wed, 20 Aug 2025 13:45:12 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9781917F1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697512; cv=none; b=ksZjTvZMoGZXUt6rSv1JDLTZR76UUTRPs116qXa/hkuTqy1HboLYbvh10Zpdi/3sQV8dcSuT0VKpYBW7DaPv24ysbfJ5yVAVWXJa4IojUeAYag96xz0sExDJ3mDtLIFcUb9Lbd55Wr3+dPQDMeO6JIE0aZLfqCtg6dRuUTb42RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697512; c=relaxed/simple;
	bh=08Hd+yNsCCGzxTw3cPdVNbHlNgVxJeDhZzkwxMc9q5U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q27pvl4y3IhOaX9NX5lMgCQYD7WD48CzbF+lhXR8QMdUrwi6rtU2rNmfsd/bZbmCT0J4xNk0SKduEwbEynwFOn1vfCmHXIJn9jProlIVF7ZNr0/3qU72kgbuUFTgYwUX85nkkSBlAHqfIPVJvyAh8R/E7J8Lafxhir3LCo5Ep7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowABHN6tT0aVogOTBDQ--.24665S2;
	Wed, 20 Aug 2025 21:44:52 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH 0/6] riscv: Add helpers use_alternative_{likely,unlikely}
Date: Wed, 20 Aug 2025 21:44:44 +0800
Message-Id: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEzRpWgC/yXMQQrCMBCF4auUWTuSpMRKryJdxDi1A20aJzEKp
 Xc32OX34P0bJBKmBH2zgVDhxGuo0KcG/OTCk5Af1WCUsepqFAonX9DNOeBEcyTBD0dUyo2ts9b
 4toP6jUIjf//d23BY6PWu+XyMcHeJ0K/LwrlvyuWsOxSvYdj3H9RSMLCUAAAA
X-Change-ID: 20250820-riscv-altn-helper-wip-00af3a552c37
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ayd=C4=B1n_Mercan?= <aydin@mercan.dev>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABHN6tT0aVogOTBDQ--.24665S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1Uuw4UGF17Aw48Jw1kKrg_yoW8WFy5pF
	43Gr9xZFyrGFyfKFZIvr1jqr1Y9rZ3Kw1aqFnIgrykJw4avryUZr1qkryrAFyYqFykZ34I
	kr1rZw1rGF1DC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

There are about a dozen uses of asm goto in arch/riscv just to select
between two code paths with the alternative mechanism. Introduce helpers
similar to arm64's alternative_has_cap_{likely,unlikely} for this, and
convert the existing code to use it.

I did not use the name alternative_has_cap_{likely,unlikely} since riscv
alternatives are not all CPU capabilities.

In each case, I have tried to preserve the existing logic while picking
between "likely" and "unlikely".

These patches are also available at:

https://github.com/dramforever/linux/tree/riscv/altn-helper/v1

---
Vivian Wang (6):
      riscv: Introduce use_alternative_{likely,unlikely}
      riscv: pgtable: Convert to use_alternative_unlikely
      riscv: checksum: Convert to use_alternative_likely
      riscv: hweight: Convert to use_alternative_likely
      riscv: bitops: Convert to use_alternative_likely
      riscv: cmpxchg: Convert to use_alternative_likely

 arch/riscv/include/asm/alternative-macros.h |  73 ++++++++++++++++
 arch/riscv/include/asm/arch_hweight.h       |  42 ++++------
 arch/riscv/include/asm/bitops.h             | 112 +++++++++++--------------
 arch/riscv/include/asm/checksum.h           |  13 +--
 arch/riscv/include/asm/cmpxchg.h            | 125 ++++++++++++++--------------
 arch/riscv/include/asm/pgtable.h            |  15 ++--
 arch/riscv/lib/csum.c                       |  65 ++++++---------
 arch/riscv/mm/pgtable.c                     |  22 +++--
 8 files changed, 247 insertions(+), 220 deletions(-)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250820-riscv-altn-helper-wip-00af3a552c37

Best regards,
-- 
Vivian "dramforever" Wang


