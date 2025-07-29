Return-Path: <linux-kernel+bounces-749170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3CDB14AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17BF189CB59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7521E0B2;
	Tue, 29 Jul 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOegPnYg"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2482874FF;
	Tue, 29 Jul 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780445; cv=none; b=Mj5O4nRjOBAihrARjUi9Ul9NR4UiPeGeCT7AJx3VuvjRUrVUh+gVKD6ZRhLRCtwc49pIajRwWa+hFBpskF3kxLorwM3mevV41yfU3yltWu942nky5+HKFVcRgpc3T5Ha0eeWNZTrG7vp6ht4AjsIX3NWcg5QGwuG7T7f2PaLkxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780445; c=relaxed/simple;
	bh=9kMuQKW4Z0YWZcFJf5QnFiW2s0f1P9Y+rOU7gLJIkZQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1bMSh08getOtVRzBeTGyA7R4HFl6YeYA0DjT3LfGFxUhq5KHFrt6/JphwW0WtwmNAXH87/UEuvivsUP0xYxplCLFJx06wPSzH+L5ydvjI4zIHbyuD/2XB5jWGMxiA8UcGVfO6ZJypb+XbN6l4XFPnN3w+k/AHV7os0eo8zlg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOegPnYg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74b27c1481bso3610637b3a.2;
        Tue, 29 Jul 2025 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780443; x=1754385243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
        b=eOegPnYgACodM017KBz3g3cSDikTFczeCj1iEJ6LvflFTX6UFWDrzbT58Nbbu8OHZf
         iRJ3+Ckh6GcmN661GOUVJVPu3BsJpXWO0LWBYYwpwGJZ6iEBt8zQzmBMpK9z6CwPRpdW
         xNsLxG/2MUmkfTX7kpU1/7FDq2gwtygwUTerTHXVGf9GIXLimp2ABpD1ey+u/3PqQZgw
         cQDaP+24PH/pJSoLWaUa7YL1G+A3tNfSCretattxsCl2DpnjBPQ+CXJstgoHWB4SfJIB
         dB7rTkbE0JgndF7JrHriM+tlBGOT6mDIe5gdyYw2E9hjEZafclcC1yNBXEXbBnwfyCaL
         lrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780443; x=1754385243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
        b=t8QAnsmdpFjNQKAGoZVmQUgocDhYkmlodpiuRC33jVUZeIRi8vsJn/iuFv2PozI0WR
         4OdcQk6vDglwWwDCSaXJoPMDChyX7wMz7QbnZbp3B/sZfiUEAVI29rIWyRXnN16T+k9M
         JBbFhNo0GAemJWZoUnFCmHVJIEVrtYjT/oel8D8aiEasRktR8DEftUXnbd37BASmVq8d
         EfoXkxavQT6qG4U04pXFw9woV7b5CasA6U4KJlVnTdah1Dq4eVJbFsmgHyb0xsijPiI3
         fXQaaIrqhCfJwJZXqYLz01g24wmQOfRLm7iYkzk3LJ8kkRnZtik98T8tkRC97I6Q0KFS
         yf5g==
X-Forwarded-Encrypted: i=1; AJvYcCWhx5dQ7gcJe/jBRmgnMM5cFrKAKUvDnKQhN4pGrLuqsPp8C/DogCTYDn3K2SaraE50+Mo745I1WrKA@vger.kernel.org, AJvYcCWxePTrzUWJLaax702/1JM6z0RSHeeNuSAF9YqWKyKweOJtKyaBnvXcs/mWlQfD4gku9SySKdDj/qdPngE/@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7vc3bSixAxbgBeq432WbcNGq+6/vWWw7Muxw2net4+d1Gmer
	kmJ2iyKyqjjDlMoCkmBXFU/evzas/ahYhb8wMa5yZDvrQVFWBJ6eL8Hq
X-Gm-Gg: ASbGncuFWoyMXmGzxycwXdJRVqKAHGFf6QiHVH0GsA4GyQMlVTKfiEotAlJoURY5Znt
	A0po1+bhqfI61IOJxRc6GDg8jEL2olf78rJc+uS1mAtXr7s4w+/neavGSqvpKpBbawEwMtpCQaN
	AGGDXWArLWkNJDqwBuYP+bkyf4S/znZWHZvOsFFebyKkCVVFSVtKts+kwe8xigOG0eHHBDp3fXK
	sJYdFa5urPm7hGRpE9Q7El4syagB2AjfyqvNNyP6zWUkow8zpv5DW0klxeqV/5XeNdNRhgRNrj3
	hKEp1iNgkOPggI+eqlj/K4/wN1MJ0mOAL1fQY9cIXmNhXzzUk+G8i2IH/laH1JpNzWb6kRMVf/j
	pfQuBkoFZRiOv9Dx44GnvEvcdbtvvf8Dp6sFgZqJIDfAWGH0SMATg6NBzcQ+61omrB3GxA8O5c7
	GoRMq+Kb8StakRyXHjlTRuEx6viJ1tZs8xgqCBRe/4Hi5e32s=
X-Google-Smtp-Source: AGHT+IE5de0i6/0ajEO85aIFRHzPN7aXOAjUa8N7MjCYc6cFnhkPCLV7DX4sN98WfDkKcoDvsFP22w==
X-Received: by 2002:a05:6a00:a85:b0:740:b394:3ebd with SMTP id d2e1a72fcca58-7633276c2b6mr21066948b3a.7.1753780442892;
        Tue, 29 Jul 2025 02:14:02 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e38d-c586-0429-5c72-053d-8858.emome-ip6.hinet.net. [2001:b400:e38d:c586:429:5c72:53d:8858])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b06ddsm7528612b3a.121.2025.07.29.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:14:02 -0700 (PDT)
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
Subject: [PATCH v1 2/3] ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
Date: Tue, 29 Jul 2025 17:13:44 +0800
Message-ID: <20250729091351.3964939-3-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the mctp-controller property and MCTP node to enable frontend NIC
management via PLDM over MCTP.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 2f5712e9ba9f..ed30f3bf61a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1248,8 +1248,16 @@ temperature-sensor@49 {
 };
 
 &i2c11 {
+	multi-master;
+	mctp-controller;
 	status = "okay";
 
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		label = "mb_nic0_mctp";
+	};
+
 	// OCP NIC TEMP
 	temperature-sensor@1f {
 		compatible = "ti,tmp421";
-- 
2.49.0


