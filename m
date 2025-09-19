Return-Path: <linux-kernel+bounces-823822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C4B87839
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695275680E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5724A076;
	Fri, 19 Sep 2025 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMunf6KT"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C4235045
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242227; cv=none; b=m2ZmhPWKGJEnEZw3W8klzoJBcTcpu3TSsHnWeSB3SSwNnN6uX/PdrqOShlQvbb+rbtpLDHDUDXfe//yzniJNK8jSwC/GKmaMLjZz4LQEbeiwTWx2Jdo8S33km3HPO/odWPX1QXf7ff/AC1GbDwpSDOJRquNbdXU9Ixrr6bs7JL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242227; c=relaxed/simple;
	bh=WfEfpEV/WCNT+LtNWeUNac+ZML6LQG345dmWyepkyJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eET6a1qzg8HmhDOqptNMZKC1/YFhbwk+2VOgU+XRiWPjTAHtjnaYqwNZm1gNEGnNhntJCO9Kwj6yz8kMTOzUuHOJuB6SwdrJe2byaUe7lV9vU88FkBo9TcBgPJlDsvf9QH7VGtphq4VZR22hq9BVkl8brPnE4CYIV3ueibexr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMunf6KT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1109786a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758242223; x=1758847023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BZ6UPkHLusu3qwn8I/3S9JaRleSEd5bS7OxTGQX0u4=;
        b=AMunf6KT+YP66/cDAeTdp8jPI132OOURQ9gjh1wqLhZCBH8qyC0k5c9a7YgRwR5udZ
         YESeoJhpBfn80sHOTQbcqMxpjAX3B3ueN5YesDVF/SuI9EkMYQwyONijX7t+j7T+2Cej
         Um2naqYCBk2f03mfNXCocH9fowHDtxldpUzsk0vGhzbqu4HoCbWbVk2HAOxOKvfZMlvJ
         8bK5GeWSmRiPJ6NFv9urYOzjNYjGjyzcdmDBd/UoI+s89u3E7rVVtSN/FqzKl2aKTtHe
         iAbD7r7/cAvlF1JoBjzYwYgusp2vv7Lvq8QdfUhI8PwTxKxuPnUtjIcEisi/tu//N1Hk
         mwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242223; x=1758847023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BZ6UPkHLusu3qwn8I/3S9JaRleSEd5bS7OxTGQX0u4=;
        b=unBkCfdG0V47h2evZhnnaYCzc9M946cuxDXDwq8fAhrIaJlDlUJNPQfxJVAnXyknuF
         XDQACGHXq+mEiL4ScMOiCB3iUBUZTmYNJ/ere8QHUAM1YIgtQLUqnmqAurZAE7f4ZuQ/
         VW33ez7hKLRXcgopK36qDnBeVMNEurN7KLi3fRAxB6wHlA3wkgozJgZYQqflwbfR4nnM
         26BZm1mkzq1YAiM30wGeqKy0DtSOsTHRrGoTtX5tdjR2GopyZFzq8gf1WbuT/MwLFRYm
         SSiM2p2f1wFdQ9mI2ILr++k1w0v3yCZhMFjj/Y9ZqFnNVRrhCxuQ4upHmvlGse1kk+zv
         XSKw==
X-Gm-Message-State: AOJu0Yyw2zIG5ecRficFrKOEmrsWJNxYX4fD2pkYpwXgn10xmZo1p6mq
	N6nzlFpSF80jOnkCD8WBROEdTP8ofGx4JYeKsTo9jQ3cu+N28bOgQe47
X-Gm-Gg: ASbGncsVXfAYqDOi2ccR3S/8U9RVXL0V2Ds85sEEo+Yxt9GXck8i8YIggNkEMFV0ywF
	bXMaogdG+Bj/nNtV1J5dv0TfG8YEluhiBBsaKK8Ad4qfdJ+9YPQSyMTcQgN/GHT9icVZlrHThyy
	vBzzBdbSVMUEySaB1Ld4KvsO/UrGTg90Nuwb60IdPPczdYA66ReNDfQ65Jt7EfyfGmSzKlqTpqv
	ycIuZmpwIKeZMEDJDleI1oX4xl3Ja1nU052JV/HfRL7tV2qAoCzeKK707VRs/PEmRNcy+8z/cea
	QuRHgg2ISxay+wIZcAGYX4/R/LYqGyiNVuMQ43O2RLjJU2KQM36BInQLxOTycAWzGBxJlDDVLst
	zDEDK0jgRl2S5v3d9SVOX8g==
X-Google-Smtp-Source: AGHT+IG/P523B4qIxsdV3Nd5mcbbm4HW+mCWBHfwsee7qzkuiimd0XP3XyafaGOXtbk4LwCXLc7haA==
X-Received: by 2002:a17:90b:4c10:b0:32e:3830:65e1 with SMTP id 98e67ed59e1d1-33098385815mr1650016a91.33.1758242223152;
        Thu, 18 Sep 2025 17:37:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed275e795sm6694557a91.19.2025.09.18.17.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 17:37:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4EF954227236; Fri, 19 Sep 2025 07:37:00 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Bernie Thompson <bernie@plugable.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 2/3] Documentation: fb: Retitle driver docs
Date: Fri, 19 Sep 2025 07:36:39 +0700
Message-ID: <20250919003640.14867-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919003640.14867-1-bagasdotme@gmail.com>
References: <20250919003640.14867-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7088; i=bagasdotme@gmail.com; h=from:subject; bh=WfEfpEV/WCNT+LtNWeUNac+ZML6LQG345dmWyepkyJs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlnlrS/8Nye9a0yIeSf/J4/z++5JVYv2heZzKS8ePmU/ 6eMjF6v6yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEFqQx/K8+L+yU84W9I33f i99PY3/ETdPtjkqZdm0KU+mpsiffir4yMnQVGErLTNm6fXPM34zvS9Y/Uuyay6hr/nRC0xbHb5Z vNbgA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Many framebuffer driver docs are copied from vesafb docs as their
template, including "What is <driver name>" title. Such title
implies the introductory section, however, and not the whole docs.

Retitle them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/fb/aty128fb.rst | 8 +++-----
 Documentation/fb/efifb.rst    | 6 +++---
 Documentation/fb/gxfb.rst     | 8 +++-----
 Documentation/fb/lxfb.rst     | 9 +++------
 Documentation/fb/matroxfb.rst | 9 +++------
 Documentation/fb/pvr2fb.rst   | 6 +++---
 Documentation/fb/sa1100fb.rst | 9 +++------
 Documentation/fb/sisfb.rst    | 6 +++---
 Documentation/fb/sm712fb.rst  | 6 +++---
 Documentation/fb/tgafb.rst    | 6 +++---
 Documentation/fb/udlfb.rst    | 6 +++---
 Documentation/fb/vesafb.rst   | 6 +++---
 12 files changed, 36 insertions(+), 49 deletions(-)

diff --git a/Documentation/fb/aty128fb.rst b/Documentation/fb/aty128fb.rst
index 3f107718f933fc..0da8070a552165 100644
--- a/Documentation/fb/aty128fb.rst
+++ b/Documentation/fb/aty128fb.rst
@@ -1,8 +1,6 @@
-=================
-What is aty128fb?
-=================
-
-.. [This file is cloned from VesaFB/matroxfb]
+=========================================
+aty128fb - ATI Rage128 framebuffer driver
+=========================================
 
 This is a driver for a graphic framebuffer for ATI Rage128 based devices
 on Intel and PPC boxes.
diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
index 6badff64756f49..3d4aab406dee0a 100644
--- a/Documentation/fb/efifb.rst
+++ b/Documentation/fb/efifb.rst
@@ -1,6 +1,6 @@
-==============
-What is efifb?
-==============
+===================================
+efifb - Generic EFI platform driver
+===================================
 
 This is a generic EFI platform driver for systems with UEFI firmware. The
 system must be booted via the EFI stub for this to be usable. efifb supports
diff --git a/Documentation/fb/gxfb.rst b/Documentation/fb/gxfb.rst
index 5738709bccbbf3..3fda485606bdc1 100644
--- a/Documentation/fb/gxfb.rst
+++ b/Documentation/fb/gxfb.rst
@@ -1,8 +1,6 @@
-=============
-What is gxfb?
-=============
-
-.. [This file is cloned from VesaFB/aty128fb]
+=======================================
+gxfb - AMD Geode GX2 framebuffer driver
+=======================================
 
 This is a graphics framebuffer driver for AMD Geode GX2 based processors.
 
diff --git a/Documentation/fb/lxfb.rst b/Documentation/fb/lxfb.rst
index 863e6b98fbae55..0a176ab376e30e 100644
--- a/Documentation/fb/lxfb.rst
+++ b/Documentation/fb/lxfb.rst
@@ -1,9 +1,6 @@
-=============
-What is lxfb?
-=============
-
-.. [This file is cloned from VesaFB/aty128fb]
-
+======================================
+lxfb - AMD Geode LX framebuffer driver
+======================================
 
 This is a graphics framebuffer driver for AMD Geode LX based processors.
 
diff --git a/Documentation/fb/matroxfb.rst b/Documentation/fb/matroxfb.rst
index 6158c49c857148..34cafaa00bab19 100644
--- a/Documentation/fb/matroxfb.rst
+++ b/Documentation/fb/matroxfb.rst
@@ -1,9 +1,6 @@
-=================
-What is matroxfb?
-=================
-
-.. [This file is cloned from VesaFB. Thanks go to Gerd Knorr]
-
+==================================
+matroxfb driver for Matrox devices
+==================================
 
 This is a driver for a graphic framebuffer for Matrox devices on
 Alpha, Intel and PPC boxes.
diff --git a/Documentation/fb/pvr2fb.rst b/Documentation/fb/pvr2fb.rst
index fcf2c21c8fcfeb..315ce085a5855b 100644
--- a/Documentation/fb/pvr2fb.rst
+++ b/Documentation/fb/pvr2fb.rst
@@ -1,6 +1,6 @@
-===============
-What is pvr2fb?
-===============
+===============================================
+pvr2fb - PowerVR 2 graphics frame buffer driver
+===============================================
 
 This is a driver for PowerVR 2 based graphics frame buffers, such as the
 one found in the Dreamcast.
diff --git a/Documentation/fb/sa1100fb.rst b/Documentation/fb/sa1100fb.rst
index 67e2650e017d12..c5ca019b361a94 100644
--- a/Documentation/fb/sa1100fb.rst
+++ b/Documentation/fb/sa1100fb.rst
@@ -1,9 +1,6 @@
-=================
-What is sa1100fb?
-=================
-
-.. [This file is cloned from VesaFB/matroxfb]
-
+=================================================
+sa1100fb - SA-1100 LCD graphic framebuffer driver
+=================================================
 
 This is a driver for a graphic framebuffer for the SA-1100 LCD
 controller.
diff --git a/Documentation/fb/sisfb.rst b/Documentation/fb/sisfb.rst
index 8f4e502ea12ea7..9982f5ee05601b 100644
--- a/Documentation/fb/sisfb.rst
+++ b/Documentation/fb/sisfb.rst
@@ -1,6 +1,6 @@
-==============
-What is sisfb?
-==============
+=====================================
+sisfb - SiS framebuffer device driver
+=====================================
 
 sisfb is a framebuffer device driver for SiS (Silicon Integrated Systems)
 graphics chips. Supported are:
diff --git a/Documentation/fb/sm712fb.rst b/Documentation/fb/sm712fb.rst
index 8e000f80b5bc6d..abbc6efae25f46 100644
--- a/Documentation/fb/sm712fb.rst
+++ b/Documentation/fb/sm712fb.rst
@@ -1,6 +1,6 @@
-================
-What is sm712fb?
-================
+==========================================================
+sm712fb - Silicon Motion SM712 graphics framebuffer driver
+==========================================================
 
 This is a graphics framebuffer driver for Silicon Motion SM712 based processors.
 
diff --git a/Documentation/fb/tgafb.rst b/Documentation/fb/tgafb.rst
index 0c50d2134aa433..f0944da1ea5ef1 100644
--- a/Documentation/fb/tgafb.rst
+++ b/Documentation/fb/tgafb.rst
@@ -1,6 +1,6 @@
-==============
-What is tgafb?
-==============
+=======================================
+tgafb - TGA graphics framebuffer driver
+=======================================
 
 This is a driver for DECChip 21030 based graphics framebuffers, a.k.a. TGA
 cards, which are usually found in older Digital Alpha systems. The
diff --git a/Documentation/fb/udlfb.rst b/Documentation/fb/udlfb.rst
index 99cfbb7a192238..9e75ac6b07c36a 100644
--- a/Documentation/fb/udlfb.rst
+++ b/Documentation/fb/udlfb.rst
@@ -1,6 +1,6 @@
-==============
-What is udlfb?
-==============
+==================================
+udlfb - DisplayLink USB 2.0 driver
+==================================
 
 This is a driver for DisplayLink USB 2.0 era graphics chips.
 
diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
index f890a4f5623b45..5ffb35efd4538a 100644
--- a/Documentation/fb/vesafb.rst
+++ b/Documentation/fb/vesafb.rst
@@ -1,6 +1,6 @@
-===============
-What is vesafb?
-===============
+===========================================
+Generic graphic framebuffer driver (vesafb)
+===========================================
 
 This is a generic driver for a graphic framebuffer on intel boxes.
 
-- 
An old man doll... just what I always wanted! - Clara


