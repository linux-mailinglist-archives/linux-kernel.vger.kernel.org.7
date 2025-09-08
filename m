Return-Path: <linux-kernel+bounces-805274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C8B4864C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BF73A9B66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FE52EB853;
	Mon,  8 Sep 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO8uLUDY"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0A2EACF8;
	Mon,  8 Sep 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318557; cv=none; b=YTkyHWqcmEbOQ/Y7T26YLbBzpfIDQ2ytOQDeWkLm/GlLWGMMn4DfE4uP9pMEukVk+An9dJPkJgcflTnGeMMS9JsZnNctmAZGpqqPp+KgkssvL10G08Az6c1B9tLiW6aA8IjkMj+L2Jcnjr/k6kXa9XdkPnduUygxkfHQGKRFyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318557; c=relaxed/simple;
	bh=FCp6/F3rxkkIQHSvhpNqC+GBTT26LI480ROwmICs/QI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPspOt7UDbCDDtaf4gMX0iSrhysyyTuMby6zn3typVaLk1XJC5CVfCYozpyLDwXIvqNdlk/Co7yCkSiVSzvygmdcteSR7UmxHfl6aVFHyc2qcwe4n0jjCxrnRFkgCAmt9c6NC2UvbDHnxpoZasKIUwzCdKE56M26BlovbFjhF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO8uLUDY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77250e45d36so3380062b3a.0;
        Mon, 08 Sep 2025 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757318555; x=1757923355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7L/8llJEdSIG4Nfg2l+GvW6TEBvITMkZd39Mo6ER7CQ=;
        b=QO8uLUDYElIPW3XsW48LxUtgzBtjKQXXZJJkt+01bDW+uGFrPoV6xpvdny+l9Ibo96
         vBNTte32jGj3fZ/G8YFj2hUDC20paH4vjlbqF5+GpSH7YaOAFKS4vGWEcaekOTKQnURd
         8acxzXeOFNjp33zmylb6EWFkipJpuNYAwefJoKgWK7F8IGs2n/bzqVLWd+wBdhgNgeEI
         RJEoSntGNV0DhaI1np7ua+01/nusC3MrykKIH34zb/R3oKxUJgerDPOnEsm3C53vsYCE
         GHB4cUnLifhiC72QXfsznXNbRwV8sHmhyJ/oWcej//iel7w3zkPRMWtmKQTG57B5bloA
         pb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318555; x=1757923355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7L/8llJEdSIG4Nfg2l+GvW6TEBvITMkZd39Mo6ER7CQ=;
        b=VxcHiMtN4Y5A4VOwTQ0N9E5wyM0cfxZz8o/70pnNjJOkbTxfI7zT++XzJUfxwU9Bhr
         bcBX5EsJVZMCYGUTD3vbalb95Hz5UQ6aQdeeM6PuPz04XslaRNOCRS6vz36O70xYjIGv
         FV/osjXHz2QWtUoBC1qVDqOKej0WUCkjNBdxJD3PGyvD7bKzx25jDkbJwRUYdgmV3PaX
         uOr4+vFvK2+2Zv2pFMHlMNpb8PAX/f85D9IqTZ6BJXFhbaIuvfTw36OG2AGyZrQBDapx
         gptbDBdqFTB3G4NOOZJO0/NNW31h4TD6WtGmZJdMuQmH3MMwylwXKcXEycwKQ5gRRQrq
         XNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE25Q0/pmtbRB+0lPXXEaDQuDgZhIFFs4Ne9umDG7vronMoiIWIMFMBjkbvHbOG6jLvJuSAyUrL1/7@vger.kernel.org, AJvYcCXJ6FqJfyNKupXYSw/ctvCZ3D0s6XIBkMpXcviRKF4beMHVsOL1FXT9fsn2jPTQtu8DhSCzO1CBdt91w9BE@vger.kernel.org
X-Gm-Message-State: AOJu0YyWV6eo47khqH7Oma9oedpXRhDjGS4NFesTh5p8n/4gem2AOTub
	Q0WyofBnFbpzCKrJ1hwfhIkjz6m/PZplV0heWnDKKUOn95xb5r8Mc7zZ
X-Gm-Gg: ASbGncuou1pZwBRRyBuRI4vXqXrLqlkA4IhSD84v7QKH/etrNYxvozvhSSryQY7yF4I
	m8TS1iERIg1dTvfMgrxf1Krik7oM/+cRLbtozyNubVcJSEPc3h6ukLWFpz8x8npnOMzxQq55le7
	v4E9X06aZZB4AlyRXhMUqudgcNQu47SoteHHWir2NQv8hshCVf3RoahnH0eExHpoa69/b9HbmLS
	ble9E56hdkLhtHBrq1/AuefvbCMKLVzvezuNyLiDtDTMzZGC1KUV6L3QSpE8+aTM2JQNgSKKgVq
	FnTClLUkGQyjA7BPayxCR1WA3ej8NznkhZ/RIg97+HF9oEXSUg8+4M73SeRZ+LrnjwogerJiI0t
	lwvzCmAmYbGW9lRfhjqrnRYLIfNHyssHewdAQCymIq0gm8wnxssfxBkp3gDLwMu8528CmHu4E/7
	c3+G1DV+RrwsraNXt2sozzadHjYnJB3sivwjxil6al1KdMfnNGPleonhu59bu2Sy5+lDalIxfQ6
	pKduQ==
X-Google-Smtp-Source: AGHT+IGboyEkG9gWXFOkl88XKtiOMptf6/1xvI87ICp5Zjmw//pmeh9e60nsTnkc1Awdr15nSl0vZg==
X-Received: by 2002:a05:6a00:181e:b0:774:1be4:dced with SMTP id d2e1a72fcca58-7742dccafdbmr9530181b3a.9.1757318555079;
        Mon, 08 Sep 2025 01:02:35 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm15186600b3a.9.2025.09.08.01.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:02:34 -0700 (PDT)
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
Subject: [PATCH v3 3/4] ARM: dts: aspeed: santabarbara: Adjust LED configuration
Date: Mon,  8 Sep 2025 16:02:14 +0800
Message-ID: <20250908080220.698158-4-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
References: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
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
index a453f8dc6b36..de624f4a33f3 100644
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


