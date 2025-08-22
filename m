Return-Path: <linux-kernel+bounces-782013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF0B319FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32469B22B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0516131280E;
	Fri, 22 Aug 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6KlWkiK"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F73126A0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869645; cv=none; b=jhe3bNdxTp/FisiDhMZ9y53YA+wyvYb4eG0gShW3Z9X35krZViDZnOSWMSVNZ0NfT52p8hkx/iGQAX78HM2dqPuDOfIY4bFrU2QuSEFfu/MEcfQ9Yhvprbl/4JDyFXWKhXqRLdM3iob8nLd+Z5ia1h8KtwUp/QZMKufiM3F9hqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869645; c=relaxed/simple;
	bh=ns8imbJBx4C3VrvaBGidv4ZtmC/h7m9iRb2qgAqrZBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY3qiTihOXb1rRkJbbx5tMCMvSj5aC/2cSAiiYPdiduVh8B2xR/XrNj6m1S3IIU6yZYrZynwpHvFhEWK9/5yC+xbXklg6Mj9E/R55iR0HkTdDWVfZsPU++su4DLOSnvvVpp4dxpHYpPczXRqdLqzo3RGSFfSsI6Oom2rJl7ZLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6KlWkiK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a5cff3so34414166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869642; x=1756474442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ne28tbpC8VIGZbl82F5AMsqB6uZwJ1NTU53GkFSodNM=;
        b=q6KlWkiKxh46AWy9ol745eVAfnyw7S5qmF3qxbi9fRPZIEcH+EDj0SjwXGGSlbUX5T
         vhFGU2GhEjalP3qXw5ekN4vUNSZdveQmfyTDVkVVF5WBxXiUxp2yktlLebJPJLGxkU7g
         N8+whff8FKWgroFxHU0kLYQATbXZVsdcEsolYMy2DRsJZhXUSIJY21p0gSxG6GT42ltm
         yFiFtaBxzoBNJE0vwtVSpgGm83PUaSdpnngQsCbbC56Rnz3Kd6lrOLqw3gSeLtpblJup
         EgouHzoGyEQy489Prtw+81BJhJ12J+35Jm5pCbg7vj7+mAYofXPqYFEaQO6Uibs9r8n4
         MDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869642; x=1756474442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ne28tbpC8VIGZbl82F5AMsqB6uZwJ1NTU53GkFSodNM=;
        b=GKWIc1Xcf9UtOJrnh5/3n0d5FcKHT/f/xYx9sUlX9A6YCzuErqgIDI7GWyqrfbjWN0
         WJhgR7lYQciacZcprCAi8Ya/X1XF602KWwDwqeHV8mCMe0AUXNW8dnI5twYe5aOj1g+O
         +rYxzkQUl4vmnCs8wVj2SVGLRSypaSse1uPqoV/hxFAK3IrdlpbrJd8Jo9GVkTWZmst6
         MNTWSzap5dFQOnespY2IJ9b/La9XMmQfueqlSF/uhrII9t5NktwgeE9Cb3WFQ6s9KtCd
         tZMN8NsURNWsB0UhGVM5lL1GPnhWrWJ10pE0NFbNFEYKJwm20IB8EwD7csmzJEYXlMUo
         8tpA==
X-Forwarded-Encrypted: i=1; AJvYcCXoy/Iq1vAmde4fGiSacn7nbYuujEpS4HvJ6Nt7LthIU6NL9ysHZ63NHi7slcTiOLk1k3vAnD1/PAqzhyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZrKpZcficUH3u1zwTb0T3pQMcpm/VeaGQakknIera1csRFUE
	q0owVzvF44qLyP48cog0S2+mzz1CIx3Wd8kCDvhLOPAjIoEOledrZ9kSYXkSTb3dCUE=
X-Gm-Gg: ASbGncvrIrNSl24tuApylszwEdUuqhOiTvqYjEOeM1wenc+3ng8/WtKd6cqfMAjtDHW
	h0FNUxsrwRl2LouXmiSkEPvt3joXiCc47XmMuL8YTLZnbO6A6tOf9shhXFjZUtEmC39cJI4g5uC
	X0hD+S9mFqIaFz0Y4gUXTuL1yfxoY/azC3oL6oa3dZ/WCWmGg6m4nHAq/gJe07tyBTjOJAsAkK4
	zOq2BkxrwypaEPUBmRA0WNKuw3Ri1oKtt0K/ccoVX9HgpzpSTI9CdoSoQLaLxqLj1qIi67txHFw
	SjcCUbl3M3DF4FIYI3XR1YqWsQAAskXNsq/pAsObC4v5RA3bwvvhXshzFflv8U/AnmDAW9a7ySA
	3A7l4jr4/0ymAcfmIToUwdD0EItPtqG7atQ==
X-Google-Smtp-Source: AGHT+IE/RgUMhyr0PNdCI7Qukrbmep8ud6mpyF55q9Xq7Ba9E12fIy31kNibIcLkWDsgRPakkS/j0w==
X-Received: by 2002:a17:906:2449:b0:af9:a9ea:f42f with SMTP id a640c23a62f3a-afe294b4624mr125018866b.9.1755869641532;
        Fri, 22 Aug 2025 06:34:01 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded537f98sm606493066b.104.2025.08.22.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:34:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] arm64: tegra: Add default GIC address cells on Tegra210
Date: Fri, 22 Aug 2025 15:33:55 +0200
Message-ID: <20250822133351.312424-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822133351.312424-5-krzysztof.kozlowski@linaro.org>
References: <20250822133351.312424-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=ns8imbJBx4C3VrvaBGidv4ZtmC/h7m9iRb2qgAqrZBY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHHCzlRNg1LWEmhCPkSvmsoKK5EFWL5YhUIc8
 T0F13v6WVKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxwgAKCRDBN2bmhouD
 12AOD/9kkxIAM9sdeRIOlxJGbkWTVEvSZKks+owj1bO6CEcAyE7nG/b+RpdarbUKdwEevGew3va
 pk4cK4k9oSMrawV9iw6KN2GSOWPCuJ+Exrkk9ipiwt9z9SADA6M9Y5LWIOgZrEJg+7ReeVf1TqG
 yANqxcVqxWl/D44sVcwyHMtGrf/d49hfAz8W3BQ7dcIQjh8a+i+1X8yQq/L34LGgpz2cimd4YyC
 xy2NmsO03gFMAGttStffuXHEwNtvvpcxrCdUiSeNTXLBOSFtTcRzyj6eF4jR0JkdsfYnV9dKuFS
 FtrK1HB16GOYZmffagOmi318yN6SCRlw22UZN5sriaedk1exqevB7RPyB26ZmtNSArgjzM0OWu9
 UTBngM+aAse1tOvmILQLOY3obyAohxrNkMtMl9taTJdQUhmT2hxhFP1y+Y23HeNIp2e01ZRpiFE
 SSl7cvd4buL/wca108cAnm8YWdD7hG+8+r+xoZS14LM1ITv1rCaARHiU2cArxTlOs2yGC51Xx7N
 rptFLQTwV1t+boUTPjp8Wr2G0Awpk9ljRjd+pwFZEVp3xRCR0/VbacQWyPv5SocGwCZ2Bqzw17c
 UbVCGGNVW0bTCYctp0ymt13N/C8w+CcIZPrcXmiM7xk89+xeV6eGVSGdhF4hmV5hdOGZ/wgbyx0 EdXBZzdh3feqdYw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  tegra210.dtsi:31.3-41: Warning (interrupt_map): /pcie@1003000:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@50041000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 402b0ede1472..c39c2b9ec3a2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -409,6 +409,7 @@ i2c@546c0000 {
 
 	gic: interrupt-controller@50041000 {
 		compatible = "arm,gic-400";
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x0 0x50041000 0x0 0x1000>,
-- 
2.48.1


