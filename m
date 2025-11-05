Return-Path: <linux-kernel+bounces-885945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F0EC3458D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D95467154
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1F2D47E9;
	Wed,  5 Nov 2025 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/3YWFrE"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D22D77E3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328942; cv=none; b=A3pYfyV4WnrOGxuUmW1rZI4MExRAEBQ6zlJkvOPxpbyB4tiFtP/10KkxGCJQlFOAqXlXSAX+yPoSePMyJb9/ASlA5v5x1MogHohlyeKLaoZ5bCNUauMNVnGHGpfr65zGCnijhHTXcgTnWloGhPnZP8cqU2UxB9tE+SpSWDbYaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328942; c=relaxed/simple;
	bh=BmyA0IWr4hyGD3vWpVmVZJSRjcmviFzh7aQHkcg3mN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/8k6Hdma97KaIiuBlmD0c84EbpObq4YjNHRlkUwQrHcUYeOW3APgFc3aRig+LpyFldpahy1wfaa8DDeV1IOAXd3oeWq+jJM1NlIQOnavRHPJ+T/sdNV2QWDghmXS6AC/eD29G/Y5+/ltEAjJnx3IGalyUjXOXGnnlFySy73CMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/3YWFrE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-294fd2ca6acso4956295ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762328940; x=1762933740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67ZeKLSOELkdf7hZ3ElB6t0tmcMRx6X+ahqbBDAQsHI=;
        b=b/3YWFrEZ1aUTMz3CcBG1QvQV4ODeoj6tl01WN1t/iwZOrzs/R0qABc7UDU3X1nJoV
         wf0y8LWNDYNoDCgPBydW0siV8xR1VPa42Of/pu32ldZRjnVtFmYS0i5la4TG5uDzfQ9U
         au96DJP5RjxDfbz0gYY4QckKR/AqcSYl2nBBgpS2U2Hx8hcRO8mUGG2WhMjL9/Q8djUZ
         FMA6C45CKW/23qguyMEt8yzzuNEnAoQLtsSHbf/tdSeelrPY09+9T8d+izXJpJH40vBX
         ptVV47YQWodOSKpudEgDWzj1nhG5qFdxjaI4gAcjCKjMC/ER4OW0cABbmTj9ObXMRwPd
         Kmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328940; x=1762933740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67ZeKLSOELkdf7hZ3ElB6t0tmcMRx6X+ahqbBDAQsHI=;
        b=tEVeGx485dkQZbDI43Ot5OaJIncMpPETLWjRT4I/1qLDwEnKeSnR4ikUc6KckBTEW4
         58wJMuAvJNSec8bljeTcZGAzIJxmNelumpWlnxP77vzWeXeYjJBPHqZyUWdyYW9s4jVD
         a0vLW9a8XZ9mdZ6szj+ZLAxrToVhdnuPZPEv/f5yOgvGlV9y87o8ie95yfk5TaP9l6Hr
         sMnwnvFeRaWlrWNtHn38M2/ebeWLNFOE4FMuWgukcGoiXKOQRvVotXJ8EyBjQgidToFx
         5mxhlB5oQhym6pFlJOSq+WoIW7Gyyw9M9MTWVwfFxzr31sJNH9ZFsEEMdmxCl2Kosjbd
         6JUA==
X-Forwarded-Encrypted: i=1; AJvYcCWetaI3omCvOyJmMkQ4AYlSEvu6tbvNNFUk3ntDRCrQkr6WgrK/6VUPJfbe3Ws3CpWBPcZmb+H+Pjfp7NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvUY0sgGh5EJFfevy0AcvC0UNmfsV4yzgQG+fg6XKfSVw9F5g
	1O1shAQslc3yEiB6I4CSSBs5o7SkW3qSClBTvAMnXoXUlrg8ayeNBMo5
X-Gm-Gg: ASbGnctNrPpOP5ZoRxFB5IePy3YrQJuKdvsmEgjpdgQxu0bV0X8F42e3WODnflP8a63
	fdMKBiYYT/vTE30uRj3LKCjfDzDW1WJRMCJSCNZ8wTeSTQ6MFuTQ2aR8Pf6vS/Jsc4Ej9AC21hl
	6ZQwl4PO1N6ajlnDzDqr64a2AjkiWAJiYlx3uTHnxFztps6ma4lZ2Y4F31eiWXR6BU6oWmhOWu+
	9vjCA1O4i65BjGQy7ZN401XEkQSSbmb8ZmKHEmg6bwIUDzprMTBRgaiPieFlz7R12ElNYoQ3XeE
	lg+L882SUSZxHAqDL5Q55ao3EMLB1IEToKDY3+OlZtEhTl0hBKy4bwneie6zmVkC24wCTDiJMxt
	o2xlncxCKOfhuRaOoQcy3GpbYiJ+QiHC1bBlqY7gh6yRYyUXzf7C4ktV3iFgBFksyvZDZBQYfKY
	Ne5tehwQ7vwk6Mk2eHJ5setZwoJJjaUnPkcbsftaMk1+b+2jewVH+OMbjAPTx8yAEGBObw
X-Google-Smtp-Source: AGHT+IGiAjmimpFxip7tKyRV/j/iBgiRLLtxcZ9CmJII710Vk29R8WF2Yb7ekv3p05OB8NoLOiQPmA==
X-Received: by 2002:a17:902:d48c:b0:24b:270e:56d4 with SMTP id d9443c01a7336-2962ad0fba0mr31189105ad.4.1762328939942;
        Tue, 04 Nov 2025 23:48:59 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d74csm52174625ad.76.2025.11.04.23.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:48:59 -0800 (PST)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 05 Nov 2025 16:48:00 +0900
Subject: [PATCH v2 3/3] mtd: spi-nor: spansion: SMPT fixups for S25FS-S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-s25fs-s-smpt-fixup-v2-3-c0fbd0f05ce7@infineon.com>
References: <20251105-s25fs-s-smpt-fixup-v2-0-c0fbd0f05ce7@infineon.com>
In-Reply-To: <20251105-s25fs-s-smpt-fixup-v2-0-c0fbd0f05ce7@infineon.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, tkuw584924@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762328922; l=3384;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=BmyA0IWr4hyGD3vWpVmVZJSRjcmviFzh7aQHkcg3mN0=;
 b=cCCLczuqHGsz4VITljQmiPangRInHsMQ5kOIX+SUpSeApzYq1bXAEQFpcUMLeg3Y2GHhDg3mI
 32T/H45ZKvtAZevI1d8HFsm2H+S9LZ21HzIr6+ufxoiVXPJDusRY3zD
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

S25FS-S family supports SMPT that helps to detect sector layout settings
in configuration registers, but some of parameters in the table are
wrong or undetermined so the fixups below are required.

Read Any Register op is used to read configuration registers that
related to sector map. The op requires 8 cycles latency by default.
Implement smpt_read_dummy() to set correct dummy cycles.

Map ID is structured by combination of CR3NV[3], CR1NV[2], and CR3NV[1].
However, in S25FS512S, CR3NV[1] is RFU and always 0, while map IDs
defined in the table assume it is always 1. Implement smpt_map_id() to
fix map ID for S25FS512S. Other densities in S25FS-S family (256Mb and
128Mb) don't need this fix as CR3NV[1] in those chips is configurable
and map IDs are correctly defined in SMPT.

Co-developed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # S25FS512S
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index a0296c871634678be509cb30d26e18debff3066d..8498c7003d888bf96bd402694f7774bb2558706c 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -785,8 +785,46 @@ s25fs_s_nor_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
+static void s25fs_s_nor_smpt_read_dummy(const struct spi_nor *nor,
+					u8 *read_dummy)
+{
+	/*
+	 * The configuration detection dwords in S25FS-S SMPT has 65h as
+	 * command instruction and 'variable' as configuration detection command
+	 * latency. Set 8 dummy cycles as it is factory default for 65h (read
+	 * any register) op.
+	 */
+	*read_dummy = 8;
+}
+
+static void s25fs_s_nor_smpt_map_id_dummy(const struct spi_nor *nor, u8 *map_id)
+{
+	/*
+	 * The S25FS512S chip supports:
+	 *   - Hybrid sector option which has physical set of eight 4-KB sectors
+	 *     and one 224-KB sector at the top or bottom of address space with
+	 *     all remaining sectors of 256-KB
+	 *   - Uniform sector option which has uniform 256-KB sectors
+	 *
+	 * On the other hand, the datasheet rev.O Table 71 on page 153 JEDEC
+	 * Sector Map Parameter Dword-6 Config. Detect-3 does use CR3NV[1] to
+	 * discern 64-KB(CR3NV[1]=0) and 256-KB(CR3NV[1]=1) uniform sectors
+	 * device configuration. And in section 7.5.5.1 Configuration Register 3
+	 * Non-volatile (CR3NV) page 61, the CR3NV[1] is RFU Reserved for Future
+	 * Use and set to 0, which means 64-KB uniform. Since the device does
+	 * not support 64-KB uniform sectors in any configuration, parsing SMPT
+	 * table cannot find a valid sector map entry and fails. Fix this up by
+	 * setting SMPT by overwriting the CR3NV[1] value to 1, as the table
+	 * expects.
+	 */
+	if (nor->params->size == SZ_64M)
+		*map_id |= BIT(0);
+}
+
 static const struct spi_nor_fixups s25fs_s_nor_fixups = {
 	.post_bfpt = s25fs_s_nor_post_bfpt_fixups,
+	.smpt_read_dummy = s25fs_s_nor_smpt_read_dummy,
+	.smpt_map_id = s25fs_s_nor_smpt_map_id_dummy,
 };
 
 static const struct flash_info spansion_nor_parts[] = {

-- 
2.34.1


