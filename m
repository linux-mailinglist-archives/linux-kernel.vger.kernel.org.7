Return-Path: <linux-kernel+bounces-794515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96166B3E2D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5D47AE04D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205E73376BC;
	Mon,  1 Sep 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxLFaK+S"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439C3375B2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729573; cv=none; b=VObAgQikBuMEKM1Rgb1KESuvxbmD1fs/z1kaZu6mSlqkgKGlL3+77VMuuVA6sKYkh+dvEG74lhfNfNB1aUle/T96v9ZOuQPE6p7zCma8ErUpTAiAos8YTklCsF1rTAQm++CmUDT8M2iBknDZwsavM50Hfq/rh7nIJ5MZJTcdljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729573; c=relaxed/simple;
	bh=cmo0VEU3VTFHjXBJpOpH/OF9AaZhAVSnOOOuATirS3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkXf2FuD9z1m2NgLIW71uXpppRzQ4NIFzaQ666wW76TYg3F5L2EZFGafy6ffL1FlPH/zaPKK+o+PQUCCxzhNDRF7oo3AzAiHLeOFCzplLR8WAja/27dk31PbN/l8OUNvGVIRXCE6eCZjhxjQYlb/+SWHVvZUDT8WA5qnax+8l9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxLFaK+S; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso10537535e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729570; x=1757334370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O+yZ0tVj4VVG9ie2bCzxaZKaxc2ngyJg4tXjB6Ebrs=;
        b=SxLFaK+S86v9gV4Jjz6oe7FCxrjG62zCg/AKQcVfa7mjhuDAy0F1NahOCxbzS+f6dS
         Y7kxRKDqVzM+3+VGTE36kb7oU9gvh9Jt/Hp9OElMVZrFIejgzliCvg37LG7d9rfRXjku
         WZ82MCvVkJE4KemB5mX6v/jq+9bBMA5eaHJqwinsTd/hxR+nDukxzFXrzDaJ2BDecZU7
         I9oi+sqjXPZMcvLFQ8pAgeOgymw7SWWyiUhNxzBn3dbPbUo5qfbDo0DIoSWa6b5b9aI5
         pA5fe0rOUNXelKY+o+kiDaZREEZNACyKJnOywcg3IrfluLAyN3QVGy3y6YJcH3DbS40D
         m3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729570; x=1757334370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O+yZ0tVj4VVG9ie2bCzxaZKaxc2ngyJg4tXjB6Ebrs=;
        b=gc5TKfKQiZf32pfAPBaA9VtkUBY/S0W3K4iGlDmsAWlRWJtaUhZ3EdrEEygIfZwlJ1
         MFWxPdS4m4NOgJERx8OF7Bt8yJkTFc0aeRFSSBLvIOR/jBvtLugpKfV1UMLlVcQwV+Bf
         WZqnduw1DCyXmGDHJWPw73HMj4XCE1Z7sQhWQq3NFjNAsY94SEG2EJz7rysyVZDHCBmy
         fqYR545NYYToAyyotnyZ5GVwq6dUr3VOAkVKIHgHTMP/Gqa+URIl9uzOQKYUmXhjjKy1
         YHj/mggf8lXsxDgJGuQjB+rv4sOdICIa25pvawIamTMjoHAnf83cOgFm3YdWwpE08Men
         I6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp1r0Z5SHQcY4+6OHNip41G+JuO73nHSr/RpMOBrafo8BIU8nIGiBXnm13dUqHFxMKHRR7502SNtQRI+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRD75Po8GZg/9BHsXXUaCzXkt6nGHlY264MMEoW33WiTrKh6EY
	78jRSJjVH7n4VllhE4KMMIoh0EIaa9uYOPqI3+MkzovsZG9xiV8JHeAe
X-Gm-Gg: ASbGncsU4tameycR1BlWTv/aPLd2PSW6GKhiKC9L0YU3gNiSn8oJXXBTayETrG2WEJB
	lnoXy2usqugiOuokdj71GEOIcP28fzmx4yLsu37oEtcusrjf0FDIb7Mt+Fj+Bt6MszI1neD/7EV
	74mEYw2rvqlhg3f7vqD/xm6kv64yzvmYuCbDmahmaD5M3EJJiFNGQWAPu98uKC1dL/gxANL1TJ0
	fbVN0oK8oiQnLdL7w8BbFeWmjKMXhaCLgaoJkc7BtSEUqES+byezxBA7a6TQt3nHc3JSixRnwsa
	2rP1EARFSMPWyt5s+JO9B/5VBK/9QfU6H5KhpUc88ecPYwMoZLpBlraCKjMQxgu7XWwOlqsrOSx
	q7fjMgeezmxesnoAkwES7N7l8Oe8QwtGG0nGVkDs=
X-Google-Smtp-Source: AGHT+IEez3DPgxAss23izjD/lj9HKWSCt851WzEhPT8lwiYI89K4kHJbwaUo6MmcCHOXKG1VR8RWdw==
X-Received: by 2002:a05:6000:4205:b0:3d9:415c:b146 with SMTP id ffacd0b85a97d-3d9415cb164mr37173f8f.15.1756729569839;
        Mon, 01 Sep 2025 05:26:09 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:09 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	sebastian.wick@redhat.com,
	xaver.hugl@kde.org,
	victoria@system76.com,
	a.hindborg@kernel.org,
	leitao@debian.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Mark Yacoub <markyacoub@google.com>
Subject: [PATCH v6 12/16] drm/vkms: Allow to configure the default device creation
Date: Mon,  1 Sep 2025 14:25:37 +0200
Message-ID: <20250901122541.9983-13-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901122541.9983-1-jose.exposito89@gmail.com>
References: <20250901122541.9983-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new module param to allow to create or not the default VKMS
instance. Useful when combined with configfs to avoid having additional
VKMS instances.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index c1f23e6a4b07..6d299903fab2 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -50,6 +50,10 @@ static bool enable_overlay;
 module_param_named(enable_overlay, enable_overlay, bool, 0444);
 MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
 
+static bool create_default_dev = true;
+module_param_named(create_default_dev, create_default_dev, bool, 0444);
+MODULE_PARM_DESC(create_default_dev, "Create or not the default VKMS device");
+
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
 static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
@@ -219,6 +223,9 @@ static int __init vkms_init(void)
 	if (ret)
 		return ret;
 
+	if (!create_default_dev)
+		return 0;
+
 	config = vkms_config_default_create(enable_cursor, enable_writeback, enable_overlay);
 	if (IS_ERR(config))
 		return PTR_ERR(config);
-- 
2.51.0


