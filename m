Return-Path: <linux-kernel+bounces-720649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD72CAFBEBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFAB560C57
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A07D293B46;
	Mon,  7 Jul 2025 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar4BWXkC"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BE28FFD0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932008; cv=none; b=cw+/bALuviB3j2iVhE5YMOgLpmuFO73bPNtwIEY0vitRNgdxpBOHC1KY3rlw9XoUzDo629J3SQz+/mzTk2q08WLJhN8kItjVoLQ49Xk0xgoX22c7xH6XkSs/1ACFn6G3b85muUOxl/+dU7IGhWv76jPe/mKsHApb0Cb+Zs7sVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932008; c=relaxed/simple;
	bh=o3FVkmysu3tJXsHOQ6TCDKU9zD/cWySQyVScEurxVxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UcT6MCCP0UrjtWI0LupgW2kr+YgdeuIvmFGOZWPo4WdSPC9xxZyL3n0XP1RavYGVyk5IuKZip2akkyDduIKXLfFHUdk4YcKtq3RP+l11SHzNEyfnbJkzQqsjAnoEv2u7pIxfpqgwN7nhdk+bUEUZq3BspTmNx5EC9Xy9qd8pcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar4BWXkC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae361e8ec32so755678966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751932005; x=1752536805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XPk1root0WuK7dRHLh7WX2PMH42V/Cq4joNrRdgfqU=;
        b=ar4BWXkC5480Fxfxs2sSKCVdVMC9LdypDaYOIJo9O5Ux1bYgk5tzqtv+Kj9J85uA5C
         ooBYQlQI1LJtvPAy0cSH+gFpeF3bYqxd2nSHi7D0R0lzHGJTgQTE8TCYRxaRWFhpjygm
         6xcdo1RjedOROXO2FeL1an3qKlVd711d6RUvpzyd3Y0gD+xkd0+/PNATBwdGAHTMFbUN
         pOWRoYR1v5WzAAglqFvko8ej/k4dT74IIplhpZd+tHalcq22dgZ4gQBpnfs5RHSo0TYk
         5LRsRj9HwJ6Bxz7c0K61/knQ1nuXK5YDwszP2AQqVZ4loTIbUPxO7B6Jkud4hq/0INDJ
         vgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932005; x=1752536805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XPk1root0WuK7dRHLh7WX2PMH42V/Cq4joNrRdgfqU=;
        b=JfvmmdVqgnAY0dJ3sX7JflgLI3OI+3DxzCnxc1Agg5/IgHGonrPw08ec9aihwKeZnw
         A+v2v/6NVFLD8uRJVbMQAW648OxXhguARCBZ7ya3KwL2dj05iFvfq4+I73FLIxubn6ed
         CeG4wC1FR4i/6n9ycsTdxgDZjh7eBFsr0nZM3tebBfnnZHtP9t6f6D3V9lqhJGnk5PoX
         hls1WOi2JVcj+bOp3QMzeZ56vcMe/YnVfmr+ku+Z1h+CkIt9//RIrnTNhF/yBspJ6+qY
         4t7LTQIykUHQ9tvA5fVwE9pvJezNGFc8PK4yIoPNFm/Q3Hlrt7tBJ2qggQtyQmAUbALo
         B/mw==
X-Forwarded-Encrypted: i=1; AJvYcCWHNLI2N3HHrybEZb0Ji7tG5LajiOzERou3oHBEvMi4bdTezn5JEpjD/ves3JZEqOn4CknOwt/P2bAhgC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6Twgh0rhQD92Z1KePR8G+R0LyTF79lnkj/Ly0jzY0eo0Uu3X
	9CbBbsGoUatIYVWrHImV+32Gn3f44WYfxi+xeCh/YijQRbCnWWCe9PbQ
X-Gm-Gg: ASbGncuqcJfsvzoAKqng3vT14yESbfSh+XcP7NGkggk2wieyRnRtXGdK+lXfcJt5kdZ
	/veLK2M1zA7teTsPmrUtiBrHtZdq3KoFq60ka15hpF9cMgsNTT6EW6iG7aV7GGACzwfDAw49ui/
	uyjqggKS6OSkA7CBcHVhD3rQNB5i46WdGWb8aPhQDhBqjRs1pMqvt1ZPxm+4LL4GS1q5Y/yDdyH
	VxNslPoYB5R8H/irdMW2Bl8l26xVUbFkY4V07N+ugfLdUz8qXgDQif35Hi/CduouixljmUZCwnq
	irAENh66DX5F/tdclEnjaq0BPDA/7qbvA1cEW3gwOJixa2SkE3tJcv/KApmQEEmHYl22aVsDfoq
	VolXXgmQXe4GyhRQbLkWbv9k=
X-Google-Smtp-Source: AGHT+IHg/S+OKZXPbczL7aJL0lISW8YY04z127Xz3XTz7Zqi0kh9ari/hi5JHoRcoVlD1C56s6ePwQ==
X-Received: by 2002:a17:907:7293:b0:ad8:9b5d:2c1e with SMTP id a640c23a62f3a-ae6b0ddd818mr93226566b.29.1751932005103;
        Mon, 07 Jul 2025 16:46:45 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d1ae3sm781539266b.7.2025.07.07.16.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:46:44 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 2/2] arm64: defconfig: enable i.MX AIPSTZ driver
Date: Mon,  7 Jul 2025 19:46:28 -0400
Message-Id: <20250707234628.164151-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
References: <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
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
index 739b19302865..4d7a60444bf5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -262,6 +262,7 @@ CONFIG_GOOGLE_FIRMWARE=y
 CONFIG_GOOGLE_CBMEM=m
 CONFIG_GOOGLE_COREBOOT_TABLE=m
 CONFIG_EFI_CAPSULE_LOADER=y
+CONFIG_IMX_AIPSTZ=y
 CONFIG_IMX_SCU=y
 CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_QCOM_QSEECOM=y
-- 
2.34.1


