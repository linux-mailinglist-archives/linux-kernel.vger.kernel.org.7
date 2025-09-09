Return-Path: <linux-kernel+bounces-807309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30A0B4A2D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6781BC69F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A3E306B33;
	Tue,  9 Sep 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Xz6nUsID"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E10259CB6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401408; cv=none; b=rS0+1ai5XFbfzFu+RPC/WJol4O6dyAvJCiESuQYylywmgIeFxmRdPGd8Mpd/qFCr8Nnmwr/uZPERqq8XMXmcry70AFGJfbGtRb9V6y7lsW3Go2CSxnfC0V2cXNXcSXS6iyZw6PYnO8rCdV7DKr3qMiGZpIElUYUUd0oQgU+dW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401408; c=relaxed/simple;
	bh=YiWO+f6yiqoYUMb8nGevg0JVmM0gfAGm3UgzoJnSL1M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N9g/nfdxrUc6UJ5gcc7EnRKW4cfFGm1QSGY2UbHVaWVaRci95i91vWZXLhJoprhtOB4L4YyeoEPLxN1BXtJnvnOGca5MSKxJZi5ajPHot1LouLrD3DNXJdExZSG7pQgaqjI9Y/803Ot6iKiQnR5+1nXgRw68cI6I6dAwxuQnTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Xz6nUsID; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772301f8ae2so4265376b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757401405; x=1758006205; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNthXv7xmnVgNBJdwKS6Eu1LchZyxPFP+JzXVAI2vr4=;
        b=Xz6nUsIDThbqFGkYrfKSLt7MJaFlvG+Hs5SlmAYVFjYVSITUv5gQnvxcg3S28GyMy/
         CaauypcbSSpPR69RWsLVdzxngKgEaUnMEIxXy0UTpd87ZT9YF2FW3ZJZuFmYecoktXAl
         qBz0J41vkACew89/QMqu05ctVdi8muNiedUDgjImgyzsEzDz9ajQ6mA0VuhMvQO2F1Iq
         aZcXyzbdHgb8JsTJoTWjNBMsMikbbZLKvQsnFJQbYDXvLw8f66lWQNv2S5+2K9a6yeMK
         HB2W9CR0ARfblg7Az5yuX1eg9ilyrSpkSXFB3rMqqKdMtEWMKTUrB5nl2+v5SjDp/HGW
         8dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401405; x=1758006205;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNthXv7xmnVgNBJdwKS6Eu1LchZyxPFP+JzXVAI2vr4=;
        b=mPEb4q7bsnF236oapVqPZ5sNsM3LmBZVls6nh8ovaocC5qEuHCJ4ALCTJyBq/uTC+a
         QGIg+cRmWazaoAGiVsqD9NdrJ+ANeYC5YZ1JpE6bAKJ2mZY5pEh1n3OLf0Jn/3koENb3
         LtJg+csCbQJBSYmvVt1BXTXgB3hn4+gALTUm/Ma97KWsuHYA+yJCCq69DLzKz8xHrY1n
         fjohBVA5k9PNNSvOgk8YnVoZ1OnffWdRAyY5mNHV9+88qK6CVFSLdxQwg6NcZUpZn9I+
         JooAL1iLH7nnLf3IjJ1VVtZkcUOMuo4WnoziZfCog1HLH1ebJiS12wfRmxgxVyAZOqU1
         ISCg==
X-Forwarded-Encrypted: i=1; AJvYcCVe/wQgXKJGEM5unYgk1aX/+ejHb1CzYq1JI9whITWd1n3NC7jnnoM24op7A8oL6RqR+jTXT2/aLW5MxVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDj/6IL/0CtwkjU+jYWNxz7OHXMPwAfCyJQV7YuaLGeSgxEY2V
	/FWi4Zp1SqaPPzhMss6xb5tKTDNXDoDBbzA2S7HX0h4aLqDK5Vv08cJlMhk71pNbXV8=
X-Gm-Gg: ASbGncvHX3SdD42h/JMclamWGhgC9tecpBa7XfUbNNaQRkq51fqtMeS8Z03iIbvb6Nn
	3g2AWPpc63QE7cwWZAT8Z+Z5TL6XlI6LWTMNityI22RJFaVA2Zp6gOF6leQbS5zMOZlrepAEX5r
	99BqE5vM4z89nE584badFdR0wJKYOSHhIm318mQXKhxv+aALTG/X5UivWqDm0hqySgKjJMsaC5g
	ODVjZSw4L4H71/vW8L4qjdamn7iW43WtYTIbACceLqjrQcN3ggaLohJloebjTeit7TFXjeG1OC1
	U3/eZgBpU4d7Tn6gBYMAy0FS0CKVOjOV/MHbGbUrbZuMIQB4kRYoR1yNE79FqB+5YJYaoWh+3eR
	nwVf9biPjswN7lzVbTYFc4HqlDsc7VPcDtcI=
X-Google-Smtp-Source: AGHT+IFVlHtNE2LMGS7gSQLQT0W4LugB0ERiut2YB2J1SVxQq4kRk0S88rF/oo0Map16D7hoJpjjYQ==
X-Received: by 2002:a05:6a00:c94:b0:772:332c:7976 with SMTP id d2e1a72fcca58-7742db6308dmr11948119b3a.0.1757401404738;
        Tue, 09 Sep 2025 00:03:24 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7158sm1025535b3a.72.2025.09.09.00.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:03:24 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v6 0/8] Add SBI v3.0 PMU enhancements
Date: Tue, 09 Sep 2025 00:03:19 -0700
Message-Id: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfRv2gC/23R32rDIBQG8FcJXs+Sc/wTLWPsPcYoxujqRZJOU
 9koffeZhNGt6eUR/On5vgtJLgaXyL66kOhySGEcyiCfKmKPZvhwNHRlJlgjhxoUPfXng8tumA5
 h8CPVSjoE62TbMVIunaLz4WsB397LfAxpGuP34meYT1cKQN9TGWhNDfdaauAIXr3GkMcUBruzY
 09mLeOvIGoAsRGwCIorEG1TM8XaBwK7CQJxI7Ai+KZtTeM7bb17IPCb0CBsBD5vYRvZCGU4Sv1
 AEDdB4TYHUQTdWYMSmDaM3QnXNeboPs+lrmnNmvQuJbPUta+el4gR/q63tHIoCa0hAXPle15oi
 f/4l7nE1iRHy9CHaV9luQNGo8Xy8vUHDuHwgjACAAA=
X-Change-ID: 20241018-pmu_event_info-986e21ce6bd3
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>, 
 Sean Christopherson <seanjc@google.com>
X-Mailer: b4 0.15-dev-50721

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
[3] https://github.com/atishp04/linux/tree/b4/pmu_event_info_v6

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes in v6:
- Dropped the helper function to check writable slot 
- Updated PATCH 7 to return invalid address error if vcpu_write_guest fails
- Link to v5: https://lore.kernel.org/r/20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com

Changes in v5:
- Rebased on top of v6.17-rc3
- Updated PATCH 6 as per feedback to improve the generic helper function
- Adapted PATCH 7 & 8 as per PATCH 6.
- Link to v4: https://lore.kernel.org/r/20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com

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
Atish Patra (8):
      drivers/perf: riscv: Add SBI v3.0 flag
      drivers/perf: riscv: Add raw event v2 support
      RISC-V: KVM: Add support for Raw event v2
      drivers/perf: riscv: Implement PMU event info function
      drivers/perf: riscv: Export PMU event info function
      RISC-V: KVM: No need of explicit writable slot check
      RISC-V: KVM: Implement get event info function
      RISC-V: KVM: Upgrade the supported SBI version to 3.0

 arch/riscv/include/asm/kvm_vcpu_pmu.h |   3 +
 arch/riscv/include/asm/kvm_vcpu_sbi.h |   2 +-
 arch/riscv/include/asm/sbi.h          |  13 +++
 arch/riscv/kvm/vcpu_pmu.c             |  74 +++++++++++--
 arch/riscv/kvm/vcpu_sbi_pmu.c         |   3 +
 arch/riscv/kvm/vcpu_sbi_sta.c         |   9 +-
 drivers/perf/riscv_pmu_sbi.c          | 191 +++++++++++++++++++++++++---------
 include/linux/perf/riscv_pmu.h        |   1 +
 8 files changed, 229 insertions(+), 67 deletions(-)
---
base-commit: e32a80927434907f973f38a88cd19d7e51991d24
change-id: 20241018-pmu_event_info-986e21ce6bd3
--
Regards,
Atish patra


