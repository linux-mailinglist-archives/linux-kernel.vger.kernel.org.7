Return-Path: <linux-kernel+bounces-795986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161EB3FA57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C952C154D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E62E8B77;
	Tue,  2 Sep 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8un4InY"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9F2E9EC1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805331; cv=none; b=DPza3zgrTk80k9EfHlf3PXkzkE1i5+/1PuvQbLaG9qJx52nAUvFKR6NctQRtcranzmXkIua6y95I0eGpRTZzENbLvCl9GPDlykI1POQbWa+ziwP9EDHlVG92dCdTLu+kmu/gi1XrXlciGKQZQi8cLFj1Ivbr2DQbMXS/E/V9c1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805331; c=relaxed/simple;
	bh=zIiaEMcLOGEflrFqgwtyUbqqcZexOFcO+SM0N5ku4Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QlPxLlptGzIM+PZN/KF/lGdgSo7oIukYGRc61o0d2FAytKH8nZYmaQHTiHbDPnsTKXyV3nJNjQQVBwqwkUo63PGtJsT5DH1XtBn64VbBmjsWusmn2KylurdpOI+JECbyEMuxdUqMIKlrAMnDT3jC4fsYZ8UBxiG0WeV1KjDAm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v8un4InY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b804ed966so15900035e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756805328; x=1757410128; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edYlP8Z5hwCifcr6FufgXJe0x3O4W0S+n8Or6v62MHE=;
        b=v8un4InYiBMfP9noKyR0+qJ+ju2BrLOvp/j4RBR031WLixGSVmzrb4R7j9HhN6D4Ns
         1bMLEZVp7C9T96ujnJB1FJlDA+eHDsok78JXVIvZ+ENSiUlafHoNj90OV3CaNs3KEi3e
         AgIYd4VA8FQl4zRoApTy36fhgEjsRSXMtxqbTNKHqHOSsSaN80BOx7zg9ipgJ1chg1gt
         JIdyYtaktRJF+sEKxy4nef0wfNE09OVknck+JoQ+U0mqxJUTHpbAYNQHeDIR2uhyGnlb
         7vPgoGWNS3+zXkiZ3eayd8zlCWDn42kQfzbyiTAqihnVzWjrIWOLLkkAa5J2Rvm4FmrY
         na/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805328; x=1757410128;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edYlP8Z5hwCifcr6FufgXJe0x3O4W0S+n8Or6v62MHE=;
        b=oqQpK9kHYs4KHViuAsACg5smTKe6VSljyf8Ii4JjHs63e6Vuf1vneAJGOBfxF+TzxM
         QVLSv8oRJa7RIqs23auj3JclSEMXUy0BN4pIfBplJJpuPaUp4gOCOlmOM70fkQrnBhCE
         tBFY+Xb2XNjV3qgHC2uIA+gNqNI9bgZ1gCOKcOwAC9P8o2TqEHIbGEMw5N5J6+hd+JrO
         o7H7+JbpOPFr0QLzKuj8qN2K5nhXJn/bejNTj6t1IiTD2HgfLJ3Hfrsn4LHdQvASJHqT
         Jie2f/r/FrSd75sRFJi/9u3m1ltyiClqvU+OhVj3SiG58hrsos1ZAVVJ6AX+F5ZCfXNp
         mfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlYllxu2V3KfnGNF6c1dI1W/+oa3QbrP24zGsMZ+bWelZUkhdkcj2xD/z46iqgyao7TgIDExlpwmhL7FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKCBTTR8/i/1isHiNJvlsj/cjRt+a/JxO12qaRvYVdPycGmiOb
	iLSt85LAYsE7E5/KWBSmXDpNQZH2I++ptgp4PPW8K82XXAaPjFECbgAg3HxNy2fao+I=
X-Gm-Gg: ASbGncuWprWHb7QSt7MkETYtkjO/qdIbMTZoOzwm8+Z+WGnLOLUhMEYj6Y5dkcx6PLk
	615RrWLvJBQyi57GKXGdpzDTJFEn4f9b5PCL2eBs4KKRp8Hj/m6aQv8/GhITwTV1VIYPnbfylle
	ZDpdoDmWltcVWHRga/m9axHV6FFDQja95aLvR6wRgkon5m3/4pO7/EBPM/wBrUznzoxaprbgZws
	Zuje8/HGmRnG40u4wORA7sJ+Ji5aPUY8/FJZxIIhuCVefkTXid+ef+yLDnlA4EzA4VC2ddoU338
	6CRMHHVeJyLfZluXYhHwTKMoQ2YpblLItXspmQjZDzSwYKCbP341VhhI1IgHBB7GzD1EXJCIc03
	Rs1hN8NeOy6A8uFpbLJpx7Sol+KgVabiS6Y454qVnRwE=
X-Google-Smtp-Source: AGHT+IEY/YSFrI6UrJniUuogyMXmb035NLrPVWZyM/wPk//oA7hmbyBZ5lCICvvZzOw9e+9BtJ6+4Q==
X-Received: by 2002:a05:600c:1386:b0:45b:81ad:336 with SMTP id 5b1f17b1804b1-45b855340e4mr100469205e9.16.1756805328090;
        Tue, 02 Sep 2025 02:28:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm271502805e9.4.2025.09.02.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:28:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 02 Sep 2025 11:28:45 +0200
Subject: [PATCH] arm64: Add command-line override for
 ID_AA64ISAR0_EL1.ATOMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-topic-arm64-pi-aa64isar0-atomic-v1-1-125f9538a230@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMy4tmgC/x2NSwqFMAwAryJZG6il9XcVcRFsfC8LbUlFBPHuF
 pfDwMwNmVU4w1jdoHxKlrgXaOoKlj/tP0YJhcEa681gLB4xyYKkW+swCRK1TjKpQTriVky/huA
 673tmhlJJyqtc32Gan+cFqwYyf3EAAAA=
X-Change-ID: 20250902-topic-arm64-pi-aa64isar0-atomic-8fdd47558eee
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4097;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zIiaEMcLOGEflrFqgwtyUbqqcZexOFcO+SM0N5ku4Tc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBotrjPlqmBSDdqD8zMfFv0XXzw9wN/I6nNGhVgkTIT
 4qSzP1mJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaLa4zwAKCRB33NvayMhJ0Q6xD/
 9NrU+WTr64/PlGUBAU4zpCqh4GbhRID9UPxztpzTuunIxA36J6wiqy4+BmSohWo1aDkaUoKtvYAIJG
 eL0Uq+L5f/6W4Y5g28ndrd2tka+uFAm1eOdQfFx2+MkdbLKOi2JzExOVkPcgjI9JOpH/q0SL/Jkpuz
 wAMU2j3NlI58hI95QQITls69ZvIsjtUItY965hdk58nfYuJhd+qWTNZXY5Kr/JHmMtM7stI038ztGC
 v/NU/d1eoE5OauYWiNFblLfvxstouQbwoRHuNTDjSwd64ipSltyk2eDP192sg9OXUuepkRUNts1Ugb
 MgY2Mm02Z5cg4tB+KnK41wfEENiwuviRiDVFk0hIym6rexpb3hK7BpaE4es/fGzlRGHF3BaP4F6zms
 k/C0GseF+bam4LlECstlVD/8jTI40B9UrOXm3Adegl/5PvwDLgaBpbYqCKxsTb1ddpT3d/6Hkfb0YN
 SaSaB3Q0/6o65ljjMICXCOfD1O1UsbgGePEJH4nqZU3hjWqcHQ6+Bk5nx0XNI0HGLv/ni/reAzeckW
 7ZIwE/29l3OVoogFMt72ZHymEMLDFVqS3y1BqZe0f3p5GNowkd7grzFX/hE7f0lHYJt84v2ufkYByT
 tCFeeDRTMoy6LHxlTCiUruqz+kfUOmK4uQSCJusUW1Ch6G5bZaiLz/xSzXsg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Implement overriding AA64ISAR0_EL1 to set the ATOMIC feature bits,
allowing booting with LSE Atomic disabled in case the feature
is badly advertised as implemented or incorrectly masked by
the hypervisor.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/include/asm/cpufeature.h   | 1 +
 arch/arm64/kernel/cpufeature.c        | 4 +++-
 arch/arm64/kernel/image-vars.h        | 1 +
 arch/arm64/kernel/pi/idreg-override.c | 9 +++++++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index bf13d676aae2cc9903c83e9a3c4be0ad4bc86204..74fa9efd6938905a6397c78aeddb03a134d4d8c9 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -963,6 +963,7 @@ extern struct arm64_ftr_override id_aa64pfr0_override;
 extern struct arm64_ftr_override id_aa64pfr1_override;
 extern struct arm64_ftr_override id_aa64zfr0_override;
 extern struct arm64_ftr_override id_aa64smfr0_override;
+extern struct arm64_ftr_override id_aa64isar0_override;
 extern struct arm64_ftr_override id_aa64isar1_override;
 extern struct arm64_ftr_override id_aa64isar2_override;
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ef269a5a37e12c53e8e825e947b910f6d3efd296..1084475c479b0101e151ff7dfc12c7b79506cbed 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -778,6 +778,7 @@ struct arm64_ftr_override __read_mostly id_aa64pfr0_override;
 struct arm64_ftr_override __read_mostly id_aa64pfr1_override;
 struct arm64_ftr_override __read_mostly id_aa64zfr0_override;
 struct arm64_ftr_override __read_mostly id_aa64smfr0_override;
+struct arm64_ftr_override __read_mostly id_aa64isar0_override;
 struct arm64_ftr_override __read_mostly id_aa64isar1_override;
 struct arm64_ftr_override __read_mostly id_aa64isar2_override;
 
@@ -832,7 +833,8 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_raz),
 
 	/* Op1 = 0, CRn = 0, CRm = 6 */
-	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
+	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0,
+			       &id_aa64isar0_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1,
 			       &id_aa64isar1_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2,
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 714b0b5ec5ac4a64037834545b0246eb04fb2bce..10deaa63ce7f801fb96d69fc97ae033bcea73fb1 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -46,6 +46,7 @@ PROVIDE(__pi___memcpy			= __pi_memcpy);
 PROVIDE(__pi___memmove			= __pi_memmove);
 PROVIDE(__pi___memset			= __pi_memset);
 
+PI_EXPORT_SYM(id_aa64isar0_override);
 PI_EXPORT_SYM(id_aa64isar1_override);
 PI_EXPORT_SYM(id_aa64isar2_override);
 PI_EXPORT_SYM(id_aa64mmfr0_override);
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index bc57b290e5e7bab51a9de90d23fe36e1640e4b6b..326fa7d69b6df044d840164be3b504af6d8e8482 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -160,6 +160,14 @@ static const struct ftr_set_desc pfr1 __prel64_initconst = {
 	},
 };
 
+static const struct ftr_set_desc isar0 __prel64_initconst = {
+	.name		= "id_aa64isar0",
+	.override	= &id_aa64isar0_override,
+	.fields		= {
+		FIELD("atomic", ID_AA64ISAR0_EL1_ATOMIC_SHIFT, NULL),
+		{}
+	},
+};
 static const struct ftr_set_desc isar1 __prel64_initconst = {
 	.name		= "id_aa64isar1",
 	.override	= &id_aa64isar1_override,
@@ -222,6 +230,7 @@ PREL64(const struct ftr_set_desc, reg) regs[] __prel64_initconst = {
 	{ &mmfr2	},
 	{ &pfr0 	},
 	{ &pfr1 	},
+	{ &isar0	},
 	{ &isar1	},
 	{ &isar2	},
 	{ &smfr0	},

---
base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
change-id: 20250902-topic-arm64-pi-aa64isar0-atomic-8fdd47558eee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


