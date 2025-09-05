Return-Path: <linux-kernel+bounces-802962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC80B458EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6845E1CC399C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262D3570D4;
	Fri,  5 Sep 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig6w5nMR"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102A350D79;
	Fri,  5 Sep 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078722; cv=none; b=Lv3kXi5CwqQzm0HEPBtH8HP2Du2Q8sue7JXr2hZKACCW6jEA/iFGri4VAqsBHmbb8p1RzLauU/atdsg/kKmyzyOzGzkDZyPh7h5pJFjdvCDPpNMfEGmhOvkM2lnjvaHeMQdSMR8oof4lIyZR/KoMPKTaG3j+iQIObwILM56Nyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078722; c=relaxed/simple;
	bh=te9I149acRQokXezs/LovR8cdSMoueaQC9rGVP7AV2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk114HTYx3or12QhMfTfCzIF1/id1REE3DbgHI6gT0uDVWnzm3vKi+ARVfjXhdmDBkDJKl9bNwZMjqzeqcSqytS6hjinkRYoPERd75XTnFKsYLqi/3/NnZei3vv6mLWONn9/7OxgZNxmmsOsnRHCFRMqfnYLzKQbTYCL7sIP1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig6w5nMR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24cb39fbd90so19902245ad.3;
        Fri, 05 Sep 2025 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757078719; x=1757683519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ixXcdqyuNr1VgQXgWjsF1xkuEAC5opz8oCbKicjrwI=;
        b=Ig6w5nMR944ZLDufyoIG41goddga+Arx6wtlkjR3CMqGPZY8L3a7wLRf+x+G2nbQeH
         sgoB6OlGMmzK5GIy+NLh2pn5ksSwJjN0yfxba1PI5v1MLmzLX17UnMiR+Zx07pL+E3S+
         gtacmn/U2Ppwa7iaG4hWqlroxizdKROerHQetbJSI72+dzxRXj0kiZK1A/21WqMvnMZo
         d8CpBMA8TNztFp/lyjSzCZlkNQk/Y18ZcB6XK/pOpK0jggISWGe022NdM+4gQxkk3TnU
         CU8kCwXgA7jPJ+N6GTUrNEnN+f+7HPPPLzslB2em8RpJP/fQqI6eJCQt/qVStj6UGkg6
         8jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078719; x=1757683519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ixXcdqyuNr1VgQXgWjsF1xkuEAC5opz8oCbKicjrwI=;
        b=nr+FUh08+gs2w1XxvavbP3YvstlRTuRuCw4Mv691vtA03fR+ZfDZ6sOHRV4icZciS6
         IA47/cy4ft+qeW8isisSwMv5vHi+q5WgSwU/bqnoWy79IFKpjIZOXrVZQR4FX8buVfZ8
         aFTG/9IDe56SdVavoafQ8r33Nik6X8inhLComt/bs7BJxolCyHno+mf7W5IK4sK7UtQ9
         9uwckv5zUoE8a/SOcdC3Yey9UJ4Is2eNW5NRO9BHxP+qW181O0FyV9jDxaeiwaL8Wc0D
         VMTBOWNWePJX2upblJL9omrgKJldMQQdZM4Z7TRFIA5vLmHOgIECFzG/6mUnswDZYQVd
         9wGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8atDLUNNzumEkqtKQnLdp5UNJQ4ciwrGD3ojhAq0VGrj2YomfG2cp3xAuRgVV9EoKES4EuvS89WaIm0Vt@vger.kernel.org, AJvYcCUmuiS+RRUrZFv/lBT0NVWsssGpPw+V1xr2K9rznXyI7eFuyHdZEgqPURA4vyKyfDL7Btk56NbVY+5l@vger.kernel.org, AJvYcCV0Ap+QqUhESYubFc93fIU+BlPf6/yM7ID8x8CfJfBzjn7g8jX9zrbtjeRJ6JG9ml10ZV26ABn0LLpu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgi38SslpZ2m858tUn9FMvtnWuLVHdh1+woivxzb2Vvwja/5cM
	lHQjdHGYpHMf5srRXuLvQ/FbvZHKUPKXo3cpuvvSXrucFtTxnG2uuXYn
X-Gm-Gg: ASbGncsKjoEZnHc51eXXBND9nymyYxlmcv6SnFBapPybkt/TZ1v9tsuhVkCqJ/QPOrh
	qZPA1JBoB/zlpZc36112+jRl84bBIz62zVzG+iQ9hiXs6TTONov1gpopNPvai4ulXJ56JZ5NmzT
	x2mF4tk5I8n2/7PEf3l2ibDBp2m4HxdLs4XKzO44mtV2+oyZe8jFzUNqylBqQpZBTpmqOjlAWl/
	N7OQXj+fMXcK/KRHQQQxwUfPYUeHumNidRbXQGy+7l1Ix5g4NOBGbAOq2NGG4ynjNzDNe/sA/VU
	76d0K0XxyCIZHlzMHm6GTxsaUbknThza5WXA5Go0u+ullnx9Zo+2U2iC5XcNcXbm3ApWgPtKeD1
	xQtWl1P0EPFlurbz374An/A==
X-Google-Smtp-Source: AGHT+IGL6dl25eU0xEnElNx+LVYolPJfhrDoa8h/iqZ5Qb9Zslkxe75tLPHNBliKx3Sf+xjeHY/XlQ==
X-Received: by 2002:a17:903:2ac4:b0:24a:d213:9e74 with SMTP id d9443c01a7336-24ad213a1aemr272621245ad.49.1757078718677;
        Fri, 05 Sep 2025 06:25:18 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c8945d8d4sm76447955ad.127.2025.09.05.06.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:25:18 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v1 4/4] arm64: dts: rockchip: Assign I2S 8 channel clock for rk3368
Date: Fri,  5 Sep 2025 21:23:28 +0800
Message-ID: <20250905132328.9859-5-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905132328.9859-1-cn.liweihao@gmail.com>
References: <20250905132328.9859-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I2S 8CH needs assign correct clock to output frequency wanted. This
patch assign CLK_I2S_8CH_FRAC as CLK_I2S_8CH_PRE parents.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index cdcbc0a944..d931b5f5ac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -862,6 +862,8 @@ i2s_8ch: i2s-8ch@ff898000 {
 		compatible = "rockchip,rk3368-i2s", "rockchip,rk3066-i2s";
 		reg = <0x0 0xff898000 0x0 0x1000>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks =  <&cru CLK_I2S_8CH_PRE>;
+		assigned-clock-parents = <&cru CLK_I2S_8CH_FRAC>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S_8CH>, <&cru HCLK_I2S_8CH>;
 		dmas = <&dmac_bus 0>, <&dmac_bus 1>;
-- 
2.39.5


