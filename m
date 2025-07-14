Return-Path: <linux-kernel+bounces-729582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D397CB038AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D2018922FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0156623B63E;
	Mon, 14 Jul 2025 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9zOkxiZ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFE237186;
	Mon, 14 Jul 2025 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480279; cv=none; b=hP1yQkNmavvwJ74Rc0b6VlYDdzBzO9YJmoYUze3N1qSOESkr1UuCpf0/H+0VQnSnSRxftQUQAotriMU7kGQkIKrKqk+Mu9KP/GVi9dw6qP/Sn1eUQTooZlt/FRV5gxfI9KeFOH+TvEr7xlr+XBcobu/45g5B/bLl+pVdddHiUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480279; c=relaxed/simple;
	bh=9qhFVbTDQlUnWoyhzXl4tt9pDTAcoj21SaN2FI/eQiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDkGGUrTaKQ2l5ZHEqMXfeaefvKNwHLl5/61O2fLmUyn2QTBYsuCkIZL/pOWztNSQ5uwp15b40rrsWDIxLjrrad1BJqXLlN4SNBBdE1hn13R+X2PeGqth6ZspCeBA+oOOYQEwE97V49TkSiI4oOPzbVMJJqFKAUt/DR+gGMpphQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9zOkxiZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553d52cb80dso3671549e87.1;
        Mon, 14 Jul 2025 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752480276; x=1753085076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6s29Ts1SkPQDQu7w5HZtIzuTKDuPYqCu0keY+TlHALs=;
        b=M9zOkxiZoAiBOzu9z+x3Sp8pZ3e37xG+p1I8zJ5SahtbTqV7qLOsefVAbUy5UWsJFQ
         tZ9h0LZRBqS4m8udvpjOIQDLhD5nVa2ZXa0Y6XRZlSlUTnVAAVYOhI9DKObhWu5MSgr0
         zSN+ovuZjdQ9rBXfBVsn+gh839Qufn5V8sFjJ2E5aWX902fan4wfP5LpiUz6wvaYbB2f
         crzGkflbAAugRLjOKU7D2Bq4RVA9mra4OTSSAS7nb59rI5n0Bx/7+C6FM0HKBOW8y9yN
         +HYZzeJqyLHDYOuo/c8bWdtT4jSkjC4tdm5oi7wxSUYR4p5GIykZumeVZThBetoCohgU
         piTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752480276; x=1753085076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s29Ts1SkPQDQu7w5HZtIzuTKDuPYqCu0keY+TlHALs=;
        b=SgwTH0VR/AeV0L1CnFtwjs4BXXFzmJd0i7Y8sz9v4NeCtm/NVJy2H89uGY0FnutfbJ
         Pm9yCnq1EZdhp+58x8SAomR26CwNHxAfjDnmpzgvEMLoSq6kgnfR+LkUfKvj9wz05o8e
         OJS26Xqr9OOWJxccSZLtPO5X+7mUMjWiF1dOrDLdkmfu0gknV0N/rYNbLD2T9G8Nsdmd
         m1WavqwRWnU4jC/6878ka5x0YH+J3lwjknrcLnRX4a6QgQnoFIEs7Pku81HlnAE3210H
         WA6HM5NO0g4vTUpE0Ll7+yKymFPh8VPmx/UU04TZZVODPmsfYVQl45E7AXomZXDFyfIV
         izew==
X-Forwarded-Encrypted: i=1; AJvYcCVBnYbVIuvv7XTDMcgMoF89O2FbejxqpUYwGTElTI52ahWix/aTlVjMTBEohItLNYaW/zBdyvz3LzhO@vger.kernel.org, AJvYcCVnSt6HNbvRsRELbg7UXwYoUgp/D413ViOgaCBsZ65M+cASQdLgW6O9SRrUowX0ha9V95W+nKC3NXOwW9vy@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEuhbja0ecScOZsT8SFYrmkBWtvz66ZzyEPop+pI4IZ1mIzT9
	csh/gmZI7XtevzRfn1zHoGwZKuKLjTz7sNi8N11ZFwTwGCHhzalJMwbx
X-Gm-Gg: ASbGncu1C/O3dZPhguW2kwcbZHmtnEPkM6/ycfUQPu3o/VIsl2LdmR6yynk4i2ztsgg
	CxwOrZcdKCWpgVw+tuj9UxaB7unkzQ9OTG9tbYD8HM29BY6p/B+oJESd+/qI210gTcpjeCzp5c3
	ocEehukVHWimW0thvdWqODqeSz4L/4pBtwxceNEhMapJ0zlP0N28z/9Xlp4EdgLi2yoSYT2buN3
	9dPXpv+a6VOCxodz06kmIOzlQ0AwFHf7yIGw6DopA6UIJCoSyUzP0xU6liiGWb5EPijZHZS1DHm
	dSafzr/Gw/H7q6CqKmkgHy/iTGo0lMUql6dG08uhxbZGIoCh5lZ5ydYGrDOW37pEG1j59BY7pPu
	0fa4sSQkvKnYsr3NERN6O2cvjzTuXIoZ00WhMm0AA8QOjjQfrwFMfPr0KlhmB+oB2hEw=
X-Google-Smtp-Source: AGHT+IGpTrjfqaTHgLcCLsQCtZHA9El8Nls2neMHYylS+9ZWNLkW6HwS5nJKpzuK/j8dl7RkHFN0Hg==
X-Received: by 2002:a05:6512:e9e:b0:553:cf72:45d3 with SMTP id 2adb3069b0e04-55a038e3f24mr2907357e87.3.1752480275420;
        Mon, 14 Jul 2025 01:04:35 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6c08esm1864385e87.187.2025.07.14.01.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:04:34 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 14 Jul 2025 10:04:00 +0200
Subject: [PATCH 2/5] dt-bindings: display: sitronix,st7571: add optional
 inverted property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-st7571-format-v1-2-a27e5112baff@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
In-Reply-To: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=9qhFVbTDQlUnWoyhzXl4tt9pDTAcoj21SaN2FI/eQiY=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBodLn7NMEAsj6msiz2IRTvAEkdMP27Gj8qLURkl
 ACWp3Vk2VSJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaHS5+wAKCRCIgE5vWV1S
 MmZ+EACMoSu6V685oHN6Scy6hlmCAkFKaSHbE/4zNrMLDOe0PNepbZKaR20D7gEV2p7fMX270Oi
 PXA+Zj6UEVasO4VzQbJv/eAVjEnM25LD9AsFViFfvP9h37HdKNFF2g8JcCY73HMfCMCMh559/hz
 9sZ3IqB8ulTbg+zci0zcUUJIiFKwVD/e0CII7AfO5ovNafX2GuzomyDnDBaj0Zt8FAAhwAF04wB
 wiEcoHTjS5/WTDnYcEyH8VhrVGvFJWTE/HWiB7ZhYOIfwXT2ky4jpS+W1a7CeO4R1LLwsq0Flux
 qfpivCs+PfsFZhe/KlMZ88/T5Mqz9Y3pc4o2R0buPVXKFDpLQKYMoei8zswKnjUgQ/GsKX1RTVC
 UJh9G5VYW8+8LfUMmANwx5eGWaBkf95qlLcuAgo89fUt6JrvqoGi9pT6M1okrEe803/he27Ertl
 V0JaZssLndLQgMYP5ZdCyP2jbZJsNhIJsL4fQjH0CmlrX7Y7xVqnodGKoGy58Ezva4jLOC/UFZH
 F1Lvy/lnnkIyD0PRQVMWi2iWuRjQmaDOUR1Gi+xAkvdnRQHzv6QfzUxLX5MgY/c97nX012qAwer
 d7WQkgmbbkZQr81mx1cjXLZ/ldBWjQXafEll6jztX9eVhmXhoRIAtf+iaOLFOllqQYRVprrQVn1
 7m0IdCAgyAm6dJg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Depending on which display that is connected to the controller, an "1"
means either a black or a white pixel.

The supported formats (R1/R2/XRGB8888) expects the pixels
to map against (4bit):
00 => Black
01 => Dark Gray
10 => Light Gray
11 => White

If this is not what the display map against, the controller has support
to invert these values.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/devicetree/bindings/display/sitronix,st7571.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7571.yaml b/Documentation/devicetree/bindings/display/sitronix,st7571.yaml
index 4fea782fccd701f5095a08290c13722a12a58b52..065d61b718dc92e04419056b1e2d73fd0b2cb345 100644
--- a/Documentation/devicetree/bindings/display/sitronix,st7571.yaml
+++ b/Documentation/devicetree/bindings/display/sitronix,st7571.yaml
@@ -28,6 +28,11 @@ properties:
     description:
       Display supports 4-level grayscale.
 
+  sitronix,inverted:
+    type: boolean
+    description: |
+      Display pixels are inverted, i.e. 0 is white and 1 is black.
+
   reset-gpios: true
   width-mm: true
   height-mm: true

-- 
2.49.0


