Return-Path: <linux-kernel+bounces-818033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DDDB58BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4E77B08A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C264204096;
	Tue, 16 Sep 2025 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="Eb2jzNPR"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004BD35979
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989964; cv=none; b=lfsQ5eBKA5yht+QrQOAQj+KbRlOfsydWaKkDBzfMGYEgKWQ7numPcJ8OoKrWqWGQuoGMrTgsbfd2SabJ0U9DU5M7x0uFl/jgtDqknh5r4DAP3VMFXH3HAUjvAwjR/LQxotqCoSJoASQffyH31zOc0j802V9X0V/q0AC1TI0mnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989964; c=relaxed/simple;
	bh=a4Xw2iLxDUzyz7eq8OF1R9c3YLE4PdzVtLs6KNJOq4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2PzfOXgnBM/re+qW5IM1G+lVjI0DDXkvgWOmMxS+HLp43my4WV12zaHkmfHHzP0r8cxpLBYJ2zWAjEqbhbkaZeAZvrqJGXY4AkokTVi5l2E29OiNSile6B/lPIr2tUlG4SeWc66drD2AtJvEExOjB9tIvg6o2Q4M9EPdbukhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=Eb2jzNPR; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757989961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGHWHtxYrh7BhZTaz7WCOtU0mmIBJYnKsduPAHkKxfg=;
	b=Eb2jzNPRRJAGQU5mqxLFlfAK8RQsO0ZdVk/5Zayx9MnPErLjr2rjAS7rSxwHiWh3z/XoUl
	FUKVthXz9Sll+79o+Il7ih9O1m9DFedciGkw2123S/obSUMtOC6nXXtlejr9HUNnGMu9K3
	AjY1IKGcqbFgzX8wTXcbEH+dOiPKPmiFganwzUS5Y1y4GxCuFoj84VQxpuLQHZ0CzD+lUU
	GaJg1UFbyd4xq5ishI7tqws+reUERqobXKP2luJs4e1Vko86Cpr4J078wB8PfSnoX6naO8
	kGRoC1Gez8NhcXDK6Z7qg9qDwOge0VGABut68dvzpX29VZhqyq3srwv4M1GEtA==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Mon, 15 Sep 2025 19:32:12 -0700
Subject: [PATCH v2 1/3] Update MAINTAINERS for lg,sw49410
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-judyln-panel-v2-1-01ab2199fea5@postmarketos.org>
References: <20250915-judyln-panel-v2-0-01ab2199fea5@postmarketos.org>
In-Reply-To: <20250915-judyln-panel-v2-0-01ab2199fea5@postmarketos.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 phone-devel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757989951; l=814;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=a4Xw2iLxDUzyz7eq8OF1R9c3YLE4PdzVtLs6KNJOq4E=;
 b=2NG2Va4BOC4emWOZSkySoPI75aAuqbKuwkpVOdNC3dtP7dOthFKbGd34Tlpo7RdCzG2GHs6Mb
 Q3/Mw+RWO0VD9rl5jOc6RyHylPENpcECSuGexoO6twFqt1kFCB4NpsJ
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT

Add myself (Paul Sajna) as maintainer for lg,sw49410

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..f6c7f3cd80d7db6551351432215049adb3a5f626 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7584,6 +7584,11 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
 F:	drivers/gpu/drm/panel/panel-lg-sw43408.c
 
+DRM DRIVER FOR LG SW49410 PANELS
+M:	Paul Sajna <sajattack@postmarketos.org>
+S:	Maintained
+F:	drivers/gpu/drm/panel/panel-lg-sw49410.c
+
 DRM DRIVER FOR LOGICVC DISPLAY CONTROLLER
 M:	Paul Kocialkowski <paulk@sys-base.io>
 S:	Supported

-- 
2.51.0


