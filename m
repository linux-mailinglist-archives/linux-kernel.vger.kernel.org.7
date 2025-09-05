Return-Path: <linux-kernel+bounces-802638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB72B454F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16385C0EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E030ACFD;
	Fri,  5 Sep 2025 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="yUR4/P1h"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935003054D6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068867; cv=none; b=iwR22nbFm2tNvXG7PMz/j5u64hi1wmGzcHvQMGhTkjnLTZ83g3vOHcYuDJeBWnzUZoRH3XaOhzWrXuokhco38nM5ILb57jV02ZUkwk82gbw2vStOmsnSYB+yTh016G4+6+o1pCn3/40DjzSuaWJLfXIQltilJ6ls6pRhv/BmNTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068867; c=relaxed/simple;
	bh=BsquXCSdmRv8hbIvUjTb7dUQJIWJ4+iHdiZoxAVtdRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAW7c7zgKSeuebAc+YQptHb27kCNhQ0/AAqV95uT3SEEjPIxh8NJGN9GaxMVdlqtG/nOFCGjZ0CUDsxNVlzYxvxUQoK0FZOuOdDtZIzDBpvfeHIQ32ZegVS+G0QenRawcWqmTth/IG6yUHvmlONJCPsURUMx7oYTzkd5UazFmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=yUR4/P1h; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so1348619f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1757068864; x=1757673664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vq4GY2r0cceMRd0WxojTtWDxH4I3aOXQIER+mEWrZpY=;
        b=yUR4/P1hbCo9eoUFZPWYduHC/ELgVqflahkT8UskbtEV1IIvcy5HLCPfvmgNZYX9tS
         3NJruTXoUcfOFx9nK0yblOZgUxuJZjwbFpW8rDQNMDUNNX5rqHo+3TPXYxolwVb4iP7d
         SyxI487AbppQI3JaqKE6xL30A2bLwX4fvYa+GE9E2lbCHrGyK4fO3frBz/IRyTBBwVkC
         dzrWOZgU2Tm38NQ1LlzY7Y22H4+Z9AaUfT2Z4Usj9xAzK4Q5Hj2S3TvatOzIqONITksj
         VqG+BNv/I00lHQSqmBxleunFi+SXj7iZRkSizi6Hn2VIpWGr2ZaVtSCqiCirszvO0DVP
         nmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068864; x=1757673664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vq4GY2r0cceMRd0WxojTtWDxH4I3aOXQIER+mEWrZpY=;
        b=MrN+9VXy/VNCMKC0F45mglM7LOufsnX+zuTCTA+a/feYzWqlbgYWAV+JYUdOpJgV1F
         h21eetgWEjEv88WZXL8pTaDpcRFU+X/VLHjzZ0gfHtzi5E6raNjhQ85DaC4rwfEtNmLp
         TvPfSCfRj4Uv4WLBkbc9EINL6Hu7JwMH+2I/RJ3vkDwvBTlSg3yy2eE86eBJNgdubICj
         Q3jRyl/SJc31e3kh8j2GREB3tAFofL0wqBXLtGmY211ez50zrkRjGXNFByHBd/yYI3s7
         abLIdMMW/8Z/a/7bwKPRG91yw6OBZSmVCdLKmG90jrE27aHBsJcHyeAXsU2f5U25cC0B
         gqqw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/b3yCEzjupwmiIIP3VVb7BVawc9coHeWCJBBW1ngxLz3PSaUM8tQ0/kUY4ChqLhoA1jZX9aQ6vsRd5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgayZXiSW0PceH/sHxv5kaq8Ft+8OtYyEmOIDMfE/NUWKoJ/N
	ppdsM/RYp8lIf+QZpr9r8Zs0knO/Wb7EsQdEZtvU+SxSRuznwNgYdlsdFP8bGEhRynA=
X-Gm-Gg: ASbGncsFpvZMTfFiY4EwhS5yXc2Vg2De/XqWFRGCfwpMc/DrEPXfY8w6Z04cHJVjjFh
	3j42PifWKPMriMmi9b6VYAcG4V6wdEb1Q+Bm8wvuA31/4ypDSc8+0GytD8g4RDcaxx3HCRFkYIN
	b+SoMO7N/Bdq8IJJJWi7uifzeGoa7emvuTR0G5Od9XxufhWCnXr3Nbrd9jf2OjvqS72BDyKwl5q
	xXgMZa+ba0LCnnIoVP30+0bwm03OqQfjZvquwgi/tjcmYUUF5omSKX/COaxjWgVLx3FJUHk3DUF
	SjI8xAalDwkFLFqi4h9ryT2AoyjkQj+HFFCUfApSa/kNIJDh1P7/0XCC7LDGodfjczFUg+OF/s2
	+pVi8332gCJFCst+Toq9x7UvG6zLn+DyrJXxC8n4ugYy/cpvLosQAg1VHLDcS0x7tNNi/8oq/E4
	EZmdoiV59Q18p0aj39nDnM1PI88GuMGg==
X-Google-Smtp-Source: AGHT+IHG8nffzwD4YN91CRrTsA4vU+N2ZBbmAzmBwvrFMUoXDd0zamtpz6w9o1A53yZ3pJ3Fdfiedg==
X-Received: by 2002:a05:6000:2910:b0:3e3:5b4:dc27 with SMTP id ffacd0b85a97d-3e305d3632bmr2626788f8f.47.1757068863712;
        Fri, 05 Sep 2025 03:41:03 -0700 (PDT)
Received: from [172.18.170.139] (ip-185-104-138-158.ptr.icomera.net. [185.104.138.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6cf485eb7sm20990738f8f.3.2025.09.05.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:41:03 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 05 Sep 2025 12:40:33 +0200
Subject: [PATCH v3 2/7] dt-bindings: crypto: qcom,prng: document Milos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sm7635-fp6-initial-v3-2-0117c2eff1b7@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757068857; l=922;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=BsquXCSdmRv8hbIvUjTb7dUQJIWJ4+iHdiZoxAVtdRQ=;
 b=DufvbWhWfijv36FttwJUJbmZnqswuL+O9y5KlTf3evp/rae9jPjUvTHmnGQuHkt4QK2UESAbS
 xuhpq1+V0Q+DzEy1kFhJr7BCq7NmiM9RtK0Ej98vvt2HYMjZaC8HrYH
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document Milos SoC compatible for the True Random Number Generator.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index ed7e16bd11d33c16d0adf02c38419dbaee87ac48..0fdef054a1a30c363e0d99518351fb18124904f0 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -20,6 +20,7 @@ properties:
               - qcom,ipq5332-trng
               - qcom,ipq5424-trng
               - qcom,ipq9574-trng
+              - qcom,milos-trng
               - qcom,qcs615-trng
               - qcom,qcs8300-trng
               - qcom,sa8255p-trng

-- 
2.51.0


