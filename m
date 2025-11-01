Return-Path: <linux-kernel+bounces-881117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA09C2780F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 06:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACBE74E9EB0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 05:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6A26A1B5;
	Sat,  1 Nov 2025 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGmNCzlz"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FA1E868
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973258; cv=none; b=QcLrhfZ0WVefbRFn+JxhFa7K2mGssfUH5ElXDs1CvMMoWyaMsK/skt1D48cvp1lQZ8uoMJAgZlU9KfdSQenCls8ZwQn5x08UJ9iCAec5MF3C2L1VFdPVI2wQw4ZbZBLbnKeDvPJpYukK1r+y48DXyQ7IiCRkrYCZwrOwYymtPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973258; c=relaxed/simple;
	bh=16CUY4BHukYrONigdNf6hHwKpWDcA0Nh385BQ5R55XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVS7fOFZL3S6WhTXCYwkSvsq5ojt9zxGBecQqIK5sJM9TH+Vzs2ys/NIYRD7HOXZhxRWSZzTYEYoMApfz9Ngmtfp7v+71ir5B81BW9r8WBhhwhY3Ay0bIaiOQn11V9fuHNamwP55QmDta2FvCq2bibsgX9IErTajWOwMuiC2OC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGmNCzlz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso2954959b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761973255; x=1762578055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiw7k5BoI+E1avLBAbhUpCYSAa1PLmht1gV7sVpOsMA=;
        b=aGmNCzlzq7yYoC2K6jmqxllEEan/sdZdJHhvtVZj1vHUpGCPUv8s29CfFDD2Gs15ny
         5jVCw+cg9BgI0HMElFeZuhWkVQfGNxJXz0C3wUKyKcrIharSt5dMBdAFAsqAu6/R8515
         VKn5x6KjmnmMC8+n88SpTnPapc1se7M60tnFUxYmSZEx4wAwLuBnUP1m9xZDdiEqdeRf
         TO2GC5YI4X1+Kl+xTwODewTtU4NbYkv3q/SiQTWm4PRsg6QsGg3Lt6sxNE1RpG8dzybe
         Qmtuox+KBCJvy+fPO+y8SkGACl7ObB5ZYz6zhwEcKE3uW62k1IOPYdI+Om33ayLmgBJH
         wJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761973255; x=1762578055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiw7k5BoI+E1avLBAbhUpCYSAa1PLmht1gV7sVpOsMA=;
        b=MdP9/P47DjCaQthVo+YnTITutvru80ESKwryWR5Hyi54zf1uC/IFZfQWekA2Ehbpxm
         q23gwnQRyULGlowofY3ZCTP0ua3b5z4/aJgGvKIaII2z7u9fn+7gOtg2Rd6KP3zvqDBD
         JgHIFgr2HXM3JXgbtW2SKyNSXg8hKap8LZy1PokJNcDbpVfo40irKfKmHr12xIXX1bLW
         4pUJvptHZS4+X1vw29BlLyS9xgskPEkfBsrK+nA5LimmOuKUjxmcqL/4/cupS2EBwK1n
         GL2AAplw6rjjTBbwGWliYnBu7O+KSno+sC0RZm7N3wRMj/AmducG37CUEI1zmpq4/xbt
         nK2w==
X-Forwarded-Encrypted: i=1; AJvYcCWwaM7Ir/Hpq45C61EUFjAZyVHRnD7klUTIw/ILyWBjmPKu33ySghYWSV1qEVqStv6dXmQnmqLsuHvaWBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEc9dvqdWVzPy+HEXQ6xOvV5JZpY7AvKwObsYRoA+uFReK9Eb
	K0NB7TyhwYbcqjFTJV689b9WIiMPBzkkIVPfQ/OahkzyzMPDsCsHYkCk
X-Gm-Gg: ASbGncuuNLwA1/021InJQqxmfrkSqpCNSfVhFBnrj75IhtxgwLH1KvX1wP5iDvJ+JOl
	spvKO3h7FrhO+BpPFHzJCJ0Z31YYB23ASk8thQThvVtBgs3Rf4YxHdFdH1JBthgg3PY0YjN8Gdj
	KwkiX+bFji537dw1LFZ1yI/y2WicbafKaZG/AwolxxrIYy5mnCck3eKUyNj7HATFNWHY9cUcf/y
	syEHZG8zZ3tKHpukfBkG0Dt/jvE1kSXFShUt079CN2u4hnJqJkWjnqUjSXfi29onAG4c54SO9K7
	nXs6MEudaaFsGsj2FpioTBCeW1SjOPxRGLDg2698v5y2BQLlO4ObEHr8LOOd+ssx5BEMFYJwqF3
	wrGCK0xgu1RINPyZZZoD5k7mhwaohcpmVSorSB/x5Y782NKhWTLUVNe34TDZmyqegtKHrSwwHzJ
	MLd594z7CMdfkTYhz6tmzxeeeo6KpTSH0=
X-Google-Smtp-Source: AGHT+IFd2bk88eDysEPUx421uqVUQRIoZmTj+xtwyXu5exUwOlKOq6uKKxTjYZHf2N0IRzsbcLrjcg==
X-Received: by 2002:a05:6a20:549d:b0:2f3:b278:eaa5 with SMTP id adf61e73a8af0-348cd213c93mr8457177637.60.1761973255036;
        Fri, 31 Oct 2025 22:00:55 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:600d:690:cbc4:d4d9:22c2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8aa3ff1sm3761095a12.14.2025.10.31.22.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 22:00:54 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/4] dt-bindings: clock: renesas,r9a09g056-cpg: Add USB3.0 core clocks
Date: Sat,  1 Nov 2025 05:00:32 +0000
Message-ID: <20251101050034.738807-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add definitions for USB3.0 core clocks in the R9A09G056 CPG DT bindings
header file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g056-cpg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g056-cpg.h b/include/dt-bindings/clock/renesas,r9a09g056-cpg.h
index a9af5af9e3a1..234dcf4f0f91 100644
--- a/include/dt-bindings/clock/renesas,r9a09g056-cpg.h
+++ b/include/dt-bindings/clock/renesas,r9a09g056-cpg.h
@@ -21,5 +21,7 @@
 #define R9A09G056_GBETH_0_CLK_PTP_REF_I		10
 #define R9A09G056_GBETH_1_CLK_PTP_REF_I		11
 #define R9A09G056_SPI_CLK_SPI			12
+#define R9A09G056_USB3_0_REF_ALT_CLK_P		13
+#define R9A09G056_USB3_0_CLKCORE		14
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G056_CPG_H__ */
-- 
2.43.0


