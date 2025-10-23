Return-Path: <linux-kernel+bounces-867520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FBCC02D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E29C335976D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5BF34D93A;
	Thu, 23 Oct 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="C22663pv"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36AC34D4D4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242377; cv=none; b=HwA0qRx8aaKGDyzPoFZAna2oqSdvNILqsGPn+HdIQQjpQRvrM8s+4DfzC2mEe0pq8cUaetndaEXtIN5LMTyaJVURHNIq85pInjMgqnaFcykU4SY/5JtpaOrm80AMbizruZ0PZ/r5T3NBLzJcm5L8yzMfqj+T/8USavYa/g2Aitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242377; c=relaxed/simple;
	bh=5K6yqKFIUhX7WHvLgQtvAcryO3l2vC0j/sf1x7a2qPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7sXaxiZtxA6OvgWoXEym7aLPJ/vmpO7u8ht6JQ9sY2E2Pp2D5EedAQIWFlbRlpTuJBfQ5X8oEsJJQ6ZVN4wSR46Ixz5iOdcEOyQaTewhLpJAbT6lTy71kTN97M1uG4OatkDhX+kYWQJ7NCwmS5orRZ5z1onksKW2sDSNIXF4vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=C22663pv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso979174a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242375; x=1761847175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4A20c4iE5OCTLQsbFf/dnrtJtYgptzbIxA7b1V4Ehw=;
        b=C22663pvARXhaJw2zPJTpwvG1d+QAihlVOM27zCU/+6w0mos1PbIfxzmGa3pF4HOwa
         n09UbYjfpqBot1x+im0M/V7hMTTUtWdMdMTRGhv7PR4Hl1B3KBJMmLLJXWGzWtGFAar7
         OQszf4kf4nRKzSScYIyktdx8XTMrKCH9c+tOvy3nOkVaO7lTsw+h92xTxEluB41B6BEj
         W+VD+lLh846UN1bSeym6JLOGhor4FrSOX74uG2avKpH8bFo8vhOKstIKulPQDvSVE/d6
         YzDPbkl6ZOA0rDHhw4WSvlELe1L2m8jgjNOXgSXCuj0CBVbx8F0WNhaM3FTlzcrc/gEw
         oVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242375; x=1761847175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4A20c4iE5OCTLQsbFf/dnrtJtYgptzbIxA7b1V4Ehw=;
        b=VIRNrx7WiWkPk/SJgl5rdBQwCIiAA0uIKxGHOLQaO6abt0whev3hn0yjd2QSOO+DHI
         /7zqjPyBhcvHg8LGZc2VBrCByEFQvQkF7GgqqmzyPLcCRoVgyzT8fp7l5p6zBQUXZfQt
         Zb5RW7nQuIsfITx+rva9NXCY5dRZeS7lZ/tEp+KqlKNWYcSOmyzBCVKowL4m2kchzXP/
         fG3tOEgdzlpMf+aKpyvzb0XrAxJSGDqT7w1Z/6mvJnYe7DYd+cBzRAAYXsGrK8Imuh8s
         VPDHUMMkRiGbCoOX/Vcmb8AdBLtG22ennRXN02tEPTO2+CpEl1DQIT3RMVvsNVTraMz8
         YXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTNkGmwsXEE7sCsAPDPgoCkiu4yZGGPYZdZNyV0fYqZbPvn9A9cqUUC0LIKSXJTxAYmYY8dTwJ1HmbQDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZphJoMaH9q2yTX1p0ebvjkI/SbI30ePuOPxmQCZqKu0OZmhXA
	hzE+RdtPef1zTnEAPa3Drrht5OZMvLyHGpffaUQVEa6ygWYXtHhJ2fm4NkVy4EvtRRA=
X-Gm-Gg: ASbGnctmd/BxAzZU5z0FL6g5CNI8ORuWSp79mfDK/uzN5xhnEp8iOnAAzqh7g41LO7x
	ZSlNB/bUK2uIPCd9esIYC6JFucodZLFYtT6CQIoHUHwM0ZN2OO/OeOuY9y5uPzbWNYQ+28aULyT
	SBX8pqupHXDIZom9cig1C95cvcGjbpnngwGeDE9DdSLWmiupkXgpvwze085Go12SIyozw2ywyO/
	Tb8PI70kQwkTnfgqKBXyACxn4Rr87GoaM0sDVSjXrPLk8XDd0QEWPleDMBxrbXAYYgo661PTFtH
	5N+nO80Uv0ADHCBY6W3w9z6fZUtuUbwohbueI7UV5KbhXG9q51loZ8A//U3Jy6DMli5s95Mrue2
	ulgPvaYPeK9TVWdewEbOwL3ao2MwKm6u9jrqFtCLNWuwjZCUbuDpvUQDL3EKXNkmm0h3NvIs4bM
	+rpp6JqKn0OCY4mCiQYwke/1zGw5/sCJYKhA==
X-Google-Smtp-Source: AGHT+IE97/1pEPN/LuV4xxuaKmjoVVAInH5LYa39rU238Esh33gdeg6v8zj+rsYvlz1t0Nfc0Ga6dw==
X-Received: by 2002:a17:90b:28c4:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-33bcf8e4f50mr32926807a91.24.1761242375280;
        Thu, 23 Oct 2025 10:59:35 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:34 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	conor.dooley@microchip.com,
	dlan@gentoo.org
Cc: Frank.li@nxp.com,
	guodong@riscstar.com,
	fustini@kernel.org,
	geert+renesas@glider.be,
	cyy@cyyself.name,
	heylenay@4d2.org,
	apatel@ventanamicro.com,
	joel@jms.id.au,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] riscv: defconfig: enable SPI_FSL_QUADSPI as a module
Date: Thu, 23 Oct 2025 12:59:21 -0500
Message-ID: <20251023175922.528868-10-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC QSPI IP uses the Freescale driver.  Enable it as a
module in the default kernel configuration for RISC-V.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc2725cbca187..48afe30d42e88 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -158,6 +158,7 @@ CONFIG_I2C_DESIGNWARE_CORE=y
 CONFIG_I2C_MV64XXX=m
 CONFIG_SPI=y
 CONFIG_SPI_CADENCE_QUADSPI=m
+CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_SPI_PL022=m
 CONFIG_SPI_SIFIVE=y
 CONFIG_SPI_SUN6I=y
-- 
2.43.0


