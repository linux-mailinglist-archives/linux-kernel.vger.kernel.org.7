Return-Path: <linux-kernel+bounces-729831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97A9B03C26
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21EE3BEEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4887247283;
	Mon, 14 Jul 2025 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KV/WzHgl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB223BCFA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489889; cv=none; b=a7/qwlSgBJlm7GxlRiBvZ25jPxfOoNYlpkU+bIUX+62y6f1qEOIVxNfWuvS2xXjkjO5LPZvYXu1dIxHcRoqbue+eCKZfG7zKXiDV7SlicJFIaDHLiTP9A4bd0IZR1hG4nNKII+kekzsHrs4W4pk3PCbzmkLu+Aykz3ryxIlR8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489889; c=relaxed/simple;
	bh=nC6iSVG2Uu5Y97rCmVPPdK8QJYizHSKOadqIan5utxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQuO9KkjDKxWWXVukw3oyAWxceVKGl0asX+dzXIcsWfxwVr8P+Iszod+Z8vwQB6o9zPFPj5w+D2dg2fvf0wADJnZ7ySX8cT5AZSDlLfHTaPcnTCjjWmBsasAgzGHCoICuHVVwo0zHJ8hu9WcX2QWOlSEPhlHJ3S72SeJpyFly74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KV/WzHgl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752489886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+dRbh0w0ssR7z7SffOey6CZ9oYNydtq8EHITGU1RKY=;
	b=KV/WzHglCnJDMhLvfMdPc00engTWYIKbAe8vMOWOYMeq8WLFXVpi2/WQcNIg2QQIHYeG4l
	Alm2w1exhs2MHazwS0mRyO4EszKYtpx8oCcO6hU7FUUFglOBleBOdWySZOgO9huKIEeolT
	fGWHxHwLBKa0kDOUCvZckb/IErf6Tpw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-8lAtqKbuNeqVtlFAr_i7Xg-1; Mon, 14 Jul 2025 06:44:45 -0400
X-MC-Unique: 8lAtqKbuNeqVtlFAr_i7Xg-1
X-Mimecast-MFC-AGG-ID: 8lAtqKbuNeqVtlFAr_i7Xg_1752489884
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455f7b86aeeso12184005e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489884; x=1753094684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+dRbh0w0ssR7z7SffOey6CZ9oYNydtq8EHITGU1RKY=;
        b=K7GaRqvwzzpUZmdNv+t9HmLImpGol09qLseEfhFcJweLgxr4//5KXceKb/XFUqC5xD
         8wFawC4xPajf9/LZ3PXhcCzw+fwwn1+KaRJ9FUDEtr6Jw/UUVqJc5v2PM4/4HdCr9A7Q
         jQnLH2rDbbP5g0KzqiPjb9qp2HkvffTUK2zXlyGVdA9W7ddAcXXkvlQe6zxcRgEbH6ox
         0Vqe0ylmfF2fdQ1C3q0l5aaMAL3yB3hYeLzPshfq3+W2SyAo9H2gjBhpGlhjuLB4aEsX
         CsxWp7M8rahnpzm0Am6gmTNDO8OGH6XOSA1YcVvgOaWddm3JvU9VgK2hsXdCq5K8+e7P
         HDdA==
X-Gm-Message-State: AOJu0Ywo+3mZsRbW6f7lr/QB6ObEhuyRGc9cLEagGYWIQ5Th5ZRyX/r0
	6VpviBzMIid3B3Dypt48do6s5OX4dcLWKiL2Ev6q4xwzFhNqM8sjDf9IYVNB9TNqU4sMYZZW4D6
	6pc5Fwk0+OGzxj1du8a3yIbZYdhZQalEvQVm7ykgBA+aieVwKW4yclGa8YmFGwiYlcNCFP3UItm
	ExMCpmoWRQyMlG/Lqv4l+qCcnEdGEW5PlYKjAyW7UgiJeXdK30
X-Gm-Gg: ASbGncsPWv3DSySTWYRBhekaRbCC3z66TftZfChOpmYOzcwF4O/LeKvuXwpteQ4wfD9
	4+SXw6xoJUNMnYKaP2ySRXB6dGEv7HYQy+i6G99NJNPHGmjM+C2M3O0bEYcLaKEMEO+P3UUGwcQ
	60SiKJ8C7WGOupDnL6OCcirRwXuWr0xQrBpCz5CM5wRPCcDU3DNMuoMovSHyRjoqyKj8+u1mmVm
	PC7X+xqCRXR7S2B7WYNf5sK4hBFG4NAx+zXCRWVTjo5WTMMAb4S+zBVt8QwiMni1j6ETCtOW8N1
	JsnJcyIrQMmS+v3rypjV/44HIkv7ikc3
X-Received: by 2002:a05:600c:3155:b0:454:ab87:a0a0 with SMTP id 5b1f17b1804b1-454f4257f20mr127692555e9.17.1752489883572;
        Mon, 14 Jul 2025 03:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv7Rff2pEBanvuCvIAGuf8+StdSH/j+ARZxyQfPyHplKgidfrfHXUUtXua8aJ+zq7YriSdEg==
X-Received: by 2002:a05:600c:3155:b0:454:ab87:a0a0 with SMTP id 5b1f17b1804b1-454f4257f20mr127692145e9.17.1752489883089;
        Mon, 14 Jul 2025 03:44:43 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560d019f1esm64813235e9.10.2025.07.14.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:44:42 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/5] drm/sitronix/st7571-i2c: Add an indirection level to parse DT
Date: Mon, 14 Jul 2025 12:44:02 +0200
Message-ID: <20250714104421.323753-4-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714104421.323753-1-javierm@redhat.com>
References: <20250714104421.323753-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other Sitronix display controllers might need a different parsing DT
logic, so lets add a .parse_dt callback to struct st7571_panel_data.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/sitronix/st7571-i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index fd9d6c701cc4..f9c4fedb3cca 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -92,6 +92,7 @@ struct st7571_panel_constraints {
 
 struct st7571_panel_data {
 	int (*init)(struct st7571_device *st7571);
+	int (*parse_dt)(struct st7571_device *st7571);
 	struct st7571_panel_constraints constraints;
 };
 
@@ -881,7 +882,7 @@ static int st7571_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, st7571);
 	st7571->pdata = device_get_match_data(&client->dev);
 
-	ret = st7571_parse_dt(st7571);
+	ret = st7571->pdata->parse_dt(st7571);
 	if (ret)
 		return ret;
 
@@ -964,6 +965,7 @@ static void st7571_remove(struct i2c_client *client)
 
 struct st7571_panel_data st7571_config = {
 	.init = st7571_lcd_init,
+	.parse_dt = st7571_parse_dt,
 	.constraints = {
 		.min_nlines = 1,
 		.max_nlines = 128,
-- 
2.49.0


