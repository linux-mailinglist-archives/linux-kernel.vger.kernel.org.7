Return-Path: <linux-kernel+bounces-831280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B638B9C45E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6BD325153
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191027FD7C;
	Wed, 24 Sep 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ZrFvoSuz"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406E153BED
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749444; cv=none; b=uiWz/HgsXO03LV7KS+ZCLmtabZWUtTPbknFoazlZ8V26Lht4AvU9O8lcvcKRyhGFDQoj7kCAAYpneN3v7Omc+1ieftA8VuTbutVYxsSrVUJWzuRH2iqN3Xd4RMZgfYHwLBORVfH4RYYZBzXN4a8suP+DogdX3sRSyjfScZ73Mio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749444; c=relaxed/simple;
	bh=r6vJatirenvxNJq5RVo5+xDwbBNx2oZNLAnvjLIizeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfSS4AJWcDs2un1f7NQwnGma+0yB/jP1nXFE11QHdZCAJUtUlT5XxUuc90FgR+nGDFTQEQKpRZ1RFNGym504IhscQNF0JjjHHt+TRuNFYu+RjKC0ptAQagHZVDOPTCxY7VxU/jFt/qg4oWDt11ReqkB5aYkJFMdwT7DWKNlgMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ZrFvoSuz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f67ba775aso432965b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758749442; x=1759354242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uf8e+i1NQmbBzvEMBLlbeFVnrVkfp1K5SVjnFrmkNpk=;
        b=ZrFvoSuz1IAPwAZp6rzfn63RaVCY1Ax7AxITEUeiwaM7Ga63RcFMnKPzGwEg1enbTA
         ngwZ9RYeyGYwpAgc68epnqwvUqOdyioJTJ5bGJdh9svyhyi1JLRSY406pPdCya/BXoiv
         VQJyJO/tMBZY4xZtHShx5lukxwaY8Il3sIHCm1vBiikWiuQxJhQWxdXQNLvtZJCXBtBO
         bEF0DMP9TE4+U/STOjC2nZ2paXy8ilR5FJ1AzLNm1S3Cevvu9ZmF5lBaxHO9bfOveZEc
         X5rTZjywkh84l6UwmrCPCEPw/QFQIlStBBQsN+k2J+s9bEm7Y1GQlzoE2o67NFb/B2+L
         N76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749442; x=1759354242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uf8e+i1NQmbBzvEMBLlbeFVnrVkfp1K5SVjnFrmkNpk=;
        b=IxMrTTY8oL0yyUEv7Oxi2zpaSiSWCeW82hgKZ7taLBfYa7rPJJRsNlDLWIWCrlV1dk
         ZpCSzA8Qk2O2zbXDemoO7CrHrwPz/ll8flNDd1bWdbc6pKCIzsH6mQDiSo+YwvbXRBlO
         drrA3ZsARnsd8yaT8Col+iynxpgja/GwpXDl2N6W1wQRn3fHOOh5zpv2ZKJIYTTC8SLf
         arPuYeyR69qvOAoakGAlr7KvcFlSZE4eBmjTHTKhFE47e20zcO+I819Mp2P1ivUXoYW8
         ag7Q9+czH8fFmrrfZ/3B4myqKbyAXG3KPVNjVIJW0w/d4Xp3N5KpEsdGjKxF2ogWZN5L
         II8w==
X-Forwarded-Encrypted: i=1; AJvYcCVb1wrXT59y6l6bcihtkem6GXQo5VbRk3EHrpavH42iBqUe24HMnZ6QcIuJxUbUjMubU+ch67hm+ELqB6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlBbfiJa5dGjokZUwl5Lvk3it99CFtVU33ewRO3xyGkqnsnpW
	bcP7iVHZCzeE6nTjRUO4w0nLylkJES0W32QAI1oq42ZiE0lLDYFoJcPrdBbKT1wFCJc=
X-Gm-Gg: ASbGncsOTl4QBFjYlOY5tFjfAnSJW7FHURV38tEoMsGnJrJVkpzN4aMoIZc24XreL0n
	kmk9AwMitfKyRM0uv6vICyp7hY+LgW8mzZMgGpv0z041ty++IGf2ZzjPeFimwePA3EdVSWih37f
	vLh1Xd9r4htr8TXWUKCE8mauAtQCp2R//DmQNv1nDqkUj/B/J0BGJZELuvmqMu8LoBOXssUy2r9
	52rWI7+dPGvYstazCOlQi/4G1x+YcV4owDwGE/hWS8K+jcg7CtB6KqpBqR+//UEsyqbwJf9DtGW
	HAJ2hpfwftNCbhr+17XL3GuwXg4iU5JzmORBSpNGsmwXqBFgB2vrpMyHnJFkIPwLPOeXT//xSnO
	jM0ve5enaDpdpCPJTSBruAvS1MvOM7E+5crsVrVTZ+3M=
X-Google-Smtp-Source: AGHT+IHDk/mJZU7GjxvepTGSrn5V0zMSz31PMb0YzmQruhmfqOi7Q9v9gnRD+j8qskbbixZ1kv9Pzg==
X-Received: by 2002:a05:6a20:72a8:b0:2c4:c85a:7dad with SMTP id adf61e73a8af0-2e7d6ca978dmr1157135637.46.1758749442471;
        Wed, 24 Sep 2025 14:30:42 -0700 (PDT)
Received: from fedora (d-zg1-232.globalnet.hr. [213.149.36.246])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78102b29688sm3243b3a.57.2025.09.24.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:30:41 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] hwmon: sparx5: make it selectable for ARCH_MICROCHIP
Date: Wed, 24 Sep 2025 23:30:02 +0200
Message-ID: <20250924213027.1887516-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the same sensor and driver, so make it selectable for
ARCH_MICROCHIP.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 840d998f850a..ba2b7b2f6c44 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -632,7 +632,7 @@ config SENSORS_I5K_AMB
 
 config SENSORS_SPARX5
 	tristate "Sparx5 SoC temperature sensor"
-	depends on ARCH_SPARX5 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  If you say yes here you get support for temperature monitoring
 	  with the Microchip Sparx5 SoC.
-- 
2.51.0


