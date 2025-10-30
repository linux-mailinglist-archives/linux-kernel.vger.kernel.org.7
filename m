Return-Path: <linux-kernel+bounces-878374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA54C206D3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C33FE4EBDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95771233721;
	Thu, 30 Oct 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MdzhP0dt"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE221DEFF5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832624; cv=none; b=RnqENbGcqo5AZo4+sceDfbiEHkh0mRb6Z7VXects2mx6S99GfUmu6C8LBSD2uL+FgyFLzcMyDAA+L82TwIO5JVS2a3598vY+DHCVAFjzMisfQhcZJ/1hJM4cLCa1BDs7bOhVSehuZq8MKEe0sHp6dD40GaSmDyd6ZRJYB0VYZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832624; c=relaxed/simple;
	bh=L6ZolACIi45vTvGhv5t69evXDSyHLYBaK7rVKfVns+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzMSMtch8MMgmSYjTCG8DDRmgVNsKU87ZdYFQq0Pu+5bru6NOM0boRC8bx1bCa1xrmXvzb/YHle9QzIfVMW7HDLRwmJwc1kQmb1K45hGY3lSWeHNnfonyW6G9F/PFgIOLOpACDdK0fyz3J7KVv20YLZPWz5CC9Z4teMaHb3A/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MdzhP0dt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-294cc96d187so13639595ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761832622; x=1762437422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jk8TnzOxyuLBQtldVmhC9Imz006gRUGHy0jLbQTIeSg=;
        b=MdzhP0dtigPeBFhTddi1IfSgLqanq1wz+K+3zz77y7mLml4QwmOrjwHnnSHNhV1fxL
         9qN7vEAdjI2rkb4UrFgn/xqsBOeyPPthv/KR4Bf73fqLWsmsBPZEgiLqBIRW6/if8qxe
         A1u6044Y0bhQBO7DOTM2wNmsXxkm35NuXBXV0EegE4PqDs1koGrjvlqT3UMpq1zFwjag
         Pu02cyYeNlB9ZPFzEAs7ZZthf/Tb0Onog8LChiwJb3Yz1brc2B1KzyuCuvTuqN16fhwe
         eNp82Ly0vqaXcRjCGCmmzbKGOpHyDtT1RKDFkJvd1BjrxIVcWOmKMkKfLERLUETsELlg
         zo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832622; x=1762437422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jk8TnzOxyuLBQtldVmhC9Imz006gRUGHy0jLbQTIeSg=;
        b=Uth/ns0Wh7N2gf6naZOjC/M8rfUz4gOX6xL4Shr3NU9NJfmFcft7QBwQTeIlVNnMTz
         f0LfuOnkJNTO9qo1fE4oC21mncHrm7Isq4/YlM0XDe0g9ZiGrQG39IsKN0XW4voPcwU4
         SNfi+wbXGrCazd/SW5upf/uLEKzOLX63p/L+ITULKiw+3k2jc/KOwAqAN3NL+NEhcJ7k
         XC84Tes2UkmBPEXkBdlZLZd7wQzHZNNPZJl40Qf2SwQTFlOmYwNfPstf/7bq2g8LpmqH
         HHaofp8qhPM/iIp1YkT5g7XE3NdQGK5t+FFcGwPM+SXzCnJriednGfZjAmSbmh/+tWqz
         FKoA==
X-Forwarded-Encrypted: i=1; AJvYcCUnpCbTSYdyftMCOVqbg2P7i1L4JomuH6m764Zbdtuw+vcBhl3fZlKWy6zSQJso5uK3ciEK+pi1Gohahlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBF1jERqAGW5aAxRqxRYu0Cjr4zgaYDQhRCTL7IfAhmJXJUzck
	um8iwUYbOq74p5P5SaFP5r3RJZwajkscUVKYi8uqfqOoke/CR0PohxJoFxpqnJYwVyQ=
X-Gm-Gg: ASbGncvmIxwGJwLMKJ9bzemRqX5kBhYXXF0DDnH4HF2ctjLHzpCXmdJ4OF2ca808R7f
	7oMb2P5wP3dKMZc/D61y3E0Xr0XueR8if8GJqNRr/MiW4hYf2GqDpS6tUd5x2HLlPZecnhSy3RR
	hetjqVLiMzbVm81h+LWOR44uv98hriL65eJHwgVLlx3CZ5lvj6ezS7AS81QgrjDL5MXTBLJxKAz
	h2496R4Hyng8q3z1jUOmuIMoaP7AnjKW85Ffq+F6BiiYihFyH/64pGBG4Pjbz9Kg50V9Xc41k/r
	7qpVFGd/A1fg0OAiulUNdLQ2oIcz0jK6iFh0PD9hKFjtEwKm+fSWpYFpDBRpPPIlZuSLp9ZnRQo
	s8FMHJhtWBz/MMhlFdKUnkLC9fBtCToZWKo5ddgLjM2emeHzUkutHldiodeX4IbULH/cQ0j1uKs
	h9U0ce0XR1NzDV08PawEPcIUVPL45MaVh3/jcHnxJ22w9kXGhh73yo+LCbBY8fQZen7UcDD8hZA
	A==
X-Google-Smtp-Source: AGHT+IGpaSpfBxlrthCicNKtIDC5somDGkkgwjpvULUEKqRhdtcWOa61ZR+A4h5HiaDX2of1Cz4ySw==
X-Received: by 2002:a17:902:c402:b0:294:e8a0:382b with SMTP id d9443c01a7336-294ee477f04mr37227085ad.54.1761832622332;
        Thu, 30 Oct 2025 06:57:02 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e495e8sm187071905ad.110.2025.10.30.06.56.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 06:57:02 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	apatel@ventanamicro.com,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v1 0/4] riscv: mm: Defer tlb flush to context_switch
Date: Thu, 30 Oct 2025 21:56:48 +0800
Message-ID: <20251030135652.63837-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When need to flush tlb of a remote cpu, there is no need to send an IPI
if the target cpu is not using the asid we want to flush. Instead, we
can cache the tlb flush info in percpu buffer, and defer the tlb flush
to the next context_switch.

This reduces the number of IPI due to tlb flush:

* ltp - mmapstress01
Before: ~108k
After: ~46k

Future plan in the next version:

- This patch series reduces IPI by deferring tlb flush to
context_switch. It does not clear the mm_cpumask of target mm_struct. In
the next version, I will apply a threshold to the number of ASIDs
maintained by each cpu's tlb. Once the threshold is exceeded, ASID that
has not been used for the longest time will be flushed out. And current
cpu will be cleared in the mm_cpumask.

Thanks in advance for your comments.

Xu Lu (4):
  riscv: mm: Introduce percpu loaded_asid
  riscv: mm: Introduce percpu tlb flush queue
  riscv: mm: Enqueue tlbflush info if task is not running on target cpu
  riscv: mm: Perform tlb flush during context_switch

 arch/riscv/include/asm/mmu_context.h |  1 +
 arch/riscv/include/asm/tlbflush.h    |  4 ++
 arch/riscv/mm/context.c              | 10 ++++
 arch/riscv/mm/tlbflush.c             | 76 +++++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 1 deletion(-)

-- 
2.20.1


