Return-Path: <linux-kernel+bounces-839853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905A3BB294D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3B23BBA5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA53428505A;
	Thu,  2 Oct 2025 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fzwWJriE"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B677632
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385305; cv=none; b=ZLO7QSD9myVMRnl0khq0u6FIiN3NYFdgJrnVB51edFBKLpyRppwth/w/ugS+N/AztJFJxYa3mX2r3FCrKKy9Ru0qwHtlEOyHAwXdLTdpUS2vWlxGqvjj2y9pOb3+d9cAU0pvESgfwjdnHHwAEFX8sSaQrp1ElmG6nKiCZRenBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385305; c=relaxed/simple;
	bh=BS+vJqhdCP6ZTBMXv5Fcb0BNkl2MOks2yJBfSgi82Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCkUO+QKN1pHQBApWVfItaLW3HUmUjJYUlqXltnlKWZx17wyLNJCz8m705D4nt5Xl5HsCASpkWN1w/va371OR4oPr+d+LGgN+jo+j6UfTbbmqEYcEFYtvCdPHUxFDtMNmSCOeQdlbAd5HKnyR7QBwp8plrgRWIUee/pDvu0ssDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fzwWJriE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781997d195aso536353b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759385303; x=1759990103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2sr1Hj8RYXUqowJ/luorrsraS2wOxt6c5HA/zSdYBaw=;
        b=fzwWJriEWrcWe4a3b4cFOqNnoTeb5aENqWpysL2MwTfverD5s6TQzWgqgeDDrR9am5
         KBjDob5x2M7A/CNe2SKpi2iPgrvvhxymPCv0FmT/Ez2WBNwvZ+qV6Fgqpl8mROhhWdAX
         8mbCR0cZ2RR4qZElPmgMaZKHzV4g0/IqjfHqfTR/5SsmF2lZPNUkHdcKgYKhn5AT+hvG
         B2fh2Vf7iSOzELv9r9Qo6D7kxySwMQ9+P07sHFkHFxMbldi81lQBzKyf7YbL05ZctnxP
         zvnJ+FukNjvfABn7H8v6V0PiX8XGUAR6nalqKGs+PtDk7eX7mnYsk2tpn+Qo/Weae1sd
         6ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385303; x=1759990103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sr1Hj8RYXUqowJ/luorrsraS2wOxt6c5HA/zSdYBaw=;
        b=WtLIe9jv1vW9tr/+FgeCnrp+uLILMLv2diUzVIfVNPIczioX4rMV57yVRUNlkdWnhX
         z6i5OnUT2Rhng+cNTOcOKwy00M1tJEdXtbkP6MDJGyYqR1133hBe6pbnWbyeAmtoVEpV
         0FnY3n4i9IEi1RPfsfwqp/0K0SNt9IOVf63o11qA2ekrk768qJC11eA1k4dYV4xWwGuG
         ftCySgVlmdyoxolEEdeaQISBBbIIkGLameiEBx2yhENEJSRNcFU1Xi1eDVdJ5QUDMERq
         NCveY8i+BKnmfCbbPoMb4x3mdi+KSLhaGGnCqOuk8vI6qcr6XhXdbP+b6NHadjbTkavA
         vusw==
X-Forwarded-Encrypted: i=1; AJvYcCV6gHn+QVvsObqO2JOfM4cbhI2E6ujRzhy9Y82OcZmhJs7zE+opqj6SJKEOEAksH2pT/uQaOcFHVwt4BRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFNNs6K2lIUeqUtEJg92SLFJpQMFinU4fR8z7iEbci5MD2451
	umSj/L5Z/Hguhqpl/ytSaB4pwl5Wt9/7zfmKRmlaVuJUyWP94Jy7vG6UyLr85qIGTG8=
X-Gm-Gg: ASbGncvdP/cV+NxgVjtQQx+DZMgfahXsqnxH9PYLzAZWWmdcHkZO7DP7a48sf2dL1fc
	7nbPWnyGREqBwkzyGY6hI5/b7cwHZIz71LAjQ0dxJREMgXokaMDUiahq/kIWjfLIXw2RZ/3j/N+
	PeV8AzrfhlP/h1I3QKerY2+xdfLZ3+Yd5eFQA9gwfaL120pDKKUbRhw1Wh8F3EntzTBPajwkIwA
	JUzkwISatyGQsbzN/8UasjgmYAXcraq1q7W8ILyHjLUFI4o/zSF7/CtQaGNe+LlS3ThPPqS6eql
	ACMbvEEdFWy6az6PqbflLqszDeUYARJAWSo//DbyhqxMCj7T6Z0ueXI2NtCfiGaRA7+z6HfK/tj
	8mB9z8DcHR8ZzN03LzgGeEwNunFoKRCkPFegzGmpyorn+pyIeiogUETeGifaxUO17EAqmBSCqn3
	LLqdw=
X-Google-Smtp-Source: AGHT+IE/P3CYgcBDFzRCkFb9v11QtqWlSsUw+KrLc7ikzxnSyndvWks/J4/8QFBSVDLBkg6UpMZ8bg==
X-Received: by 2002:a05:6a20:9f99:b0:262:9451:c648 with SMTP id adf61e73a8af0-321e3edc7a6mr8232285637.37.1759385302495;
        Wed, 01 Oct 2025 23:08:22 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm1205029a12.37.2025.10.01.23.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:08:21 -0700 (PDT)
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
Subject: [PATCH 00/11] Linux RISC-V trace framework and drivers
Date: Thu,  2 Oct 2025 11:37:21 +0530
Message-ID: <20251002060732.100213-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds initial support for RISC-V trace framework and drivers.
The RISC-V trace v1.0 specification is already ratified and can be found at:
https://github.com/riscv-non-isa/e-trace-encap/releases/tag/v1.0.0-ratified
https://github.com/riscv-non-isa/tg-nexus-trace/releases/tag/1.0_Ratified

The RISC-V trace framework and drivers are designed to be agnostic to the
underlying trace protocol hence both RISC-V E-trace and RISC-V N-trace should
work fine. The discovery of trace protocl parameters are left to user-space
trace decoder.

In ther future, there will be subsequent series adding:
1) Sysfs support
2) ACPI support
3) More trace drivers (such as funnel, ATB, etc)
4) Support for upcoming self-hosted trace specification
5) ... and more ...

These patches can also be found in the riscv_trace_support_v1 branch at:
https://github.com/avpatel/linux.git

To test the patches, we need QEMU virt machine with RISC-V trace support
which can be found in rv-etrace branch at:
https://gitlab.com/danielhb/qemu.git

To capture rvtrace data using perf on QEMU virt machine do the following:
1) Launch QEMU virt machine
   $ qemu-system-riscv64 -nographic -M virt -smp 2 -bios fw_dynamic.bin \
     -kernel Image -append "root=/dev/vda rw console=ttyS0 earlycon=sbi" \
     -drive file=/path/to/rootfs.img,id=disk1,if=none,format=raw \
     -device virtio-blk-device,drive=disk1
2) Run perf record to capture rvtrace data
   $ perf record --all-cpus -e rvtrace/event=0x1/ <command>
3) The step2 would create a perf.data file which has the rvtrace data.
   Now run perf report -D and look for PERF_RECORD_AUXTRACE event
   section(s) which point(s) to the actual rvtrace data offset.

Anup Patel (5):
  dt-bindings: Add RISC-V trace component bindings
  rvtrace: Initial implementation of driver framework
  rvtrace: Add functions to create/destroy a trace component path
  rvtrace: Add function to copy into perf AUX buffer
  MAINTAINERS: Add entry for RISC-V trace framework and drivers

Mayuresh Chitale (6):
  rvtrace: Add functions to start/stop tracing on a component path
  rvtrace: Add trace encoder driver
  rvtrace: Add trace ramsink driver
  rvtrace: Add perf driver for tracing using perf tool
  perf tools: Add RISC-V trace PMU record capabilities
  perf tools: Initial support for RISC-V trace decoder

 .../bindings/riscv/riscv,trace-component.yaml | 110 +++
 MAINTAINERS                                   |  11 +
 drivers/Makefile                              |   1 +
 drivers/hwtracing/Kconfig                     |   2 +
 drivers/hwtracing/rvtrace/Kconfig             |  32 +
 drivers/hwtracing/rvtrace/Makefile            |   6 +
 drivers/hwtracing/rvtrace/rvtrace-core.c      | 781 ++++++++++++++++++
 drivers/hwtracing/rvtrace/rvtrace-encoder.c   | 107 +++
 drivers/hwtracing/rvtrace/rvtrace-perf.c      | 343 ++++++++
 drivers/hwtracing/rvtrace/rvtrace-platform.c  | 174 ++++
 drivers/hwtracing/rvtrace/rvtrace-ramsink.c   | 198 +++++
 include/linux/rvtrace.h                       | 341 ++++++++
 tools/perf/arch/riscv/util/Build              |   1 +
 tools/perf/arch/riscv/util/auxtrace.c         | 218 +++++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/auxtrace.c                    |   4 +
 tools/perf/util/auxtrace.h                    |   1 +
 tools/perf/util/rvtrace-decoder.c             |  91 ++
 tools/perf/util/rvtrace.h                     |  20 +
 19 files changed, 2442 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml
 create mode 100644 drivers/hwtracing/rvtrace/Kconfig
 create mode 100644 drivers/hwtracing/rvtrace/Makefile
 create mode 100644 drivers/hwtracing/rvtrace/rvtrace-core.c
 create mode 100644 drivers/hwtracing/rvtrace/rvtrace-encoder.c
 create mode 100644 drivers/hwtracing/rvtrace/rvtrace-perf.c
 create mode 100644 drivers/hwtracing/rvtrace/rvtrace-platform.c
 create mode 100644 drivers/hwtracing/rvtrace/rvtrace-ramsink.c
 create mode 100644 include/linux/rvtrace.h
 create mode 100644 tools/perf/arch/riscv/util/auxtrace.c
 create mode 100644 tools/perf/util/rvtrace-decoder.c
 create mode 100644 tools/perf/util/rvtrace.h

-- 
2.43.0


