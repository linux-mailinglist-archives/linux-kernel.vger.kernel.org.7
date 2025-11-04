Return-Path: <linux-kernel+bounces-883974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B7EC2EF56
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E853A72F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ADD23EA8C;
	Tue,  4 Nov 2025 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+gXlu4a"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276561DB13A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222989; cv=none; b=PjhFd0FJHqshd8yo57QV1pPfutpRlTfSJQUZZWqTg0NU6DoFE+gd8VX4nSnXTx/UCBxzuAwmcBaBqz/UDe/0BdsfY+6ddGlkqMXZ1AaSfmlnC2ikfRNxn2G9wAUruv3L47y3O2U5OAxUFnDw5mz80nFjddYwuuxs+1zIDvq0Hmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222989; c=relaxed/simple;
	bh=eCLzlFPaLSvLqLxXZ5mRBpzn22+x40x3Y0NMv6gFw1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWNhxjcggq3XIRhMboI3aziM4wWKcx4Q/5/XfeDM2q/FTTcJkU5y6mWlz3myeFbo8JSv2n0LwBwl+dFGB4Yy3UMgty7oUbWS7quZxzKmHgphIoh9z3Sq67fuqYOIg45ii7IcJjayRObQFTSRXl2QK+1HVeoLeN1aVQ0IekB1CIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+gXlu4a; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781010ff051so4083743b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 18:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762222987; x=1762827787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUNivpaoNg5y7SD12fYPhASBZjYUtqUtVFH5sTI+ugM=;
        b=C+gXlu4apB4wOePxwvLbvRI6K58ItydQe9f6OvIb3gVe4pypdJJdRNBsIz5H5ocds3
         QCZKwKcene5W09X+JUZ5fDUiGA2avPYVwTdDYvu4N/x5dZa0vu+/s9tVwDLazxVVOutF
         3VlOdy616wZ8piGIPy3Yxw+rjxkaVBkKLXUA3DfHIqXa0qCbBmqP+j/HO0C+JG5uKUCe
         5dQfcHbYRHX24LdhQ/1K6KmNfNTaEz/d0kuVkkAShNY+PJCHekqyQDPh71L+N95N7DGq
         OR6T9sn7+NRnnuf7d8Ezh7LMYAuYBqon+kM1xQDQAdO3WH5roAn8P1fGjcE/vuTPjdTC
         UHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762222987; x=1762827787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUNivpaoNg5y7SD12fYPhASBZjYUtqUtVFH5sTI+ugM=;
        b=FbOdkW7SrgjycGHeZO2XvMJw5Z/k2+HFUN2M/bW3cf20TDZVcmuWD6HlK0cYjSZfA5
         yOSzFU3WeKQ0k4Kzd1W9HMfWQBizqTlG796yjAC1yGM5qWNLzl4ZjLFx+LsEyjeLGer4
         0VrM+fB9W3PdITwST80fSO4+z3oM0psYx8X0KKEVN71Xvg5BscJI8lYQ/fi7xNYY8ZJw
         0PtVFybmRA3YDmq7UMh9ZzoJLjFg58KnFkVuhKVBr4ek70KWImtx2oqVjNN67gXY4W2D
         PsQNS4Z9JokOZAcOwF3Nd4x0HQ2F3BoCnRwvS12OK25LE91MS7xamiucmY1y0iaN9Xa2
         ilNA==
X-Gm-Message-State: AOJu0YwF2bbRsD/APBx2SEb7WlYPjnn8Zh0xmMrIEIh+SWYwwMy+uXZv
	Cye92BwUkaF57h8BC+/sW68azUk8k8dxoS3txbhW8nbGXtvzOtBeLege
X-Gm-Gg: ASbGncviYqjeWjPj2FkRFTkA2sg4zMyu7gyo8pFz4BPuHXW3l+CdQgsXXnQoJQvLsdK
	3jVngCvzaQEiOHIVwT84IBuKrytruDj2AIgM+4Wyj/RahwUzoz3NbM/BNiaZXVlgixKznZ+BAPG
	5DH38afUmjivPk5yK9rPSyk7KU6xgOvbZCLdvvDyZNM/xbw7zOAWWPa3sKFNH0YVIK54dchRn4O
	7fHYhy2Vl7SPAkuPE8Dk505WHsrRbJ4eL+MRmcGDtnibXJVZ/J/v2G92FSuWW8uLCLMg6mY4/f7
	c+TwGZhKvZ1Mk8akN9vxhwx/U14Q/4HpaqZxiG+NF6ysUsLOouE/RZsUOG1jH+f8TruaH5KKW6i
	K2rh2cBuVy1WqFLuoIoZ6Dbda8aFfFFTIfvgwW2m19HKKN6U9Yk1VqaEFjtxaIjYzA1DVW1fLlO
	VtM29Nd6EJzfM=
X-Google-Smtp-Source: AGHT+IGtaT4nbrH/vsm+W0H/MgZf84Wbl/w652bwjzVWrm82zm/wubl6T4br7d+kv1IczEaMxgwPyw==
X-Received: by 2002:a05:6300:218c:b0:342:bd5d:2c62 with SMTP id adf61e73a8af0-348cbda98acmr21110239637.29.1762222987383;
        Mon, 03 Nov 2025 18:23:07 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a614asm541798a12.32.2025.11.03.18.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 18:23:06 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 2C2E9420A6B9; Tue, 04 Nov 2025 09:23:01 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Srujana Challa <schalla@marvell.com>,
	Julien Panis <jpanis@baylibre.com>
Subject: [PATCH] Documentation: misc-devices: Fix C macro cross-reference syntax
Date: Tue,  4 Nov 2025 09:22:42 +0700
Message-ID: <20251104022242.19224-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2887; i=bagasdotme@gmail.com; h=from:subject; bh=eCLzlFPaLSvLqLxXZ5mRBpzn22+x40x3Y0NMv6gFw1E=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmcSX+2ifB2xboIXtPKO9HHzmAvZmPbWXJT2VIsxUJJx pUz16ujhIVBjItBVkyRZVIiX9PpXUYiF9rXOsLMYWUCGcLAxSkAE6lWYGTYs2YF179OZ7mpm/T/ fFCoebsw9oX8idUrz2/R9fp47qmzM8OP1w8/sFzd2iS7SObBj9hFW1OuPHa6bzRVgPtL1euD/w7 yAQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Macro references in Octeon CN10K and TI TPS6954 docs are erroneously
written using :c:macro:: (double colon) rather than :c:macro: (single
colon), making these rendered in htmldocs output as italics with
verbatim roles. Correct them.

Fixes: 5f67eef6dff394 ("misc: mrvl-cn10k-dpi: add Octeon CN10K DPI administrative driver")
Fixes: dce548889650c1 ("Documentation: Add TI TPS6594 PFSM")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/misc-devices/mrvl_cn10k_dpi.rst |  4 ++--
 Documentation/misc-devices/tps6594-pfsm.rst   | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/misc-devices/mrvl_cn10k_dpi.rst b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
index a75e372723d860..fa9b8cd6806f14 100644
--- a/Documentation/misc-devices/mrvl_cn10k_dpi.rst
+++ b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
@@ -33,12 +33,12 @@ drivers/misc/mrvl_cn10k_dpi.c
 Driver IOCTLs
 =============
 
-:c:macro::`DPI_MPS_MRRS_CFG`
+:c:macro:`DPI_MPS_MRRS_CFG`
 ioctl that sets max payload size & max read request size parameters of
 a pem port to which DMA engines are wired.
 
 
-:c:macro::`DPI_ENGINE_CFG`
+:c:macro:`DPI_ENGINE_CFG`
 ioctl that sets DMA engine's fifo sizes & max outstanding load request
 thresholds.
 
diff --git a/Documentation/misc-devices/tps6594-pfsm.rst b/Documentation/misc-devices/tps6594-pfsm.rst
index 4ada37ccdcbae8..5f17a4fd9579ea 100644
--- a/Documentation/misc-devices/tps6594-pfsm.rst
+++ b/Documentation/misc-devices/tps6594-pfsm.rst
@@ -39,28 +39,28 @@ include/uapi/linux/tps6594_pfsm.h
 Driver IOCTLs
 =============
 
-:c:macro::`PMIC_GOTO_STANDBY`
+:c:macro:`PMIC_GOTO_STANDBY`
 All device resources are powered down. The processor is off, and
 no voltage domains are energized.
 
-:c:macro::`PMIC_GOTO_LP_STANDBY`
+:c:macro:`PMIC_GOTO_LP_STANDBY`
 The digital and analog functions of the PMIC, which are not
 required to be always-on, are turned off (low-power).
 
-:c:macro::`PMIC_UPDATE_PGM`
+:c:macro:`PMIC_UPDATE_PGM`
 Triggers a firmware update.
 
-:c:macro::`PMIC_SET_ACTIVE_STATE`
+:c:macro:`PMIC_SET_ACTIVE_STATE`
 One of the operational modes.
 The PMICs are fully functional and supply power to all PDN loads.
 All voltage domains are energized in both MCU and Main processor
 sections.
 
-:c:macro::`PMIC_SET_MCU_ONLY_STATE`
+:c:macro:`PMIC_SET_MCU_ONLY_STATE`
 One of the operational modes.
 Only the power resources assigned to the MCU Safety Island are on.
 
-:c:macro::`PMIC_SET_RETENTION_STATE`
+:c:macro:`PMIC_SET_RETENTION_STATE`
 One of the operational modes.
 Depending on the triggers set, some DDR/GPIO voltage domains can
 remain energized, while all other domains are off to minimize

base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
-- 
An old man doll... just what I always wanted! - Clara


