Return-Path: <linux-kernel+bounces-829514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200AB973F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268134C4925
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528572FB084;
	Tue, 23 Sep 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTAgFoc+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE512836BD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653632; cv=none; b=VEUeilp6xUJTvC9W+VrwB/fBRZI0VYG+xRFgLMMaFlAe0+C8lFKvbX3HyW49n/50dD05JYSxyLUmX2bd1Bgz97T/Z6ZL7kQtLgUQAeoBL97UZkOTgq8EElSBgc2Ry1fy3/1QgIC7m/9xXFmE36AzrgL56CjJ+u6hQwL8kIJWvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653632; c=relaxed/simple;
	bh=oRUBVfO2d3MoKM1jD4VAKRUkm+iozi0HUHHMy5T2wc0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GNkg4sbis11mf1v8VeT44HB9wX6vjWL0NnHN1t4E/4T8yWH4PzZCdbvhQXT2gjqXBwIaPoyblQ1YT6vJ/mulBJj6A6iejS1xWCvOlU85qk/ALtxw2ca0VL8mEwVvPU72Bgl3LEpjrMbTjRrAR6LLz4qET+6v8kDZYrMVhUQ2ing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTAgFoc+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46dfd711172so19875755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758653629; x=1759258429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWcLtw2qXrDtFeNiHTtrGneV08EOKIFUjDj5SrfHC4s=;
        b=eTAgFoc+IfauKpWV+Cy25xTn7xLFkB6jZ1zSdnt8H1bGXbwUxQYpsd4rUOhonayU9G
         P4HH7KoVAvpmjqN1YcJca+Kue7ItUK2Qk4pTfnsMe8uqb2bx+Q2MrPeQSTmbLtrQtdfk
         3Bd0HWvJNU97Ogj/NL7Fie7HQrjG6S75x9b0BY4SvXKJ0awSYHWdQ0WZfinnI/VcEWey
         0vg7e/C5EqL70Mni5L7EmV0jAhA6ooCCT4GWTBkBdMnoHnekb3hHrrnrWQJZl3K9gdLM
         QgblPjNUcfplQY+W+WvwnjAmDCExznuiGNxJI04GA7a2TH30PuNWCQ57LpJlYW4/Ss3k
         kv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758653629; x=1759258429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWcLtw2qXrDtFeNiHTtrGneV08EOKIFUjDj5SrfHC4s=;
        b=qSgpvSexB6G18hded3Nfno5OBgIYB8LroetHi/4NWSRBiIBnFFdMVcn5e+OTTRtHwL
         bZk7QLkyTt+v3kh3v0sMQocrBTeyLx5pUt1yPUirDMO/XgncGeaa9MPwdtQ6caLD35H+
         NIZj1XBXGKrAtKlsA7YSGX4tL7KGrpizpYyiXNifDv7LrRUry8IXZDJG9F6c6SEQasOV
         zQoOivsK4N6zR+Yk7EDI8gmXk+l6VeKp3++sG+O3r9L7aQvb/IOKmE7eWely2TBdMJSh
         wxjL/stUPmD4oSKgSlc9TYhQDhW5b+L7aO3ufFdM0Kb2Jw99N25h1PsiuZw1beABAleJ
         qSyw==
X-Forwarded-Encrypted: i=1; AJvYcCWTNDtmhsK15k64vfP1awM2eug84mYwXFmvQjmrvoG7a0qliLIMs5zrcEQyk/fUohKK0VrqBZxYiFhsFj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OteucZkl3a6Dd3NQ4DsyWo8Jarv8BeTJxTMp+HqXORK0pIA6
	GcYJqesaByE1FOwPtAj0k6fJpWgXDa/F3z2Le/sPSnxD4TzX4EMPDcF9RrcNlg==
X-Gm-Gg: ASbGnctnc9AkwYY60USisJgwQOsjqsH97gwTrGgRdK02RmW4FfvoUPmk7skVhVE6ICl
	qDhlSv1euqRF9cq/aN8p178BJfLPDj8A2SB19LzDCmBuYE/acplTXyQvMVzil8HZUeJ6KfgzD5V
	RD6dbS5UEOsjeVmUAYbNkWdOxbIYiHqedoNGrjpKfJoUO0EjfRT2loUYzZBhGfFC1AgJY5vbGEk
	WRWdAGV5kt2c0uurlgzUvrPpadIZb+fw1IApaXMW5/tBuuzHpc8WPFg+b0bi3LOG/uuSt522vDZ
	+VjC8UwpZ0sFQ8NCt4NGAw4fWcMYSQ7lswpER/4FeTuOjQ6mGQUBWsHIxoZeZBM8iIBgbJAKVbT
	SOUw0BUx4yvyz6gjxExZjLNgzIm6a5qB7IXYb0CpZXEQWgHPsYgOktTtX+Y7VbbmrFb6dLEvp/h
	6OuR0+yw==
X-Google-Smtp-Source: AGHT+IGKjgQQvlEa+A94efi/b5b4nbfk7G0qwnMnOukLmIKhoBHDXNsNeAGIWOJr8BOP+8/JH7HY5A==
X-Received: by 2002:a05:600c:4fcb:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-46e1dab51fdmr45625665e9.24.1758653629107;
        Tue, 23 Sep 2025 11:53:49 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-464f64ad30csm295014655e9.23.2025.09.23.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:53:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: arm64: dts: airoha: Add AN7583 compatible
Date: Tue, 23 Sep 2025 20:53:34 +0200
Message-ID: <20250923185340.21526-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN7583 compatible to the list of enum for Airoha Supported
SoCs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Follow alphabetical order

 Documentation/devicetree/bindings/arm/airoha.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha.yaml b/Documentation/devicetree/bindings/arm/airoha.yaml
index 7c38c08dbf3f..df897227b870 100644
--- a/Documentation/devicetree/bindings/arm/airoha.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha.yaml
@@ -18,6 +18,10 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - airoha,an7583-evb
+          - const: airoha,an7583
       - items:
           - enum:
               - airoha,en7523-evb
-- 
2.51.0


