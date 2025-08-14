Return-Path: <linux-kernel+bounces-768877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2AB266D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE8C1CC28E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E4E3002A1;
	Thu, 14 Aug 2025 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo83XHBx"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85F3002DD;
	Thu, 14 Aug 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177442; cv=none; b=kHBIB/VEvF9wsHABOTCOtqd5VfUelbSr0TUHq92rBOMFj56nJMsJlC+3gC3nScijUVqfPD+ht55abZ3k6QVGQrKsyK5CIOHisfZmVHPVJ/q2OtrX8syLY+eJyCJqBJOkjRheNbhTCzD2ItuEBjqBP+l09G1qP88S10Bv7kIUls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177442; c=relaxed/simple;
	bh=tcCjtqMT+MQFBndK2Y3rfUQy0jxdyYlProyoMH+I6mg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzA3L8OsHo0Cog/c7tZ6e+CnbQcCLoTyg9cqXFzls+1SjWWUVrrcAfPgGSL9wVA+HWeQdFlAmC6q5Dw5uoZJ+s+j6sbPq8KrjqScrt9Wjz1b9qxd/FPdaeipo5jjl0dThRVPWi89spqTIQvUArbTuank2am3S01l4Pqtcc/W1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo83XHBx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445824dc27so8212205ad.3;
        Thu, 14 Aug 2025 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177441; x=1755782241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTeugc1mw8AJhG/UkyxA6QZakbeowukdRimSYseE0MI=;
        b=fo83XHBx9bw4CMHtLuMnWnzeFuDp05CxccH7OkYodgwRlK2TjrpzvDQxjJxWBIqmYX
         u5XJJPclkFOdBufNnGkLakZzvo8GYC7hPo8fIWSs3viSMsJVAAwTa6Hr8JObLsZRJQce
         hVA39N791/I3Q8Cf1LI5ZwjPjhDtYA9wJr5FKQnPajpY91LMBjFkqs6cAmdUePIYcEhL
         lTB8ygqBOrXgYTB2mdyaeyWnW93C6n+dcWWNfwFDfoiwf6xbQVLff+5D717M6ZOql6nK
         QDNNXFtQS+p1CQ7cywiDlwQfJr2R/NvbdtAhY1xjWxS+ViNZ3dxxSvd7QGTQkgxLQxN9
         PXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177441; x=1755782241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTeugc1mw8AJhG/UkyxA6QZakbeowukdRimSYseE0MI=;
        b=DVPwnREJE3YUYqn3vvnVW046+DeTPgzjqHp3ePmuyDTPigl+0vSyhBASSpDdR3CXNb
         2Y30X1qG+N+KDJNwVy6+HknGiBVZzTLN8fMss5EKZeMazXdENY0KiLoYOKYyHapx0Iy+
         Fh5VT6N2FHRupwSjumokwVWH6jen3cVdRm63DkDiSAFLoGl3PCYajG27Vp36HHMm2icP
         8VFugGtBO6LEdmFzDkzOa5S4G2bP6o4jbbGvAkuQCjljSC4sDOSC1f1eLlvEbd9z8nMu
         zSYu0o6cu7+xVVi1W2btyvaRhaqQ3MeNh1YPi5dcwo5y4kzXB3zK8Ac7NEjb36bylEe1
         RFZg==
X-Forwarded-Encrypted: i=1; AJvYcCVC6cqQToPKN+jyHHwvq4ypJrIJeXz+ZGvq4gcVGu8P8zgTnOYR9H95Oh82h8Qqzwil8lOtK+GEWAwB@vger.kernel.org, AJvYcCXCNubhqzcGF0D2xjs5ilhqUl8mtPpuFakfWH92pNWZ1M1BQkMDsA1fD4LxMRoRTDJOnFHu2JimmjpZ31J2@vger.kernel.org
X-Gm-Message-State: AOJu0YxWLzWraa2JHEGAmgVWPn/vLpAxmCViMHtHqWaEaJ3e8g6UPFMJ
	FleudTz8sAYE/Jei8F0cvx7rmexBFeX1sMQQJBTOsbEWw7vEyT4txLxM
X-Gm-Gg: ASbGncuujVK4GOijaYb31LwaKIG+XJ6r/xPV5mFqi787p5aDnjSjuHfWUQ+3aKPVyOm
	7X+z7Yxb8ruSDCyMo/h2bjgB1Ew7qwK2l7GgtP8weRMkV8tGa63j02g7H5lO/9XRn/iHcF3106/
	9AfROD6P3tcqYaK0S2+OsfoKAb8xA9xH+MkHuHwEdKKajJ7+1qCxrMmmBZC+osaF6D4rujUj/kv
	TAGvKcS50TMgY2rz1PdcSKFd0+nwhojNkW8UvAT/IAhq4iYAR69bmYxDhL188Zx4U1MVuiA0aWw
	Hq9Q4Dnl10DA7ckvJ6sXfxCsMYJ0Oha1n4eVq8bO2yci8e1AxOyK21DshRjeOxcZEh34xcJJ8zZ
	eM6LWfivml8LXLwBXU/HFNybV1ltWe6xue1oh2RfhdibclxH8FMNM4K+Pq/D9cKoO/r88ciu62O
	L0EjCmMXB6it8=
X-Google-Smtp-Source: AGHT+IEi9Cd4/1A3g4Nl0M2mQgj+9WahbmP+8Rb1RXtow/Y3VwIO6BsjihtLcR9sqiy3LmjE4+Qh7Q==
X-Received: by 2002:a17:903:2acb:b0:23f:d861:bd4b with SMTP id d9443c01a7336-244584b8f07mr42768455ad.5.1755177440508;
        Thu, 14 Aug 2025 06:17:20 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm335652995ad.63.2025.08.14.06.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:17:20 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: aspeed: santabarbara: Adjust LED configuration
Date: Thu, 14 Aug 2025 21:16:59 +0800
Message-ID: <20250814131706.1567067-4-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update LED definitions to match changes in the hardware spec. Add a
power-fault LED on GPIOB5 and relocate the ID LED to GPIOQ4 via the
CPLD. The ID LED now shares the power LED: it blinks when ID is active
and otherwise indicates power state with logic controlled by the CPLD.
Retain the 'fp_id_amber' label so /sys/class/leds/fp_id_amber remains
valid for existing users.

Add a 'bmc_ready_noled' LED on GPIOB3 with GPIO_TRANSITORY to ensure its
state resets on BMC reboot.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-santabarbara.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index ed30f3bf61a4..ed2432f37609 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -94,7 +94,7 @@ led-0 {
 		};
 
 		led-1 {
-			label = "fp_id_amber";
+			label = "power_fault";
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
 		};
@@ -104,6 +104,17 @@ led-2 {
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
 		};
+
+		led-3 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-4 {
+			label = "bmc_ready_noled";
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
 	};
 
 	memory@80000000 {
-- 
2.49.0


