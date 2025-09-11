Return-Path: <linux-kernel+bounces-811276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F1B526E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426AF17C041
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11A23D7D4;
	Thu, 11 Sep 2025 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="ZPrD0PjV"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE53722CBE6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560140; cv=none; b=LZ8XOcsj9IDEbDbXnIDydT433EBUZFzk0Hm0XwbXhJCYZFWxDMr4YSbXnT/1/6lQh4VjnTdaXVnw+uNiatdiVnowqp3QBtA2XIwX+BFeQ0YEb3DwDkK2UjLk2WmdN8N5HKzv3ugNs/iEwuP6/esbxlo8Uek/JT3ji4jjkU10jMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560140; c=relaxed/simple;
	bh=Wyv04p1vPaFXnDGn+MYaWjpbxivqD5UIWCuLT6Ht2Mo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bsh5CwQN/PgNeg9fJYYwy9B0VGqL632fisVK0vwEIFUuj30hwxfYInMeWdXlrFntvVyopjErgBmy7h752v4+nyL6tMRIfABdBNxNd1L+kydIb82PnMI5Z/79/DjUpBQR8xaixX0LqaQrc7NFN5RCMQf41Rso4IN/fdsZDoIV0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=ZPrD0PjV; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757560136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QnOR/jymtXa2WVfw0v4uM8w8LZkCHUggWlTkJYd2NE=;
	b=ZPrD0PjVbKGJ/to/Qz+4tzEfji7w5o3tMgDxikSC+bK8z+nCIqYs7rA67VWLgsqeQEXy8w
	IVNguIoN0n5nzL1d7qMqoUZCIxDNB2t/ZbqAqDUA6sXGKVyYdBZaxk7vqCQSUYd1WCoREa
	Hk80ln0a1zhBFKS9Ii0BroPLgr/yIkUccbLCTdAW/N2Io/yXhYiqU8XrORE8bICeevUlge
	3qjejeA6kwZGYfo9nMHMuhGHxwQiE8DNk4D6EjLkrl7F+mxcTqYz03BPY+qtzxCAAqC5wj
	tr2xAXNZpwfoG2yeKOnRJ3ujq556+xADatiVI8NN5+kjPxzEM7hlAz252i/PYg==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Wed, 10 Sep 2025 20:08:22 -0700
Subject: [PATCH 3/3] Update MAINTAINERS for lg,sw49410
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-judyln-panel-v1-3-825c74403bbb@postmarketos.org>
References: <20250910-judyln-panel-v1-0-825c74403bbb@postmarketos.org>
In-Reply-To: <20250910-judyln-panel-v1-0-825c74403bbb@postmarketos.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Amir Dahan <system64fumo@protonmail.com>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757560120; l=884;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=Wyv04p1vPaFXnDGn+MYaWjpbxivqD5UIWCuLT6Ht2Mo=;
 b=klXhdqEUlHPeele/QPtYTvphyr0G9h6MzY/wM4eg+Oy/XrwzeMmiTVCZx/tHiDA4+i1ClQRpE
 0n5QAc5+aNxAISnW3ic3650yUkLdy+EXJYBve2w5U5+cf2Li0yFhq9V
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT

Add myself (Paul Sajna) as maintainer for lg,sw49410

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..26a3ce38d4d6a355f7357a9f6bd07f741301a115 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7584,6 +7584,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
 F:	drivers/gpu/drm/panel/panel-lg-sw43408.c
 
+DRM DRIVER FOR LG SW49410 PANELS
+M:	Paul Sajna <sajattack@postmarketos.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
+F:	drivers/gpu/drm/panel/panel-lg-sw49410.c
+
 DRM DRIVER FOR LOGICVC DISPLAY CONTROLLER
 M:	Paul Kocialkowski <paulk@sys-base.io>
 S:	Supported

-- 
2.51.0


