Return-Path: <linux-kernel+bounces-861228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1EEBF21E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913D718C0842
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2823EA9C;
	Mon, 20 Oct 2025 15:30:33 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB5264619
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974233; cv=none; b=GMAlZOYhp/ldBl5HXJUEc4TSu+gRPbP4Mhf9TGglTRD/wUrZNv0JsMpWjBzamMnXh6j4t1uuncE+g4DO1fSDGlJW692QW8/hJWpH1e08DipUvIBRRGwchSuxkcJ92drW8x/hti9IiUa94dcN4ukEeIiiswKrmC6VO/Vz8/RmtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974233; c=relaxed/simple;
	bh=DUvyH/soZ6Ix7RQ4mLM0XDaA6PjFSxZ8g2HX20yiqO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPCRzK/0y/GEgOLnZEJiyv4rURCduPGnIhHgwTj+mE6Mw86MovCj5C9xj0yx3VffE8PCk1VoHz9Qnn/ecC7GGDLo/StO+w/qeuQBCz0oLx4e1/YLR0MIySxdf38Umo1Z1w4NIZgFjSQW7QU5YtV29dCIVORtXnBEMEQTIE/T7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [183.6.59.216])
	by APP-01 (Coremail) with SMTP id qwCowAD3TaCCVfZo_ecYEg--.3482S2;
	Mon, 20 Oct 2025 23:30:13 +0800 (CST)
From: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	shuah@kernel.org,
	samuel.holland@sifive.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	zihong.plct@isrc.iscas.ac.cn,
	zihongyao@outlook.com,
	zhangyin2018@iscas.ac.cn,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3 0/2] riscv: hwprobe: Add Zicbop support
Date: Mon, 20 Oct 2025 23:29:12 +0800
Message-ID: <20251020152924.64551-1-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3TaCCVfZo_ecYEg--.3482S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw47ZF1rZrWfXFWUGw17KFg_yoW8Xw1fpF
	Z3Xrn3WF4DCr13Ca47Gw17Wr1rKw1vgrW8ZFy8WrykXrWYyry5J347trZ7AFWxJryagrZ0
	vF4fGrWY9F47A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: p2lk00vjoszunw6l223fol2u1dvotugofq/

Changes since v2:
------------------
- Squash the previous UAPI/kernel/doc patches(originally 1/4, 2/4, 3/4)
  into a single hwprobe patch for simplicity.
- Selftests:
  * Drop the `memory` clobber from the prefetch inline asm since it is
    pure hint.
  * Fix style problems. (Andrew Jones)
  * Merge the standalone prefetch test into 
    `tools/testing/selftests/riscv/hwprobe/cbo.c` (Andrew Jones)
  * Switch to `getopt_long` for option parsing. (Andrew Jones)

Changes since v1:
------------------
- Bump RISCV_HWPROBE_MAX_KEY (modified 1/4).
- Add documentation for the Zicbop hwprobe bit/key (new 3/4).
- Add a selftest(prefetch.c) for Zicbop (new 4/4).

Add UAPI and kernel plumbing to expose the Zicbop extension presence
and its block size through hwprobe. The interface mirrors
Zicbom/Zicboz. This allows userspace to safely discover and optimize
for Zicbop when available.

Background: Zicbop is mandated by the RVA22U64 profile. Downstream may
combine the presence bit with ZICBOP_BLOCK_SIZE to make profile-level
policy decisions or enable Zicbop-specific optimizations.


Yao Zihong (2):
  riscv: hwprobe: Expose Zicbop extension and its block size
  selftests/riscv: Add Zicbop prefetch test

 Documentation/arch/riscv/hwprobe.rst        |   8 +-
 arch/riscv/include/asm/hwprobe.h            |   2 +-
 arch/riscv/include/uapi/asm/hwprobe.h       |   2 +
 arch/riscv/kernel/sys_hwprobe.c             |   6 +
 tools/testing/selftests/riscv/hwprobe/cbo.c | 188 +++++++++++++++++---
 5 files changed, 175 insertions(+), 31 deletions(-)

-- 
2.47.2


