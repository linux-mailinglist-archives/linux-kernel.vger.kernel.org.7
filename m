Return-Path: <linux-kernel+bounces-735495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD74B09020
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1AA587233
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D892F9488;
	Thu, 17 Jul 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="RUEDBde+"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78332F6F90
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764541; cv=none; b=koo78H+H1fxbDGYZYGy/OYHVPU0/KswgX1oftx8KQxYwQhTaIuMAaMy0uDVhxN9IFtpM+PnZpeoPGngJR7qvs6h+jHR8YDnb0LL6AlQiLvS1zZXkpclPd2tbJL3gtItMDwk0Gcm+xGR0mo/KVr8BAtq9CzziUf3rvWvN7dN5vSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764541; c=relaxed/simple;
	bh=llBy/b7Qa/FAAMcEoMOnFkQjPXbckRY7mUt4vQyY1Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADAGkMyuA/EP6dK/m8c36DDKbAPand6oKstPWTDCZs3pYo/o0QU6aIFc8PISTllYh11sdyAyzSGpQfd9xo0Mp2JCR6O4Fe6Lu1xuR/DS68zNmPPpEd4dKdcSjmZxRGnkTWcfX6PnXLqkhMqKa+DLCvOtXvLsXiTjdaU8rTmBLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=RUEDBde+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-456108bf94bso7270255e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1752764537; x=1753369337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNJrEl0O7bRpLpSsIpKxQcUH18AWQLtF460aSt/ftcA=;
        b=RUEDBde+47oQyjH0j/iT0oIXjkq8L48QbYUGdndi28+lnRBKUOKzldrymcU/LbZcIz
         3i3zXmVGvCLnwjMFB9g+qmCLihd8/+nI3WtF0/IuYjWykewreIdmKoK96rdl80lZ8Y1f
         cwwt5gYQF1cD6LUrBmYbgUaLnF7I+O59bRD0FqUpd8AHR6ysrcJuKqP3+okYsfDcOD1h
         UphGjj1bNFtFMlyd8cy0eVwp8Vl3SfQxyQDMnphABH8+dpMVJutABqyFThllsgxl91h4
         nvU/1WIENDQhARQ1IhQOLg5Qacj+JC4S46+gETJ9FPlngLQXcWtucob48TGFbASSDe0R
         ukXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764537; x=1753369337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNJrEl0O7bRpLpSsIpKxQcUH18AWQLtF460aSt/ftcA=;
        b=rj7qZrFthJcDqUz1J9kNv1TjZv9WB7DoTuP6E4KSW8Ufar5Sf8aGMQddlFSzOeX0Vi
         GgzIijygIe7l7A3nHNC3kAlZxwqn2oZbb2LtwjBO9gkKLhNNfeS9l8yTkwVlSuZHh6yK
         uADsK2OieJIsKt4tUHMKZFgCrX/VagwH3CDAY+wFRAlJIJ+TzGIXpInN54S5wlUOWwy7
         NcLbJjyWg7VTOCMeDk6haWM05BdWXLASDFN91NlUpBhjDmhbhojLELe1Ejhn53s4EJ0S
         wUVfx9GSc4MhQXmH7G/EeDDcoFwYaJ27LGLi36oZoAzCoNrM/Q9a0wi6nOGZ2SgomspC
         AaNA==
X-Forwarded-Encrypted: i=1; AJvYcCUI1d/FoSJnJxX+5t7gZwg+r5uk7Vp00RTPnNM2dpOtotpIB0BcEB+5TtYv7waIVRmVfYdclHT5ro+w95w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJ35CZR7kI6H2TTs5L46ZUuv7d55+TWCWIbO1BSCHvt5zEDdo
	d8Wm8anJZmprGB3JpjE7ZryzyM5ofD+b7r3kAoB898TF33zXaB1/73KKIUFAMewdqbU=
X-Gm-Gg: ASbGnctRcxjIiyNq8Ec8CkP6BkoMhyuxxZ7ONVCzg/00OjIEKhhR6YeqTPR/0NOIiRB
	BRDAPP5Q/EOEtmtMgS28A40FVtNNaJ1MgIWdikWRiZbQEWvbv1oxYr3rUgkHTcijbTjQAC4gXqN
	n28jLBWi/yEVJMr9ZUQnplpALKPu5d8jjYOP524tOLNSdxqkOFXawUbwx19Z/fWuuA4uxYL55ee
	l4R1kQP19/MoBKrrNXVHudJdh7WzSiyB5YgVa23id7Ma9Crg2bdj5VCGC/K1kvJj4XsFhzoo3o4
	h5rdhus2azd8tBAs4IWkd2T2YV784c84asHhF+I4fGfIi4OkmBff8uDZF7hOdWyuRDU5obFEQaT
	NGlTL9WF6/SyfwM/w+czhVAi7WXQs27zQEm0xYe05JtYGazyjOw==
X-Google-Smtp-Source: AGHT+IHgNHS/o6onGmsdDfpqQpu068SqkxhZQat/9gA9e8qJKESPJAAsVTAkOqGfNFHJazeHZ3iaTw==
X-Received: by 2002:a05:6000:18a1:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3b60e4d1aa3mr4787708f8f.1.1752764536545;
        Thu, 17 Jul 2025 08:02:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c7:1d1a:9c01:ebc8:7ccb:ef04:4f83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f5cb9bsm25321885e9.10.2025.07.17.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:02:16 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Thu, 17 Jul 2025 16:02:08 +0100
Subject: [PATCH v4 2/3] dt-bindings: leds: issi,is31fl3236: add
 issi,22kHz-pwm property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-leds-is31fl3236a-v4-2-72ef946bfbc8@thegoodpenguin.co.uk>
References: <20250717-leds-is31fl3236a-v4-0-72ef946bfbc8@thegoodpenguin.co.uk>
In-Reply-To: <20250717-leds-is31fl3236a-v4-0-72ef946bfbc8@thegoodpenguin.co.uk>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752764533; l=1105;
 i=pzalewski@thegoodpenguin.co.uk; s=20250625; h=from:subject:message-id;
 bh=llBy/b7Qa/FAAMcEoMOnFkQjPXbckRY7mUt4vQyY1Ak=;
 b=3xGj2IvSWBD8KRt8TspczyjKTTUc/IC++kZy+CcUPagHRuWzBxlsqHuisz0tUS3CtocoXt+Mz
 jwbuRyAT6leDEopMa9dwD5VbEPi7fxlmZLXiH5NI5HOD9Gz99kd2cKp
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=hHrwBom/yjrVTqpEvKpVXLYfxr6nqBNP16RkQopIRrI=

Add an additional and optional control property for setting
the output PWM frequency to 22kHz. The default is 3kHz and
this option puts the operational frequency outside of the
audible range.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml
index abcd4c448e94db1d1e339f7ee165c3e04a1d354d..e75809e343b110eed0fd5f87065d8e94a97835fa 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml
@@ -42,6 +42,12 @@ properties:
   "#size-cells":
     const: 0
 
+  issi,22kHz-pwm:
+    type: boolean
+    description:
+      When present, the chip's PWM will operate at ~22kHz as opposed
+      to ~3kHz to move the operating frequency out of the audible range.
+
 patternProperties:
   "^led@[1-9a-f][0-9a-f]$":
     type: object

-- 
2.48.1


