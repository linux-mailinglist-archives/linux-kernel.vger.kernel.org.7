Return-Path: <linux-kernel+bounces-795915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C2B3F961
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7B01B221ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D22EA173;
	Tue,  2 Sep 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zkx/e+/y"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460A26C384
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803638; cv=none; b=hc8++dsf8hcd0QxWRW2MPW2XE29I+zE2KBVkqj+xjF8nX0IDXFwOpFVtcZHtsbfDUnwaxCmea18Q/xWSpbNS6rJjnyS4cHxcI+YAi88aOAwr6jXVwG3er6h3JJBpmLoTp9f36aeyW0WWaPsTB9qMmd2BogMP2fkGCRXDmjergzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803638; c=relaxed/simple;
	bh=KZG8o0WJ9Re/vKN3NPbu9QOtsOJJZv2uJocpkewtdKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8+IIrX+bxpEGcILcLrkWlE8qS0YiE66Sp1U0l77WR/tTOSCyVWg54GFmLsK8E6TX9Jpkj3TlhGvdsRvoDpW2SAIuXnloidYZxVkQsyqdGNm1Rm8H19shfWnhVkGKDeWtQLRKmxLroBNTaXKXLMC2XSDd1luJtP0poua0G7GKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zkx/e+/y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dad6252eacso128492f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756803634; x=1757408434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZJp+xAbTo2+0/zDtOg8BIzlYFDkHgZ1HyTvcor0XRg=;
        b=Zkx/e+/y4s+0g7iMYtKVllE8CDapui0TVlqn6QGD1eDK/jg830/RLP8gjp4ou9EEkc
         EGQ3qcnQV+nsjf/dcXKYHYHGzGPkuRiWlfKswahYEihk8TSa67crVCaDwglL2JqV9sb/
         zEUE7ibhFCP4/PbY/iOyL8IdTT0vttx9VxZUJADlSQMJenGXu4fRfi2Edw2CqzLiOdi/
         t2SMVBeC5TlKvbdwWMFsrY8useGtNVsTDmvmeKXBT44+So/+BCaKK0Wp9KCM4rIxZba5
         DZ3sBSFVyh2+pBfXr/Sl3jsvmat5ew+LodL/+JsMFWuw2leFBC93BZJEF7PbU55wqVJz
         W/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803634; x=1757408434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZJp+xAbTo2+0/zDtOg8BIzlYFDkHgZ1HyTvcor0XRg=;
        b=uP6bQRZTGGfJ2opRRUlFDElnHkTdUwzS5pS5ck3IN7kR0uICpjBf86OsYjqeaASU5O
         0Yi3eueY57NewmYemyABCesL2wLj3yfRXb3yrPxMSAowzmiV1csknYZCmfvlKuTDZwlR
         JsKW/971hW1yL5njns1/tq0Le89cSgmOhI05l9u5Uv6gm2Me2EWQSltQw0sUIk3m5LgQ
         B/2ZedWzBpBEUfymHwN/QrmvVCyUEHw93Sxy7kRuj96ta0Y6M4PrO+2fWOYB3IaDkS4F
         eJELoxwiIyXNI1MJCy3Afqy7OWyhhxu5fGoViwmtwyWnpd7NlJa2Rq2hZPERs2fJuVzY
         MVEA==
X-Forwarded-Encrypted: i=1; AJvYcCVdGo8aTyJfkEE8vQXjlKG3s1MMYTw9cm1/PoeNtcqh3a++8Kw+aghxPzrxBELCE8GSFtoCNulKYSYQ7b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEO5Gpx8K/GWLL8fcBAlz/phswcJiOnMFopo5FdXvzfcyYQyhQ
	pca4CdqgT8zmZ1NW0qyqcwNd6l3uM8RAsqAQuLyIrJP1DeVKBazr9rQ3c1aOTEGaByE=
X-Gm-Gg: ASbGncvmSUVk4/MGUpnZcuCKyFHJMgW4tkL1Ioj65QMdQIhxHv2RzQXBKvQE8xePvlP
	qJkg90S0eWPp90t9nZOlquKUia6g1FxdZ42aZKMmNhJ7A3G+Z/ZWn6o4J+C7ac46LLa0r58hjxE
	DONsTh0nGpcOe+GXwO01a+6gJX7DgFEPNEC3+5AEKSjX2Du57uV4LmXIuTN0uSsD+Kukfb5kHRo
	7jChjmWnFTQ5ruCMXHi0YRlMfVwSII4aHQCi3OcREqAaRAop/RdkPPsKZduHsRW26dzqVesYdt6
	eh/BeCNBbPB2aw39RpB94p2TG79LtuhCdk6VN5gO1NFMJS0OdyaT/pISs6KvuVZW23RxIw8db0G
	+IYRPt5V9Xfl0Ig51E5SMlPN7fBloMUxQifV0+LfL+Nc=
X-Google-Smtp-Source: AGHT+IHfb9W6Hc9fhkbvwOEzR7R4xuMQPNSMx9xL8H2MM97h3jF8v3/LInCLpQSqbnItnP4BCrQ1Ww==
X-Received: by 2002:a5d:5846:0:b0:3cb:62c0:1eea with SMTP id ffacd0b85a97d-3d1dcf57a13mr8399840f8f.25.1756803634361;
        Tue, 02 Sep 2025 02:00:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7271cd01sm261112045e9.23.2025.09.02.02.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:00:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 02 Sep 2025 11:00:28 +0200
Subject: [PATCH v2 1/5] dt-bindings: display: bridge: simple: document the
 Realtek RTD2171 DP-to-HDMI bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-topic-x1e80100-hdmi-v2-1-f4ccf0ef79ab@linaro.org>
References: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
In-Reply-To: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=992;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KZG8o0WJ9Re/vKN3NPbu9QOtsOJJZv2uJocpkewtdKA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBotrIuFgDKkYXOkTv1ihPBQVWU3sfYnkAYl82ek1nL
 ewBnoz2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaLayLgAKCRB33NvayMhJ0QzUD/
 9PMMy7AWl6efzDwVsG2jN0BEPfR1VI0fDO66I+6cU1tzE956HxCK+S5gajlWS4xawEEpMPGBP5WiEi
 e8LA1Qmnluy/AhBl4u9se3ZMQVXsordhS9sx/hpyzTNGoG5B2TfvYpp6tgiAkYwmqvspdegzKlv3Be
 Koo4hkRtxDo29dsV/wgyzdAcFk+uEIfVoEpfoCLzJqoywPYKLkfERA4y9X3i7ESZR4wPxN8UVamYlf
 fogG9RyGVGCOC5058UeQXY53LBoucMVj6D/edxlmBU1wrIhStDqk2WJpDuuf/fHUB/xL/WavDzW37k
 pGuj0424q4aflRUXcL6iBwQErUmovyP7Z+Pef8kznH4Pn6LXP/D9p4DgxyKLWq0E4bhBKkHQfyMLLz
 TMggt5ae3Z6coBtLcG6HhtXIQs+2oR6XU9RmvECIF2I00/CxPyiNQ0cZNVrOZKv9J1F9v0knlPkGM/
 TlHVG29OZd6o/n4C31kVQQI1O/gaYnt1lRDUM1GZSn/oNQvJ+De9DnSblO+6r9l0N4Yn2XYpCMCuKN
 46XiFIXtChk0WKr8c5de7O8RP2rSq6OLQkZu3qHiGflTCPpL4XXc+UCp4B2Quc7daok6pkRkq2PCGJ
 M+WMYwH8t0KsZF7SXtHzYkYLoe6GK8UuG/hYq4+j0AHSJtgi14XxcHSS8Z2g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Realtek RTD2171 chipset is a transparent DisplayPort 1.4 to
HDMI 2.0 bridge.

This chipset is usually found in USB-C To HDMI Adapters and Docks,
or laptops to provide HDMI display output.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 43cf4df9811a5897843685727a49fd5a90096391..003a1c934f863864400d689cd784990cbc1de3de 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -28,6 +28,7 @@ properties:
       - enum:
           - adi,adv7123
           - dumb-vga-dac
+          - realtek,rtd2171
           - ti,opa362
           - ti,ths8134
           - ti,ths8135

-- 
2.34.1


