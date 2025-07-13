Return-Path: <linux-kernel+bounces-729108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFC6B031E3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5244A1899F69
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866027E045;
	Sun, 13 Jul 2025 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlFbZxFf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255D1863E
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422020; cv=none; b=oCG2+Pe25UFqgsYDa/5R/JufmxOwhgBsMmzwIw4kjWp0ZgZJeHj6b+VNOHSiR2zrR6XEsnTWFWBQQ0vJkwvJRRmQCYNcN8912stgA85+8n3KkaKG5dvocjiZAEFQy9BUchhjgJr35CIaICLNWKYQgzev71ikkvGOBpQxmv/V120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422020; c=relaxed/simple;
	bh=KW8diOD7GzEBunJn+RKzPhWkRLpgAYo3gtaKrpFxmgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E6SIFJTKSJjd8kpYgNIiAgP1YlL2NxXZTMa3Amh7jie+pcy8Umg2KIirxeOiXPp4nCZRT2t7BHNHm8dYO1ZtpF4on8q3FtnBDaSVDCGjYGCDjTjxAknfxD+Ww7vZSrdcOIDGJQCFQLg8+a6JezsTDugjuff4PIDdEePa77xzDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlFbZxFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A31BC4CEE3;
	Sun, 13 Jul 2025 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752422019;
	bh=KW8diOD7GzEBunJn+RKzPhWkRLpgAYo3gtaKrpFxmgQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MlFbZxFf5xje9Atzw5RaEYBbqIntMtaMQQRbp2F2byiMXOo6J9syOSFc01a4I5VXp
	 8mQuBO0E6qJLNjhgMPgtMlYdjHDAPg4fHJFmjEiEjfPHIRLkhIm6JeSLf+WBDMQyhu
	 4FRc9xCGmVVItWx6ZVzv4TzCgYe6FdcqXwsHLJ7ofufwnjvHxA/EQCDv3cQUuICj4A
	 AOyZWKF3+E3QDyl1kE4em8dyuDhtX6czErConFw7SNXBWbHX2UQitZoIzDA+uwbB4Y
	 +GyGSqMfOLIRXCiEZU+ZzEfLnmJU/uJYLBawAaLkdkZX3PdjessxgydkQscQl05GxQ
	 Px9QsLpGOpHsA==
From: guoren@kernel.org
To: palmer@dabbelt.com,
	guoren@kernel.org,
	conor@kernel.org,
	alexghiti@rivosinc.com,
	paul.walmsley@sifive.com,
	bjorn@rivosinc.com,
	eobras@redhat.com,
	corbet@lwn.net,
	peterlin@andestech.com,
	rabenda.cn@gmail.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Date: Sun, 13 Jul 2025 11:53:19 -0400
Message-Id: <20250713155321.2064856-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

The early version of XuanTie C9xx cores has a store merge buffer
delay problem. The store merge buffer could improve the store queue
performance by merging multi-store requests, but when there are not
continued store requests, the prior single store request would be
waiting in the store queue for a long time. That would cause
significant problems for communication between multi-cores. This
problem was found on sg2042 & th1520 platforms with the qspinlock
lock torture test.

Changelog:
V2:
 - Add new header file for errata_list_vendors.
 - Rebase newest kernel version.

V1:
https://lore.kernel.org/all/20241214143039.4139398-1-guoren@kernel.org/

Guo Ren (Alibaba DAMO Academy) (2):
  riscv: Move vendor errata definitions to new header
  riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup

 arch/riscv/Kconfig.errata                    | 17 ++++++++++
 arch/riscv/errata/thead/errata.c             | 20 ++++++++++++
 arch/riscv/include/asm/errata_list.h         | 19 +----------
 arch/riscv/include/asm/errata_list_vendors.h | 25 ++++++++++++++
 arch/riscv/include/asm/rwonce.h              | 34 ++++++++++++++++++++
 include/asm-generic/rwonce.h                 |  2 ++
 6 files changed, 99 insertions(+), 18 deletions(-)
 create mode 100644 arch/riscv/include/asm/errata_list_vendors.h
 create mode 100644 arch/riscv/include/asm/rwonce.h

-- 
2.40.1


