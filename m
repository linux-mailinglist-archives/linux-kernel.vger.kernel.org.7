Return-Path: <linux-kernel+bounces-779565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33CFB2F5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D8AA7A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7148A30AAD4;
	Thu, 21 Aug 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM/rPNU3"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A93093BC;
	Thu, 21 Aug 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773809; cv=none; b=F5F58BtWxtYyq9oCA6IH/6xxZ4ihBhKeRsaLDLTQVm+4Wm/t0HKBr3pvM4fYATjw44oShVQvec0VGQHvX6WDwGfu5d0BrVzFJ/Jmm6PnZVxQ4zwhc2gq+m7uwhMirwPE+cxanqDak5+ql4JHnMM52cOaKcJ9FFYL9z0FRj6vqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773809; c=relaxed/simple;
	bh=GfUzdHKNLuUCeROo8QZ9Rj8Ue4x6+JxUEAvaTCuZi9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYyaS7CgPpYfWiiUBv3vaIhjZR+jhwXx67V9qT1MdaoK98f4IftaLec6+K+stosXbxDwXVslCauDZyUDQFPuRQ9EXSXVLmTX8z2IGHFwV3p2NfBWRJwugQpp797Z20PzafPcxATiNCZ85wfFRG5rAeTvefunOFJCOM7mki2Ebls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NM/rPNU3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-618b62dba21so1223969a12.2;
        Thu, 21 Aug 2025 03:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755773806; x=1756378606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEM6zRrG0wrRh1d0tdQzRRFEwI97+Is2fI98UBxa5F0=;
        b=NM/rPNU3Vr2aqkSBwIfvPXYaQVwtaDTpRD4ahCLoLJM/rrffLTiJEgno4OfHlj+59f
         A5zjGqMcfe15MZNcbhwSRy/FbD/c5lqwppRo1MVBEKOljqYfVkMyywfuygithla9IH+h
         f7Bc/E2zi/x4AVBexjjbryxKdVAcrvCGgeXLyDFsf2T4p0JpczHlVF5CVh2BLhy19tgH
         jFQ/4PzABq5TgtYWlQFQggo46Ut0N/80L6OmtSLDN/l4X2t9YXMpbn7li0m7oW/a8wtl
         WrDgabvAc0W2Zwry5XT1yE0lK8nHbkw3QTWGZJ/5gCPFOU69KJBusHjgbbhB5OK7Sx46
         jGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755773806; x=1756378606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEM6zRrG0wrRh1d0tdQzRRFEwI97+Is2fI98UBxa5F0=;
        b=kH2fnri0udlxSNsw6dM1YfRo+TvVIIvFpTPEJFaIZY5QRuOer/9QNmGvcmsy5HzyvT
         Gg5KeHmjTNC0vSIK4h11QE0tccWHVucm2zWqaBvFKVw4rK2UXRfk4HLve8DIiPx4cfhK
         NweLAovJpQBeYcfTvv0KJqvBSzC3213hl9HJ7x5uNPBOv7bVpXLUMsT4fattKeswjg1F
         c6KWebTEV5EyL2pkK92DfcDw9MLggghaOMQr3+Tn/xQ/EpU+QQO1kpfsTTD4Ej+kAsNE
         xtn64FikvNxQBtzgZyzmf/Ub3F7bWfoYnBzZoI3geQ/3bvqSndmRqBt1r2PqlbH16xZJ
         D5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa4kWl8AGHvlDrguFb/Evp790l069O0XPudhTvwYY2vpNsxVJnsvw0+eDSqegydUPmMgcjxVViXZHUjyNR@vger.kernel.org, AJvYcCWkG+S/rV2ZmzEwH1qvd7zMnEfihA5dE0PymFm4SDtF1GaauhbI3fFCEokN61h+mz8GI3oD4PbiJIeI@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXwT/z6V60A1P1XNNuQ8oywpNwmTkDXOqTx1Px7OkUXJJt+Db
	A1vYypSox3Gcv33t1e9wY4+21HqCjC35Pb8jxI1/ZT04iTEsM3yryw6u
X-Gm-Gg: ASbGncsrks4nWPpQpjVG/fDz3c4q1oYzUHSmKXk+9r4bjbt9DGNoD5jfVID8O4vBLCs
	GW+slaHSelF7/UMlqHpM+yR49DA84YUPjr75gA1lQ211HrBLRYcisMcaenE5RLUhsQEwzUCTQHd
	TLPgypi6c5DsBB4wtlmR1W9SeoWnlf/KZ+Oyc7s303NIvRLwVvvjV2MMFaP7P5FmV6NVh1jbcOv
	Wg7nl/AvUf0LUeHOsXixD0NRU5PRZH7uLIVb7UHWdzv+WqyDESn+azDCcQl4+Mr7+JL3LhqnFJD
	cxl3/7OMLXvSStk3Yv5TgUo5qid61ELfFd7+YE0cZ6oq4RTf3QppjMar7X2FrQp4Fa6JRf7gggy
	mHOV1dB+Gld+Am9Eg2QOOCHIUYpTvHBlfMmag6lAjmzyzNPrhR6OB
X-Google-Smtp-Source: AGHT+IFVorh0obeXbG1Ko6UmVI+44XxAfffiT2uo5FSHfTA7gezl9y87WX6WaAGvvAl4Gewp22sq5A==
X-Received: by 2002:a17:906:478b:b0:ae0:d332:f637 with SMTP id a640c23a62f3a-afe07b3d5bfmr194996966b.31.1755773806255;
        Thu, 21 Aug 2025 03:56:46 -0700 (PDT)
Received: from DESKTOP-TTOGB9M.localdomain ([92.120.5.3])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afded4790bbsm373602866b.56.2025.08.21.03.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:56:45 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: defconfig: enable i.MX AIPSTZ driver
Date: Thu, 21 Aug 2025 13:56:31 +0300
Message-ID: <20250821105634.1893-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
References: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Enable the config (CONFIG_IMX_AIPSTZ) for the i.MX AIPSTZ driver, which
is required for platforms using the AIPSTZ bridge (e.g. i.MX8MP).

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 667c4859ecc3..23ba01d37263 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -264,6 +264,7 @@ CONFIG_GOOGLE_FIRMWARE=y
 CONFIG_GOOGLE_CBMEM=m
 CONFIG_GOOGLE_COREBOOT_TABLE=m
 CONFIG_EFI_CAPSULE_LOADER=y
+CONFIG_IMX_AIPSTZ=y
 CONFIG_IMX_SCU=y
 CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_QCOM_QSEECOM=y
-- 
2.34.1


