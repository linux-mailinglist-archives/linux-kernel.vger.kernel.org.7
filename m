Return-Path: <linux-kernel+bounces-731701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4362BB05867
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A74A4F76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324452DCF52;
	Tue, 15 Jul 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtHt7Gj6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F452DC322
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577502; cv=none; b=bnPmSYsE2MGQrGn8+QhQy9sypAJGnRE/jYG+BaRWk7i5C+paLmDCy4+VFwFj1dJZAm9FAMJxbxdsXjlenNqg5mo5QIif/KF0ygUGTRCvFiaqSs135V8qnkbZuXn6Gi9bJGVXz69IJSbDOU56HdNNZtn+feAnKxIA2QAqbSXBCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577502; c=relaxed/simple;
	bh=LB6UAY93QcW6Zc2/G/xKm8r8te+hEdJX+mR6vMH3XAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfVobbYJWiFbjwiB32CY3cBVKP7WlxW6bGI/k5qF+5xcdLD7Gip96ViS073oVvh4jWzGRvrzM0n4zS6RtsMWSoL8OwQjSLxR91hzCq2rUoic+V4ZeNWZueu91qGUKIMTtM5kGTLMgF7uqaoMz8h30UwtVHqoTXB+stFCpeJ7Jv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtHt7Gj6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752577500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZ6F2xwZmJTchnY/FGJYtWyfDOS8jid6Za74XWNHMg4=;
	b=PtHt7Gj62/ZFCAYqMef+hiTaCrgco78ri2KqN1Oo0jsnqEn+SzYcvZGI3I2XRVj6h2d1Kd
	EUtKB/NqC2/b5mhNgBTKP+pwrCwtx/2EWfUnbs/AOs76MUX0BIaZ2c30dlUcF1ZuTJg7oL
	U05Hh10RCB0g4XcuK2dS/EaeKpO/VO0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-k9usgzRxP1ay15zFwulBLw-1; Tue, 15 Jul 2025 07:04:58 -0400
X-MC-Unique: k9usgzRxP1ay15zFwulBLw-1
X-Mimecast-MFC-AGG-ID: k9usgzRxP1ay15zFwulBLw_1752577498
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455eda09c57so27204415e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577497; x=1753182297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ6F2xwZmJTchnY/FGJYtWyfDOS8jid6Za74XWNHMg4=;
        b=vU3x3kfm3Z+e+ftti2SuuYp2ukSc9YDAe+TYHPue52FOMFEmQoGsQTIgUaqqOWVzcI
         gqiNl7+2fRRYEdJcfRRPlJG/GErx8dIxech1OdZdk5Fb9ufvXoANKfO9WLMC7lYsjS/f
         qgKWJ0hJxSkOGrB27wWrE/WOQop5ql57udA8nBGt1mNwLPRp7VmHboyko4CVGxqz9Cts
         iv44/w7yOHz+mIB/5JjpMf+R0gy0cXWi91NYsaTP/VlUejsOdQ4WSmvDFdJeNupKkE3P
         2FBVZ7BCU7+YOr88ATePBKg1AUgJxpJh+0WCbi9rLhf9fegdD+Ba8OyIx6Ube9U4Y+YB
         xpHg==
X-Gm-Message-State: AOJu0Yy/jp99KH3iuGEAMJcI0FCIqKeJ+Q7rCLZRvjtGLdKuq+/gp4Hp
	aYf/jjRmb88pnJfKJ5ppSYFy55dvx0Fhssi6HIsR/DNEj9Cuqa5u/EDUX/giPMTYkBTLpBLn6+E
	D5PYv0BkxIIdg3yyFjln/USY5YbLaZCmFHrJVamd8sVpi/ouESO3n0axvkYjneQEh5JPYox1UQn
	Do1HntXHfbTble8o6xc5sD92fKs88gm9rEGbYkwMRgwY9aSnx2
X-Gm-Gg: ASbGncstji36s1Vpob3Xz28C189Q0UdPwA65nyhwSOKbtL9nmkkM2UF20NKmx++q7bR
	8DqNpSkDMYfBWE+6ALHgk4qWRsxSKHyWvkngoRTHABa5YqiP4aYerIWJVAMkwILmv+yoOZO2dTi
	wmLXEf3I8vAZquytB56HS5+roNtdCl7oacct8WXkbpkmZNE5FEEjmbfmHmDW3y/nX+Brx+grT+q
	NSkDUroX7iPWVgC0gW4mlFOjOjzv/sDk/JDXBGsueSRdQcknZxfeTYzwVnYa+D49t/4sK3u838b
	+g+GHJ5cjNKbC9mspRQ/ZSoQTR0KzBWf
X-Received: by 2002:a05:600c:4f91:b0:453:62e9:125a with SMTP id 5b1f17b1804b1-454ec27dc91mr164885055e9.18.1752577496834;
        Tue, 15 Jul 2025 04:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy/03rj+uvyxo8odjmdiUaAYAi/Dr5jnAKGatQgTP0VjrCmZ8kxYj+ayZXaZnc3r+nddecYg==
X-Received: by 2002:a05:600c:4f91:b0:453:62e9:125a with SMTP id 5b1f17b1804b1-454ec27dc91mr164884735e9.18.1752577496390;
        Tue, 15 Jul 2025 04:04:56 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45613c2d84dsm75109595e9.5.2025.07.15.04.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:04:55 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/5] drm/sitronix/st7571-i2c: Add an indirection level to parse DT
Date: Tue, 15 Jul 2025 13:03:52 +0200
Message-ID: <20250715110411.448343-4-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715110411.448343-1-javierm@redhat.com>
References: <20250715110411.448343-1-javierm@redhat.com>
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
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
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


