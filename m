Return-Path: <linux-kernel+bounces-723167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EAAFE3EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2293C1BC4FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43C2857FA;
	Wed,  9 Jul 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="5kOdlUBY"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F95275859
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052726; cv=none; b=Jfr3VAbG71R/yWgk/o7kDrFsLOWZlvVsKw2Z4FBvrOivmzPY+diQcklq2VixT4xusX+XWYjypQw4QDfywDOZ7O7WEDK3dt44U+KRor1q0ZX4iSc4hOsGSrmhLAt52/6+ehh79u2LCxWZCHmYTiACYz6nH4GUL+Aem8ZB9+m4bIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052726; c=relaxed/simple;
	bh=N1DuyPNcj5JKCc1IHvUuzahkrwJboCfhgqDrPUo+Zic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8MdwVK42+JW1tDmB5JYkOgW6ligrZyR46OG4wEE85QR8CfeihN6EoijXXi+CSL5dJ4dwIGBCuy+fbZ0Dg/betpYEt70nYUGWGBhrymjys7+ZBuFl9TtLv9yZ2G7G1hXHA+9maC1Yth5cTF9vp5BfGG78Tf/GgJB3N/MAo3jnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=5kOdlUBY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade5b8aab41so1112535766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752052722; x=1752657522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YzGffSdl0SelALHaNtnKuFhO/J9qLrb0FjuAIV2ya4=;
        b=5kOdlUBYcOsuIB/hCmWJxrif+7v7Ne3pKpNmfpcSf8/diAlBwk5iIcjTJIe9QS47wc
         sMTlH9H72c6pQ+j5POhsHs6z49htzyqoR88BJkwKdOeGBIXLE8lJJNumJ3c3DGys50uu
         u7ofD0Udk+Az8BE4+OsiAZ34qDjldOwSU04iC+crYiw+QfumE/OE/N2V2nEPV1l4UtKa
         Ar+z7fxHkyAt+95b/EDfiOOsAYXyQg0WavGqIX1U90JEGNxzbuSRPqNodlSE4K3mw4jB
         cxmqF/zPaxesgLzjUSZSfJ8APMU0QapEWyT6U3HxlyiHla+ih8WWnN0xStTX0G4zm7No
         rpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052722; x=1752657522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YzGffSdl0SelALHaNtnKuFhO/J9qLrb0FjuAIV2ya4=;
        b=Xas3n6Fpq4DYBsZSPwIDgJBCC+sOtyLTALoKm/A127VWHx5NN5tEj84oB2xHG5DId6
         3N0oa/Vps66T7uAXJY0rWWEqnz4vKRjRrotC0XTVt7NVKlAa6Gynt9pOtqJCMKJStaeW
         vGmEliMm0sjZiqBUEe1pDpuPHsEKqG1vROowAYrhwlgF4ujGP+t2tLAgddOfJ5NlbUh2
         vwWqqQ+yUYIfldu6W7gHzGiUIQ/ytGAUjS5UdyhiRMGpRpYbutyfG2fcDXwkFlOugMqr
         578GFUS6HiOfAUkzEtGi2QJZrFPjCQyOCEUrrFigCCUVrCoWKaWzVBPRyUI8EPW/DQwG
         morA==
X-Forwarded-Encrypted: i=1; AJvYcCUZvsqXGno28dGguhKNua9qhzw3pVg8PTNdQcizB9Z89Y6yUkVoTqQghqMBOzEKUhAyUwATNk5a0DaDzR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoWAOFTzx2fP/v1eQ9100Z+3wKRUmkbReFqzvCjlqI2ac9a4La
	5XarfEV2NrhqVGTbGjuQAQiUtgmhP/MBqOuWOlaM5upVxeP1K8iGBb79Zq6kEC3UVxo=
X-Gm-Gg: ASbGncv1D3RRc+DaDLtttRsLQmdpcESeLPhav0DPBouhUXpZUHZpLVtdIyZ+SYmWIsX
	G91z31Q9yH673Y+u/e6wdMOlThIKiLQ9cnIkV+ChBkXHB+5Ru2sH2JwGsZuXiD5ftZwlpAMW+n9
	7huw7kKZImsO24m8+hfvkUEPYC6RSdsUC3A2uRD/3yRDnYiiaGg7teTlkD+WYDat1wMAy6ccoIX
	yp0Hn4VRgZdtFZl2rBvTcB3mf0ZBjtVCuJnAFmfetSMu0kxNxa/wP90GfVc0U7o/d71kAJA5y+g
	nuo2KP2d99v3dZ2FNzoMvCHCyf1mSUyK1ZyAk+naJ6/I3t0cIFbWQzq6khNg3E5S7rLIeTOyXQZ
	10zRr4pagOzSCXTWf0mEVvp9WUkvDHlmf
X-Google-Smtp-Source: AGHT+IHxUaM+C2R6jkXjJD6rCqMOZdTnVavMM1pgYMFVzDnu9HtXv6fIbTrykY0qZGIVD/WAolgKPw==
X-Received: by 2002:a17:907:3f17:b0:ae0:bb16:1cb3 with SMTP id a640c23a62f3a-ae6cfc3e135mr185121566b.51.1752052722372;
        Wed, 09 Jul 2025 02:18:42 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b5e737sm1060116866b.142.2025.07.09.02.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:18:42 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 11:18:15 +0200
Subject: [PATCH v2 1/4] dt-bindings: usb: qcom,snps-dwc3: Add Milos
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-eusb-phy-v2-1-4790eeee7ae0@fairphone.com>
References: <20250709-sm7635-eusb-phy-v2-0-4790eeee7ae0@fairphone.com>
In-Reply-To: <20250709-sm7635-eusb-phy-v2-0-4790eeee7ae0@fairphone.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752052719; l=1258;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=N1DuyPNcj5JKCc1IHvUuzahkrwJboCfhgqDrPUo+Zic=;
 b=rb96OCei+nJnNOyzP4b1MNdnFGw98NO2wwz7mhvHHcJLFGHhCzGptxQ88EaQxQvSSui0OygF3
 0BbqX2XwpQhAMBbPnBeOAM30ehgBH0np3JfuopEX/Zk0s7vD8pLqeUn
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Milos dwc3 compatible.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index 8dac5eba61b45bc2ea78b23ff38678f909e21317..dfd084ed90242f0e77cb2cde16023c3421c5dfab 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,ipq8064-dwc3
           - qcom,ipq8074-dwc3
           - qcom,ipq9574-dwc3
+          - qcom,milos-dwc3
           - qcom,msm8953-dwc3
           - qcom,msm8994-dwc3
           - qcom,msm8996-dwc3
@@ -338,6 +339,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-dwc3
               - qcom,qcm2290-dwc3
               - qcom,qcs615-dwc3
               - qcom,sar2130p-dwc3
@@ -453,6 +455,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-dwc3
               - qcom,x1e80100-dwc3
     then:
       properties:

-- 
2.50.0


