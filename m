Return-Path: <linux-kernel+bounces-826190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D21FB8DCB7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1071717D457
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019592D7DCA;
	Sun, 21 Sep 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl+8CUK1"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AF2D1F4E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758463041; cv=none; b=TGqFcYyaQ70/tXL5TUWiXqqlk4O2VRrZGJPnWWKyhe5gXwIhub5PnIi7mah2lQGfd7T4/zw0O91/Cof3FqpmT/5MplRzQQbLZ4RekXIokw5kwgfjT1pzVXqtPVLfyGfTHC/CwtaLr0RaBIAMJoTLIviKo3pggnXkkleAEkbZe4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758463041; c=relaxed/simple;
	bh=fHlIY9+uhSJm0tDafJHi34eihV/XQEMibtOTvhxc7No=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DnZKbts0VSKJI+GjCxSwzDC2r8i0hP6s9b1yGlmWTPjL4d/wOaklYso+Juv6BIXGwDsalxKz34tr/KqVHEpgIUq+WdiTowNBxvdCQnoFATc0pQVM6EMXWM7XRNAlfGlu/Z8b6nfL9aSjbI+lCOmxTNml2AGtTinNo0F4VYq4dng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl+8CUK1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5524c0ed94so1343610a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758463039; x=1759067839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwKtMMVVH553vWqd1jOUT4NC0ABE2UrFAfCYIBs6Ut0=;
        b=nl+8CUK1Q/W8QCa9kKIneYcG7oMgpKPCZUAg2/zEbrIhBE3WTB7O0UkYaw7GIlZLlu
         LrMvIadvWfGQZ2aGQkAVNW7GpTSzHJZfkUXHfbhvDGW81ixdX8N0W6453Bra5tfAlcAb
         yJKtmQ8StMtFwHaPKHp425x0IFFeljHtFq3hM/5siu2ZxTs3riDaOdw+UfIpGUfk1bIs
         ffyet5vEY8TqEGywUNPwzRMDinFu/wSkSkw4XFyWbgNT2m2aU6nenmS9pJ9aMCcU5X7L
         x4cnXNp/H3HKDGX7Cu+edqoYM9HTyeUQtf+yy3cDfBiTzphsuqhKvsHErbf3ZbepXTyf
         OlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758463039; x=1759067839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwKtMMVVH553vWqd1jOUT4NC0ABE2UrFAfCYIBs6Ut0=;
        b=ZdPbB1Cm7/AotpWPq8/b7nGhWd/riCHJfIzZw6quVG2EhdJJ5X1p4Dr06bnamG5LYH
         Ka87FhQJtqUNLGjdKZA7MFC7HOswSPls2ZzDNdIp1krqXa/KMMRvd6pSiqK+SGAghrho
         a24nuPnMy+QXdqBkK4siJ92pchDEqZqCWgybmkx1pjuKUyCE0NpOZQHe+78V3qKqyspC
         jGk1UWOKl5U96tebtzA4cwVmDk3dqQ04KGkHKbLQy6WT6fcZHPwTtSRWKHTsspn57ZUV
         eCf4BfObk+xDBkLNUdKJlPFIh63CEb+NjJmBvuHKXlckiLX8d7yVIp37BfQaZoYyuuR0
         1tZg==
X-Forwarded-Encrypted: i=1; AJvYcCUtm17Ez++BS1k+AwXgpm1P5frHCmNHXA9m5RiwxrpRXMJMNu4rVOD7L4zkZ6VaSH1PE1ps+0G35dggpk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIn6h+QU3BYCFK0hF7B/HBZ5tPkwCvV5CAtlqrF8QDfX7R53e
	rA2jV6vVBjhCSvGe0GWI97VM6sN4u/PwQwZLR6DZVrVmOc1O/QuRjSyB
X-Gm-Gg: ASbGncsWyrm+dEcXIxz76+ZHgXG2Uy2a4sw7aK201FeNu7dia9j/iEJY/rCysMcMYXh
	mAD0CwsF67VCiIQGu8X1neC7KoGMAsl+dI/vB7lHOOQY8QQd+M0EoS+k56W9bf4ZD078CdbRcGX
	XvK5uWYV0A8uI3MFnu6rQmT5dD3781YExKNTJqx+cwgXh2DTBa8CiTU4qgKPM9PvQWB7E462x8z
	VfqS6INJgFX5mVYTJhxNbIe9lQXsCO3+w96iq5Fi60E7ghkutw94T0ioPM7KDr+FbEc9YkXSDYW
	gf7y3MwFtv/iGzLemj8ta+N0bAANzl23K9o7Hut610N7K6pJV9i0ovY+ug653y3csubbpwoklfI
	QwefbeFw+BWnMjLnczawH
X-Google-Smtp-Source: AGHT+IGDsKBY3ozuTuBIgDdeQzOEwOHka23t+GrkUMG+515i/Pq9duddouEA6yTXxYZi6jjJjuHSBw==
X-Received: by 2002:a17:903:4b04:b0:235:ed02:288b with SMTP id d9443c01a7336-269ba5167bemr111498925ad.30.1758463039263;
        Sun, 21 Sep 2025 06:57:19 -0700 (PDT)
Received: from archlinux ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df74asm106105725ad.94.2025.09.21.06.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:57:18 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8250-samsung-common: correct reserved pins
Date: Sun, 21 Sep 2025 13:56:23 +0000
Message-ID: <20250921135623.273662-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The S20 series has additional reserved pins for the fingerprint sensor,
GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
index 96662bf9e527..1680be67e733 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
@@ -159,7 +159,8 @@ &pon_resin {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <40 4>; /* I2C (Unused) */
+	gpio-reserved-ranges = <20 4>, /* SPI (Fingerprint scanner) */
+						   <40 4>; /* I2C (Unused) */
 };
 
 &usb_1 {
-- 
2.51.0


