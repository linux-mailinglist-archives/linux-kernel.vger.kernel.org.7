Return-Path: <linux-kernel+bounces-729830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155CB03C25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965C6189D1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6854A246BB9;
	Mon, 14 Jul 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZ2nXUow"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066B246781
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489886; cv=none; b=lTLCPXw7rU1l2C7pI6E4wVWMlju0ytFWUSduEfkla8H+fNunbeq4tUzYddOAExVWqM/Ktpf458gdVz728jrcLPtWohFuvYhUZPhXrqu6SxXeB5Mct04d2gLN7esKtbpDzWjZj5TTkShYrX9Ie6BXOVSpH3c+LRzI9gmFGkt2dWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489886; c=relaxed/simple;
	bh=gAYY9GhSyI8+jlIBzY3deK5w6OvU3C3Ju6zsK6OEtoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BF6Q4wZ1E/RnFQmCzcDGrfA/MkAI2tpAS9jTpAK6jloOk1U9kUscrjRrOwjoLPayQBaPPMHS9lYaA5IKPqS+NhSNtls9aLecRvA7uAj0HByCPYY46aQJi+ZR7mDAIeN0nkILBkUWeya/PcAt1tIYWN5+E0D563dlubhYvVsc860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZ2nXUow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752489884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2gdjIwVeQi8Hoq0lCLi65nVhLbR8gpg8luFAFpWgHM=;
	b=EZ2nXUowgSlGkhuW4xXsTValjd9BG5W6LyA4nf59/kTO+FUySUSBNIBtqPw8q5b5p2XmMP
	d0I2aJyGvVf3ALCPiRc8gJwa6FgDjxQSfzZvqBSRNCE/269lnr0h0Ejp6/bC3Gm8ptdPT4
	hsh1RkXwhdBJ6Kw1GYT5mAuqmBG+r6E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-mGrk9tXrOueiTXFqs_WJZg-1; Mon, 14 Jul 2025 06:44:43 -0400
X-MC-Unique: mGrk9tXrOueiTXFqs_WJZg-1
X-Mimecast-MFC-AGG-ID: mGrk9tXrOueiTXFqs_WJZg_1752489882
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso2017951f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489881; x=1753094681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2gdjIwVeQi8Hoq0lCLi65nVhLbR8gpg8luFAFpWgHM=;
        b=nyLR9sXS00TXnfrmanhZRMp5NbfFXqCVPG/7aQgGcMwXktKdpGgFnsSeG86iFd93qO
         NKEgG6q2no2tohq1Q2U457ExKhzz/THiEedZ+EkdVlPoH7fBGILWqAoWbTqjHtQ49h5Q
         evSM/ZXdc9lkxeuV8Nr/iNJrAd4MVhBrhF/59KXLNQX8GbboPQepsz7N+dQQ3ebMaW9s
         yuitQWXDAh/ZiWJIR0nJckiS2/9FUYD7t9UvZncDaWCxvfCngSG4EyU211Qc3uvHvLRj
         gm4ApHv8C6vi+aQLIYS5nMZKuahuqs8WScBRS/+mbbkX4nBUbTjaOq9oBkF+75d6bWcG
         Ym8w==
X-Gm-Message-State: AOJu0YzRd4/jIJ1l5RiUjVdOPtc5v+W3+whA84J8qJZpE/qXG1fxJ0Y5
	AJhaR80z+zcJpe4eLBnDfkgZ8buOinBzKcUCMWyrCXk1kUpR+CmMQNDCSFMxvbUB/CKyGfw4/M2
	l3QNNyFiNVBiCsB9vFVTlg058QLDTtTFNFn98PFstT0rfwWSNTfkCj6r7+L8iAfsy1LfU9wRv0h
	J0ltisaDAjX+D5CoSsmhg7GrOxzMnG+soUplvyPaWa+BOiMC/t
X-Gm-Gg: ASbGncsVHjsXh3bNRTmRgn/Ap7YQKKHIrc6fEFFbdei9CeElLkiFGZqPr6ZwWvopSsX
	HLkA5y2Dqh0nxyCowc0HrXuZubkiNWJGtPdRWjgjOywh2h6+SQCs9vEz+/gDxT351u7pdzS5Hay
	Y2eg3aJxBAPtbaRWeQ9u3cKFVARvLPkg296z7ZGIc8zaGTyblMEgUAtNWPieOJioZXxxe0xT3dt
	2f/CCrdGLNjQCogsEctnd9KAbCLy+V5gUQf2Qv5Wz4UjW/cj7Y4puSkv4QxQkiz2JAcfjR746xP
	0G4Vq0Za/yvqLRk7dj6raAreS/p+Smkx
X-Received: by 2002:a05:6000:290b:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3b5f359d08dmr9051352f8f.59.1752489881143;
        Mon, 14 Jul 2025 03:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtxVKiRxB+FpXzE5cW+k4F38kh1q3AFLo1SgxCi5sV67WZgIsGuQ18ILpi+whjo1m/+jvI2Q==
X-Received: by 2002:a05:6000:290b:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3b5f359d08dmr9051312f8f.59.1752489880604;
        Mon, 14 Jul 2025 03:44:40 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e1a5sm11873559f8f.74.2025.07.14.03.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:44:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/5] drm/sitronix/st7571-i2c: Log probe deferral cause for GPIO get failure
Date: Mon, 14 Jul 2025 12:44:01 +0200
Message-ID: <20250714104421.323753-3-javierm@redhat.com>
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

The driver already uses the dev_err_probe() helper (that only prints error
messages for the -EPROBE_DEFER case) when fails to get any other resource.

Also do the same when it fails to obtain the rest GPIO.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/sitronix/st7571-i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 634b426e2874..fd9d6c701cc4 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -804,7 +804,9 @@ static int st7571_parse_dt(struct st7571_device *st7571)
 
 	st7571->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(st7571->reset))
-		return PTR_ERR(st7571->reset);
+		return dev_err_probe(dev, PTR_ERR(st7571->reset),
+				     "Failed to get reset gpio\n");
+
 
 	return 0;
 }
-- 
2.49.0


