Return-Path: <linux-kernel+bounces-604199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424E4A89202
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 04:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2103B36DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 02:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AC6219A7E;
	Tue, 15 Apr 2025 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTWnUizB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED59157A48;
	Tue, 15 Apr 2025 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685158; cv=none; b=eH4oU3+cCmTgJ6ZYk/5VT0fWc3jyUbWHw+q+km1F7EmKp62vhCdG/+dPkYpyzeMgb3HhSRX6aU9UzL6rHIM58SCDhPiUCROLwxNzISKUJlRrp8q6NJxLFr6+caXHf5/9bk/bDVo/Mj3j2vLwBkZ9aOAwT1OhEYCh0FPNN6ag9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685158; c=relaxed/simple;
	bh=EopiHNkPR1CFk53P+qfQdgoA0cAjgXrR1L67F8XEVbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pv6l0N7MsNFDIGwh3g+r6RToGJQCxEsqPd29DPjd1xl7rk6VpiqXzVa1vJo8wZdNs1yhLF1R5+VWC46kq+0xLJm4q8/xPyKB85tqE05wkmAOF6JzkRqrRnaPpuNRueeH9sRAMSNktp5QSra0i5/ZJWevdcmScTOTkPw6wFWjo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTWnUizB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2118DC4CEF9;
	Tue, 15 Apr 2025 02:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744685158;
	bh=EopiHNkPR1CFk53P+qfQdgoA0cAjgXrR1L67F8XEVbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gTWnUizBefWJTKYR2DIYa8m2pLfxUFwjfh+8cUCyjfFRlczeTAciVl8rOe8jf7wMI
	 /7xnjHnmdKrjT1PZVHsFSUj1RNB04jsqr6miHi2vuW/mHZxiCF79HjiqoqLFsCDPBd
	 GVE6zIb3mH0z0rZLpXhwD0eGgerfEkOVamH7Kzqtc0mDbPH1CXzZlVlZq7rflAIjpf
	 wIBlW8VxHEujTfYtsnt+WOl/yrbDLEn7vQdthZVb0ED+ttJaCI6o2WxylhW5VvCK6i
	 GtvueIyE2DHmPCqXszPoo03B97URUj0Gl3xFoVJJ/rk75mnza/3q+DdFzq6IRA/pUA
	 Q0b/ZzBLrOjFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15963C369B4;
	Tue, 15 Apr 2025 02:45:58 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 15 Apr 2025 10:45:29 +0800
Subject: [PATCH v3 6/7] arm64: dts: amlogic: C3: Add clk-measure controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-clk-measure-v3-6-9b8551dd33b4@amlogic.com>
References: <20250415-clk-measure-v3-0-9b8551dd33b4@amlogic.com>
In-Reply-To: <20250415-clk-measure-v3-0-9b8551dd33b4@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744685155; l=834;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=AKlPTU8xGIGqlFdU3xVKc7rvyc2ZehKyhODovUNRMo8=;
 b=xRl0UutH0q4YaOvedHCl+vBzUekFHFCb6eNZCJrSl64c0mIqDdsgPBF8Kya2VzubX1w0FPjju
 IjvPZr1CYt8B7+UphyE2a8QFI2wcyifCiIg7WSXG3mLRe4mrYOk2BsO
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the clk-measure controller node for C3 SoC family.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index fd0e557eba06..cb9ea3ca6ee0 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -760,6 +760,11 @@ internal_ephy: ethernet_phy@8 {
 				};
 			};
 
+			clk_msr: clock-measure@48000 {
+				compatible = "amlogic,c3-clk-measure";
+				reg = <0x0 0x48000 0x0 0x1c>;
+			};
+
 			spicc0: spi@50000 {
 				compatible = "amlogic,meson-g12a-spicc";
 				reg = <0x0 0x50000 0x0 0x44>;

-- 
2.42.0



