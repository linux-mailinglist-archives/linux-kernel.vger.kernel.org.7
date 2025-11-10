Return-Path: <linux-kernel+bounces-892838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D42C45ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAB03B6D25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C130BF6A;
	Mon, 10 Nov 2025 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb/3vwDw"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C730BF65
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770331; cv=none; b=INqfuwrS6CKyxVfZl9YpkA1vgiKzJ5Jh6A9beaGkpRiCmZ/KFopdqa/w8WXlHicdVxrlXjbjyt9AJ6lbVVkR0QpW7esOfwibm2S1nUNDGmzQ0ygE3tKi97ZnMLLz/q5sq3SlT/m+RfFl8DXxjT+pHyY1Rg0f28zcnxBxaBiTVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770331; c=relaxed/simple;
	bh=+XnCO9qejTe4ztQ5le1uNUFmPXCcBG6FCCQyy4ErpsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+G4KzZhWiFbJpJZ3iUwGzD3S7qJmMt0luMIOwhU9CehYPaT0hseXYcWf8om194NkwXCynTEupmEOFQ4mQb248Zu9HcfwbJIoXLCoiOf5eiovcRwfwibZmajcoIuYCEpV4VdCDiMW8cZjgzfR7hPoZlKAcavL7TlF0cBodL+hHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb/3vwDw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47778704516so5123065e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770328; x=1763375128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCSGnpbgz0bliYKvoZoaZD9Q232D8JPebeahtnpVkpQ=;
        b=Bb/3vwDwweCEGafZWcqE47BJIWst3pJBx92bDdkmK1K8QJEEgUmPgN5lm/ZeU/HTnB
         b8tNnSxelF32aLYFIQuTI+BChoYtMTgh1WVnLDvpj3e4eVAXARGn8IBAWga8990D1+Tb
         H37HqMkld33LGWp49f2L521CUloE/l9X6DahaLaxGzkV9YNDdXkbRTICeo2ynqBvxSPm
         sWl0zptVwg7RZ5BnZUqSIJnH+0tX9na9Yxx/41IOzKEmsKAfr0HTPF43rQxCxpP5hrlc
         sTVz+LSFdZpWoB+nXIi1YY9ngBRBy9hs/S5rPV7z5OF1gfTf5f+eisBp3TJzvWEJqGT/
         Qmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770328; x=1763375128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCSGnpbgz0bliYKvoZoaZD9Q232D8JPebeahtnpVkpQ=;
        b=ZmaxMwp4vAea+HyYEoVu1ZncLDrGUG1KHJC+NJcUZ0T/lUw06fCD6/nv7NJ8q6n1y2
         mMEoTMyxwVWMvudgai4lt26zqqEagHWGDhncQYL0BNS95g2Na1vnsLuMFkp6GFCcgj5v
         V2fRAr7UJjicyvcv3mXY395/7AgfPKULOQGqVRGiU/y9lozdm3TIjAUgK1NEHURf8TDx
         /fQb4M3imjVUm4hcb0EYibDmedUBS5JJiUaN+X90Bwtjnu9eegC9Aw+5EyzdLiAdrSJx
         vuERTEIsi3YYC9bzIZuku6z9fzkdb7lLHKd3+N3cBGXHbWwoFjTFTDBKpSXlEla+xVv8
         WmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIIuAzvucPykXRTCzPCHzM+hjraxBo45u+4HJOqZlicx0g5BbI7zj7k0Oz5YzabIWonJDNHfg7SvbENok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7bC/uMPPk5T7oiBBIKP9QlyFVE8kuK6c34KEhOAYxLR1vYTs
	LPEev/u2azRSvfvSVc0+Zy0vhsgrAJ/s2GG3D9s3fHmXRQpZjsR/tabm
X-Gm-Gg: ASbGncvgXHaLRx2mTYSpJPEUuHTeCES2hZgNwbf4uUCsrfcCA/3nOq6YolGqOIkYNAO
	btS+FdYl7y78tNICy5SMD/EXDLBHnXB6H67dttJXc3lNdeR4Wg+GXELOe2zEpB6q5/WG8KwWfyN
	IyvHROpLkByZ5x18jHNZFRUI0/08HVp7dDKyq2qJ7zrTVMvA89coWrCBTjQUp+vZdn5aVR1S8Lu
	JU3bEqijjIHuEx5j+bxmRhFpku84g120gIr6lXdmSSLVIShSp/P6rgq8ush3ffQSmuywYbGWfuI
	tRfyoqkwj/SzpNf4MADGJpHmdSOJYdzhQE2DIJ/jNeqNskuHS3ueRCL92QOOQyV38wo1hKAhIB6
	6gOAHv9KyiRAUJ3BFbgtDNnEiNduKU08cNkHaEO2Q/+IRP3mphUCuKWYDb2jTx2RF+j1Dw3l1wV
	WgJVGE8tfGSGw9caJ9
X-Google-Smtp-Source: AGHT+IFQWYggozTgEs5FML4i05VMRBmgOOAruw2bEdH14yVGLRrDIfa5y2DG/WtVEIJXHugLGIkeOQ==
X-Received: by 2002:a05:600c:3105:b0:477:1622:7f78 with SMTP id 5b1f17b1804b1-47773293fd4mr61805175e9.40.1762770327949;
        Mon, 10 Nov 2025 02:25:27 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:27 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 07/11] staging: gpib: Fix SPDX license for gpib headers
Date: Mon, 10 Nov 2025 11:25:03 +0100
Message-ID: <20251110102507.1445-8-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110102507.1445-1-dpenkler@gmail.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part destaging the gpib drivers we need to add the
WITH Linux-syscall-note to the SPDX license in the gpib
common includes as these will be part of the kernel headers.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/uapi/gpib.h       | 2 +-
 drivers/staging/gpib/uapi/gpib_ioctl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/uapi/gpib.h b/drivers/staging/gpib/uapi/gpib.h
index ddf82a4d989f..2a7f5eeb9777 100644
--- a/drivers/staging/gpib/uapi/gpib.h
+++ b/drivers/staging/gpib/uapi/gpib.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
 /***************************************************************************
  *    copyright		   : (C) 2002 by Frank Mori Hess
diff --git a/drivers/staging/gpib/uapi/gpib_ioctl.h b/drivers/staging/gpib/uapi/gpib_ioctl.h
index 55bf5e55507a..50bb6e251e45 100644
--- a/drivers/staging/gpib/uapi/gpib_ioctl.h
+++ b/drivers/staging/gpib/uapi/gpib_ioctl.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
 /***************************************************************************
  *    copyright            : (C) 2002 by Frank Mori Hess
-- 
2.51.2


