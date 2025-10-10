Return-Path: <linux-kernel+bounces-848886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E71BCEC20
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8973B3C04
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E827FB31;
	Fri, 10 Oct 2025 23:36:38 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195F26D4FB
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139397; cv=none; b=Zywga3l6Sc+pcC/RvVUVr5n2MXVP2WCtu5Wm/Of8cF2SvbQMWHl4YMKEihHYmUweqNnwpSxuj1PJPFYrFR3XLY29mzQpWGWhoEDhxOfp/ECsuvWZSCsHpPj9pjhwK/76Ih/7YWmDD0AGOqpcnoCkBDSqLYf9LXRj7Yyt1a0/5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139397; c=relaxed/simple;
	bh=0OUg51FdlTMRQu8lk1RhOXlx6yb/G/EgjGO3ffnScbA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bYNbpKTUcFEZjENgiE34m+LU5QlsUbafqiwl4t0uzOkRd8gB4b+AP8NSiZC9vtX8pufbDLz2cVndmaNFJl9e+OKF5eImPrmwh3ZKEfyDOlOkGr9IRlYWVw3HfFo99aGCl6WWOcRc3qENynJ515kY9LehvAcDhFJ/5X6dnAqwjyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.81.247])
	by APP-05 (Coremail) with SMTP id zQCowADHaxVUmOloXC2IDQ--.41211S2;
	Sat, 11 Oct 2025 07:35:48 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH v3 0/5] riscv: Use __riscv_has_extension_{likely,unlikely}
Date: Sat, 11 Oct 2025 07:35:42 +0800
Message-Id: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE6Y6WgC/4XOy07DMBAF0F+JvMaVH/KDrvgPxGI8HhNLbZLaw
 S2q8u+YdAMLxPKO5h7dO6tUMlV2HO6sUMs1z1MP+mlgOML0TjzHnpkSygivBC+5YuNwWic+0mm
 hwq954UJA0mCMQu1Y7y6FUr7t7uvbIxe6fHR+fRxZgEoc5/M5r8cBo4EuhJi80Dqi185bLU20O
 vmglQkxgEqRfVtjrutcPvfJTe7YP+ua5IKjRqssyuTIvvQ3qAfAA0672dRPR/7lqO48G28TOKG
 S87+dbdu+AA3BjXVQAQAA
X-Change-ID: 20250820-riscv-altn-helper-wip-00af3a552c37
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Walmsley <pjw@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, 
 Xiao Wang <xiao.w.wang@intel.com>, 
 =?utf-8?q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:zQCowADHaxVUmOloXC2IDQ--.41211S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw17Xr4UArW3tr1rXw1kZrb_yoW8trW3pF
	43Cr9I9rn3G34Sqws3Ar129r40va1rWw1agrsIg348Z3y2yryxZrn0kw1ruryDtFZ7Zryj
	kr13Gr17uF1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

There are about a dozen uses of asm goto in arch/riscv just to select
between two code paths with the alternative mechanism. Convert them to
the existing helpers __riscv_has_extension_{likely,unlikely}.

In each case, I have preserved the existing code's choice of asm goto
pattern while picking between "likely" and "unlikely", namely:

  ALTERNATIVE("j %l[no]", "nop", ...)   -> "likely"
  ALTERNATIVE("nop", "j %l[yes]", ...)  -> "unlikely"

Since the helpers are just implementations of these patterns, the
performance should be the same as before.

These patches are also available at:

https://github.com/dramforever/linux/tree/riscv/altn-helper/v2

---
Changes in v3:
- Rebased on riscv for-next
  - Resolve conflict, use ALT_RISCV_PAUSE() in moved lines
- Link to v2: https://lore.kernel.org/r/20250821-riscv-altn-helper-wip-v2-0-9586fa702f78@iscas.ac.cn

Changes in v2:
- Cc'd authors who initially introduced the asm goto blocks
- Use existing __riscv_has_extension_{likely,unlikely} instead
- Remove bogus comment for Zbb being likely (checksum)
- Restructured patch to minimize diff (bitops, hweight, cmpxchg)
- Link to v1: https://lore.kernel.org/r/20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn

---
Vivian Wang (5):
      riscv: pgtable: Use __riscv_has_extension_unlikely
      riscv: checksum: Use __riscv_has_extension_likely
      riscv: hweight: Use __riscv_has_extension_likely
      riscv: bitops: Use __riscv_has_extension_likely
      riscv: cmpxchg: Use __riscv_has_extension_likely

 arch/riscv/include/asm/arch_hweight.h | 24 ++++++----------
 arch/riscv/include/asm/bitops.h       | 32 ++++++---------------
 arch/riscv/include/asm/checksum.h     | 13 +++------
 arch/riscv/include/asm/cmpxchg.h      | 12 +++-----
 arch/riscv/include/asm/pgtable.h      | 15 +++++-----
 arch/riscv/lib/csum.c                 | 53 ++++++++---------------------------
 arch/riscv/mm/pgtable.c               | 22 +++++++--------
 7 files changed, 53 insertions(+), 118 deletions(-)
---
base-commit: cd5a0afbdf8033dc83786315d63f8b325bdba2fd
change-id: 20250820-riscv-altn-helper-wip-00af3a552c37

Best regards,
-- 
Vivian "dramforever" Wang


