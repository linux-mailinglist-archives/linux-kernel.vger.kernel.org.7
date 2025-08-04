Return-Path: <linux-kernel+bounces-755478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB87B1A6D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2491B625056
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F5526D4C7;
	Mon,  4 Aug 2025 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU8qCz9f"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825F2472B6;
	Mon,  4 Aug 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322914; cv=none; b=ZPD53zv/uwQ23Ub2QWmmP1UBC3FU7VeuHOSMa9bi3ugUT2lfRl1lDifEs4r+6xpLvMvurvG9bGCTACnAwELp1P7dLocxtKcE72dNBFVsF07GPYWRxaNcXy7ZhZzQUOlNzSqcuut1zCaI6dKgF9stIfz2AcqSmVqpArfrwmgNNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322914; c=relaxed/simple;
	bh=wvwXgfJa4cdNsv4I8ZrN0NK4JINVjURvPKkWHLuWm84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ks+urJaIWRaY8WG+TaWkpZSbAwCJrO7cnddf99EzjI3dhqedkiuPNDvmgJRfoc/ci+2H4C6ctbog3+PTu3EAiLuvo26g+m9SEeTpA8caHWjhZIp7Qn4I44tF9iNlk6IrduDl4N4lSX6HPH4ovRY8Jkd4hXTstTipXtzR7u7Vxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU8qCz9f; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af922ab4849so646248366b.3;
        Mon, 04 Aug 2025 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322910; x=1754927710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mk3OWYLSToLJRsWp5g/85e+rXfgSRMqYxnQ/kEoFIk=;
        b=hU8qCz9fRmMRXnZU0HCurgqAdf09DsIKMedIImkZLLPZ8m9miLs3ReCX9b05/NcHw1
         ZmbbvTb124HTAflTS9kdUU1D1ziIpjmj68sHM+az/dVDrtvKVoPlRdCTB1J8FYhIBIBM
         JLZ7lenGRa+dT4JpOq9UyjkgV31AUoTrw3kItiu9drMRyp9oqcnI8/L/fMU2ueB64whP
         vTzKNY3uSYWyRCJyhhwqNoguHBYH0wvbZTXI1sR5VKuQbwD6H4bd7Wfnmgwt8UQy5tka
         6i9r6dU89zwWUGcWVEQlGA3MBR6yNFlDoAO9M8tEttUZGaagR8JnyN0ak0Lve03JK1jL
         tXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322910; x=1754927710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mk3OWYLSToLJRsWp5g/85e+rXfgSRMqYxnQ/kEoFIk=;
        b=s1tunEwyreKqNL/uofDB4+8XYL06AoRRJKG7UlW2hiERfD4d1b5EFQctsLYu7St7xL
         R8heS5GuCvrQadwERNN6FO7ySq1izPtMSNvLAMqmmnijiVvz+akJer9If1w1In0e1lsu
         w6A2QsPiMRLby53Il+ftNAhpOrSKRMCd80Eg/ylSnFuOgE78vIf74D12CswTs4xFVzVo
         AEkXDsE20NnTgZawNTUwtQ56+vyteXVoEASnJa597RQIZMGLFeAqbGiKFzND8W2RMJ+D
         izgNb1DS07eILaquzYSMOW0uRAKUsMk1c/KZRk90PHf1MjGotscDMacTOLje3ZUOC2uN
         L9PA==
X-Forwarded-Encrypted: i=1; AJvYcCWCCmYQaJS5lrKhv/15Zfr8vpgBi1/Em4O9DMAMhPLHjqXoUw+A+i6Zb8ckFPzUEEh6wJDF7T9lBqb7TCzH@vger.kernel.org, AJvYcCXPU4sKGGyWfVR0WZ3efXBWtwQDjsUjoEoyS6DkHMZKyYJvg0nqgE6dCGUH92/OSs/WvpV5PVl0HsL9@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhP2Yv9lyc0A9Uz0AghR89KfuruNshphxisdIbY0lqECWhm+7
	E5B1F4v47aDyb8ZosXiaHR2kzFYEa+oqU2IxBylTtD75lVyJqsQMZjQd
X-Gm-Gg: ASbGnctjbTyaTMDPC5Skeqoc4M7ugUf7kMJ0CxEHEB1lzMJ3ZijKjp5Y6OIOJGyG2pX
	uEHu21Tr63u9XNaIc3qjEEvzZhiiJ9Gr2h2174vS3XoRywOUPHPY70gGRqoJQS1NWGWy0ZPPvH/
	bDr86wByc71u+NMmbeHjt75shz0M0giXYT/w/tQE/ebnnoFEfVxr/7ZxOJXJPliD1uwzXlbLXMW
	/sQjueqSTCpAe1g456r8q+2A2K/VmfKdnKJO1bN9kDxIvRLXk5gZwPlVoXogNMI6ML0TuHnPRh+
	fV/+mdwq4dT2hShMZYgVwckw6cGQ7edV6SAviHclQJ5PB0gN+GaR+ZsBgrjm1nQh2K9GFJ+NDd7
	ha7dPsTKBSV80k/1QHvZbaqxQby99h4o9l491yw6KKSaEYZZdEjnH/7qICSKVKEDPlxVfyQ==
X-Google-Smtp-Source: AGHT+IEQLmBUuRK724RheZWkPG7lebmyIqAtsj6RhVLdLdz6uzzGZDzQSt+B/vMM6nmib8DWWyjlOg==
X-Received: by 2002:a17:907:3e87:b0:ae0:bee7:ad7c with SMTP id a640c23a62f3a-af94022bf6dmr1097053066b.46.1754322909632;
        Mon, 04 Aug 2025 08:55:09 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a075a74sm761114266b.17.2025.08.04.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:55:09 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 1/7] dt-bindings: reset: imx8ulp: add SIM LPAV reset ID definitions
Date: Mon,  4 Aug 2025 11:54:01 -0400
Message-Id: <20250804155407.285353-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add ID definitions for i.MX8ULP's SIM LPAV reset lines.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../dt-bindings/reset/imx8ulp-reset-sim-lpav.h   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 include/dt-bindings/reset/imx8ulp-reset-sim-lpav.h

diff --git a/include/dt-bindings/reset/imx8ulp-reset-sim-lpav.h b/include/dt-bindings/reset/imx8ulp-reset-sim-lpav.h
new file mode 100644
index 000000000000..adf95bb26d21
--- /dev/null
+++ b/include/dt-bindings/reset/imx8ulp-reset-sim-lpav.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H
+#define DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H
+
+#define IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST	0
+#define IMX8ULP_SIM_LPAV_HIFI4_DSP_RST		1
+#define IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL	2
+#define IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N		3
+#define IMX8ULP_SIM_LPAV_DSI_RST_ESC_N		4
+#define IMX8ULP_SIM_LPAV_DSI_RST_DPI_N		5
+
+#endif /* DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H */
-- 
2.34.1


