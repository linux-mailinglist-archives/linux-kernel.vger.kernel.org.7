Return-Path: <linux-kernel+bounces-892335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F4C44E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0DD34E73EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683AF285CA7;
	Mon, 10 Nov 2025 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngimD6hW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7238DE1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747220; cv=none; b=RehvY9EGSEoJcdMDFDeZxH95M6X5U+7cJt0ZabUcc2mI0xC7arxLyX2v4xD5uRjpj2R+2Unwu+RnwusXky5PkxNXbB6iEgua0R07mKfAb1czO4yDt7j7d6m5yN7MHbCPQtZLNY/jbjh4/RfNfWEYfSWa7tF7XEUfFol4NxULFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747220; c=relaxed/simple;
	bh=K4xLzZ2/2eVOt8glPRV1xVtrk/KjA9eAkIyUmF4bX0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFK/Xu034S/34CMcIrWZgN8fKXD6ZJxXbkN9pL9tEYBZltMHccJlgc8OBY+C+QHifCqYUHIxlAlTkufk3DpD0hC7NrG9N5InbCkYjvdD01fHiFqVmPb0yRHLEgLNxOEfKfVsUDsgoC8yQzysRuF1CsDT3fDQd73LgA4BxUWBGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngimD6hW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso2066228b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 20:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762747218; x=1763352018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSDUDAQE9sOa+voyhIFgd7gTvEsE4t/g4DOsmmFBmrM=;
        b=ngimD6hWFiCkx4X01ZqKJBqzMcrwqsS5hGT5tzS6BG9mYsfN/iELt+72SElWjsd/k7
         5e4xDde41X1J2u8CE7lf6J3WKTiNilRllNxAyZBxxxG/EKRbh0muK0WhWEokSh+OzwYe
         plCsvgRZKD2Z7nxjLim75QUfJ0etkEW4C71qPQ8PZVGuvZpPuV7LxmKDmrYJ23AKULgy
         ml5RMf2hcNkxbTVAWbt3ssmchjoQ/jaDBbyiQ11iihS0m7wywxEHy7qMVUwmD1MPRILt
         0etwEdsCb0TbtR7ssTKrbjXoWiyxFOsR8VOJJKHTy5Nj4hkhCYu8jGTzrbKHzxtw+FZS
         uuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762747218; x=1763352018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSDUDAQE9sOa+voyhIFgd7gTvEsE4t/g4DOsmmFBmrM=;
        b=aJJ2QhFaHbkWsHf4JA/yQ7kKC5aHxvFI3LY9nQ0DjJJnf7QiuJvqZ192DcNBwxD8oL
         f7N6gxTRGHDu2ZlMB/BHYRvJry2gUZdGEb7EYzsc7vEWSkt0u0SGvVZ/O6myhBmW2z1k
         vGywSAx932x4GfwWflPUw5+6r533aO3BOnF/pxrPA4uBe++wvFDwYWVLTnQEMTMe2ZMb
         yMEoc2SXR6a6gBsFhjrmuUKMjL8JqqtewI+Xe0uY6SoD8dUBigT00XpdzFhUi5wBPkfJ
         1vx+UVitrUo9O9kfG//gGxf0onHBAUW2oX3cdIO5HP1VJnqjneqDCfZMFkgqW3oVo3z9
         i0Sg==
X-Gm-Message-State: AOJu0YwCQA1BgXfC4zJGzf0Melappso0IKucawMqLk/UT+vhtO1zO31s
	POaXigekAtNv/WahJVKTYD3QaMDRfmCar4qd4pZPym+0pq3ylK3w7Ukm
X-Gm-Gg: ASbGncsvtOjp+z+jqBT/rGyqwx/Z4gIxq+aEI5n3QqAQO3QugtbS8svDVuopo9D38kl
	auB6nqweWJ838tlhmkXnyXzSudW3iJnDtR/lgeY80K2R+gShSX/d92LObG8d8oKNOPwiZKJKmte
	Y0WAPMrFOcRFRJOBM77eZsb5uDPOrC6MmBoL6uDuu1kaLYCkjclkwUuQhFwGJfbQqEGCACb71Eb
	gIFiPFa8zrmF7S6SFRpMhA2cqEuU5ziMBmqRvSGDabqdZho+SsdVW03hpCMFpyKQZbg/iquxHPE
	svSxB+ZWTBWUeOy4T3a63FwK0U6s/HuCbNfSVMsaLEPccARfcGsk2d5um55157y7ucmfwcm0Rea
	mJHaZvh7T1YTXwsZk+WoGjZnW/FZR8R2WhHyWoPrQv1yX2KQPMVI+z9pj+lMvQ0Cds3xZuizdlP
	zp
X-Google-Smtp-Source: AGHT+IESDcVDuxfGXnbyvbRCs31L9wp486DOb6hfCBx0l2nolH3Esz13I69INyPLAs5QB4NXfObnWw==
X-Received: by 2002:a05:6a20:12c1:b0:350:d523:80a4 with SMTP id adf61e73a8af0-353a314ff11mr9564540637.28.1762747217272;
        Sun, 09 Nov 2025 20:00:17 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed1e73sm11606997a12.12.2025.11.09.20.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 20:00:16 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 2B840418F1BE; Mon, 10 Nov 2025 11:00:13 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ARM MSM <linux-arm-msm@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
	Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Aswin Venkatesan <aswivenk@qti.qualcomm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/2] accel/qaic: Format DBC states table in sysfs ABI documentation
Date: Mon, 10 Nov 2025 10:59:53 +0700
Message-ID: <20251110035952.25778-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110035952.25778-2-bagasdotme@gmail.com>
References: <20251110035952.25778-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2702; i=bagasdotme@gmail.com; h=from:subject; bh=K4xLzZ2/2eVOt8glPRV1xVtrk/KjA9eAkIyUmF4bX0U=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmCSVl5q2wOvw+ydS5S105U0nDbe3GZIs/m+4+NfjvMW mGfU7uso5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABNZa8TIcHCC6e93D7QUnRZu 2cgXvvRsa2q55vO2/j0vvVdkb/q/Uonhn83+jwvtWgS6F5r0X998xLM6+fqrf89rmppW5cS9iZ+ wjA8A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warnings when merging drm-misc tree:

Documentation/ABI/stable/sysfs-driver-qaic:1: ERROR: Unexpected indentation. [docutils]
Documentation/ABI/stable/sysfs-driver-qaic:1: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
Documentation/ABI/stable/sysfs-driver-qaic:1: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]

These are caused by DMA Bridge channel (DBC) states list in sysfs ABI
docs. Format it as a table to fix them.

Fixes: f286066ed9df38 ("accel/qaic: Add DMA Bridge Channel(DBC) sysfs and uevents")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251110135038.29e96051@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/stable/sysfs-driver-qaic | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-qaic b/Documentation/ABI/stable/sysfs-driver-qaic
index e5876935e62b34..c767a93342b3c9 100644
--- a/Documentation/ABI/stable/sysfs-driver-qaic
+++ b/Documentation/ABI/stable/sysfs-driver-qaic
@@ -3,14 +3,17 @@ Date:		October 2025
 KernelVersion:	6.19
 Contact:	Jeff Hugo <jeff.hugo@oss.qualcomm.com>
 Description:	Represents the current state of DMA Bridge channel (DBC). Below are the possible
-		states,
-		IDLE (0) -		DBC is free and can be activated
-		ASSIGNED (1) -		DBC is activated and a workload is running on device
-		BEFORE_SHUTDOWN (2) -	Sub-system associated with this workload has crashed and
+		states:
+
+		===================	==========================================================
+		IDLE (0)		DBC is free and can be activated
+		ASSIGNED (1)		DBC is activated and a workload is running on device
+		BEFORE_SHUTDOWN (2)	Sub-system associated with this workload has crashed and
 					it will shutdown soon
-		AFTER_SHUTDOWN (3) -	Sub-system associated with this workload has crashed and
+		AFTER_SHUTDOWN (3)	Sub-system associated with this workload has crashed and
 					it has shutdown
-		BEFORE_POWER_UP (4) -	Sub-system associated with this workload is shutdown and
+		BEFORE_POWER_UP (4)	Sub-system associated with this workload is shutdown and
 					it will be powered up soon
-		AFTER_POWER_UP (5) -	Sub-system associated with this workload is now powered up
+		AFTER_POWER_UP (5)	Sub-system associated with this workload is now powered up
+		===================	==========================================================
 Users:		Any userspace application or clients interested in DBC state.
-- 
An old man doll... just what I always wanted! - Clara


