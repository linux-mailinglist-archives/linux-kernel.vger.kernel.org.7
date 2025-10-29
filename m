Return-Path: <linux-kernel+bounces-875886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DDDC1A087
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 544D44FFBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F24B3385A9;
	Wed, 29 Oct 2025 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pe54++yt"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EDA32E13A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737276; cv=none; b=WzhXGw4NfuYBdQRGGRPVL1gd/C1GMhSEYUJ7h9py2zSZtn/T+Cbd5u2Ble81UpWXvCGRZQ0H5+Pzl7QR4IjBchBuDFB6btmmx6zqGuq7Ik5eVX1J9uByH2hJfXQYD3GCZPP2pm2CSRdMrCfjdysgXGTo7Sv8yfhvlirFFGUqDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737276; c=relaxed/simple;
	bh=TilcVfmqeN4S9SQk/86dbqTu5JigqINDawfpL8vf2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr4LKZQ+yxOX4Q0gKIXz0d3KgtRR6YbjhNsaFYvuuIE8TLzoGB64525FqGjDimlnsCkJjhiWWdxiQ8DtWTkrn+daOUynFB7E2hClQ6H9kh2ndsy87SMBcAzIAFtrlGeVWH6BDanoGoChc6XMSpdOL3taKl50dJpdvf01XShG/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pe54++yt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33be037cf73so7461678a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737270; x=1762342070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd49FUCFXP7v439aOYgrBhlMaMpFr/VqGWFeAvQumyw=;
        b=pe54++ytCggU8LUi7x8xTGTKHGjO3vSbxsgPKrzECz5/xwulrRYqwC6Mm4exFUbA2C
         1Y9D3DQ5+XMTdzLSseE5XbFvdarBmLYhdycKL57E7u6ftnJISGXvT+U06JCaXWeGFAKv
         FxT+FXDjmoIkdoQCEbhpbFLP5tf3+fDfnjNjOxMNyY8kPGcAKsnGCNqar3BOPmEZ60CU
         cCYOez+eeRb5zoHlmRIxuhwvLpb8b0s9hJAn1frBZ3+ias5YV4lk2P5ia3sA48glunZ7
         kx3blCT5+wamtPadOIjlscqVSCE2kjwK9ai24wB9ecdycIxNBFDv3H9QqwCrKWpp3qQ+
         EOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737270; x=1762342070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wd49FUCFXP7v439aOYgrBhlMaMpFr/VqGWFeAvQumyw=;
        b=kNM00cZaUhmDKJxaBhLTREoEwwW7NCa9bnUSnvct73dzwWl4Fs1Ye/lPiz2aZo7CSu
         yokMeyJITEY6tJWCb3qPzTJpzfArb8NxGOTFU4pr9akxu4Z6oLNOlkRI9qGGYS7x7Ys/
         aqL3zw5CCLq2DbGChw+/yjoMCeEIrwQeD9owuaBxALnRoHkaaZcGgL7MZxZAj2q1wzkW
         VzTvl9dmsBWRbZhcdY9r1l9fhHZGRZ5gkfoII2x7dK/ZpgfZxNJ96+ZMzr4sc9/k4M68
         nzAvzaSpQ5EvdosiXL4OY6yva6IxRGxckH6Mq17na1+/S6q7ecDQvdaU43R4vuWbqEUG
         M0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVQ6H3m2wdg83vSi7fn8TpYZ4bqZ5KeIvStY7+/hIQOPQMuM91LIvJH3EBss/NlVMggzn/JkOvBXyrORA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2IeQ3pJKcHjSKabPQBUfrEtnu168rSl9ebhH/qsKrX17a03Di
	Z4HWIdkgdeF10V2w90BWtBnObavpgjRMIKUJVdg2XAzMcRrrTxohzL0TZ+UiSheJhKs=
X-Gm-Gg: ASbGncv5lxh5v6rvYTMMdMGfzg8bz9pSCzi/KkV7UFX6xYbpz9jJkc3NCCii9XX9RGB
	dI8u+DMFvajCs7D4DQ7UraGZjnNdNVkvxWxLkFPQqXaJVv4oSNywomV0zCeDCe7eSNHJ7y085DT
	TUQd+0tfJ5xKJNVZFkbF1Zm/ZwpJdbQp7G+YpdUrrJ+4+ib4FhBwLFBcxEz4bSsOVDgPW5udWUM
	l2t6llrkCq1eNQiGBxbJRX+evQGtGodWXL8EVwVqRLgonF0YD7GFfH3MiwTWdQ/53vaTP2nepXs
	0XvzpRIC6WCOXP5jiFKE9ee6N9O8bAlCvWI3N3RZBJ54V26EK2YubzXg/owKZ8YwuiSHD4WErFh
	TpsnZBT+hOYOQnclC/JBMonCz26tBgnxA/qirfUvndM4HcQhjO4R7NbJ62PAG6vQyt2GGqPpYoW
	GGLMQzvZ2hFbzqwTKBK5bA4TeyqPy/
X-Google-Smtp-Source: AGHT+IEwpD5L2Hn2Oj9/1NiPPKl78u4FeofUgufEwNswN516sCORZuI1gux4yna6NQqFE96u6vitOQ==
X-Received: by 2002:a17:90b:1f8a:b0:33f:eca0:47c6 with SMTP id 98e67ed59e1d1-3403a2f179cmr2624640a91.30.1761737269909;
        Wed, 29 Oct 2025 04:27:49 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:49 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Wed, 29 Oct 2025 16:56:47 +0530
Message-ID: <20251029112649.3811657-10-hchauhan@ventanamicro.com>
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

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22cda9c452d2..97aa3726e9f6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -185,6 +185,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0


