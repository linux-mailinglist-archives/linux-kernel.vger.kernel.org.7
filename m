Return-Path: <linux-kernel+bounces-660566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8CDAC1F69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5249A1C0337E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05425224B15;
	Fri, 23 May 2025 09:10:29 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F5719C540;
	Fri, 23 May 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747991428; cv=none; b=R3MiblQaheiDE9F1qRP3qI76uho7vHyP9WeoEWbb6do7aW9HuJZt0xOy7DYbKj0jDAwI5LM60SUujzdJmgrBQ27/S76GUu8ZkkHDTwWlUJmNhYwhJW8cpSyC+6hC0ypqZKkdE14ouU7Ehn2vIZBBe5PWLVJgbK7H68XHpWpdQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747991428; c=relaxed/simple;
	bh=MDxnLt9ByCXdHX3IQAQYKZdyKJyha4673+V2+dkoijs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gb2Qp5eNbwx9+0VHP/5UayvKR3NU7nnkNsO5e26CCGax0JNek3XmASF5bOikYHqR9BCr0cFa7fXs9AfW2XVDR9wDB/K10O9DOnOuTOyl+vYdQ0ZgK/dE3E9kkvgSzxbeZqsVAm1tXb8XbfPPHJF2CSLL2CUUYOUQuHps6CG9RSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgD3DQ_7OjBoHdyJAA--.36090S2;
	Fri, 23 May 2025 17:08:13 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v2 0/2] Add driver support for ESWIN eic700 SoC clock controller
Date: Fri, 23 May 2025 17:07:47 +0800
Message-Id: <20250523090747.1830-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgD3DQ_7OjBoHdyJAA--.36090S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4fCr43tw1DXw4furyUWrg_yoW8Gw4DpF
	4DGryFyr1jvrW7XayxJa4FgryfZ3ZrGFyjkFWIva4UZasIya48JF4fJa4DAF97Aw18Ar13
	tF1qka1rCF4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Updates:

  dt-bindings: clock: eswin: Documentation for eic7700 SoC
  v1 -> v2: Update example, drop child node.
            Clear warnings/errors for using "make dt_binding_check".
            Change to the correct format.

  clock: eswin: Add eic7700 clock driver
  v1 -> v2: Drop some non-stanard code.
            Use dev_err_probe() in probe functions.

Xuyang Dong (2):
  dt-bindings: clock: eswin: Documentation for eic7700 SoC
  clock: eswin: Add eic7700 clock driver

 .../bindings/clock/eswin,eic7700-clock.yaml   |   44 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/eswin/Kconfig                     |   10 +
 drivers/clk/eswin/Makefile                    |    8 +
 drivers/clk/eswin/clk-eic7700.c               | 3800 +++++++++++++++++
 drivers/clk/eswin/clk-eic7700.h               |  194 +
 drivers/clk/eswin/clk.c                       |  973 +++++
 drivers/clk/eswin/clk.h                       |  213 +
 .../dt-bindings/clock/eswin,eic7700-clock.h   |  588 +++
 10 files changed, 5832 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
 create mode 100644 drivers/clk/eswin/Kconfig
 create mode 100644 drivers/clk/eswin/Makefile
 create mode 100644 drivers/clk/eswin/clk-eic7700.c
 create mode 100644 drivers/clk/eswin/clk-eic7700.h
 create mode 100644 drivers/clk/eswin/clk.c
 create mode 100644 drivers/clk/eswin/clk.h
 create mode 100644 include/dt-bindings/clock/eswin,eic7700-clock.h

--
2.17.1


