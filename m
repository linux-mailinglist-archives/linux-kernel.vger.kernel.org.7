Return-Path: <linux-kernel+bounces-729762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8DB03B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6575E3A2903
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622D24293C;
	Mon, 14 Jul 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EPweWqJ7"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51A1E47A8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486368; cv=none; b=J/oWxjtM5ABSB4vi5lUS3abh21wk8Bx8rL2paaFN6766+Q4b4Ruyxk9xYKSxYGtpbAb/69VAr90nZt5M9veI+ivcqfxS0X2/fvPonJMdUZYKJduhh1k5ocDken5OhWGZ6PiD3IZ03Bj4eBpFfcqpriC72yT1dN60GNxDw4+REAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486368; c=relaxed/simple;
	bh=nSDiWwcKhqBcSjyKV3EIuCxjblg1mWRaJe5gw9GZdDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qLekCy4+GwhnTEd8D15Fpu6mwYLUINyPAyk8lP70pncfbXU4gICBEcZERVHEeRKbvhNWIUdVx5/BtOcShWvK5Vxoptx9HAE7DzmyH0M60ey6GXe3Z+6hsOM+/e2xk6Y4EAg2CTSxU6NKk15E3+bO9djB2RG+J2cVAuBYbiQ+aoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EPweWqJ7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c7a52e97so3170328b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752486364; x=1753091164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dnf5JriQVpHQM4YNtZJFgadu2tM3f9E9KiPFuztXa0=;
        b=EPweWqJ7HGg20kQdGVRKB9YV8O/2pre0jfr1xrOznkxR8hzx86XPJ8Dx2JJVvIPsCc
         p1WuWswI9AwmsYV7XcVyiE9A967cY2F0CYgBa/q4Rwex+6HhMPXf8bH2GZyePZTKPMQy
         ZjRwDhHv5F1bLW0nKHyW+zDoTjYzcyTlVnsM2Qjw1JYPyuL8S67N//kveGksavFSJ62c
         ld6Z/Az/NlQSUhaFCRyJTbpl1FDACPiOxKPOTLQ/PbkoBEQsDeL5aULTi2NbBhXPeET4
         NGBOKpeRkdbnG63LUqMYNk1bpDFUehwNLz1YwBB1r5Mz3UooC3w7I7yl3eKf9KQJs0WU
         9DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486364; x=1753091164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dnf5JriQVpHQM4YNtZJFgadu2tM3f9E9KiPFuztXa0=;
        b=MnGQCE0Cwdd3QbyW0aHA+HpITx2eqovc+ibaU0oyIbECjxIQN6eq3eaemFnd0ckt15
         96CHZRfFug/W56gvzu+4sjczxz+Yu8LY3rIEs9OHAqPua6lsFeQbta1tNgHIaewjKLiM
         rJZ623gjNAo7A+3hzVf0d91zqFl8WtQPKLz5aLILAcZMeezPDlJlJa7dOfWeML6mb6eK
         xLSxltF1tK2jo9Q8zSw7/ZthHaJfUSVoqHasaDfZyJTbSqoxdXgiZZzpuwYm16HiMbKD
         kQv/qH0ZlsfMqmsxaTAQGPcwLh/8tVZVzuR0y0fp/KX2f4xWyWTj2Q0wflaa4mmuaXiz
         4Izw==
X-Forwarded-Encrypted: i=1; AJvYcCWRXhIBc2BzU2ujzaSwFO044sE2xOXQXwb4VV3jS4tQ21rfz7Fw14UhYZIfzGATgsLiqOFFzYvDn1SJe9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDzKxXF1HSniBZSSlDi+kxblDm2A2Jr4Xx6D4yLx27rqzDAaf
	ZaiTlC/Yon5ar00WGh7Q1SJsBNTfXfwbTUlMvsb0ZDRFrQqMe4PBk605xxRQzFs3q80=
X-Gm-Gg: ASbGncvDvxp0rwLtavgLe56GKjCToK2OgkcQ6zA3GDIRUJyjvulXRGeh4HpCBlpTXyh
	V+v9gNP2/Ku+5ZCIysQpnte7nNhC1xxiQ5j6VN3/Jv7bK8BkBwBZ/yvwrDFG/dd3Hxyg9DnoFMd
	S7PoBcuNebNIRDVq174bDHkgcSIETm6gCVhLoN9VQz9IpWce8TlL6GCWuGqwQE98+gQ4+pPrWSc
	kM9X3Y/9VQD8JQ4E4V9q5+J/1f4grw11LzyqFOCR5EW9p3ZH/bpop5gSlZy6E5062pKjepBpVYl
	daZ1/eg7L6+VY5SHg7l88+wEXzSO37lBm8vH4nsx/PVESJ8rVpKR97SHCT6XGkn8GtcKyLwE/Ff
	EsQ9Yfp5ZRE2kTQDns20nCBXg7WJjMMvAQyiXq4xEozQZcTvforqLVN30xz270gJ509PMZ1ByEy
	OF8KNl7N58Qw==
X-Google-Smtp-Source: AGHT+IFF990cxBBIj5rcns4ua/Z9mSLbBzTWgWQcSkoafAxgEV/F4FcvyqoXGxjBchTkM6/hWtRe9Q==
X-Received: by 2002:a05:6a00:1992:b0:747:accb:773c with SMTP id d2e1a72fcca58-74ee2c509e7mr17413857b3a.13.1752486364023;
        Mon, 14 Jul 2025 02:46:04 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd73b7sm10201283b3a.1.2025.07.14.02.45.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Jul 2025 02:46:03 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: rkrcmar@ventanamicro.com,
	cleger@rivosinc.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4] RISC-V: KVM: Delegate illegal instruction fault to VS mode
Date: Mon, 14 Jul 2025 17:45:54 +0800
Message-Id: <20250714094554.89151-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delegate illegal instruction fault to VS mode by default to avoid such
exceptions being trapped to HS and redirected back to VS.

The delegation of illegal instruction fault is particularly important
to guest applications that use vector instructions frequently. In such
cases, an illegal instruction fault will be raised when guest user thread
uses vector instruction the first time and then guest kernel will enable
user thread to execute following vector instructions.

The fw pmu event counter remains undeleted so that guest can still query
illegal instruction events via sbi call. Guest will only see zero count
on illegal instruction faults and know 'firmware' has delegated it.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 85cfebc32e4cf..3f6b9270f366a 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -44,6 +44,7 @@
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
 
 #define KVM_HEDELEG_DEFAULT		(BIT(EXC_INST_MISALIGNED) | \
+					 BIT(EXC_INST_ILLEGAL)     | \
 					 BIT(EXC_BREAKPOINT)      | \
 					 BIT(EXC_SYSCALL)         | \
 					 BIT(EXC_INST_PAGE_FAULT) | \
-- 
2.20.1


