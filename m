Return-Path: <linux-kernel+bounces-756287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F26AB1B251
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 880E44E06C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C635242D82;
	Tue,  5 Aug 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MfB/95/X"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F91242922
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391248; cv=none; b=LFslauwqO4xBk4dMi8WQuK3Qc3vIKkj3qHZ6OgQa6PhVDwH0lqS+aamehim4UDMMnKO9a8RJiovB1wl0uTiF78qqXh4v9Sj8UlfJ0TsR7uuqIeUZnPO3oBxeDMbDf5aHFLysgJyBFRvCIQw52qLoVyzI+9SkhR7i/AT9sM7aHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391248; c=relaxed/simple;
	bh=j6njE58QFD+zg3/0GPbXJiFfWjG2rF0iiy1yUJKDjrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bMSFbbbkv412MKEaXDAFD/tDAs6MfRfhgCq6NCXf/cnYhvdFC9DurhvAjrzBZuCy/RQ6JiIkPXlHhtuHLoFWG37MIpc2NAP06AMOStZPyqA4QodyBpCHn18zKFAAPyk0g69ZjyA9Inf15nlzeHC2UZpOZzT7Lgs3MRXO1ml/T+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MfB/95/X; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b77dece52eso563516f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754391245; x=1754996045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUiodtQBvKBTA/iKS7oNMgVKazgBWdic3Ly/8SfR7xc=;
        b=MfB/95/X6j7hyi4c7mQpUHSGHCFQ+iwVMOhVU76zaZu1/ti6Q7Fsddwq90v7WAby9Z
         bpQrNgHRQOapowQzdW2rKJND/CykUwh0CHt7OC6y16oXCsqauOJ6Iv+Q+dCZkBRD9TB/
         ESbOFd/jij75oNWIsHZbATIku4rL7puYnZWQKDwCT9OZSWGKtpVz+4QfrgpGJYkkX2Ns
         9HGPug2CVmlfubL7YgWML764DvueOgAsDvN2zAn282lf4EuuTU4mX/eDTC67Dnmq2r7e
         SlANsfpi7uwMevgl1FI631eJEjgOtuMz6XnJKReJp3mdRah9u2Ik5NF6s5Y/vXwPCfgR
         D06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754391245; x=1754996045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUiodtQBvKBTA/iKS7oNMgVKazgBWdic3Ly/8SfR7xc=;
        b=jyAZ0THePHWZhJAOwoE7OOdfChHCUfmJP+fcUUXC+9uz+ilNlRY/+Cg02n2OZF4tC6
         plSh4N5aaepDwFkfM6T5apFSa9af6Eq+k9Kcc8iVpdrI7aJIl611tOCnCC97uATeEvpr
         LSx41h+nwZ4yKlx0ATwDqjLVqIFD2VaQPESk+Es5zWPq/niJseR3dX3GU1kP6hs5hcbR
         S+sJIeFFafYkY0Lg8jlkw8Odprt87CHsyBcKFN0SKh8xoJoVAvq37aswRx7NM9ODpqxf
         RrQcITqDFFDW/lzdU9Q7yPAOvthGonJXvvd98r490LXXqg0SDm4UdfzU8ey169GiYrl1
         unMw==
X-Forwarded-Encrypted: i=1; AJvYcCUNSWGCOvgV2ypNY2zQXlmQLh21L6VK1B+gVtXYvNRIAhtJbQcjqyUP0fS0UxJuthUqMPkUWvJ6sZH1dTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vHmeUQESnS0w1DJVidQQrGq0gxioSPP+AyAp8A5LroPYx+SQ
	sWNDJl2GIzx3hWQGqTuL0RfrTqgp+jRPWDvAfTW6bOLZ9x4GcHyTWmZNLw5XjcMkSpw=
X-Gm-Gg: ASbGncsnJsaj0xeqoHBvuOasT8Y7lAnx4qIgqP5Skom45rQFUtA5FELX86NhsYUxgUW
	/iMp/WtPy0w9Dsyz0j7jC8cnxOhg8Cs2RNdvgV+6SRgtZLUkxiUu5TO5MGPPx9/40eMQI+L+99i
	aLfXZJP/VIw3eHIZBWcV2CagTlTiv7u12lgy5xmazguj8rJBs3hvfZleMFKQ9XuZOTKXr1IknQT
	S2Swy8W3MKke5D96uQcenEQorYST2a4e644VBaXZe1wK+rYVjoFps4OUoqO1yDzxqb4Hj0JXGLE
	BUkfRmpQrAcxzkYKv6y7rcuKGtumI8fDMIuiu02v0Ez8FI/thuXxcW9EAPVhfB4RitnUK9E0yBf
	++WNa73Z/9Cdl/V3XeI2bYW+6hhNnD34DrtgPBWw=
X-Google-Smtp-Source: AGHT+IEpOsq0FAVja98/mlRReMdSEb+xPNZ7ZEoi0EN4dXoUtDCJVpNHURSd1y/tvYFRXGJZtratYw==
X-Received: by 2002:a05:6000:1a86:b0:3b7:99a8:bf6d with SMTP id ffacd0b85a97d-3b8d94b6fa0mr3885890f8f.11.1754391245272;
        Tue, 05 Aug 2025 03:54:05 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:d884:b809:d57:1ad7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3abf0csm18344450f8f.14.2025.08.05.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:54:04 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: kvm-riscv@lists.infradead.org
Cc: kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: fix stack overrun when loading vlenb
Date: Tue,  5 Aug 2025 12:44:21 +0200
Message-ID: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The userspace load can put up to 2048 bits into an xlen bit stack
buffer.  We want only xlen bits, so check the size beforehand.

Fixes: 2fa290372dfe ("RISC-V: KVM: add 'vlenb' Vector CSR")
Cc: <stable@vger.kernel.org>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_vector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index a5f88cb717f3..05f3cc2d8e31 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -182,6 +182,8 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vcpu,
 		struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
 		unsigned long reg_val;
 
+		if (reg_size != sizeof(reg_val))
+			return -EINVAL;
 		if (copy_from_user(&reg_val, uaddr, reg_size))
 			return -EFAULT;
 		if (reg_val != cntx->vector.vlenb)
-- 
2.50.0


