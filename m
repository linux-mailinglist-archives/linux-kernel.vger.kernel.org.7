Return-Path: <linux-kernel+bounces-802639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61852B454FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EC3178CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EC730C621;
	Fri,  5 Sep 2025 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Q0hhARJK"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE191309DA8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068870; cv=none; b=b64Ch1b8+IoISaIicH3SzLIpMrTsBY1zeD/gz8fkyhp6Nf6Qd1wW5WfvDGIhx5+pcO8wCyTLPtPSA3eaDtv9TF+yjOTjDUDeb6LOIKM6Xr6/rF5fy7oXKON2qhkNktsjMZbydOgB1xtNhfbmW+92WNYYKfGKTLQg+ReJAWAW844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068870; c=relaxed/simple;
	bh=xEZQ2DP+0xmVOtTUyk0n7mNgFjGNQdkHGCz5TGjrLY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apJNQuedV6l9B72q24buxsmnn8tTgtOnH9q+vmEFQtVT2S/mvavEJuJrLxUjmNVyuYdKmTb/M/+gkBsA42P9HB/y6yEDSmTJewNuI/Wz4HxNKOjVJ5w0XUoPkyXcs0HQQ21SDHvEPkaEn3i4UqlzwaS7C2a+zYRkQJ8zS7fr5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Q0hhARJK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d19699240dso1842037f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1757068866; x=1757673666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1rvQZQxLwmsRnPml37c1Lfi5R0CJr98kBiMU9gyfu8=;
        b=Q0hhARJKtDduuOM++E9K8JShdedFgklsuGWTdQ8S+72wPzMCiWwXFUFmFY2ioGS5S3
         1ApB3bKmcqftSDgwo264haM1Nh4HLbthC8muLPMPpzrOVwGg79YS3qArGvrZOEp26U2+
         sUiX0BSY7MA7RCsCJcAMp8nymUIZDZzyMo6poflCTQbHZJv0ahLBr4q33j79d1i0UZ3g
         jKpAO+7J+tB7fuh79PMK9hC0jtw+/hvEyoUXlBy4gAKbpEJOeJkIGREwxc1V4CRZ1LwI
         wceV15QnwEQgg4POUN+Wnm8tStou0bL1RjdXLlih+JB10FCQIc70pOuAd7pCRforHZC+
         amBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068866; x=1757673666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1rvQZQxLwmsRnPml37c1Lfi5R0CJr98kBiMU9gyfu8=;
        b=caEsR0eLb+KXQD8VzskDmQmweb4BZOH0RxcQjePbUUZbUYCrIgkcm7AZtSXO3w3xBe
         Zl5xvH826RMkFmADI62LSgFx04haocPf8VCIPoqzcky/1m8+k13MVV+8o5RWWRwGlajd
         KSrKm4DGqKAiZeoWtSYW41xPKmB6nztcV/OJqvwKQjU5ZA9Lie6D7/ZtX1wcG+A1hFbG
         PuKyrpZ6lF3UYJD4X/zDryJ9rt8gRCFlNWgAl9CgOgTZhDKKms1zV9F7fP3J0T2oTQyK
         +YG/J4ps7eY8Gtqz5/PAkxrWhY7cKuNR10xi295MMJkoxUS8qxHHmsnLQ6/6tn91XQCo
         3RcA==
X-Forwarded-Encrypted: i=1; AJvYcCVSsa7IjsWxP6pfckKvfN45CH2OGxVjN5Vnb8Sx/Tx9c9Eq4ViR6qft9eNCzpPOrx3BbsgAZX/VMW5Tl9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVhU74ycZapnpL4CeRaaM7LkhN2dGiAOHbm3Wg4JKSJqjLLkh
	WrKouSPN15R+j+LygmwJt87hemF38VBe522SsUkmUzQXYtngD+cTkTXSSz3awZvGOn0=
X-Gm-Gg: ASbGncvabMwR3KX3oAvSaZiV2K+dHOJ8WBKFm4ZoKOo9lxyj4vVyEZD4KacU93ui1Cv
	T5EmqKUn8yH/0dp8cofE8o84pityrO9PFAyQaq8xJLxvrkEYNBkbjD6Ij+iVw2AgniBNNkOnINK
	Pbx51QaB0b1oFz+iMkv9RTHmBrebpiwzODR05g+fhZ+bmoRH04328QDqdAuHaZObGpSik5+/7/c
	IY5ew6Ae7nvLLKWj0goY4vt2d/2s8qx2UV+GaCZJJx7YBJupXT5DScjMFV9wlSMjzuxE70F/OSV
	TfA6/J6YP1RkSYxjaH8Aod4T1Y6/fCXyhuWhHnYdD4ACCjP6Y4izUr27HyBXUyzVRQWD3dnOI+I
	onzDRK8JKTWpxLwGJby7T3L0P3WPCeonxJZSBO5KqsqXNpiR+e341l/QxSwfoIXyhBK0zt1vNoA
	/oUxjHSj5MGyOTw2diUbPWs8GSdHtGaw==
X-Google-Smtp-Source: AGHT+IFIuk0QBVF+N8cmk094clxzhJ4H7q4AzYcSgacFq2+ob1IqwwEgeaHutExdzNR3cASZWiUeOQ==
X-Received: by 2002:a05:6000:288d:b0:3dc:15d2:ba9d with SMTP id ffacd0b85a97d-3e30463df0cmr2266019f8f.31.1757068866016;
        Fri, 05 Sep 2025 03:41:06 -0700 (PDT)
Received: from [172.18.170.139] (ip-185-104-138-158.ptr.icomera.net. [185.104.138.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6cf485eb7sm20990738f8f.3.2025.09.05.03.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:41:05 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 05 Sep 2025 12:40:34 +0200
Subject: [PATCH v3 3/7] dt-bindings: qcom,pdc: document the Milos Power
 Domain Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sm7635-fp6-initial-v3-3-0117c2eff1b7@fairphone.com>
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
In-Reply-To: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757068857; l=891;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=xEZQ2DP+0xmVOtTUyk0n7mNgFjGNQdkHGCz5TGjrLY0=;
 b=NjgjfvDq5UjS7i8ksrCpgumVPl316Un9DA2C5ULUSAe79FSyGV164Wjf6IlnP0bB3sye3THyL
 vPBrwd2qGQ4DqkyA8E2ISIlwJ///87lFFBwCUWBWF3YyR4N0p5Tq7p4
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Power Domain Controller on the Milos SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index f06b40f88778929579ef9b3b3206f075e140ba96..3f90917a5a4dd9d068ec472565f5009690ea2c5b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,milos-pdc
           - qcom,qcs615-pdc
           - qcom,qcs8300-pdc
           - qcom,qdu1000-pdc

-- 
2.51.0


