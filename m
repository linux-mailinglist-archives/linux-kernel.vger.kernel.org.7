Return-Path: <linux-kernel+bounces-807317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CEDB4A2E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1AB17AF65D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487D30AAC2;
	Tue,  9 Sep 2025 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Dyz5vgAO"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553E3090C1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401414; cv=none; b=Sh2Tz/ycazq1uHAa9juSTOewttxrmXwLXa7KDt7WuPE6ZXz+GcFd5Z7WHW3lqgWcDTSWYo0z6gndZ9jBv18BHlI3tOoMmQn0zn6e+dIJIKqW4vt7YaU0BcyRnkXBbMa8FdfPaC2yDD1Opxs43+OTq0vL3pop894AukNlBG2RqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401414; c=relaxed/simple;
	bh=XThoAUpZFHs1s+pwrFwO14HP8Izu5U/x/smPnCa25bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jh07FWfoS+sdezGKI5zR9LpBTo5JM7ZkhbNwqvGOnU82r3fK6c78QY0TQOlyfoUCj2L6VI+uY2bilgwLg3SYaJ8J3BKUHnNq6kmTFYP8aMacWpAh5ZdMa53uaOTGSNjT64e2y+hLbqIroTEjgHvRir5uGWIYNlQQEFpNnqWSlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Dyz5vgAO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77256e75eacso4732377b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757401412; x=1758006212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRvT6lW8SE24T6disqBtYa/lDa3Uh1O4/DOC6STqtSc=;
        b=Dyz5vgAO+mueIY/tuA5IItacvLH9s8N0uaDTRCFKpTztqGluuA0S4EygRaEki+oq4q
         Dr9lC/ghGGfruoJoy9VGH+q6scJ2mWNsrwVMvccgU+YrGGNrFWmVruDLjvDXQceRlFzr
         L31S3D5UZhfKvIRF/NbxVRgBZq79Hnaj8TT2MOssQN9RhFFrAYODkR+1S2q7PQ2iVVLO
         AyQiUeip/hFonOAByA9/vmfN7uO8zvJZ+OGcd6ELR6gB845KEcqLjBq9O6HEiY1rTX3S
         7b1jGt0Kphg8qDdwAQfrlbBD82fhMx3tahc5oN8Xqt5vTSZls3DQXqpcCBxVlMRhcStf
         YG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401412; x=1758006212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRvT6lW8SE24T6disqBtYa/lDa3Uh1O4/DOC6STqtSc=;
        b=GYT5iuLtNZEQd+K7IpI4nJTVLMgEdsZVbwJoXf1l4/zQFn9RcqtVBEIpAr7zXbyNM7
         jpnOh4+TXOzPmbFN5qOJid24GZR7Mq0PCkQ2eNsN2WyDiKp8o+WAnkdBrIPdeA3mIgEC
         i/OE+kB4u9OGmTK+SdbEfVD8s8ArFeS4Tyc6nlt9i/pJch2MB58dS+fHJ3pxUJIvoiKx
         ufMUe9gqA//TkcoZ3/5fmyQqI1rP5TfMj2WWqVRUZ8+2xB0JfOY8k82HSKAL9B68Suro
         F0SHYR7/oZbFOrtL2TkvO8BPMB7Qth/Xz0TsGdtr2rj7W0rC0hLJz0BrSfNQmCzPY+up
         ibCg==
X-Forwarded-Encrypted: i=1; AJvYcCVEt8e3cr/nYijuOwRvH8yjYZA9GeZ+xfjStwhcUN1VzSRdQBHdcaLUhWQUkOk1JmFSrs4xXMquz5xiAGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+MXE+N9MORTC+o9lVAsqbXc1/MzelF+p9oqAvhTTNsY4M9+0
	DTsJNBESe+n76ARcF+gjOv9yubNZQmqyq8d5X64koKbVhiojcPJ0+PU5hPOVkgTK+WDQelykc56
	ktR8L
X-Gm-Gg: ASbGnctrIBxmknYHqxna/LNuDsJurlnfAGGorfh1Qj9bCFDPfogPsUxm+6u9CkbwjvO
	RFvcPSdQiLAikHCGG7uksMcKX/CyWUOAcvyREf4vTsV53/AJY30Uv6QKzEH1XaMl/iF1Yz4ZZmD
	cAN+VK9wkYkg8FxxExqN8VtumihSzemrFYBtFhalDaP2OHBbzedgFhr7Hcdy4qOyZc4iE1OogRi
	q0ZsBQYtFhTo4dy8gDZcCuNmoHNx0QOXCzWmgsyreyvd4gRYAADXYd71+Cl/dTR0Pd+7wkWT+4O
	Hy90R78K0jY+QaV7Wuj3Dx8HGcH7l0AtLw8McLqeo3C/3u4tYTVRwGP5M+1Fvw8N8wrY/KytDGK
	nRYjJlGBV3Y0X5Kyaze+LWN+TrsaT+TO205Zmv4uXW7DCO4TB2ULCCi1n
X-Google-Smtp-Source: AGHT+IFeScYoURP1S0tDI9KKWt2+546E0P9kyjl9XLHBCBfgEh4mWYviwRJae66lvgYjFmHDEYj1kQ==
X-Received: by 2002:a05:6a00:140f:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7742de60630mr11833770b3a.19.1757401412287;
        Tue, 09 Sep 2025 00:03:32 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7158sm1025535b3a.72.2025.09.09.00.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:03:31 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 09 Sep 2025 00:03:27 -0700
Subject: [PATCH v6 8/8] RISC-V: KVM: Upgrade the supported SBI version to
 3.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-pmu_event_info-v6-8-d8f80cacb884@rivosinc.com>
References: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
In-Reply-To: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-50721

Upgrade the SBI version to v3.0 so that corresponding features
can be enabled in the guest.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index d678fd7e5973..f9c350ab84d9 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -11,7 +11,7 @@
 
 #define KVM_SBI_IMPID 3
 
-#define KVM_SBI_VERSION_MAJOR 2
+#define KVM_SBI_VERSION_MAJOR 3
 #define KVM_SBI_VERSION_MINOR 0
 
 enum kvm_riscv_sbi_ext_status {

-- 
2.43.0


