Return-Path: <linux-kernel+bounces-740110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41968B0D01A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BB3A5AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3463628C2B7;
	Tue, 22 Jul 2025 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cxOpbG6o"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783828C022
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154128; cv=none; b=XiqNa0ALf0GN9rgE6d27CytT+gukQzZov1r9Re5AU3jq+oKDiseHtXqnG/7sLl3CbmHfHZchzPz5opmGfAnkqLwGwA4xdNoVWgyMb22PcpFm8OX3xzhJ8fgl21eiMOAyQnTc+boq8soS0LJzOdeljL5zR77fIA8/lcaRvNwi4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154128; c=relaxed/simple;
	bh=m2E8W7DiSx6Ltrasj+rnR9WEkMr09MKsEoyxo0F+Klg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLHpOj1i99VV4520Z0yRAhE+hoRiIxhyjYCJxZHxZ5oBEqfD8xhrPLtKuGm784wYbZKCYrSMnlxG6B3RSl4+Y93e4nloWQLFJR/sANR2O1j52+CenZdp/qrMs3uXH0cTIQ4OSJteXRIbuoMJJKBDCamMVW8zJphc7C7cYRMUFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cxOpbG6o; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso5228635a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753154126; x=1753758926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QppemwXg72umVaHol/lc8lTgDOnrssZANvnDyByXBzA=;
        b=cxOpbG6opvR+8IuaxkxL2yUWP/SmqzCtnL0uJLzhO9ngBg4TPwHd307T/KZgGzxLHx
         0HhzDt915bdN7Xnx3H4TljgciT96Iz5JYgDsG01mqC5gzID2si6wqzI05BDwy1zCwXDT
         xhjok01RlUUo2tSU67j1ncR8TkNx1UW8MtKt41qsM/QAYgKXmBBZgOSFQGA6YRjSwo7v
         wpHGlix7+fJ/jBxVnT6HOvm9fdspIsFZjnrXfQ0vHs0nSZh0EmmGNuNbopSYtcRZx+4X
         yPev6AhsOOtMzOUNwOSut5tVsSqBNj8ZS3gxpWD60q4NgbhmUEDNlBPBeEj66+YYRyAK
         iJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753154126; x=1753758926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QppemwXg72umVaHol/lc8lTgDOnrssZANvnDyByXBzA=;
        b=GydbGdXIoORm+lNJ/ZVy5HI/3WMDsAG9q1vSV8b66WZMoCERRCqKmgGRHz/DB8MMep
         fTd0Z/0piPrTGu+VFvQVNy6U/xJnSeckbazK3L5brwWnOpNMQwzGEdzPHnY5UIO38Q94
         Sz1NV8HcKVtFZQi0yN+IBTFh6bHkHqDX1emq48uP8wOiWxSljgikkxtlleHJwk0iLZk7
         0UZJggDaiU5GArZZ/OVQGJwBCQR65kjEaM0IZi+QqaWOl4rk7jaCdzdQpNIY4QSe0Uio
         F0e3yJigC+uli6nwM9O2AO0q1+wkXQEqWrvYQFOtaRdV3er+C58s7NnAqhKkLE9LcFma
         Rakw==
X-Forwarded-Encrypted: i=1; AJvYcCV7VHHkSQ5j64c/bRh/4UJBZL+8kLtJ2P+kgjaCVsNo+GRzvpEXowS5Tcs5orPEF0wYYpoWV8kzbjwo3dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnfo8YlCaw/aPBKD7d9LzsbtupiWRkQoKKeLtEteKOvmieZH7
	YmP6gjRgwvJ38grbM0csii3NqaXHE4RusVkkIzC2/+29RCftYk6lapKSRIlVrv+9Kyg=
X-Gm-Gg: ASbGncsNvd5FBXmBC0PeXtJ3yQ9ggbuyNPaVec5zL9kS2dr+8su70yesyS9kRLuDBNz
	+9RlS/kJtIqAzNzG80Dfv/9YrcLt7AIdpKMNUvCQvi4qvID+8WQv54KpGlekj3Qy3VyiZ5lHP7u
	gVJVDniUoeQx3r2Euxgr9cNIhQo69WZbztoJFB8FApurpHFV0iY6v8MPuY6Lwa76/DQHLU3osMG
	DLBmAh0V60chG4AQ/0lxOyjBBbbCl2h8FBWNKPW6PNsYeDCRwfCO1sOu8MZSE0X5euFv+U+hGRu
	lIzkepX4SAucq6N0QOrD3/v+P3YKlTJd+tx1U9uoLa1x3D05KPUmsrYtvK/+SjPK4DvQPfg568K
	SnoOsSZRXHxRl7koZNIzRE6EZLe7+ht8jXEk=
X-Google-Smtp-Source: AGHT+IFGWxj3iUKxSSdZKPT9lOfiDcRTnkWskcnNV9b0jBWk2yItlB0Jg7U1GDfAal+i2ahxkqkLKQ==
X-Received: by 2002:a05:6a21:6daa:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-23810b4dd3dmr37662781637.7.1753154126114;
        Mon, 21 Jul 2025 20:15:26 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feac065sm6027612a12.33.2025.07.21.20.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:15:25 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 21 Jul 2025 20:15:17 -0700
Subject: [PATCH v4 1/9] drivers/perf: riscv: Add SBI v3.0 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-pmu_event_info-v4-1-ac76758a4269@rivosinc.com>
References: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com>
In-Reply-To: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

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


