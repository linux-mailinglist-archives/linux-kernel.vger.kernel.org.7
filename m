Return-Path: <linux-kernel+bounces-854688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8A4BDF1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18D424EEB13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80832D3EE3;
	Wed, 15 Oct 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjLOXxzc"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AF2D24B6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539174; cv=none; b=dcADi5YjAyFNWE28MqYqwT89hUSf0GCxrTJB9tmA6qjXweN6tTjWQLoziRlaCGJ+SPHnHBEOrzgp304ez4m48DHtcQ2PskV9GQA5jpcwDxd07NvQ0SFqpRnGrP7TH5ka9whh5eakE1N+JWsyEIjPYowuawS5kIOKtYtgRSvL778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539174; c=relaxed/simple;
	bh=AzyWtWcVDHS3YUe2MXPBE3luV5G7bLlUdIrIjbCCynE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBU1ry7ij/4RVvM9t2VIx0Y0X/GDl43W/5ztqj/TSmafjJXMv+k9eOQQtikvGd5EnZbUsik/Vofvik9GK4qH5O1nBPqDNMlJvvjCVR/N2nVtaPBLtwKWQJ+jckdh90q4M4E5zAfK3v3UupTCakEb7K4zeUsoW/8TtvDjS1oD8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjLOXxzc; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso4214704a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539171; x=1761143971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oianJSkzTRF5G/SQIYeXjnYqhxQJXKeLJMnXmoruyyw=;
        b=XjLOXxzcghbvimP92D7i87LImR5faHuNtjUpydVLc5fOxA29RBeNFhU+hG+JUsdey5
         cDPZ6l2IPapTZFptYl91sSr9USfSSkXhRls+VMKNOWzD+9vNOOwcDueHx2Kxd6KZECO8
         5PBDwXVyySV/otNcrC8PO7NYArfuYHMj6pC4d0BOAvACdFRf0AfdwxvkKlTXozwKOfvp
         9nSxAf+bGnvbkwMh+S4uvB+1OQm3nI8w4tfJ995F8jFmKp0gIIbLhcUuDZ4kpbO6Wocn
         V5FbVTRTZ7L/2xEv+IONGMGhlEkj03KEu5sRZlmk5GNddCsRAhYlBedhsuooGTzqYjAl
         1lQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539171; x=1761143971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oianJSkzTRF5G/SQIYeXjnYqhxQJXKeLJMnXmoruyyw=;
        b=Pnf2DOz5W4rSCEdZpIHd7x7Xfhf6zT5UfLAwVlobJNiNrrJE2rq5KXpBIicHW/CRhm
         gYAwocdxiDd4VSwndKWR1SZsyJ0omDKuA8SHVrFHfSp88FdY6ENOsz52sv+Gxp6Beq2T
         GJ6FCgNHJ2LKJgE1XlJpGgiwdpOORa5jA9oTH9y4xmc9EKDiNRmdWkUlFxDXRBIfgBEr
         wgdTpuAcftez8PGQQI10wM1dxbaIjXKqse0Ho5zq6p7UtoER3/VU+zj3s5UJCmlOxWw6
         +pKXaf0pAkjv8oejuwVAeDjHlCOlEG9xUbWetgpGIDcrtGzPbEoFfjNk2/1TltI7mD+Z
         k8HA==
X-Forwarded-Encrypted: i=1; AJvYcCX0d79emVIBbkjOtyHCAHd2Yi+276/pElGoScL8gpAj4UayHhkl2m8SyTPR0mPItA6yG8Ea+979zd8yo5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1FRP0fj26vd/EvVjuUTe8U91HMiR3Le8tLofvzH7PE9O7OJH
	/VgaAO4SkMflf5DShVeYCkxKpKk4VrOvZKRE3lT9Dn2ev79hLc8Gw50O
X-Gm-Gg: ASbGncvpW9Nma7CcG7pWRMwV0sGZocE0nxBmV8dqZhF3vrpA5A6+oc6sMAAEcwcHJ93
	4y62+9GrGvy95TW3V0Vwe87zfBuVfK2KFOqiYj1QK19bPry4FqI1wIQcpa7WR6SuxL+MfGp2X8H
	cA/sF9Ytd2MjmRZwJXJCEraR5rq5v/v5Wjz+hKObijCOLIrom7T8Itp7QkRa5+yux8LE0Kos2xE
	ZKAsZd0ZtlVcGFfiQsSmh9QFJMwmiKvgVzHMp9ZN72AAFtewVvOjZZlcRw7mDTFPrGD4LOksMGQ
	RjEHmTej9IKhoAKSCCmejtOuOskhSGNix0GJfOgEihcJQrQVz15ZcP3gj4+bWa1oDGmGPZWl8lf
	/GnW8hjdLxh4lZdK99sQepWdMgfYDVSE7L8VQNQptDeVhAod6/5KkRnZtTZUSZ3oKZpORgxSTLZ
	lmDf2zea2CMjWULC1koXpjfJFVmgup/Un4WQLSR41/auvBqtpNxrIxIRfQ23f/IURW
X-Google-Smtp-Source: AGHT+IHQV5VLlGEJEx4nThpYETPXzWBCwzYZ1PXelEFJYlRZ0x4BxIFfLFgQXf99ujEGLB1D9HXqKQ==
X-Received: by 2002:a17:903:9cb:b0:266:702a:616b with SMTP id d9443c01a7336-290273799bdmr348708855ad.18.1760539171032;
        Wed, 15 Oct 2025 07:39:31 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:30 -0700 (PDT)
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
Subject: [PATCH v4 3/7] ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
Date: Wed, 15 Oct 2025 22:38:59 +0800
Message-ID: <20251015143916.1850450-4-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
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
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 89b18afe2b00..b190ab344aa7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1279,8 +1279,15 @@ temperature-sensor@49 {
 };
 
 &i2c11 {
+	multi-master;
+	mctp-controller;
 	status = "okay";
 
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
 	// OCP NIC TEMP
 	temperature-sensor@1f {
 		compatible = "ti,tmp421";
-- 
2.49.0


