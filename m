Return-Path: <linux-kernel+bounces-854729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53153BDF41F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AB3B505C81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747C52DEA94;
	Wed, 15 Oct 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+CQSoJn"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA652D6E44
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540442; cv=none; b=bXLRBsdGRVeT4MSlSkXWe1B9rPTb9p0ZjTn/7ZDIpJFpETLBgANXSJTcoAZZFvc31X2uqqE4GxfYL4X1inkG48A5pbnBlAA7y3bi4e9NO/U8dfRJAG95NIh7MpYl4c+vZPmx/wkPdhHwqA7sDxrrEHga5J0HRcwT0X9q6vnabus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540442; c=relaxed/simple;
	bh=F0ClBApCMgVyjID/CjFDSVUx5gSGLZfHQALoUwC/I1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvWPhEpXtFh438vbtz3DGFCqB+k86chCEPIV36H3wbJR1jAkA2COceh7Swbc9QAkIHqLPsUCl/s9iGqKWMSYhaZ+GbtvtyeHGddE6y1nyRBfGUunA8gcUYF3wc9kJQTYNy6SVg/wAltS37gSaGBtAg19XsN9BOsX7QMlf0wHf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+CQSoJn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-269af38418aso76785685ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760540440; x=1761145240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+DLV1CzXLyhsDAWia+k6Xr/YGg9OzRZzk7hbqGZmlI=;
        b=D+CQSoJni2Tzr+xgY9K9hksTn1gps1rCC1MoeNr00IM1p8wo7/YP39uRxb9tWk3Gn0
         SeXFhCefNGVQj1s8eBPedGh+jEfisENjU4u4NYRGtjXukM683xVrJWVBg9fv5wP+Zs3F
         5gsBuPupVsfZVfE8cSoYXEiW1ptKKDqRTxfpSjKdN4UFGU0FM0U+lq2oXf2oCaNuBWhT
         NOipqC6FTvtEKWLVVgX50iyn/9n5+unVNNgpqiuqQkpaSmsuvBqqyBC3VjkyoMl4QJtr
         2gm4+NXVLYdhpMbq2AEauN8ApRurx8HxyT0omf/cEFF7XsmFLNAoA4xLO50L6tLQEgkN
         J1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540440; x=1761145240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+DLV1CzXLyhsDAWia+k6Xr/YGg9OzRZzk7hbqGZmlI=;
        b=FH3GZfRp6NgnD50WpXt+uOt2T+mwNnlKTT+l9NavaE/gyxhQm0jXyUr92nIYLwpe/7
         X7avurxvDUi4R7Omw8dg8C1hMQg+JTKN5EXeKH7UxAgg4YrQDRFuUslFJD49hkJS2h/r
         +SZjzaR09S8kFSAC1eNgPZxcKelRNyVThi7qkDD896kRLEfhkLFqvHPFxG1pHvxoPtnw
         W1fboh+j1/B34YkrIusbNSkvTJQ4N3lBexxMx6N/rrU2HO1XR8y2uxgd4PZgBLQylnfd
         MziOik+ujdxh6zbwJrKeGoPDETCssTmIUuH4F3FpJO9avfdlB7JfLq/jE8eQbWyrWLq9
         +wJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0M5xEP/+JbIBPDJLh5vreiCqr9Yo7gt1Bn6fbVoijkXn2mfJx/ueiTEJCjZPaazbtQ6B//5E1LRV+yTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwvUrayaBC/t7cpy2zPopi3QCIdr+6f8HgmCsL7mnnXjaIxUw
	VHJOefDpMpH60RAloIa7SGcWzUBtf0B4XGJV7SRtz+ne2dm/9ApM+sYs
X-Gm-Gg: ASbGncsR2GR55+SpXTwKW/dN5+Gr3BmfJ0IRM5XnofCBRV2IkkWRzVY4MwQXBT1A52Y
	98zL1BW1jLTzRyLotRGLrsJLiwE5XDkNR/lnGDAGbknIOgW/XIWjVl0G5BBaa7ozWjQ/XFFkPBu
	ourAjE0rSUem41coBCXNBgWZYvNUpB337rkrZOC5jJLxYMmhHwVnjFmR1PGd8OXvrQEedUKuX6W
	i1cvRqhueYMc1xvHuh+hpyDs2YpZuiV8IEGbMJ3xYwsZR7+Rqep5gjDtAwDU9c0pXPr3EYg+JNB
	c4+vf4NaYMfoZ4MvqyaLDThirUu6Pw4Q9bNJbVrVfqJr5pf4i7h8VsAMSHocXLjKBOVJjwdCoEw
	Xoa+FVgU8TLysf+U/AA976VrrISo3QaAWdcRjvoavNCVC+oxjnIOruESYfNZxEfw=
X-Google-Smtp-Source: AGHT+IHwRZTs9TuYhczA3uxy66laQtAYZoZCfvpPr08dztpOuSb5LWAjgETrqlREdBPDLdAa8s5nJQ==
X-Received: by 2002:a17:903:faf:b0:278:bfae:3244 with SMTP id d9443c01a7336-2902741e44fmr368699015ad.54.1760540438774;
        Wed, 15 Oct 2025 08:00:38 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:f449:63fb:7005:808e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36408sm199642265ad.91.2025.10.15.08.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:00:38 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] net: ravb: Fix SoC-specific configuration and descriptor handling issues
Date: Wed, 15 Oct 2025 16:00:23 +0100
Message-ID: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This series addresses several issues in the Renesas Ethernet AVB (ravb)
driver related to SoC-specific resource configuration and descriptor
ordering.

Different Renesas SoCs implement varying numbers of descriptor entries and
queue capabilities, which were previously hardcoded or misconfigured.
Additionally, a potential ordering hazard in descriptor setup could cause
the DMA engine to start prematurely, leading to TX stalls on some
platforms.

The series includes the following changes:

Make DBAT entry count configurable per SoC
The number of descriptor base address table (DBAT) entries is not uniform
across all SoCs. Pass this information via the hardware info structure and
allocate resources accordingly.

Allocate correct number of queues based on SoC support
Use the per-SoC configuration to determine whether a network control queue
is available, and allocate queues dynamically to match the SoC's
capability.

Enforce descriptor type ordering to prevent early DMA start
Ensure proper write ordering of TX descriptor type fields to prevent the
DMA engine from observing an incomplete descriptor chain. This fixes
observed TX stalls on RZ/G2L platforms running RT kernels.

All three patches include Fixes tags and should be considered for stable
backporting.

Tested on R/G1x Gen2, RZ/G2x Gen3 and RZ/G2L family hardware.

Note, I've not added net-next in the subject as these are bug fixes for
existing functionality.

Cheers,
Prabhakar

Lad Prabhakar (3):
  net: ravb: Make DBAT entry count configurable per-SoC
  net: ravb: Allocate correct number of queues based on SoC support
  net: ravb: Enforce descriptor type ordering to prevent early DMA start

 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 30 ++++++++++++++++--------
 2 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.43.0


