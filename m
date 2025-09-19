Return-Path: <linux-kernel+bounces-824151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C4B883B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C0116C459
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660252F6562;
	Fri, 19 Sep 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PjIU41OU"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2872D238B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267534; cv=none; b=N8i/qJCryynYe92gJLmzDG6UKmpCxHLvh1rkDx+NaKzrnJZYWrDjsMcXYU8Q3NdrYb/tDY02FIdkCmt9AGCdO3K0cCScWqIwiR+KmPCrGa2WlINsGp2KpZTAh9BkrL+/EtDUm11DNaFkZHvuqq+vUUQSRM9P3rGJelcz6Jdx9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267534; c=relaxed/simple;
	bh=c191XMGekjwyT0k1fIaZ95ZvPfNZBLAH+N5NWD52kwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4qr4I/5xrnHeCJOoge3FThyM69Iru3yHz6l7f6lxskKtO2rvPenvDTQbt/9huLdAkOzAL5EzYA+uiI5RsrVmIxp9QUhF408Xu4mdnmmIVsSjdhbVcLL+by5E0/H8/GR6LRTZbjAuFdaGKc0Y3t7dfpdrurbKURJ5KF1O5XkbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PjIU41OU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so1649553b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758267532; x=1758872332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/wZtJxRjsPgsFT1TZQP06vJqUDEl57iCFv88CuZkP4=;
        b=PjIU41OUYpa5GM79iBUbErnojyglssB59mxt+pnqxe5xNSugTp3XzUbZtTRDhYY+mj
         AFI4vSoldVpgCaoKhmnNBmrfsSWD9hi6PyJoWW3iPsCWpqA8u+0yN7coz4mTvEw9XJoF
         S9Cz5vQoYeanUxpS89cLVdS4OLWRDtmQrrFBHhZlWY6Z6anmELda6AMSniGIBt38AhA/
         WSDWti9dtcR5Lx1U+UWp2MsPJ4rWRC1A/7Me5ySF1XNqOdHPUYri6ZAsMwxjHJQENOV1
         BzYDpD95J4TUq9jA1Jg8DbEYdeENlJSgIGNO4xtE0TqTE+zAoBk0vu73X/uMlOGdbO/v
         UlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267532; x=1758872332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/wZtJxRjsPgsFT1TZQP06vJqUDEl57iCFv88CuZkP4=;
        b=cnq4Yn2O9I/Giuwuf4NGDG4PcA4iqhPqKpeQgu1O88tJPTuAv8O7SF1fI7fpfxDTN5
         kxEkQWhXJqAVPLMZNzfVWhURcIx7mjd+kD0usiCuvRZvBHvJTfdvmI8gdo30rVtofBqV
         USx4h1TXCWfeCcI3kPaR5/vc/Mo0K+/s9Lx1t01b2CgsHXPRj0SzXn2IkhS3jJMh8NBu
         INNPShZO+gSXLMja6KlKO7YzNvSwSpzYIy6T9yvgq6AlrzspYZ71BGMiDZS2ErA3E192
         K/qyeRPIruPT63XEiN9VP4EwsnX/3c4Ak2N/x3PBbkpP5g21+ugpWB5TaCUABRZ++u4O
         y3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVQVfcQMC99eaBUrWO8BAZyzdzlVowXq4ZjxPGAw6ZaIfGxmb80yttXhgc6nX37mRISof6ZzR2s1gUhcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/tsCyXlJNDE6W6YArE6+RgELTG2BvChlo9QWFt7VxwseFQM3
	hHmd3wVY7iNemvcEsri03oaZc0ISEfc4cwFYtmQcE73bhfOJ8fY+Kp4JNg7J0vvk00I=
X-Gm-Gg: ASbGncv4KxBrlwbHEp89+p7rrcAQnmKwqdJdkEMfnLYDSMDmh1Qe52+kEF4AdLKfrWU
	/A29VEPhLkKLpToWFm/XD+B2WnZcsZeYi3loODo+XCSgcCnnN+qb8sv1shUeetX7HQ+NfZ8gCEr
	MLqNOEwqyL+NtgA24DYtFqEbJ8BtJdNAmnD+hnHuCGssmye+huM9RI4ozLmzc/ibuULcTZ6fIRI
	ymCtu3rRiT1edV+y3fXGs3SO4o7t7T4UPLVmh380vLW65cfhUpChPynPGc/DyNeuZ2GuvStAS1/
	rT23qsw6/Mf/kuy0SjjHpMBi7KcFcmMJDxT928ZLbEq8Gd6vz40k6rE8syaqtD6jYDdDORj9qH2
	TSjjT2zYG9yjnKuSyioWxDBMXcxFCQ29wa4isEwWhxwh0LHQjmu4xqkbnv8i4qFZCc8nLQ6mcdo
	UV/vQ2OSWLjW88UHa1auJG+E6ud4cjgRG3FTV9UgUUUA==
X-Google-Smtp-Source: AGHT+IH+4QZdIMI6dt1vIbAhIv1otTpdn3Cuf58RfGKyqc29IOHSadIrxg84hnYxuSAKEAjnTACHLA==
X-Received: by 2002:a05:6a20:244e:b0:24d:d206:6992 with SMTP id adf61e73a8af0-29260d81077mr3369360637.22.1758267532201;
        Fri, 19 Sep 2025 00:38:52 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b550fd7ebc7sm2679096a12.19.2025.09.19.00.38.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:38:52 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 8/8] KVM: riscv: selftests: Add Zalasr extensions to get-reg-list test
Date: Fri, 19 Sep 2025 15:37:14 +0800
Message-ID: <20250919073714.83063-9-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919073714.83063-1-luxu.kernel@bytedance.com>
References: <20250919073714.83063-1-luxu.kernel@bytedance.com>
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


