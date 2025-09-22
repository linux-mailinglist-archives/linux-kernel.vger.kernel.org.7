Return-Path: <linux-kernel+bounces-827068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F7B90221
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B765E18A3015
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86C8303CB3;
	Mon, 22 Sep 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuJ5Lt2I"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F032FE569
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537401; cv=none; b=MgE/QZKdcCjnmlt+pNgTeaPL2tU9Kvhfn6km7mbkQptkEbMXOasr3ZN4CbpidlKP/3gBr0xYYJZ6U1jfQTbLFh6kWnFBBDtYFDzJcrIMPoPKL0ZfdBEIhfZm7+AVx8Hp0UrozGrD88KIxsTF8ylh5mLjkqUa3twq0LqLvWkNt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537401; c=relaxed/simple;
	bh=5AEGBnus0Qpin8vE8E3VJOLKJlPJziaZtjsBzVOmbM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMhY2OiHgLR4JSTV+Lbek7v2/EFDmL/zlg8NbYmqZLWYyPYHMwbQUif1dfw3Ph6ssDmb7RIk7NnWJjbr0ladoM+uamlCiQw4dQSzJRKfbRXs3gQOmpyUFuroumQNc2YtsUoHYTs9VYX21QGYsJWEU0uEozrjiS1SLIxFP4Umuts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuJ5Lt2I; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso3817004b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758537398; x=1759142198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja79xQC+jV0B6iDYhE4odk4g+YamsPvZ5MHaPQIPNoM=;
        b=UuJ5Lt2IwdFIRIIDzk3CWDnBddOWy6cicXVnmx+fWYcf9BZ5r5rs2FHI8wJr89DXnW
         EsLdGivCuqd7fZcmVSHr7o5BXw2Ibrz89AtMX6LDq/BTjvaR4hmPGgqCfVddcsp5nJTA
         VzMPD5Qk97zPqapOj7s/m0BtrhcroHyJ8prO4C1qfxPiMbaQYG1/XvHZhvyPl1iEgoPF
         1hcMR1FTFkPU0wMBSrqIJufwYo6a/YyqBUDx9xnkz2g/mQni83oqRxVUHhtRPrKnEYwa
         Nwf7EIQ4Bx3crXYh7Io6uy/cVa554+ASjBqA1/iS3ydGlUSzhDuaBn8TMOUusGQ6j7Ve
         t4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537398; x=1759142198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ja79xQC+jV0B6iDYhE4odk4g+YamsPvZ5MHaPQIPNoM=;
        b=n1Mz1aAEoNuE05pPFIlxySGZ7IZ1aZSLv00Fn7pJiWGNG5ewK/o9lDafV75Xv4AS4X
         7nC2Y4f/cFmkASgArQNxszj1TKTcZdROq9M4khZ4NOxLGTA+erBPCVSx5ltJiFsh2NcL
         jU1iBgmkfB9/yEfgHdS6bTiBbpJd/GX3TtqTAlAgQf7n0NWA+giTw2SGwgnVXEMcsuE8
         mhgYdCqyxjDIBFSxuYzI3k1g/BN4mj2pdZqhTlYsYjBZaAyjfeLQQF1Poek5QaqHWezX
         BiNmj6SRFY8eeMryi75F7dF09qCcRReMisctcRSOMSxeR/uqdrbTUeLojCKlnnRZSkqZ
         FJdQ==
X-Gm-Message-State: AOJu0YyddmCP5tVVErCRG7DzXtkcOsf9ryc3oFEl2RTDK5BOIo5rwvpu
	0vZwhiDDzPqIL9PKOGHxtA4lRqXJDQfV/hvh3kgMk2vGMfUUsPopHehg
X-Gm-Gg: ASbGncuTudz5GJUdCw6G0tcFiJRF4RmoRJiAXpxE1J162UKhhbh5BkoYMEz5J1wQyex
	qOuHO1rmvJ65eQaxIys1FF0wLdT1GyxKuVVS4vc4e3mMus03KO7xzkZQ53RnID3l75PWYCaACmT
	6OixAPcR+Dt6efqNn5JikedaX75vjyVGxURKivXC3UKaVVFY4FQmNRhlUW1StH5hxVIIoKluekm
	2I1ApTl6FMh8kAbMXnyTmc1uNQLX6zmqBDv9/ow08MC5zJHbYUP91b9bVeG3rY7VIcA82uuaNBA
	2d42osqRighugSVfX2bpyi66cwRQ/ZDW5aM7Qwg2XikyMAiQGbnnMFuNb5zgUTbQNzi0gGENgJb
	z8LkIxc+f1UOgf7Qmb7tzdw==
X-Google-Smtp-Source: AGHT+IFjbk1Ge/dq+0OQP8qlAA9psarcE8O7P0zDwLh4eJYft0zHWrPMxSR3ke/HuW5RGmagj5p9LA==
X-Received: by 2002:a05:6a20:6325:b0:2b5:769f:254a with SMTP id adf61e73a8af0-2b5769f2904mr3892589637.6.1758537397559;
        Mon, 22 Sep 2025 03:36:37 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f43b6f6afsm1391686b3a.65.2025.09.22.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:36:36 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8D31D4266764; Mon, 22 Sep 2025 17:36:34 +0700 (WIB)
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
	Arvind Sankar <nivedita@alum.mit.edu>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/3] Documentation: fb: ep93xx: Demote section headings
Date: Mon, 22 Sep 2025 17:36:14 +0700
Message-ID: <20250922103615.42925-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922103615.42925-2-bagasdotme@gmail.com>
References: <20250922103615.42925-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=bagasdotme@gmail.com; h=from:subject; bh=5AEGBnus0Qpin8vE8E3VJOLKJlPJziaZtjsBzVOmbM0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkX1QLfr+8rFNv9puHYSc34IO/K7k2cE549Xpo+tULlQ 0oDe3JeRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbiGsnwz9w0YcmvlaXnjLN1 9yqKHxcS3Hx0B8+XW6usP5+SLeKd/Ifhf9INZrngmfMshXZ+kV68wfn1zFd6m9ZkZ1ZZHT3xm0V 7AwMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Section headings are formatted the same as title heading, thus
increasing number of entries in framebuffer toctree. Demote them.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/fb/ep93xx-fb.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/fb/ep93xx-fb.rst b/Documentation/fb/ep93xx-fb.rst
index 1dd67f4688c751..93b3494f530979 100644
--- a/Documentation/fb/ep93xx-fb.rst
+++ b/Documentation/fb/ep93xx-fb.rst
@@ -41,7 +41,6 @@ your board initialisation function::
 
 	ep93xx_register_fb(&some_board_fb_info);
 
-=====================
 Video Attribute Flags
 =====================
 
@@ -79,7 +78,6 @@ EP93XXFB_USE_SDCSN2		Use SDCSn[2] for the framebuffer.
 EP93XXFB_USE_SDCSN3		Use SDCSn[3] for the framebuffer.
 =============================== ======================================
 
-==================
 Platform callbacks
 ==================
 
@@ -101,7 +99,6 @@ obtained as follows::
 		/* Board specific framebuffer setup */
 	}
 
-======================
 Setting the video mode
 ======================
 
@@ -119,7 +116,6 @@ set when the module is installed::
 
 	modprobe ep93xx-fb video=320x240
 
-==============
 Screenpage bug
 ==============
 
-- 
An old man doll... just what I always wanted! - Clara


