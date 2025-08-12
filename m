Return-Path: <linux-kernel+bounces-764415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC2B222C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35499188A802
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3002E9ED5;
	Tue, 12 Aug 2025 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xeRLBaWn"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735F2E92A0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990197; cv=none; b=MZ71eqbKYj0EoQwzn0fAyjSn7Cqa3IbmWQM7QCtxuEqauwXqQEJfWDLFbMe81MU2PSBjIpIWue6EKzKkxmf4zCgS6lzclRNODoVmzl+8iF9V+PwTri+s0aC2O6D0HI4exizINQT7UnlicxDsU2IDc/wSTwAe7ssIzRzb0W9n6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990197; c=relaxed/simple;
	bh=U+sQZCXY+70gu+lQasLcWAIMKRfycTDRFh5r/EUihZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRgeAHXmKN5FH5yN7EGK+Tg5iLE9dKVOtmfgPnETvDUZZN4QtgFQupjY8ZNHvfZaqITxN7aIKXt5PzkFCxSsdMYiRrSykCbwJ9FyK89mYT/5MCLfw7Zf7+2DN9kR5JNCK/4nBzJDO0a+NF4DlojlfM2nl736AvFphZSiNb9HHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xeRLBaWn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af93381a1d2so832561766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990194; x=1755594994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJV7YHis7znGp8bI08CWuwiCGtVUv6W3lUmzvPWlQX8=;
        b=xeRLBaWnDa8nYM4W82go4qp1yuMOFH7W2SMkVZ0Y9IE8kig9F1uZZrSfakOjKS3FTE
         GNrcXM+AEljoXfh4FSd6xHFru6wBPoX1FeW+1nbSJnHOYKOJMaBq1n6eXPDQf+L0TzTU
         L0dprWf/orNdV/NaAqJPo5rkbydrpyrvhB6qKmevA4CsS8gzyZy2gG5VlTCyBO3MX2am
         IZWc7hRfvVPP9+4n9OUFCg+CFjOjikpbHHhyvy6eDA6NtjVdtHrpSiVcTd6DpmQV5kTe
         sqRIqarjFdADJQt+4uEiEDVRD1Hm1zVGqrHtYASCZfHdg0BZfRr87JkzbV+6HrOleWlx
         aRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990194; x=1755594994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJV7YHis7znGp8bI08CWuwiCGtVUv6W3lUmzvPWlQX8=;
        b=Y5kEyRj8nk0h4Czg5NA8M4lR8H6fKXNnDqNB4enp75GUchr8YA21FH90wcYTR55YNR
         m3v27JorHLf/FFFi+SarESdQeHNcz6lXeYHDsQbAG4Ec7bt9pbIf4sCwRE/nMtfiWYUS
         4TpxQIS1ussNrEQBTuzhmwV5Z+leb1TAaPOwPXPPsFdfFEtJ0mVr8lVTTKh5AKU4TMok
         GZIK1SjEtPMklAW+YFqUeBln/FFOX/9qoUtSQbfml2uyP1rUnUL5A/Q3Pq8vvuksD8RL
         KT6eQsTzW5Y71KajnlnV/AixNFFAMyOk3pbW46BlPpvJsS1aW9VxiJGYnI+KVPccRlP4
         23iA==
X-Forwarded-Encrypted: i=1; AJvYcCUQHeyUMYB05ZJA1DLut6ysnYU8dJmlvcW+svBYBLUdRlHv/3FpKwbD7VQ7ulpNxiJFf0IcWblV6y0PibA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNyZwS6Hs1XJ+8h/aywMPEJVE2xPSLKlZNuro5t2vXDT30vsAE
	zvpxFO7QaIqlZ/1qw72NpyqKjEer9quZIzDnkPDCZ9NFUp1DKQy4gUWnt+oaR0TIKJM=
X-Gm-Gg: ASbGnct/SM0xwKd0Eo8CLBVOVfax0cUCdvYele6qes7j8Q2hrMBUBunvXXZq+8TIYDR
	dKKZTYiPqWDUu2ko4CBabA2ApVpD0ImEGZQ5pu5+Gmsard1dl8jLG5wzPjsfIln15wbl6lPBgu5
	Me6aBFyPGC6+oe28owlT54mqYcEUaejCLMAcUrCncb00DYKUyxlilThGNYtxcsZaxD/5uqlQVTg
	e3wWR+2cR85UTDNMrCU1YuF7NbSVtDFHYL/7nJNZwecd8Wbebw32nG902xaGa/ocx3US3eaEPFG
	04VgE62A8gxL1ERSRCMeEKW1TStNJA0LSnqY8FJ5NUqlENbRanuKNPeKwlvEDrhutcI0HSuD9g4
	RRR1OS7pJNADYoBIpkFwlaH64aaaw
X-Google-Smtp-Source: AGHT+IHh8cqn28ouC7/YJj2rnR4pJ0TiM4OD7GAjc8cb0zqPwyxYiILrTmg7dkx5KBh4sMc/Lq0YmQ==
X-Received: by 2002:a17:907:1b1d:b0:afa:1d17:b5c5 with SMTP id a640c23a62f3a-afa1dff7dd3mr228206966b.19.1754990194063;
        Tue, 12 Aug 2025 02:16:34 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a1e8359sm2160921566b.89.2025.08.12.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:16:33 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:15:22 +0200
Subject: [PATCH v2 3/7] arm64: dts: ti: k3-am62a: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-am62-dt-partialio-v6-15-v2-3-25352364a0ac@baylibre.com>
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
In-Reply-To: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=msp@baylibre.com;
 h=from:subject:message-id; bh=U+sQZCXY+70gu+lQasLcWAIMKRfycTDRFh5r/EUihZg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZbCGBLquu95ZoJH6wn9B255Wv02xfKYebx57/il28/
 1WM1fYlHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRn5qMDI9PfDr1Vijiz5Jg
 3WQN2zetV7a/udV17HTb1qDlWT1m344w/DNkmaF3KP2D388NDI4xcUe8Qrb1/tT645fQc+uZmEF
 6EQcA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on am62a SoCs.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a.dtsi b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
index 4d79b3e9486af18b8813a8980a57937669ff6095..31b2de035f0f748e34b8919f90251aa0551d9b32 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
@@ -46,6 +46,33 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	system-idle-states {
+		system_partial_io: system-partial-io {
+			compatible = "system-idle-state";
+			idle-state-name = "off-wake";
+		};
+
+		system_io_ddr: system-io-ddr {
+			compatible = "system-idle-state";
+			idle-state-name = "mem-deep";
+		};
+
+		system_deep_sleep: system-deep-sleep {
+			compatible = "system-idle-state";
+			idle-state-name = "mem";
+		};
+
+		system_mcu_only: system-mcu-only {
+			compatible = "system-idle-state";
+			idle-state-name = "mem-mcu-active";
+		};
+
+		system_standby: system-standby {
+			compatible = "system-idle-state";
+			idle-state-name = "standby";
+		};
+	};
+
 	cbass_main: bus@f0000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;

-- 
2.50.1


