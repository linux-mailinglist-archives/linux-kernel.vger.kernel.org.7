Return-Path: <linux-kernel+bounces-749518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B3B14F66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9483916DADE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1C1E5B7C;
	Tue, 29 Jul 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="mcRVOy4z"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121451C2335;
	Tue, 29 Jul 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800010; cv=none; b=GsHAwRKWM3JUQM87S9nVCInDtvjDI6n9g5ZJg+p/vB6ELjwRrF6BUD5WyEHqRiy0hHCWlxKmMrlq+s1IxfpNQUIhvwBA85zk5pnVhBD6tIeeYRVCqpoft3AcBHuR0Cx2XkgFSyaX8gwuYz9LNu3kfB0Nit0SQdMi2JK01rHjDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800010; c=relaxed/simple;
	bh=6fv/yxfI0HkZptw0QcDLPYXU5y08P7QykFX2AxkYUuA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b7EDsGgp8dTTOGTSYD0Fiqwdf6MSc+ICBcoIOSAWjLXnPLsW5BGNsGruD+IrB3eVa3jnM308Kq1oM/K/uE3iyx7jT1kmmLDOr9MAOb4DOtc0y7YJCnEiZd8mscq8IaoVwYONEJLsRhJl+Yy2kJepEbXcFxxBzJIAff53SEYKiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=mcRVOy4z; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753800006;
	bh=6fv/yxfI0HkZptw0QcDLPYXU5y08P7QykFX2AxkYUuA=;
	h=From:Subject:Date:To:Cc:From;
	b=mcRVOy4zp+xTP1Rxjm+6TlnymcMGmPZ3UMgrcidz9o842ZMnUgMrXl5ahHdoI2iBc
	 hPrCVrDbYc6RVvFC0x4zSOXZT0GuAsC33TWoRx7Sy32sSx3hR4Y5trJ6ypT5JaQqXZ
	 MF5nHSfio+YmyJMoS2A2N44KILcSL3Tmlx5qhGTfidDypFBWo6tXDBsFe/CKcHj8E1
	 ASpOJvLxh2ltyl/4FJdiNyWYRK+sTpCJ/55+lVx0Xe7sCSeEntSIHV4R4uI4XC+DQR
	 JkIJcobP5OSHLBpViWpJYk9E/l3RJK/rCNdZDX6EGvFlDYRHPdWR9tclM2ogXkA4xz
	 CEAwlFKh7EKuA==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:f717:c76f:99e7:4a24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id DC47027E434;
	Tue, 29 Jul 2025 14:40:06 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
Subject: [PATCH v6 0/2] Resend: Add Support for LinkStar H68K board: ARM64
 and RK3568: dts and dt-bindings.
Date: Tue, 29 Jul 2025 10:39:50 -0400
Message-Id: <20250729-linkstar-6-16-rc1-v6-v6-0-92307f465835@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADbdiGgC/4WNSw7CIBRFt9K8sc8UaGl15D5MB8jHvmjBACGap
 nsXuwGH5yT33BWSjWQTnJsVoi2UKPgK8tCAnpW/WyRTGXjL+3bgJ3ySf6SsIkpkEqNmWCQ6y0e
 he2GGzkCdvqJ19N6z16nyTCmH+NlfCvvZP8HCsMXxZjolhROdUJes5rCoFFw+6rDAtG3bF2OFp
 m69AAAA
X-Change-ID: 20250729-linkstar-6-16-rc1-v6-fe283c53d74d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Erik Beck <xunil@tahomasoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753800001; l=5247;
 i=xunil@tahomasoft.com; s=20250724; h=from:subject:message-id;
 bh=6fv/yxfI0HkZptw0QcDLPYXU5y08P7QykFX2AxkYUuA=;
 b=o6P6At8FiUw2E0BRyZf7V0PYnM4+hw2T98poG/cthVi+2/8Q6X4kd8Mld13hydT2YevGX4Lf4
 QqVj3bbRPd+CIbUwR5ZSoCfEz07FSJc28dNLdUiEblq1TIEaJNEnAtK
X-Developer-Key: i=xunil@tahomasoft.com; a=ed25519;
 pk=FTZVGUexvkWb4j8v0wbtm7CtJLijIAaa5x0XV72WWC0=

Provide support for the Seeed LinkStar H68K-1432v1, previously
unsupported in mainline Linux kernel. It is a compact single board
travel router with the following features:

  - Rockchip rk3568 SoC;
  - Four Gib RAM;
  - Four ethernet ports:
    -  Two 1 GigE ports;
    -  Two 2.5 GigE ports (RTL8125);
    
  - Ethernet ports support Precision Time Protocol (PTP IEEE 1588);
  
  - Four USB ports:
    - Three USB 3.0 ports;
    - Two USB 2.0 ports;
    
  - Integrated WiFi:
    - MediaTek MT7921e
    
  - Audio and video outputs:
    - HDMI;
    - Headphone;
    
  - eMMC (32 Gib) and microSD storage;
  - Real-time clock (rk809)
  - Powered by:
    - USB Type-C;
    - Barrel connector (DC 12-24v);
    
These patches:
  - Create a devicetree for the board;
  - Add a (dtb) Makefile entry for the board;
  - Add the board to dt-bindings;

ChangeLog:

/* resending with patch version noted (v6) */

v6:

  - Responsive to comments received from Krzysztof Kozlowski <krzk+dt@kernel.org>
    - https://lore.kernel.org/all/20250729-poised-proud-ibex-5ab838@kuoka/
    - https://lore.kernel.org/all/20250729-passionate-jerboa-of-superiority-c7aff5@kuoka/

  - Change made:
    - Put patchset back into proper order, with dt-binding before dts,
      per Krzysztof and '.../bindings/submitting-patches.rst'.

(/* Thank you Krzysztof! */)

v5:
  - Responsive to comments received from  Krzysztof Kozlowski <krzk+dt@kernel.org>
    - https://lore.kernel.org/all/20250728-dashing-discerning-roadrunner-bc8b87@kuoka/
    - https://lore.kernel.org/all/93c39b36-07c8-4883-bd23-7d0194c50a7a@kernel.org/
    - https://lore.kernel.org/all/642df1ee-5e92-4f0a-bcdf-7e10dbc0d59b@kernel.org/
    - https://lore.kernel.org/all/9ebd9797-8d92-4799-bb8d-59a796e6043c@linaro.org/
    
  - Changes made are:
    - Revisions to commit messages:
        - Removed notes on base commit;
	- Fixed checkpatch warning;
	- Removed notes on device history;
	- Fleshed out the top-line summary of the dts patch;

v4:
  - Responsive to comments received from  Krzysztof Kozlowski <krzk+dt@kernel.org>
    - https://lore.kernel.org/all/20250725-muskox-of-authentic-gaiety-b8eda4@kuoka/
    - https://lore.kernel.org/all/20250725-nocturnal-messy-cicada-dbcc10@kuoka/
    - /* (Thank you Krzysztof!) */
    
  - Changes made are:
    - Clarified the base commit working from;
    - Base patched against:
      - Commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494 (tag: v6.16-rc1);
	
    - Revised commit message for devicetree to be clearer, contain
      more details about the hardware, and be more succinct;

    - Revised commit message for devicetree binding to be clearer, contain
      more details about the hardware, and be more succinct;
  
v3:
  Responsive to comments received from:
  - Chukun Pan <amadeus@jmu.edu.cn>
  - Krzysztof Kozlowski <krzk+dt@kernel.org>
  - Rob Herring <robh@kernel.org>
  - Heiko Stuebner <heiko@sntech.de>

   /* (Thank you all!) */

  Those changes are:
     - Removed copyright line of <amadeus@jmu.edu.cn> per their request;
     - Fixed indentations;
     - Replaced space indentations with tabs;
     - Packaging this patch set together properly using b4, fixing the threading;
     - Clarifying versioning and Changelog;

v2: (https://lore.kernel.org/all/20250721201137.233166-1-xunil@tahomasoft.com/)
  Responding to comments received from Heiko Stuebner <heiko@sntech.de> 

  Those changes are:

     - Splits the single commit into two, one for the yaml binding,
       and the other for the board devicetree plus Makefile addition;

     - Adds other recipients needed from get_maintainer.pl --nol and --nom;
     
     - Uses git send-email to send the patches, to avoid adding line
       breaks from the MUA;

     - Changes comment style to conform with style guide;
     - Removes several unneeded comments from the devicetree;
     - Changes LED naming scheme with more standard nomenclature;
     - Changes naming of regulators, prepending 'regulator', such as:
        ~ from: vcc12v_dcin: vcc12v-dcin {}
        ~ to:   vcc12v_dcin: regulator-vcc12v-dcin {}

     - Removes unneeded tx_delay/rx_delay from rgmii-id
        
v1: (https://lore.kernel.org/all/20250718075058.243a5619.xunil@tahomasoft.com/)
  - Initial patch to provide support for Seeed LinkStar H68K

Signed-off-by: Erik Beck <xunil@tahomasoft.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250729-linkstar-6-16-rc1-v6-v1-0-8bd4a63f343a@tahomasoft.com

---
Erik Beck (2):
      dt-bindings: arm: rockchip: add LinkStar-H68k-1432v1
      arm64: dts: rockchip: add LinkStar-H68k-1432v1

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../dts/rockchip/rk3568-linkstar-h68k-1432v1.dts   | 740 +++++++++++++++++++++
 3 files changed, 746 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250729-linkstar-6-16-rc1-v6-fe283c53d74d

Best regards,
-- 
Erik Beck <xunil@tahomasoft.com>


