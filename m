Return-Path: <linux-kernel+bounces-740109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7728B0D019
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF605172340
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B728C030;
	Tue, 22 Jul 2025 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vX5ZPBpF"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4428C01A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154127; cv=none; b=WZITfnyPnZhf2MKed1R77NYhX6TAfvWr7yl6XP8/9gSiZ9uMmqv3vcWWBjA/FPuZXMmoqk0ku2wQ/A/rtgqqwvCB/hKnCiHpYPx1oKk/ZeC7w3wMnyQ6PzISBjPlFpufxCdt+Iel5GKSF0wy2diVwtsAWgW/0klY6AngzrrArjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154127; c=relaxed/simple;
	bh=JzkBOKAgWdiUJQ2g/MaoHxtIyReucIXiIAdcpENkXdg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jcURN4UT4qRceAB5wPH/A3sMf7vsSieOiXg8QG2iixD1bfRuBieYb8Ur3SPl2bl6Sgzvst0IIEVcvKtYr/fO4upT6sJ1vl56o27lcYeU7/t8MyQ8jvhvtsDHbpB/Ua2XQiJZleJoDbB/O4tzk1z+z7HlMJcVWsc+Ff8Y8XltENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vX5ZPBpF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31c84b8052so5549507a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753154125; x=1753758925; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N3ro4Yyao5uXofBVuxsMuyd3IafrNj++K0PwR4Tt2N0=;
        b=vX5ZPBpFcQlouuvkn+JhlTYT+QKdqXD0kYgt2NV2gvr+PVMCIPJJl5ibjRFpcAukZs
         SgfJPkzjekrNSlKeeyy+Oh0iD1bPnnHltkgFTbyc9N/B/Fvp0U/LURfqQQhj4rE1eiAW
         krvNRoVg/M5P5EO4y3MZzSEjGV748i9ewk2Dm4v2vUPVS3fpHP+9wlu3W91p4WsIM0/8
         InEkAPPFgvf9qXJPiY/Xk3EdhqcLGwMFeg+wejJrqVyvrZWRMw4rDdplK/v0900BeTKA
         tgw2rsa/Zlv/ZVfCN445OHQ1dI3jpTcd8sr17IRcGSztBPzPy9cfCD0dRjrY+nb7bhF8
         +l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753154125; x=1753758925;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3ro4Yyao5uXofBVuxsMuyd3IafrNj++K0PwR4Tt2N0=;
        b=gyMVVXKlLHaQesT95qb7TGMikUMVHWVEOI+Ef3QKCx2TwZzzGo9VNRQitNsNRpt6Ws
         Z6KdU26vm3ns5jBk/G2P/IDWmgtsHsUi7/e1erINUGWcatGyzSnVvVYXOBUz89IHkG9k
         LSTVWaZRHU2iNyVBUS7SIT8KVUo0yf1J2YoHU2UNGHekxG/lippTpNOkiwb+OdlQ4ajQ
         3Vknoywv/0KlarwgLTMcuQsgd3Ky3/gu4OZxsS03HFlxrHO7h38JXIDWyYsqTLLh7H/z
         jVmn9o5DSEVrsp6NXKMkdkeA5W2XnyCXk4bqQcGuAUYWQeqRTPc44FKOQnaeNZAQnA6m
         ETig==
X-Forwarded-Encrypted: i=1; AJvYcCUHybqM4QY5ElkIpG6HfsMb7eRZAJuTNDGipMG0taaw1GyTyMzJZpwqARexYx/O0YJ2+TJAPv0WvaDrg3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VEkquihe6gr+NQmzbxBI1F7ihJPjaISGOT8+DPy9ZTYTaAFd
	jLkXFPTbVtliDz0iAlMa8a/d/XBvijPPwHx9FKAQCKs5ZwEN4MdfbFKRCOGw8q3SsmY=
X-Gm-Gg: ASbGncsibFvJcenFudwc3UjScg1xKlrWvtuHRG+Z8mPgFDBXYUwnB83lHN3N4K1CsjN
	T30GbJ3c7UrUjDvtnncDvMszznb+LoYz4z8tNbsncwWtZdIzsJ4cFz+0JzBwjqfQCVCsmhZUn22
	Lt6eMy4RN0P3GdctNkb7TKIiPyNtWeF/jAN8trDECrkRQqgoBhSZdOgFTQtBPrTW6z8PHDiLV37
	t8ytTsBcyD71UN4JfKtVznN6aRGBBrQyVrpbbRMLpDPqzBZkb2zU2G1D6Zl8BsFfru4S/bvxzQL
	4nQImm0N7NohG1rcfkDCt1cmnopFcG9cnbOW9RuNhMLfhdw/WquSWTKPXnLIUSRSVuiMN3bwSQo
	I0tTrRbCKp+GlR+ObidLuNbf9cZD7zE/BXmk=
X-Google-Smtp-Source: AGHT+IE5Vc7OGRx4QhLjcitwZKIWZGvajhiltbo4bWSxvPQDoCrplva3mLaEOWP7EA2twj6pT6oskw==
X-Received: by 2002:a05:6a21:6b02:b0:21f:5598:4c2c with SMTP id adf61e73a8af0-2390db673cfmr29574196637.13.1753154125053;
        Mon, 21 Jul 2025 20:15:25 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feac065sm6027612a12.33.2025.07.21.20.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:15:24 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 0/9] Add SBI v3.0 PMU enhancements
Date: Mon, 21 Jul 2025 20:15:16 -0700
Message-Id: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQCf2gC/23Q3U7EIBAF4FdpuJZNB/oDjTG+hzFNoYPLRekKX
 aLZ7Ls7bWPUXS8PCR+cc2EJo8fEuuLCImaf/BwoVA8Fs8chvCH3I2UmSlFBCYqfpnOPGcPS++B
 mrlWDAiw2ZpSMLp0iOv+xgS+vlI8+LXP83PwM6+lOAehbKgMv+VA53WioBDj1HH2ekw/2YOeJr
 VoW30JdAtR3giBBVQpq05ZSSfOPIH+EWog7QZLgWmOG1o3aOrwRrnvFiO9nmmrZe7IJUxq2qbr
 icasn4De9LdLT7/YPgkRFPWvdiD/80zqgGRJyCpNfuiI3B5A8WkEvX78A6qJO7qwBAAA=
X-Change-ID: 20241018-pmu_event_info-986e21ce6bd3
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

SBI v3.0 specification[1] added two new improvements to the PMU chaper.
The SBI v3.0 specification is frozen and under public review phase as
per the RISC-V International guidelines. 

1. Added an additional get_event_info function to query event availablity
in bulk instead of individual SBI calls for each event. This helps in
improving the boot time.

2. Raw event width allowed by the platform is widened to have 56 bits
with RAW event v2 as per new clarification in the priv ISA[2].

Apart from implementing these new features, this series improves the gpa
range check in KVM and updates the kvm SBI implementation to SBI v3.0.

The opensbi patches have been merged. This series can be found at [3].

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc7/riscv-sbi.pdf 
[2] https://github.com/riscv/riscv-isa-manual/issues/1578
[3] https://github.com/atishp04/linux/tree/b4/pmu_event_info_v4

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes in v4:
- Rebased on top of v6.16-rc7 
- Fixed a potential compilation issue in PATCH5.
- Minor typos fixed PATCH2 and PATCH3.
- Fixed variable ordering in PATCH6 
- Link to v3: https://lore.kernel.org/r/20250522-pmu_event_info-v3-0-f7bba7fd9cfe@rivosinc.com

Changes in v3:
- Rebased on top of v6.15-rc7 
- Link to v2: https://lore.kernel.org/r/20250115-pmu_event_info-v2-0-84815b70383b@rivosinc.com

Changes in v2:
- Dropped PATCH 2 to be taken during rcX.
- Improved gpa range check validation by introducing a helper function
  and checking the entire range.
- Link to v1: https://lore.kernel.org/r/20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com

---
Atish Patra (9):
      drivers/perf: riscv: Add SBI v3.0 flag
      drivers/perf: riscv: Add raw event v2 support
      RISC-V: KVM: Add support for Raw event v2
      drivers/perf: riscv: Implement PMU event info function
      drivers/perf: riscv: Export PMU event info function
      KVM: Add a helper function to validate vcpu gpa range
      RISC-V: KVM: Use the new gpa range validate helper function
      RISC-V: KVM: Implement get event info function
      RISC-V: KVM: Upgrade the supported SBI version to 3.0

 arch/riscv/include/asm/kvm_vcpu_pmu.h |   3 +
 arch/riscv/include/asm/kvm_vcpu_sbi.h |   2 +-
 arch/riscv/include/asm/sbi.h          |  13 +++
 arch/riscv/kvm/vcpu_pmu.c             |  75 ++++++++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         |   3 +
 arch/riscv/kvm/vcpu_sbi_sta.c         |   6 +-
 drivers/perf/riscv_pmu_sbi.c          | 191 +++++++++++++++++++++++++---------
 include/linux/kvm_host.h              |   2 +
 include/linux/perf/riscv_pmu.h        |   1 +
 virt/kvm/kvm_main.c                   |  21 ++++
 10 files changed, 258 insertions(+), 59 deletions(-)
---
base-commit: e32a80927434907f973f38a88cd19d7e51991d24
change-id: 20241018-pmu_event_info-986e21ce6bd3
--
Regards,
Atish patra


