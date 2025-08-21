Return-Path: <linux-kernel+bounces-779402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6811B2F3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF3817CC14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426272EFD9E;
	Thu, 21 Aug 2025 09:16:49 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DA2E9ED4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767808; cv=none; b=Ut8SLcEkAAKsV9Gk3h729iyS1fBkanpCKXi507GYWi2ksDaIJhEKICu2BYeeWSwa4gHKT3lxPtChsRAwWfPJDRppPuZ7Z402ShD0w+BABioxbOcn+xmWQp/EBwxMYGjdiyT+77K0spNSMpQkTcFFshNUHHjhWo0AYzjsQuRJgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767808; c=relaxed/simple;
	bh=ropEjBSHDX8p61vp/pJarLywi5mA3DJAdMEbN9E5QIU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E26N3RpVqk7mRsv6TUXWgpJf0qEpsIwh0F+ABh8q47UezjcQpAO++X+3VzqYSCHqjNQUGK38e6Ngpo0+/HzmGSxzjHLxLK9drK4o++Mf1cSQLhZj1SHoZpp1QsSzBQ3u+lBX9Q3c6uQznz7DPUCawahONLgff6i72nMPHr4GfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowADXAqfv46ZovXADDg--.14435S2;
	Thu, 21 Aug 2025 17:16:31 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH v2 0/5] riscv: Use __riscv_has_extension_{likely,unlikely}
Date: Thu, 21 Aug 2025 17:16:30 +0800
Message-Id: <20250821-riscv-altn-helper-wip-v2-0-9586fa702f78@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7jpmgC/4WOTQ6CMBCFr0Jm7ZC2BDCuvIdhUcdBJuHPtlYN4
 e5WOIDLb/LNe28Bz07YwylbwHEUL9OYwBwyoM6Od0a5JQajTKmORqETTxFtH0bsuJ/Z4UtmVMq
 2hS1LQ0UN6Xd23Mp7y700Ozt+PFN82I9wtZ6RpmGQcMpilesaHWn4yZ34MLnPtinqzf5THzUqp
 IIqU5Fua67OSbM+t5TTCM26rl8IVKXC6QAAAA==
X-Change-ID: 20250820-riscv-altn-helper-wip-00af3a552c37
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Charlie Jenkins <charlie@rivosinc.com>, 
 Xiao Wang <xiao.w.wang@intel.com>, 
 =?utf-8?q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowADXAqfv46ZovXADDg--.14435S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw17Xr4UArW3Zw4xJw1DZFb_yoW8ZF43pF
	43Cr9I9Fn5G34Sq3Z3Ar12vr40vF4rWw1aqrsIgry8X3y2yryIgryqkw1rZryDtFZ7Zryq
	kw13Cr1xuF17C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
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
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250820-riscv-altn-helper-wip-00af3a552c37

Best regards,
-- 
Vivian "dramforever" Wang


