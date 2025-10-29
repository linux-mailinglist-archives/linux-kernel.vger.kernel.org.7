Return-Path: <linux-kernel+bounces-875880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD37C1A111
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C07C5647F4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F03346BE;
	Wed, 29 Oct 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bIj6YdJy"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC643346BD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737241; cv=none; b=lFPh7+bPsnNHkeaZ+fnwXT5sDe14/2VMkhMJcterBpHUYwhw3StvR/q23H3AqEwi5e86s1HcWp2M3lVqaucw4+L2XX1oUzyASQqBm7e9b1JVIzDIFP2w5XCKE+ZgJglanu+q+sYHY0F6FqTQZttDlDaDeyL4FLRMloVi8klt9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737241; c=relaxed/simple;
	bh=3k4eu6bu2FqRegq68CTBi09f2mevDFi0nw5dHF0KKDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtlXTpTo8gqtkZN3/cufsYnfYUkOcm1d2dD84OBbGSixz7OBQMPGZ8ySjLexo7VAFYgxPpXV+aOuvN7ns1MIFMflirId+PSnpyyVBiiz+8crt+vqHK172h7ED+FjXG6kZ2pF6VPkb/7U1cjsO08H+yGPnDEw3wA8Qke/xk2iXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bIj6YdJy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33badfbbc48so9042628a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737239; x=1762342039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjTmNoD235Z0Q+UTnvL+T6Jk9tiw9Xtbmp+pbEirE4Q=;
        b=bIj6YdJyEvkwKDBetosLgBeCt45p3L0tgSGwDD+ZQi68I92SvNAaB0ufF2WJnsNoA7
         MRPCIfmWhm4DpZMUp6H+HrwA20J3HILEMjSkvem5aZZVkqIGyD7PTouaGUDqqFRKwNCj
         XTpv7R02xxQf7aoIgHvuOYyga1LiO79ki/MAQ9MnXCknBaMeaVWtlR6wP37ESCxbjugm
         Pa8AQsCGS4i+praZfZgXP6Tgv55xznDbjgO4uQ0jXVmLTqYUdhp0QE3Xcx65YASwHhK/
         ICdXQvz/z/iZ93hDbzkbUN3mnBIILO8STRGfpjiPjCjHyDXl6qybhIBuJB54zE7iPR4r
         eAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737239; x=1762342039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjTmNoD235Z0Q+UTnvL+T6Jk9tiw9Xtbmp+pbEirE4Q=;
        b=fkatbQk90swYfxmPkPKNQN4z2DKSDuvkF6PWKzBcLW39nafScGRVqa637s6xTLEKzb
         ShdfGGbzR4aWN6tXkDCGshASLMYgSVBT6X07RnSkftepubNxjYPu2NJh3TNxkRTIven5
         /6S/EbP9G1bQysi+z5Swltm6DBvjFw64ym1ZNhUOURj1cdbF/TC3HSTPvySqRqrvR/ef
         cNtOOQ8yBowfNCPHj0XShribd3UDCBbhY2SdPZIXy7FbYLHmoAKvCbyc+OVya8qaeVgu
         JxicYOXfHlBh/R3uvLaEOS01K7oZdFpRpe/b0gYrYA5TVQIS506Ix6KoRYLKDC5bMVMw
         4aXg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Dm2xXwwVfQUbQRzwBD3n25yjvby75FchBJfZyZ7aa92MzFa3peCE0IBmcJtiRTcbGMIIAK+KJUOyHzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDK942Bki6TJ0ex/fFODOVErzct02gMMfeTbOftlSYuYPU0+ji
	zDSybWmXB2sO5LzNwH4sdmZmilQZXs7jGJ2dzT3jnBWDxhOcIt0g+8HMCnxgZ0fBTgmafDvK+kL
	8vt5Ms0zyoQ==
X-Gm-Gg: ASbGncuCnMVtT6ueVcc8AoUbvxJ3KgfpXkQube69v7RiGKWw9WZNQnbKIZK0fMdoUkr
	aR27gipYyi74ojdg6CNEBy8/80fVE+KKUDjqAGQoRTIjNuCAjQX53kpVINptSZ9J3LlK5K+Oh/k
	i3E8szbH4jPtiUG+HPInEUjxQjxCRuy3qlTr0mOVQs2WjayQ+EFgnaHp+TnR4wbuFZl1zn3Wo3N
	BYGLsGmY8uXAW9mS1sE3m+mtA0cAjiHOibMsJ3p396qBnHN2U8BqbFUHpNqOHVbc/qVI03yYpgd
	e1jNE9Ctw0OQ7x4ZXebt/OWPn2ecKMQ9H47WVa20nsY4f7Y0d47MMuRW5HDVVQGv0cwLehB/yyD
	kMYZOQ12milIywL5EtCGx5/oyQgHz7Bt9cnNO0cN5SQuYLQSnIP0oZxJylKVjXH9sP/3z/M2S2s
	skqDqIWTPoX5SHLZc1UpjRu5tFCFS2
X-Google-Smtp-Source: AGHT+IGV9vVH8+hlZLrwbCF6EeuF04kV3fpI5UDP/oNNvPeA5hF+38GHsytRURBATavrU36r7KMQfg==
X-Received: by 2002:a17:90b:384d:b0:339:d03e:2a11 with SMTP id 98e67ed59e1d1-3403a15844cmr2891587a91.14.1761737238675;
        Wed, 29 Oct 2025 04:27:18 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:18 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/10] acpi: Introduce SSE in HEST notification types
Date: Wed, 29 Oct 2025 16:56:41 +0530
Message-ID: <20251029112649.3811657-4-hchauhan@ventanamicro.com>
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

Introduce a new HEST notification type for RISC-V SSE events.
The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7f35eb0e8458..20b490227398 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1535,7 +1535,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.0


