Return-Path: <linux-kernel+bounces-748206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8022DB13DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAFD3BFFDF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BA627054B;
	Mon, 28 Jul 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="Fv/9Tf+n"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F05237163;
	Mon, 28 Jul 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715261; cv=none; b=Dx4f5VR3WjA6fctJZJyn0mUhzV46sWB+Am26wXvwSQNAxWrlsm3A6zPlxLB0AMOe2Mf66hEfn9L6hnSDejTt9oB78IdYYJO+a8ZgMKivWulT8mCbbO0p57krtj9c/OzlCokC2jFe1B9d2+kYHPn1JuOHk1nAdFdymGNv1qOl6hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715261; c=relaxed/simple;
	bh=P7GBGRaCytwVoPcpEo/GTa18XaJiFL6s41D1WBhUN6M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CZVVsu81jPnjxLII7vxoFKXpGpe77OnCVNHdFJ2vZXBKQcxLym1mBG/aqLSTKlFyzMbnpyktSbH7btO17mC3owEjDZlH/3KLWyRcRR2YaY65Tc41zf40DsO8Nn35psWZJayIuRFIpQCWRsqJV51/2bOBa68YiEqmyd/w98kfFWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=Fv/9Tf+n; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753715257;
	bh=P7GBGRaCytwVoPcpEo/GTa18XaJiFL6s41D1WBhUN6M=;
	h=From:Subject:Date:To:Cc:From;
	b=Fv/9Tf+ntvIQwAA/WeUFCxrd7jUITd4QzDkpOfqtvkm1zIi4bvpFwblU12Ts/ZZ1D
	 c44s8/32kZjWq/M6ya+jXPeZe5SI1JV6SJ9oNfu4eL3yHR8OdxiQg5bHN4WjNgC90v
	 Eiw6ys56iwzcERoZ9tCvsMWntMBiXTM9AvBhXXBt7aNXcfOVVJFm0fL99WFaYm/p2k
	 D81K0JsyL0KvZUR/ag98rHtH+4rbuB5AOCiHxfTUu6mSKADjut+nq4R54FFfi7aaWI
	 fHFGp0byszvYaKKbbd2rcPBpgg2z8k9EIbeXV5s21+cr/B5SPjnb9cHeIUUbH/50c1
	 Pb1k5HMesB0Ug==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:31ee:da95:eea2:34e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id CEFC827E434;
	Mon, 28 Jul 2025 15:07:37 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
Subject: [PATCH v5 0/2] Add Support for LinkStar H68K board: ARM64 and
 RK3568: dts and dt-bindings.
Date: Mon, 28 Jul 2025 11:07:35 -0400
Message-Id: <20250728-linkstarpatch_v5-v5-0-b4ebfeaca652@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADeSh2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyML3ZzMvOziksSigsSS5Iz4MlNdc0MTM7NUiyQzC2NzJaC2gqLUtMw
 KsJHRsbW1ABQT77ViAAAA
X-Change-ID: 20250728-linkstarpatch_v5-71466e8b6837
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Erik Beck <xunil@tahomasoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753715257; l=4590;
 i=xunil@tahomasoft.com; s=20250724; h=from:subject:message-id;
 bh=P7GBGRaCytwVoPcpEo/GTa18XaJiFL6s41D1WBhUN6M=;
 b=LByh55mLcNOseDPfg8APMtYS88e0An8W/GWWiS6utY07N47Fu/GD2mS2iXKWqg0jIGTkMMn0Z
 s8piwSZkclPA+WGnHwseU/PRu5r+M67JStj+Xy8uGqe3a93BP/lDXd+
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

(/* Thank you  Krzysztof Kozlowski for your latest round of comments. */)

ChangeLog:

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
Erik Beck (2):
      arm64: dts: rockchip: add LinkStar-H68k-1432v1
      dt-bindings: arm: rockchip: add LinkStar-H68k-1432v1

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../dts/rockchip/rk3568-linkstar-h68k-1432v1.dts   | 740 +++++++++++++++++++++
 3 files changed, 746 insertions(+)
---
base-commit: 5f33ebd2018ced2600b3fad2f8e2052498eb4072
change-id: 20250728-linkstarpatch_v5-71466e8b6837

Best regards,
-- 
Erik Beck <xunil@tahomasoft.com>


