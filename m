Return-Path: <linux-kernel+bounces-807310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB9B4A2D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D53E168738
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7C6306B2A;
	Tue,  9 Sep 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VoVuFYPM"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5F302CD7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401408; cv=none; b=bua+xSO/g+S6j+Gi+/r+GG0wEJMX/z3PpyTXyrzl3lun8BTlh6kN1lyycGOXdXjWZE257DDLsj5dCnaok5/vJcZuUBM4aaFjR3HZI+5ZrFnh5zWW2EjxT2DEMdts/bjzq7OENSmVGul+qT3qE76UaZDDYvMztbp4inSVQpEPPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401408; c=relaxed/simple;
	bh=m2E8W7DiSx6Ltrasj+rnR9WEkMr09MKsEoyxo0F+Klg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qcK2Pw/yLgvyDcSSgAXw4xikcC3/bOIn6TBKkxk9A8jDkx+FR7Jcf5G0+9zYjj1W+EccEAd4BRbSlKNNmog1Xe73OqqA7hrPvniea8ubVwg3Cefl0UscxgdfMpr+0G7NbsheBSxVvRIHyA9+u+leveSnSSEGn7bEvTFrDf6TZyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VoVuFYPM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7723f0924a3so6970757b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757401406; x=1758006206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QppemwXg72umVaHol/lc8lTgDOnrssZANvnDyByXBzA=;
        b=VoVuFYPMGG7mF6nKhQqKrHMYMOIktE34kOU97h38mZSiLfPSc6hA5CD2IfnxEdQZNr
         4FZxCHIgMnW5fyPmUGx4tYQ0WhZ6eCeMB+FbMCq12p1+MuTvi+Yv8nonOXkq4WiPvYWs
         EOJ5Gvk9o+ONJqH4heQLAJduA/8ZxP/Kcc2gmepDGq5CL16gJfpeGsao4u2OfwtZjqle
         YJQztVnhN3ESQKULvNTNSOU/pbnYIX5XIY2fEQUU1vTJVS6mN4ilasSa9qPnn50EAuim
         ko7+k/dnMdZU9BdYVQmeutlSGeajiFIcLfsZWCRW6rMP62RSOqI5Avm6hf9E0IZP3G+9
         kZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401406; x=1758006206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QppemwXg72umVaHol/lc8lTgDOnrssZANvnDyByXBzA=;
        b=C8k45T1vV0c5fUTV5NbTXIfvtHnS34NWuLu+hse8uz5KvROkStCicwmMQbm0Fk6oVt
         OZdHYC2dJz4YUCRqLNAhzcTinvS5e6jQ/xnvP6kUp0iS/Tt4mb9iehF2DJEer9CAk5tD
         MOLOhqSmWDlK2DEnKUOYSJ5lA7S4mQCEO6B5i5MW57BvHoCVCwzysOK2N/KrP8Vlf/j0
         AL4+BU+dHJY8nAtWE9bZsK/JOWtE+KdebR9h4A2Sk/xiygKFDGfl7zIExPstvT+O9oQ1
         TwZSl2O7389ABss/2muSZ0iy7mToQXU8bbylfJNWqcXVA/id0Kzwt2o7OdsW38fQInne
         nDWw==
X-Forwarded-Encrypted: i=1; AJvYcCUOzofM0t5ftu6+y8wkMIwNfutX07ic/jWj7JVq3EL6EofJIYjvMVfsr6EMl0pvv8Gno7UQu3kgXWVj1R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQUrp/lnjxxlQdpWgIYodlWPmznovdwRti6D1rgB1QzsWxq3n
	1grdrByIQuYdLCZCSPvHUwhwumRYOssMmUBIVwgQdb4uiw4HZ3ObtSbRw2Zu9Re6t+w=
X-Gm-Gg: ASbGncuQF0Pqxw7LvYIfQ+ukqw8iOWMmGLJHVbBMeprVD3L6za3X/h37+u1PSrzfa4g
	X9ikuQ9ELL7isTaABw2YEko1ESDysy8kJbQrZOBm+VcD3BO2IRVxUu9QrV+2/IN7yNyYm/ytN7j
	A8pgaQw26hezc3uCtxteBI13D49kNL8mOpUKhMf7xvayKZUCwH+p6RDuN4aHBIAzendfcUH5e2S
	6Uk/SpJbkKYE5tH8VU0wy3VmE5Q3hVu8AhBkOFCCUIOEZO3//2Zwzcw6BLhn8Sz8gfk74qspgOP
	XVKjfBD5nQ8OostWtgdK/HoLMWyZa2XuEooZFzAi6Jz33PvQn+UMsM9gNQxZzncTwJFuNxrKbC0
	/SEAWBQbOn3GVu22JnOuNpI4o3UNvi6te1jI=
X-Google-Smtp-Source: AGHT+IGTI0+CANiAOY9dQTvuxmq7UvW41+dk3xf0GTORfOZzG86GOBRQUviZ8wH9nFVkT6u1ya+N/Q==
X-Received: by 2002:a05:6a00:928c:b0:772:4b05:789e with SMTP id d2e1a72fcca58-7742ddadae6mr13433332b3a.2.1757401405716;
        Tue, 09 Sep 2025 00:03:25 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7158sm1025535b3a.72.2025.09.09.00.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:03:25 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 09 Sep 2025 00:03:20 -0700
Subject: [PATCH v6 1/8] drivers/perf: riscv: Add SBI v3.0 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-pmu_event_info-v6-1-d8f80cacb884@rivosinc.com>
References: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
In-Reply-To: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-50721

There are new PMU related features introduced in SBI v3.0.
1. Raw Event v2 which allows mhpmeventX value to be 56 bit wide.
2. Get Event info function to do a bulk query at one shot.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 698de8ddf895..cfd6946fca42 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -63,6 +63,7 @@ PMU_FORMAT_ATTR(event, "config:0-47");
 PMU_FORMAT_ATTR(firmware, "config:62-63");
 
 static bool sbi_v2_available;
+static bool sbi_v3_available;
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
 #define sbi_pmu_snapshot_available() \
 	static_branch_unlikely(&sbi_pmu_snapshot_available)
@@ -1452,6 +1453,9 @@ static int __init pmu_sbi_devinit(void)
 	if (sbi_spec_version >= sbi_mk_version(2, 0))
 		sbi_v2_available = true;
 
+	if (sbi_spec_version >= sbi_mk_version(3, 0))
+		sbi_v3_available = true;
+
 	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
 				      "perf/riscv/pmu:starting",
 				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);

-- 
2.43.0


