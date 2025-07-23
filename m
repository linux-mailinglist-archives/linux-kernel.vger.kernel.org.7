Return-Path: <linux-kernel+bounces-742658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 124F8B0F4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECCC47A32A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597082D3723;
	Wed, 23 Jul 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHD74sRX"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48823290BA2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279908; cv=none; b=VPLv2gVDBo+PauR+RQZOpbhihZogPDz47/me6Y6XOlXRTK4gFoYn9hXNLeYptcVb5LTKKk5905MdhUzPJHhZAsr4YY4yxxzMHS2X+en3zpxgAdlnzrFiHLhmww4T5k4bcxMd/dGPNuFPVJz15GwD3apLwjpQohhF0hca7sJXcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279908; c=relaxed/simple;
	bh=6zSWr6nH/KGpvlv/KyV5DDiEaTv3e7Cpp0KzZuxdtA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1XY+1sf3v/2GOs4XxztwgD5eIk5G5bS8PVEPXL7KIylkY0YFUYiG8GjHy8b3mpJ77F4MkJS9QnJmeEFVVJL+nym9p1C5KogyFal8phCEUtfe/errOTPQY7npDCvnszG2q7VdwMfV+13Di88VTRp+xcJEjzMklYYj/fER3Vx47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHD74sRX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4abc0a296f5so62182251cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753279906; x=1753884706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFy9TZzkAGxuZgNCwthN1QHzgVNATGxt3CHElfWCOUE=;
        b=GHD74sRXAn9TQ//pqct/eQxwg8VrXP4WDb8+vni03lUNBgSJrcb25VvVgmv9YKxMoG
         7n/vbt6Ww/cGeBjwAZ0IRKuHvR2WzOljKQFGQgia2p50euPXGy811qs3zXAReUDtWPAH
         kUKDZwPXUXCfyANgeMfOQj5GPXLNzmNFbTv+2pFJ2PYrR2QI5uFuFI49IYNGgBEOZ9bf
         XezYRjYNAlwx1Dcve2mm520OjYSQOVNoGPaR7LKvhgK6Syf0F+15Ctzk57zwXDIu0kwo
         GzFM4x1/VK0MlT4pMOF+BaVKoFoyF1dLgTdevFsLzh64xGTVC+viotQAvIy95xhyiMDZ
         i7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753279906; x=1753884706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFy9TZzkAGxuZgNCwthN1QHzgVNATGxt3CHElfWCOUE=;
        b=JAOrj/S7AU4+2IpegaIj83zwFebRhxHj/gqexq6Cng6iBPL89DvT2ik+ca1Teebz7n
         BbAeqcA/kNb59LsVnvc0q1uKIDz8m7De+/eU35/MYUozW1jHZI0m3Pg0oXdnPeCKZu9R
         an8MJA7eCL21vdzCvjNsisHyL42bS03bJy7YcwBKkzwkFMSUGWVbHOqxodovmhtKcdLr
         ubycdErfUWSsEYHbi6GG7xmYkAIH3n2mUb3EE6izAZrlYcOT7KmDeyA06uxvpaQa0Bax
         fM/Q6nDn2Lo1x5MnvO+LJd++VBVrp2qVzOwbpHmf2eU9eKGzY64Ha2WKFU8zvDkIhtA6
         /2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhKnKJRvKeYLRS/PVWLoCCzchSsb0+4SjgXPtaKTi1c1b+ecLyg43ednpwdTMlxfr4kszNdNMyAkrJtM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbo1Ixa4GQZco3vlzk3pim3IwidI7p/o8NwH6Sq6zavRoVwP2
	2yHCp0lG/2poerUUO59qGr1MCH1kTqj+G6Ssh4LVuyAa4qJ9/mroD82q
X-Gm-Gg: ASbGncvS2mkQlFYwq96S8swJFqCzcW2Y7mmkFdePKaf/tWXoFRT2pXSjPhrQpX8WcsR
	YMmOmdxGiHf0nKgeEOLOUAovB97DGd7fLo03v+43KsVfhwpBANr5DkwH/x6ZRE/UoRXiiZr2uwF
	XSsY8rOVvXMkcnwaqqdCGsFLgTfYBzeELbA+8pgQsCBGmCLO2/SyItMdL1klRIGVq34bCV7+My7
	q8Nl/1zedclQidAP+JcwkfhVr8mL6cu/e2/roWD5EHKGgQIRD+g7YacGmKzKgsRB2bkJZelh1q+
	1ssLEk+rxqRwIY209ScGBCJ+ZgRGIyLiD+p3gqz1ujek4ApxQxkIefKxy+oI2eXCBL7obi1eYtn
	18R6IgQ8M296oJU4v/ELdleMWoLVylVl23FhOFILb
X-Google-Smtp-Source: AGHT+IH43W6bPGs5N5EcarTgPDlTfCfxXYfTnuSltQofOhU7BqbBDkn0CR01Qt4bG9w0XwkLq6fLGA==
X-Received: by 2002:ac8:5948:0:b0:4ab:7358:1490 with SMTP id d75a77b69052e-4ae6dfd2d70mr42332001cf.51.1753279905366;
        Wed, 23 Jul 2025 07:11:45 -0700 (PDT)
Received: from localhost.localdomain ([142.126.85.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b204cdsm67352861cf.56.2025.07.23.07.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:11:45 -0700 (PDT)
From: Keenan Salandy <keenansalandy@gmail.com>
To: bleung@chromium.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Keenan Salandy <keenansalandy@gmail.com>
Subject: [PATCH] platform/chrome: Fix typo in CROS_USBPD_NOTIFY help text
Date: Wed, 23 Jul 2025 10:09:30 -0400
Message-ID: <20250723140930.1443-1-keenansalandy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the misspelling "platorms" to "platforms" in the help text
for the CROS_USBPD_NOTIFY Kconfig option.

Signed-off-by: Keenan Salandy <keenansalandy@gmail.com>
---
 drivers/platform/chrome/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 10941ac37305..2281d6dacc9b 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -286,7 +286,7 @@ config CROS_USBPD_NOTIFY
 	default MFD_CROS_EC_DEV
 	help
 	  If you say Y here, you get support for Type-C PD event notifications
-	  from the ChromeOS EC. On ACPI platorms this driver will bind to the
+	  from the ChromeOS EC. On ACPI platforms this driver will bind to the
 	  GOOG0003 ACPI device, and on platforms which don't have this device it
 	  will get initialized on ECs which support the feature
 	  EC_FEATURE_USB_PD.
-- 
2.49.0


