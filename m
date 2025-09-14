Return-Path: <linux-kernel+bounces-815636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC72B5693E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B753B752A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AABD246778;
	Sun, 14 Sep 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgDbDHPL"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDAB1922F5
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856043; cv=none; b=d3VXh8y54y03HghheBaltOBEIi2nRlsQOrfVPF7cuSrFUpRgp6ngEeKxyk3lYaFhAw6FtwaVNtND+OBfjj67OsjzV0TK3d02+9C947ChpAtaix3e1oQ/sfJ3C/K4w9udtCABFGDrHSGGu4dSRc8ZUVAdT2Od+6/UAylsGxqAk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856043; c=relaxed/simple;
	bh=rruUm1ocHEpQZ4MUQAAECVBOSGcNHmVZdbgaderWfw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+jLnkBWEwAfqzoQxLH1eRQECDV3aKyYbOvcT5CvYDDdf5YFPSLWiqqXHIN3wgyyX8Emyv4DZgFD2b0kW3+wvhwv0SD3Nq0aXNInrtNmbqiIgN6c8X0KusoK1DKh529iLzfom2b9CVyIAdh8CIV8fGIGqjemAmfbO5QfSkIRrVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgDbDHPL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so21304425e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757856041; x=1758460841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAG7m9JuJHlEHyVLrilF0p1L19ca1FzfGVRDxZu6tYk=;
        b=AgDbDHPLIqFZiytWd5LyzSqkMHtBXGA82UWkS/u5tJmXGD60lFGq7TejRYt1PeEfby
         1tXlPkygBsaoRHT2H9dJpYq94mcJBDqhC0dQ+fvJVa3AElH8oDRzmJ1+343jS1WHVT4f
         PHEzfY9Irqwi/KVpL47lU+Mn//GWVoZX+Ci4nmM+MyFJR/1afC1huJ1BMubPkU5KB+up
         /1niqx6GlwJeEnBqKwHUBXGMpJMBA0sohIw3ht5swibQ/rjzAgkaiw/F/Kj3LfR0FytK
         Ue1RTqm8TKvqPX+gZL8GbzZLR3u+C0HWHHSl+99/6eOV6j5ic627vthA/PjUbYM+6qWn
         kTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856041; x=1758460841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAG7m9JuJHlEHyVLrilF0p1L19ca1FzfGVRDxZu6tYk=;
        b=UCNjm4VbeOe5FRsUza3OQ3SiohaLfiplcZfc21VYThiYvyVzF6psys/eo6+ky5Ffx7
         B4eniDdbI4Ux+pH2kIYOVA3x2jjkTiA6q1rxc2UbulYMOuSFanqEf9vNgEsIl38z97FQ
         lP6jPITkScYOezt4vIYaF5oDE6MKGHLgvENpw/C4m51aO14ojHwDAgOm0EstZ9J5dGVZ
         7h+bMw0JCT7ZSGE2NDQL3JWEOw0arsPPSrD2lLrfBnyTTM1+1DbYtGKBQfzTH0jI/Xwe
         TpEC+dyYoew1MCRLmeo3shaQUwvTMJ6p8nTKUCsFW57S9S16nkGj0BvAeesMBrL8Daus
         o9zA==
X-Forwarded-Encrypted: i=1; AJvYcCUhMzfPL3vSa5GuTt3FQIBauPnTzQfzzWEuZqMjR2Ggt4yyCAP3bNoTpgFLpY8taZv1Tw0TFYOrdS6oMWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGKarz/EZ+8/UhAX7m5LZIjfQdiEs8FzydmjXgElwA+/ITWpr
	/goe0TL0RRbbhOS+7ucenV//3lAbhkgtQNiO+fxOMK/UVhVgIG5sAs57
X-Gm-Gg: ASbGnctJvl9yBpCwJdXUWFVGJ2j+nVgsoa8h3rINkeoKwmfQmn0JFkh49R/0IroR5e2
	Hu3+A8zZ3bGcfv2Klhyfi1uos2QEIwexYQ+1LlZtH/zajRdC3YOtQWMjsL6befypsbvWb1z0Od7
	40sHiV43IBpMvxTjrK2gv93hDQMSMEenijWGtzv/RcOZOnA1iuJgmaYhMUcq8NXWhFebBWl8xMp
	7sKgOTEl7hq7Hy7j1kcviC89iJLVN1M9OwWUEWPfqw4NRCsYn0hBbgYwLdHZ5jB2Hvq9kC16Csv
	hXZMPDPf1qJqjJ407AcEzirZOdln7xlTUYj1xEyKWorWtOBncZvm9gUTwW7OwXNv+je1UFy54GL
	jmM51dyNKH+vmjSKM4ovY0u2h3RN1CQWCiIQ67UKZegKJoG4D2NwPDA8cCW/SKPrbkpqaIUaQsS
	i6wMHl9Hem
X-Google-Smtp-Source: AGHT+IGXHijtzVt4eJs2ZV02TN6C9aMKH+pvbvhPrJQNoOx9E+tCmvs9kL5J7Zm+EWTDt2YmA/iNKA==
X-Received: by 2002:a7b:cb87:0:b0:45c:a955:4578 with SMTP id 5b1f17b1804b1-45f211f7f55mr62938465e9.21.1757856040463;
        Sun, 14 Sep 2025 06:20:40 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm29595095e9.0.2025.09.14.06.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:20:40 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: pwm: samsung: add exynos8890 compatible
Date: Sun, 14 Sep 2025 16:20:33 +0300
Message-ID: <20250914132033.2622886-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add samsung,exynos8890-pwm compatible string to binding document.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index 17a2b927a..97acbdec3 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -31,6 +31,7 @@ properties:
           - enum:
               - samsung,exynos5433-pwm
               - samsung,exynos7-pwm
+              - samsung,exynos8890-pwm
               - samsung,exynosautov9-pwm
               - samsung,exynosautov920-pwm
               - tesla,fsd-pwm
-- 
2.43.0


