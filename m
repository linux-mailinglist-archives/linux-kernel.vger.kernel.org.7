Return-Path: <linux-kernel+bounces-836231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E9BA90F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D864D189FFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7F3016E6;
	Mon, 29 Sep 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtGMTRWB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D230102C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145899; cv=none; b=hstQ35xAki7GWa6YRKEdku461m5JhrksD3ONUN/fjCgbgCKPU3zE3naVdHRbPJSgcFCsR+MSbnvW7yU1Qy/GFAZPpYh8WeR1mFFdOVN8ms0GIy5mQhMT0v7NjAkYK4fSAKyJsyCDODhUyVhxfWaB8qvaKD/iLY5iaBCABfhjQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145899; c=relaxed/simple;
	bh=6sa4dBlIVtXXSWxWD+PhcdWd6PIrRysSNnN6dDj8eWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K20guM76mKz6HoQVenF7QbmaLC+erLXc+2mJAFLkqzzJeWQ27Xqfg4RJ0yJ7qM3KqTuh3GUSv8/a4f/iuM6UZgp5GSD+OLvorYiaQKKkvb1j21WnsMZObzr56KtGWvz6Lrqr9TObnYFPVPBzVWMFn16jR7BCb/tdsAIP+dgJm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtGMTRWB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so49675395e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759145896; x=1759750696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV+6yoKv/P9OgvlWPQKcQD99p3mLWnHYMK2iXPsZM3o=;
        b=OtGMTRWBLoZWsgoOH2w4rn5R/b597s/xtcZj6c6DbuZnLdYiFR0M444fuo1GX1qBRb
         rrkA7enF54EtmAhTV+uSOr9zk1dwOb+ANiM3VbRlfP7cct59JTMMprZ3eopPpiL6JHXk
         W0LccJcEnBOUQzkCF1xbSCfyz7yrne7u7qWwGvXg8Q8ztmzS2/9xURXG1bV8r4jsGKuR
         a/7rSXjKH5rJkvZsnz0n051bIOMW/giXSXWHl6mmHxkEJb2HOkEl0TL7D95xR3+MSffD
         wVWgPKc0qitw1c2jaX0QjZnaNcgmSGr7A7P9N8/FNwiedtfZP64Y9uKlbyWdnwGeZ1ZA
         II+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145896; x=1759750696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV+6yoKv/P9OgvlWPQKcQD99p3mLWnHYMK2iXPsZM3o=;
        b=GFUHqNqcv9b51R5bTePWarfGYD797mbZm+5JzQx/yv5Y3tCOK35whC+YD5cnd8V90Z
         joUTwtFOkQ47bKLgtV/XCSxnr/x6ttp53IcYz578Pj1yjNWlrbPfRxvY/Earj0FlETRj
         G+1BFpOZ7G7iyIPv/Xx6iXeVZzu/xhimzPlEA1qh7jP/hgBT8ESAuUMO0FJTr2S4kbeJ
         ghXWGgjuxNZSkwrASw3w+ddwIhzeP08TcMp26bocEmqFT0gySK6YX2BU1n6L6KD+YYGN
         h+v/SISTrV87r77N+7rhC5MuxHqdxzS+6uxD44+lZ506JUZ+n/uZxqCTHwpI/U4fY5tZ
         0Bmg==
X-Forwarded-Encrypted: i=1; AJvYcCXfuQk4Jk2t/EiL8qAi+Df8SXp4Vt2uRXxqPSpvPoHNV+9KCv9X3F2fccYCyzY6kFSX9TMDweDCdjBj+bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6FW1c2VG7G0CAWpq07VvnQB/fKQmqC+ICcTCV0IFQOfnswnu
	F+7tnepemmmzuj9hdnau+ZrYyx4mj6+9BhwuVAho/gSQ8DJGxZiKDqxn
X-Gm-Gg: ASbGncsvCmP3r1ThQouZZL2lUrM2ipYRpVx8hSplCcifdTDH2Ma5q5jOpo0Qv8U5UYk
	1Pz+QGGh+/UMQplLGMMUoqEF4Q/xzKNDkOsETF4PkaBq+07j4W3vEEFG4ZsQWjUBpqTVRr9EdEN
	wRx1uEBM+ZhYG+FECf0jGtKfUXC3UjsGsJ1OAw4lHEF+Smpb+8zKWvpZ2ZFD2to+/z/CoFjNnzZ
	N7BuHaMqG12RxaTjG9df4Gd5LNGpGdIMLOPYElSeaadWezyjeCrnucCie8FcU+DN47if7zx6lSh
	F7YBjIevOtE2o3+UonGddNH63qwKFpVJNw6oHN0+7bXPvmxmJ7TbNZnv+HZrcHYYg5dmbmcMWbJ
	8+t82XwqfD59I7oUVlGHUrodLN0dsXssaIX2LDQVAYOijpvDFZSfnUkP17PTIGaR254jLswezdJ
	+8MW4kew==
X-Google-Smtp-Source: AGHT+IFI4JCC0CS5i7fI/P2/bpr7mkkJzs2jB30grNUffEVDg+ZThDdiliKzuAgxVdMuS1kcxLiNLw==
X-Received: by 2002:a05:600c:3149:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-46e46c7b979mr68799125e9.2.1759145896077;
        Mon, 29 Sep 2025 04:38:16 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f53596sm9502465e9.7.2025.09.29.04.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:38:15 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/5] ARM: dts: mediatek: drop wrong syscon hifsys compatible for MT2701/7623
Date: Mon, 29 Sep 2025 13:38:00 +0200
Message-ID: <20250929113806.2484-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929113806.2484-1-ansuelsmth@gmail.com>
References: <20250929113806.2484-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscon compatible for the hifsys node for Mediatek MT2701/MT7623 SoC
was wrongly added following the pattern of other clock node but it's
actually not needed as the register are not used by other device on the
SoC.

On top of this it's against the schema for hifsys YAML and causes a
dtbs_check warning.

Drop the "syscon" compatible to mute the warning and reflect the
compatible property described in the mediatek,mt2701-hifsys.yaml schema.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/mediatek/mt2701.dtsi | 2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt2701.dtsi b/arch/arm/boot/dts/mediatek/mt2701.dtsi
index ce6a4015fed5..128b87229f3d 100644
--- a/arch/arm/boot/dts/mediatek/mt2701.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt2701.dtsi
@@ -597,7 +597,7 @@ larb1: larb@16010000 {
 	};
 
 	hifsys: syscon@1a000000 {
-		compatible = "mediatek,mt2701-hifsys", "syscon";
+		compatible = "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
index fd7a89cc337d..4b1685b93989 100644
--- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
@@ -744,8 +744,7 @@ vdecsys: syscon@16000000 {
 
 	hifsys: syscon@1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
-			     "mediatek,mt2701-hifsys",
-			     "syscon";
+			     "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.51.0


