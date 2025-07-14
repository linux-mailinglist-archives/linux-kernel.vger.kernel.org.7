Return-Path: <linux-kernel+bounces-730663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B6B047D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF806164C12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1276E277CAC;
	Mon, 14 Jul 2025 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b="HOnP1Jbf"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60B279347
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520661; cv=none; b=StTw1rPWKfGfBZHSTTyWtpfNphJoZrHvdiSpCOg99PJWTZ/5RxSB5suA4LXb03/UH87TCzi9Ar1WvVrg5POh852tCiaeq3/3e3lKnysXcCpPsyYGw6CmX+hWobPI7GVEtdPUDesPQx4P1KMNQGlgGEXeux1Q7JY2VsbdA+jsj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520661; c=relaxed/simple;
	bh=y6DxFsYFjydgZJasX4daOP3FNTJLEXvo75wTSG1raJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sW932VcSkg0qzTCUsvM21f/lIenktnF5waAAYYT02NxSe0YVTmKLN3NXuFz8rX10Oh3zqSKBKT1F4hnjpAo+arN/OhJtqyA0gsJNBz9c5xtbcYfkWITvYBK2SSikGhAlP/ShYAh3ty5RhlVtm0P5LYhqV+AN2Jis4Gqr3PiIa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com; spf=pass smtp.mailfrom=scandent.com; dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b=HOnP1Jbf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scandent.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab81d016c8so13531cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scandent.com; s=google; t=1752520658; x=1753125458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWoIZzm0uqcPp9ZelvtCnlGSyRPqWxQLJdYrHzVMirc=;
        b=HOnP1JbftMVw9xqoZQDA6gShUTGxYtyokkjXt9DvV2ABLYtKvCxF367xbqmZc9lpro
         r8LRU1EfrZovj2aPBFM4gQdIU8vpqpShHfQbrQRy5eVMjDmmT4EZV5R7RacdLtdATglN
         7Tiff7OrjWiSy+g0YmZczxvJI1D/PsPjpTgAtUjQnAUniSTuDbYob132piMCgjF476lD
         0SU501/5z4U3an4T0OOT5bxYKoWsYHlRka3GLRTIkROVu1YYx3v3S3NlHGdScFW9PYGt
         GsNaPbOCHO3Qf5HdY+TJU9+SP3Kr2w0clzqyBDL0ubjmMDwMfX43pTGU9tkhXST39dEI
         TWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752520658; x=1753125458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWoIZzm0uqcPp9ZelvtCnlGSyRPqWxQLJdYrHzVMirc=;
        b=Jt2s0urxTauglMeZIYhi5fKQt8khSwJWhkBLeKrkLQE76EQ4WB6/Bc1MeTdqTZV4G3
         8bxTvONbnnkVtTllo5UrruSVGeQ5/F5gecdApY3KxWTSd5ubwUMutCbY+EOqXL2sJ7f/
         BDE3iQwUE2sl0Im6L9iA78Cfak309HUFPwAVtz9Y65HwhS3CCrE8Gi3e+Sx1SKKYauz0
         ZzFSVlPnRajEMdAEQde+oBn0Ei084ouLprkiCy7LnWhi1OjIRw0dOt0sMetbNGx6M4pr
         vIOcoczbrKcdumM34vntXCqk54jlCezouKueRDAQUB5O4nt37hCCNaHPSNJSkcy5xgOX
         jMTw==
X-Forwarded-Encrypted: i=1; AJvYcCXWOXXrUgc9LQUE9yt5qzZKRnf42+qc9pj6bNHcL95cCH9kRodWmQHPsFk6YMvXa42mueeEdg8R7G3vbjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/jrBpBK+6Wa/nyFD0vCPsuIsp32UuYz5VDGe6yx9c6m1Xf2l
	OWs16Tis7+DF2k8xXT6WcitrubiWAOSjbLSAJcHrtmnqK7DLWUNQGYeA+LozfwJXQMA=
X-Gm-Gg: ASbGncu3HJ+0ODwxRwWxEX23xGJXLixQhyI1ioMurFb96dorORHw5Ad+fYhaIBCDeR/
	eKDa6vVQAiw0AR0/XndiMGshbYwXAFNtOmEnqTXbD7HJ9qgDCM8mCjpnrDBk7+GPf7K0gFWBpBy
	1t8k1bM07rPP9q1hdD0fXWdUxqcusBfXXc9JC/If0yodxMYPmft5KQ/SAu9W4dmfubXh3eVLnZL
	WKUnhMBQfKE9YA5n37373vEzS5xfcjGI0JQwrYHXxU2u/jzav5L8k9S/xIpimzKrQzGE5splvS9
	VInl6tBywocIvW/rkvMtrb+chQwInynzXQePyu9O80fJWZdCGAiGgxW/IbAIYDcxp8E0WnwPWkA
	V4kWOKUkg5a0Oo4BB217e9g5L20EnyJiH6IBQNWUpM3whTMuP
X-Google-Smtp-Source: AGHT+IH9gnkyuOuPKjSw4HN8uBsSQTfAFopuTxzSbsZaRocX/u4+4/u1WhT40OcTC4OtUT869qGIsg==
X-Received: by 2002:ac8:5c81:0:b0:4ab:5b3a:5f14 with SMTP id d75a77b69052e-4ab5b3a6171mr148318871cf.4.1752520657836;
        Mon, 14 Jul 2025 12:17:37 -0700 (PDT)
Received: from vserver (ool-44c5118c.dyn.optonline.net. [68.197.17.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab801e542bsm1482521cf.3.2025.07.14.12.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:17:37 -0700 (PDT)
From: Richard Yao <richard@scandent.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshay Athalye <akshay@scandent.com>,
	Richard Yao <richard@scandent.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 2/3] dt-bindings: ilitek-ili9881c: Add Tianxinwei TWX700100S0 support
Date: Mon, 14 Jul 2025 15:17:22 -0400
Message-ID: <20250714191729.2416-3-richard@scandent.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714191729.2416-1-richard@scandent.com>
References: <20250714191729.2416-1-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible value for Tianxinwei TWX700100S0 panel.

Signed-off-by: Richard Yao <richard@scandent.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index baf5dfe5f5eb..c181f5adcbc5 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -21,6 +21,7 @@ properties:
           - feixin,k101-im2byl02
           - startek,kd050hdfia020
           - tdo,tl050hdv35
+          - tianxinwei,txw700100s0
           - wanchanglong,w552946aba
       - const: ilitek,ili9881c
 
-- 
2.50.0


