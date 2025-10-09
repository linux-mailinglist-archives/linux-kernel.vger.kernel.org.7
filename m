Return-Path: <linux-kernel+bounces-846892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CAFBC95A6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93A164F4F32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431772E8DF0;
	Thu,  9 Oct 2025 13:44:27 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769402E8B74;
	Thu,  9 Oct 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017466; cv=none; b=fW6fl/NHviyJJApKOO45AUdmu7ahpn8drhsvDk/qBLvAsLddXD9xXfISoTUv9W/TE80+/xm+xUeQwtN5f3mh2h/MIVFSHC1ETliYtyhnEZ2vmYInhatx5MiNFvVukz52nNoneFXHHHJ2ESYHwYboyPMTWMBCDJtc+Oj/q1p3kgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017466; c=relaxed/simple;
	bh=y7aZrzzHIwCxFeCrkDuZoxhYEAgE7zAOtB80HcFIIUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3VJljHKzzyIXrEdl7IL4s1/EQAdYxJT2EJ4nHX8uSJS0JuSq+Xk8NI55xT6e+2AZ8QymZ7y3B84ySvVwp1VLxJnezz6cJgJqC0uOw4UIUvNTB7ds1FeKZQecwnDpE+D9zCy+hDyrPQrN7MupDeC+QNK6nYN5tvYlSjeEKuVEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [183.6.60.79])
	by APP-01 (Coremail) with SMTP id qwCowACX76EEvOdoFFc_DQ--.1956S5;
	Thu, 09 Oct 2025 21:44:01 +0800 (CST)
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
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Cyan Yang <cyan.yang@sifive.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v2 3/4] docs: riscv: Document hwprobe for Zicbop
Date: Thu,  9 Oct 2025 21:41:53 +0800
Message-ID: <20251009134318.23040-4-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
References: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACX76EEvOdoFFc_DQ--.1956S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AF13XF18GFWxGF4kJw1UKFg_yoW8AF4fpF
	4UXr1qgFs8Xw4fCFW8Jw18ZF1rA3Z7Jw4jgF47A3yjqasIvrWvqr9xt3WFy3WUtr1Fya92
	gF4fKrWFy3y7AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8I
	j28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR5l19UU
	UUU
X-CM-SenderInfo: p2lk00vjoszunw6l223fol2u1dvotugofq/

Update hwprobe.rst to include documentation of the new
:c:macro:`RISCV_HWPROBE_EXT_ZICBOP` and
:c:macro:`RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE`, following the same
style as the Zicbom and Zicboz entries.

The extension bit records support for the Zicbop extension, and
the block size key reports the block size in bytes.

Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
---
 Documentation/arch/riscv/hwprobe.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 2f449c9b15bd..3b9c9d7e1409 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -275,6 +275,9 @@ The following keys are defined:
        ratified in commit 49f49c842ff9 ("Update to Rafified state") of
        riscv-zabha.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOP`: The Zicbop extension is supported, as
+       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
      mistakenly classified as a bitmask rather than a value.
@@ -369,4 +372,7 @@ The following keys are defined:
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVFWMACCQQQ`: The Xsfvfwmaccqqq
         vendor extension is supported in version 1.0 of Matrix Multiply Accumulate
-	Instruction Extensions Specification.
\ No newline at end of file
+	Instruction Extensions Specification.
+
+* :c:macro:`RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE`: An unsigned int which
+  represents the size of the Zicbop block in bytes.
\ No newline at end of file
-- 
2.47.2


