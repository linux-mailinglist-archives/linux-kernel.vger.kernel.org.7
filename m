Return-Path: <linux-kernel+bounces-757761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66A9B1C652
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F4018C32C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5AC28C845;
	Wed,  6 Aug 2025 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9Ul48Y9"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D228C2DB;
	Wed,  6 Aug 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484508; cv=none; b=ar9AsQl37tBz6oW7CeMXKvdfbDza5H02wHkutx+BW9b6NKYtZoqUx2bpIh08iPUgUHcDaxZAKu6ETBREbctkqw1hxNaiA2mSo1w/A0JYk5wit2PuGMKOGAGgnUhNgyXxNK947aHzaBReHFZXLDM9MIvs68vhkqaRHONVN6q1DJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484508; c=relaxed/simple;
	bh=WqMwp9qSIcAJgErbpmLbXWzuEoVOvyeCqKyTVE9IAKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGEtJRZXyvUSoqRZocfYB8bxdx6UFLQ8b8nijQtIFQkLJSjS5BRYYe5Q3upZuyRwtAPTplG+ds+LaX+YfYpapeT9LojuWJ55SF/Nh/bl5hEi7pNde9cz23xH3IaKBm3wMhMh8/2JX9jcKXJo3YjbloIMs1/Ot0ZcI5DbsSRJzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9Ul48Y9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so34950655e9.1;
        Wed, 06 Aug 2025 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754484505; x=1755089305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6ZoVWUi0mbYvISDXeGEuG7qHw/hvGQuxorTcLyCsEQ=;
        b=b9Ul48Y9jH3QLVILvDueOb0qmZTAQEwwp/cr8IuPBGZRGspAPvs1W7EZbTdEYnatP9
         5LknFP1MRHBSGjfawJWepkXexMqmaBW5FYcVBtkjk+LDkTjjQSl+As0hW+0jV7kekVUt
         sfFR+o1I01ZUY0okVC35pduCwTJaT9r1Cv7pL8xz0rI2yBbvh0FYyKJA2UhChMfW/ZtE
         V9qMhZsfYwBXA4wh5rbVETam5wXwFrysjIYUjzWlyoHufSddg9YV/jdkhuKoOu9R6E3q
         ecCwktd0whtfhGrsmuvXjE0kX3VVGD0klpdskwDhTxHjiONBZvRkqSFQG8yj6sxu+tYE
         SoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484505; x=1755089305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6ZoVWUi0mbYvISDXeGEuG7qHw/hvGQuxorTcLyCsEQ=;
        b=qKR0bz1EGhi4caJR5kPtTNoAVbLKRkUZ9v9g2zWSpOTTAw4KEtdnw9mcvV6VutCB5G
         x1se7pPmmgS9wKX8CxHU/nZJXcBcdlfTMEZjMcII0L/HE4s5Tzhpx28jlb8ild88ZNCw
         N2eVA03yOd+9jok4KKxEaQO5u6ki9Z+5qWMiCgEXzgRohJlU5DP2gUw/JYNA3lnC/IPT
         6u9o9+ykD/AaUj0W6XL3SkXFilm5jk6fNn05plRebF7EdXQmgzVuX5YCrTLUx6Hl4JKj
         k6rBiikKsoxDinJVLcYZTIkjFKvoL3K4yyJBDaRh2g/EgFpE3DgvCEfXUloHk/J8CQVp
         SsfA==
X-Forwarded-Encrypted: i=1; AJvYcCUsuXfTV6IzC+sJeQuCr2fJoTNrGe8HBYc4bEb//4o9mBe269DRE1HQgxnwtT2UKe1aIYQDGuLYBFnm@vger.kernel.org
X-Gm-Message-State: AOJu0YznPCxDRwQl0DZjs8KOgmlH+0Z/O0a21wiRFhOjjLa03gMRBgO8
	elxuSU3QXBPl+mvkXAvrYzwnA8W1VjxRm9DtCL733U+ykdbFvXdLx8SP
X-Gm-Gg: ASbGncuTtNKPea7fwmoOeibIjsKYhEbfh6yFkv4OqTeD1AWKryBFB3dTaeQtPuNqzpc
	Pb6DEoUM/7/65HyOWxr0ivGnbKi0qVCTlybmkxG/wsmqwXRs/nYaiOwsdV/Qi9Phk45EdDtJpBm
	7t94w5RxdKeNeTvbrrqL//cHgn9Q6RUma5OCNbfupOvjk2KW4JWVKMSlJNjlflCNMFEvhYb7HNR
	IURb9Za9GxycsR0RZfkTT0ac96ARcKYCUlxq2fe4oiHelAO4N/NDGyKyVrhxt/gqcHXbRFZ0a6z
	xx13vmNzioZPotiPmWJY/Z2hhohQLdMvj7UIXyzO5tB8hIS8f4NlA3sJnuWzz6uVFiaKeWdD4kx
	C04+tnlXD++/IKdcQu0BAUWILYnz6gF55eY0efAw1+GZgeFkX/a5lsgK9wDjFgdrX
X-Google-Smtp-Source: AGHT+IFF8zdXOoNmcjXgHZMPyq4WgiA452mu+C2vn8zmOBgjSQgzIx5YlyDMYhd821Zkj/obFIPOpg==
X-Received: by 2002:a05:6000:4029:b0:3b7:dd87:d741 with SMTP id ffacd0b85a97d-3b8f4927443mr2082165f8f.42.1754484504562;
        Wed, 06 Aug 2025 05:48:24 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([91.116.162.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458be70c5f7sm170110045e9.26.2025.08.06.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:48:24 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 06 Aug 2025 14:48:11 +0200
Subject: [PATCH 3/3] MAINTAINERS: Add entry for Sitronix ST7920 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-st7920-v1-3-64ab5a34f9a0@gmail.com>
References: <20250806-st7920-v1-0-64ab5a34f9a0@gmail.com>
In-Reply-To: <20250806-st7920-v1-0-64ab5a34f9a0@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ddf37f0acc960039422ef988cadfa7176972fc5..79b8a277e38b55ebcff05450d6c565c0d87c6b51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7861,6 +7861,13 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
 F:	drivers/gpu/drm/sitronix/st7735r.c
 
+DRM DRIVER FOR SITRONIX ST7920 LCD DISPLAYS
+M:	Iker Pedrosa <ikerpedrosam@gmail.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/sitronix,st7920.yaml
+F:	drivers/gpu/drm/sitronix/st7920.c
+
 DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
 M:	Javier Martinez Canillas <javierm@redhat.com>
 S:	Maintained

-- 
2.50.1


