Return-Path: <linux-kernel+bounces-843022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B49BBE3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EC0A4E36F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E52D3A94;
	Mon,  6 Oct 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYwC8e2a"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB529993A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758719; cv=none; b=qHomMNwKrcOsD0UipkrBSytHwWXKBzMD0tYqKmPmxa3iyyB5DdgjvR8A8w1pHv13GEMPO5jBPYbexit+gmaLEFlX4EfWiuF5Xl3vrS7y4p0fYxbaWs6bPiSzSZ2QGCEpnbC3VXw/8ubR9sxy+rVQfMKmcw54Tokly5CAE8O6zRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758719; c=relaxed/simple;
	bh=5+4PJ6jPfemENa4btjS7LirYUE2KnvwhBP+jw2X7dVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t9JNiSIPNgup3BMf8JNPj7ST6hskLMXGIhbVQppJkeGV/rCOkjKyVt8b+AxKP46yFj346oZ/rfIf0B2mgj9fuwJH/4180KTIFkQQ+kLvD79YvhSAXoyu8MYxKy0lOPxzzKQGaV6DZILWxRnqRi/U2vgbqIOteA+vHR1oLHeQtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oYwC8e2a; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46b303f7469so31747885e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759758715; x=1760363515; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl/Xsdwp7DpkeGa1ImOkGWOTN5ZyWaGLBtET9IVZcxU=;
        b=oYwC8e2a+4ti8O2OSDQjxFcgTGMVI3ElmIZGOnuW9lssdlbpbUhtlZJG0SEmThveB1
         2eYVQ02XSwg7eS8r8IH2RQrQTUuh3RZ1ygM4bBp27hpN/JJwRJfTWp6HgBrp0gFSeMLL
         4oSW9fMeg0m1pRu6RoSDxj3gM7DHYiBQh6zO3O0OIBa7EhrwJUVBEWZowWBGcaIhTuGq
         xV9Yp9u5o6jUE+vSZnxa7DKSAftyiKUqDK118D03XQJVXMm6EX0BZME7n0YC2CHNgCrm
         f5dU9cL3Y1WkuLCIwUVwzOW102neTx35AeTkWuUReAUBg8SlImKPYD/k9SB1zR1kFwMX
         y/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758715; x=1760363515;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sl/Xsdwp7DpkeGa1ImOkGWOTN5ZyWaGLBtET9IVZcxU=;
        b=IxOCFU5Q1/jVhN1KTHfaIoH0tTHiRC7TGtycaYECUqhA3lzB4ONgl3Osuny4o8WvcP
         IZxj3T/rCG9DquCyvPHX7BCDP+ya6dsY5KivK55iOC3UvzZjvDUGV0jZkXhoS75HsuHC
         FIyB5iMQU9PST9ThPzByqdmpv4o1DsTgXurNI5ePP1gvZ5lN+dAJMKmtNePRFq8tJqYY
         roZeeE5ie8up4m82i2Z5pbv4IYK2b7TmsPGGEIrIbnrEbzjewT3259jCcyYvACg9clFo
         f5W7r7N+J7lIHYlLpWlpZSkzv3YK+w0SdFoDxlKqN62f4HKotZvilu4FlhPrmFwkpnti
         vzRw==
X-Forwarded-Encrypted: i=1; AJvYcCVecbjEd4Qa8gBlXavg8cHcLxuSu1RiKfdaQjkYBEzWlu7JNzfX+VvYZrTagloii3tpeCmlwuE04i2oJG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyeGhC0bKYQfPS1uoafaMl14zqYQ8obuyz8UxyektqOaz4dWi1
	2edW69uESpjqiSBlR1/h+aztuWABr3bZuXFCBiJn2tHww/GMeFGzEGpfIHG0uFBU31I=
X-Gm-Gg: ASbGncvW2Fya4K2YBqHu/+nc0RUuCnQWDmzDv2hmYgAS7QMFPa6lcpIw010gw57p5zF
	PlL4dSAfW88ubdoAUTTwFU7KQ9QrYoLN7nV5x6eMqrXEjlW823pfa3Knucvy3B1T23CgwNu0Vh5
	wtxVcWVZjcrMwwG0ocBDDc9eWGwtgI7szgZUtcmHESyB0YniaqHdQ2SIq4WhtrS8FWLxQy4mc89
	GpBwl1PtzkqKQ2x/YvNFT9f/TuV2tmUdh0MkOWOQuDBrw1FpFKHdLTwSAEHrszNdMufSuAqG0wp
	fC57/SIiG9vR/vAP06JSMriq0txyVo7KH9oJ58b3TWKHFA9/hGIBG8mOdQJqIwVKFu5a0+yvW60
	CPO3x8JhJ2ajKmbrFPjzKLCQ8Y2wgvHtvHoumDxrh7Tj4Wtk0Phk944ugcKfJt/cRe01dWLw=
X-Google-Smtp-Source: AGHT+IHf0XVleDEkE0BhbbDIPcUJVH+5v33yVTTQ/TAofs4Bb0q1LMt4liHnvPnDbjjsIjmsonEo/Q==
X-Received: by 2002:a05:600c:154d:b0:46e:6c40:7377 with SMTP id 5b1f17b1804b1-46f9bb3fd36mr29299735e9.35.1759758715096;
        Mon, 06 Oct 2025 06:51:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723437d8sm161373265e9.3.2025.10.06.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:51:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 06 Oct 2025 15:51:53 +0200
Subject: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add
 mode-switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-topic-sm8x50-qmp-combo-allow-mode-switch-v1-1-3d79e7ea6824@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHnJ42gC/x3NTQqDMBBA4avIrDsQhdHSq5Qu8jPWAeOkiagg3
 t3Q5bd574TCWbjAqzkh8yZFdKloHw34yS5fRgnV0JmOWmN6XDWJxxKfBxn8xYReo1O086w7Rg2
 MZZfVT2gHYnJEbggj1FzKPMrxX70/13UDC6M3qHoAAAA=
X-Change-ID: 20251006-topic-sm8x50-qmp-combo-allow-mode-switch-a75e5b55b7df
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=5+4PJ6jPfemENa4btjS7LirYUE2KnvwhBP+jw2X7dVQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo48l6OT55Ag31LX05Dik6U7flL1LRcECV3P48fmDE
 TId2NMiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOPJegAKCRB33NvayMhJ0c75EA
 CdtICwvFHqp7DobK5NwBTBXdeEWfziO1B5o6TRtlyFfartZTPlBciNHfL80Iyk3Zvn/Bwvv0lZjqs7
 Pgs2/TMlsScDFroBe0L+wPbPF95GXaUg5lYogAdm4a7nHolbsswGYikugIT0xHxghal77W+WeHSb6M
 mfnnZj7Wpty/ilqvoyoNB5+Wvb4hGv1hAxwx0v0J6D0HGtJ64m17JV3+7Ioy1gW+3PyVsTTFAHQTr8
 +G5pSMtZzqf963pvnhRPCaMqhGi/Gb3Ks/yOm5rzOJh7gvkrExraW3ACooQoq7TKK0YF42oyK4z8cV
 sP8HdD8lxXXCUU3LiLHlLsCIZyJRD54Fq6pGBS2fP23+ZxZfRByCr0DgyrODdTr0uSdVkrZk5z4VYY
 K9Dw80O0MphGGbHXEmOMTwnNwYUme64EXh/IRbZseeWhVpqHdjYZAkfQC5Bsfj57OfvgBS+7nOtLjj
 jQVbagl7QvgsmagcI7Z75N7iEfqo1FofHJw/Q5pkQIrXaCL2/HwDUTOAtR7COPcko8wXUqYDLlHpWt
 5B/qXalYhJHanRRQJNDlunY9F02oKBmjZza6cTcDfH27xZnyhvybtada3MhiATJrKqLFWGHppgwbZ2
 //70JOiIQXdWdHNHvdMNmHNQDMhhGdY5nTwtz+Q3W0SCeQ3YQp20MbFgA3bQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The QMP USB3/DP Combo PHY can work in 3 modes:
- DisplayPort Only
- USB3 Only
- USB3 + DisplayPort Combo mode

In order to switch between those modes, the PHY needs to receive
Type-C events, allow marking to the phy with the mode-switch
property in order to allow the PHY to receive Type-C events.

Referencing usb-switch.yaml lookkied like as a simpler way to allow
the mode-switch property instead of duplicating the property
definition but it causes some issues with the ports definitions.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Depends on:
[1] https://lore.kernel.org/all/20251006-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v2-1-3249e511013b@linaro.org/
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index 38ce04c35d945d0d8d319191c241920810ee9005..bdf7894ff84869030252f64f20acb4f920fd19e9 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -73,6 +73,11 @@ properties:
     description:
       See include/dt-bindings/phy/phy-qcom-qmp.h
 
+  mode-switch:
+    description:
+      Flag the PHY as possible handler of USB Type-C altmode switching
+    type: boolean
+
   orientation-switch:
     description:
       Flag the PHY as possible handler of USB Type-C orientation switching

---
base-commit: 9cba8ad3e538c0d955a9844fbe26a887dbb04f4a
change-id: 20251006-topic-sm8x50-qmp-combo-allow-mode-switch-a75e5b55b7df

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


