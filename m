Return-Path: <linux-kernel+bounces-868724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F4C05FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCABE3B9D37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4631A555;
	Fri, 24 Oct 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap67KMXa"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA561313291
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303628; cv=none; b=SKNp70I+pAskg+FLlZNd/d/VjnGrvUHEc9v+XhGBVpYs8RKaxFJxQCgH06dTb0G82N+YI77g9B6+kK7iPc2c0jgDXRVz06jXNsbJ58nTUhN55a305waEh98ZIEnZVPXkoqPNnodHPxvxS6PIMjz0irdF46ItWM/WDXzbvNaknfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303628; c=relaxed/simple;
	bh=UUJma3mfHxdsACo5jvuRAN7LQ2A/mwBLWD+dCqbrfSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N8tRGI5Xv+BI/dwn8ytkMxLDihlM0irYRGObvG5fDIiSW0pkZl42vcrQHgyj/IW7uoUWuAxJoXhphAZU9aX4cNdNpnaff0RB3fus0Cp4ZZE84I98IaC1NtOTXDw4Yh36ob66HBHPkPmS5R6SvW1AGj3ie1lr1j5t+mxd5S9ICIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ap67KMXa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so19022235e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761303625; x=1761908425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNwQqBemATmxjXx+rJAEDdWPHTVfdvUDQPF043XY79I=;
        b=Ap67KMXayItpma341b9u0JMZE2ltybepOBM0JUzocHH+JuTxnzxnOH6Vy/Q7ksyBy5
         7AfvUUT81x20FG7C2z92gE7K3/JOfa4K4wCR/XhtzHyCW6qjeT2IWJR0fsgByWQZ5I0h
         h11oFyDXSEg6lOrajGSyknpOSuR92cHPNBQvQQ/j2EZDu1YBnTyrgSKXrykCXkKBtRiA
         dj43w1QKY2kYZ5jI2TUob44WZmkdQlYy+CKCBgDuc4frhi/qWTsSfMbOAfvHZG3sAdqF
         QWAIGF6AcwUMYcxWseaECz6/zigYsHNFoMdIurQpatEFWE5Ir/IQUuZv3u2e/ZeBkiic
         FiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303625; x=1761908425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNwQqBemATmxjXx+rJAEDdWPHTVfdvUDQPF043XY79I=;
        b=N/xP9/pjAZ2yUKakCxx7WIH6I3nocxu4VPM7chyEw7k0m35YOWm0+N8L0YGNMoP4aJ
         LVCPGQbeciqTgUcYfAXpMyaANWHAQEVtF2MNxM2fANkE+CwccSvuE2b21V3IYr72xAaA
         qD3QjOdGMnoNRBz7mN88ykSh/FE71OXMREl5uPI/Uhu7NQAbcfly9HD3feMdzlXmFBge
         E/FrsnsoQAgaUX+E6ZFXsdHerPFwlqJ+NUOUGLBJBTuQZiBv0G8fp72qntiD5o2J3EhO
         8tsQ7KGu7kFSYEjx1KKjuy4FvNb+2t0Ss2jimCN6yKEsnTnlZwbs0k3ZJUvUoegp9Elq
         /esQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Q0MtJGPDplySOH5hQHH4csnX0Az0ILbgfDpvuRZpoF3uhku+QhK+IHRuvqw/wtO9nIOo0RiqXm2HYyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoRhFayVrh1LJfdJ6cau9Rdn/24wAI/k57jz0PzLj2czBAT/M
	mWHvqEuaGVpuIwD4Abxjw+4gGgNQTNuV5tC5tx5ZNkc/PahH+h8mDAx5
X-Gm-Gg: ASbGnctjnGOa0WMzdMqeFms2meO1j2LA54TT2IEZ7jHu99VGjCqoIyxFMg1qnDYbZJT
	YZWrsTk1gyLGNzdQBpGn66KsDUaUNbUykv5qvCT3o/xCaye49F4yAr0BAWJqIpaMXi0wV/7J8B3
	HGg4cgy0jOCTTcAZ1/C5ckKA3/RN4jLMvTamAix58CUJwn+vY6/tGebXBnfLK4i4gYl9uefAYZi
	SFQgLY/IPIueMw02O6l4hBQFhos2Ne9RbscBpFOIy/iB9ePcld56pl28vuLFGOJCt28tS7YvHVl
	DNCZS1S4EqNmbM4VN962P9+W33DSFd7OTQsBfm5tkllWuyJpBiwv5YhAFvjCG58PZVZm2n4hV1a
	gw+2ON11jhSZK0SrTseItKld38qY1jCSiKWjS5VE6mazUEEQa0OJxuAHlIfN9LDAvpcx4VHZlb5
	hkKJtKmSVqMQ==
X-Google-Smtp-Source: AGHT+IEbRG42e1LgV+3nLNHGYb8yQMIxPTGoVR+OKvME7EdNaQHnxt1RF9GQGXBtioq1FU6OLJLiTw==
X-Received: by 2002:a05:600c:468d:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-471178b14acmr208423095e9.18.1761303624680;
        Fri, 24 Oct 2025 04:00:24 -0700 (PDT)
Received: from fedora ([37.29.213.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae9253bsm82484615e9.1.2025.10.24.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:00:24 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	airlied@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/2] drm/vkms: Fix run-tests.sh script name
Date: Fri, 24 Oct 2025 13:00:04 +0200
Message-ID: <20251024110014.4614-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script is "run-tests.sh", no "run-test.sh".

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 3574e01b928d..d8c445c417b7 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -161,7 +161,7 @@ To return to graphical mode, do::
 
 Once you are in text only mode, you can run tests using the --device switch
 or IGT_DEVICE variable to specify the device filter for the driver we want
-to test. IGT_DEVICE can also be used with the run-test.sh script to run the
+to test. IGT_DEVICE can also be used with the run-tests.sh script to run the
 tests for a specific driver::
 
   sudo ./build/tests/<name of test> --device "sys:/sys/devices/platform/vkms"
-- 
2.51.0


