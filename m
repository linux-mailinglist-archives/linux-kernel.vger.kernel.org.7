Return-Path: <linux-kernel+bounces-885942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F46C3456F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723A34EFCCF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB52C08B1;
	Wed,  5 Nov 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq1lzSzV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0F287511
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328931; cv=none; b=cgbIvyDN7AieLwxf8ZHHC11FJONEFxFu86501DrNhcNYrb+PzcyMTK3PM5K/ikn7egbpM46DVPxaQcTVDPWwQWeioUj3SEp1tigJ+Q3cvjf4sslX+ObRIseBlyHmIMTFjWU+TmgpzgkMZ0AYb3y0aJyLWdWUW8Ot2fluc07e/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328931; c=relaxed/simple;
	bh=NOKQIR5btRps3wC4qpEiz2d9Wi7VoS6HMlLpi4LAbfI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P3jeB24MPZjFqIoFF4YlFuRSSWiiggk3Plb+z//G91vor0LhmIjd83SeDjH8Em6Ii7DYgrkCgEoPDwE0qebazUJrkcqdx31UXGGS6uS0wmu+yadM/547nyE1mfVxHPitoCcu9JoljnkpWCYOUt/SMHAzJqvdrQXeGPhrJK0cvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq1lzSzV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2955623e6faso40617235ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762328927; x=1762933727; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uL1GP7iRekfu70kjpjjUo5sATbjXbXDsppPEJx4S9Ps=;
        b=Zq1lzSzVaRLlrLWuibF+ZZPwucnRFx5w8qRKuAIKcwdOw2vRUqQv4YG7FEIWHHFmfU
         cpXxqhjdvDDIshOSaUDMJc02D2NniHPsTv3tyBwY5Mi6eOsdw8boXMsIycg8wd3ah7o0
         7EvbhcoGqcaE6edmsmv6AkFN1mpVb0U34kuuLnDvsC2tvMkAofvCjYNrDLppdmWjXB/d
         ePERyss944SlFnGbdkD95Lspa8Lw2WSzdj3U2N3O2DU2MoxAxLAqhaPDEFwW90Xo1bS9
         KsO8ZeXw4cgo+p+y0Lm9KHsmGbL276JWfW3uOlYHSLpv4u7arnLfLWCSBvDtgUb9yoUZ
         Hmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328927; x=1762933727;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uL1GP7iRekfu70kjpjjUo5sATbjXbXDsppPEJx4S9Ps=;
        b=of6MSC1fWGG1BMTUaIpGcWzrDeLi2Rh6MfrTXinPPCqbltmKPiVziytV0bvb52/B0n
         rrXiFyOucdmq/BWf+nkrSOI9V09BSv0HwzRAJa5NhbzcQjuRnNrIYFDnn6/SN9hwdDVY
         VBjszkSIQ1og74s0R2xnt0T3+Cx51qdUtaaTY3uiv4WAvQIDSGd6G0VfHgmpD4K97J7s
         KxuFeItHp0jLPiL/KEZ2vr2RKT4xZn5V5NOBPGBfJnSCpU+GXrWY8QtENrbcalE2Tr4E
         EZVmFGw5/NrIHJ+5zmrxbBl4citUSu+T/1Yus7TD9pdKBh1lZbQlRXEcznzsKG+oZ0uq
         Wqig==
X-Forwarded-Encrypted: i=1; AJvYcCWeaB7FUNi/k/YKgcPnC+fufr5I+ZV0ZOi3oBqt2EVvr6/AhxaAYwPMJylDDe4cutD734knFQXK/auapgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMD48HP7+UKcAMgVwBatl5c9CTUHZgA7iXRkHyf27ixGo6hOyM
	Xie0uD/9k1w+PZNJuFpHgTD265FJQrH2F1PSQ6xD4vVDTxjzKdePd4S2
X-Gm-Gg: ASbGncsHXKMJ0cXQpF3hkAoeV7R6kDYpOlxsTm4ofW0pxjbXvSaHwXj6lL/53VZu2MZ
	UY0QU1dUFU9eDtDZGE7e6gVYTkvPyHR0SyVKQr6iFgfvJr1FMR9l6jIX+m4ow69Fp7B2YtwBTte
	5D/ACgbBjzdvO5aC9ZMYU0LquaDUHterVma7XVXLOtynURGDMqOB5SOBS9/4ke+XEbA81nRSSq8
	DlzlyXdHNM0Tid7aQOYQeo62HKjKhBQWUy87t4HTUngPryWEskD4Z5AMd5LEZyUU3dwJB/75W2I
	MfcJii5DqovgeWt4FaT2+M/CSaVUQGhBg5nlrqZ3rWz6F8J5Z0j0r86eiNWM93NmU7DJ/gSNh4S
	OTY/vU2R2dP0BOj8d0dKPnxD5K/uQqIG6UbIxFq06zTVHmotiAEpks6hHLzIxBrgyrhn+mdW2If
	XmhTPnoTxhTJg4SybC0k73ToMma54cCTLuO3Jp8MKHcg1hFC8fbRqdBkqekyNZnYrmPqdk
X-Google-Smtp-Source: AGHT+IFOFf9xTz6pOGnc531uSNVsJlw5qCZM62WsFSgEWlN8iBURroLwLvev8uSaRoieuDIvDc10Cg==
X-Received: by 2002:a17:903:2f4b:b0:295:5972:4363 with SMTP id d9443c01a7336-2962acd5179mr31353655ad.0.1762328926879;
        Tue, 04 Nov 2025 23:48:46 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d74csm52174625ad.76.2025.11.04.23.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:48:46 -0800 (PST)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 0/3] mtd: spi-nor: spansion: Add SMPT fixup for S25FS-S
Date: Wed, 05 Nov 2025 16:47:57 +0900
Message-Id: <20251105-s25fs-s-smpt-fixup-v2-0-c0fbd0f05ce7@infineon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0BC2kC/32NwQ6CMBBEf4Xs2TXthgp64j8MB2m3sgda0iLRE
 P7dygeYOb2ZzMwGmZNwhlu1QeJVssRQgE4V2PERnoziCgMpMloRYSbjMxZN84Je3q8Znb023Gr
 T1IOGUpwTl+AYvfeFR8lLTJ/jY9U/9+/cqlGhZbq4WrX1QK6T4CVwDGcbJ+j3ff8Cs8yctbcAA
 AA=
X-Change-ID: 20251022-s25fs-s-smpt-fixup-dc97e81574b1
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, tkuw584924@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762328922; l=1086;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=NOKQIR5btRps3wC4qpEiz2d9Wi7VoS6HMlLpi4LAbfI=;
 b=wuqyFyHxGCoOUHn9gt736DIgiDoFoalQEsyffbImu0RTyJ0w1rF8XT/+LFmIsICZKFKbASvVx
 ZNl3DmXod7lD8GIFHRlitRPv7XJZOZkA4geWD1W0Bb1xkJJep9TXJBA
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

Suggest new series as the result of discussion in the thread:
https://patchwork.ozlabs.org/project/linux-mtd/patch/20240914220859.128540-1-marek.vasut+renesas@mailbox.org/

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
Changes in v2:
- Update commit description in 1/3 and 2/3 patches
- Update block comment in 3/3 patch.
- Link to v1: https://lore.kernel.org/r/20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com

---
Takahiro Kuwano (3):
      mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup hook
      mtd: spi-nor: sfdp: introduce smpt_map_id fixup hook
      mtd: spi-nor: spansion: SMPT fixups for S25FS-S

 drivers/mtd/spi-nor/core.h     |  6 ++++++
 drivers/mtd/spi-nor/sfdp.c     | 30 ++++++++++++++++++++++++++++--
 drivers/mtd/spi-nor/spansion.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)
---
base-commit: 17926cd770ec837ed27d9856cf07f2da8dda4131
change-id: 20251022-s25fs-s-smpt-fixup-dc97e81574b1

Best regards,
-- 
Takahiro Kuwano <Takahiro.Kuwano@infineon.com>


