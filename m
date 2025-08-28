Return-Path: <linux-kernel+bounces-789465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED3B395F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6775E767D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A02D0612;
	Thu, 28 Aug 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFSIbeLY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14F2D9794;
	Thu, 28 Aug 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367412; cv=none; b=i66EUL+dU3EKap2v3Er0LQMXhybLl9bylaOGfTIXrZ1a7p5eqvOYfhue8XQfQbY07VBime3Zkw6NDp2yzB5iOqIsr976KzgTkmsUKhEiFNiyj9mbzeTolqfSSlfLq+axFi3YDmEn+gKT2P4pL2uFcqiKtre5bKUfH1UhW6lIBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367412; c=relaxed/simple;
	bh=cn0ZgqcOXF/a78yS/5vC91GaOee1SjCOcAtbNrgNmgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwZjnQ+Fps23Akw1ZvBFWlhs/Ca2ABkbaHVjTw68JSlcgKFbEzUy9RTA0xVh8VPsxmAMOzav8Gxl1b+OrsCUnAOBiVgtC0TvMwmUdTHBzHSeHTtZrXRrvG8TOryr8NnIOBpTu6H+n/OFUYj+ovzLzWLXoi7UXA0VP+PnHh+7O/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFSIbeLY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771f69fd6feso828489b3a.1;
        Thu, 28 Aug 2025 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367410; x=1756972210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vni583dy1qPpKoeI/BvuSUANKkix8/DHWprmu6YA31k=;
        b=QFSIbeLYC9pQK/GMJanDMKaSUL09VLfatzxsUb9nkzemsk0JeTw5bQ5+Gf54HUWZi3
         vsL1m9DHUsPOQfFUyXUmKRYy//q4rE6Vi9apreOurnFsHVeHA9E7syP3MgL96UeqXO9K
         3Bu9JxE319y/N+NiXGJz3E1QpQCO8SefyEqR2CxbQl1JeCaoNHIAbd5B3f8/4BZpfV04
         ooQQS3Zu8+nMF9ZJBcVux+HEN1kWlFKpEoUMxqTqJSpKm1uf/xosoWTPKlvpc2c+FD+A
         R6E81NSEUfKaE+JM6uaMgjJ0E8dyMEIaY5bj20oirUE9GIok3N0FPymruyO3v0DJ5Yo1
         BXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367410; x=1756972210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vni583dy1qPpKoeI/BvuSUANKkix8/DHWprmu6YA31k=;
        b=HFfRI3adtCBk8TiQFFWsgzVqMT3rqmmDlfF4fx3trYSFRWkPj3pHGZYI9BDlSQgPbw
         3C4kpaXPYnruyF7jfnFBqWzP6k1iQgY5rWOQIIwK9LjjkMJ+Zrta1YRK0Ui6OgZlIn19
         OQT+tV/ysEQwMhS4FkNOrD8FLKAA7evSEM3qhkpMZ+1crPaAJap0vPLY8LPrMOgVh8lf
         vnTynssNHMXLXJKkCQu46hMIv05RKxmrpTvM4JHci9LpQZnU9j3JTXxPup6NArRxXbQ/
         SDkNItgfREGkCzUKxq3F9hnaeusi1aLlbXbvCIAURjG4z5IOxfqolHOYp0RaV3E0CDgR
         bEfg==
X-Forwarded-Encrypted: i=1; AJvYcCU5mbCu9urA3S+sp6tVzSi7V3u8kBEEZHidxpsR6EJkFblhho15UyRwtQsnRklH8ohxKJA6mSurrvvVAAXz@vger.kernel.org, AJvYcCVx4/Y6OweKnYpUBH08ilYaVZPDjEE+IzTQA1oNbmAl5jdWVqsSz/cBwRMeZJg6/QaS2oGzLa5qbk9Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOUDOpzrIlco6fZLquWrWzFhGRfAiobLMSpXfJYI4m6R3Jtsa
	0MxajV43HpYKCmh1OuuhCvOBS4oiEChx5+02LqAuHIWwiQRtfHSJ4iUJ
X-Gm-Gg: ASbGnct4deE1gQPdj0UGiwR8PDoVnXZ9ePCPeib7pIPqwEn82a/zljV3svRjMuzK2DD
	hj/GelAac6mAZ+aSlngFKyOMlfJw1PtuPnZ3UkEZOGBZHNNl6oGSOHOwm8DDx8YgxeBoGVdqN0f
	6Jf9/B3HtNQxm7yetyRLGtSLY2Y3zQUk9dIn+jp4HehVVzmDDXfavmBWG3wMjmQFWO2MWthsdIx
	Ev8Jq5IsiGG/6gZ7XeslDFZri/7TGp/sKuZSWzIg3p8Pi/4/XLz22gZUNSsAJU4SR4BwdsSLVgG
	lJgW6Pt2Ks9NvweBQQRoe+8S0gdhU0EcPQeMaZsiOxgTIS/YMCgxTSvdXHcOnXbwM9noYf7VK9p
	eQ85C4YF/1jK7ZKyaRtoF1VVpuYW09AJVrFHO7ghPI4c7bZkqxPoLmzW9cWE9SYxGhMzr3UuAmz
	fyWJ6RW8wvEX/geH8oILYM/4adqQU9
X-Google-Smtp-Source: AGHT+IF4HC4PbFCqww/SIqTzmzziaZEWvmMs4ySjP/B1BpUGSc/ehDGuZDBlPqwuqZKik/CkkD4VWg==
X-Received: by 2002:a05:6a20:a125:b0:243:aca2:e500 with SMTP id adf61e73a8af0-243aca2ec8fmr2970429637.29.1756367410222;
        Thu, 28 Aug 2025 00:50:10 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35e-4238-7ad6-5c9d-99c8-92d0.emome-ip6.hinet.net. [2001:b400:e35e:4238:7ad6:5c9d:99c8:92d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9d226sm13272038a12.41.2025.08.28.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:50:09 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ARM: dts: aspeed: harma: add mp5990
Date: Thu, 28 Aug 2025 15:49:53 +0800
Message-ID: <20250828074955.542711-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
References: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the HSC MP5990 device on the Harma platform.

This change updates the device tree to include the MP5990 HSC
(Hot Swap Controller), allowing proper configuration and integration
with the platform.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 81278a7702de..23eaf47a38e8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -520,6 +520,10 @@ imux28: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			power-sensor@20 {
+				compatible = "mps,mp5990";
+				reg = <0x20>;
+			};
 			power-monitor@61 {
 				compatible = "isil,isl69260";
 				reg = <0x61>;
-- 
2.43.0


