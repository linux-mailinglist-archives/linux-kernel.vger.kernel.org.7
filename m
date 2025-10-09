Return-Path: <linux-kernel+bounces-846890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92FBC959A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB38481B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64D2E8E13;
	Thu,  9 Oct 2025 13:44:18 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87031450F2
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017458; cv=none; b=rU9me/azSaJK9f62fBR3+sVsZ89n8eFcK6DiNWQw9pXKl3N/FLQmp2kWdJSqngJINvqfI4x3UWvjwXeGuA1VVcka03lre2MSZBRhgi9qBwI1ELcWyOFZkt5WirdvWAoSn4DMNGt2renlLVLr1FKEgXCF4OPxEjHXgtuj0JFDvK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017458; c=relaxed/simple;
	bh=ijld4K5VbHabQg9o5Ylkb+73Da7j6r7znzttgxXLPRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDliGq65uIQdtyqH9//yjeNFylnCjNBOlalox7c+Du2Vj6H6GWout5hHy5kd7f4F+d9qeUybMLi5sUGAzT7kp7hJoEdYgaLkoQnpoWWBBlw4ytyGYThpI9vW2wEKLS+V7ngqJep/gWgdctnvIERTqRd6pZzJ5tlHAGbclJjb3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [183.6.60.79])
	by APP-01 (Coremail) with SMTP id qwCowACX76EEvOdoFFc_DQ--.1956S2;
	Thu, 09 Oct 2025 21:43:36 +0800 (CST)
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
Subject: [PATCH v2 0/4] riscv: hwprobe: Add Zicbop support
Date: Thu,  9 Oct 2025 21:41:50 +0800
Message-ID: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACX76EEvOdoFFc_DQ--.1956S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryUCrW7tw47tr47Jr1DWrg_yoW8Jw4rpa
	93Wrn3CF4kCw13CayxGr1UWr1rKwnYgw4UZFy8Xry8ZrWYyrWrAr9rKrZ7AFWUJF93tr98
	ZF4fGrWYk3W7A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Yao Zihong (4):
  uapi: riscv: hwprobe: Add Zicbop extension bit and block-size key
  riscv: hwprobe: Report Zicbop presence and block size
  docs: riscv: Document hwprobe for Zicbop
  selftests/riscv: Add Zicbop prefetch test

 Documentation/arch/riscv/hwprobe.rst          |   8 +-
 arch/riscv/include/asm/hwprobe.h              |   2 +-
 arch/riscv/include/uapi/asm/hwprobe.h         |   2 +
 arch/riscv/kernel/sys_hwprobe.c               |   6 +
 .../testing/selftests/riscv/hwprobe/Makefile  |   5 +-
 .../selftests/riscv/hwprobe/prefetch.c        | 236 ++++++++++++++++++
 6 files changed, 256 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/hwprobe/prefetch.c

-- 
2.47.2


