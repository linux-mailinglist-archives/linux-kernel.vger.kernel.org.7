Return-Path: <linux-kernel+bounces-807393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFEAB4A3E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879A71C21892
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05756311582;
	Tue,  9 Sep 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6WHddid"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528B30FC36
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403253; cv=none; b=toK4fCjenu4fMIrbDmR0NNveLfAmC/frZgHx3E3n/QhYFi1U00F1L1W0zJ7npU748QTl6nbQwQT4bTzGYrmFi8NYGB6HDlDgnCn9mEa0az9He7cL7KY8gGLz31QvWLWnrsHD4GPVdWOQqT0m3Y+8LVvF2N94zWNfrSxGdioIHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403253; c=relaxed/simple;
	bh=eQ/FyPc5Zgfvvoi2dwn7X4THjFGPUOmpjmW0J4V+O04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BK+pa1GqUsrVvyl0cTsoV75v/dokb3vqk5MVldAYJSdF0KSu68M+GxFJ6ltRvtA1OqwbMds/iqs1iWneYFelzthDV7y+3mdDMitOZDQ/iL2i8+1yhybFoBO1tdq+2UadiaXC/ZXH2aCoQ3EVviIa8Yn8bP3e2JCyKSwZrZlvNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G6WHddid; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso2032963a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757403249; x=1758008049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOv6YZzImpUIBG/mr0NgF5IqW+E610SMfxEFIyqnXkU=;
        b=G6WHddid/+an2yB4DGyKHqblvoyKF/MGZ6+yYZzGq7jIMQaNsnqVOMu3IepZ+UPF5D
         bEeyvvU/z1hP2M3f/W3eQjjTayM4tNVfbscRBwtjfNlj0Umf4rF4qlD0Kc23nOpOKyME
         5tgWsDSNKFLRqc0QXwHor0jcsoesz6QgIfxysc4PDLZA6l2dhggOLkriDc48I8f2whJa
         MluSc2SUgRKbjznhJwp9yyC70v3EGDMPe8UseaiDtJT9W9zypyIJD0gCi1F5lADsVE4e
         QNG7dWVbQq6Kvj0E4y3GyXUHg9WUOGCsKWezEeFlr3o5oP2F9iR9PkJjCvH/hkx3CmAH
         o9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403249; x=1758008049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOv6YZzImpUIBG/mr0NgF5IqW+E610SMfxEFIyqnXkU=;
        b=uTJJhwbaGGHf+oY6XkCNZ8Co5TI0kTYJdTC4/UTA7KotYSBL81psibYTISjKl/yNlk
         Azjc4NG5WOnDCQcKHEeS7h7T/iU/GXK6q4+irjm0SufyQ52yN383iuFXyAv72nemxa4T
         6cSW1pqqcOeIWXqGrb8oq6as/JBKVUzeCBly1gZe0m52xk1jxixrEa9yi/BuJs33BUW/
         LBhfiPe9xuNXVT8n0Aa3FGOuTCx6JxSpK0D1IPOnWobj8aRBxhByScr2JbERDpwrMfWT
         mAQN27yqY9/gHXrBfPm4e5tX7JXTSkwpVVLOnGWT22Biyr7QVyxceMqLArc37i840ybc
         fZqw==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZRcllem3eipaT7bJoyrIBKm+QmCT12SzfwzgX5Yxf4zWTLfc8/wPL5AAkgzhbQGZrzoJRGNjPWmu0TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOPcTF5QYahWB+8rGoSx1mj42Xd+pNsnDVQNzWl6ZXzFugWKl
	jMYjrYTxpPGNM8Rl3ldbn1PnpOQYYzJiuT2QVrDkrM33ZpA+zMlkuUeumbgPrZ7bfek=
X-Gm-Gg: ASbGncu9vJGAgGlmdW2lkZR5YpbNw8MLfDgQ/BxKebKJaqR8wmDAGdT7MCdkSx7gPe4
	L7fpGXhKk0/NIV8aVdgW8NWVJV5BsYWgegif9SIImJCua5vuz9Nr8ArZFyoy0Wyk6YleRoJ80Hg
	bB2I8aFAydsk4aw/bmuFohZ1avL94F88mvEhWKLsLKmMlVp+NP4sFAtUJgddi+nG9LKM7++yzhY
	V+OYhean9IEWWRoFXLd9NALR6xtSFC3kT0BZm31FpwCRsLLrucLlk3+pPOujScsaEpeK0/MnlDt
	tg9uVOiHKeTAsZL78amZATfdkkBzDWryMzUPFhPuDYrtUhMy8wkM4duVUIQiVLRWset2B0X9aYG
	8dAbj+6Cb1tSxuiQFm/2XUDvt8ngqJljmAA==
X-Google-Smtp-Source: AGHT+IEFgIuQ+MAL0AXInCJzlXHyFtWrT8/3RqheCs0ENRxVF9nih4Vnn0GqZYmz9QaRd74+9eyp5Q==
X-Received: by 2002:a05:6402:3814:b0:620:1030:138d with SMTP id 4fb4d7f45d1cf-6237edb1ca2mr9611565a12.22.1757403246636;
        Tue, 09 Sep 2025 00:34:06 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c6a264285sm226976a12.2.2025.09.09.00.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:34:05 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 09 Sep 2025 10:33:33 +0300
Subject: [PATCH v3 1/3] dt-bindings: phy: qcom-edp: Add missing clock for X
 Elite
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-phy-qcom-edp-add-missing-refclk-v3-1-4ec55a0512ab@linaro.org>
References: <20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org>
In-Reply-To: <20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2004; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=eQ/FyPc5Zgfvvoi2dwn7X4THjFGPUOmpjmW0J4V+O04=;
 b=kA0DAAoBG19EyQCVFVYByyZiAGi/2GKg2tT6epSE41heO9EdESvI1fzKKIrV4s8MTff79i2h7
 IkCMwQAAQoAHRYhBE7z7hFOeo8qyqfRuBtfRMkAlRVWBQJov9hiAAoJEBtfRMkAlRVWX80P/1tF
 k2nco2jZ5kwIf66I3/oea97Yez1B5JxFKTF70e0hrnFvMIquCzh2ojmI8EkXUm3Wcx2QJ5FzBHC
 WjpCaSGuLYdy79JaHop5AHrqJqyLsWwi+JnWS298L+P37a+zAwiyA4wGdVu6tgcyXwj9AofiOhT
 v7LJZSHUIXCVBoYnVXtucHYG0liLkdU2K3LnVCmkEeNp5DB5h2cdNgRmgQP6soH/jyb4B9c4+l/
 gRpEoebWv+EDMUOLz6jnLozOgzAq3uXGVZCpzO5DSb+v9zCuaVUyCYFp0DdN5pXR00Uvh86catt
 QHpdrD5W8exgRT1r0dOYZBTXyCVpEyiLC2tyC//2fHuiILOhaGPe+8+nv6IspBd+78t4zALwlX/
 DlIc7mCQzpXqfhQZbFQWTAVzTWhsbbU1BRkEFvKOt1VcfeG53i+r0IPlRnoWY468ohostUl2y8S
 l172uY8CEGzMyKGv8QIvys2wZZ607zDWof0Mzj+46VMfSuNAiiFTE6P0YJQE8IeJ5eoe+XfdSsw
 Mx591B6mR3MwmPv324Iw1dYh3NhiLJPbSHT/9ezJzH3vlrU0FTyN+lbqKt5cuoYwSsIupGva91F
 FsRoWaBh28do8Bn+5sBW8Z43+TFL7jcwdR0+St/sTXNMOOjLvGfkYi+Il1J3rGugTqBJlE37gCP
 2aIJl
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On X Elite platform, the eDP PHY uses one more clock called ref.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, even though this change breaks the ABI, it is
needed in order to make the driver disables this clock along with the
other ones, for a proper bring-down of the entire PHY.

So attach the this ref clock to the PHY.

Cc: stable@vger.kernel.org # v6.10
Fixes: 5d5607861350 ("dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index eb97181cbb9579893b4ee26a39c3559ad87b2fba..bfc4d75f50ff9e31981fe602478f28320545e52b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -37,12 +37,15 @@ properties:
       - description: PLL register block
 
   clocks:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   clock-names:
+    minItems: 2
     items:
       - const: aux
       - const: cfg_ahb
+      - const: ref
 
   "#clock-cells":
     const: 1
@@ -64,6 +67,29 @@ required:
   - "#clock-cells"
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,x1e80100-dp-phy
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          minItems: 3
+          maxItems: 3
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+
 additionalProperties: false
 
 examples:

-- 
2.45.2


