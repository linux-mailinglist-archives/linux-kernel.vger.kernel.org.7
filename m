Return-Path: <linux-kernel+bounces-686950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D50AD9DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 16:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C1D3B8BCE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA332E2EE9;
	Sat, 14 Jun 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="ALwt8DzE"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B92E336C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749912967; cv=none; b=VuVo5mfjCaaHEFCF3CN3aAHtoiSU77TQk4SUQ/fyT7e+z3ZRMMfZ5Lyrwp97AiA/RVPZs/gGyzgeaWoeYAKVKIGMdeZVj4sJKkRf6r3UR7GKGisRSMS3m3QYmtqS6zwo06BdEQV8JoVrwcebc9iJDXNOKoXM8lSYCQwX/0sSR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749912967; c=relaxed/simple;
	bh=V2dnmXkpmQkFeGJ0/9lY8APfUTddRrtiX6o9oiKsl98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9Ce0wTLM9TO4ZBdhZysYGC3MO/7TztEgyayNgYoPzUw432k7Vi01pS9m+CvKQJwDLCwCz2OewL2o0TR7mOog2iRcvB2lyfGk4jvFkasz0565J2zDiQprwtQw3DQYwRHWL0Aow9q0Kd2qTAijpv4Vkf5QhlxIfFG74sq8wIeMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=ALwt8DzE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748a42f718aso260196b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1749912963; x=1750517763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdwgAOcCxW8xP65CJHYSviC4hBZAI2hMwMKg/94ld5s=;
        b=ALwt8DzEZRYrpIjqupKdSvRIV1lr8zb1lu0pHwop5YDaUZ39/DyyiVib/e1tJxFXUV
         lnMvljOhl55SIikGtgK4yHpFfBrNfLmlRGxjIoyayNpjsTyw2ioAj8dPzF+IWqNP1lme
         L/Cifi0MeWstecSm5bYg4V5JOIMEXekjBHrvP+Cm4tBcB/ufa9yeQpD0iGl184ddfq4Z
         V5JF6IEPKAgJoXbdfVhjQCLmsGsN7AKiCA2F6I6TpGHTgftczc2JVsk1Yny/OAnz49v1
         72N61MGSe+fSAdw2OW6BMlvHoqyeam1a6VdkdiarediF2jD9yPBYCsQVFFfpG7TG6FTA
         n5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749912963; x=1750517763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdwgAOcCxW8xP65CJHYSviC4hBZAI2hMwMKg/94ld5s=;
        b=qYdl8ccEpxMCS4X93qhGaQcHTy88k8v/ihcrkp4V6hfsIoJeDlcb03Wfy6ciEGEdsX
         X/ILZTpKqZ92Mzy8TaKWGvJxtf/4NYVgQ6vbCE19FVL86Se9BRppJGwPJB9hamzw5ttL
         ftzbu4uFQMZJoVkRZQ+vmkAOAwOCrrZqULH1yOREduxMN7exOLfV6c9Viv/U5jtqJRLo
         aUKiaqKH7EONg27pgjh5YNkORI2AuWZoWCdotkQloYxcqpcOGFG4yqUarLyvUwqcOVIL
         +g7bWQlZrrZaysRllzU5YvXTFiENb5CdTp2xKpMEV+4ixwt2bD78eoamHdV5mCmuyrZF
         4oiw==
X-Forwarded-Encrypted: i=1; AJvYcCXzqOKakXGQ3vMKy5I9Nu6s/UOkzV2shp04BJw/Ovqfjwnkxh3QGv9uMY5PjEqRWmmjAbhwLQdAeAJ8Tng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYdYmEJYpjlo6Ujjv5lFYCJrbRMTrZyS1SENiAFnEnJAcjFJq
	WDFChtlgqUEvTdAFTKijSsAiq3L3PcxAjFQ54YbYdpOy6OSjv3ihQX51xwf8gwGsEiShka3c33+
	/jO2OY0jowvEIVdc/CpUTfvl9KpQn41qsvZVZD4kIOxXMN/hPRAxKFoEqDRA=
X-Gm-Gg: ASbGncsXHrn3Uo7GiiDZhH4g3MqU16bQZRmPF+Ich2WA+IJ1orG0ETQP4RQggiB+l8r
	3nFqUPsC5osln3s0hrv7D5yt8shB6SV03zSyp8w1xFjyzNnIsgtSZbCcSixLx7BB53q/0PzCoVs
	h/tGPaH/x7YLQSwupPiPNYkUorLbe2GyX0pPw1IhGj/YNewaPk/LgfPPhLZskbXNBOjhmo8O3Da
	RD7XTIRS25cxYJjBwMW7UGNcrwzjvMZwH92tC3XIo5FUm/6WV0CGAOYySsuwFN69DyKScPXmUHZ
	UUsHSuHOW8eDsXWix88jFap0IOgldg3jG7Q1jFfMgSoe0jr2UQCK0cexBPCURI1nji+IXgK40Nh
	WdVvMXqNWJ9ERsfRWbM3AY3nqpPe0FlZc4a3Il/ntszs=
X-Google-Smtp-Source: AGHT+IEEnn/ufz6mqS8sNhhi17+pqZj6OB0ZO/xLcIsqqzhVrA8tKi9dLivhuV4/wirpHZNz/ivObw==
X-Received: by 2002:a05:6a00:3e10:b0:72d:9cbc:730d with SMTP id d2e1a72fcca58-7489cffbf39mr4211820b3a.11.1749912963480;
        Sat, 14 Jun 2025 07:56:03 -0700 (PDT)
Received: from localhost.localdomain (36-228-20-239.dynamic-ip.hinet.net. [36.228.20.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890006059sm3565303b3a.55.2025.06.14.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 07:56:02 -0700 (PDT)
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei-Lin Chang <r09922117@csie.ntu.edu.tw>,
	Will Deacon <will@kernel.org>,
	Jintack Lim <jintack@cs.columbia.edu>,
	Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH] KVM: arm64: nv: Fix s_cpu_if->vgic_lr[] indexing in vgic_v3_put_nested()
Date: Sat, 14 Jun 2025 22:57:21 +0800
Message-ID: <20250614145721.2504524-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0

s_cpu_if->vgic_lr[] is filled continuously from index 0 to
s_cpu_if->used_lrs - 1, but vgic_v3_put_nested() is indexing it using
the positions of the set bits in shadow_if->lr_map. So correct it.

Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
---
 arch/arm64/kvm/vgic/vgic-v3-nested.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v3-nested.c b/arch/arm64/kvm/vgic/vgic-v3-nested.c
index 4f6954c30674..29741e3f077b 100644
--- a/arch/arm64/kvm/vgic/vgic-v3-nested.c
+++ b/arch/arm64/kvm/vgic/vgic-v3-nested.c
@@ -343,7 +343,7 @@ void vgic_v3_put_nested(struct kvm_vcpu *vcpu)
 	struct shadow_if *shadow_if = get_shadow_if();
 	struct vgic_v3_cpu_if *s_cpu_if = &shadow_if->cpuif;
 	u64 val;
-	int i;
+	int i, index = 0;
 
 	__vgic_v3_save_vmcr_aprs(s_cpu_if);
 	__vgic_v3_deactivate_traps(s_cpu_if);
@@ -368,10 +368,11 @@ void vgic_v3_put_nested(struct kvm_vcpu *vcpu)
 		val = __vcpu_sys_reg(vcpu, ICH_LRN(i));
 
 		val &= ~ICH_LR_STATE;
-		val |= s_cpu_if->vgic_lr[i] & ICH_LR_STATE;
+		val |= s_cpu_if->vgic_lr[index] & ICH_LR_STATE;
 
 		__vcpu_sys_reg(vcpu, ICH_LRN(i)) = val;
-		s_cpu_if->vgic_lr[i] = 0;
+		s_cpu_if->vgic_lr[index] = 0;
+		index++;
 	}
 
 	shadow_if->lr_map = 0;
-- 
2.49.0


