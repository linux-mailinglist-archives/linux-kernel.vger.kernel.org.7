Return-Path: <linux-kernel+bounces-807700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945D6B4A832
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54061C61435
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABF72D3EF2;
	Tue,  9 Sep 2025 09:27:15 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60D28E579;
	Tue,  9 Sep 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410035; cv=none; b=fcDvRHSej30DVwH/ury/E3UK4Q3xHoSM7crsQk6BoSNm4alb6XyCoZY5IXggFKaIRHCIBxlcYkuDgpK3mOLc+VLO7bZ8cFp/foC7KZeiVbzxYIQXXvOTQXyLWE+Pe6eUi1Oml01iI3j1sUzb94NnvsaMZWbzJ+QMEbPwHaD2Qrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410035; c=relaxed/simple;
	bh=+DLg60lZDBzN6GJTarOXafWeiiDD4x1Nkq280BXb/+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4e4cknG3wmNtSJd9koN9nJCtgpqKHiH19/hL9ghlHSNKhp6orz6tD9kUqlN9DlVUL4huNCb/bitctq3wHAhnYZyErDyavnWcMlTXACXeAfGf+kfvfwQdNWjTor0HjagcjF6S6CmL2O1sW4V/mMdJlrQTIzXWzKnjd9R/mIkVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxmdHt8r9onE8IAA--.17858S3;
	Tue, 09 Sep 2025 17:27:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxbMHr8r9oeuSJAA--.56108S2;
	Tue, 09 Sep 2025 17:27:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>,
	rust-for-linux@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Fix objtool warnings with RUST on LoongArch
Date: Tue,  9 Sep 2025 17:27:05 +0800
Message-ID: <20250909092707.3127-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxbMHr8r9oeuSJAA--.56108S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALUUUUU=

This series is to fix objtool warnings when compiling with LLVM and
CONFIG_RUST is set, thanks WANG Rui and Miguel for your suggestions
about RUST.

The second patch uses the option -Zno-jump-tables, here is a related
discussion:

https://github.com/rust-lang/rust/pull/145974#issuecomment-3236418282

Tiezhu Yang (2):
  LoongArch: Make LTO case independent in Makefile
  LoongArch: Handle jump tables option for RUST

 arch/loongarch/Kconfig  |  4 ++++
 arch/loongarch/Makefile | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.42.0


