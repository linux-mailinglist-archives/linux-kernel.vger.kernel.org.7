Return-Path: <linux-kernel+bounces-813927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2864B54D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E5E188068C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0431CA46;
	Fri, 12 Sep 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZXtch7D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA653090D4;
	Fri, 12 Sep 2025 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678891; cv=none; b=n2HyaMe3RBdv8Q9y4ax//cYyHCd55F4B9UzRrXRzg1b2Kj8vgWgSiZtfnyAszuv/Bgk1zYRF6TJEeQcOmaQE/dx4LvADp/T5CLnyowvKYj3ZCQv+h98ynyPvErE/uISu7ohY3EuducbfDkO4R20eD0cf1eLkB/07XscM3IU2yv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678891; c=relaxed/simple;
	bh=RUMJQPe0AYRmGCrjxRqp1GqAC9UdgedOdf0x5X2StKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibYliJwmuSCMK2E4TvAs6WtGEe+DIuzKWKo2S0GHMaKUL7WGQll45lfw3m8KNZnbxe35ecLW4ArK7y8qeEdFEzjt71hhDaA0frYG8sOAdBKCVrc4G8gnccExlL1vkRg2zq9M22S1dPjxof6V4+9Qb3NRtwNBiNh8agZv9oz2xIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZXtch7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEC0C4CEF7;
	Fri, 12 Sep 2025 12:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678890;
	bh=RUMJQPe0AYRmGCrjxRqp1GqAC9UdgedOdf0x5X2StKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZXtch7DbphlH/t0FUjTLyGq9EMaAxNe+J1sx3DWDGZ9ubttXK5+YMTdgkyOI7KHH
	 lvalM7RY65xJH05mFl0oD0St2juX5M0DJ1lutJmodklbXwvrpXjuz7YxZ+v+xTS5it
	 D3v9y/TmzvsSSEujL8jedaXh23v2ojSxE/8BFASKOVwgUqcUxf8XgKWbvz2hLTisn5
	 inttQTmQLflz7CtiW1+H6lvBP91E3h5EinHJjtz9y05pMWhS2wVFfBdujugQoSLyu0
	 YSZA5DyXT/xfGxK3nh0uCHbVUpbVZkvlygc++lnmHC4SW8sG6hoidj00gVXtmL9IzV
	 wwcY+ynyhvoIg==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Andrew Davis <afd@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/7] dt-bindings: arm: ti: Add Kontron SMARC-sAM67 module
Date: Fri, 12 Sep 2025 14:07:39 +0200
Message-Id: <20250912120745.2295115-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912120745.2295115-1-mwalle@kernel.org>
References: <20250912120745.2295115-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for the AM67 based Kontron SMARC-sAM67
module.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index e80c653fa438..af41f1541850 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -181,6 +181,7 @@ properties:
         items:
           - enum:
               - beagle,am67a-beagley-ai
+              - kontron,sa67             # Kontron SMARC-sAM67 board
               - ti,j722s-evm
           - const: ti,j722s
 
-- 
2.39.5


