Return-Path: <linux-kernel+bounces-844197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA118BC147B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943D23C2D45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5662DC321;
	Tue,  7 Oct 2025 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0uAdM15"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64621B4F1F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838327; cv=none; b=iLlfYZOk3GduvMSoqVPV6Ii7nzmwdXcyokLLadCIQ4vmpFWBV9BdKJiKCW/Efw8otA4uZJ1OX1huuuU69PNQgQ8sMY1mtZHxMWyUh9Kr+ES7DxUHZPnnZCIYIs0ltq/CvJ4FX7A9dvW7KKpgpp99XP3pXYYereVU8bix700Umb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838327; c=relaxed/simple;
	bh=B28UriZIDHaPpeAMdw/A3PSTb2BtJpDt+bRHW5rPK7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=citDokt6/tOYHcjGGhm55VgBbcauOXE01+jyp2+X/HQOroQxjk7Ctx9Xq+EiCfNz24nDP28cWnieiWbFouuuCGBPd/cY5Kx5AmWH6IO2XVK0Kt2YYt7R2LlO0eGqF8LAuKk++vFLCRLxqZWNNgq6ZPZ0A6NX8kSh/rHnX7YGdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0uAdM15; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso9383373e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838324; x=1760443124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UHSTsWVgVFJryrJ3NLdWTjkzgi76W+AuTzj7De7nJs=;
        b=T0uAdM15QY3a/WCz2OJ/5T58Juyfu9jd3fJMhb5Cg07CkVpwXn6/1nqeKNPkw1cbL3
         0fjW5pPv2c1E9g7Q+cSSbYm5yofwUJMzrf9s/WWgifU0dS9EQh/SXE9JpjeBUa3kFtPD
         HR1nwB+o5nEkL3XaLA0L6gR/tF19NA0RmuSpikK+0uXwDEE2xtAH04YMfV1cfuOwtT31
         4V+y2JYT+SyR2i0MmxTg6SCo/1OMRA3R20zDNgpRSMTolksbZjFIGORi0wvousHac44T
         HDszxOPASCrq2dQPfH8Q943g+wC5QzdjWyyU3mouyLVn7CBvRyvYVi6i2ESUwQ+AIacL
         MnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838324; x=1760443124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UHSTsWVgVFJryrJ3NLdWTjkzgi76W+AuTzj7De7nJs=;
        b=uWSe12hAbYCsPjoVa3zKtkmDD75s7COcoR3xSfgYU8Fwwsazu1WfD/5wgR7HpNruL5
         L+EevjRSr/NcStQFmpxZHk45srA3yZ4W0ERYXaXkbw15KjUZSHUJh07oE84GqQjq44KJ
         WYaZMPOZIvvliNPP6oTAwTzSONwWQLQysTJCNJBc55wR3B3PTC/icU8qQY8ahZ1FBM1O
         mrSh3kA1OnulNVBnFJXFmFPfrcdyU6qDM0HJSNfmmdMJsZrbopAg9XRAR8czcZIY9pIR
         qaMdskzVY0ZxR47Yyn6POm2oRlQft1uXUIEQb7+vZiTyZ0DP49//M5SsCIndacErBKde
         ERCA==
X-Gm-Message-State: AOJu0YzIV782uVwTlW5zz/x/mmZluKiVep4wj5F5L6teC2QWq0RUcxVU
	u1Dol3AqVurdE7K5I2Vkmp5vWYKjKHCNXEPdRgTf+ZXbXxZS6wzaMA+J
X-Gm-Gg: ASbGnctycoaS7/PAetC8oSTTlEcBOquFIple0mrjAV59mP1nIw09DfdS/8BJ5N6GDmZ
	4k1s8cXcdhTfNbn8J7YhQzbJw5G1zxjuMQKaWVbg4Vr6TrlDPCfw4aQFOgmcnlYv6zcmtfvlNLb
	SCkEr4M7VIR7lrDalk97koQiHcgWDyRgLGfrgOozIa9LNg768AXw0xa2WkWJMPZ1IVleAsVR7xa
	6Gp7ZNtMtowXSGwSMIOh8rH3pZ55YWb5JxGbJSKTEcnt3hu0T23GF6o6FZFPgxI2JO3pKmPOxnH
	MO5Rw813TNoNxHfuanl0setRPQrNQa1rSAIetTEz37dyJGAmgqZ6aHjnFKXoJ1HTvqUoB55DsJE
	VVFFuR4qY7iQnDEIw+ntlCe5+FZOyJyMwuGXwKQ==
X-Google-Smtp-Source: AGHT+IH7bnrkgnYWwbfbVsumwqkq4TDS5dWXB/mKRxP9HCltzhRMTTRuu0r7Qqnaw0RjDr3wioTn4A==
X-Received: by 2002:a05:6512:3987:b0:580:dda2:52f0 with SMTP id 2adb3069b0e04-5905e21c2a8mr974685e87.8.1759838323582;
        Tue, 07 Oct 2025 04:58:43 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:42 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 0/6] riscv: vector: misc ptrace fixes for debug use-cases
Date: Tue,  7 Oct 2025 14:58:16 +0300
Message-ID: <20251007115840.2320557-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series suggests fixes for several corner cases in the RISC-V
vector ptrace implementation:

- follow gdbserver expectations and return ENODATA instead of EINVAL if vector
  extension is supported but not yet activated for a traced process

- force vector context save on the next context switch after ptrace call that
  modified vector CSRs, to avoid reading stale values by the next ptrace calls

- force vector context save on the first context switch after vector context
  initialization, to avoid reading zero vlenb by an early attached debugger

For detailed description see the appropriate commit messages. A new test is
added into the tools/testing/selftests/riscv/vector to verify the fixes.
Each fix is accompanied by its own test case.

Initial version [1] of this series included only the last fix for zero vlenb.

[1] https://lore.kernel.org/linux-riscv/20250821173957.563472-1-geomatsi@gmail.com/T/#u


Ilya Mamay (1):
  riscv: ptrace: return ENODATA for inactive vector extension

Sergey Matyukevich (5):
  selftests: riscv: test ptrace vector interface
  selftests: riscv: set invalid vtype using ptrace
  riscv: vector: allow to force vector context save
  selftests: riscv: verify initial vector state with ptrace
  riscv: vector: initialize vlenb on the first context switch

 arch/riscv/include/asm/thread_info.h          |   2 +
 arch/riscv/include/asm/vector.h               |   3 +
 arch/riscv/kernel/process.c                   |   2 +
 arch/riscv/kernel/ptrace.c                    |  15 +-
 arch/riscv/kernel/vector.c                    |   4 +
 .../testing/selftests/riscv/vector/.gitignore |   1 +
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../testing/selftests/riscv/vector/v_ptrace.c | 302 ++++++++++++++++++
 8 files changed, 331 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/vector/v_ptrace.c


base-commit: c746c3b5169831d7fb032a1051d8b45592ae8d78
-- 
2.51.0


