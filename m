Return-Path: <linux-kernel+bounces-723492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB28AFE792
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6C61C807D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A042D12ED;
	Wed,  9 Jul 2025 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="xWkSgUJa"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42C2D131A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060162; cv=none; b=SCc10LimJn338uIaOMXCuieuF8D9pCdKHtDnqs9cN61E9EEZeikrs9SI2Fj25CULWHyvbt9au0zhlkFTz4L5yx7OZGefoo/Iq1IJsnKo20rux2xwj3icmjhPAXQcCizQzKMR/iS6NmbFnBejLIYKHs3rtSpqo3o/zt33x8XJyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060162; c=relaxed/simple;
	bh=oD801OyJYm0TzoKKOZTj3O1DfOFU3aBIRy6M+xYUl7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMgiDRCBRORxLSYRT63g+V2kslf8EpBfdfz8MiC9avrMPrQVCJtrSGXLwuL/Ia55wgYkJ6p9ZkaO3yyyOHjCjLtSsP0p3/YynDBqXa4psG6cKvaA1Ant9CgW2LL77+Okccst7TYmySnuIYzekxIGs20tmfLSXNvRGR26QUoSJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=xWkSgUJa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0c571f137so1051011366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752060159; x=1752664959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74lpKym3ozeJInIfjg7y7JEQW4/oh6esczwCLsGr5vE=;
        b=xWkSgUJaVQSQ+A3raRVZ4hH43avKwBsCN/4D+AXPM6/wD+Lli7TNX9TV11zfE3GS6g
         Gh/n5yiTRzoCetRBSZZ5dbN/X6GvYqGhCcEIIyr5YRc16EoipgXevqGmR9kps5yXv/TY
         lkXuogOxCi92120NhoP8k1Cg84kE2oc62Mc4zwIToEnHHH3+rf/l0HcCm9mu83/pqVFk
         R8YrrOhbgJM6wk/3up7GLLNWg5gqPW+iGtt7ynE7AatlsTqwxz6c5pATDDQFMC3BlMxe
         AEbdwmOjYhC5T8HdQMYb7XtROYp6DTSDjHRYjIRIXl2sdv1SM8HWqQo0Gw2tJGXWpoEe
         8zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060159; x=1752664959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74lpKym3ozeJInIfjg7y7JEQW4/oh6esczwCLsGr5vE=;
        b=GUjVAWTqyGMidmLuliN/zQ7b5ts7Yd583uNtt2q7qRVesTPhvStfh+tsuik7Ll7YMp
         cSYT4IIMJ3rvUw339SSYP/lNldraLX9w1FQwIUldnFzmf7fiq5d2r1LHJ4so3qwQzXhL
         MjrbCWJKxA5KEz+5tmAi7Ewv50hH2SARpK2F34d+D1ptZ0/o9zcCxUtkPF+4bk8o6/ae
         VHoVIw9VjTnsDDiUgAeKl4v9RA64yz9nEfCsG861rvJtwrScWNQdM6XTmp7c9LMrKhXM
         ZQf37zdW+4lXbwdR+738a6akjeslwjsgcE2Ktlh2fIm0vxJGUfUetVSYyoLFg2Z8+oyb
         YqOg==
X-Forwarded-Encrypted: i=1; AJvYcCXzUgP83gxB1RMeeJZGUoMRerKoezNdiR5wDKXHlGOX3DF5XsTOcJLZM4RrnSSHWQApnfhv73OaMKpsJDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2kxAvtcYZ1zR3ZIVyoWsoksC6aqkqFE99H6FGoBeMUFdf3ikX
	scz0Pto89t0k6rPQYXsuj4GMGTHXlMkrDkZ7x4FeMzTWAdxutNawbKJQ7AgXVnIX9nk=
X-Gm-Gg: ASbGncurujkXlY8XcYzbEFHJEVjZ1ABshSE8UbrfXehSh7pHyLA20E3mpGjpyePL9Xr
	WW6KyxhGYoUC7ohewETln90b6QDOe0hI7svudM8ik7uBvquR4U0C4FTq+Jceo1jwB9pw2LM2AIJ
	rutLcxOXPO4GGLQiTCyF4CU4UDY4h8lysydvLc1XmzHp3ywRpu+hxIClg2JY7RJzLC3KSqirOCA
	+JES9TtLIm97KbckQgSPIFl9zuLHTTVtyCxM4tNevdeJqW7eyj5W81gqMnh1JAh24QdUsiY6vcG
	M9rQk7jfEW/r2nphvqR6NdbsUHHX+2FUExG5OgdOM5YSXK6U81H8dyFF/+s5nS10bg8yYaU7QTN
	n6taomlCLvpnT08+ZtSbTMyravRFVY2OB
X-Google-Smtp-Source: AGHT+IEHXA/q4RvVeUWMB5+8Kt/h33MOXaZwfUVmkNUbM229Z1xSuzwOvj8c85A5E6Ij5QjdLJ0Fbg==
X-Received: by 2002:a17:907:7f89:b0:ae3:d021:9b05 with SMTP id a640c23a62f3a-ae6cf5bc281mr244392066b.15.1752060158698;
        Wed, 09 Jul 2025 04:22:38 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d93basm1079861066b.4.2025.07.09.04.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:22:38 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 13:22:27 +0200
Subject: [PATCH v2 2/4] dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIV0104
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-pmiv0104-v2-2-ebf18895edd6@fairphone.com>
References: <20250709-sm7635-pmiv0104-v2-0-ebf18895edd6@fairphone.com>
In-Reply-To: <20250709-sm7635-pmiv0104-v2-0-ebf18895edd6@fairphone.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752060155; l=1257;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=oD801OyJYm0TzoKKOZTj3O1DfOFU3aBIRy6M+xYUl7A=;
 b=H1wCYnwuu6PbgxLICu1skMzgyr160vcgGQEQnAS9JBqNT/PD44IqoFohiR72TT430xhodRLOa
 TRcmz1vzPTYBqvsyySuOyNPt4w+d76ApVkGcQuBGYBcYQ3DirPi2/X+
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
to include the compatible string for the PMIV0104 PMICs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 055cea5452eb62ab6e251a3a9193d1e5da293ccb..e8a1f524929a710a6a65ba3e716c697f24524496 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -64,6 +64,7 @@ properties:
           - qcom,pmi8994-gpio
           - qcom,pmi8998-gpio
           - qcom,pmih0108-gpio
+          - qcom,pmiv0104-gpio
           - qcom,pmk8350-gpio
           - qcom,pmk8550-gpio
           - qcom,pmm8155au-gpio
@@ -228,6 +229,7 @@ allOf:
               - qcom,pmc8180-gpio
               - qcom,pmc8380-gpio
               - qcom,pmi8994-gpio
+              - qcom,pmiv0104-gpio
               - qcom,pmm8155au-gpio
     then:
       properties:

-- 
2.50.0


