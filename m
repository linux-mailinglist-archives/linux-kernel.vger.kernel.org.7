Return-Path: <linux-kernel+bounces-815060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE5B55EDC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B6818972AB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF912E6CCC;
	Sat, 13 Sep 2025 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj9J6WDO"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1E40855
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743801; cv=none; b=uu/Tr70CECBX66nbMlVlsI7aolHnvBhmnZ/rqb41l9UYdI/UiERYBPrLqXMyOynhIjbJd7FpLZyR+gutAczX22Z/IjGRWL0kv1kz1HxXHzcc7UEYJ6BX7+/HTjFaMxKqvPmcHl6ySdjMJZ2IDMivp5ifDIum89XVb4tASHcfxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743801; c=relaxed/simple;
	bh=gTOEkj4ZvjJRwjmvXK70zhZ6+r0iqgJJfzfUuKz4ewI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C08iL0IHoeGrPRvGyj77mkYloidArVm+7UZQ12rI48L+PAiQ1x3PBJptHpEZr72qXmnMNYgAznqw7sje4Gp3SLWJU3fXl3gbPe2sSPBEEE9V0FGzh2+I+tReWEYO3M6d/y683GjydXyaobento034iOawKbCPZxuwiKb2SM3SpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj9J6WDO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f6f434c96so2879605e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757743798; x=1758348598; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eilgNmLM+UnUigD1ts/5zlgpCEeCLq2Z2wcl87G6xGI=;
        b=mj9J6WDO/1Nji/YPX98vPU5Xv/RjDvWrPRoQR6YgoKBurHXWj18VP2ki01g+TZ5mab
         iaUzKjRPieu9wsrchiCQ/0W44MlAjRMoSMw78gggMV8sKyXy1fG7Dj4gZuZA50frH44U
         SSGw3YI8ivCCXUKNPHOPDCB5BSzNUdUYtKzE5OIPxcRbLgs8/B8OLnzUrl2AMHjBErO7
         FNy7WGGIOYaKB1717HMgD/AWpHkvc0N/RCeZaOBniDHsMkZITjMT5uUD0mniQHWD1AZ2
         ZWpcAYeBPwewEUYoSRAn34Ln0oRtsAemhChCEK35GDvAaSmgFIAJFtsJnhWrtNXPe5JT
         pm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757743798; x=1758348598;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eilgNmLM+UnUigD1ts/5zlgpCEeCLq2Z2wcl87G6xGI=;
        b=EgKaqbEt0CCcgUKhCgWDT8pA/MIPyksWOHp45ZRl5LPX/4JcVj956Rf1AFt0BWTPfg
         GtGSviyejeYUoJmuZ6bMNJJ3hYIgV4zZZnuybi9PKO/Qbuv1T4s3zNjlCm1cDzJ7bEJy
         yuNUvuYHY/n26ArONMZgr54FqcSWcVuIVztXHbAC9IBeBp4GY+jLNQBUDuYU424KgERB
         yzIfOGWExUHmzSGAT3ktRxe1GoDOApY+jlqOiH8xTUl8csQ2FL2r8co1buzAnqVrd3Ux
         V8lGZqW/LjLtKdzv3wsDRu98Bb0k0KxDUrdDjqPm82ZX1uEZXufRv4rL0gYDlds/pClc
         7z+w==
X-Forwarded-Encrypted: i=1; AJvYcCXFjz9kv4WgKaUlKR7oxoZqqNs+1nSsd4lTe/qlXaGNtoC47XZIIhWXfSfR76t5xm9ntLAknCMkaJkXNso=@vger.kernel.org
X-Gm-Message-State: AOJu0YywroiCZGgegfLcvV3QAkV4RoKxMyVMi+Hm+xynxcSVRMmyuMy2
	h/OW5UPZAnVqUTFyo/wuHib+xKdYiTNzSmQfqdgrnMAlQPBTTE8QQtOvuW2mP9/j
X-Gm-Gg: ASbGncv4auXV4qPbvyq3YM/1nEoKcYjxXiz4RtIp3MY1tbLoTvZhJh0siiSqMuGc+Ez
	NbJBPzh5fAzbN9xNMSdUTSK60F1zAjKg8aE/ChE3+1rHWqy9zn8KVmR4+JmAXkDgzZbVLnPVTMi
	dlHqxQ6yUaCeLew+7v9KMfyL3HuuiAJu9e9lG7Jp80a7eGRb/z1WHxEIBxTTNFXBRf2N3045NA/
	wk2SlMv+o9xkvatHFXZohQtwiCX7JKg2+awFdreas1qCT799QdVidXy53LyAsNVmwet74W73mCQ
	fw/YJbZQ25WYsLz/L75I96B83yzUQQmNNu/+Gtt2lxGyA9wGz97fw/+VNU3xQ4SELJEQZmSl6cU
	lTbp4V4sD2t79U/DXjfZF+lkp+nTGhhPhyXqMVp/9CZxTL8ljcDS2M/HKUUbOvILrgBA=
X-Google-Smtp-Source: AGHT+IGmwZmsbVKZyzEV62EILsLHTLklQ4e5+PHt8mSyNhEWHnxkOXo8eDX3vJX/WmXUbz0ahwUfaw==
X-Received: by 2002:ac2:4e12:0:b0:55f:4839:d059 with SMTP id 2adb3069b0e04-5704b52f28fmr1387061e87.13.1757743797629;
        Fri, 12 Sep 2025 23:09:57 -0700 (PDT)
Received: from [192.168.1.166] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e64fa7134sm1699740e87.122.2025.09.12.23.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:09:55 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 13 Sep 2025 08:09:40 +0200
Subject: [PATCH] drm/sitronix/st7571-i2c: reset position before clearing
 display
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-st7571-reset-v1-1-ae5f58acdf8d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKMKxWgC/x3MMQqAMAxA0atIZgtNNbR6FXEQjZqlSiMiFO9uc
 XzD/xmUk7BCX2VIfIvKEQuwrmDep7ixkaUYnHVkO0SjlyePJrHyZXyg0AQXqEWCkpyJV3n+3TC
 +7wdYQRDMXgAAAA==
X-Change-ID: 20250911-st7571-reset-785838285415
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=gTOEkj4ZvjJRwjmvXK70zhZ6+r0iqgJJfzfUuKz4ewI=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBoxQqrq2QBZ5XmdEg1YGZgvM51PpAyHQA1cma49
 Pxth4Z6rlOJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaMUKqwAKCRCIgE5vWV1S
 MlHYD/4pbEnIrJLmXXp6nL/tqtzdNleFjnCyFXglVYfrviZpWfQcRHITojRjKvxWzP2IhDC4Y+P
 NrHgwauETMdNdnDxjGEpRUTqjujqCErHENLyl/hWAmpg1tx4P2HvVZcS5UpcSNqAH1ZnC/2fJOu
 R309eTTC7cs0LbDAuYtu/0Y3t+jtuncOIS1uE9KYjLt3EL0A99zbNuO6EnHYUM02Ded9Wr7ESHJ
 1JAkWNVPHJfKOnHM0elGpcw/WkIRwotKNEJ1xua1RLpmikMNoaewSAMdQlTnS/n72RYujG3u8Xu
 AkeDC3J1s4JMLwmQZPg03zAnCi8ZYLpzspaGuqgx36Vlf29SKkKrGDg6vLBMWryKOwcirl155nI
 WB8NxD/VsqpeZATgf+OsybyVCyo736tm+bDvmc3ZRX6mH0mhb/p8aVVKXfiSvmdoPPTXGvMJkSI
 BMQwPw2vKvV/UubmUGF0tdaSmMuxDXRpJplymv22U65E8kX+sW4cOt4frj0I7Fdm6I4Kh3cAnK2
 Gh10oc/rW9BWmIHV9vN/gODDIJUzmkfO8156H2qiN6pgr4cApu0HiaTVCeNruFsmJxBQZYF5LoB
 745SP3hFHr0c0ackuVP6pJm7dhJpTH7i1E5UUnwqztkPAUNVST7csZwSasC5Vk5M7P2I0G8de6g
 71uA8W1/HEA+rpQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

We cannot know where the write pointer is, always reset position to
(0,0) before clearing display.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index a6c4a6738dedf5881328414e9d8810d3af2a6fe4..32b91d65b768b26caa7dcef42a00d36f236fbc32 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -263,6 +263,7 @@ static int st7571_fb_clear_screen(struct st7571_device *st7571)
 	u32 npixels = st7571->ncols * round_up(st7571->nlines, ST7571_PAGE_HEIGHT) * st7571->bpp;
 	char pixelvalue = 0x00;
 
+	st7571_set_position(st7571, 0, 0);
 	for (int i = 0; i < npixels; i++)
 		regmap_bulk_write(st7571->regmap, ST7571_DATA_MODE, &pixelvalue, 1);
 

---
base-commit: 91494dee1091a14d91da6bcb39e12a907765c793
change-id: 20250911-st7571-reset-785838285415

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


