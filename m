Return-Path: <linux-kernel+bounces-881366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F0C28164
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D237B1A21CEF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480323956E;
	Sat,  1 Nov 2025 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8hLat10"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D17817B418
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011330; cv=none; b=RbCY1zun6r83vRroHliylrGHe08S/NiyhpxmMIE4JYRZdgST4lxeSRJ0NUSdSb9oHtsMQNg/qrypidg+nS3h8pt/Jx1ff5auRBMdjly46EDmvnjJbOeh9Fsw2hmJwzeokjWKYxI3xMQ6nMFXqVP7IUnDXNYWJKRVuVFu/wylsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011330; c=relaxed/simple;
	bh=2l14iCi71vkVUgeo+E1Q/tEM4El2uFdeq8BhYm+l/kM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=aFSTDxgxkMIrNU2x8P8Jg7DP831vArAej7RopeJ9ARrMA94tO3dcfsvyR6v5/WggXVFag7+bB4lvHylrMVOPrfXP+Sft98m/mhmvYiTh//nXrYQpB8CH0R3kf7XvJfK++rq6N4pwfmUmaH2brKwA4JdqKBZZmFoTrp9XaAQ7mwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8hLat10; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63e484f8e54so688385a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762011328; x=1762616128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0Tk9dDcYmqBenbtFC0DeeXVXsg2rmtasPdJhxUdBos=;
        b=Q8hLat10cBiTqyiSayLxowXV9Md4o03S2ySShBAk9A/3UNNC2YWCSdgHGRauYwMmot
         AcrTfEUXGBXyd7j3V+0fu2+upl71lyrKwU2dxxONyhFXl733R2zFegJke9TbsBNRKhor
         N4wfehNo2YdW6FX6QOdRHVaIZyUyl9XCN/uTXioOZJA6/UTuajJ+EnWzCjGywvpc/BfI
         doAQQu36ps1rj1yUpxkSU4R0Pfq3Wh6dUD5i/+w1w/PaVMChAFFRrQ06nB+r24U29Q4k
         +E1aA9wHNw4GlSP0bN/mvZjEA1WOK10IgzrGwxh1tZ4CtnkBJQS4zd4jooux/WtU9PJu
         kA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011328; x=1762616128;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h0Tk9dDcYmqBenbtFC0DeeXVXsg2rmtasPdJhxUdBos=;
        b=AKH0jRqbQxk1pZHPnoqOmL1o45xPETCIh+qf9Y+AYJR0JtN3gMLB09/KY3gKRjasfK
         arAoemzueQDeorfXIz4vDBc9WJhqr+fNaIt2hMzLvsnu0bzDrdQ+sZdLzyrSh2A07Iv7
         lAl+N4k0n0Pr6NK+SdrqWnn35PhmrWyKcJkfvonpsIUl7R4B1UXLKeJCjuddeA2eq2Ln
         gSxWdlosuIq7zko1zkghb/GDXIV8SWS2qD3q7mfIScIPMXp8erRQ/LIg10PzwRotyahg
         2VMGOTGlKUUKa/I1i0SEg5ajOhCxoGGFd+GR2Xrs1LEC6bDUeHScBwSZ5bksB4mfrNRc
         M50g==
X-Forwarded-Encrypted: i=1; AJvYcCW0CMNoXMoUW+qpMWK15f+HYckDaRsO0BkzHYkPjGlTgRfY6eNC7FvP/XPqv2tZd/uf1QCmfxByEyK8Pgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwcRwX4FYWn+YIU1BtMn3MpQFcNeDqcAkWfZy6atNbt9Assml
	+1dwenx68O3+NJG+46+SHmegcBGXovFgozLz0pzLOgXYT5AMG+WMfgL/
X-Gm-Gg: ASbGncvpf23cHdMCZcHnlgD7f9XW3blRgMzPy7iMc30458h/WZxK2L2WtJF/7LWZz7V
	kOF+beSE5CMSUioaqTrJS68YhkEjeWGj+qo2aLASDrP2BaofTMm36xUyWVoQ4Ri+4cunw973nWe
	fYwkwk0CEVueCGmBbpK6MyUoQCrkYaqbOEixNVk40ztxkYPto1g+yutOueMXpZ+U7d2Jfy43n1I
	FwuLILtKZ4H9UTorE6Z7C9c3ntfIIHbZUDNmoJe2CZegwLrPM1S9OKG57Jwx6gUWqiBvNoAGkEj
	IkpJE1ztGfslPyohDL1evdTXvqXzFjTd8ILSqzBB6UO5Rs7TmAdvzVcfWL8oKbXE3BwXzCTHYbn
	qCk2xYNXj6GNSehJ1no9CmM2fs5YyxXpu/ooaxhRoOmVd/3emEEy/B/HtWD3U2zS6wdknz4wLQq
	/49mwVZEZkFebOPT96ogGll4uAnrbaga0bDZNU4YpD9fxbshzfIw==
X-Google-Smtp-Source: AGHT+IGGbZKmix+04v0yBeE+miuCe2f5O67VTMu7nJKCL7jr0B/QprRarMtQ6I/yofHU8ylwWgs/DA==
X-Received: by 2002:a17:906:730b:b0:b6d:5587:e336 with SMTP id a640c23a62f3a-b70708c8a6fmr418924566b.9.1762011327533;
        Sat, 01 Nov 2025 08:35:27 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983? ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cfa966sm478124166b.65.2025.11.01.08.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 08:35:27 -0700 (PDT)
Message-ID: <92714b6c-6c0d-4a10-afe4-73ed313c87c0@gmail.com>
Date: Sat, 1 Nov 2025 16:35:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] arm64: dts: rockchip: correct assigned-clock-rates
 spelling
To: heiko@sntech.de
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Due to some copy and paste from the manufacturer tree the property
assigned-clock-rate is missing a letter "s". Correct spelling to
reduce dtbs_check output.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm64/boot/dts/rockchip/rk3328-evb.dts#L313
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index b5bf84322031..b9d4d78bff0f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -184,7 +184,7 @@ &emmc {

 &gmac2phy {
 	assigned-clock-parents = <&cru SCLK_MAC2PHY_SRC>;
-	assigned-clock-rate = <50000000>;
+	assigned-clock-rates = <50000000>;
 	assigned-clocks = <&cru SCLK_MAC2PHY>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 3707df6acf1f..76715de886e2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -101,7 +101,7 @@ &emmc {
 &gmac2phy {
 	phy-supply = <&vcc_phy>;
 	clock_in_out = "output";
-	assigned-clock-rate = <50000000>;
+	assigned-clock-rates = <50000000>;
 	assigned-clocks = <&cru SCLK_MAC2PHY>;
 	assigned-clock-parents = <&cru SCLK_MAC2PHY_SRC>;
 	status = "okay";
--
2.39.5


