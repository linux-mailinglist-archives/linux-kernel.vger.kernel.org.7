Return-Path: <linux-kernel+bounces-884679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA44C30C70
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410F54213F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497742EAD16;
	Tue,  4 Nov 2025 11:37:12 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7A2DCF78
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256231; cv=none; b=eyM8vIYiLpREVwTtjQE/OnDg8+nTz/rHwvbFu6/8JP+id/Oz60vSwfZA+b/t7SGZ/ODQ0VXEsME+YcXOtt4yPlN7hSND0UccIMOfPe2WWV1UGgr198aIV+EmJB+Jfjb6sQpOa1HMhWjpk291QCGErLdPb/DXMSeK5QpVtYRCK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256231; c=relaxed/simple;
	bh=xiUc3Li4ny/si6xBgXPpJv56hxi06RYl6cV/ye2B3Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R6tdQJDIeqO8F7ms4hcqqAdgyxhCsAx+OyNdb4UjzPqxRPkVcBwIRwC5B7qzmjPoViBzxQdahC0ldC7k5Cvbb1W9LLsUsQYijM343iJV5IkofazIhyf8mDOdG/CW2JVNw4Q85CZN3EPQHo7/8XSG3RYDz9xYo8PPZnCREVcvONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxrr9e5QlpXLQeAA--.65323S3;
	Tue, 04 Nov 2025 19:37:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDx_8Nc5QlpQTImAQ--.54832S2;
	Tue, 04 Nov 2025 19:37:00 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] KVM: LoongArch: selftests: Add timer test case
Date: Tue,  4 Nov 2025 19:36:52 +0800
Message-Id: <20251104113700.1561752-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8Nc5QlpQTImAQ--.54832S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

This patchset adds timer test case for LoongArch system, it is based
on common arch_timer test case. And it includes one-shot and period mode
timer interrupt test, software emulated timer function and time counter
test.
---
v1 ... v2:
  1. Restore PC and PRMD after exception handler.
  2. Split patch 4 into two small patches with period timer test and
     time counter test.
  3. With time counter test, set time count with 0 when create VM. And
     verify time count starts from 0 in guest code. 
---
Bibo Mao (7):
  KVM: LoongArch: selftests: Add system registers save and restore on
    exception
  KVM: LoongArch: selftests: Add exception handler register interface
  KVM: LoongArch: selftests: Add basic interfaces
  KVM: LoongArch: selftests: Add timer test case with one-shot mode
  KVM: LoongArch: selftests: Add period mode timer test
  KVM: LoongArch: selftests: Add SW emulated timer test
  KVM: LoongArch: selftests: Add time counter test

 tools/testing/selftests/kvm/Makefile.kvm      |  10 +-
 .../kvm/include/loongarch/arch_timer.h        |  84 ++++++++
 .../kvm/include/loongarch/processor.h         |  81 +++++++-
 .../selftests/kvm/lib/loongarch/exception.S   |   6 +
 .../selftests/kvm/lib/loongarch/processor.c   |  47 ++++-
 .../selftests/kvm/loongarch/arch_timer.c      | 195 ++++++++++++++++++
 6 files changed, 417 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/arch_timer.h
 create mode 100644 tools/testing/selftests/kvm/loongarch/arch_timer.c


base-commit: ec0b62ccc986c06552c57f54116171cfd186ef92
-- 
2.39.3


