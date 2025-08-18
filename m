Return-Path: <linux-kernel+bounces-773862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A84EB2ABB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2331BA5A53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0FB31B139;
	Mon, 18 Aug 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TRCG13yf"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2330EF7A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527808; cv=none; b=kVDWhEutoR5igtJowjI7PqmsAG1ZT2gkG864M6mdBvoVppB6niuCXzYXtbE3BoA9lT/SO7qA0xpjYGu0Nhw2sfDXINdzSGzwTU4ik+EwqbCq9mn+89q7euiSrFj2uINtShkGxPvGaTfaq4Iz0/Y8zM6dzClmLl+1Gxd7WrHqEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527808; c=relaxed/simple;
	bh=Mi7v/5SFKn7WwGpts4xb8BlAippn6V6B+njRlwy9Ex8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLriq5VEBEs+Z3fuD1x1sbfgEfnq73CFmrqWMcGAweRokyjmnAt7dlvoZRgZSSYq0oXauVv+dF7hvZImJ3sutBjvE2YQiXyZbquuNSCKXWAlTqeo520l0IIMo3nMyPvHdLvDchNjmqzaHZSjo8pYxNUIzF5WpX1YmLmxMVhb1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TRCG13yf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-244581cc971so50003415ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755527806; x=1756132606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPRfWRSPn2MXzdkFqXMoQyh3+o3vsKMsh/EYBelfV4w=;
        b=TRCG13yfcxRWuKagNJbN9swhxqua70XJ2WSWKcHzN78W0hDpsll6lZWx0Jwm9TTgsN
         AdEbkoDUORKsVEyDf95eVBxikFJ6bjUDjZDvfnUUukCeZv22+8bBGVkBdNuYIx3d7y/E
         DnDTCXjUPG+1sVJ155zELucUxDaFWN/Kz/N02n7jl8hI4WLjgfhMgs3816qeXoYLo6ii
         mWcRg5Q4hBo9SzIipKvVwnKdCi5mbHfhU4giXgV6bc+7olKYiLgSL4m+4Ael7PZ+NK0X
         OdwNmX5dGmG6Ahm6IXN349GlwnDi3te/4b8pqijh7hWwfZ8QjkzTuyohMS8q21FE92ue
         HJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527806; x=1756132606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPRfWRSPn2MXzdkFqXMoQyh3+o3vsKMsh/EYBelfV4w=;
        b=kOpKR7xUwUOv9PijVuhOOK6YFpUwrKQZ4CCCpZ60GyYwguwZCMEsu5DYG8K3d6lQ2l
         CikS5V1Z2wQI27WnGQ5lduopBVEVRFjXDU3cK4y+5J949NE8Num6NCWTsbOHxYtTcuuO
         FQZHr553WxY+v79/KED3laFZJxb/+jRg1UHBa2yWR5lmi1ZlExQ7RiOPdryDBkLtorrP
         sHe1ski/GL06hSYA0NofukqwlL8W6XUW6lf9UlUFTia5XbdHYRh6DGrQwId2m9xgEvwu
         1qvK6Dfe6K/If2gmaKZxqSCSpbXUDlVaogUAzi8Y+rfvcqV4PWcU0anwuykao+SrEQTK
         zUGg==
X-Forwarded-Encrypted: i=1; AJvYcCV3XzCW5d64Bi5fQkXxUOlwKblY7RnFO8aWdOFQ848nwi97TFdExYayc7NN8Odiw6dA2OMPtoae+qeB15Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDvga1Y5zWu6FvqAtfnb3NerXWNA2y3PrsQsTWGq9MjJJJ5ecI
	dRGYl97B2kYWCU5YVvoq6HZDibzsZ1JQ3RC/virE01ilKNsZVLwKXYfny22KVzoDzRY=
X-Gm-Gg: ASbGncsNx10cf0QVmfO399nyr6F5hGYRbfVtwaAPWJpisrGLJQfEZ5TdiggEWL/aEmc
	slzZIpJz1V+EuEUsCpLMD6cU1IzWawBy5989z/JVeKinkZfuVPiVKzhqoPlB18BXOIS+XaeP/S8
	eNxuLbKmX9akRwzSt9naM+xxzOHTIf4BLvc9sEsBnV1XiT4wIxpd+mkeMuhCa+olDH6pUHz3ckV
	h6GsQdFpbI9+UL0Yh190A+RKk+j6RQwdPNG5FjBtt/f7LActx9W8yEUa6w/RjwonNVWoesCbKDW
	eP5bkDgoUgrwr59nGSU2G9l7qaK2QWIN9Y82O/OKesV8vtyH2FC5cvi/KdBV19ZT9PXeaWL4ug/
	v2vtqhFjEuW4q45fs/1W6wK+Yn2Skx/yV3z58yH1vSeDHmxhwj7cm53s=
X-Google-Smtp-Source: AGHT+IFhQIGFe+ChK7vTdpEKuwo8wR5gEcJq/HqOaD2XkCBquPT7zD28uoL27+VgjZiGEpkXOMVA2A==
X-Received: by 2002:a17:903:186:b0:240:3ed3:13e7 with SMTP id d9443c01a7336-2446d9699aamr152591495ad.42.1755527806186;
        Mon, 18 Aug 2025 07:36:46 -0700 (PDT)
Received: from localhost.localdomain ([122.171.22.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f664sm81704945ad.75.2025.08.18.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:36:45 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 0/2] Common csr_read_num() and csr_write_num() for RISC-V
Date: Mon, 18 Aug 2025 20:05:58 +0530
Message-ID: <20250818143600.894385-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the RISC-V drivers (such as RISC-V PMU and ACPI CPPC) need to
access CSR based on CSR number discovered from somewhere. Add common
RISC-V csr_read_num() and csr_write_num() functions under arch/riscv
for such drivers.

These patches can be found in the riscv_csr_read_num_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Make "out_err" mandatory for csr_read_num() and csr_write_num()
   in PATCH2 as suggested by Sunil and Drew. This also helps further
   simplify csr_read_num() and csr_write_num().

Anup Patel (2):
  ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
  RISC-V: Add common csr_read_num() and csr_write_num() functions

 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  21 ++---
 drivers/perf/riscv_pmu.c     |  54 ++----------
 5 files changed, 186 insertions(+), 58 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

-- 
2.43.0


