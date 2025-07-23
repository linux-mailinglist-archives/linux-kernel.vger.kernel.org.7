Return-Path: <linux-kernel+bounces-742648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 667AEB0F4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B691899CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04352F3626;
	Wed, 23 Jul 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="G+hMqo/v"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71E2EE5F5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279451; cv=none; b=VUVzuoLNrurzto1fAYWiZDmIrZ8VjTqh5cMjpozmbLj6YHwcKb8WMSMy63P8m7x+ApSaYq5vtpS7LFH0mwOipNLRQUs+8C7KuZLybfGP/FwVobSa4iCjW1LZw6YGx6GHdcK+nBO2yGrLll6XeSLOM/NCxDGiEhvliPB4u9Lt7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279451; c=relaxed/simple;
	bh=iFrv0UOBrWQDOMIVYCVEkyIJ0o38UILWsfNE6sREkpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5oa1bhZp0KwOswdaHvDij8h8sJSB1FPBAz/C3rewnE3KGOltHG4fIgyeQ8LSDFHVbhBR/CL1AZXXm6igJtHV+Hs0GVzClduVCIPqOpmJyKOc1l3JqZIk+dTBJ1QIsblNV5qIOrCc5LT7oF6W/MJUlscpWBC4dEwNkjbpbJDV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=G+hMqo/v; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so13750063a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753279448; x=1753884248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIayvnL52YWH7X/Cr5CMXwZtJGZyuDUcKNZ3PxwKQms=;
        b=G+hMqo/vNEw56CMZ2SofiexvS8vVbsxq+zeSEnAWJFNJK4+tVGgJoAZuOy/t9EOjNv
         6D6cdLkm8tes110bKGEuoLyFhbeWRPVzDwKV+ubTf8JT29smqb6LjDXhtixgo1fPtcrc
         TZCk7hZTdvrRMJPBAFOI4+jZjFiJT3NxG6NnuxulPeDAkjpsRADqJw/rTVyklPq2dwYC
         ZGIwoi4UNcVY1nJm0180ZBoKj1t3EsFOtA1mWl7ztghaBK+PHG1WE/SDmiZ+ehv1ADE7
         ZcaytxTrSsd8NAyV1w5fwotJByOyjqLfJTA7BrrIrOANIC/jKOxV47CCt10Whwy12mju
         FwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753279448; x=1753884248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIayvnL52YWH7X/Cr5CMXwZtJGZyuDUcKNZ3PxwKQms=;
        b=UmyFjInILp9KETELFiaSrPpTJc7QPc/ph5LQF077g44C5JrieXywUHEH/li1VRrtos
         Y3E5AcJDqLgjYrDUeb3hVwE1F8dkSjlfBMmNpAKkhfTbV0j2SPLlI7pfnhmwnyElbW4h
         a4xvuk/g2JYlbLB24XsMsbbJzc0dj/3a3or/wwqCYrJ6xtzegUp/QHM1tdLnrV8JGDQ1
         sIQS5Lf/QXzRxYcSkI3m1EPDPtGjfOvDe5lFyBPlu6F4NoRz/+aI+3uSPDESCVGVQihd
         ibXlcnVwXub0JeZMfTGqamtpQIVvTnuVR6Ta5Di6KaqqZ1u2vYIjxIF65Cm8/W8KGEZn
         /54w==
X-Forwarded-Encrypted: i=1; AJvYcCWPgz/V/tZJ0vuxO4R/RXOrnmzBgiXzGt7pMgTIqSbdIf2DbRNsNf3NfdPpj7MBue0kSbJrYh25kJneuWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZUl2XHBVS411NGEj5KDvUfNfY1X5xew+f+8Bx10YiMrJXcc+D
	4j0mFVIyWHmqj/45AZiyDjf9x35M86W3iWWbF7WQ+RF73fwqH5ixsE9naxQTH0YG9zA=
X-Gm-Gg: ASbGncttLrPMBQlH9cFwR2OP/OpwaLk+KhGA0i0Pj6LbkRvBmf0RD8qKWLSSy+AFVRx
	qKVNozIBVj3GuklgOi1DiGnAgIUJpvO7Z6ew3prNnE0omcAfBecTdgb2oKj+YiDGe5fwUg5+/tL
	hlpomcFW4kjiGFnEkg2dmNvVzI1dZIwckG4HS/6DvdjSEWPc0H0y4J3/DMQ6IfKTe5Y1Pw9X4Ox
	7Yt7bI2RsD+rm6neijt0VJQlCfcGWxLF7yV9tet3pR1t2ITuliYScSBSHUMHw+n2qV3k9pLKY4k
	Qe5Mx3KKQyXsvhBXXuvdMtpG+X8LLiJUyqMFel1ES29S5dK24CvocgDh3539QCsvLR+TM12CSDv
	EurEbmrrSjFrRuopLVfclyCDmk5i2V+P92Tomt23s3zNYHGVmj6XYoMK81dEIBAJdF6i3
X-Google-Smtp-Source: AGHT+IGR6BvCSuwozQuhF+JK63ZdSllhSvwjucskJLyJAXnOTc2Yf1K6fqw2IyjVv7b8YJWo3DFKzQ==
X-Received: by 2002:a17:907:9813:b0:ae6:efe1:5bb5 with SMTP id a640c23a62f3a-af2f67dff36mr337902766b.7.1753279446731;
        Wed, 23 Jul 2025 07:04:06 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d46ffsm1054830466b.42.2025.07.23.07.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:04:06 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 23 Jul 2025 16:03:38 +0200
Subject: [PATCH v3 1/3] ASoC: dt-bindings: qcom,q6afe: Document q6usb
 subnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-fp4-usb-audio-offload-v3-1-6be84ed4fc39@fairphone.com>
References: <20250723-fp4-usb-audio-offload-v3-0-6be84ed4fc39@fairphone.com>
In-Reply-To: <20250723-fp4-usb-audio-offload-v3-0-6be84ed4fc39@fairphone.com>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753279445; l=1387;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=iFrv0UOBrWQDOMIVYCVEkyIJ0o38UILWsfNE6sREkpI=;
 b=Ztq41RZXSMGO6exUAOuQ4XQcdpBry6H1ciTLjtAknNQkm9moDrjoxqdKldMAFo0BxG/t8N6Qw
 UOlP27CPefLBV/wj79OId5uHt7EjrKLju9XrZCiuJZQRup7OWYCuFaK
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the subnode for Q6USB, used for USB audio offloading.

Cc: Wesley Cheng <quic_wcheng@quicinc.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/sound/qcom,q6afe.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml b/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
index 297aa362aa54ab41a956b3ceda73d4c7027d72a7..268f7073d7972da2ef46d36264c0f7d8f648071b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
@@ -29,6 +29,12 @@ properties:
     unevaluatedProperties: false
     description: Qualcomm DSP audio ports
 
+  usbd:
+    type: object
+    $ref: /schemas/sound/qcom,q6usb.yaml#
+    unevaluatedProperties: false
+    description: Qualcomm DSP USB audio ports
+
 required:
   - compatible
   - dais
@@ -64,5 +70,12 @@ examples:
                     qcom,sd-lines = <0 1 2 3>;
                 };
             };
+
+            usbd {
+                compatible = "qcom,q6usb";
+                #sound-dai-cells = <1>;
+                iommus = <&apps_smmu 0x180f 0x0>;
+                qcom,usb-audio-intr-idx = /bits/ 16 <2>;
+            };
         };
     };

-- 
2.50.1


