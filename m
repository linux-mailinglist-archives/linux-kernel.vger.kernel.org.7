Return-Path: <linux-kernel+bounces-795918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822DEB3F967
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B52C1DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530C2EA727;
	Tue,  2 Sep 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K60edRK2"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4920966B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803640; cv=none; b=sGED2R/BuTYyr6T/F+ekmlwmTlvsstRn0WoOcOsGigfUF1U4Qs65EjT4SU/24Nz4YYU4iiQLB/ICA5h3IZLzHj27zIRLfqi7tINhzj+/YLlB/fZwApwgXx5S8kCnPmG0/CkMomg/P3LQKWnGS/NB59suqv7f7aSisYmVF6pLyfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803640; c=relaxed/simple;
	bh=51R7ntqsrbjqkkbo9tDq8z9uhTW3d/VToQqy1+1C74M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8ZMh1kToxW8cUSfGyAK+rRy1K0eUAYP+sP9NAE3VWo0TXgzdyvapmCLo7SZF83PkE4sWM/pj6rWHH7SEQuSE44vRK+R9j+9a/ND2v3EHWSuTk9f2FDhc4n5MgWlVeo4/Ui+gzAiDJ+lqpq9PGMhGEJtjinc1t1UgAQWTW/b9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K60edRK2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b82a21e6bso23214005e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756803636; x=1757408436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4Gc9lydW9tzAwiGsPKTUOmW13FumVd5+LLitcdezXI=;
        b=K60edRK2tjMxLq/pzEIfLo7g2RvpjJ2wDVF+wTXG46P1Cck3f3lDtbIfB2pyTEzztW
         ziDnAtwCnUvJVULo0kUHGT7Nwt5i11eDAVeLy4jbrLrEW6kTBlCsIDpG/RVXxu5aqjFs
         Gp3wTTzTAjvVHiRYHYkWgRUj0uGU+JdeQfRpvNy8a4hEyTChNefpc46+gAOmKIMqBrIG
         68eC4nXTwslocMt8EzLMuxbcaU6F/kl6XIWnEEM8npZFmnM0YofRuayEMxKFR12o0cDN
         mt53UB68i06oIr/Gi1+eBiysVz62uXe7uEoQQaZOu5bnb4qtqMgS8UYfANnc0dUFQ/Fs
         9WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803636; x=1757408436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4Gc9lydW9tzAwiGsPKTUOmW13FumVd5+LLitcdezXI=;
        b=Mi4ne3O5ibl14hlKd8Jd8rQGrTBm40nY14kfJw5wK3wUbajFi+lVJxFjloiUiMUKVX
         C7VjTxwteynj2unnHr3VObPN4iDzAk5cnZoQE1JZCh7f8eBK94Eh3fRvt3wvI3d0lWN4
         c1ODHfaMakLJzqd8j5t4VROdsgzNHtBrPcF+lCfGznxqho6lOu64glubxV3nMMCD6QzX
         b/Wuial/v/KoOPWDuVHSYB2tT2EoV97i436iJzJHJkeuLN3v7bJWHrOWaUne1Mk7JsSi
         fj4YHnp+tmfN5mRBu/G0Y39T0C6oXp9+niExKF7ZuKrvEaeMlEh00LpVxRhv7Yqy680z
         FvrA==
X-Forwarded-Encrypted: i=1; AJvYcCXkplgHSx9ypN/Sq5QvlxJQtknlcb8elz7DWzF0fIhuKHgNdo5eGkRZfQ4DBC8gPZFINcASTHAdqbHjHk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85OYxLsPFRSDXIOp+SzOYh6uAQpX2K+iBxf88GFPNAADFHvlB
	trpf6QsbVkithY2L39ymXxl3kR8Zce9lFhsbNI2eimFenbkEwUS8hzxqhIzxH1jj7QM3ZYi8Izi
	duKisPNQ=
X-Gm-Gg: ASbGncvHGZqvyVevglVOCFPj4x7AH79oSgzDqXs0jjWdYYRZVgtpIeDCp3q7r3XAEtx
	7CloLECLCQV+U7Zh7RSjZGpLzm+AOgNymayX6XAFtMvYY1clgZJwzW9+mGwau7AbTZiUF6GYssc
	d3rZUclQuXUPfCSY09WmVAy+yFepxALOQ8XM8oMQkgWkWNB5FscIjvrtzqsuAadfsRy3uAv31QX
	WKFg3H9rQZIPftsCV7Y8DGX7E4zYF5RxvYvA/76PnR+IvU5/bzTXefQGEuQYm0BiFm/nIA6EO8h
	UB47AGvQwjK0VlsercOmJ5SSqeG21+h1NDBdzaO2KzBoolMKMNn7iXT/+Ep68VOZQtf747kEf7t
	qAbh0ymdLfWf0z7zvT5Auf3nQ8gAkm5NUEGS12nJmpfZSM3ZBF1fIhw==
X-Google-Smtp-Source: AGHT+IEILw7DEldBdS7IGmRLvi+LEZl/gvFjKbfhYpEStds1C/TgZH01vWw4ozqfSAy+3MiHrBhGUw==
X-Received: by 2002:a05:600c:1e8a:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-45b8fe2bba1mr31627165e9.20.1756803636238;
        Tue, 02 Sep 2025 02:00:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7271cd01sm261112045e9.23.2025.09.02.02.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:00:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 02 Sep 2025 11:00:30 +0200
Subject: [PATCH v2 3/5] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document static lanes mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-topic-x1e80100-hdmi-v2-3-f4ccf0ef79ab@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=51R7ntqsrbjqkkbo9tDq8z9uhTW3d/VToQqy1+1C74M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBotrIvc6t4TujnMpo58ede29xTmJGQdEWRpxV5GSqf
 h17tB6eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaLayLwAKCRB33NvayMhJ0X+1D/
 4u4YL6Ysgv6k6MFx7QTE9Fi/CP4grEccBzfnrjMyg7+VSuEa694ZowkmTpMf08EX/FuD010Pjs2uhc
 J86s8vHTOcExjUoFmhz3QoDkMDUwn4PBZKxGVRa7xkgsadjEs9rKlnsRc56+X7AxMu6DX1AEu4be7Q
 471IeyJBoikRzPsZMFxKC7ai3e9OtbFoO4lWhnTmkSu5ByuAdm+OTqy9TH2m9rE0h1v4Dfw6L7AKoB
 EgN6WIjsjR/SXOGyPP3lgELCyni4+hPj/PvvGoyhZXXFV9wn4hrRJM+OoKzD0lXdmeb7sDA7+n/keG
 fP6XvhWQL0TOoWukD/8Y42HSn2Mqi6AAcG+sJJkpfXwl9wd4MjDd1LU74fGbd056V5NOPI0M8wIpGL
 As1f4pvje7+YN/eXdWJ0xM/+dKzJ54yw+xp8KdouBwhhu/eTDpMV/ti283/lOnSQIsGXODTIpUL1vV
 5/PMVXQsQ5L9bZJ9f8T2Lp0v/cybcpPvmLCV/frxtWSlR49L4DUfgMcYHrhTZcQrn1xuj7R9j+sYKs
 MDEWrxU+SPBcdvWgAvyHRqaOieELBxKvMCvSSTkrD74KcriI64wy0L/7ZBT3RpuVg7r0m/NyjD6kqn
 bfquLF1jGDVlthmN27a+ZWZngxTya5WD0OD4b3Fz0WfzuYKF27wiV2PU5Tyw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
of a combo glue to route either lanes to the 4 shared physical lanes.

The routing of the lanes can be:
- 2 DP + 2 USB3
- 4 DP
- 2 USB3

The layout of the lanes was designed to be mapped and swapped
related to the USB-C Power Delivery negociation, so it supports
a finite set of mappings inherited by the USB-C Altmode layouts.

Nevertheless those QMP Comby PHY can be statically used to
drive a DisplayPort connector, DP->HDMI bridge, USB3 A Connector,
etc... without an USB-C connector and no PD events.

Add a property that documents the static lanes mapping to
each underlying PHY to allow supporting boards directly
connecting USB3 and DisplayPort lanes to the QMP Combo
lanes.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index c8bc512df08b5694c8599f475de78679a4438449..12511a462bc6245e0b82726d053d8605148c5047 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -76,6 +76,35 @@ properties:
   mode-switch: true
   orientation-switch: true
 
+  qcom,static-lanes-mapping:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    items:
+      enum:
+        - 0 # Unconnected (PHY_NONE)
+        - 4 # USB3 (PHY_TYPE_USB3)
+        - 6 # DisplayPort (PHY_TYPE_DP)
+    description:
+      Describes the static mapping of the Combo PHY lanes, when not used
+      a in a Type-C dynamic setup using USB-C PD Events to change the mapping.
+      The 4 lanes can either routed to the underlying DP PHY or the USB3 PHY.
+      Only 2 of the lanes can be connected to the USB3 PHY, but the 4 lanes can
+      be connected to the DP PHY.
+      The numbers corresponds to the PHY Type the lanes are connected to.
+      The possible combinations are
+        <0 0 0 0> when none are connected
+        <4 4 0 6> USB3 and DP single lane
+        <4 4 6 6> USB3 and DP
+        <6 6 4 4> DP and USB3
+        <6 0 4 4> DP and USB3 single lane
+        <4 4 0 0> USB3 Only
+        <0 0 4 4> USB3 Only
+        <6 0 0 0> DP single lane
+        <0 0 0 6> DP single lane
+        <6 6 0 0> DP 2 lanes
+        <0 0 6 6> DP 2 lanes
+        <6 6 6 6> DP 4 lanes
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
     properties:

-- 
2.34.1


