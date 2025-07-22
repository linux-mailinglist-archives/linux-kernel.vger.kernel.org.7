Return-Path: <linux-kernel+bounces-740839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872BB0D9D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B05AA6766
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6BB23ABBF;
	Tue, 22 Jul 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUfeuJqu"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727E2882BB;
	Tue, 22 Jul 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187952; cv=none; b=u6Ox3+KEvGIDMcHFKY85uScmDMcVDRKhQmOEl4i9Cqq6V9KHjYgUuwhcSou0+QFNWJVT9JXeJzbAt4zUPyRpkGhUL/nQ647vWN1/xqxkTQsf/RwtY3/SkHBvYYKrPy2B2+cUqrMDtgoTLnbxYRUKTy9RBNrywlhi1V0cDCiA0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187952; c=relaxed/simple;
	bh=+9qUx5tq4U5MWvA4F0+qY9SSF67hDpTXMro0ZrJl76Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpz/AZYBklbGPxQWheFzBMcFNrNoRRPiRrzroL8s84RjkHO6+eix5sNcC41iTPWFABehoCqOHdBgaYIhvgtWa4HtfbeWYGQWLSzywpxdCOBTymTkF2WNm2wFWE0u3EGpy0Nok9IQ4ula5RofDHavpTA/ZvlW6PKeLfpPKzixsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUfeuJqu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso5096882f8f.1;
        Tue, 22 Jul 2025 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753187949; x=1753792749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWluu49IJdbI2h3dbimjwSTi4G/MwPZWZ2gMCYo3Vrw=;
        b=VUfeuJquL/0oGNTBRWEmHPThe6V92CuAR8S1XR8q595dlMzaYy+j31eKlhzZ8NIlpC
         QTbicjPEJW2MnZIJUi5hKne2rCUyUjYagJkcwSIbufxyqLJehvRxpI9qNz90IylhC7cM
         0jWnEN6LlixN/WuwPoc+ua9K6Bm8eVjYWMuuPzNhvvoh4jrCSvVf9ZQxU91zPDMHNEYZ
         cnriaHEKZxiLDE0xMGa7dLkZjcs86VgSgqdNwGwnlCAednMnJt9e1s+dugFbCGqy7gUq
         16ncVgVdIWEiKADSvfsUDNhYOigweR7jbkvaevqIAceTYAKsUf15U6g/1FXgmNk23zK/
         9Ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187949; x=1753792749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWluu49IJdbI2h3dbimjwSTi4G/MwPZWZ2gMCYo3Vrw=;
        b=T9QrtzV6XYxuwus4qVW16SgX049Xgv2fw5QiGIfyAYzC3HTk0h0qPejhdBGmaqnR75
         lsUREQF6g12U92j1va2U3heHyqfqDAX5QCPP0Zm8dn0U0Z/bBEmrEROxI3hWq3GWrLJU
         366WQb3rCN/12TWEISaoET3ji2SaQZ/50kEM8kJ/p+VONAAO4MCfV43jjSyIUv/qdgg6
         +Aes7Q7rw3UhNPm2jEG5/FXFKBboW74ab6O94CqKsrL/3TdwNVDCARl/dzubg5GGmSBH
         LNGltnt4UR6MFlreso1/cN2VB6EL2Ubhy60Twlpbes8fuq9gQiPdbP188kwbXMPp9O7z
         TXVg==
X-Forwarded-Encrypted: i=1; AJvYcCUygIYuhXF7zBCjK2Dt43kPzZPWBk/EnpXrEdTr6viehZu1fTIyTMdv3YHqQYZ6A4P92jIdlkN3yaVWxjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsCE55PM/vo2+87LWgKEiGJhtputey9yjjzquKIh1EL+g7aaq
	XU78pE0cbYIKMpkPyTWUz5IMIRSEULyKU/WFegc23t7J5VSavjOkVAVp
X-Gm-Gg: ASbGncvHeNi5338t/Y7zdIDOmQ0USzpWGPJzFoSMWN6/HmX55NfukDSRTIbjtwKDqVb
	ic55sIxzpFGVJ6/I5BD4lF26THNmcI9pf4uNQoJZNcFFVUfLzHsE2ucFpi8BUoKLxDtYz7nDJ35
	aj7HEtewRwOYMPptKmyRjDqnWzD0Krc+pYC7a+Bhck3yfQjPpd3H7OF9kARNPrzBNJN7Z4whZF+
	MUXXU2a5V1K7ChBo4bF1uNmKyccvdIpe1pEOADN8Y58cmbvZXi42n67bit8QWQiAphyobMnkgtw
	la1pV7oenjognbxRP/vua5HyjX7nM4voHUKPbDUGjoxtBNbIiwnfKELkFKFGSLcIV8KacqdsLb2
	ObWX+0n53rk4u6/EVWuT9+f9QaUo=
X-Google-Smtp-Source: AGHT+IEraH3X9pXO4sggn30Iq2vKffU5EddS/TLc3q5rEJWuWsuIcw3mUY8Btgrh8ziam+8yV1+nNQ==
X-Received: by 2002:a05:6000:2286:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3b60e53ef79mr17656375f8f.55.1753187948418;
        Tue, 22 Jul 2025 05:39:08 -0700 (PDT)
Received: from tearch ([46.104.48.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm13525197f8f.58.2025.07.22.05.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:39:07 -0700 (PDT)
From: muhammed.efecetin.67@gmail.com
X-Google-Original-From: muhammed.efecetin67@gmail.com
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	lee@kernel.org,
	rafael@kernel.org,
	efectn@protonmail.com,
	daniel.lezcano@linaro.org
Subject: [PATCH v2 1/5] dt-bindings: mfd: khadas-mcu: add new compatible for Khadas Edge 2
Date: Tue, 22 Jul 2025 15:38:11 +0300
Message-ID: <385b22d3f1d30e559cfdc08616812de0f958e5af.1753179491.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753179491.git.efectn@protonmail.com>
References: <cover.1753179491.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Add new khadas,mcu-v2 compatible which is going to be used with Khadas
Edge 2 and potantially new Khadas boards like Vim4, using the same fan
control register.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
index 084960fd5..fd57ed92c 100644
--- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
+++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
@@ -11,13 +11,14 @@ maintainers:
 
 description: |
   Khadas embeds a microcontroller on their VIM and Edge boards adding some
-  system feature as PWM Fan control (for VIM2 rev14 or VIM3), User memory
+  system feature as PWM Fan control (for VIM2 rev14, VIM3, Edge2), User memory
   storage, IR/Key resume control, system power LED control and more.
 
 properties:
   compatible:
     enum:
-      - khadas,mcu # MCU revision is discoverable
+      - khadas,mcu    # Used by VIM2 rev14, VIM3
+      - khadas,mcu-v2 # Used by Edge2
 
   "#cooling-cells": # Only needed for boards having FAN control feature
     const: 2
-- 
2.50.1


