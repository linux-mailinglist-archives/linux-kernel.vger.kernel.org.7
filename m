Return-Path: <linux-kernel+bounces-798464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC087B41E53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71955E29C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A142FC877;
	Wed,  3 Sep 2025 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUW/kbsh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C52FB96D;
	Wed,  3 Sep 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901167; cv=none; b=I+rwPR+7guBPx44YrL+fNcGjGluiX1uJGynGvNgZl0NbiPT9vqdmfME/PbgY2xTp42FTcjuKim5iGNTLhouYHM/OZDuK2asqrKWrXT3PMH5x8E9UqL2/DiXc4thmNrbB+e1jRvoiHNaMz0JWeLjD9OD0Wc3jGd4d5IKLVbEzF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901167; c=relaxed/simple;
	bh=66t/hFShHFdZCIhnoWs3mWNOD8M5mug0LH9Pl3buax4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PC73GZo5t5cKh9Unu+0d/AP6q6uaucvufo0gQaQHVsJIq94Pkpr1DpmoReZTGQ5AS+1dVNtGpTb5qaHKGfQMqEIBmHSFK3CbP1uccxKN3k7Ox4MbeYMXpM0/Z1LF0VBneLSlMjE1WFfltojTlwqB2RRH7vcsEzBS+svJZbhGaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUW/kbsh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24c7848519bso12009165ad.1;
        Wed, 03 Sep 2025 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901165; x=1757505965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5iEAlc4MoMtFJUAvR6dtjmQqf3jvqvKGSuRvb2CExE=;
        b=CUW/kbshOAxBgobgRf4beMas4JFELigQZgYw+MELldZRsWE3nTGMwyu4smzRgYxnm0
         LAmkG/ymJtRQBOgRS12dKIplo4XQDRD/o17wa7AZawlSloksW0LaWWV2owR3lSaX97UH
         J0S6oHRILy+tZwhiZftExA7hfYUY91v1qH97OjT2p+4ec/Y9zJtb832KbEGxE8WjOGGD
         pV8WClLto8nJ4fkbxkBPcWsqAw8OZkzxu9Cl4vO1PL+acZ2OyrbrmFnUgv1RuMhPxP6u
         w7MHWILLxEnYKPAO21UHXG1Lw8bjwlWd6Yt4HFhptAunZONGBVNCiIfMdCmbItYJ7d8h
         yN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901165; x=1757505965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5iEAlc4MoMtFJUAvR6dtjmQqf3jvqvKGSuRvb2CExE=;
        b=eHDtlR7IDUlNxCQco9mDnNpKUprd9j1Zx9W+EwMGpAU6kt10pMi6J/L8SFP0mF2s1P
         eiMVqZYuuro8vg36g36OK8tSFcWBjPKckpQGI1HMygWh8Ygj9afMxvESMtuPSQSF1jb9
         Ux1UnpXSNC8LrTuFaip1/v8PzALfZrV2dnTZcaBRctCbdipgtrt4Ga7v70CLyH24w77J
         dRMIfDmE5wVKW29of11LaG+nV/FVgE1v+MCc/AhPD/t/znmB7JHSQNLue6Pwtk1DYl1j
         EXZry3N0liKLjCPrwVd/PfOUUbJyJh/TJVeQEtOgRVggD3HieqKEYgHjEQswfFzgfkDh
         XZiw==
X-Forwarded-Encrypted: i=1; AJvYcCVhT18ey2OsO/PYxKVp5K18ot5l2/xlCm2z0QLtVTJHa5PH1A3cU0XBmHFTHyo2axHxjAKx3MHhOvj0sQdJ@vger.kernel.org, AJvYcCW/MXRUBsnLZUH9olspnM5ULV/L+msyzlrzctAf4an40wUGvmkp1jwkKTTEAU2rnykDzmI1Xjx1g5jn@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdRG70Z8uPOxs06Hu/9qHr6Scqp5jH+RWGO8xJlrfg2VjOYKy
	g3XgqSsUCe8UxpPNFyDSWu6pQCNfcJ3Cx3g3y8o/o4W2k/ll8BkKYYyY
X-Gm-Gg: ASbGncsUaazCTH+sv9CHTMR1SChGj2eb78gl4BG5EOE7lk+DRyLqznbPu6FYY9vTUek
	pQpt5uhVdN3xYZwr08twG8XiCprvAPhL6I7kVSR0ji4cPnr7GmrTqBgsrQTUtxdc6X9Bvcn9vhT
	qsDdK+yvE2zVA2O6+17zzgI2Jgh767/ltfujibcB8hyx+2M65bAl1XwDnJ9lqJXqVHgW+wcpryt
	uYTA+aF9FJXlpvoCxrmAdctbz5mr5fu2uEFUsR6448ldUry2Svot93P2wanaCmznMltG4xDj5RR
	NPVJOIlJHZih1YII1CdKj6QxOlPR/CUqOQOXKZbtubJDmsnp/fKbcTzZHya+a9RTVG2nh4o/lkN
	pE6Y58MzkgrKdq11SbxxXrYzJnVoT/6vnHpbeHlUf6+qSELJzKor7Vbw5ITJR/dWPclx27jrqMH
	v/rFcFYa24FHW7bkNGnlFaE37W474+Jw==
X-Google-Smtp-Source: AGHT+IGmOK+zU4uhlF8L1/G5THkM81+gGkxdGDOsluSdhqpOhIUayM/TmHmVlI5g8VrEuAb6A/4e9g==
X-Received: by 2002:a17:903:2383:b0:246:570:2d9a with SMTP id d9443c01a7336-24944b1fc6emr204959945ad.59.1756901165063;
        Wed, 03 Sep 2025 05:06:05 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm160905185ad.109.2025.09.03.05.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:06:04 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com,
	Jason-Hsu@quantatw.com,
	yang.chen@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v11 0/2] Add Meta (Facebook) Ventura BMC (AST2600)
Date: Wed,  3 Sep 2025 20:05:58 +0800
Message-ID: <20250903120600.632041-1-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree entry related to Meta (Facebook) Ventura specific
devices connected to the BMC (AST2600) SoC. The purpose of Ventura is to
detect liquid leakage from all compute trays, switch trays and rack
sensors within the rack, log the events, and take necessary actions
accordingly.

---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
v2:
    1. Modify email content.
---
v3:
    1. Add mail list.
---
v4:
    1. Apply git send-email --thread option.
    2. Sort nodes in the dts alphanumerically.
---
v5:
    1. Run scripts/checkpatch.pl and fix reported warnings.
    2. Remove unnecessary 88E6393X CONFIG FRU.
---
v6:
    1. Add a new stage for the DTS change.
    2. Run scripts/checkpatch.pl and fix reported error.
    3. Fix the issue in a separate patch.
---
v7:
    1. Fix broken indentation in the device tree file.
    2. Sort nodes alphabetically, then by address if equal.
    3. Rename fan sensor nodes from 'hwmon' to 'fan-controller'.
---
v8:
    1. This patch series has significant changes compared to
       previous versions, and quite some time has passed since the last
       submission.Therefore, previously received Acked-by/Reviewed-by/Tested-by
       tags are not included in this version.
       If needed, tags can be added again after review of thisnew version.
---
v9:
    1. Reordered the node sequence under i2c5.
    2. Added a description of the platform's intended use to the commit
       messages.
    3. Added 3 GPIO expanders to i2c10 and defined the necessary GPIO
       line names.
---
v10:
    1. Added IRQ support in GPIO expanders under i2c10 to handle edge-triggered
       events.
    2. Reordered the nodes.
---
v11:
    1. Modified the position for i2c3mux0ch6 and i2c3mux0ch7.

P.K. Lee (2):
  dt-bindings: arm:aspeed add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1578 +++++++++++++++++
 3 files changed, 1580 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

base-commit: 533cec246f7f0ccadd7d9fb4e664d38418633c6 
branch: dev-6.6
-- 
2.43.0


