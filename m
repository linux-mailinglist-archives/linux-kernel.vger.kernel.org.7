Return-Path: <linux-kernel+bounces-863063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED3BF6E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B6E19A02EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD292338585;
	Tue, 21 Oct 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="erg9Vheu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A862877C3
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054807; cv=none; b=hWh1IFTUkwNDvqo8pqnbvDDEpihIwhfWUJk6Mp27lP+W1av6hZCwJoBN7G8DlcY+j4i8/+PtX9ShAeR2ozRoXiLwtbp+kJM/SQiZJm2NbOPSxZMoItdZuVRDTZrXJNEtBDDm4AzvqZytT5303//6gUx8I2UZon39EO5a1rIk6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054807; c=relaxed/simple;
	bh=cc8ZBZFtHpD3W3PnRGNl7cj96+fGL6tAhxbLcqlVuDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8utXzQU+Fw9/eGAVBW1gY2ukiNfMc8lDvlo27c4OghK/nKXbSebHnZQVt2eVTUCwZTcg4nf0UfrRdsQDIODwbeI42dIoNHRXnZxtZRlej8TFZOGhgzZcvOgktIzd4lgRzAJMTeGmDhL/bOtHLoclzs1YP0S0gtlEEZFR0dRsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=erg9Vheu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3c2db014easo1238656966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761054803; x=1761659603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqUCglb+0FDwyycEK2V2KsoX30Sw+xzpkkOZ9ZURSbo=;
        b=erg9Vheu6gQPJ7kJeAykcipLXSsfzTWkNbuzpZIwPUcqhmeDE3TYeInFSKNL4SuUDC
         CUFYLPRTRplazp6NQ3xuqCW2PBXJ4iBLM2nFVdHHcbKJIIlp9R2oXgOavW5cim2Q0uAd
         qU4GtMhChH0JOY2NfyS5+NnG5lZoahJgEoOyp2BFBAVuSz6GNCas3NQspXsSl1AauEpb
         Evb1Gm+4f8LG+2ypmlKxf5Dk1MW3MG+lWX6QJsS5g3hOWft8dBvcYlQ/kHebjqy7aMaZ
         SDbzHCa1aIz+wtHby+ungo2IpQwtuRMGuRKZDfwhdbdE9pDRhmP8OowZc2TZrDBRE8uU
         yjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054803; x=1761659603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqUCglb+0FDwyycEK2V2KsoX30Sw+xzpkkOZ9ZURSbo=;
        b=Y3eB156b1S1LMX4mHNcEfvWXt/uXeZVDTNFKY1PlfzO802brIxpL3Dx49TvBXGTRfT
         U7EQZ0sRIq/JOsi+9BXEQdl193AImXP7dHyJT6Q0XlDGbomLpvmW2MPkULXc60LOnzaR
         9fyvZ5EOvDILj86u+O9zdGJE4GGkiN/jJ7wX5LbY61fkjukAmpqTOSc8hXEZjytCmAKL
         3K0J0bH5Q0u+gtE338frREkCHLjyDhJvA5ku+kYdqAgOiJ3Sd66k/H5jlo82006uqYR1
         uUgwAOvnLZWi8RXcNYfdDqxGp+71LUtsWiBZTU87q7x79NDOAoNArDwMNuSKSOy+STSI
         drgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKgbtsszJ9vL6umbU7Tm6IQZSuvZiez5ynysaHr5V0rZZP2UyjdGgDXd5NHa6N5gI8Ir4cdUYqvMo1oj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRhUtaxluu+z+M/LkSFzuAW4tOzapAX8ivspi/HIzU9yeCjJ+
	KN+ZBcTONmzLRE7RQnQ15QG5LP8mikGw7T9GJDGZs0TJfwov8m6NASePMoxqkyMl4S4=
X-Gm-Gg: ASbGnctJCTIoO1lwvz1k70xGVUDv2jIaHiAlHjr1ZjaSgOlXCf/XL+QI/1+PybKmn8s
	avWwgLLld0QKouHSwmeq2/Wg8+nmC8l6qKDZBxpi2pY/2kGdK7hMhpwg1+HCgvwgPlHaV3mO07a
	ASlYGryub1AKGlVhOx91OsD6Kv+4IjA46atVTdcnK6uc9OSLIMKm96PqbOxBZykir2MXzu6RUNs
	B5sXMG1XcdwvOvuQldrgII4PbLnm/u84B0bngi2lwhRBMEgMde2wsndK9OP9wBt0CMoIveorhOu
	AiS+nsVYH0aRS2TREFHSFlWPcc2UZ9PWaBds5lmMJsqjZhLiiA1VcMp8rh7CkDZ8YNS3DE+uJeY
	8FtI6QKrrPUSrCOhYd9e5rZ639QNsfGG1DxIUyHMka9iSm39igbmKCcSNkLD4FFpmPTCrcw1RQb
	L/EFF1PHgQqnpaZX/JxMT/lSOUThaHBttG96ICTJaHUQCsFVIlHRIGck8NuYM4ew==
X-Google-Smtp-Source: AGHT+IGzJ1sMZhzOVfrRQ+JvVbLUEVExvUKiHVvXUfDKq0+hkvumJylkHNfbe6040lXwumRTHkh/Vg==
X-Received: by 2002:a17:906:9f8c:b0:b40:5463:3afd with SMTP id a640c23a62f3a-b6473147238mr1967688766b.26.1761054803200;
        Tue, 21 Oct 2025 06:53:23 -0700 (PDT)
Received: from localhost (host-87-9-62-200.retail.telecomitalia.it. [87.9.62.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e50da6a6sm1106448666b.0.2025.10.21.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:53:22 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stanimir Varbanov <svarbanov@suse.de>,
	Andrew Lunn <andrew@lunn.ch>,
	iivanov@suse.de,
	mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH] arm64: dts: broadcom: Assign clock rates in eth node for RPi5
Date: Tue, 21 Oct 2025 15:55:33 +0200
Message-ID: <20251021135533.5517-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Raspberry Pi 5 DTS, the Ethernet clock rates must be assigned
as the default clock register values are not valid for the
Ethernet interface to function.
This can be done either in rp1_clocks node or in rp1_eth node.

Define the rates in rp1_eth node, as those clocks are 'leaf' clocks
used specifically by the Ethernet device only.

Fixes: 43456fdfc014 ("arm64: dts: broadcom: Enable RP1 ethernet for Raspberry Pi 5")
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index b8f256545022..09a849dd09b1 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -23,6 +23,10 @@ &pcie2 {
 };
 
 &rp1_eth {
+	assigned-clocks = <&rp1_clocks RP1_CLK_ETH_TSU>,
+			  <&rp1_clocks RP1_CLK_ETH>;
+	assigned-clock-rates = <50000000>,
+			       <125000000>;
 	status = "okay";
 	phy-mode = "rgmii-id";
 	phy-handle = <&phy1>;
-- 
2.35.3


