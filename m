Return-Path: <linux-kernel+bounces-792893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95719B3CA10
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4482A3AEA88
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02BA274FDF;
	Sat, 30 Aug 2025 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBDkISE4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DE2749C5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549150; cv=none; b=KR34pHDb2sbVm1XoaBjsXO+qbsE6UOljEPkLlIioiMDxrR6inusZitzMBy7CLAKw0eG+1HAVl2OREyRHybedouXrJq9FJKngfg5ndsKFJpo4NQ8RvlHTKXK0KBCUcv238zO//u5Wo7XKYw6l18VwC8/ON6AZRILov5Le1UHd82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549150; c=relaxed/simple;
	bh=phCIU7qXQwzL9ywXevhpCuLOX4bC84K3Yg163SS2Jhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1wKgyGVLtDoIyLyF107LbyZ63Ydzw8joGtQ7zdvsgyBfd3krWQEKcplm90pC45bvOeXkR4cGb8yQ5i8RksVoOZMnpNKtY4K/8w21npMT+Tmd1lnCMhDTGTJLunPjfVMpuZTYujkxweR/h+12x/cyBrFVbxPzSV65uLMqnZZjRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qBDkISE4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d323be1617so9795f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756549147; x=1757153947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc4VvtndTdQUwu9NAMxU40diYp84hx+fKTxM5CnEC0U=;
        b=qBDkISE4rNvm6z2ws3zYdpEkoJs5FkfrcwKPndZK/qmYbtU5o7qk8DRH7ucRTGyMk6
         i+4e3hJl3v1YLG/u23OqBdvXG6g2m5Yd4o9l8zL/3LPzIVUlEXWibqhvQqRiOUifF1Pp
         b9qO79VluTGD3RWRvWLtep2BVHgAgwAVdASKFvsVe2pISMV9B9sW2Hy9zXm+2nYZ2mow
         hTigNAOMggitrsxbw/4lb8toItcZ8giBsIKEytmW/Ry9GaaxorJuN8AVGuk6Na/Tuc3w
         y+B0OiK+KBx8SnaiM7xqggG5SG7BtOlDyU65REClCvHA9LD3bRqdy9ky3REbJGFFcZ+Q
         M8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756549147; x=1757153947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc4VvtndTdQUwu9NAMxU40diYp84hx+fKTxM5CnEC0U=;
        b=ezeEbVw719QVEyPEjtmVsz1jMTQyQu1HPJTlNOxCIRtREm7pe3SsvSqoLK7SnO/Tgi
         YVlB04oUq+sYRBKADgrb39aZYQc6QEs0zFdGZgiAxjKo37+QNZmB/aeKfD8T1pbmd6M4
         0pnhtasx84Z7EV1COjitNf+UTlM1uwNTx+7PNCjunI5CnnTxJBhfLrT3AZPBtf+f8dUy
         BwzK8YHYzZhTsds2iCrUDerezkDdpE9z3RXpM1GxVMdsM59PPoKhtA55Kl1VhUg54GRw
         rQUyS43BOfcdBlXQBrw5MGU5amLM6m5pzR0lryp0mwkeZQyeqsTttCkm6hSLXqBk3YdQ
         qsvg==
X-Forwarded-Encrypted: i=1; AJvYcCXAg/e4UTZgQKxxurQOtBT7PmLbBYZrjo+esmQ7aR5ZjHndUAfIbXNZfuNJx6Uh68VWa5cZn/id7pLw64g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwq+q+jdHG0XPneKRM0zuVR+GIgOvLEbeo0YU/0saN6kPrG88
	/SmGZ2kfTKRAdznp1APAeaKSR3OzwC919kYS//UCKpFKMjcnQLTfdaymZoUl1TLihmQ=
X-Gm-Gg: ASbGnctG1fLyNTgBFkJyt5oVj/xAhabbUU7NQp9nFSYMFmkM5ZY0nxJK5c2zia7t2YY
	HyqPS0iChWDiN2rtqICXg5eoKdASAnoVMkdch9ugSEzpRb7psfOxVXCu5bmB5fAWK+NlQRjRnNI
	VgEovQ0wV2y4SNR46KiX5lPn3Q5/4zRo3swKt2SwGVepA9n/cVDUm/okbJLG8MI8+MrMGHkT++p
	hRnqj7ZM9xK/JjylKU91jk9Y/2gLLuiyMytgL8++D2P1K2lD7bUgBIhcqLqVjd5H8WIAO691mNH
	H44RyafP3rBK7gsrU63iWdrVIubPh7eaPsZqSPdz+mNzKj34DzaxbWdZZ/p6c4vHevWRBCx49gx
	e0DVM+KpDrFv126xWbEPNG2c1z9A1XwN7Wic4zcg=
X-Google-Smtp-Source: AGHT+IElyjWIDdnRLs09FR+6PzPMYJ0mBBOSNWeVs5b3fm069jnqc4HgASV/Qa+IsKi3cpsKc2Birw==
X-Received: by 2002:a5d:5d0d:0:b0:3c9:1b91:71e5 with SMTP id ffacd0b85a97d-3d06606301emr1956916f8f.7.1756549146595;
        Sat, 30 Aug 2025 03:19:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276c8eccsm6547492f8f.20.2025.08.30.03.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:19:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 12:18:57 +0200
Subject: [PATCH 1/4] dt-bindings: watchdog: samsung-wdt: Define cluster
 constraints top-level
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-watchdog-s3c-cleanup-v1-1-837ae94a21b5@linaro.org>
References: <20250830-watchdog-s3c-cleanup-v1-0-837ae94a21b5@linaro.org>
In-Reply-To: <20250830-watchdog-s3c-cleanup-v1-0-837ae94a21b5@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=phCIU7qXQwzL9ywXevhpCuLOX4bC84K3Yg163SS2Jhc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBostATWdrpdUjx7iDa4Cq4mMsNQm8U0vKHMo27y
 uln7YNtvyaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLQEwAKCRDBN2bmhouD
 1/u9D/91m8aRXiwMrNQqYcDCDbp+fzpNTIX1p0ufDEiWmRJdp4r9vOLcLqClJ0ZrIN0QPFKfV8A
 ZwN7RWtY9x658v8E8l1eosqy3gwhoba2WgKC0cZpVltv8wEqCPATPk6Z4wNAl5ALIIXDSM3blgW
 FFoLip9pEF7F94wca7cKsdIdLKtkOiklZ3c7c8EmI11uiGgV/rm3JtbTaUdtZubMCcNoj7/KF3c
 R9fP6FnjwFbXwUC+DmDegoOBKKmdMvioZVjsFX1RDGhVwULF5J0A+XtzqYVFJFv5LsQPrUTNyqK
 5eIyaXy20Qmm50YIauobjAYV4JSwL+4BMyQt2L/TIx8D7cy8ZtFybxjbJ8/vp+pbhU4vbWG99K0
 xmn6JzcqHSt9uAeL+majTJPB7v94/DLdXRpbzFMQ6TPvTHHJRrjB2A8jmiqNXGvstRiYPNIBSP2
 DqXlm2K7X8uaZ/Xr7F6cWeCRy3nypZ4G/xZFD8klLD36PDbJJJkhoksqaAPcV1OfZJIhrkrj5QW
 omWsoukJVFDZw1nBJeZOnIb1o+fxpzHsyk58xPOTQBxNRKl1XhioEzQLW6m6BAdrTVkxNvVOpfV
 lRXtKh/Mlqcm0Hes1AsZ92NTSStjpD/H6651y+S7P0oyqZgrrAqfobIQXEidlDzAqsYhK996DtQ
 /ylTuDAV9xIAy5g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Properties should be always constrained in top-level part of the
bindings, so move the samsung,cluster-index constrain from if: block.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 53fc64f5b56d33f910395d32b35e0905b8b9aa53..445c5271879f002f2b05645a0e748dd9be5aaf72 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -49,6 +49,7 @@ properties:
 
   samsung,cluster-index:
     $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
     description:
       Index of CPU cluster on which watchdog is running (in case of Exynos850,
       Exynos990 or Google gs101).
@@ -104,8 +105,6 @@ allOf:
           items:
             - const: watchdog
             - const: watchdog_src
-        samsung,cluster-index:
-          enum: [0, 1, 2]
       required:
         - samsung,cluster-index
     else:

-- 
2.48.1


