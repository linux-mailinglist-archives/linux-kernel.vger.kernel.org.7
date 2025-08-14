Return-Path: <linux-kernel+bounces-767824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7148AB2598B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4997C1C85770
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69F2494F0;
	Thu, 14 Aug 2025 02:38:14 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8F19F11E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755139093; cv=none; b=QXikh3mKjadcstk9liBS/TUg44lUV/dL3lwR6+73gHnkgWa/F22YtyYdcD9Fz2BZI373P1ryAn2uAnWKvsvqbftxRINHdlh+19igED8XfCcjmbORzyiK9FdrUflKtmcIroCA3Y0n5pfaOb1MAYOqX5KNBxNR9lkaGdo+VHERSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755139093; c=relaxed/simple;
	bh=orXKxVt//leHOyaInDmaarxqvL9O/ii9pjhaz28t+EM=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=E/uILiZk7ckuo7TZt/bcb30mxCEK5cvoAhE/aJeb0fP8p+ETvB0kE+rDoXmDlZURhlLgsXrLeskzIO2QHjeGdk7da9j9EwCD6EpCfnGU38Hi7ETx6sthMu67uN2s/9OD9HiOIJU1La2JveIS4saAAEPDoyK430UarQkYjzh8OEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxnnMQTJ1oD5Y_AQ--.19478S3;
	Thu, 14 Aug 2025 10:38:08 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxT+YPTJ1o_GdKAA--.20216S3;
	Thu, 14 Aug 2025 10:38:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [QUESTION] How to silence objtool warnings of vmlinux.o
Message-ID: <8737f2ed-3f4a-3cab-1dd1-55ad50f951e6@loongson.cn>
Date: Thu, 14 Aug 2025 10:38:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJAxT+YPTJ1o_GdKAA--.20216S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AryrKr1fGw43XFWrJFW8GrX_yoW8KFy3pF
	47C34Yyan8uFWq9w4UCr4ag3ySva15Xr4DtFyUJa43J3yjvas2q3ZYyr4xAFyqgr4a9F43
	Wr47KryUCa4jy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2nYFDUUU
	U

When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
following objtool warnings after silencing all of the other warnings:

   LD      vmlinux.o
vmlinux.o: warning: objtool: .head.text+0x0: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x18: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x38: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x3c: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x40: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x44: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x54: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x58: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x6c: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x84: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x94: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x9c: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0xc4: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0xf8: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0xfc: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x104: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x10c: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x11c: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x120: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x124: unreachable instruction
vmlinux.o: warning: objtool: .head.text+0x144: unreachable instruction
vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruction
vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruction

All of the above instructions are in arch/loongarch/kernel/head.S,
and there is "OBJECT_FILES_NON_STANDARD_head.o := y" in Makefile
to skip objtool checking for head.o, but OBJECT_FILES_NON_STANDARD
does not work for link time validation of vmlinux.o according to
tools/objtool/Documentation/objtool.txt.

How to silence this kind of objtool warnings?
I appreciate any guidance here.

Thanks,
Tiezhu


