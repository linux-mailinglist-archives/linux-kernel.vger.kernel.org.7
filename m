Return-Path: <linux-kernel+bounces-860079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9691ABEF44E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521583B6D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E402C21DB;
	Mon, 20 Oct 2025 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XGPSyqSR"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583E2C0278
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934347; cv=none; b=G6lzMVCx8w/zaCZHNZiwZgRXA9ATuakakUL91tMSWddNz75boBA1XFktwwz447V8nzpBPYwaOmiS4oo/vou0UkBTpFFK0Tu4HiKE+9XejI3nmVyC7cI75QC56OLJjaYA32MjXaNV2WAUN5luDPCW8GA0lAFBx4Cw0gQmYVyrKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934347; c=relaxed/simple;
	bh=B02ziWQmo5WsV+VWudXschLhIhlEAVaMv4vSaAYkoAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/i3URQN5Dz3ttOs6JvMAD3FxKDjGwLwfrCt/DMQCskg52PnpRMjoN/JTrZVeyatNDIKuoCamEsCpd0egj9zQRp6KHSAr1nZGGXX8oDKBzV6VIR7coyxLa+oK46eiQ18wFKfGau57PoK6eFjlfAKu0BXaeNHtXVy7RNNo7hA7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XGPSyqSR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f343231fcso2567409b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934345; x=1761539145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvb+N79+1rz+7OJYvNB/1WfSxRwqST+oSw7w/swSoZg=;
        b=XGPSyqSRnRhq5JmulstB1NXdKZIsaEyEk5/nwN1cBuSSDVPpH1LoGGVlnP8clTE/aE
         my4xciFeoPjbtJRO/3H1D6AXEgKk3pna5kfEOLDSaRVTprBYPj94nkdjxgWTPDkWI5/J
         fiCqGnJXalcvfT7223jn6dqZTs5nGGBHEp7di2alh48AR53v+J9ViKkdy9RNoSRSG+Mf
         Mz+g/E0pOUZpxEa6UJEAuHAGLEfSKHNy2zE1qthztfi+RF2fLhZi0cA9tfVL6k42+ymy
         tHQYcAHS8xUBZqlE63JTOV3ygUPL14ISJbRktfNbt8Ewpp7PGEHZ5XFDCR3jwd1f6lEg
         8BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934345; x=1761539145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvb+N79+1rz+7OJYvNB/1WfSxRwqST+oSw7w/swSoZg=;
        b=MZf/xWRA+Es3aihnG54aTYYotRKNf6n0QJ1bn5zPFkr0h0DHVD5DxgGoLdonWRbpTn
         2NbT0JmE0ehALmOna14V1irMGzDRXqrBi4ihVSuvyLMUy0e6SWl7c49sUtKAY8aQ9oWJ
         FdZYixwnI2rzMaI2+Xd5ZOVnc7+YcLjKEZKx/bs9CIORxTihtmUZg4tEh0p/01t2gaqi
         4BmNjG0bXUKk+lQiexQKBT+QZBG/vb6VmOshewKu5EtP0ZFkWfRP/6c6BM98CUb5KUVl
         /u+UPYYBJbVZNl2pkc0A/RWTrj0ZHfW+H7f9rimHBWAuGT8Y8iLKpaL/Dr+gH3eUHA49
         bzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOoNX4opojuVGgjNMXANogwsewQG9yV8s9wTtwEOnwHOFAuN5eYtgVEgaWbO0AmC1Rhncg6ohw1IJJJPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqjRw3WGDYaJ2qzZiAHh4d0Ui9zDhBxCHG02cCcCSY5dr31iH
	+6F9gnniQkQ2Z/GHlQuRMEZSqVjlfZebTBd6DrqMJt6xlnGx0oniFzDRQ0D+825qnCQ=
X-Gm-Gg: ASbGnct1zzcYTaHx6J1PaA4+naEclqJ0fWxbsm+0RqxdQXckGcU8g9XYEDCXfUbflEO
	1ERR258s1iVIK2jfNCmh6XvnF9gxAQGYy7y1+QvBrrHbqrEsK9Q3LkYnvAOHdwbJzV4oNGEBusy
	T7xadUXbUbO8Qu4Dzk1cU9eXGu5zx6mk2P0Fpp5Lr9EcrJuxMdUQQSek1X6nfVrrIhJddKGIWa/
	O46cWgGzZw3ao0JTH6K3Ch6/cTPBnUPxVoRGUgMefic0XH5/24S2UKEWetHc+oJVYkmBmhqrdsu
	R+4DLJ+ggsAe2BskjujCahD6jodg3Y6QT6u0osBtijC8cnFQBUAce183X0TzHSVHlcjk0wY8lKr
	BDYQ0RnoWVcyNLOqxXvqRF0+Y2lRD4juAplHbfG7kpsbmAjHay3mnZm51UJvGCiQvdoGi6od7NY
	pgH9rt+8WqxgE+ogGikVElMxvrISEobnX3Jugmxh57Y2hhU1m76Y2fqK+YF+QL2ztWea8TNx1IA
	w==
X-Google-Smtp-Source: AGHT+IH0j6CDe697/Hu2JYLa69TXmwS2tLcGClfdWod/OVynSzlnBv0UTOF6Th9AWlAgJGMUHpIxww==
X-Received: by 2002:a17:903:3c24:b0:269:8f2d:5221 with SMTP id d9443c01a7336-290c9c89cd4mr136224525ad.9.1760934344799;
        Sun, 19 Oct 2025 21:25:44 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm68319325ad.7.2025.10.19.21.25.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:25:44 -0700 (PDT)
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
Subject: [PATCH v4 09/10] RISC-V: KVM: Allow Zalasr extensions for Guest/VM
Date: Mon, 20 Oct 2025 12:24:56 +0800
Message-ID: <20251020042457.30915-5-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020042457.30915-1-luxu.kernel@bytedance.com>
References: <20251020042457.30915-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension ONE_REG interface to allow KVM user space
to detect and enable Zalasr extensions for Guest/VM.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index ef27d4289da11..4fbc32ef888fa 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -185,6 +185,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZICCRSE,
 	KVM_RISCV_ISA_EXT_ZAAMO,
 	KVM_RISCV_ISA_EXT_ZALRSC,
+	KVM_RISCV_ISA_EXT_ZALASR,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index cce6a38ea54f2..6ae5f9859f25b 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -50,6 +50,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZAAMO),
 	KVM_ISA_EXT_ARR(ZABHA),
 	KVM_ISA_EXT_ARR(ZACAS),
+	KVM_ISA_EXT_ARR(ZALASR),
 	KVM_ISA_EXT_ARR(ZALRSC),
 	KVM_ISA_EXT_ARR(ZAWRS),
 	KVM_ISA_EXT_ARR(ZBA),
@@ -184,6 +185,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZAAMO:
 	case KVM_RISCV_ISA_EXT_ZABHA:
 	case KVM_RISCV_ISA_EXT_ZACAS:
+	case KVM_RISCV_ISA_EXT_ZALASR:
 	case KVM_RISCV_ISA_EXT_ZALRSC:
 	case KVM_RISCV_ISA_EXT_ZAWRS:
 	case KVM_RISCV_ISA_EXT_ZBA:
-- 
2.20.1


