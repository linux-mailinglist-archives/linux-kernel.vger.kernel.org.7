Return-Path: <linux-kernel+bounces-769267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9366CB26C19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0821886314
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7432571CD;
	Thu, 14 Aug 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDc5ysOE"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A241303CB4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187640; cv=none; b=oK7PcWXcCZM6FqaWy+Q3rJi0aZRPf1dSrdBsu/PFjdthH0FVLJxsIce/k2kVUBsY/lHuTOJDOZJ7iRVV3+UUzpU8CAcnagjCvJr19sziLJiFwiJL0ZI4a120coWFuQSUqn77BEm4gxif0noCBiRIIGQFDbXHn7mblYzG8hGaiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187640; c=relaxed/simple;
	bh=1ZN/hBU5KFnWEm5a5v90vlczlCZ4mmlahGdTTa+btSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1p6+NbxXHsrseQb9tDdSs81CtThpt94h0fnr5+xFH7qvVTKYthfaZkvrDzi3WhOC24B6omNO2htmTLgRVuDPsu39W4odPxbvrfvGHjcPbGzBxmZ9bRGfHgEsRmz2vKWzecXGCMlpGiD+L5FSylX6Na/fxxoeSA26/+09ammncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MDc5ysOE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b281d25so4763325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187637; x=1755792437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6w8t1k0+L73Z3H7zGEQgr6I4vcHFOJ0Mhc+O6mOnc/w=;
        b=MDc5ysOEPsZpzRLgJeMRCPc62mgSbmRtYz5mn8RCsRC0ZfxWSJxaVLcurIktGTYoXq
         aHfAeXwv0mGTR+PLepNlQ/yFKudtVkHj6VC6ceWmve5Bh8Jcd0Jf2q8BSnABSwZaAImj
         fLQ67WN5HktggrpfpcwkDFzdmtrT8Gey5UW5jITC55NtneQ5fTLH8Mbst7vqCJ0x3H7m
         UAyy6y29IMoU6sp5jDAWBl1fGPCDyGC+l/luneApY3pnri1C7Ys4cQbVnv59CybQuxzH
         3MQhmiIwT+fVVpK40pYUOjgHohbCD4/V2nh2xUU4XmrAzk0isM1MdxQA+Z4ivS0B0cLA
         lgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187637; x=1755792437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6w8t1k0+L73Z3H7zGEQgr6I4vcHFOJ0Mhc+O6mOnc/w=;
        b=gPj/q+5hbAA+jW/+qM8Agbo/acqNb92y4KpNKaypotYLxYgkjWc0Jb1hYdZOSFKIPL
         4wtTffcmI4t/tSTcQl/AlDzl9CBbz2LZRObaKsm5tbKjYC/Gcr24UMqecAyZJqx8046W
         AxOvUDFKjt4dZ3eMUbGYNcAQNFs/9QPnQQ1sY4ex2vXsolfQptlY1Qq1kTe8XTREzloJ
         zk/5bCEmxv8qZUA1KFNGwn0r2tAdWGH2vaCKY+pO2+EQ4mK2DR6mOhTmxHk+vfW6+xdm
         JY36rZnTO0Kwp/FeelW6y1vNHgrcsZ/9D+uep3Xul1YCf9JDpTZnNMarwoe1/vE4DgVf
         XNNg==
X-Forwarded-Encrypted: i=1; AJvYcCWk1wuwW/U5Pk9uZoalOpvx1bf+PO7/Yo/9T2vQMnG6FQz3kIGYkby+nHuN0xmwMgJQlYPjAkU8+H/yTl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmDe0D2DSxa2bKqo5FYHi+97A0KV+qLHmjVfFJxpNi9CMBZGv
	vACtuDdjjUKzgs3BmlLdtHFTpVIBgod+tJx+qOtvAGJczU/obCG83xcirCKGxZFL6uw=
X-Gm-Gg: ASbGncvzGAMg4MaISdG1BvDS/ZKeI9XkpsuZb/pxtQ82zOls/lhqC2B8zKXnIeP1dKM
	SntcHrmsWaf4xLcfyJQZdw0Ep5vWzJHK+MqR6emQOp7VWXPxIY+Rsn7qIX4i7y1nr+oC1KBkXsb
	Z6kzsl4MedPo3GUg+FSdI8UnsGpyFB9XJEl7Mfti304Lf/65L4/+IZ36G9nR4py3Rmjdun+Y+7V
	qWkLBMjVjUG9fv9etOotT+FIcJ7LWHyFuGh4zr0Q4ZJLSMPVr7ruT32IUEIruZG8i24RjPWGJYY
	3rXZbHlL3fvdLwVpz3gY4rph2WKpxGAz9G7qUDiB+ayiXwHi72Ikx1rNj/vI/IQtI0iTCyyhKSE
	5HMGWQnsccW7dS2HLVg8WlObIZyEEgUE=
X-Google-Smtp-Source: AGHT+IEZbpliyIDsPb6R0FpfpFlg3UBRXfnKDNpZBswiqyG30cWnXAPOznL3hegH/Ef1DZOEk8/F0Q==
X-Received: by 2002:a05:600c:45d0:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-45a1b644c34mr26991495e9.22.1755187636941;
        Thu, 14 Aug 2025 09:07:16 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:16 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:53 +0100
Subject: [PATCH 13/13] dt-bindings: lpspi: Document support for S32G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-13-9586d7815d14@linaro.org>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
In-Reply-To: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

S32G2 and S32G3 are currently treated the same way in the driver, so
require that S32G3 is always paired with the S32G2 compatible string
until there is divergence in the future.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index 3f8833911807..9fc98b0f3428 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -20,6 +20,7 @@ properties:
       - enum:
           - fsl,imx7ulp-spi
           - fsl,imx8qxp-spi
+          - nxp,s32g2-lpspi
       - items:
           - enum:
               - fsl,imx8ulp-spi
@@ -27,6 +28,10 @@ properties:
               - fsl,imx94-spi
               - fsl,imx95-spi
           - const: fsl,imx7ulp-spi
+      - items:
+          - const: nxp,s32g3-lpspi
+          - const: nxp,s32g2-lpspi
+
   reg:
     maxItems: 1
 

-- 
2.34.1


