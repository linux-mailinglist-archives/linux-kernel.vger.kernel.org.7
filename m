Return-Path: <linux-kernel+bounces-750931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE1B162FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8617F18C8171
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C052DA779;
	Wed, 30 Jul 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEDbYTjr"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA62D9ED8;
	Wed, 30 Jul 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886530; cv=none; b=VtShaauHh1WT1Vgq9upU9JX/S9ENCpblqcVu2UZDhq/OYVNMASLAIbNF443PWNz1OMFDjN33dQMhZmaeCr3n6nlr1fGMVEId8bViIhgbWzRDXXzt9/fG245yT42jwLDYgulqY80UPN/DjvxId66sKNX9Q5NQBE/yFCCVCF4WLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886530; c=relaxed/simple;
	bh=yBKebHSmHOfmlKzt4dxWwUdm5H/+xqmsFAEGPRL8Vqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwZPLVc/X2ugY5SoXLHTTkVeCKsmDs601+0zQlSrs1UnnfLVL9S5fusZXDPQ5VJCzdJMW2/uPVEfI289mShyvuSedT4WIQBOcyQQ/yxmckxwLOpbXDi2IwXlJZAsvvMWS2fkqMln8PfCwPgk+mcULVh4KDD/yvMRKTaoXESVMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEDbYTjr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so8287886a12.0;
        Wed, 30 Jul 2025 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753886528; x=1754491328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYHDRzJKOaAYMNCXSgPR1P5klbcOxCCuVtkaiNHOnc4=;
        b=WEDbYTjrqPAAVgt9whClW830FzZfgzEYxrTtnDQxzCE1IPRaOepT43C9T6JBqNw/Vn
         pyGeiHgLfwUgdHSNsRiO4mQMdypNAq2o4qtD8D6HMce9eqVW0C0bGDLacw0K1vhchXF1
         +XoN+Cc+lG7SY27BloxHdPro75m67QWL2bk0G9O9V+R7ch3MuWtFWpaQlA3LgNJII/Y7
         RYuOvYyJj0noeHn4w9IcHho3BuAfoSNDPJhx9lfwUiUETTk9/VmtblK4huOKBSczHdlg
         BzOzRtQdjYQCikvOWiOGZm2rLB3uH/WqUC4fmwVA4bwHe+NSu6MSqomrmNxB6AS709tn
         evAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753886528; x=1754491328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYHDRzJKOaAYMNCXSgPR1P5klbcOxCCuVtkaiNHOnc4=;
        b=il/e20gHcM2f4pytktB/C/mZ5i+KhZfk2ihIrIdgVAAhbG36/CHBIYsgZuBmdLG408
         qe1NeN7slNIj4lClExJuezCDRGt3aPYk8A/sZgFMVGfJe+fkiHs37EVGhnrNiFdPMfkC
         f6Q6U34R1esc811+Qit9wsEo4UkMGPnlnPqM2NB40zj/uzy+IDxcSfFtkq7qPfMoKpJm
         MHjD7Gb7meav6gv/78IYaGEQiUjGhTn1Hvm/5bP+k/xcZXrcFQio1BAhZlhlxDx4gIoX
         m68S56ooPr2rELHLz5UDoQquFZErynMOUkQfL/OgT29XPq/rX9jcXyxh9/msNj4CRyAg
         h68w==
X-Forwarded-Encrypted: i=1; AJvYcCWGhvzqRPkgM5G1GNCAWfRB02MH8Fq7wqYoY4nB4xDZBAZqghxgjPpZGOK6VKJCeB97WFyb97PRw+1WunTD@vger.kernel.org, AJvYcCXFIfz5zdumOxr/F8zx/X/BOJV7UYfYkBWG3qbTB3kxH6utuk9skmhFC+sR8zGNdCflahTjHhTec4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyHxGIT+wHkoyAHN2KwdqsBWXMyartjl5IxbiEn4Ur25s5OXC
	VadT79mh8pNrTT++C3qAvoLztdQsZRh2E2f2UAgFIp7vmY0b5BDX1PiN
X-Gm-Gg: ASbGnctG2AUmq4ARqHrXyhtjK01QIbu8TjzmKajFQdrccu059W9pRYDsE0WgNempmNB
	2L3c+4CHBsKKgBz2Xiu3vFAAVfHnjlP8HOOarMEwyBcSCCVnAZm+WpowTVmy/IHPn26rfMVd9zb
	+dnHEcIxj2P4iF3rsksF7KpJKCCIIsj+G+0wy7lfIKdEhcTbknJ+MjHvTsayQhh5ZCXXA7btF9y
	vLp1ZEN5Ug0dqLUGSGtad7eEfSJI9Ctd/oiSgc+XcmOHaxfdjpwkNdoQ/SKPuovVC+eTlPcJARn
	N3fnIehqFANifFUoKdmmAy2gRV5h5iOlaOHkIeBEis6F7NbU2qdOWjrOm0N1uavP8Go4IicFeVT
	DuB/uP5x8ocU=
X-Google-Smtp-Source: AGHT+IHHhMReMrcHM0rLPnguJMUg4v42TJz2pDtZFa86c15cEiGMS6XSNlbDGKZ7Gy8VKfe9R0BtaQ==
X-Received: by 2002:a17:903:41d1:b0:240:8cca:50fb with SMTP id d9443c01a7336-24096b49247mr42457225ad.37.1753886528338;
        Wed, 30 Jul 2025 07:42:08 -0700 (PDT)
Received: from Arch ([103.87.142.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff6e201a3sm87342125ad.150.2025.07.30.07.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:42:07 -0700 (PDT)
From: Ayash-Bera <ayashbera@gmail.com>
To: skhan@linuxfoundation.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Cc: Ayash-Bera <ayashbera@gmail.com>
Subject: [PATCH] fixed typo in the DRM UAPI documentation.
Date: Wed, 30 Jul 2025 20:10:23 +0530
Message-ID: <20250730144158.7926-1-ayashbera@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix a minor typo for the drm-uapi Documentation. 

Signed-off-by: Ayash-Bera <ayashbera@gmail.com>
---
 Documentation/gpu/drm-uapi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 69f72e71a96e..64e002c6383c 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -518,7 +518,7 @@ ENOSPC:
 EPERM/EACCES:
         Returned for an operation that is valid, but needs more privileges.
         E.g. root-only or much more common, DRM master-only operations return
-        this when called by unpriviledged clients. There's no clear
+        this when called by unprivileged clients. There's no clear
         difference between EACCES and EPERM.
 
 ENODEV:
-- 
2.50.1


