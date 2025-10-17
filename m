Return-Path: <linux-kernel+bounces-857502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C18ABBE6F86
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50279504D35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6923AB98;
	Fri, 17 Oct 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8EQN41r"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AA1A316C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686824; cv=none; b=evJfOGxNRi3ze+/HvJcPHTVtHnBMrBtuuU71pGSvYWq4Uyqx8r4GvaffcTX12g80LuRrQ87kzAQ6ORqhSlVF7P7kMPu6XeanFVjaMAmF3S6UZUoi4hyxVNARRR3iMTS/LukcBuBgwWLxhuzIRcZTUe209uKySXqDJi07YKc1nlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686824; c=relaxed/simple;
	bh=T5p4ysugil+bNKLSR6F/8xllg8Tu9eWt6vjkSEyOVcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=im2NpYyjSfgqpbtkcT+dGuOe3fRw+F/2tfNwFc9ivMHViJ2YT2YWzMMNXc+5WHsc28t1Fe5xlCg2/fcz0V7BctC8d4WcQWVICy1Rutm9ONvQaRhhzYEPUl3lDBGqjxZJ88itGE3OmGSywrCF4tkNSX+Yf9Mzw80hDO+DlgnkvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8EQN41r; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33067909400so1277460a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760686822; x=1761291622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bx5Txy8og/O6i1T8MIDUUZY/+F2oP8HDFFEoUUoKHk=;
        b=J8EQN41rGoTwkw1P4I+j09pSZ6i4toVPuIW75BiMEjTn9kHx3i9eByYJ2UG9t3MDcG
         +sqJxUSMo/nMllNhMFK+722bJz9Rx6bh38EmBOAMDlgAb1us3xcOePZA9y25wGlbyozk
         bcIDkx8A8ukp1YI7MLWZC18FGFyKj5qVCYqrxgEQc9wG6nyE42tugxfnpN/aYLhBrZoJ
         IADBbI3JYsJ4vYH57fGgAwIxqg1iAgH39WAl8M00+ZF1n4UEw17/1JBcPE80zURzAt75
         Q++P4aY18jZ+VLmb7ZnFIE+xreI/wyqN7iQ7XECs3xAWCGFk+uhJR/NUva6D01HoUwjL
         AjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760686822; x=1761291622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bx5Txy8og/O6i1T8MIDUUZY/+F2oP8HDFFEoUUoKHk=;
        b=Jzwg4XEzBxOjPQMOTEklgUDkt63U881oMBEbf+0+/frTAalsadLOGpTIbohSLc4fWX
         HcG0G/90fuabG9Fw8+IqIXcP6mdicVnuDgAeXFZyqS/jnnS7WGMwAJxYKov+EdMuHNXr
         BoDWlfzUzTF5tq25Kvq4ntSufbAdjGBqaJ5TmUKTtm7nQzgF4CH1v7nHqrXyGSMZXSQN
         VjPkzQLt+8HF9NVUKkP2CIT7bynvMTQ1cdmutMU5DJIUqiISa7rh+eqM0c8aWRaFPkvy
         JDoXP42NCGpwhqkLs53yGhMjLn8tZz1It3OgINQfKOVwjwvTdOw1fdrAXZovrxRVPD4N
         X+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGcwgNa3LjV6YDJZBWhNhFRVxOyuOiZQkrtJYC9KQg2t+8dpBL3DRXz2CzZWA5AFIgfgXjS0mkV91uaKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoH7aAQve/Vi/9jgkGwV6fcaI2/sVM87+gcJR2e+uxNEgPW4K
	55+Sg9Phbz9X1ZHflIsQPSOuS6FiO8x5NnWXfg+3VpLdhxE7BYQ1xE9W
X-Gm-Gg: ASbGncvQzuzSJDAtS7k0z5qe/6OUC8sy41OXjxQoO0BsJq1HBJQg83GCizDGShtYJqz
	WfL645MYEeanP5ElR8J/pUt3PH8RjK7wzcGd6GTcosukhBF9F0fpgu+sB6d+abD9V9RZUWYu17a
	zuceKAEYmEgbCBJWyQMlMTkcbVbv3A16fBszDbqMCycr4low7FvfM6mMxzqdOPXoN7GtHVDAuUR
	7G56L/YfHkx4D8Lm+PCMvSG9Xu3P5SwGERLm7rlc4Zvlfse/hViFGkpb2nnUx+EvDGadm9bO8Ie
	v5T9I7eJ7wR2FqCRa3jjUY46baCdNo6PIrpen3J14nBdARQMA5hiqcjkie+0P0B7PFEtVFLC79/
	UA1Xm+/f8LsC35cEbNaDKWKc5yq/hAbgCi2B16LTuBdczKKc6TxIGbig9FAh0F/4=
X-Google-Smtp-Source: AGHT+IE5Wq2LSw/8u7zxDPAEAndLC3TWgGO8LMJfU4cDrcRHWlGtfWo/mBTgBjACKeby5RgogHrlvg==
X-Received: by 2002:a17:90b:38c7:b0:339:d1f0:c735 with SMTP id 98e67ed59e1d1-33bcf91e032mr3105311a91.28.1760686821347;
        Fri, 17 Oct 2025 00:40:21 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b3173asm1879479a91.12.2025.10.17.00.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 00:40:20 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Grzegorz Sterniczuk <grzegorz@sternicz.uk>,
	Tianling Shen <cnsztl@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6 with A3A444 chips
Date: Fri, 17 Oct 2025 15:39:54 +0800
Message-ID: <20251017073954.130710-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>

Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors and
corruption when using HS400 mode. Downgrade to HS200 mode to ensure
stable operation.

Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index fafeabe9adf9..5f63f38f7326 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -717,8 +717,7 @@ &sdhci {
 	no-sd;
 	non-removable;
 	max-frequency = <200000000>;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
+	mmc-hs200-1_8v;
 	status = "okay";
 };
 
-- 
2.51.0


