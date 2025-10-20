Return-Path: <linux-kernel+bounces-860091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C6FBEF4C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFF864ED038
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F52D640F;
	Mon, 20 Oct 2025 04:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NSs58go0"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625AA2D5922
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934559; cv=none; b=hBz+273xj3Vs4bvfyG1Pnhc0Tb8roIiXIONqXeiI+P52P+4WDsPq+OD9vN2HrYSFWwO5zqGf6na7BKOK7UT12WK8VoUZATxHLWuKXxaEshibO7uJrjg7ra9JUJVCnTaI8VDo8C3T0Afj/0YtDZ0nri8W/6jQzalKn6rSiysVOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934559; c=relaxed/simple;
	bh=c191XMGekjwyT0k1fIaZ95ZvPfNZBLAH+N5NWD52kwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3LlrsXZiVUy+9x9yqoGQOLpVYKK+YhfLFfSutkMF/TWX5C6rFseN2TcLBuJlROol5zt7G6Nt9wrvPZU7vEjw1Ux0NNdWuqXVtY+7YBaNBpAIZdajsvrBXNt3oUYLM9jEY0Ol8BtnZoQAsn9i3HOBwXH3ZM1tdqXPoxe72Wxdm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NSs58go0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so2380173a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934557; x=1761539357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/wZtJxRjsPgsFT1TZQP06vJqUDEl57iCFv88CuZkP4=;
        b=NSs58go0HdBRQ83pu6c38OEJRSDMhRpsd+KZ2YVjUlboshhfT/vxGd/2WLOMHiKz0v
         0AogOMMMB4f0CDGLoVD4P9emzk6WlUT9U1UtCMKz8FAEVcPifE4x5uPWzdE4WqaPYa5G
         CleVhyKg/Cna92SjsvQezDjAyGaLRsjr5nxdzmc1nT6nYom6JJZvNRtnBu+nfRtcVGHX
         Y52Rmcaqt0eEE9bfrivHoDfP2C4US5v0vUq3THvEBYWZiOaVBGLVdP+vLIXjtHa2lj1K
         6U75MmoNuW5JzafRxxBVACIFaAlWuUMIZSJkdilwdiUFGWQpD3XPYc9EFjQwUy6M8EAE
         kyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934557; x=1761539357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/wZtJxRjsPgsFT1TZQP06vJqUDEl57iCFv88CuZkP4=;
        b=JDNgOKVY/72D6iNtG/psSBRxRLHWFcdCAMqN1M1xRaHHek5VL3O2UsZbBnft1bsWN3
         AtrGH4/4e44nIklGKK0H3bunxjRBRw1hVfTHfkRy1OKRszKAh4HOTaeFLRBOQPkiISQP
         yx0GS+3zLO9C9m3jHp55qwPp10ZW3ow3S7oJxMIkekg0HAHzcYNT1KIQej1Fb9Cj+7+U
         VBFGKIz3//ZdRkloGJqA86cP8B0Ojyoaq2c2lgswLvrrD19DAbmX4DwNPs1IQuuZVBxB
         jEtfmudtWfbj8Gwb6UEkBuSZQomoCxbiyIoZx4FRzmHwadZ7AtHIywWZHn3WwGBhbhfY
         mHgA==
X-Forwarded-Encrypted: i=1; AJvYcCVwVEeV/3Nl0SPpwfE5zUdue2tjU+4tQhkOJtQbFbihaR7rP9sbKJv/bHLhhpiolO6X3xRG8QFhW1o1FfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PpBK5Qj5HqTyxeS4i0AGi3j+evTIVbZR695yzFTTjd0l4GS8
	gCk9PNPhOaUUTx7AJ9+PCl0umTr8AKCODL2fhA3ZcuNIQAyhz+Ba68YHNySkyiETT78=
X-Gm-Gg: ASbGncsAP7UvsoiyTV99JtAD+bRdctpCLLe8j1aeTdg2KD9RyvETX21GyWMPuEhU+MC
	g+AsRGwe/KOx2GzHQpivjTybpokOa5eFMBMftpwNCDZKXHrXjmTr2Jar2EKkBoZA0dkTb3k1pCj
	qub+qzSUhrZTmwxohiR+UTDm+PA6+zy5HAbnGHp3xS7fqkfDhw4WE0Y9/Hl1XLYh21tyEUPeW7m
	gFhuanIaGZch3PnCKSr7gwBF9kkmKso33LhYLA8FBUatCn3+NZAP76mx9ZQSAz5sREhAuLVEORe
	lhO/KqVRa9J5qsRuCXKSjL6hXTKiIh4jrRvZXFE6SikXX2EJ6QvmThFYw/4zYV+d1ra3FhbD8Fu
	fl5epTpmltT+b9vegDoVxy/wlb6vCunKtoLxz1cEsvIs4Y0pmToHkgbJ4Fa+aTXtmSJWaUaSem7
	DVN2+wKwC1HF5yqhXrWcgWYMINr3NOQ1CCmjuQwA6U6qM+G/q4XkOeGTbsTrNqK+4=
X-Google-Smtp-Source: AGHT+IFpyzb2lc+FEvYmYTlRzjGRaKAbU2/1KopbwUla+EaFbZIWmZ4VSEnrtlloLabkn4dzpBObsg==
X-Received: by 2002:a17:902:e5cf:b0:290:9576:d6ef with SMTP id d9443c01a7336-290cba423b1mr160239305ad.54.1760934556712;
        Sun, 19 Oct 2025 21:29:16 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b35dadsm6932872a12.26.2025.10.19.21.29.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:29:16 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	guoren@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4 10/10] RISC-V: KVM: selftests: Add Zalasr extensions to get-reg-list test
Date: Mon, 20 Oct 2025 12:29:04 +0800
Message-ID: <20251020042904.32096-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Zalasr extensions for Guest/VM so add these
extensions to get-reg-list test.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index a0b7dabb50406..3020e37f621ba 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -65,6 +65,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZAAMO:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZABHA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZACAS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZALASR:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZALRSC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZAWRS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBA:
@@ -517,6 +518,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZAAMO),
 		KVM_ISA_EXT_ARR(ZABHA),
 		KVM_ISA_EXT_ARR(ZACAS),
+		KVM_ISA_EXT_ARR(ZALASR),
 		KVM_ISA_EXT_ARR(ZALRSC),
 		KVM_ISA_EXT_ARR(ZAWRS),
 		KVM_ISA_EXT_ARR(ZBA),
@@ -1112,6 +1114,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(svvptc, SVVPTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zaamo, ZAAMO);
 KVM_ISA_EXT_SIMPLE_CONFIG(zabha, ZABHA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zacas, ZACAS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zalasr, ZALASR);
 KVM_ISA_EXT_SIMPLE_CONFIG(zalrsc, ZALRSC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zawrs, ZAWRS);
 KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
@@ -1187,6 +1190,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zabha,
 	&config_zacas,
 	&config_zalrsc,
+	&config_zalasr,
 	&config_zawrs,
 	&config_zba,
 	&config_zbb,
-- 
2.20.1


