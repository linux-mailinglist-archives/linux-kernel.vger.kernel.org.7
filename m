Return-Path: <linux-kernel+bounces-875887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE3BC1A093
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FAA1C63233
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9950338F55;
	Wed, 29 Oct 2025 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ioLAtW16"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D101337B87
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737278; cv=none; b=lU6wHkYhBbBKqPdGsY0bNeg290zL2/fiqpGlaetF30VlwfqTVAxHMpcj3/G5IgSlZUsJxgI0NlesiVda+znFDDvhSJIZMrzo1YJCw/BvhTzhUF0r2ul9PX56fc+qjUYPjiJURM/SVNrrV2ywwyjxrORayuFaoqhd31sS2btHNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737278; c=relaxed/simple;
	bh=8JZYDhNrsI9HtE6ZOHDXkqloHy3uMWl7WxBeulXNIIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+6t0wzuQRipFNtsZLI9GTnqXZlJLvxaHureWzR6jCZoPOSYN67D9nePoT/vMF7UwNPHNYVm2RGeSaLE2XrZzh9aD63/lXOQ/pXaQrgGwVOfeI2cRDYpd0FBNbmcGMHv51A2Ko0PUDpQWBMtgT0tnhJ06MwE1qwZDqraHGTw4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ioLAtW16; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-330b4739538so7178884a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737275; x=1762342075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM17XL2D8YjMnEI2n2oDZbxwn/ekL7mieaWD4DF48lk=;
        b=ioLAtW16zgFVLPptdqS3SRTZWy3FimMgRWvjmu1YiKNBFWjDO2R2XD110IJcGDYZ/c
         E6eGAZ3Yt4TfhTv9060zve9QSoV+HXfWAgLKsaFjCRs0vwxaZM6DCQbl6kpI2rfs6cQL
         HfOvA62E3E3OZT8NgYwiDIhcdcORMJbR8Aqga+eZYZar6Gl2tevDlX2nDP0TVrcfmDJQ
         88C58qmQYP2mozK1ArDCIDsjWxHMsePN9OrpLACQ+Auuegyx9XVtKhJ6SpXWWyNXdpN4
         ZodfvmRnerZLQHA/32Eogf4K5OgCrP8GznkQ6/dsxLepzljmHBXZhWp7eRTQ9kxH/PNW
         CicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737275; x=1762342075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM17XL2D8YjMnEI2n2oDZbxwn/ekL7mieaWD4DF48lk=;
        b=T+onZv7bYymRNjEUwejMHKB6+XcV0NZOJ1ZG4Q7WZp4SN7wmQJfVIqdMuPWNR79K3k
         Hx/VPQ8ekhZP0TPQ1XhPZxJ8OCd2O0rEWWr1OnDfEJb1OVNd2Ori6hpeh28/4yQe7miP
         Cdqfe+3GlJ+bhxzY93HBXAbl7mVpzC4RxTgqEpq5eSMSQPRx8tLTOVtvktNOGh79sG7f
         lVdGn2FWITU5GpDifvKOiU/A4SNLr3cRc0qCJD7NVWNR+4EvzxcxOUonu0dMTUxsMNof
         pB2DBm3Qxs10bJmnvKQOIloFtXJqZX969Z0mxTyBlv67tmq64upZMkeQVilMUAuYbsrM
         X3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOs24o5Z9u10BfLqY18B80ZqFPRDHshh8+5i2ekW8RLBFSvmBb9x7IzFn4xWRbR5uuGKPkch37GkjQTqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjg/6qENvP4dxRKpulzfW4sZxfmoy4YKyIR9S566GYoAJfn1Nx
	8qpz0if98ZXXT39rRcTrWztggou38yWgNJy3siaEGUA0pdM0xfDIIcrpwjthoLLvwac=
X-Gm-Gg: ASbGncttplAfqZg+eUWSQ63fVnQsnLFkzkMpGyGS5ks3xXt7pCcd4vFgmnzZqmbQDct
	0VHle15MNdrRoZEIIp7wpCyxQzjUiWK76ys4jH/yJ3cecdDS87Bixz+7nTVTpBbZpRLxn3inPZw
	ThNp0yKsMWEDVbcI0O1VS9xDIsYhnpNaCUTZPT/P9iwC3PFR/EqZqKOu2+9R4ShgAGk5ecqtyZr
	1DUMgJ8/n0oRgfyPas35t2bLsrC9P9s1isDIyVCCIfmwL7/sD0y4dQRKRTlsd9mWEqElK7cObLE
	JMHhyNcTe3RHRGpxtRHTks9pxAhET7AlLCvKMesI8B2CyHBBK1jL5bqtDkm1NoYUvhAVcw2vAcM
	J2pW9P/Z40cBoh35w0YGOAY/NSbvqPigE8Pqk+3zqHXUj67g99C6r3F5gfISOmwQKStNHg29ipI
	gZjd96gOZMNX60+ffQz5vVrErAuCZo
X-Google-Smtp-Source: AGHT+IF600ISkv3fQ7BjFWjXUYnsdlJjH4uC/2j9DNguZaBAOpmO8VBsTXPp9fAX6HQJwfo0kcCWuA==
X-Received: by 2002:a17:90b:4c10:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-3403a281deemr3120310a91.19.1761737274703;
        Wed, 29 Oct 2025 04:27:54 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:54 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/10] riscv: Enable APEI GHES driver in defconfig
Date: Wed, 29 Oct 2025 16:56:48 +0530
Message-ID: <20251029112649.3811657-11-hchauhan@ventanamicro.com>
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

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc2725cbca18..3e62484e148f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -44,6 +44,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0


