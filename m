Return-Path: <linux-kernel+bounces-895037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79AC4CBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02612188C775
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309DA2F60DA;
	Tue, 11 Nov 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azMNHuBg"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA32F49F5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854339; cv=none; b=QXDb076HWEDF//lqYXynGFMfUW6GfMVQfJ2xaLnTNSqwBW2oYJ98/x42CczfIi/nrZ5oJqG0F04ce09oJSECrT5Url9eJi0dahXwL0/PtWklogRtjPhPFMkmQSQf9OJTWh220/zCZQkO7EFMAPSuvFguFIxn5PaesuWCt6/mZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854339; c=relaxed/simple;
	bh=+XnCO9qejTe4ztQ5le1uNUFmPXCcBG6FCCQyy4ErpsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJcToeVPch2hh/gCGm3g+h7VTJGgT/xp5WXR9imH0O3GrT848vtd4vfAtbeaCPk0m8DRwSI9gOhldavDH632KvnYr3Q/L9uNn2llMgxZVMjOGR6iafcQuqCabaEtzaLMxkpPeC7ruW9PlYWl9ykXbDhygmvxpPqhTgqdAUh27fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azMNHuBg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471191ac79dso41149075e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854336; x=1763459136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCSGnpbgz0bliYKvoZoaZD9Q232D8JPebeahtnpVkpQ=;
        b=azMNHuBgIgo/ExxWmbx9xOKSPikXWhSx88qlmnnUFxywc0uj0Wp8Mc+m9wpAEmiJ8W
         27dxHhH73vwi1NpKVR7yz6wSP+Rx2aNLKiL1ldDhvwgqm3MTlgkA8CcpavjsYOnWzyOc
         FPd10bx0kD+ap/j4uoBgMy70LQl2CIVkTkKddEXRXk4Ijjrgk58zgD4sl1OrN+bx0uqz
         VLRhisAmiowruGzqksIOsYAl0o7YwrC7E2GknqbEXdW2R7MbtsyoMsRWvLMCaaxuoSWN
         hCvtwLMP/FyBS4TNNrMnO3q4oo0XcW6WB4eVm8chATWUeVBWYzgq/Kb4sffE9TF8ceSe
         7ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854336; x=1763459136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCSGnpbgz0bliYKvoZoaZD9Q232D8JPebeahtnpVkpQ=;
        b=C2lST9WjlMdRbpc7sbf4YhCswBfvuDHNcl9I05GqgvnjplJHyHV6cecUtllkLd1s1K
         hUKXfryRSQnnQGAAQK9KxEC+tv1ROKD5y4IiVrpXDjyxVcAViDIadIq5a9j/S2X576S6
         NYqM9/2jP0Icvx46enWELZv/R/z3s51D6dOnuGTT+pJlSS7+JgD+Omi5gEcE1BC/ZUVT
         3Afoh/kxUBYULbwgGsftDPh0GyLvrc1UW2hUY2+YD6Bzo/tv01ViwGSPws3ryVWDHrow
         piWIZq5Cr5iB+me147Qt7JZT+fkr+6jTo4BSDp8HYc0ZjhcQqnk2m/GbJUOzdBW4qOf2
         rA0g==
X-Forwarded-Encrypted: i=1; AJvYcCUced6NeL7pcCPE/fmO4+KB4kS71TH0jd/ZJ3/MaXIz8FNLJ2DhGt8IHlRUhCsgupLgna5v1uwjJOMQl70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz576C/FGkcaaRudz8cln0H0B2lftTqFJJRBuNvdPDVTMlO3sk
	peYCLuujp9IIOwXcBAaMMi0mX3Je+LEmGTULPWMc4LwsMqfSfyLp6nVD
X-Gm-Gg: ASbGnctXw3M0V+LKxULqh7c8Z8Yc9qirxaa9eB+MP5cn8qaOnHxb+dpuZRAWs5+p8zE
	amwQNWfZ+PqIx3r6dRphmW4E6RHP5skql3qqy1ADk96Yqutml4Lywd/4wvB9BHx+kk4g9UC2g4p
	RGwD8V4Z5B2dKv7zYLiIiphgaAB4UReyZxsIKKHyGbT+hckRNocsmNZa+k83HHKpN2/MaqU5tF4
	mHSZPNxFxu4hkylOJwx8a8MRHqwRtWkx6DZZXxolMidsd2cTpA7DgwqbVNqUkfFJogTE8dpZcZB
	/QSZ/+mnsRrNg1GIChFudj+XtH9bTQV46Bjlcz1OHXMW5YdsbDlNJXQcAmJ77NN4mQgriwXDplX
	86sOm8BOz030WrF0SOfOODf/ANdXgPFQPVy12SeVxQTSXfRL7zxjemOAzl0lOzr+8kdo1W35VRi
	Q2Fk17OJQQM0vjxRKUGk+PfyKI4iQ=
X-Google-Smtp-Source: AGHT+IFMwBYwj8RzHSh4woU0eevledo4c8hN1mPiW76L581g+wR11bGflC1/9eoKimvmIw7JWJyzbA==
X-Received: by 2002:a05:600c:1d1c:b0:471:115e:624b with SMTP id 5b1f17b1804b1-4777323ec6dmr96147085e9.17.1762854335978;
        Tue, 11 Nov 2025 01:45:35 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:35 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 06/10] staging: gpib: Fix SPDX license for gpib headers
Date: Tue, 11 Nov 2025 10:45:08 +0100
Message-ID: <20251111094512.6411-7-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
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


