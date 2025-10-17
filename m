Return-Path: <linux-kernel+bounces-857361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D222BE6A79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D69B741999
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7C731062E;
	Fri, 17 Oct 2025 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gI4ptFeP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C830F958
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681599; cv=none; b=u/ODVHzrcl8A13UVFxVOKJ/8rO7KQrEJrOHn/HkVWVBfrYEaf/mnfuA2g1f7nZrA9BY1tV0Vo6G7GjQMXL12zdVQ3wHmQ2X3GtJG7CSbgcBl9NDPF137mX5pYulDXQPMYKxXMFL93jU6L2nED2aPpoL80PeQttNwVhQFMFh0Hog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681599; c=relaxed/simple;
	bh=eF6t9Vq9NRea3XnH1BHglCTN0IeLN7yA62hWb+lXoeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaHgDhOCzJvcv2v/JACN+6QI5jhU9Vxa2IX69tKRnO6sQxs5uEq4Am9syv2q2gNk+k32sLW9k0Mw+O8A/KTdGQq38X6s8kSKSBJSWF/AYTsiuaL2h1U9mtUuqiaJXfNJi6LuwxA7T8cNcO69aKh2/9L+Nl3ykmipB0HM18ZEdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gI4ptFeP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4711b95226dso2047865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760681595; x=1761286395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHSNJ2BDwx1sBbfCkuw18NdbM457O5a6eDYxm9b/Apw=;
        b=gI4ptFePjPd23cusxBMiooO9gPjaVXKeuVH16Sq9TrAYSb68PcoIxvuviViJjSARD/
         k+SHjLrGB17S00Zg4tuMgiNDgHHEjjz7ue1ZRQ2FGpD+yKVE4b7mgmemATWoGEdT8Fmc
         DUP1s85K/bsUFBIJNTpNjb9GNHnyg1/MP7qdMibT1hUzCI+VqE5cxpbXdlZcPVlSfTm2
         eEFOPgyzttZuLv3gN18aj2y8aQD2W/GPahATDDgV4yXUe+01hpVY5tPO4SPtvZiFdT0+
         bEdYNCX8lHsTm1ugX/cqKpyk8hoZPpLRPS7WN9YnAcrH7hSiuIkWGxi6SNkIxnDJQtj+
         Q7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681595; x=1761286395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHSNJ2BDwx1sBbfCkuw18NdbM457O5a6eDYxm9b/Apw=;
        b=iJoajxyy3yxSY94wPbUqEbqFlZI1m1pgEwhGPkC/0A9tzGKckHGfhgGXth+r03ct9D
         wCeD3CmQp/a3kL11+zgRjd2Gr9bvGIyBbTVk7z9tgeUbu7C+g7YO3qtBaiDLgFW2G+HY
         XkbrZVnoKP9KND7NfhZ3W8Co7moXDDzj/IbY/hrn74ElsqDT6QVe1/bgIXdRJ2PJ/S+k
         HfsjdWNEbNRZwFCaHBpHG4GezyeTFJqEcQQMfc7ZkkWsy9OCikVGYxmLAVqchaOzQ0FL
         4M4gxiYR09eOu8pYdZbUU89vO65qbsi+mx5rNNhMdtOefI5PFLM1O5Df4/Aaal5VPz89
         BAvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX467H1oeO+bzuQMf35+D99hKZHub90387/FkqaqlazyAFMoc/KDUbaoRm6yBJZg6mgc1EpIPtOKfJcxII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYL9w9Kg142CBzjO/70yKBFe1D+Yy4Td0fg3TmJUFu+OjsIam
	8+tGuMnIsLbOX617o+wP95xGBteAtbf28AXahywNP8tH8PTrPj+DwHvuCh2zf+mo9J4=
X-Gm-Gg: ASbGncsS9agxbzCzbw4pfBIC/iSUw7UGPBPbhl5fqMDmq17gOWFlzIJyE2Xdh+lL69C
	wfaa2kK3muAqQmYZp3mIAy4v3pEI8Nhe/Qnt39y+ifkqP1dOlheR72BODblcQ8VcU8VhgT8JYGu
	+3ixq/9tBJCKZjEsznVYlLo2RWhY2xtRooHhlJHOIFXHKzPAzPi1ipA/7IG0SC/Vb6enpIohA+a
	IECnwfpySNeIJyPgrH8f+grisKUPXl2wb2CyRIo217DIOQchN80emayBkdSKqJAqpycF44nqUPz
	nxen4REobc9bMhRQJr8WgKOW2GN2G2Gw5cJQ7R8Eotrs7jeKTUCZG2lGFNRC4r4lGF6C5fDNa6N
	qzUFzq6ypXglNIDE/oM77bCYXDolB2TQCIkkNWOpPxR1KYITmx+IcKM1yA5lY6iiMh4ZtITuQnN
	EbT7FphpxY9G9LpMgs
X-Google-Smtp-Source: AGHT+IFi56b/X0lBjC6eoQ5DueToZROug6pRk4AZnyscKkreLGme/V1PG6KxmiRrNewDQ22JeqVkQg==
X-Received: by 2002:a05:600c:34d0:b0:471:1717:409 with SMTP id 5b1f17b1804b1-471179071b4mr16544585e9.23.1760681595439;
        Thu, 16 Oct 2025 23:13:15 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:6426:9b9b:6d3d:1da8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114429679sm61624745e9.8.2025.10.16.23.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:13:14 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sboyd@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	srini@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v5] dt-bindings: mfd: qcom,spmi-pmic: add compatibles for audio blocks
Date: Fri, 17 Oct 2025 07:13:14 +0100
Message-ID: <20251017061314.644783-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If/when pm4125 audio codec will be added to a device tree file, then dtbs
check will emit messages that pmic audio-codec@f000 doesn't match any
of the regexes: '^pinctrl-[0-9]+$'.

Add the compatibles for two possible audio codecs so the devicetree for
such audio blocks of PMIC can be validated properly while also
removing reference to qcom,pm8916-wcd-analog-codec schema file.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---

v5: implemented Krzysztof's suggestion, completely rewrote commit messasge

Previous version:
https://lore.kernel.org/linux-arm-msm/20250915-pm4125_audio_codec_v1-v4-2-b247b64eec52@linaro.org/

 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 078a6886f8b1..2a7a92371b55 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -137,7 +137,11 @@ patternProperties:
 
   "^audio-codec@[0-9a-f]+$":
     type: object
-    $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
+    properties:
+      compatible:
+        enum:
+          - qcom,pm4125-codec
+          - qcom,pm8916-wcd-analog-codec
 
   "^battery@[0-9a-f]+$":
     type: object
-- 
2.47.3


