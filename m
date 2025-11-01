Return-Path: <linux-kernel+bounces-881382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C70C281B5
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF733B07FC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028372FBDF5;
	Sat,  1 Nov 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JbgOwaAM"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E02F7AB4
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011885; cv=none; b=Q+2p6j3btVsWLWVwpjF74EPyBdp7qQ0Bs/xKEYCuXdNE+FYrjCiSQoXGNkpKnN7Uc/CPy+wusFSFRaUUrI+FWrjC+j/PRXzuYlxXCuHgD0fqrSuvbMjgOBPqUXFHfWevz5fK3sWb2YroNRbmvSfkT+bpS5st5l4xAGAPE/W6Y5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011885; c=relaxed/simple;
	bh=HAo7tAo9pz07C0eWiSeGo7gw9TyyhoVzDLUpVnhm81I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzRF0sOnXm8+P5LLJqoqMBMhNufkwxu/epBsoCQOCAL6LKS+d8AibVLHR95NSbxs+XZSYnmNND953geime9uX+XyrBtqfQsYqLF+257PJEyS+VdHn5N7JAXjYfPfgO1lWjgu2g1FEQgCzb0zQyO6ThR15AJ1wqayd4ZXq2nIcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JbgOwaAM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b67684e2904so2220250a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1762011883; x=1762616683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DZT80TGVVkLsDEh8uIzxjLsAC/KruYN21Qem0m8wUw=;
        b=JbgOwaAMxo5b9DwOyWFIeRyJX35y0Ee7GbJNmaFzFl7XF4Nd21ZDmUkHnDuAoLy6pY
         Xf4iT8RXoToM/oVcUBfMyTcYPUuEkzeCJKtGQnKB3rcSyDXu2S/2aFqQ8ozCpF2ylqLq
         y3DKb5eIEWJ+LxktDcgCOmg/9n0jxvnT0tMsSYLuI8vZhAES+7vacrXD8/7VNU3Yjtv1
         9VwdETVDpQoXwNoC5kyxjQilUuOd54hLmW9O+kygCnxp+EU6aijhpT5/2ItGL2gZGXWB
         gK8kFTRtNUICgiHm6rGng5KYDluWbvzjvyePnRx+X5svfMQ7yA2RW42myKAQWnULu/72
         w2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011883; x=1762616683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DZT80TGVVkLsDEh8uIzxjLsAC/KruYN21Qem0m8wUw=;
        b=LVWrXRRPbcA3G3pmBlVcuhwGga16Im3JCiS22X1EFcGUB8j6S/om2gDJaRBqlhbWlb
         uCzooKE8THDzhpNOres/+lvRyChCh9fODU/G74ksaxW71JdfQ1GtAhf21Ed5VFSzhsMh
         Tbo+PuH9Cu2ZBHPhPBOvPfP/efrLDuVEzVmC6Ji7EBpN4gX9Ge7EYjfpL61MkZFc4sbS
         hhXyzgZ1M17GNCOUywBdfjgKszDghPBnHqgpgSrEMRwkpYzrZNnEVs7B12rnwFMpbu4v
         GGo2HFfDTVonQJHX9iSDwwRzQFKxLmwz86WSlhj3DIaUGOofFtYuB5ZgrGy/j3yNwKyo
         5zDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZgHyKfP1BS24hSnoMZNbRx2lssnt0HJEMh+Oi01dLaCXqHU/whpHaBtieO5X77A5Hm7RpeacatS65OL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfV+cBdK4Njg3VIzia3jP8TaPlUzyF/9MfuDBiBwjde7ArB8I
	XbH4F2MH3LJ14s1pIOgj5W4hblMlcAnLNlwFKDagXSVksey9K93BV1vNqct7KC+BZlk=
X-Gm-Gg: ASbGncv1NWLCb3c25t9dkNEzoG+7tYIGsg5zT6wjyA8k59CvFoeC/AhMOfEVIkZTLIR
	eiqEZrJ0Z9RmF0bpQgQb2W7Argyqadx4yVkv8urnNbuKWRXfcayFMbtAEbMvFkmSdgoHhVoywyO
	gi2sPy2qDzK8z0E9mim+/b1M3/YqFE5M8PQfm1PaNAiYHAFYOA+rTNZKbfwwOKhvc09WYYa1jdn
	F+v//W65rBs31tigrtbQTnaeKdT6Mf125bAPM6fGwFnA5SoTTWk022BPgzQ0Fv3xAa9kS/y/mcu
	4aVbL5xMdvPVBxMXIrjqSl/XVW4Mf2X1f1HsT0pg3YvadLoKpi+Oe49Bwi1isRZVu7OSSpO24T/
	6HWuNrdC66s2P2LeyJoVVd0tKjmEV5uLNM5Z+SKkP8FaKo6cDq9ymVO8ooaZGVDBAvfxYxUAClP
	AsyYmF+u1TXVsCEpdwvs+ucxdjplLK4Cmatvdth9VrFw==
X-Google-Smtp-Source: AGHT+IFkhzb/ZLe6YUds3l2xBBPyiwCVMl/rVpbi6jYMxJtBM8rfwpjbkYfn40FDvEOmymUfcjZpEQ==
X-Received: by 2002:a17:902:ec86:b0:268:15f:8358 with SMTP id d9443c01a7336-2951a51e6b1mr86346225ad.42.1762011883058;
        Sat, 01 Nov 2025 08:44:43 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm59990105ad.105.2025.11.01.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:44:42 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 12/12] MAINTAINERS: Add entry for RISC-V trace framework and drivers
Date: Sat,  1 Nov 2025 21:12:45 +0530
Message-ID: <20251101154245.162492-13-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101154245.162492-1-apatel@ventanamicro.com>
References: <20251101154245.162492-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Mayuresh and myself as maintainers for RISC-V trace framework and drivers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 29e94a94aa0a..45718190cf44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22228,6 +22228,17 @@ F:	include/dt-bindings/power/thead,th1520-power.h
 F:	include/dt-bindings/reset/thead,th1520-reset.h
 F:	include/linux/firmware/thead/thead,th1520-aon.h
 
+RISC-V TRACE FRAMEWORK AND DRIVERS
+M:	Mayuresh Chitale <mchitale@gmail.com>
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml
+F:	drivers/hwtracing/rvtrace/*
+F:	include/linux/rvtrace*
+F:	tools/perf/arch/riscv/util/auxtrace.c
+F:	tools/perf/util/rvtrace*
+
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
 M:	Jack Wang <jinpu.wang@ionos.com>
-- 
2.43.0


