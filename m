Return-Path: <linux-kernel+bounces-769266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E9DB26C05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F8F1CC46B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6D6305E07;
	Thu, 14 Aug 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0p1PYhs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C89254AF0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187638; cv=none; b=do8y2UPn32PZ6cqCDiTb2v/ETQRmRYCUgWiAadpx3aMrPXJXsBygy1qTKzaRsdUHeUNqAjK6BV4dZmgzDVRtVe4n81hhbDasMM1txlhcXvPt2pLdYVbwwE+u7cTkVSwz77dWfUcbbz2u3LB6hX8jDjAyKoCrj5m0ek+H4wtRedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187638; c=relaxed/simple;
	bh=tuyFNbIZjJIEwYsTvCXnsEW/EVfjfUpA1Tb/WaZ6BA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+kp06/hO7zwBDzPpAllFENsQeTREWk/TGe9tPZ0qs0/ZzBxCaS6Azox0kHovjv62C+2gT7z45BRvEBVZl+nDkb0Qc9pZYjXg1G47mtpzlU18EX0kydhC4jZ3PtBjB3MnsYvLAtdPO230z7ilwqLc5QOke9uNE2Tg2n0UPfYwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H0p1PYhs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b065d58so7363605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187634; x=1755792434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD30mQRry1zYj/pxkKOJqqK6h7OO9d6sUU7HFt4NRSg=;
        b=H0p1PYhsBp7V+rik+q9YRlAXP3khx0uxMf/1GbHV+MZ42eUCuQcCAUHcC8c46D2+PG
         xGUwc8fAg8skNctg4zqHvIbfD/9mtv+A82uUWRxTZ96ZZBf0IpN47AtNi6r2NTtArgAk
         Q7j1QR5RKZqBK6sSWZfWpGNEirQMVUBgqgMJtgT/xZzGkAXFNDrL0YNY5LrKAeo6KwLr
         hCRCz+ivCRh0eW3PIo1oIoR2JhWyIR7JAdhjpue7y4PTCg0/it7I+3M0rQ05VuKmT5pl
         un4eDdE/M5DZ/+a+RU5ElfEKUVyqXi+xENGpsnZiphMomhKXrYn/maioLnWigkFirED6
         rYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187634; x=1755792434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TD30mQRry1zYj/pxkKOJqqK6h7OO9d6sUU7HFt4NRSg=;
        b=irxu0NK6Md35vBJB81EWMePaVGjHdBMVOCZ+4MTs/J4ocyaNU3rHARk2qJgEx4dN/p
         nyI6RbdXZ+5N/oCSrzF1oJCjN2J3h11m4/Hx5WnI5S5Tt27480+qQIfYq/tAvp0zKbyJ
         vluQWggKIrl9PqexREs+S8T6sHRXIpFg1Z+t6arEE/ijCMmtmiw2yt+wMIax+AcQBEB1
         LHhOYAylzGz7cZ0fbGi8cbS7AVzsh4rKfRhczn93ve1/AqgtI7PVw/CZG470sG6ZdUmI
         OcuR+q1oyQ7Cqwojm1RcUArAB4+SKTC+n1AwEjOUF9V503KX2RG6DZGLmnRd/WbIfF2r
         BlVA==
X-Forwarded-Encrypted: i=1; AJvYcCVkPIwusEu8DfgcJO1NoRiq+IpUbSTp+4S6KTm40F5pJ6kkd/WuX3CwKn9ocWYfFFniC5AuqPvckOf/RA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRf8j0lrjNEbNNuVUM4tYpoXzDlgUn3tQzmgqhWuvlzFuzhun
	fOWLGwI4ym/REN/54voydp18B4nw03946BsrNrTLKE/DHr1IMz6gP50eloOl+oo04Y8=
X-Gm-Gg: ASbGncsyaShcPZZmEtTCPiQAgtoxAVolptJnHFn+lOQMKI2g6T825itqT+0Emdv/DUO
	AMhE+mVkADfFDkQ741Ki/SGRZ0GOLGSg3L2yjUMfDf/cjepi9M0Szdc0xcwd4rwxuWAC7O0XA2s
	efq4r/sC5eggL58ui1iKLTr179Iqq64zQwaVybzQqLC1QZGm/qG/xlO1WsFyQc6CPqepjPdApDE
	h5z+NWIsL3bSN3S0W2LpAttqv18rPV8SWN7SHC493ORb5Igsye662AFBDIJrEP6fQN5AIwIdghY
	/y3qFE6AUzE8nWdC6kn9dukFN2tiqD3NAy2lZaRjK+66qXpA7VxHktshoIIOA0ltoG31X5LnzpB
	1O7HQ2Dlpi6epp7WqkJupIO3ijIQnLUc=
X-Google-Smtp-Source: AGHT+IH3g7Lbg9BD0ijgtIIxDOgR9U2NbTxPGle12zoaibJgP+H7TGUyhDPESpYkX6F/UP8500PcEA==
X-Received: by 2002:a05:600c:45cd:b0:459:a1c7:99ad with SMTP id 5b1f17b1804b1-45a1b646924mr27213635e9.22.1755187634247;
        Thu, 14 Aug 2025 09:07:14 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:51 +0100
Subject: [PATCH 11/13] dt-bindings: lpspi: Update maximum num-cs value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-11-9586d7815d14@linaro.org>
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

As mentioned in commit f46b06e62c86 ("spi: spi-fsl-lpspi: Read
chip-select amount from hardware for i.MX93"), some devices support up
to 3 chip selects so update the max value.

This isn't a fix or functional change because the devices with 3 chip
selects support reading the number of chip selects from hardware, so the
value wouldn't have needed to be set here. However the commit states
that the DT could be used to overwrite any HW value, so the full range
should be supported. This also avoids confusion for any readers about
how many chip selects there are.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index a65a42ccaafe..ce7bd44ee17e 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -64,7 +64,7 @@ properties:
     description:
       number of chip selects.
     minimum: 1
-    maximum: 2
+    maximum: 3
     default: 1
 
   power-domains:

-- 
2.34.1


