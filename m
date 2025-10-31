Return-Path: <linux-kernel+bounces-879444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE5BC23223
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AD73A7D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6542882D6;
	Fri, 31 Oct 2025 03:12:41 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6B270EA5;
	Fri, 31 Oct 2025 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880360; cv=none; b=hU+FJI4Cow15Tx10ozmhXYcptbZAzf/kydPbPs+oi/kCSs/dlzEbsQgcip94Xtp89e7kVS0U2tx1ZkVx7BI9IEBW3nPR6eIn+4+Quo0ypGlfYkDNMPE3wQFfea9A6JDy99uxvCsIwBJ94QgTGMUQWogDfbM/ky4Sj9J3lFT6DQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880360; c=relaxed/simple;
	bh=07PyXE4Y28HS4ee3Ds5mAcypk5SGAgRieN7hkcmoa2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=spZo317HH2s7wSgLYp1AAFyzOaW8u8WpQUp9uhj+hvnrLGtHbg6t2QUL4P4UjRLwtU2J4qukl+KWyZO71Ildfnm88+BAU6C7wHrv9nVQfdZCUXoUBM2BMGFowjSiMYgSDY9hR+TTlqoGXavJA96yHBIzX1HuJDVdAVz2zTD191k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axjr8hKQRpouwcAA--.60916S3;
	Fri, 31 Oct 2025 11:12:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxysAbKQRpGMkeAQ--.13727S2;
	Fri, 31 Oct 2025 11:12:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/6] KVM: LoongArch: selftests: Add timer test case
Date: Fri, 31 Oct 2025 11:12:21 +0800
Message-Id: <20251031031227.4020738-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxysAbKQRpGMkeAQ--.13727S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

This patch set adds timer test case for LoongArch system, it is based
on common arch_timer test case. And it includes time counter function,
one-shot/period mode interrupt, and software emulated timer function
test.

Bibo Mao (6):
  KVM: LoongArch: selftests: Add system registers save and restore on
    exception
  KVM: LoongArch: selftests: Add exception handler register interface
  KVM: LoongArch: selftests: Add basic interfaces
  KVM: LoongArch: selftests: Add timer test case with one-shot mode
  KVM: LoongArch: selftests: Add period mode timer and time counter test
  KVM: LoongArch: selftests: Add SW emulated timer test

 tools/testing/selftests/kvm/Makefile.kvm      |  10 +-
 .../kvm/include/loongarch/arch_timer.h        |  84 ++++++++
 .../kvm/include/loongarch/processor.h         |  81 +++++++-
 .../selftests/kvm/lib/loongarch/exception.S   |   6 +
 .../selftests/kvm/lib/loongarch/processor.c   |  38 +++-
 .../selftests/kvm/loongarch/arch_timer.c      | 187 ++++++++++++++++++
 6 files changed, 400 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/arch_timer.h
 create mode 100644 tools/testing/selftests/kvm/loongarch/arch_timer.c


base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
-- 
2.39.3


