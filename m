Return-Path: <linux-kernel+bounces-804939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A95B48227
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18143179C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7645A1DFE26;
	Mon,  8 Sep 2025 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIiDF9d7"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527CF1CBEAA;
	Mon,  8 Sep 2025 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295237; cv=none; b=L2DlM3bl0e7dCR+iVxvHFOVYBdQeZIkCg5NoMoCM+FnJ4uNHl1ndaFkl7FLDzx90Wy4Q8eRHuLKnI/ybjXTMvcAZNPWhS3N9Q3e9X/8QLe6EhXAqYa20ONu6OaOa4t2dwm+H1JGNyy754PdO78YZiNu4lESbINmZ2atemeg4WaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295237; c=relaxed/simple;
	bh=UEw4F4LkD49VKclwQjDUiuUfQ+Jf1njAT51SLNuYO2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sI+50dOlwZPBU4t1NEcqsgmhd91yR+IaMPYrZ9vrwR8+1EaCv9vDdui9fSfMoXTxihJyr/jqCdt3zZ04aiv+vHo9OiIrDHd5SxXQRdLgxPbD1GPxpe7crPQna6Hvlm3TpPuCTjtmhQNsQgKcAHftsPsp8kXvQNg1cwz/C25Ud9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIiDF9d7; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-89e5b87f406so1110898241.0;
        Sun, 07 Sep 2025 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757295235; x=1757900035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIrWIgaPrpXvy15ltxr3y1zTh70BAC5HdpbmwVt7Qmg=;
        b=eIiDF9d7Js5TKifjRVLbnk9Jeg+A8sfSpnUgubHw8duzMiWJUi6Tgk47FbJ/RTUxSe
         9LrRBtzuW0YFXkjLWl9eO1iWHln54PDHPzl9yY+sYI3WR9mp//HTzmssx6NR5jn8+4DA
         kNk6VJkQ7aRX2TNPNmb/m8A4Jx+5aseU1INgkBO+vWA8zX3BChlBfjuE7aLGhGHWsQt6
         hl/XJLaCHlhSjcgNhS0BAaV+zcFNmUFO7ABkDxtWesLFA+ElQhqAvDNKT2u+lbkq2CI7
         ZKV5c9WzD23CaV4xRV0iU+KfgRXgJzDiCk9dHTrBQn5dLF8ubd4Cg7XOelRe4+zrX75d
         Hwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757295235; x=1757900035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIrWIgaPrpXvy15ltxr3y1zTh70BAC5HdpbmwVt7Qmg=;
        b=mtg5TFfsSBvd1uAN78AF0b8B4zC8TGv4Z42kRDOeib9M4MOG8jisiZa1hQGXf0EWvR
         CvdevxIaxyQZD6trtGzCt5riPm9QtdBR3u1rE2OTSFIsTJKOhsAiPiizjF/gNeC1K/AL
         MR8V9gMHDLs6g8jlILJUO4x+e4JH1yefKNfDM08Q5/uzLWJ7RRR3Ox9D3+ibsCoMIRhv
         9WzQzfXD3GjvDRiUKnDdoZtsPrcHvgHFYRBfwVeM+ahuhjPCQBZmpRDQ9ugr7iUTUnLr
         CpMYGqGwO7/sCZko2dClLK7si26Qf/yOC4Gh/CrcknVVf8zHw6dbWJsaRfmrGXuidkfL
         wWgg==
X-Forwarded-Encrypted: i=1; AJvYcCVfb6fOoru90DhLfUWwaEX7PQX/RdRJMKq+tVBjwHWJxUbDzmTNGv5YBPucvyN5Wi+epxler5JhyeVq@vger.kernel.org, AJvYcCW32LKWvbv3AcsTT+uiKoFujbgWawtqbWMyq6xFVjl/fIyJiGi6BJaNfvgT2oI6yG9PaRCgDbO+0o0F@vger.kernel.org, AJvYcCX6vMW5llvbWBZvT+TN+GgkYTcggPrjpn5yVe8+zkK+jy8+zss3uWusGAJVUS/pSDh17+volFr9h6KotkIS@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhHCf5RzaDcqwnIqKAmDMucrGLoF00rZUeKCg7Mp/zG2BDPdD
	P2Li5nHLGL7xQFLLE3vqoqEkKno9EP7TUARWvgMgc+51rztiCAWWoS5w
X-Gm-Gg: ASbGncuXDUqV2Nclt23idnvgnOnlGQtXQ7zJxB+PmNNj4clX1SqoWp9HMLTptoM/e2g
	pWYDTVASKorD4Hm1ozeL0yrOKAaQo7TYPAgg5BSLn+QhBJNJliKtsUg/1W16uSohEm4ma57e53P
	VGylX2i8jz2GhAj+svNrhBtJ4QtkYE4SaN/Jka51n5xnQDGA548upLCtV1c9XcfJhOx3a9ENg1W
	eYHTCTJ9rl1pOGPTCyRAMwhnPnOOKXZU2JSLUJsHnicXoWpWFJ03j7BlkYk3IpMaiQ0c8ziA2tb
	1OvXOLeQb8JUPTx8n6wiZ1xgBikAtcLcLRqP1J0Ke6VygDv2pqB0rmlC3ScE2yrZs1qqzHa9tfH
	+pSoMNgaYc0ErSoaDcVRUex31oWXaDfbXdEs=
X-Google-Smtp-Source: AGHT+IEbeqFub5fafpyfn6HTr2X2bHwT20HZdm5+VLYf04CK3V26R21QIYBuCRFCweDAvA15UXNRkg==
X-Received: by 2002:a05:6102:dd1:b0:525:33a9:c71 with SMTP id ada2fe7eead31-53d149b5dd8mr1068805137.24.1757295235164;
        Sun, 07 Sep 2025 18:33:55 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-899c47af508sm5857494241.11.2025.09.07.18.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:33:54 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 20:33:48 -0500
Subject: [PATCH v3 1/4] hwmon: (sht21) Documentation cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v3-1-bf846bd1534b@gmail.com>
References: <20250907-sht2x-v3-0-bf846bd1534b@gmail.com>
In-Reply-To: <20250907-sht2x-v3-0-bf846bd1534b@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=UEw4F4LkD49VKclwQjDUiuUfQ+Jf1njAT51SLNuYO2c=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7jOp9L904JPpET0Nl5uJvHPsY3nuw/NaOO3+5Tkl+7
 9mk/nq2jlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjIj1KGf4qlvYsbDjhOVBSd
 F6p3unrxzRIlJ+MlExKZ713JOGUcsoThf1K/K1Oi0HXvA6lrj5rcPuR3udVWm7vSI+t/xBX9vWa
 q3AA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Drop extra empty lines and organize sysfs entries in a table.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/hwmon/sht21.rst | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.rst
index 1bccc8e8aac8d3532ec17dcdbc6a172102877085..9f66cd51b45dc4b89ce757d2209445478de046cd 100644
--- a/Documentation/hwmon/sht21.rst
+++ b/Documentation/hwmon/sht21.rst
@@ -13,8 +13,6 @@ Supported chips:
 
     https://www.sensirion.com/file/datasheet_sht21
 
-
-
   * Sensirion SHT25
 
     Prefix: 'sht25'
@@ -25,8 +23,6 @@ Supported chips:
 
     https://www.sensirion.com/file/datasheet_sht25
 
-
-
 Author:
 
   Urs Fleisch <urs.fleisch@sensirion.com>
@@ -47,13 +43,11 @@ in the board setup code.
 sysfs-Interface
 ---------------
 
-temp1_input
-	- temperature input
-
-humidity1_input
-	- humidity input
-eic
-	- Electronic Identification Code
+=================== ============================================================
+temp1_input         Temperature input
+humidity1_input     Humidity input
+eic                 Electronic Identification Code
+=================== ============================================================
 
 Notes
 -----

-- 
2.51.0


