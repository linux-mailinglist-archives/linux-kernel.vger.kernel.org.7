Return-Path: <linux-kernel+bounces-868725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF06C05FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0202E400884
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5A31AF2C;
	Fri, 24 Oct 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ohsc8+Jx"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D231A7FB
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303631; cv=none; b=rC3ABT6FW8SxsQVuOYEvSFj5MQJptWo8GoNHI05nkQlGGriORWbv6hEYqEOJdkLok/gLo1slWNGpN0VtuSMbozuuCzRgQ09CBfl+eJ5VIqoeQ0uZYh4Q6RRJAEKz5qt8p+Y6Ym76QiC2cOv2VZifeSjf46CGImI8AF12Y4zkBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303631; c=relaxed/simple;
	bh=sRmLVb4WDCfxemO60P2Zl3Rgl7zJ9hn7HxwvQBrR0HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbqvnOKejiTbU4aVqxzXHjZ8fmk8lSuIBO42IFY9sISnaArf6Cjo5/ZSidB/RVBYzm7d0HpcK+EdfhCECLdmrbKF78UGPYkile/fRAaF1rg8ZcVA38deBUBqSX4WkkwcQ/NiBdSn4p/79aUCddfyjP58mi0uHCNH+L3OAG0eaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ohsc8+Jx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47117e75258so14492715e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761303628; x=1761908428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2DlPJEXE9bFCg3voEVGTmMxEdVMG5zLWK3yFZXX/LI=;
        b=Ohsc8+JxXZo8CLR0CflOAnqkT3ZYz6TVHYeaEoc4jd8DqcmvfQN34oRj9bOfCo6ViJ
         SXT6pIyKIX06Eu4RG3ni6RZY0neRBkvteP9LH3c7Z7NZROTLRLA4p6u56a2LaNrJhVyx
         znAWEwOCrSHaBQLL8eOJDc9LYx2bAGEbS4hm4Nn3jpI6O/Qgs0a+ZdykQQYw5S0Hjrhf
         JgNwjBmEuR7stxJ2rAHcdVoyR9LWtey6PlubB+iPcQvAqLo4GOag/9CGJOP9moorcdfA
         h0he1B4X97jVxuOshV52IZqEXb6y+ClHQ05CnGl/7tPPk2TNGXTyq7rb6vYlAb5i7Qym
         2bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303628; x=1761908428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2DlPJEXE9bFCg3voEVGTmMxEdVMG5zLWK3yFZXX/LI=;
        b=TKJ+qg1mjNYijgXuD1ISUAz3dDAN8wxTmkagARkCh//kF2bQXQ+rArlNh8PmgOjKJa
         Crhm/fB5JQtD0tMOpRwt7cy2tI3cjZyT0BmU/4Ezro3Pb1YcCq+K0uej9hgb13is0Oo+
         hjxZW89WRqMib61ggcson2o57RfDZrQQNHjpbJCv5GnP8cR7wQ/SK7i+ytKzT7dzMi82
         d7tm2Bs6Z9/zDb78/dphgiydLdqXvfl1Xz+4BwyLmyi3gfSTgVMr5wpC6Md0yfaGJgJ1
         JcCCHU/TA03Df35rXW5wZbkJpg9X8bBR6nWLPvBfSAmmM2OpJ1srGRMFM5rtnhzc3W4s
         ZW6w==
X-Forwarded-Encrypted: i=1; AJvYcCU8fJT1WxsqLof9kKe9PbErtek4EpoQSgJ3JF+YPT5VBV4g3j1ttJ4n4DunpBWUBPLVL+J4VUADSlmWRJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/KrK43tAcN9imVa8+KUGIZp1T9+2XkLNjcNLWp/5WsPUTa4n
	U7UmnuvHQaLNW0OJmN8GC2n5EmWeGzCUNnRAcUfjjEzJ8R9DIcOr0L9c
X-Gm-Gg: ASbGncvLSpdmKu3u68XVefsjriD9207Z3Wf5oN+wwg51FQ3IuOt7ZS+9F5fNdG55u4W
	6femYvC13IB4QayiD7O+yVcf0oNjN3buCUhsVXlk4/5pWQiMvQTG7T4KQ3haDEdABPtUVyRrQ24
	YQgZupjc7qSpj2c3ktFlhJLvDkS5U/qxB7Ju7yr5z2EuEz2oG7xRkMdi1SR+Cw9WIEqJgL5K7DU
	FsZh+4zj/vwkQ5rfWwf+WfMIOsjfKBo8MFsa4CebJJzUJKZhZM5KAKy4fA9vPd2XkVR4H0UN0jz
	lHdXmgL+2geUgR6YhYky6br9WIVko/OI50pb3T8lSBMPT3CCtIim1IlCRrXEngS/iXcHogKEN4t
	WilQWsQXKGc0zvU5dZZ/KK6OZyParT8wzJtYwSkzU1zcBYuK6+ZfamgsYGRe81o/HW3a4b5ITVI
	ogUdmv4XScO4jxZgfwka86
X-Google-Smtp-Source: AGHT+IFDGexIqIJe+aeZRvtxTGvwmt0zUxNNK7H0pqVfPDQQTVgP3yUieL4uwsisR5iCtogwo4ejsQ==
X-Received: by 2002:a05:600d:8303:b0:46e:396b:f5ae with SMTP id 5b1f17b1804b1-475d43c85bemr7875965e9.16.1761303626317;
        Fri, 24 Oct 2025 04:00:26 -0700 (PDT)
Received: from fedora ([37.29.213.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae9253bsm82484615e9.1.2025.10.24.04.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:00:25 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/vkms: Update testing with IGT IGT_DEVICE
Date: Fri, 24 Oct 2025 13:00:05 +0200
Message-ID: <20251024110014.4614-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024110014.4614-1-jose.exposito89@gmail.com>
References: <20251024110014.4614-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

VKMS is no longer in the platform bus, instead, it is in the faux bus.

In addition, when present, IGT picks hardware drivers instead of virtual
drivers, like VKMS or vgem, if they are not forced.

Update the documentation to use IGT_FORCE_DRIVER instead of IGT_DEVICE.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index d8c445c417b7..1e79e62a6bc4 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -159,26 +159,23 @@ To return to graphical mode, do::
 
   sudo systemctl isolate graphical.target
 
-Once you are in text only mode, you can run tests using the --device switch
-or IGT_DEVICE variable to specify the device filter for the driver we want
-to test. IGT_DEVICE can also be used with the run-tests.sh script to run the
+Once you are in text only mode, you can run tests using the IGT_FORCE_DRIVER
+variable to specify the device filter for the driver we want to test.
+IGT_FORCE_DRIVER can also be used with the run-tests.sh script to run the
 tests for a specific driver::
 
-  sudo ./build/tests/<name of test> --device "sys:/sys/devices/platform/vkms"
-  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/<name of test>
-  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./scripts/run-tests.sh -t <name of test>
+  sudo IGT_FORCE_DRIVER="vkms" ./build/tests/<name of test>
+  sudo IGT_FORCE_DRIVER="vkms" ./scripts/run-tests.sh -t <name of test>
 
 For example, to test the functionality of the writeback library,
 we can run the kms_writeback test::
 
-  sudo ./build/tests/kms_writeback --device "sys:/sys/devices/platform/vkms"
-  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_writeback
-  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./scripts/run-tests.sh -t kms_writeback
+  sudo IGT_FORCE_DRIVER="vkms" ./build/tests/kms_writeback
+  sudo IGT_FORCE_DRIVER="vkms" ./scripts/run-tests.sh -t kms_writeback
 
 You can also run subtests if you do not want to run the entire test::
 
-  sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
-  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
+  sudo IGT_FORCE_DRIVER="vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
 
 Testing With KUnit
 ==================
-- 
2.51.0


