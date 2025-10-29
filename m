Return-Path: <linux-kernel+bounces-875878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C3DC1A011
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0480357D64
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDCA331A42;
	Wed, 29 Oct 2025 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ywr0HF61"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC04330D28
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737231; cv=none; b=d6J/frqyP7tpFbanBBPph7ut8ODM8shxTEmUSPDeVCwV44cVf3Up9pIV9iYfqSW2iyeyaSA07NsMchXtd980IruJ/kNlv9n/aKlwPkiTYTcxGHZaqSVnMLw1EL4S6pq7RtzWnMiUm6udjjMxy5VXMf4ro7q3RkXkeKcCyAMafGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737231; c=relaxed/simple;
	bh=xZ3ZGRZyyesAYiVSJppgbzc/6wpmKcXOnx/IFbeBZY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1qJbuqJmZuFNtQxeGd4onrPax07cZR6a2uvA/sCffQO78/p+hpk3izNdYqqAXtvUaKZGRiVWN0ytL+nneFUzd25SiMHiKuHFKM6H3949tNglceWrBKBI7DSER3rqbMEOoct6m149n9x+mVjBdhbzNucVkCtrsphZwdoZr2mWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ywr0HF61; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33d7589774fso6886508a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737228; x=1762342028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc2pmS4Yu1PyEFNeNlAsHoxFDYNywDlEMWQLdy1zt3o=;
        b=Ywr0HF61w+7bv8baKiHNwYKCyrFyzT/BlYmC4f9Y7kN09vMdlzqrxkHFnlq/2dAb+n
         iJOi0kl0zjUcl48XTxDElg4BRpi8Ww8xhwYDTEo+v2lzc6RYvhRno8jQ1D+dNHzXOZE2
         cJUMnnfdE/zJvgrWDZMkGPvbQ8o7xHfPhmccJ491Frm7j8S8QaCcKfyjm35JnUyHyxhA
         iR0r8rdBrUVpp8XfBwJJW6Q3eTRH5a8xxF6cYgYq4Idq5Ux9qUzGt+IQXthcnqRWOAwt
         8oIMZkp3HBQEunFCLttV6oPhjcS+MfpJHu+Ec7Dh6TTifWbRqi/OURpArX7xhdWwduKk
         gYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737228; x=1762342028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc2pmS4Yu1PyEFNeNlAsHoxFDYNywDlEMWQLdy1zt3o=;
        b=a/p65Fku5nRZoJmQUDywvbyyhTyETW9obsRIqOqIFe0/if6pxU3T4ghpOeWh824+UB
         QhmpnJEOjeUfX0ncYgHO2P/OGbqRVfgaUhn4jkbpvdKMVc7lOU3oUCvgujg5+c6Nqo4Y
         qG5bn92lwl2RfFO+eU6jDf5QJug0oyCRQlJ8gXSBJIUcjypJF9qUQp0mk9P5RLXkck+a
         pTfUkLLss9wBzt6TR/P5xSGjNmJSSQe801+/4NklCsn8nnb9nHMXVTOKfzwNOs9zhBlG
         s9tGdcVCEpXy29xAkgHf3qjB15YqrUFJ+vtQ5fZVFDisph3GmqLmgNxcMnbLqSLZS1bW
         FP6g==
X-Forwarded-Encrypted: i=1; AJvYcCVlwQHtw0QuE58fm8bKj/q7z4G17QbMqy8d+Ddhsh8UUpT0TtnOUexbgzYH+/mEPW/VEItOm0moGWzAlYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBZaRMDW8HVnEQmiQ1i5pldtY8M20Jl0XsosvizHALMfUv+Ut3
	yaPRFiL5oPRdUu3Fa6QUKvVsjutvWMmzFwUKlTCO5DvR4BvgI7ZW9vyqEjrd3uPFhzc=
X-Gm-Gg: ASbGncstolmKPYPLJftGk8TWlV47HjcetIUZza73htNgmRyizgDwldNkasGUDsma0vO
	kFsJY14I6JDgyt/02HeNhS9b7Thon6fnqCyi60eyRQvVXDSbEfQp/Ap6Ltu1sNG/gFGWEZYptg1
	hjrCvWtftDxKoCHYf8pYvghK2h0LfmHqDG4spgGwvM32zA3jUnmVdUD2iLSWY/5hjpAxryE3V7J
	b8vTiBY6ixWIAeNRbop6fjXB374aw9OfEOU937mvHC4wAhbIAMju4mqFrYcOAOaAvROP0jz1OfZ
	jj+GeZGp1aQlatv0FBWNGkhmBSX4XSuXKTcDv+S4nI0vciNStD2BR1gM79Rvil2wOwet0phh2yo
	HKXNgk0VLW/5mAMPbhFNVqcHH4GCFgev2L5ewsgjgbh9dHUanae84c7eJQ58j7TowiEbWH5nrIQ
	c+PAgxF9BylLfcuDSmdnbra4r3lpB3
X-Google-Smtp-Source: AGHT+IGEAqFeWf0ftjlgJx4OkwPZYhleAzhblNhIB2XsxH/EACVURZv5OiId6pITaCbKSnoGThy0lA==
X-Received: by 2002:a17:90b:2811:b0:330:6f13:53fc with SMTP id 98e67ed59e1d1-3403a290f88mr2790213a91.27.1761737228426;
        Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/10] riscv: Define ioremap_cache for RISC-V
Date: Wed, 29 Oct 2025 16:56:39 +0530
Message-ID: <20251029112649.3811657-2-hchauhan@ventanamicro.com>
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

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 09bb5f57a9d3..5550b28f38db 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -142,6 +142,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #ifdef CONFIG_MMU
 #define arch_memremap_wb(addr, size, flags)	\
 	((__force void *)ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL)))
+
+#define ioremap_cache(addr, size)					\
+	((__force void *)ioremap_prot((addr), (size), PAGE_KERNEL))
 #endif
 
 #endif /* _ASM_RISCV_IO_H */
-- 
2.43.0


