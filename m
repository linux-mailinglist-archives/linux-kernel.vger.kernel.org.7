Return-Path: <linux-kernel+bounces-834179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E99BA41E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D022917278F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FAC223DE8;
	Fri, 26 Sep 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdk9624X"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F271C8603
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896361; cv=none; b=MDvxoFNys8OUMf+wUyTXh3Kk6xKG0oz+zMbHF/qRMa2VXoOQIY87aw1uA8gDzGAzYjmpHsdCnmCC/Dpb+1Jd1zbx3l96DXk3LnBqB8k0zPasnKfnlm1nth8CH+1sdN0a2NwmjZ3uZ+gGO3i7zMiJEu/Q2AeWqLcwiDuY600vUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896361; c=relaxed/simple;
	bh=6/JQRqBUjkyOthrpHav3m3u/rhn4XRG3F00Nzd3iX7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeGgskMkeb2T/QUVNuKdFDRb3FsOA8AAjO4HBKreUQeFmJEKzZbhkUbu6IM7kcqjfnKDi5CxSI5e/3rUqp9eiAY15MgJ+62tzCbZqKJev4b/CXzDbsBLahPDENrdIjLxbfNUlUG8H/N/HMd8Ea/fco/ysYPAC+GHCMZR7M7XPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdk9624X; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b109c6b9fcso21054851cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758896359; x=1759501159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7RhkLG3JZ6AWWqhGvapjhsuUBsTMt1EMhEwLlIwGFE=;
        b=Qdk9624XheBy8q8fKYUANY0V5dF8L3t56Yq3iVWKsKT6+g7pCi3AChpD5g6arDP2q4
         KswmDsFhZjbAlrlv+bqPWFQgIZvl5s8g347+dWsfiBUMPN5sSKj5WTS2v6s891s3Vhjy
         Cb9nN8fIStc4KFcjYtRyfI4fwd1i1Op7ikFQ2yRIHJqNoewhWtF763XaZb+2VhG8FyI6
         Lk2n0T8zzT3SYzdQR3a+QYSDBmU3XAwXOaqr+x9GiZMititSL7G34yEUI2pMRzidMHZc
         pZ2PJVMy1IpZjm6htdHrTf607v3RRfi+xeBAwc8wZ4gnTx67F7V9Ki7Bd5Vq12aQSe+9
         NKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896359; x=1759501159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7RhkLG3JZ6AWWqhGvapjhsuUBsTMt1EMhEwLlIwGFE=;
        b=JbByRSKGewJoLg+BPvBZgGSdOvdfIi01PULONRMR4PPl/YS2zP4bt4ddPZp3jdBx03
         3qURQbJ3ML6G/LQoko4ugM+LT3GIFxbEoUdH4CwovwITV29fKqiUSG0OwIQ5yl5mV8Cl
         vANnPqJ1FkE7rYpvM2yAqbA0RuTpqxinWSwhlCfERrZBowE6lGWA+rfatSOmyHhKuodV
         0O1H5sXJ+Xy6tEvHO8njl1R2rTVOojASnilWaAMcjej7wbwRTBsCMPKm+UEA11ipR66M
         4CwcUdCAtAIFQ2F6pwsj9FX/VPZ2SWTvdfvgIsw2QWjLuKlGXUaGbUDdiTtvvGMIriEu
         A9tg==
X-Gm-Message-State: AOJu0Yyk28MHG49LsuFy7JqFRZM8xRIgKT36vtsIiqY1ZCs5S2r8QPec
	IMYyp/+W4csXax7xL5ODJfwAYeYhRA712wtb/AEXayrZHinGUKF6y1yu
X-Gm-Gg: ASbGncviEjm/GvZBFK11KSr1cp+BoZo19ckR/qG6c1+fzkyYvyC3J9jCSMijcgvqkWn
	cza9m9V5Vj2uKQWyM/1sQO4uGixZCsTyFPj800RxMUNDqz3AdlOctL9v6783F9X8oOp9S2h2Wga
	9k5i0wKExWj703Hd7yY446zgN2E8ICKceEj0OlTg6WRnFDanJnwF8L0NEp3H6AcffySzVHXRO6b
	jgn9YSzopo1yACts6tVcYS9+tn8uZdCh1VnbTxZKV9ztIYPH0370QGNO7Fyjdl5VzrFXrUf2/H8
	t4bYMZbfY1zKfFUMhnFbPWFlpkh2HIIJmMNj1FVDVOtrsT+aNYJGvOH2dpc0vj5Sc98OjLPNrn5
	DBOROEjT9mvK1QzZBwAXdJmi2f0nbStRdDWApgXpFr8dBwsvN6BdnCvjt/Vyw+Le7ZZIx8CauDo
	qXPDc=
X-Google-Smtp-Source: AGHT+IFYT5zqtCX6jEUpwYjGWGW6f0XlIeWfVAPlXuLdY4tpOyCPjaihGRB/xqEcUQS2/YwFMG0jYg==
X-Received: by 2002:a05:622a:4a87:b0:4d2:be57:c380 with SMTP id d75a77b69052e-4da4bfc0801mr99026071cf.62.1758896358460;
        Fri, 26 Sep 2025 07:19:18 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c28a89bdfsm287474585a.18.2025.09.26.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:19:17 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 2/7] dt-bindings: leds: add default-brightness property to common.yaml
Date: Fri, 26 Sep 2025 10:19:03 -0400
Message-ID: <20250926141913.25919-3-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926141913.25919-1-jefflessard3@gmail.com>
References: <20250926141913.25919-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add default-brightness property to leds/common.yaml to establish a single
canonical definition for LED brightness initialization.

The property is currently defined locally in leds/leds-pwm.yaml and is
needed by auxdisplay/titanmec,tm16xx.yaml. Properties should be defined
in only one location to avoid type inconsistencies across bindings.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---
 Documentation/devicetree/bindings/leds/common.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 3e8319e44339..96bd7fd0f053 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -173,6 +173,12 @@ properties:
       led-max-microamp.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  default-brightness:
+    description:
+      Brightness to be set if LED's default state is on. Used only during
+      initialization. If the option is not set then max brightness is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   panic-indicator:
     description:
       This property specifies that the LED should be used, if at all possible,
-- 
2.43.0


