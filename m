Return-Path: <linux-kernel+bounces-814091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C07CB54F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953951B2002B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9A3128B7;
	Fri, 12 Sep 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2K7PFgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4D3126D1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682864; cv=none; b=Ee6HIWD1/ZGXbV9g1nuLTS4QzzA9tuznPnQqGEIHNNGb6d0i5/h3E4CbgFjq6VFWwQcycS9H4of1Hjk72DQaPV/eE0zszdXjp/3nHXKs2ZJuMb5RMducSgirfQy2k+wQy7m9THvWqEGmTcYB/tRWfpqk79AIY7e818tw1SjdFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682864; c=relaxed/simple;
	bh=7tcgIQOfiYiITg2uIpeiX/xHBaG3Z0kgPGNyIDQAn7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtPM7j0lYNvh/4Ch9bpQK+YTiAK4cjY55MmsiosHpODSQXU5hFOEZlOg9Cptrg/UWRd7tRE+8a5tA20KfyqkezHtAM0EsRl/F2cDR150PgoIuekEkY2fbrrwJ/rq+G7CPqVivebLP7O0ZH/KERqDV/38jpMh2rDMrUKbBCWPfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2K7PFgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDC0C4CEF7;
	Fri, 12 Sep 2025 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682864;
	bh=7tcgIQOfiYiITg2uIpeiX/xHBaG3Z0kgPGNyIDQAn7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2K7PFgTVLNqatLvnyKkFEEJIUKYDcHegYk8S8HfNVwp+dyfxCp2DykLQpAdWbgvo
	 RCdfKzF4dufGvcpTUZLrfuBo2D/2PzpgumMfwoNw6/XtQbLnMm/vj4YWxrDVvPf/+l
	 QxUylWkOJFqS9cHnfDZXsa+arAPAETr8st706846VURunLUPho5jrlmztNdwFk+IAH
	 TBBrff6Y/a7WSN9DDbqEAjAXPtMiFhxavNJnK+qvl/DLCZES+5t/Zn9U14JUwLAK3m
	 Xa+sFpmWFdEjg54uPVuE95crT62BjvQ3JpkEKvVIbDUMVnJQ61036fz0567WlcckHS
	 EsXLEgNncb5aw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/5] dt-bindings: nvmem: sl28cpld: add sa67mcu compatible
Date: Fri, 12 Sep 2025 14:14:13 +0100
Message-ID: <20250912131415.303407-4-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131415.303407-1-srini@kernel.org>
References: <20250912131415.303407-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Walle <mwalle@kernel.org>

The Kontron SMARC-sAM67 has the same nvmem layout as the SMARC-sAL28. To
To be prepared for any board specific quirks, add a specific compatible.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 .../bindings/nvmem/layouts/kontron,sl28-vpd.yaml           | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
index c713e23819f1..afd1919c6b1c 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
@@ -19,7 +19,12 @@ select: false
 
 properties:
   compatible:
-    const: kontron,sl28-vpd
+    oneOf:
+      - items:
+          - enum:
+              - kontron,sa67-vpd
+          - const: kontron,sl28-vpd
+      - const: kontron,sl28-vpd
 
   serial-number:
     type: object
-- 
2.50.0


