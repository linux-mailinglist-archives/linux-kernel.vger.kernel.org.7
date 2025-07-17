Return-Path: <linux-kernel+bounces-735867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27CCB094BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BF65871E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9482FE368;
	Thu, 17 Jul 2025 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2MZoIvq"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455E215075;
	Thu, 17 Jul 2025 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779806; cv=none; b=D/jGRIrGaTFVH4Th/lOPR7dJQYkUWYChx1G3x7FgsUGOgYekukveaBhJgNZ/yvNb/+tr6PA+WBCBhgcmolJH4Bx5saz+QqTs0EHH0vJeYCLtIl+Bk0FxpGwCkI0LtIRYFhwMLtJJCfAhMmBrgQoEt22ASfdZni/bdDi/XCtMV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779806; c=relaxed/simple;
	bh=PyB/CZMxUn55sPN3ZHQgk/pnsj+LAy/0OIGcsrAdeRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RSuZUQ4cL1gI4bklhzPHyWoEp0h64HKjocnwg5SFP/ZyLN9Q0DbIqBoAoDWYIEks2SA8VqKubFiiLCDsYMAKrS/4qIbX7G4OJm8T3QaWITqgJ0Lc+YlIAv/nNkxkKrPcOUdbrQn9QWVbdeIRzAKXXBBu9PsVdtqIXJYGmvxW5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2MZoIvq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so11205755e9.0;
        Thu, 17 Jul 2025 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752779803; x=1753384603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXS6IlzCXXiWTFVQaBT3Lr0CwTpzt5HQ3tRbwjKwIVc=;
        b=e2MZoIvqDzs86zd+eGp179zRNFkANi/lycYHolLL2/xJr+5wTEkfKc4oQwjB3yZeNj
         EI1MVma8XAe9r35pQNSPnNs53os8jvfcJbGKkP/uxxWCXwGEQZkJHT5WP4v3Pn+qZcZJ
         f8J0GMrVFKMwsMjGYQRNwfP22KsB2wARQZT6dRuvhc4dVG7JcAHtN+QzPn+yWIEkWLfn
         RJsFmmaWqFyUs+W3N6pJc11wc56bzbbgHYH0xK5dLWD1LDg4d5vrDVKxgjghAEl4MzrW
         PXmZgWm0jT5LtiO+szulXy+2FMLWbotrXGZUD3GVNN1mT6WHg2ovIRFO3F6R3VzcVaJh
         4OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779803; x=1753384603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXS6IlzCXXiWTFVQaBT3Lr0CwTpzt5HQ3tRbwjKwIVc=;
        b=E30vsssPS+n/zjQraXYOf7TX81ixTPjzLd5spA2OuRKUT88qKgryc1igiR6f706bkS
         aI3XEDFFAmxFKHU1pbwCTqSv4PRd4v8uoUkWrUBemkQtBhEDanHx6TfxlqpUap5S0r8L
         8treOvS6eDlg1rpdEZ9S1CrJKzGl7uxtmfkD8D8ie+CsyUHzG8LbTG2AWg9vnoBMpr4k
         sjQKhCCNmBOzswoDEP53543jy+nOUfTqZZloxsX2Q8zeqhalz8oENzzZxaBkQi+Uh58X
         IdxlHPxcnE+4pV6Av7bguAnAVIKrF5khu1mygb1fITXTajjMPHqkKlRGOtV2RzRDpPj2
         c0vA==
X-Forwarded-Encrypted: i=1; AJvYcCUSyGvOFvZmeIE1nlCnyOZKk695xZLYr099vniA6rCOdn3q5S47uDqvyy9S09kQESIaAH9zgZiQ1O6rV/Bb@vger.kernel.org, AJvYcCV/dfaflyIT6+JB/rZXugnbqfL4yMKujBfYzxdc4xS0Mg0pgAxRX7Cgo2SmrWG1+Z+J/72gTkjoj5lD@vger.kernel.org
X-Gm-Message-State: AOJu0YxZA8x0TYOZoHx8ntu0iqJ/2zdWnrDKp3yGVhcDckJeZp+fM4V7
	EuTz7GuDs1eCYjCu9tcwElrYOVggz0p4v/fgig7UAeLupNGG2u67L99y
X-Gm-Gg: ASbGncsANDXGMMlh0POlNC2UZgP1G1DR/GU9oDJMdP2ijNzJfOLD7RmgFne72Ly2ILg
	MdeJ8Xy5fMaKpy4ChirmWC9GctR89JGwa381ZdXt20vzSoLgOOZA+qD8ymV0qh0hmImxYWWUdd0
	8TlsDlFrW4vMfGelMUhqjYlt7dmKDHSfmjBCt+psTYpw1qToxAoRMh/2Zb/5D0psOXwRJA5y+k1
	Wwncgq9qU7XKZbtGi5yIm6DcGLP4GKCn0UQ59KsiOf0jiNpdsyeO65VMWsE1mHArNSo6fpLw6Uw
	1yc55SgcwJbXFbNHunp+8cvfVc/mU2msgYmPgUrJAptI04eInTRlA9sj+a/ERYsr+NAudeBptC6
	pr9m3Ek1sbvSobowEifFIFQ==
X-Google-Smtp-Source: AGHT+IFdO+XRcbjzoMbTOgsB553gBGGYSvejU7mep2+ENo9zQ9I4WEUO9p1GUi72lBKstfRX+R/XeA==
X-Received: by 2002:a05:600c:3b9b:b0:456:f22:ca49 with SMTP id 5b1f17b1804b1-4563a498d0bmr9790875e9.0.1752779803165;
        Thu, 17 Jul 2025 12:16:43 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-456278ab486sm70291115e9.1.2025.07.17.12.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 12:16:42 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Thu, 17 Jul 2025 21:15:32 +0200
Subject: [PATCH 1/4] drm/sti: check dma_set_coherent_mask return value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-sti-rework-v1-1-46d516fb1ebb@gmail.com>
References: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
In-Reply-To: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=PyB/CZMxUn55sPN3ZHQgk/pnsj+LAy/0OIGcsrAdeRo=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoeUwYYCgacxXo0fm/BVR90qG/tODN+dH4bygpw
 oxe1gR/9UCJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHlMGAAKCRDnIYpo1BLC
 tdC4D/9PsDag3hJ3pQT2IHv5rLHgtffYGReR75toGfxoxm1xIDATWpwXpz7AMz28dIoe7TBdrIa
 9HaawGMVTwTcwbJAUXtJUK5ZJKfKaTEV4O7ytjQUcLKE583M3ZKtQb2vNe1Hv4ATzGfW6RB7LGZ
 T6dHZ1PC/1J5esXSpzBZ3l0pHjcrrcgfWov8h1qqQBXjH24xsrn3xlIxSE7sukbSyOHlVXXZGrw
 B73Oduzy9HRac0Hm30rsQ74ijETnbiHKxzTmAN7fBtI131mv24arM41DW73wOFGomii8pcARPPS
 /ucgzpxx+oREkpfs+PFc0JHGSjj1DoQcwl5Xvvg0+CaEt73jSRxReU7z5837VahsAWJ07n9CiQn
 /WzTU26kGplGZHF6VXQwZolwEHSdquw5c45amV9Sa7GoX24lFThAOwAxe+Upa7jadOUKCbuq9Dp
 ldRu9H+6AXybqAAeU8MTZx+T3qWnJvPOlvxWrjJt+BQNcFJj2Hd87bz0gGgMzCyqlgCDUFqc5zE
 /jvw5El2+HA5ui3BTLbAMFp4edudZpw4XrGtVLQBhiP1qtzTzrkBsZsDXYkuv+bfpeIOL7trQU1
 baadlcUS+IgxC4wNKOqw8fkdXP6H1g866ElvJYPcxKALSNovXCapIeIeRWxadbIdbquNk8ki9uz
 z04oBK8+NQOGNug==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Return value for DMA allocation was not checked.  Check it and return
error code in case of failing.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/gpu/drm/sti/sti_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index 5e9332df21df0db30f10b7a6f5a41cba85c4f7ae..42f21ab91957b38cb9aef012b6ee7f4ae1683edf 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -234,8 +234,11 @@ static int sti_platform_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	struct device_node *child_np;
 	struct component_match *match = NULL;
+	int ret;
 
-	dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
 
 	devm_of_platform_populate(dev);
 

-- 
2.50.1


