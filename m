Return-Path: <linux-kernel+bounces-837359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FD8BAC208
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D523B7A2865
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEFD2F7AD4;
	Tue, 30 Sep 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCfI3pxz"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE132F745D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222022; cv=none; b=B0nCjf1mdw52eu9HpYNuYQz7KGoZP3it7EpwZ/HFXuWveL6ODbEtaLstmJHtbTEElsbYE6fPLQViGBYXI8SQfEk5Qbq4VTGDKtSa2RnfDXDDZCMiJQL9KMe7piizsk5DHIHUSjcTtstVZpAoWHXE4VAi+nM/YWJ5pZR9uMe5L6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222022; c=relaxed/simple;
	bh=1OJSwnVWIOwJ9ZLoYl+VQDzy0Ex+adY43gmbor4fP/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEOcujBS1ZHkt77xYW9tUGRpQEkmlcRxr/4G9eC5AuK1RGokrCahK5GG9vciqfEv1Pi7TuKP4nmlYOz0bfyFIQ02qIsdujNuu/Gkn5KmJ/7V6OzYs2xQHHSv0scePdBLIwalgTXbSuuSYlFHWutGbX0fC+xdVKQNFgC+ONrJnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCfI3pxz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46b303f7469so38702595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222019; x=1759826819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkTVKKAKgDTt3rd0xPFa8W7IH6WaF3o91NFw0CHdy6w=;
        b=MCfI3pxzYEH3eY9ZSthqZjIfb1ci4bivOYw0iO+e8AmVRDzvB0t4frXslikHyRl1Un
         AXpUyxJmUGhBDo97QzVQc8BZFcjWAVyy4/se3QxvC4z66pEIvTp/eOg26YALdrFf3j3J
         wTzzaxG7vY3jpsSCwZzhBgQQW8TmLknEYWyTaddKSZvEw8mPr/gDjdHHRsSdveWrjskM
         OwpeLBrtB76ysXy0rniDB0v5h2dbA4fz5xsFCci531oNEDCri34zOLe0KMSynDdC6kni
         PlrgwV4z476IexAOvSxaidqt6oRecNVfTsCD6o+xFBnDy+gzJmtc+8dyPgR1iVZhSeNB
         F9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222019; x=1759826819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkTVKKAKgDTt3rd0xPFa8W7IH6WaF3o91NFw0CHdy6w=;
        b=kyn5jVX3GIp+nJgNRztud0c5OzFx3aVEpWqzfnWsKI0ozf0Rtg+h6BGxOpUhDVhLNk
         NlWWsC+8xcwCJ63NhhvnJ0sMeTTRZMzgiPAI4CTwiEo2g5ePv6AAWIZ3TcxBy5b4yRaa
         km3lcQhZBl+IjI5W0s4vvfjR1LE8cb6eXCuMaRu9phOExhyfJuDS0Nev5h2y0GU8+KxN
         cg5WhgYJFepatxfQLFJvX74GzFY48vacNxxT+cRAp31ittl0zjP7LnMnvshGglBLpB/Q
         Uwxfvu37j/YCU+eO7tF66TiwtRXNBRfNupfRxG0aYNTsQwd0jMmSYQEUhlE3PzOpSmIn
         Dq+g==
X-Gm-Message-State: AOJu0YyG7PUFWnMPrP+iKhe3WZbphREvEVYqolLSK4jNz9FerVyCZNjN
	osxLionF0D306tMKAZRIlTR/bPeG7roRMIRrfYJjn31IS3UhTN0ixYqI
X-Gm-Gg: ASbGncsPX/uso8XNKhmzYlysrp19i4qgI83C4PDOwI23sTpyfDGV3FaIasSss+nt2+1
	vJETZk3kefJFPJXqB9u5tDrefp3erOav37bTXt9nfNb5dWJQUIN1BvCBdxZUX0FH9n3/5OKM52P
	Np6CHkJyNot0HGz8x3ruyFHdD2FMRQLy01cBLmz62MMNiYtJ9gLwLysQiyOkDVIR2BlpGfwf0/V
	ft1ZMjEjpykTWJ03WYToSAIlV9BYI20x0mm7aw0aTr3JurvVDfQ9fnk22Ed+yADeAq7oHPDlC/6
	UWqvQJc7cuW08esyeFZMtVUm4ueIvC7k6YQURMkfsESyWIsswE1nL9H4nnm5RYtvifIAFNGGWiT
	MVWPiEaG/6KJUuWC7iDEwNMCe/HcU7VFJYLkW6LiiwL7JaxiiBLJqQmxMuXuLblrp5HyoDeLQbs
	uDym2XOXR8UquIacWDVPCLbGYZr4cA/AyhjLuiEr6L
X-Google-Smtp-Source: AGHT+IF8wHDDTceWxUz+RFjOgHkPZcIHe9m5mYQi6GvRX5Bpn1/rX4YugXhmgUIs5mTCb6j8tM/B3A==
X-Received: by 2002:a05:600c:3f12:b0:46e:42cb:d93f with SMTP id 5b1f17b1804b1-46e42cbdbacmr127109955e9.15.1759222019299;
        Tue, 30 Sep 2025 01:46:59 -0700 (PDT)
Received: from localhost (2a02-8440-7149-a758-f461-9bc4-1c75-ebc1.rev.sfr.net. [2a02:8440:7149:a758:f461:9bc4:1c75:ebc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e572683ccsm48034325e9.22.2025.09.30.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:46:58 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 30 Sep 2025 10:46:49 +0200
Subject: [PATCH v8 6/7] arm64: dts: st: add LPDDR channel to stm32mp257f-dk
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-b4-ddr-bindings-v8-6-fe4d8c015a50@gmail.com>
References: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
In-Reply-To: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add 32bits LPDDR4 channel to the stm32mp257f-dk board.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index a278a1e3ce03..45ffa358c800 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -54,6 +54,13 @@ led-blue {
 		};
 	};
 
+	lpddr_channel: sdram-channel-0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "jedec,lpddr4-channel";
+		io-width = <32>;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x1 0x0>;

-- 
2.43.0


