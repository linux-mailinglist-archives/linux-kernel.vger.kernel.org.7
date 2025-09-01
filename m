Return-Path: <linux-kernel+bounces-793964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7FB3DAEE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B2C7A9D18
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1B126D4CE;
	Mon,  1 Sep 2025 07:22:09 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537226B75C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711329; cv=none; b=TIvcbe5WAZKBAodcYME0A3SZXWsAsDCroimkcQ0CFuQqakLqhfze/gz9yqibuw6H/yNbexEiVBkzURwb/wtaRku2JShlvBWMhWEQKdiW4aYLIUF32TmjUzIMLeGw48TULrzZOuvSCfdyXlxKIjbuaDHcU3i1APJCvhuHY1cmBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711329; c=relaxed/simple;
	bh=qPTPfwkZyUEVgBchmwNspD4G5zGo5JoA9MjIzbM4vnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTtkWk1eYpiCIdhG/7h8PHDFyo87xkDKcDuxaNBVKMntRGviFan5r/TenprqK1sevtqGEtvZI6esB56nw4m7HLhQpRVjM2oypO5nehkPVSLK31Sn54shGtkxAKQZKGbG8HebHk06lJL4AK7MWb0TNWoekJEII5Bby8kMbzCMxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxaNGZSbVoBUUFAA--.10809S3;
	Mon, 01 Sep 2025 15:22:01 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxE+SVSbVoxHB2AA--.44622S2;
	Mon, 01 Sep 2025 15:21:57 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Fix objtool warnings if LTO is enabled for LoongArch (Part 2)
Date: Mon,  1 Sep 2025 15:21:53 +0800
Message-ID: <20250901072156.31361-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+SVSbVoxHB2AA--.44622S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4kKr15Kw4UAFW3Wr4kuFX_yoW8XFy5pF
	45uay7Wr4rXr4kGwsrJa1SvFy3AwsxGrW7t3WUG345A390vrsFqws2yr42qF1UK3sagryx
	tF4FgayUKFyDZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUUUUU==

The previous patches [1] [2] are to fix most of the warnings (total 3030):

  sibling call from callable instruction with modified stack frame

This series is a follow up to fix 2 kinds of warnings (total 24), it only
touches the objtool and LoongArch related code:

  falls through to next function
  unreachable instruction

With this series, there is only 1 kind of warning (total 3), it does not
only touch the objtool and LoongArch related code:

  missing __noreturn in .c/.h or NORETURN() in noreturns.h

In order to silence the above warnings, it needs to change the related
code to give the functions __noreturn attribute, and have a NORETURN()
annotation in tools/objtool/noreturns.h. IMO, it will touch all of the
archs and the generic code, so this needs much more work to avoid the
side effect or regression, once it is done I will send out the patch.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a47bc954cf0e [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5dfea6644d20 [2]

Tiezhu Yang (3):
  objtool/LoongArch: Fix fall through warning about efi_boot_kernel()
  objtool/LoongArch: Fix unreachable instruction warnings about EFISTUB
  LoongArch: Fix unreachable instruction warnings about entry functions

 arch/loongarch/kernel/Makefile | 2 --
 arch/loongarch/kernel/head.S   | 6 ++----
 tools/objtool/check.c          | 8 ++++++++
 3 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.42.0


