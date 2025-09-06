Return-Path: <linux-kernel+bounces-804139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9707B46AA9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957023A6C88
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF9727F4CA;
	Sat,  6 Sep 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXSaiG4b"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2E23FC66;
	Sat,  6 Sep 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757150273; cv=none; b=PzKFCAMqYIrfXwF+HAkYgYKz0U7Ouol9yxJnpM1RSoD/Zg5Qw4cdtsMoZs1kHCTWxRFUk2vAjm3D0cW2WlltRvA9nXMnf64zY89lIniP7WFFg41GHrxQp1UcS/3lAioa1o0dpym1fcHKDGPfz9Q4Mer+xQGjVscPdg+QVqeuVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757150273; c=relaxed/simple;
	bh=KngI5sX69UHl6zztwuTODeaqfXt/Wi1K6usTJRVh3Qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ltDKHwWXhUmvWspxXi7jriWHSlvidovvaMdGPVO0ePtYn1wYBKc4vCEh/TsbR8l7Rqb17eqBziHiTO7ZagrRZ+IqhsvR2vZ/pZtDgT+a6AUN16pAyLHsbinifi1nsUFnVk+sXIBBMDUcIzffElP8SAwyHEBjAz3OWyFxdEg1i9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXSaiG4b; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24456ce0b96so30468055ad.0;
        Sat, 06 Sep 2025 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757150271; x=1757755071; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ve8nBlpidfX7Xlj9Re0PkPjW3YfTqNWsYR7YDLtDimA=;
        b=cXSaiG4b7Kjq/DEC5ZP3QAwiyvDdqMbFH2s3aPwRCemEqPwD2bBBR9A5nmkO/Vp/fy
         HrxFXGrYuAOLBjKS8siVMRDYw+wVboJkcDtUnuOoeajQKgxvZirH4S8pSkQ5qctWcKfT
         J/3UPfjqRydumDgk81EExLw7AitK/5NF5qcqryt9vs2gbFjFMGrguIRm3C2t0F4Apxrx
         Yq68RT1vk/bXvASsYAfwm5+vDdezOjPyVQZkHqO08C+KhxGbIn60XWiqG54ELW5Y9N94
         mdXQYgT1z2Xwgz4lBhlUdmuxo8hwIrZjCUlLwqghwZJiOGA8XBJN5OkguoRh2QGElYJR
         RPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757150271; x=1757755071;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ve8nBlpidfX7Xlj9Re0PkPjW3YfTqNWsYR7YDLtDimA=;
        b=SkFm7N/Me8/1E1H71j/q/QhrIvZPMYSvJtWsco4yEIrg7WvKmmxoObEgNYdZJdUihq
         YHsOjb67S7fGd4VVXGfzI22cv3S2Ykgm23QA9d2zJy8xPwm6Se1jvzHaGt0lxC9fPEWB
         Op9JLSTKHxGqLyvaPwerCREanPy0ap88ndlp4G7vAKX+QyDZJ7jqqQeRX6lAoRyR02lS
         nWwpdldyb4HtckNUHg3ZFtjSD/ZqUVS5N0qPLphGrnJkMigkxQH+d3YLIu7Fbr824ukJ
         oxSkgwe6Kxl1/iq+N1j454EiILD+JbmW4eGMBUxXtOWTnQW00TJvpdZl8gvnAkA0Vz/w
         OaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjlkKnLYRQhzWeQG+kX0W5ZQnK+fC9nwjxqP/d/X0+a6+zdTqq8ODdBQrmPfwgtxdCj7U88WoIBumaKIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQ/BK2nJX29ZG+TUxZNOslL30HYQ5d7Ja/BjcpWzNUwWy1ddu
	pRAaYrSOvugjv0ZUeBvSeAYNNX/EKb3Ym++s2BKgjKJ5SKPh3oKV9IQA
X-Gm-Gg: ASbGncv/VfyfIO1LQ4pVU2fxW3Hwy6ptN1iClGusWm+pjwnK9TcqiPTC4aj6VpKUDsH
	Mk4O7JApE9SkNlfUUwCqE4ZOSpkUaHYblyW3nreVyHIQwc1ocKPC36pJq0YvCi7awMMV0CmQCg9
	otuL/+rR3dL3QK/vOixuMNCOo1pPI/dwXkIiBd1WVHNT6swL4jZ1cQs87nozokGDC8HSRN+qfZv
	jW7VIJzO3laETmP9cPfgq+WSCSjI9k3K0SrWJ5jCvr6jzmAywld8WGKMz66dVEaFbvQB02PPzUU
	VHwJiQHS3MFtWaT0y8ntWXM2i2QT6hJafMZz33owGHNtsUppkUKZUwx2serDqcOgf75nIDld4y9
	AYxwlLvzLAE6NqDK8tTfrrGA6rqp4g4RxJGbsX//Dxg==
X-Google-Smtp-Source: AGHT+IEkxVuvzarp/05AlrmO88wiQ2u5cuKTrx2x6qjWyE58uQQHAUI51bWekueB+rniwhuLeLNaqg==
X-Received: by 2002:a17:902:e944:b0:24c:c013:5098 with SMTP id d9443c01a7336-251751e83e0mr17043815ad.8.1757150270830;
        Sat, 06 Sep 2025 02:17:50 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c44:6dc9:9ee4:9664:de3c:82ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cc55c4616sm63727555ad.137.2025.09.06.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 02:17:50 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 06 Sep 2025 14:47:45 +0530
Subject: [PATCH] docs: dt: submitting-patches: Fix typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-doc-typo-fix-v1-1-74a427d3386f@gmail.com>
X-B4-Tracking: v=1; b=H4sIADn8u2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMz3ZT8ZN2SyoJ83bTMCt00E2MDCyMTEyPztCQloJaColSgMNi46Nj
 aWgDy+G0vXgAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757150268; l=1337;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=KngI5sX69UHl6zztwuTODeaqfXt/Wi1K6usTJRVh3Qw=;
 b=BubnzhP6ISTpTyPF+8TTu0b2Ou63lIsMqmD0yIC1l+/0Ve5Y5LpLd4ZRbWz6rUcO8XAd8+bfF
 X+kcMnQdw3PDNY+sgdj4/jkAplTZs4xKQdB/QEjSZ7jGyyr98RVVsLa
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

Fix trivial typo "serie" to "series".

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
Fix trivial typo "serie" to "series" in submitting-patches.rst.
---
 Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index f3e23e69a638..97ae4f92d3dd 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -58,7 +58,7 @@ I. For patch submitters
      any DTS patches, regardless whether using existing or new bindings, should
      be placed at the end of patchset to indicate no dependency of drivers on
      the DTS.  DTS will be anyway applied through separate tree or branch, so
-     different order would indicate the serie is non-bisectable.
+     different order would indicate the series is non-bisectable.
 
      If a driver subsystem maintainer prefers to apply entire set, instead of
      their relevant portion of patchset, please split the DTS patches into

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250906-doc-typo-fix-f430824427fb

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


