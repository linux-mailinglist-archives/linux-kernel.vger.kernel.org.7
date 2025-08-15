Return-Path: <linux-kernel+bounces-771157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBDFB283A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3CD5C832D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248C3090FC;
	Fri, 15 Aug 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="It1UEdng"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FD3090CB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274459; cv=none; b=d0KJSo2IanPt+r41Krnd+ZVqD8PtCn0jXTPIKoxGlJC1tVuYhhYHnMt+Xb5QvGk047nl6uLIPN7xqqaCY/jrl9JulSMxu/Ord06KgGidyE0TqAtPUg6Qark5VQqAzNameG3Sz89quVNnjvFBh3/A08JJ8uTlvG8BtDdlyarrGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274459; c=relaxed/simple;
	bh=Kf2iBK1D431xQGY0jRZ1wlkj6AG2/CAeQT2ykycOP6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jt0NgRfO5upl6N09j0t4U+JGscU7Jpk3pOsUTE2PxFHmyqLnkBVORpym4UYrK0czmuN3xn+NXjOXFjV/GxM8JUay+t41/V/wM9O5BVSmKTSrH72M3xBD8F5/YeB5xH6B7xH1fAKFZiOML/QOVzZmMp6DJss1B2pa4CgFOoN6iJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=It1UEdng; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47173a03ffso1338115a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755274457; x=1755879257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vcATQ/iyLXq2WCAG+QWp7/wBNzzyT/wwSXwFvJK/wvw=;
        b=It1UEdngIm6CZdD4F/XCtQiyb+fJlwVULGLVdc84XD9s51SBS+9UQ7a0UKXLXOaX68
         y/MgiJH4OMO1x2/XFiC/M4wb6ccwWzlpPCjnFhWkTiGDcstDrBXiRLPvkzuLFVW83htQ
         fm7AbnJcyTskSrIWbFNvLl45Mx8cIIOywo3NHjSVvTDoiyhfRKVxV2QRXqQa5drH0yiI
         uqWKn6t9YZv80osm+EFA9fi2prQuRrqD67QKZ3ARsICkRSiec6egmkDzWHnlz+qiPkr1
         ZLSSRBpU7ftj5E3eTDbPmNcpv7NejH3ksxhrkuk69XYX7vqtTPgOEIx0V8af5j3ci4jN
         Ub8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274457; x=1755879257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcATQ/iyLXq2WCAG+QWp7/wBNzzyT/wwSXwFvJK/wvw=;
        b=N1Tc1dej8eAyATaN/fUTOgTUNMJMAaIJgWiBCLRRj7C52UkaaLHwIA/eGIdk4DQTBW
         oN8l6QUM/5JNtFSn2SIybOadx67Qd6EwqxX+oEmCead1aeXmyN6atcVbjnIHo4QR4yd8
         87qCY/JE3Mfp6f+mtO1WZojzhu3DQhIxM87FHpKkVneeKyGoG3H1eeVAbNJRicDLmboy
         4QrWqhoetfNE/SLkYXLpTThJPXl5X7Fmd13HtHip0Qcwp8IrQ+mhyiGHZiBTMM+/e3n+
         L+XzEfIELugnJvy7wk+9irB7a8CnSqYhZw5BvHH/OqCJLPju8SgISYcYgJzN/fmbvXL+
         ADvw==
X-Forwarded-Encrypted: i=1; AJvYcCWR8UXHicgMzEYMt/3r/ZjQ3TrUCEdezrjHXFe//PQtcCM55kj9W27pg3589t6FaHFxNj1TBTRzBbHNeeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uxIlZ/Wt6HPhFxH68gD7w+c/sQsBaRyozPD0PsYOwOapCovV
	RexkYWc4pNTl6ul1kf8Tc8UKrg+pTmFp5iXBknGI36wuUC0dRVScXHHwK6FqmmIL7KM=
X-Gm-Gg: ASbGnctEu2pdRtwtdvTiNF2FscCtpu3lyx38q/GbTfPfMXz4j/tm3D01DtoFZknxP6n
	PEyYfllJ6WC5Q+ALC3fX3KtKhZccNanB8TshUYnopJ5FfVyyTN9FOZEVNmdsVmPPpl5yQfgWzdn
	b3JPDJmjrvkWEERbs8WUSN6sIxQZ6Rq+QzCu+5vJoUWWDjDRGe2XduW3k6/n9Hi4uTcOPSKxbL1
	580U7MoheezhKdU5EoSHH2caoX0GCtbs2mg/ywkxbrX60coRIPUFecSKgkm0qhPKSwyz1hv5UHl
	fudePXkN5ab3v+6mWFwLeUPHTOfvbjBk/bHNZtv0elpeHqUtc3Qo4CkKjT3oFUT6Ihr4sehO8Ya
	ki9YAaZyfXaiAn24hA4DxG4PYLc3+XhyxBo6F0GXGeXX4Ev3xQr9moLY=
X-Google-Smtp-Source: AGHT+IHperFQi/7YSivsAfePkj2it+rOxXUM7GZDi3LaWPilgY2XPCaqL9OvKCM03IrF3xh8S5y5iw==
X-Received: by 2002:a17:90b:2d4e:b0:31e:d9f0:9b92 with SMTP id 98e67ed59e1d1-32341ec09f9mr4429507a91.14.1755274457311;
        Fri, 15 Aug 2025 09:14:17 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331123409sm4645605a91.20.2025.08.15.09.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:14:16 -0700 (PDT)
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
Subject: [PATCH 0/2] Common csr_read_num() and csr_write_num() for RISC-V
Date: Fri, 15 Aug 2025 21:44:04 +0530
Message-ID: <20250815161406.76370-1-apatel@ventanamicro.com>
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

These patches can be found in the riscv_csr_read_num_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (2):
  ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
  RISC-V: Add common csr_read_num() and csr_write_num() functions

 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 177 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  21 ++---
 drivers/perf/riscv_pmu.c     |  43 +--------
 5 files changed, 191 insertions(+), 54 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

-- 
2.43.0


