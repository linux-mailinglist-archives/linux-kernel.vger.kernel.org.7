Return-Path: <linux-kernel+bounces-860849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348F7BF12B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE9C3AAD77
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9B30F94E;
	Mon, 20 Oct 2025 12:24:52 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409031FECBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963092; cv=none; b=ncdYGiS6wspuPKDXtOqNSRSo/gHKjDiyWXKiOd+ByemcOojqC3QPqEAwH1GLnK2E4ODbYxGcrl/6LYF3m4ZpHBbKRlLeZYaarsTuETENGjN66dC3/l0wl5+TOuFVtBIhdw7rJCP1fGrhY8Iil8ECSMBNqgevfuf+bNhM36npq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963092; c=relaxed/simple;
	bh=T+x3Q/n+hNYLfm1OG7Nr213sc00RppuxHWpkom8orS4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ijp2dSAgDnl9OnFi3VV8L0+Vx9Y6DGAu9pM55VwVFsMq9HDeFazHe9kOda4/E8rsGyHTN96sf9jb0iaH9P5MMBroysp/KW2V3ljE1IEi9rTiz/GLziFPRoaGcoFTjQux9voAjtPm0Ri6wyZQ7Sv9F5bdwxTfd4pnaitFWKle8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-05 (Coremail) with SMTP id zQCowABX+RLoKfZo2ywDEg--.13259S2;
	Mon, 20 Oct 2025 20:24:08 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH 0/2] riscv: tests: Make RISCV_KPROBES_KUNIT tristate
Date: Mon, 20 Oct 2025 20:23:54 +0800
Message-Id: <20251020-riscv-kunit-kconfig-fix-6-18-v1-0-d773b5d5ce48@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANop9mgC/yWNQQrDIBBFryKz7hS1VEquUrIwdpIOIdqORgIhd
 680y/c+vL9DJmHK0KkdhCpnTrGBuSgIbx8nQn41Bqvt3WirUTiHivMaueAcUhx5wpE3dGgeqM0
 YHA3eOXODlvgIte2ff/YnC33X9lJOCYPPhCEtC5dOVXdtEQkG+uP4AXA1YsybAAAA
X-Change-ID: 20251020-riscv-kunit-kconfig-fix-6-18-01fc6eba6613
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Inochi Amaoto <inochiama@gmail.com>, Yao Zi <ziyao@disroot.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowABX+RLoKfZo2ywDEg--.13259S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1kWF4xGw48XFy7Kr1rZwb_yoWfAwc_Cw
	4IvrykGa1UAFyqkFyYg393XFs5t348KFy3Xr1rtrWxGr1xKr9rKa1kur18C3s5u398XF13
	t3yku34qvF12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Fix an allmodconfig warning on v6.18-rc1:

    WARNING: 3 bad relocations
    ffffffff81e24118 R_RISCV_64        kunit_unary_assert_format
    ffffffff81e24a60 R_RISCV_64        kunit_binary_assert_format
    ffffffff81e269d0 R_RISCV_JUMP_SLOT  __kunit_do_failed_assertion

While we're at it, rename the test to remove the word "test", in order
to conform to the style guide.

---
Vivian Wang (2):
      riscv: tests: Rename kprobes_test_riscv to kprobes_riscv
      riscv: tests: Make RISCV_KPROBES_KUNIT tristate

 arch/riscv/kernel/tests/Kconfig.debug          | 2 +-
 arch/riscv/kernel/tests/kprobes/Makefile       | 4 +++-
 arch/riscv/kernel/tests/kprobes/test-kprobes.c | 5 ++++-
 3 files changed, 8 insertions(+), 3 deletions(-)
---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251020-riscv-kunit-kconfig-fix-6-18-01fc6eba6613

Best regards,
-- 
Vivian "dramforever" Wang


