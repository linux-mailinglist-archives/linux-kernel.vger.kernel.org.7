Return-Path: <linux-kernel+bounces-794653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F4B3E4C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF8F3BE66F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A7322C7C;
	Mon,  1 Sep 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLM84gt0"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0C266565;
	Mon,  1 Sep 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733075; cv=none; b=uL7lNoXlSdzgoxbg05gdUuDkvJ7sbDPNGYYiIwvjTEUuMuXNb3waG03DVtjU08mLur46lF302gvx65nim8ND2V9eudaYZtIQXC1TWX7PgKiiuCBHf3X9zOv6dLN+pW/5vvF3WVfyqVcJMeK/JbPs9P0vnnVubjIb8CLg2rXmKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733075; c=relaxed/simple;
	bh=JBcFfTnuAxsZxmRhQrEZTdzQ+D7RTRUHtornFcNtc8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOKbotouCk4B/99aI6GvMv5EBTJGBm48QEw5a/Y2SCDfJGJ+XGGs/DSayMG9B52lV1pmC4sIa/XZnmsMiKU3pGtX8narVbSalgiLANVG17eawHUil3z2sWWnwAi4up809KzSJYbqAfJ5k/Twk0usQGYtrLM5JW9jHJ+JhzJiF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLM84gt0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3cbb0df3981so2123979f8f.3;
        Mon, 01 Sep 2025 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756733072; x=1757337872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcztVxGVnrCnJstyxMe9QKMd8mGJlLFli+mnzkxgSgo=;
        b=TLM84gt0DcAjMgTxinVHtMYTc2LVHfXWjFhP9iCs+Va+QUbPzWmm+bAOiUWWainh4Q
         o8BU9oNUxaYRw1RAyJKuLqfzAHaEGFtR3xnEYbD30F5IjJrnNT+6DRIrGptb1S1Ap8Ke
         ye/4L0xPYLaEZ7U4LrvzHzm5bx5+70YWNW4PKLQLKSmKBoUhthxUOFClIP8QGEqxddSu
         APKG1hfFXZNxilPt3ruY/rSYUj8ipQ+dN4/WkhQUlrG7pzyhMmJ1x3DbgvU6wL3OBAeM
         AVpDjnam8cv+IujkGUTy92qjYRk6Ip0XwdgwN3wLMAk9+1uurWXhLhb4IUjQRHtbx8go
         tDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733072; x=1757337872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcztVxGVnrCnJstyxMe9QKMd8mGJlLFli+mnzkxgSgo=;
        b=ntMNKjttY6K4hPi7CsyGxTknOVyMIt79ep1StbDpLVOf/8r/1WctyYAPnKODzmYU69
         QZvh8NPZXcR1c4WooaxKXgajEdIheukrpSOZyaoxuOUnWKvZ20GziyIVCShvzKwiai2R
         U/fgIb9oqKNyQdK/4wryXLQWE2VTXSZjeVYi44kaXonrZ8G1DgHu9sKNvfAhSkUFWNX+
         ddIRzUd10cQL1IywqqV0orXkx73OGHwctF+r2miRwLi3aXmlKCRWRTkMAp1fUSGJON+s
         zS18Cm1XtIMuM3Nit9s56/duvJJuyGXdZMwZH52PjaxwTQS6fm/gIyWse2qJUeLbjJzS
         rDTw==
X-Forwarded-Encrypted: i=1; AJvYcCVzcruRI0rlLwzGESAiu52kem86ojyg0eoD1mug+4Lf9IEiBYChTEk9WpWgXPW0fMLJHPHS35fol2eu@vger.kernel.org, AJvYcCX16sY7sHJ6RztL4mgBIt8JK5NNDHjbzuPq9/9Xg/yikORocfOIAHjIH5Cb/ddFRTjFDE2yPaaeo/NP+r4B@vger.kernel.org
X-Gm-Message-State: AOJu0YxZymMuefezKtNUEecMwBDuBMO1a5JP1ErqDbrLQpKeY6evavwz
	JivcsvcfN8unh/sl3oVDsiQE80rgTa3IUtBO+tzFLWf96J2nQmWpipCr
X-Gm-Gg: ASbGncseBJ5X/zE7zioUeUk6vadcgNRTwPDjO6a2+AXgRGeUSaS5/Dlmm/qZrxNrhls
	LaUsG9DBsPXXmtKw2ngyGhg5NUorBWSU3tuW91Q4OZhpLrQb7BDr4VXQdpxLs1MQZUKjQRoUN41
	p03a6kV5PF70aCWPhfyhMmeCz61XahMPPV3Pzfv6hiGXTSKVJTQUk9ddVymgH6+IbPY+Ni3MLPS
	6bmD9DttdXkG0uGeTcpW7aDBmwSrNYtIYp4fTT8jVVoBj31SqgyhedywBAIxlo4zscRYdb1StAF
	N7D4laW8T9QEN8JA1LPYrSHJ4ZKgjL/8iMVv7nP8u9OQJBKe2DAcCBodQPNKWcTN3oP+nIieacN
	OKMyHp7xiMpSCeZepZPlj6ACJttjOxEzDOA==
X-Google-Smtp-Source: AGHT+IGCJKS8iM+ASa83jD+sOeqBGUpNKKuTuJv1DDyMOXcN7dLD/1V0f4dRjY2Vr7DmztyE2Gq3bw==
X-Received: by 2002:a5d:5849:0:b0:3cb:3ca5:8717 with SMTP id ffacd0b85a97d-3d1de4b5ae8mr7181153f8f.23.1756733072370;
        Mon, 01 Sep 2025 06:24:32 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f2d3c88sm24359635e9.19.2025.09.01.06.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:24:31 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	joel@jms.id.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH RESEND v2 1/2] arm64: dts: nuvoton: combine NPCM845 reset and clk nodes
Date: Mon,  1 Sep 2025 16:24:25 +0300
Message-Id: <20250901132426.3081648-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901132426.3081648-1-tmaimon77@gmail.com>
References: <20250901132426.3081648-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine the NPCM845 reset and clock controller nodes into a single node
with compatible "nuvoton,npcm845-reset" in nuvoton-common-npcm8xx.dtsi,
using the auxiliary device framework to provide clock functionality.

Update the register range to 0xC4 to cover the shared reset and clock
registers at 0xf0801000.

Remove the separate nuvoton,npcm845-clk node, as the reset driver now
handles clocks via an auxiliary device.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi      | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index acd3137d2464..e4053ffefe90 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -42,17 +42,12 @@ ahb {
 		interrupt-parent = <&gic>;
 		ranges;
 
-		rstc: reset-controller@f0801000 {
+		clk: rstc: reset-controller@f0801000 {
 			compatible = "nuvoton,npcm845-reset";
-			reg = <0x0 0xf0801000 0x0 0x78>;
-			#reset-cells = <2>;
+			reg = <0x0 0xf0801000 0x0 0xC4>;
 			nuvoton,sysgcr = <&gcr>;
-		};
-
-		clk: clock-controller@f0801000 {
-			compatible = "nuvoton,npcm845-clk";
+			#reset-cells = <2>;
 			#clock-cells = <1>;
-			reg = <0x0 0xf0801000 0x0 0x1000>;
 		};
 
 		apb {
-- 
2.34.1


