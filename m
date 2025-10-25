Return-Path: <linux-kernel+bounces-870131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E6C0A017
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4863AE136
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8929B20D;
	Sat, 25 Oct 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3EsoE0t"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDDB18DF9D
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426430; cv=none; b=QnzLF3cXjCHsDjHis7abe/rnoFVoIscOxejXF4Z+hNbD/8u6yocOLwl/Eio1TDJP02FONulk9/2RVioHImYGTz1sy5MHByHhccHAUCkh5z+JwDPFXmrRX4NU31dz6jb/LGfQR33DLklihfQfTxhKFR+uK54SduBe9WLMNdrr+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426430; c=relaxed/simple;
	bh=8RdkWogzljVCUUb1BMp2fjK1Pb4SC1Y3SKwML5scyPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZyDjRddmjY7aXszGHdNjdZzQpEyCrZ9h5JfczyRe+Yr3RYx26OlvmE0i3phsrYI5dKl1RVmAKJeL3hWnQc4FiTHRldJFay6Ge94BP+Vt8S/MQr+NabpDKB40qwTxjsd32BsBPYLF+4Fb8HBc9JBwuZ+9r1BnUK7CbSwflfzeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3EsoE0t; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so4002433e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426425; x=1762031225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrTy/fULfWQ/AuOkkZeBntBWMGO07F8iRNTCWK3FE8U=;
        b=C3EsoE0tq24VGEPTsvjKNpiQ4VWxxhLLZ+Y/OTYTSNWj6tpbUegOy/ZDJ5H50a27uS
         JhBdWZxnFaXtjpNLXSy8FJexItswpo03O6sidovAzTISuaMn8Z/K600mLl216+DUIKO/
         Sg95COAcizDSXDJXWQ8UiF0O4h/5Vu2Vhn5p4uaKi7igrF3+rHVdDpOz8bAAHosX3WFd
         YeQe5MKCzfl7F/2vhRKU21IHd+pk2RJ6JknBRStFoJy1UwUehLmWQEevtluyfA9jqRz0
         JXmbhMclKw+3WSQ8iuEAOR3n0CQna4qY+EccDu2jkjGSgXqYUkb1oKigWjyOmhSDRf2g
         oboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426425; x=1762031225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrTy/fULfWQ/AuOkkZeBntBWMGO07F8iRNTCWK3FE8U=;
        b=H26pZBZ546uZoVVT8lTON0D+QI59E76333S2wEMQo05hQbk7qU7le5Jwvz8NIYgonB
         2JE/ND8OlZuVf9Un4MY/61ji5C5TijnFk1GXvG5nLeM4H7m2e2rfagnZ4bN3DFk4ilu2
         t8hzmtuQvgPQS8/uZXS3YAJMuQGduERW0YAG97g6AP0bF6i3EdxkwalNOjPaj2R81r1G
         opEnwSr/iAExaXvyYfDDNV8Q2biffQRk/vi/9w2REKDOh2WhtDH8gHmq/xG3nldV7bTV
         n1MnZK0Qi+u9JL0p1Zid58qDpzaHRxCZ/RW+/3ciclXdx4HLKtLzmKgwlYgeUZa6jujn
         x3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVIZQ1FnVl7cantgEjmw6LbHT+kBi7TvRwlXQw4mmEs7YsBL6dWiq0Y21A/VXHM9vR5Pg38QkqOBTdIh34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuYeR/jADWnA8kzDifDQ01tPQ5XXERyGJKRQYktK4UOW3uiFe
	vcrBZjATlqNA93415w5vFEILLfY0FPo4LWgWPg76qfUafcP6EedLLTUs
X-Gm-Gg: ASbGncsjv7Arrtd4mnbvJb2ZWBiAvXUmoN5jBGrfKRm9NgN3hmenp+LrwIIq6Q0pQ6k
	tjRSqlKs6MKeqLsnbfUzEIzze0+F1HNVQ5onlZ3aupyIPkBLFEK4qIzbEGz0jfFZiI8K20dr3FA
	sAX2YUij1FPHZeqhyqUgjpwSQyMo6EWgByI70E2ulepRFKzDyal3VyLzK4T3SNYFCGg1a2E9vvs
	PiBKQ1WqW+IGRvCAUfSAbJNKKNpO7Eu59SEIVSJRgXbwaKkpMqG1CT0T6eq4U2ArVA/Z9+VoBrv
	jl5GkorbrjPMcnU5x561m28DWKA2B/M9CNDv1ZWSUcQddz35HhoCzIPrEsIniMmhO8+Vs4bkY1Y
	DXcgAUcPgSZ2fAP1ZV0NpDQQMtQ9cQnDQymhzLQ+/l3PVEG7yS921GM1wUHpKr725KMI=
X-Google-Smtp-Source: AGHT+IGVmkvQikvMTRY2P+CBsoQX/dtGCo+IL2vMn6AXhs8QRoo32mt2Gun7dSC5qD6SHJZx3Jm6ZA==
X-Received: by 2002:a05:6512:3da6:b0:592:f7b7:2f6b with SMTP id 2adb3069b0e04-592f7b73090mr3904766e87.4.1761426425215;
        Sat, 25 Oct 2025 14:07:05 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:03 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v3 0/9] riscv: vector: misc ptrace fixes for debug use-cases
Date: Sun, 26 Oct 2025 00:06:33 +0300
Message-ID: <20251025210655.43099-1-geomatsi@gmail.com>
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

- init vector context with proper vlenb, to avoid reading zero vlenb
  by an early attached debugger

- follow gdbserver expectations and return ENODATA instead of EINVAL
  if vector extension is supported but not yet activated for the
  traced process

- validate input vector csr registers in ptrace, to maintain an accurate
  view of the tracee's vector context across multiple halt/resume
  debug cycles

For detailed description see the appropriate commit messages. A new test
suite v_ptrace is added into the tools/testing/selftests/riscv/vector
to verify some of the vector ptrace functionality and corner cases.

Previous versions:
- v2: https://lore.kernel.org/linux-riscv/20250821173957.563472-1-geomatsi@gmail.com/T/#u
- v1: https://lore.kernel.org/linux-riscv/20251007115840.2320557-1-geomatsi@gmail.com/T/#u

Changes in v3:
Address the review comments by Andy Chiu and rework the approach:
- drop forced vector context save entirely
- perform strict validation of vector csr regs in ptrace

Changes in v2:
- add thread_info flag to allow to force vector context save
- force vector context save after vector ptrace to ensure valid vector
  context in the next ptrace operations
- force vector context save on the first context switch after vector
  context init to get proper vlenb

---

Ilya Mamay (1):
  riscv: ptrace: return ENODATA for inactive vector extension

Sergey Matyukevich (8):
  selftests: riscv: test ptrace vector interface
  selftests: riscv: verify initial vector state with ptrace
  riscv: vector: init vector context with proper vlenb
  riscv: csr: define vector registers elements
  riscv: ptrace: validate input vector csr registers
  selftests: riscv: verify ptrace rejects invalid vector csr inputs
  selftests: riscv: verify ptrace accepts valid vector csr values
  selftests: riscv: verify syscalls discard vector context

 arch/riscv/include/asm/csr.h                  |  11 +
 arch/riscv/kernel/ptrace.c                    |  72 +-
 arch/riscv/kernel/vector.c                    |  12 +-
 .../testing/selftests/riscv/vector/.gitignore |   1 +
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../testing/selftests/riscv/vector/v_ptrace.c | 737 ++++++++++++++++++
 6 files changed, 830 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/vector/v_ptrace.c


base-commit: 72761a7e31225971d0b29d9195e0ffa986b77867
-- 
2.51.0


