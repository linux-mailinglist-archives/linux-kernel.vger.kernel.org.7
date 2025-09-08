Return-Path: <linux-kernel+bounces-805865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC882B48E94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB62634175C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB830AD04;
	Mon,  8 Sep 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bG/9Fv2T"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344C12DDA1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336669; cv=none; b=SUdJ2Su3DBGJ7yCZEsQgJhyC5GffE6ElEwt2kdyKwGgQcwHwVPBJCaPOB5ZOlknoLM+Ca/tk/Rmjig5QZvC3MGcSJzeFm4w6AcMvSotWPBK7SkDHoPgcNaQlBBpB18bDWJr6WVMcnm0Oh/LWygClV7jsFRBXf+SxJbuxA+lCy2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336669; c=relaxed/simple;
	bh=z7PAuGtYNvNlORz36aPmSnF79TimixozQax/x4u5xJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCyBZv5uPSTIio06pN4MtqXK2PMHhmbmtu2TU+mxAsklwT8iPtgp1/NppNkqnM/RUbyn3xEuwwta5iGyaPMxb/Xr/xH6ULQr/4okH/CRcE33aE3NCLTE0SZ+mXoi5W+888++MlSdWkIK1C1nlegdYNbPMdJHFN7YRFIq+Aw8nUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bG/9Fv2T; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so29228415e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757336666; x=1757941466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GDdn26faX8+Rd19RRlHwI66hY8ZBEzdxwGwtCXn4n8=;
        b=bG/9Fv2TdfglV5SHJL4gjz8uAX/FRQ4VwzG+PQv0aTkPo+dRKax97L7DA6VTyMEMda
         huEVNBD+tB71SSDIWDkqkBWVY+dh23wAXeY0MmJCOHUoy+BUt48iuvXeoP3by0M6Jwol
         PYNBm16uhCczklLEomPcmzcprR794WT5hNL9awTexviMJC5q7zjBa1mJjPqu2910c9Mr
         k7CIewXY0VSZJYyAdDVWeuvvqfIEeUbnIyyQAYB21Z7QnnYb6NsEvZ4Hr/+VpfDMjbux
         V4sS2c+Q0iJ1C1RTcsjmiaovG2R0TC8I1mOdFZzD3tqfnwMSVTYWR7MMtcrD8nAsiDIH
         RQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336666; x=1757941466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GDdn26faX8+Rd19RRlHwI66hY8ZBEzdxwGwtCXn4n8=;
        b=HtjaD+oqJaqPioAQJQRg2Th+/ZriOd1lrwQhx3z8Wc/tqoAXit52X7LYu90W4/SKkM
         Tf2Jp8PGlPbUC1aZxTxEgIsATJsNhUHGpHBH/sreWLTBWbkrlkuRJBBGsost7khjXAFq
         WxInRwaOu0WM1gyJKgTym+geXa/IgWX1LW/ZKjyJ6qzHt/xVRdds+dX9twVCZ4aG539h
         RyI98AnWtJG21kZhuimmPugbnKwtZZhGT0jullUCBJdhkH3694ClEOAKGY5it1StfwAk
         lCGJy0kqCr7L1LNSDf28tzoMN0jbLDPph9u4ZGR/Xyrbafap304B6b8xZPScW6g1YGhg
         QTGg==
X-Forwarded-Encrypted: i=1; AJvYcCUNOw8eYsyORAFXKAbySVokOT3tr+a8WT7V/3mQjfATVCdWJ8ftKrlQzmJsjI9pFQjfiFR9sIKt0oiRCDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIuoaRxl0BBNf+SFzvCrDbFbz3gCHqB5xo3a8fVR3UYUmRevo
	I7jbGFLlls3oBUFAc5wNgdPcGl6jbIq37WCQLMcHt0DAlJy1gBbWqv4YYKNKEtc2xQk=
X-Gm-Gg: ASbGncuuZv9KbZ4ENLgVufzgD2/u0zkxBzkWVW64DQ67rJr1X+umWo0TNXaSRC121iv
	7eIiHjmu+PVh8evWidyA5U6lm40lyN7rEMLV09J2DLcHIuzjMyHCxWeQ/WtLbDS4OeafqLY1W3e
	S/TZmtPhpe2HwPcxHHz/A5NPQDAelUJ6KrZ/b8R1ljErQEIgSixO/UnQ5l8YmHZS8np1154WCsB
	wxpCoLdD90UBymZ8fnNl2+CjGQkSWDj1juRX+PlG0QRmhDtgExuYmjYhcViG+pkcjrbx60FHXV4
	3RSJT5q8XjFHYMX2+osM/CRiGIYrJpVuPX13U98gmaNFCL+HmxCY5BvCLkiHGx4LrCdida3cSO4
	mxyg0xjMcXtvtu1MporHP+XvCQEBYvaEh6CTBa3kJEcXuFmVMsKdMLQ==
X-Google-Smtp-Source: AGHT+IE+QQMsvXfniwarXtFZkCcmmT2rZk6Fee10DBHIU433hV2b4Xz5UNo3Gvh1D6s/nDMeM1UWiQ==
X-Received: by 2002:a05:600c:4f03:b0:45d:e54b:fa29 with SMTP id 5b1f17b1804b1-45de8e21be6mr18156375e9.14.1757336665980;
        Mon, 08 Sep 2025 06:04:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm145632475e9.4.2025.09.08.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:04:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 08 Sep 2025 15:04:18 +0200
Subject: [PATCH v3 1/5] dt-bindings: display: bridge: simple: document the
 Realtek RTD2171 DP-to-HDMI bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-topic-x1e80100-hdmi-v3-1-c53b0f2bc2fb@linaro.org>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
In-Reply-To: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
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
 linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=z7PAuGtYNvNlORz36aPmSnF79TimixozQax/x4u5xJA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBovtRV0EWZ3GTngV+VZoqNOfxTMbRfZ7L5uMzyt+BQ
 Gcxw7xWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaL7UVQAKCRB33NvayMhJ0bWGD/
 9FmFWdexA2fU+CtWIWKbFIwMNtPEpiwf9clzEvPTLk1asoldTXFdDdKzIqNt2UImqiqUFDoOcmXw9t
 gIsk4GdSeV+bFCJgNSDKS+ThVbkQ27MBqv1iG8vZLattjMV4QG6Gc3XTPr5CDWOzg1p4BcXzKz5m5T
 Z73ct5hdeSi9ZQEaoehnuS3RC2+0P1MwQtKOR9mvUb/Nv6PcNjr6QR7ITS6hNczvmuPJQlF7iWuW5p
 Wu+KIBDIiMOwtM9ShXzTLo5gRbY9Q3VsC/LXusa6s2qolctz4pQLoiE61Gn8RxbMpQA2Gl5DPwrloU
 0Nu1bbUVlgKrGwSEQ7YN/MqzWV0nN/8su7VChcF26g6yhxcTfibRYw7O3+bOzob6IAQz2JMco8dLTS
 knda27GBDE3ODLhBmsMBvfdPcDIVrdunRQzXUY0wbp0lPiI2FguqNxUUQHEEIu+vWyC4uEEYjDhw0W
 3deHkxjR5FZdpZNuKxBCkVSMhXGiZ7NBe/eY4LP62g6fuCjtLqkMA9F/CCq3RlV1scYO9UMI/a1RMW
 0JaH5uUXxE91HoAeVxZAv+v85t7ibs02J9/7oR+FAcLYp51VBgFuhV4TEEn+4jHhKJLKU/pKJaa9jj
 4Ozwu1O+JQcG7aMdmLl9jqU/yt1XqxL0uKfgeLrHYxygloky0Zp2auM7SE1A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Realtek RTD2171 chipset is a transparent DisplayPort 1.4 to
HDMI 2.0 bridge.

This chipset is usually found in USB-C To HDMI Adapters and Docks,
or laptops to provide HDMI display output.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 421f99ca42d9b75ba1963493d36fc89fa9d8252c..9ef587d4650602699efac634c5466eb2e8aafecd 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -29,6 +29,7 @@ properties:
           - adi,adv7123
           - dumb-vga-dac
           - radxa,ra620
+          - realtek,rtd2171
           - ti,opa362
           - ti,ths8134
           - ti,ths8135

-- 
2.34.1


