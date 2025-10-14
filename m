Return-Path: <linux-kernel+bounces-853091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F5BBDA9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BCA19A51BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7B52FF652;
	Tue, 14 Oct 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RGJ8Oey3"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBE5CDF1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459421; cv=none; b=gFg/zFkNxOvCHYrOYPqBnYLdPh0CFuMgzabxG5Erk1nd1QYaPdz0p9SdNp80ov2yIkyO2hDzU1NvjEC6LJgnUEDWktVDEVEI778lzmhgx+y1VITXvLeVb2Bmtr0WEaSwkRNQldwd6Myf4FIpQvYjxaqzzWgxQtIZCiXqfdiynvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459421; c=relaxed/simple;
	bh=0tPZXo1qc1HtONmBrYC8xG2rw836SmDAATV06I5QW4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIsI40/J8Xmd7L2+K6otfHINO5wOMiXKWjFaaewTXJjrntzR8l/v2nXzj3lbk016XkCccie9vXT9qM0wFnMaLFoKID/vHyd0ToiEzgp8TyJTm81zKlPISK7yImn/SVQOqUmjccMOPi/Y0SJX42J+NpBDMx6wF1WaPdZM2GI+1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RGJ8Oey3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f343231fcso3473803b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760459419; x=1761064219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ9acaklz/P/nDwFY2BTOYnQh+KBD3+sU3KKAjNaoes=;
        b=RGJ8Oey3st9bP8l2/bNBvLm1euypGpTJwh8Ipv70JmxAzzjwKSjtsVA+YctRIhHlV0
         HOQhooj/nH7bjQn9NIfCwLcjyJa7Pc61N+/9J0JtErHJgsMwOEr2mnCgoFyae42CRDOO
         sj9rnOi3oKoGLCdWCFxoDcGEK1umdRNVnl81T5tBm+IA2d7cRXlLn1/lh06DEgyKBqdJ
         W+HE9heB+9nM0b5cCljmFIzTf4dTgWd+AuBD0UvvfDynLZZ0JOsXjNBFKnOI9W6IFlA7
         q99qO6UgSJ+fPTOUtEh3VMYk1ctBpsuhMOdENBLQd/V5zQCpIEyW8fpH2/XqlXqBM8GZ
         1Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760459419; x=1761064219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ9acaklz/P/nDwFY2BTOYnQh+KBD3+sU3KKAjNaoes=;
        b=f56p9GH9eq41fPqn5+MnWlxNx25AxgsO5R4pdhKRTAeiSQzp8h1QPmL2YyRvq3+LTX
         /xQrEYnk0+itI3ZG/zLqx2Mx6q35Hfq7fy5Oiiuu8ZVHtWz+sBFVeuc05PyoUlsW92cq
         fYMz2vkewELNaNMhHNtEu2x3Pa0IM7AVJKDF+pOclnBATx4b/ZmVGj3Lx4nKaZ81UuS9
         bnx7BNMTr/oC3mBF37JDrAn5EzePtm23AUM0vScdO8oIflamM4xS0qPriKMIoGJA/L7r
         e/W66OSf9yvlzAb0ingh3gU73MFXOV7RBFO1jjckxI+f19Z+63lvECivdQ7C4nkBVRtJ
         EY2A==
X-Forwarded-Encrypted: i=1; AJvYcCUZBEpFqXwuCjAMgC7nLzQQIG9GBhwDS0UWtF+FhSmb0mxKv4X5UAtA7B0IDd/KKGqZtZAkQxaCCPsV+I4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5bO+sO46QF3J+8XrVjqtt5/tyC95+2btkgBra0gvS4maPl2d
	uEOo4DZ83R6ZlN4R85HEIwTRlLy1rFZzm8Tec4Zl99pcadP3Vy72686wC1GhAjUWdHhgh3TjTQL
	PjgFzNgg=
X-Gm-Gg: ASbGncsTzGuo4JwYBMa6gVHosRTGPMYX0nsF/Z4jWSZZcmiOzruqdajvk1tOmZ13n3e
	ZzI2cuyS8tV8afWtC8R+1nR3Bpy+luucN3oKy2xI8q6JznReypg8zunfNdtRPlC408tIcXKXmW3
	HQrejkV7aCkyUFKOGymMe+Ku5R8wmTYzpushvAdCWWwVBPoGNh8YzzJKntdx+5mMljzBA/Q/ujE
	SuxpWuy4qzhqLR9VkXF7ruivCjMsyT2XY7ReR0bga5EXql2XlFpUj2DhrL1OK4zMqlIRJkmlvDP
	17KNv7bHXAxFEimvLRydCN5rUqpkA+5Ux17Exbej1e5N1k/92A1pY/U0TIHHgpTD5JOI1OFO2Bg
	LL7FAFSRZj+639virB5j/i1On0efUK03/oFIc92nWrAlKKwR7NH/56NLNw9cTElz5k/5PrDdEYj
	G7KvfJM0E=
X-Google-Smtp-Source: AGHT+IFKg+SoNpQ1p12OLoDHgMiJt2EKpjAPfsJVFpHN4o0hhnAyI7lP0r7N7cT4Fd8nYtzrUA8B2Q==
X-Received: by 2002:a05:6a20:3c8f:b0:2f0:91c0:1886 with SMTP id adf61e73a8af0-32da85090a1mr33776727637.59.1760459418636;
        Tue, 14 Oct 2025 09:30:18 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678dcbf919sm12478096a12.9.2025.10.14.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:30:18 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] RISC-V: Don't print details of CPUs disabled in DT
Date: Tue, 14 Oct 2025 22:00:09 +0530
Message-ID: <20251014163009.182381-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Early boot stages may disable CPU DT nodes for unavailable
CPUs based on SKU, pinstraps, eFuse, etc. Currently, the
riscv_early_of_processor_hartid() prints details of a CPU
if it is disabled in DT which has no value and gives a
false impression to the users that there some issue with
the CPU.

Fixes: e3d794d555cd ("riscv: treat cpu devicetree nodes without status as enabled")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kernel/cpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f6b13e9f5e6c..3dbc8cc557dd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -62,10 +62,8 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(node)) {
-		pr_info("CPU with hartid=%lu is not available\n", *hart);
+	if (!of_device_is_available(node))
 		return -ENODEV;
-	}
 
 	if (of_property_read_string(node, "riscv,isa-base", &isa))
 		goto old_interface;
-- 
2.43.0


