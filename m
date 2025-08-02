Return-Path: <linux-kernel+bounces-754093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DBFB18DF9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2346617244A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041A22068B;
	Sat,  2 Aug 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="JT4HBflS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63778219A95
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754131092; cv=none; b=nzUgBqxuEL9foImuRzfpLm81/3kbTAmk7kM/Cxc8CSA62su6xx0gHZDt1IzfgrZvjOmvd3nnoYJra+vP3NG2XY99ak7VCwUGZsqIUQzIzE7F/P7PR5Uqc3FLium/WyrPRZzqYa74P3+bMMyvPwsjN3hTHJl0jVdpjAOtpjW+i8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754131092; c=relaxed/simple;
	bh=78NVjdNVPg30hTJnbWBWyc33Oq0igcvoln/WVrBhAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOKsY7Cw5Yi6TYmie4egzZXY0Qv/8mWBIP+Nrbo7t2tUkUflKSuRzV7RtVEm4wJyIvDO3wRl6bWNj4RDv4pr3s9wDNMNVx/H4u72QnzDlZ+VxvHuH2OoD6XkgbpLs+5hQ5pUm3rMxxrGdRbCXU9owv9aT66byPUGqdCqGC4z7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=JT4HBflS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24049d16515so14382875ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1754131089; x=1754735889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G63QXIxj+Dtjk0K95q+UoQIrd3RUwOdJawqBP/rtSGw=;
        b=JT4HBflS65067brDI4BWClOHiSp5xxeZpyiz68G4lKQ4KtonbQy9DhtdsbLRBKVKz9
         UaFnMTBgrF1GlIINoBK4cYCA+QPyVSvUzCfN2jXQPGKtcKJEWbMnIhesPMrJ52bi0nrj
         +nG72j0mQSg78CZfCUrxSBAl3qu12lUI4TlLM6JUhEN1bqsP8TUdVNX9zzmLksgDmMQ3
         FYga+Khla83g7/+npbDwTJmcMWyQ/q2Iu0mMr86M4gjZnQMGDpvXcrL0mL+TupHACqBz
         jEJFWYLqN5QxgnJJkAvrMU9yGyC+xD2SawuvukzmTef162/6OVZZvsts42EV5A7t2w9A
         MlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754131089; x=1754735889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G63QXIxj+Dtjk0K95q+UoQIrd3RUwOdJawqBP/rtSGw=;
        b=hx8wYsVelFoj/2vl6j1TfFn2aTGaZEA16s/Ki0xIpGHdd2kTMr06zOjaV5Fp1691k2
         +XKh2YeewScJDsU/UoXMsPF4YZSmqhqnYOrQNMdl68f0fGTRqbGyqN9vBwVXF45uIcAp
         7S9quHVnskYAl6sAGz9w+5ssTwoDjN+2nJg5tBf4GcR/unc53u+SvufudlVZM6yQDNpr
         kOvz/06oejIslKbURxaYUQzLEZ4ozlZVYUvndkaTSNcrUJ+2pWhEiSCPWsYWBEw1DwOL
         S/8ILliV3Y9Uh5GdwtxoWMLYQt+TsH5vPUDWKn1m2sL55WQ7+4dI5mFT5BdTZLJndV89
         OC2A==
X-Forwarded-Encrypted: i=1; AJvYcCUD1VPxPKYWfr3tqdhLq2eCi6Pmxf6n10iTI7FGlmGRV9QbeWZVJqmBluAodjcaPlnU11Ma7jwbRbnr/yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwv4R3d3t3XoTE/Jemf8IfABEsFvN460tIfcu/5cZMk5ClbDF
	4Pgm5i6ifo9Ou9a72BG+I3xkGrq7zEeMDXe6SzXvdDb2BLpdaB37/EaiAWWyrJtgIo1Jf2qVOKw
	oM5ECvm3FqYOQqSI1YcsAmWz03S0+ZUEohqBJhQ4mUvFnSPb0WNnQl1dZBUg=
X-Gm-Gg: ASbGncvk3WnEJoSL/+iL/mREyh3sYLYOpZF3yXOkQEZvfEMCKGhV6WuqG7AaL5ZR2vi
	1TSGTDYN6A/tCiKtn6R+2slkdTyoEZVS+wNIBIGWCRpW/C1yZuc7dQdP2nog5smXwMY/lcIz/pg
	mL60WGkmVoaYEfylVvvmZDx9/dFRSQgDbnZsFzzO7nXhU2JEzc9HvP6FEFB+69jdmK/T0Hn1dYW
	5+EdKGS0oiL/zsbypSBVrtN+9qYBf7s8GUHX931/KW88fem7pWwYNmyjzQrXotrSOeagWgu9n6x
	lGHM/p+rKLQegA1MjZxFgiQNjq4S1h1t0DTvtmHUfw0J2uc6m1FP0bC3ymItggv8cqhmZNK2O+M
	Q0oqdXKK5Wmy5DnCBwsaqiOXEsysD7M/I/JEOKx6959z+SO6eoRF+PK3yZbGT
X-Google-Smtp-Source: AGHT+IET2miJQcQuyN4A48qXGASFh6PFQlmTNZHqpeRrnOMmptg7WMuDBI8s0Bnz8/+S9PgeZ151wg==
X-Received: by 2002:a17:902:ea10:b0:240:3c62:6194 with SMTP id d9443c01a7336-24246f6a8famr37337425ad.20.1754131088712;
        Sat, 02 Aug 2025 03:38:08 -0700 (PDT)
Received: from zenbook (1-162-100-196.dynamic-ip.hinet.net. [1.162.100.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aca205sm63963445ad.193.2025.08.02.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 03:38:08 -0700 (PDT)
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Sebastian Ene <sebastianene@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei-Lin Chang <r09922117@csie.ntu.edu.tw>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] KVM: arm64: ptdump: Fix exec attribute printing
Date: Sat,  2 Aug 2025 18:40:21 +0800
Message-ID: <20250802104021.3076621-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0

Currently the guest stage-2 page table dump has the executable attribute
printed in reverse, showing "X" for a non-executable region and showing
" " for an executable one. This is caused by misjudgement of which
string gets printed for the executable and non-executable case. Fix it
by swapping the two strings.

Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
---
 arch/arm64/kvm/ptdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 098416d7e5c25..99fc13f1c11fb 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -44,8 +44,8 @@ static const struct ptdump_prot_bits stage2_pte_bits[] = {
 	}, {
 		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
 		.val	= PTE_VALID,
-		.set	= " ",
-		.clear	= "X",
+		.set	= "X",
+		.clear	= " ",
 	}, {
 		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
 		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
-- 
2.50.1


