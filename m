Return-Path: <linux-kernel+bounces-729049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D75B0310A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 14:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55976189E2B2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484F279782;
	Sun, 13 Jul 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnNGdb3R"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700C277CAB
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752410813; cv=none; b=A5b5FGwWbzYhqL73qF8zXq+e/EUDfXaMmRLTuSS4UgcxMSmDAN9rIXs6XgYnJeXgR2+bfZmJ/FRf4Rc5PwOhY7CPhVG2i6Y0Oqm4JBOqwoXHhjvHGD4zx6SWR4skOF+GrqqidgGqNZXrK4jJ+MRBXbBsr/h1uWYRh0wUwkQRfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752410813; c=relaxed/simple;
	bh=8+8q0TMkDrtQtBtz0e5m92VGQkAbRgRxfKsnC+FyYTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqJRuvkIK7ljI+LVaXtLUzZ+Bac6Hfq3Pg+LRZkzyrEjs5+yE0k4+QecGJx8oC4ElAeht0pcQId/APEcKMkjnRKfkiA/M58q9KPm1cOH9lYbudDsHyIEKfebk53VAahamutdhNiI5mAtP5v3HDhc8fMUcXNZktN2ANSncrl4rKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LnNGdb3R; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso518461f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752410810; x=1753015610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1rMgC0VMbaAfL3THU5TCdqj9Xtp4wVUUntbOLnCVCk=;
        b=LnNGdb3RG5MwaNknbya/fs8+fIX+b8txUbTydpqwjeGBncgybthptrePhAxaX7dfDe
         LQqDbyZVoNiDPHPudwRY3LIBmlf7r8pGhcQ1QFHAKKmtI+aDiDX1PJCuLunkzM8QWvpD
         uPad40LF/N8BKpiRkxonc57nDSbtXinC27VMtsruCi1s3mHSeF0NIaJGOdPmEFHIttFM
         RNl8G59a60Q2L7v+4cEcqspCZAhMPzRHGiCAbYDQSDwtMCNCaLbXaonok3uV4fT80yZd
         HiNRnAmaxE/y6iH5jkedMYG7qLQ9afuzJUVhZ6JrSokHDdvkSh59fefW2qqprUdhvJhn
         3wOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752410810; x=1753015610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1rMgC0VMbaAfL3THU5TCdqj9Xtp4wVUUntbOLnCVCk=;
        b=UWO0QordZJadimZT/SEeja9u4AbbU2FQsDlAeVBiAVPtXKiC6Dy1AFK4hSyVh1eufu
         t+50reZpsSi+bv4AW93fHZY7gPsSdiaknPFwjRxn0n8KiIr3GIRhGUQ2arVVWG81aMq9
         PsRY9MjMR7H6gW2ty8SkUn6LKwIjNO24shG8v49FJTsqgVWcLbWuVxPj/QAi1MTXKGle
         nWzO5aB78e6hmNs0xFHrHb1DRuKvf5SbSEXD0RAeTcXw6DGDQODQVG/LKFGsasKsWcyy
         sRnOeYqlvn8yZiBJybQSq7QneTmcjVoGwBDrhjNkPybC4cDJIBZhO5+G0yz1mErJdwNA
         KpzA==
X-Forwarded-Encrypted: i=1; AJvYcCVW6qDHzsKWl52hCipmsv580bsyIaSMnPeR21x1grtBq0h67w6ZQnHad7ZvdVFw1qA9NlTSMtkltv/8Sis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy161SlRz/SIv+VhBsDTfsSz3Y/UNFXrQALOSNeImQ24GsJBlNM
	lxw5A7bMYEjlVVzYHwIuaOV1xCLYk/iFaw5lC4sXBZOyaFAPrtIoVgtGxVR7r18zO3E=
X-Gm-Gg: ASbGncvSVT+1sRHruMYFzlpktRu3CZhxRzDAY0hzWhAmd3MeL3aeYnkavpb5tMI/xOv
	bDUmqu8m3QmkZ7tZIGLEtSdIQwjllwVAHgOE9q2BupvlPa7K9C+g7GkPD9xyIOHMkku7lsECI2h
	kXctLX66wlnesPugEivCEayRXfFFtkTUwVVBi/PVpo5RgWQ94TkgZYlao8sDm5023lZHYnfEbg8
	8zd1GQGlt1QdFecm3z1jEy1ARYXCr+M5i5NdxVUFFWOv23+YswDyRMUTeslY2M03La1Bn8q8Faf
	ksn8BEb2E+US0I2V+U1RH6UWNLbDzfXW8t2dp930S/NvYQSWqk4zNV+gHpnX2wi6u3Dakg7S9J7
	YW2tEHDTtAGsB54myfJgXqrY3LrEuu+ImZNnT
X-Google-Smtp-Source: AGHT+IHaPHlWTSX+HVtAn7Xx/hnaszgxvaM9uH+nb4rYb4IjKeSKjda1vzmB9UQGeEweEBfQgVcBBA==
X-Received: by 2002:a5d:6e5e:0:b0:3a5:8934:4948 with SMTP id ffacd0b85a97d-3b5f18938eamr2656161f8f.12.1752410809915;
        Sun, 13 Jul 2025 05:46:49 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14d07sm9828835f8f.66.2025.07.13.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 05:46:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 13 Jul 2025 14:46:38 +0200
Subject: [PATCH v2 3/4] docs: dt: writing-bindings: Document discouraged
 instance IDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-dt-bindings-docs-v2-3-672c898054ae@linaro.org>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
In-Reply-To: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8+8q0TMkDrtQtBtz0e5m92VGQkAbRgRxfKsnC+FyYTI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc6qyCthLocNJQbIsZVbkfPwRi1FLjbJ+aith9
 8x1drxedr+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHOqsgAKCRDBN2bmhouD
 1wNqD/9ub0sicYrCmP3WZ1VimzPPYjPAiOvub7BaBmtUAN2PPN+BiF3aC3u8pfJTWHq1ZITJWNa
 /NXKDNjkBMGifuGveIenMGPNY/VD0m4MRoAw5wpN5CkYpG3MC5cLe4n5Z9D/HaU8Mwuu9LpDbfk
 dYKFIvmWSR/GdbrMKIRemSr6Olmk22zzRcMPYZkR7Oj0TMCpKNJapaM97bMVFzakq0hHEJPgPe4
 WjlMoVwERd+Nsw56j3e1UEwSRahjY0XKlrZO/P50J5Dee9z2DjXeXv1Q8F8z1mSUiZYspZcceWw
 q4FPtABI6y3CB1HOjONIrUmrX33ECC9uPivKzGCUTXshYIuRBgH9N2DVH4kbDUgJQqCvhg0NnRC
 t9Hx1HT7j57pmV3+tGbxFb0Roi0yqCvIXbhFVwNxY9cFFKjSeFm3gZeWDNAamTmRhsGlP8A0cty
 HX2+99ebJEVLyllb/Q1ImCXBzLp23cJU+4AfH+W7QlsvEeEqsyYN7hOP1iJLipOYt4XGQh1vQP+
 r7s2/9l41qxhP+IQcKbqFdnm+p0xvvuqiJrioZ4IH9fRVRRhdMCGJqXIDHgIUDgkIFdJAYpdFen
 +Ns7M6Knhzc3PGas1tLpNk/4gmXd4wIMbvXRyd4VORCSIt3tcGLemm5LTxhx9MIN+KW6WhDq5Wv
 WTynW0gB9h+7dZA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Document established Devicetree bindings maintainers review practice:
instance indexes, either as properties or as custom new OF alias, are
not accepted.  Recommended way is to use, depending on the
situation/hardware: different compatible, cell arguments or syscon
phandle arguments.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 Documentation/devicetree/bindings/writing-bindings.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/writing-bindings.rst b/Documentation/devicetree/bindings/writing-bindings.rst
index e63de88385b5bc5859d8d9fca82bcf30380f3e73..f8e0293a7c0621a343a493d448624bff916ba021 100644
--- a/Documentation/devicetree/bindings/writing-bindings.rst
+++ b/Documentation/devicetree/bindings/writing-bindings.rst
@@ -105,6 +105,11 @@ Typical cases and caveats
 - "syscon" is not a generic property. Use vendor and type, e.g.
   "vendor,power-manager-syscon".
 
+- Do not add instance index (IDs) properties or custom OF aliases.  If the
+  devices have different programming model, they might need different
+  compatibles.  If such devices use some other device in a different way, e.g.
+  they program the phy differently, use cell/phandle arguments.
+
 - Bindings files should be named like compatible: vendor,device.yaml. In case
   of multiple compatibles in the binding, use one of the fallbacks or a more
   generic name, yet still matching compatible style.

-- 
2.43.0


