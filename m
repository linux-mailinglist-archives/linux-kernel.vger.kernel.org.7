Return-Path: <linux-kernel+bounces-776941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF425B2D345
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9744A01153
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C9123D7EF;
	Wed, 20 Aug 2025 05:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBhwTnvE"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E91624C5;
	Wed, 20 Aug 2025 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755666270; cv=none; b=Zrh9z9GcXQ5+WJH3GD2kcy14L098HsegJLX4YUtoHGwA562PN1FFWQSGhjw6YfGp1siuR0ypxI85Ecz4pLfVocPDO/pmE7aHRgrTII+hum4v+X4E008uecT0On/+5XAUs++G+tHn/B7AE0PP2x/dEvO7YtO0+t3OThzIcmgaSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755666270; c=relaxed/simple;
	bh=+7oJt7mjiQ4+3wCASgTtlO0icWAOnyNJxoLTgl75GmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ie2MLqx+t2RpcE0di32Na9wT9P0BQaLIrhysPaSTkKLoOYkyOPNkaZMgUPVlvP+cODqDU51CzUStevcuqA/8pi6A1GcVDed7MX6i+bw71YgBM3+MEHX/Tj0Hc1KsPSkJQt/jMronrr4QwD/KbeiPkbGJUsLBqGui5gLQUnXBS1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBhwTnvE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso6948759b3a.3;
        Tue, 19 Aug 2025 22:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755666268; x=1756271068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp+M3jDgKcAwOCJY0Je+VMzGmNYc5XHm9kodmrDxfvM=;
        b=VBhwTnvEOQ29W7YOW1hWnQo9lfKDDMI7G3pi/v9o5envQV+wi4BOKWzaBDtLK6kRRC
         lFTwa2Wtoc8aZcHDcdK0rZXRo4u43FnEfIQzK1cpjvOOztUGSVvG4WDJh17xkQyIcr8m
         bCD9tHbtkZyPF+laJ3ilOiEGex9O2JiKMRahbhka/NaZ1vwTESpnX8xrjZR+SUKUfbFH
         ZT/r3AAVJKpm2FLFZyeivGzhY2DzQ8LvM0IoIbK22S7GY1azUnKtPOZgjkvvcDviT/AJ
         y+C0oUyd0IpYrLBPAxqH8z9uFfFpRQ/XXKrh+G+ldvIgLRIIEhiJ7WPWAhm77RS1w18E
         2+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755666268; x=1756271068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wp+M3jDgKcAwOCJY0Je+VMzGmNYc5XHm9kodmrDxfvM=;
        b=kxFqpWiPrCroKkp5/Llpb+NjOwsNG4cR3d5oAdgfW+6aWwA2PEaI21mjzdBHK+9cJo
         KhjdsFIEK89ATSaVRxbDfajKVOh6Bg0HmBE3ATweSIr3GcIsvGl7FGjsY9r5ygYASIFb
         PT3rWEOmdH+hLg/nY4ipoQ+0+4i6pqSSUbPThc5h04k9wg0b+9mNkZgxgsWN1CqQhoUb
         L+byt7SdvAAM/thgko4c+GYPv6ziCwUJo5ftf3lJKZFyJUY31fMGRsd9Xqg7W40AP/Qo
         B9OBuXlaTTRkOXKFRdz3lAA+tHO16HSIrMahrhINjwipkGTOlRZavR0WDdDEiWsUG4YT
         k9ag==
X-Forwarded-Encrypted: i=1; AJvYcCUGAy4haMmts5i+cKLt03zgTAPqiAmsJd0sK6J3GFpeqqcA8ZE0RvyjKCdifuROItsrov5fZvtAxto=@vger.kernel.org, AJvYcCXfyGbCbOXAdWBZAt9aV8ldQD0EIoS7J8oXkGRno+hrZe7ebInLzs4I+BRTNjsGDsuzySmt2GaaYKKS@vger.kernel.org
X-Gm-Message-State: AOJu0YwKz8F/xanxflM4TTD653uxwD78MeYghWH06Nb6SApE9jNLvAZI
	2uz7lg1TIzBcNJZSLypfN8fepjValWIt5EdrPlwgxHkSW+iTWaQtjrcZ
X-Gm-Gg: ASbGnct5+irEHxTYrrnpRpwEawOkn7GAFWDp3aWzuSjRGPGqxKcB/j7L2zolHu52RrM
	iBkSoUnC3O0HD1Y2s+6g/+tqnKWl1QZgbZpyYR9s9tz76fYBor/wsYL2ePV4iLH9OwSAW6JecHS
	OokewWX7typTVUw9UpT0afckziaSLmmE20B0yRMx+Lm1OHolEYRjrJzayCEghx62gesMA/usmHr
	yvLV4P603OM2K6nCbEKA8XqFdhBdzP/vmtX9nBVRBqrxpkoKZ5EpRUrIG8P/SMJDG7wx1tvU1ci
	B0InsHU10uHEMD0xlS5P80hCw7Y3KFz1mZ7l75cOWqL9RZs/RldG/XEx1zdlMSQtb23KUZYPZDF
	nL8zP29TNLCH3HJBLtE1jew==
X-Google-Smtp-Source: AGHT+IGM6VmwAFXdTYm7N3HTPpLGOkcKrTt5LmW3c0AzShObnErMBHLDonybFzMhQ7ASLye6YmS+Kg==
X-Received: by 2002:a05:6a20:3ca3:b0:243:78a:82a9 with SMTP id adf61e73a8af0-2431ba80a37mr3263180637.49.1755666268046;
        Tue, 19 Aug 2025 22:04:28 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3244235e3edsm1761166a91.3.2025.08.19.22.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 22:04:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B14FC42B408B; Wed, 20 Aug 2025 12:04:24 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux USB <linux-usb@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: driver-api: usb: Limit toctree depth
Date: Wed, 20 Aug 2025 12:04:16 +0700
Message-ID: <20250820050416.25219-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=bagasdotme@gmail.com; h=from:subject; bh=+7oJt7mjiQ4+3wCASgTtlO0icWAOnyNJxoLTgl75GmQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlLw9QeN+7xCL3pFOZy4ZEJr58C786InkXv37yWkBdZH xT8a4pMRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACaS5MrIcDz/1WTZJcfrgx4/ eKs39dO8xSfVNsfoS+9+MvHszsDQHG1GhlWJL5keF7M5cDctKJI8tslRpIbbZaqkz65nloum5Bd b8gEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

toctree index in USB driver api docs currently spoils the entire docs
headings due to lack of :maxdepth: option. Add the option to limit
toctree depth to 1, mirroring usb subsystem docs in
Documentation/usb/index.rst.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/usb/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/driver-api/usb/index.rst b/Documentation/driver-api/usb/index.rst
index cfa8797ea6144b..fcb24d0500d91d 100644
--- a/Documentation/driver-api/usb/index.rst
+++ b/Documentation/driver-api/usb/index.rst
@@ -3,6 +3,7 @@ Linux USB API
 =============
 
 .. toctree::
+   :maxdepth: 1
 
    usb
    gadget

base-commit: 37c52167b007d9d0bb8c5ed53dd6efc4969a1356
-- 
An old man doll... just what I always wanted! - Clara


