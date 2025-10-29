Return-Path: <linux-kernel+bounces-875884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4E7C1A029
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B43477C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AF5337111;
	Wed, 29 Oct 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N5v2ul5D"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8A337117
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737262; cv=none; b=t49Y2fR4037LZj8UAAirqhn8fMqtZKsno6YWYSQxoMVWrSpOK4Ir+HmpTWfDmIy5z5ZWavypEoNOzR0U0IZ/2RjrGv0Pxnyb6FDnL9QOZKS4J4u3APSxY6Y0Dbyi9p18x3PFXOvPZup4remLdNKlXEWK7cBFuRbW+0MqvVmW2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737262; c=relaxed/simple;
	bh=I4TEHisHhy81GfBk4tNwlY19gPH1ru3ik8bcWj4YLHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAOy4A0sAnZysRGD2nrKoVb2gYQk7dOB3uc15Nv73hBRescRWYY6aTSfTnjszMvV+lr6lIfhdAMgQg97VPAeCX0DyuoKNWOmQ8JHB5rkbxSqMDyAPdICRjE1KeTzBrZxoZYIBFaVD6G/3ZXUPmNqcwhwd0ObKT3Xmx7VIfkY8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N5v2ul5D; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so106900425ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737259; x=1762342059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu9PVTm9hjUdHoFQcU8g3rsnUfjy9F8yp+wWZYUCJFc=;
        b=N5v2ul5DYuPP6BS+JMG++hnvL8J8HGcOkejRFmUkaA5x/QCOPH52WwkH/89wzElRaT
         V4NArUDZwut/qZtnXm1M3vRUoj59DljRh7kRX/EChV2DImg27ScHSzeYjamP0vmvmg/D
         U122zUUCcI7TaTKcUwAZg9ZTZuIeenmAU3DR8t5siol1Pa9SeuTpp6jw/mBKZ4RVxmFm
         4OwS/1BF1UrFYkmNwDYUb+YFUpHBIQ3DFEIzVn2NNow5i2mhA9rAa6FlRdo8eYOqtCqi
         0ArmAuYyqiBShSXPj5Cvkb66/AKISaJ86J9FCOi3DJtrCF7vlDvUusECmRLgKM3S/cnD
         c3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737259; x=1762342059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu9PVTm9hjUdHoFQcU8g3rsnUfjy9F8yp+wWZYUCJFc=;
        b=JEJbiSFLVSexBCZSCKMzdw7cl+SUTNH6MvKIsMJBthpFdZkf1vSPy9wS0T5/1mMwWm
         HgTicgSuvN1APRLZOJYIgaQBwZMH26uPUyUQwZodmlJmKGFs7IY6IYFFUEqr/0bsDK0a
         RQEFHbP9JPImPl6kNSjyKgevt7Nu+hjkydWH6J0h64NEkU91PaVBPGEoexxU4ZVxkyFf
         7pRzW61V82+SikJHJw98+ESHQEbTLbLeP9tT2fO3Ly1n2aHPBVHSl4YKj/jdpDy0xrIe
         zVZU4nBSMwMVKzdWxt36JuoxE8ECaoltoHBDZGCALNqvUqp8Qr+FBU265HaudwXidpu0
         3gSA==
X-Forwarded-Encrypted: i=1; AJvYcCWek2OnJ+pQzfMOHHPfmeBsfZXIki2pTTYIIo1Hz1atEYW6817fy4hwh3fArsvDDlnHMOSkFfsV0E+iT+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaAp3gNZZDzX4Lhd5E+Zbix9NFE5laQWrZVZscZ1uwNOOLftal
	1TeLKpL3x7eCCaArzv4XcVAUX6DeuK+dBT9mZMftnKq3HPWKkYHym+MrXy99s8cLTgk=
X-Gm-Gg: ASbGncsnHH9g14nPE8FejeqOIaBsjwmW8N7d2Ati+UHo+IzKQJzhnur6Av/3b0ZMGHv
	lg8c300Rf+qOaI+9TrR3bF9vWHfkt3VQQZMPEjMJu24+YlGYnEmoY3jDOd2yDKqWatHb4Sw/QYc
	GoYzijbv1rizS60XqVurLHrWIDDKFHQgJl+3BFzwrtQ9heXBZGTgZBh+cH7vy/seAfc+xPKQvss
	E+IYO4Wd+Yl9/7ddO3+ck3xYhDT3XznDiFO/hNAwnGgBh9fqYGvqVozvQeh3INcrVhkEkZlDAXy
	YKHbPtUyyqSAmPkpZkC06WkUvraAChlE/JAbcXdrHqVxcwdz9rshrWBCXwliaSZCJQh4NAhu8dM
	/xWQZk5XeWsgUi4FITSsBMvRcOVcFNMPs3GH4sDlICwdNoUPuI7SNzp+nJx79EwBP1TIs5j1Mdd
	3OBAiwDLsQRWpZq7cdP4f/lu2C12Xx+gpkCvsFw0Q=
X-Google-Smtp-Source: AGHT+IEwNLyhot5qPJEYgE8ajY5jbwtZPlrijo+bkOA+9e521cPY2uChToY5FLnyugwQKON/wAVvRw==
X-Received: by 2002:a17:903:32c6:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-294dee20a01mr33897975ad.18.1761737259146;
        Wed, 29 Oct 2025 04:27:39 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:38 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Wed, 29 Oct 2025 16:56:45 +0530
Message-ID: <20251029112649.3811657-8-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 928409199a1a..ebdd92ba1e15 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -110,6 +110,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISCV",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -118,6 +119,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RISCV32",
+	"RISCV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0


