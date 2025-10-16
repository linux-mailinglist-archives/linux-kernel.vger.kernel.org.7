Return-Path: <linux-kernel+bounces-855392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A60BE1156
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2286350C28
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE041C72;
	Thu, 16 Oct 2025 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ifSuaKrU"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8B1C69D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573838; cv=none; b=MZxPp9OQ22Q8AqiOZ2sKgDLR22itRmzWHbvOp6xPiTqilts0SR9YRHpr2QywWZfCX+4wc51HQTgxAxCYWAjuXVdGyYqD7arQsJs63qCRbQ84JHt3Dcv4sXrD/2Yusw8dr6Q57BWfwUmd+uqL1J2RLIKbkxdhDLv2KHTvkROuG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573838; c=relaxed/simple;
	bh=3nwS8JQ9zjyPPEh0FDdvtn+6T1P3KX7rqtYXZtj0c4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uMhlegZ+phosMWqMdXhYbTinjnh7GGzaf2wWiFWsQesnpyOCFJYyZ0m47RAgEnCdoGoFR37eUBtcIAmxnnL/C0WUUJV/wD5xdidnFIvJGyd8q1AZL9VmeGj9cTOB6/M+hCDe5NIn9tJ1+HRpZC0NaIjPFqiUh2Z/c25i+EC4B98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ifSuaKrU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso59618a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760573836; x=1761178636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwptj4G5KoYvNAhjikL6LhizMbH7cKsoQglRkksgDsw=;
        b=ifSuaKrUtRlBbG9MQ9Ok1pW7Uecj7cFdCTd27QsS6LG9A/r1vTYBxOVTBHuYt7FAIZ
         LDVb/cQqIy+OFt+p5bZ+MSoQ01CqI7Qkp+hpLYmPIWDa7FVh95tavaQKjt/yCsY5uiWQ
         iuVnpZHm3/YV4xboPJXD6IwZ3l6rts8cvUG3PQeP1CsJHCAF/1XdX0chvRPitTxb2CEp
         AsTR44Z5P3FHfjwqLAOwAHw/mIUappj/PCJpc9jFl96AwExZjOXwSjgeCAkMyPq9ZJyG
         aNVGkJ82jAGDY7IkojXTnW6Y2ZsnMThMkVaWuTuMaQmDqg1Ym1hpdcD8PLzB6DRKhEc+
         7T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760573836; x=1761178636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwptj4G5KoYvNAhjikL6LhizMbH7cKsoQglRkksgDsw=;
        b=pV+iyiOiiglm8Kxf/KD6piplaOfwXa8vDna3u3CPZd04RBQJz4OhgHmBR+9dkYXtqQ
         p8EVTkP5YagWY4CZn/kp0OIPnIhYyyk70JuuqmABfDzkNM1WK6V/s3yq6i8cal7GSnVB
         /LioOAZybGIVc9YupjxdGrt0GndBH4zlaqQeNXP2znruQ21d5jueE0FkJzt8F4vRAtJO
         CP34ZkOLVPFfkNXSAQb/MWZ1vYuxzG8ik/kNQbUjoWLl8upjDvWT+8IxqpNL8CiPSjV1
         whB3HQtZi52YyKrMyBcNfhQXy5WegLwDzzdtw+FEAJz/AaghDQnf2ImBH7lopa3pKo19
         /zpg==
X-Forwarded-Encrypted: i=1; AJvYcCUzlR/4dU7qKfzRpuDL+mOZVBRZBUNQozStG0jiCH2NqEKBGKDCg43s+08wmRJTDMmS94RZI2/RHuoMACo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxkXVHC1YRdXjkzKBABLINnL5Mf1Co1bM8eyE0j6hbq3F+ZdX
	zGkdZD/zfcfDBNwc1YwAwaL4DnRyFimYFtAicxC3+Muwe8ngAc40qn4b/agTInAfTCI=
X-Gm-Gg: ASbGnctZd2HsHTr5D/Tzkz1pYgWHEF8jessWcnItYrcCVzLbZkAllJ5xgVeuS0opSyd
	vFs853swQ/sFPnrlc62Z/3YKLQIh/c/Ptscr65jM8+2oBuou+Sv0FRBq5UURYj1A3a26r5SZCqS
	5hOoBsP4v8nuyWT0NQF6rAPElr/DF4EZgIR1JUxN25goCeOMSDBLjVKmzuvbM+VaCqNmp0e9MQM
	wrBuMfftuUqmXvl/lxx5Nue4PTmZTtPO1hhhvrJce68cfsJca5WwWh7xeJ3PiMl3AxQJ0QU0G1J
	7RbGt4id+yHISkN6DSMlbJAqauo4tRJqw90MXYDqpr3d7dSbxOk2R74el10SgAjeFeCekgX0VXo
	zVjsYCASAapuHCisvMOGDIB5FUCGyF+HbZV6TbPjiBrQ41kvet9ZLnAHEOOhjcRCfvrvcqDsab9
	xkawUBJ38NAleAQChuyfwe+Q==
X-Google-Smtp-Source: AGHT+IF8Txz7jrNpsSTJjE/JSeJk6k3fgDPYMzVbvQKqjcn0cbcXxdsvxtPavIzWrNBmcH4D/9ElyQ==
X-Received: by 2002:a17:903:2381:b0:275:c1e7:c7e with SMTP id d9443c01a7336-29027356a08mr313186275ad.4.1760573836372;
        Wed, 15 Oct 2025 17:17:16 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afbdb5sm8484645ad.104.2025.10.15.17.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 17:17:15 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] RISC-V: KVM: Fix check for local interrupts on riscv32
Date: Wed, 15 Oct 2025 17:17:09 -0700
Message-ID: <20251016001714.3889380-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To set all 64 bits in the mask on a 32-bit system, the constant must
have type `unsigned long long`.

Fixes: 6b1e8ba4bac4 ("RISC-V: KVM: Use bitmap for irqs_pending and irqs_pending_mask")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kvm/vcpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index bccb919ca615..5ce35aba6069 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -212,7 +212,7 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
-	return (kvm_riscv_vcpu_has_interrupts(vcpu, -1UL) &&
+	return (kvm_riscv_vcpu_has_interrupts(vcpu, -1ULL) &&
 		!kvm_riscv_vcpu_stopped(vcpu) && !vcpu->arch.pause);
 }
 
-- 
2.47.2

base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
branch: up/kvm-aia-fix

