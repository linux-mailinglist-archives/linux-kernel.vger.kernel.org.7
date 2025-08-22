Return-Path: <linux-kernel+bounces-782010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88077B319E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0889C17612E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B43F311C37;
	Fri, 22 Aug 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tURL10Ht"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CDD3093A6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869641; cv=none; b=R92xfEfeg1E8j9ElAQ+iybuhcyEv8Imp6HigdynWy8b3IpT6KmKVHh58JlqyCpj1JDKfElWhtc17vhoJXwIq+w1AIr5DtjwgJKqH/tFw6ariuH6opoCH/fnUe03qsMcb7z078kfo6e+MNGfEFeoA4DDB3oREebQIpeq8ijRgRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869641; c=relaxed/simple;
	bh=8gAmAJpykAypxXShgpXJ+YHQRn2sBo0ccaC3j3ZbunQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5gaWaAmGjAAqGSa2d1nwPgwsh/On8DgN8IrIAzE8SneO3bnlKU/LbOve/ga0RtlGiRObjQZcKiQV/9bclfsClmHl6IYOxCdQVCDpT9mu/6BZ83WW5s7mt/turRGGw1lOejj1XwKyw4Bmm8C+ZEAphOy6no/Y8fPQWB5PT0FVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tURL10Ht; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7a01426so28360566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869637; x=1756474437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7AgEtBb3vOoQNSD1V/oSDnP6NsNXAYQ/9W8TOu1CYY=;
        b=tURL10HtuXAjkQGSa6fXu8Z7p+4pOSu8nWVPVI3RQb1kv4n2dcIopEjv5kbl7VwwH5
         nx4sL/A+x7s5TQF4nJJTtPpv342SoMUZHpko/uKp0JuHYCCzchjBfqUBvTDeFgestk2l
         iZjW6HMveMXI0CpLo7tDA1Sut4UaGjotyxKToJaeLR0SBbsx9qxdNsPjODpDfANSvySb
         E5DVBpXj241ZSWXQePkUuVPQ7ec1t4au8qHu/c2nxWnlHKjnwQm2FiY1Y3p0SfMVo1yu
         x8JJO+CqVg+X3tNGSapeoatASH6v2Hk9S/VVVSk6tHEUVBQ3CXp+kyXC4fC3OrirHHYc
         y74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869637; x=1756474437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7AgEtBb3vOoQNSD1V/oSDnP6NsNXAYQ/9W8TOu1CYY=;
        b=eYg1Tgxe3Mhv2rnSbpgoJS2TsYqpmLbhXEkETxMXLxNvij7LDEzwuaq6FCuYzaEbuY
         jHidiwTkJrWklbbYyLUdTf0xY1L4UQiHb315JTGkDNmaaA1Jh7oiTpt2hqMYgt/01tRC
         Cnx/+xsYxx+cJARpAdkVdVBlgGDln1IM/XtNBaXHPfZF2O48/17U3YJYZcl3w4ZwqEDu
         K8R1SP/nyhfu6e2omMXX8mAF7pbA4/R7jMZwFWJ7vD5/hF/qZigTBflgkRhiM3w70APy
         8eOQCINH0j1pzeV8wfUBbusnA8dyKYk2bEYr3rBP2BBnNvZGzucbT9nUcdQ/CWUhC//N
         QKgg==
X-Forwarded-Encrypted: i=1; AJvYcCXpxa00qYlsaKbvAY4go0SnMTjYSC6mz2U9jJa5Rxtcqiv9C6bt35uri1TfKWa4T7O9UxsvuDNu6NXzWrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaMa5UAYmKeIPEIITefseQQOAuFWsSFkXiBcnsGZU0V9WC2Bn
	yThH3awc9+f2RFAMcJVy2nMz/cgPrPmoRUMTQG1LnO+3Wk+UUNombsV0wefJbHh4ucg=
X-Gm-Gg: ASbGnculJy64yMb8R2DEo5DkB2NXRy5vJL15wQtdlSe/zhXh8YaV+ik9xo0KYKmyUv/
	Mp9Afs7vK6bUN9o192EDENxw95JLZ/H7Zt8Z+l+Dhqi3bSGX0YdPqJAl+77aVz/iqyv9ch2vFmg
	Ql8f2KdXfsXLN+SFl0XIbhpyXdJWyR7/pMA+CGguxbJ562QtLUg2wjWWeTp3wZkwpxXvXKvylR8
	3p9SMBDlxPna39vH8d6NiyBG/VU0VNFgXxhukas9lG0LhvJyWYB2SFxsWPGpxB8KlADHTAOTZAL
	U7uspSe8wYtF39pm8/8k+hUvIiAqOZ/BFYA5awgN2qCfw7HUcPv3c7TXPdcfGPuWrE91bkiQdEs
	xX1WscYEw0nXztRj0LndaeqjFEIilFs2eqA==
X-Google-Smtp-Source: AGHT+IH/6VeQRa8ABUMDHkBjRuY41G6A4Z0+/t+uoy9NDpnb7Tsxehzo4TRN5bsoBM6c2KbSAs4ROQ==
X-Received: by 2002:a17:907:9405:b0:af9:5a1c:fee5 with SMTP id a640c23a62f3a-afe2874f3eemr157690666b.0.1755869637355;
        Fri, 22 Aug 2025 06:33:57 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded537f98sm606493066b.104.2025.08.22.06.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:33:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] arm64: tegra: Add default GIC address cells on Tegra132
Date: Fri, 22 Aug 2025 15:33:52 +0200
Message-ID: <20250822133351.312424-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=8gAmAJpykAypxXShgpXJ+YHQRn2sBo0ccaC3j3ZbunQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHG/v9O+jMlw2u+lyTYeKytKAxYifhGbf4k95
 00iTqY4ap+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxvwAKCRDBN2bmhouD
 16O0D/93HxloowY3QN3qZHFlsBmzqZMth34C9pAi+VZM9XMjoB6UtQdNVJ83jatRMwB2lsEDIp+
 G0zfARYpM2xfgl5ADjErn3Fwp8fFUhaEoRPHGt1esf/p9cZ0RTpMjijio/ksouWAS+nHp1QhnX2
 rbR2tAwyJXbvAKHTqf78P7XsxHxiwtMVaPRD5yFzUFAi3TmF0EtKNEnkQPT7Cw8IKFvSoBcFDfF
 MfSmIQMZvmbi2ArMYSHsGANPNn2UktVIfvwni+31QpnKdoZ/5vsOkUmHOAmQ9bYyQ9pFfHR72xo
 6xEEJJZGrdoSyz+PKNTZChbdqHxoIThck51F/d+o3QP6+mruqVZA6I/BIKcsunA8FDZlthATwED
 7mg9iIIrheMOr5v9xcO+0q7bIKdxD37BxsFFoOvGUjfTJ6SU2G7985kOkPBIAAPrKSsCEIuS7+E
 nuLPB0l0XPt/iBRtLU+wPBLxo4tTuxIuORbvKK6pCsv5brsXiGk51GxsSbRDTVgOw3iWsgjIPIv
 9WvjDPYJzEZXloKkxfwemXczbOsV3p5LADssqUZw814DMVwrTLvhab/U6HOfCEXfz0h3u9fk/IV
 I5lpP4u1nwBcdsRv5/BL26pOy+EP65b+hdUpqZ8VVwGKlxLyse/p/3BMgdrQ52AdkrPONcJ/DSe GbHm0UuD21AQP7A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  tegra132.dtsi:32.3-41: Warning (interrupt_map): /pcie@1003000:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@50041000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 5bcccfef3f7f..93208eb72cb0 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -175,6 +175,7 @@ i2c-bus {
 
 	gic: interrupt-controller@50041000 {
 		compatible = "arm,cortex-a15-gic";
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x0 0x50041000 0x0 0x1000>,
-- 
2.48.1


