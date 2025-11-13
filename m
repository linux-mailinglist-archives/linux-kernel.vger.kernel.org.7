Return-Path: <linux-kernel+bounces-899171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67070C56F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8CAA344909
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92E335094;
	Thu, 13 Nov 2025 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2utlDgU"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03F22A80D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030750; cv=none; b=t7BcvAM91uL66+6NLALC5AucpV9XwcNFWskoP9allWXBQfuj3fVl6dp44FttjvpBezNhBE2iS01V71bBd7Rh7ZSzGEWR6XTkWxmoZ18qnD7z+Y11ic3pp7qJbr2gdngNzjreu7ggSqHkjqopKcnxyzgs9wX97b5bTV1Uk10yCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030750; c=relaxed/simple;
	bh=ckFH07UEJ/6Vn75EeCEfpSFArExjv65uHl/yV6y/LG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRAsy+7kvOczGl6vdgEJyNRDZNSXMxFtO0TD4F9ji8twjTxhqlTPt76Qe/O95DpW2+6JNyeLBzNg2pdLM1fl6GHSjeGghJ8fYtoDzMnRHF1KenqxKqzwcKeaLqfdthGIcrnbCRViwuu+MrfF7R9Uo7IyU+cLHOU0HUiTUl7lbZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2utlDgU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477770019e4so7942185e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030748; x=1763635548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nmpwq9Y4K1E48WXNTAOK6Thjd08PZ+n1dzKkwN85Vb0=;
        b=R2utlDgUr3sVQfp/bkdKtl9pHLWl0uSIf7o3JqLOzB27e0NiypZL73QVgi9eC21wkC
         3mJiNgq8dfO/wU6iAOwqz+naQVN5nlwT2Z6t7Ow0sfKpiX2ZxH8WMhJVqIF4iEvKl8EU
         lIZIaiwDFlKGEnZy+SD1eeCzkO7ROyTk9dMS6E6851QtNPA4y16++AKoWm1kTxe+5jF2
         qglxykYnl5xw1PEgfdA5s3xE/csl/ZzSMCnVfrpe+O5VXYWRBtxKDvS754zTfWMqFu8r
         Ycdx4IadK7gxWm1QsNkLspzALwpT2qQmDIz2itLU7FYgZrDEceOKv++WPoFFImzUz070
         V9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030748; x=1763635548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nmpwq9Y4K1E48WXNTAOK6Thjd08PZ+n1dzKkwN85Vb0=;
        b=hLR8jTtHWQgaA2yTGqWyRXBWXWD/K3MaDtYy1BI3OvIP+CRqZfgyRfBrFNxTHt+QoK
         /HLOID9K2hii40l1x+yMgRRLMaZ4QHnIvSfXqCQlglEezd45OHruV8ctkvGbaATGhNcw
         v5Rc6oY+OXhRtzmoBXR1tO8xW3xH+yPbftkyv+msNKlsKQe1RDXJVLqmHgqiXinw+ko4
         bu2C5G4Xds4tQM/eFnhpWash0sCtYZHErrc0eK7z/dvc1SGeF2yuOGE0y4IQ1drfQpwb
         uVQY7w8Zc0JHn1uFx2ogPelOf7UQbQzllDTKghoQvhnb6ZVhe+vBiNIm3qtW8qnWqnxF
         ckYA==
X-Forwarded-Encrypted: i=1; AJvYcCW3KDdELpLfTIz6zIKq1Dzyn/OIEQsZB9D4uJiOWXvVucbNPmdZHr5WOXm8RMIRZm7l25gkL8zB/fJ8EMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc53W89tFY7W0UDJ88Qi2DFiykGXlI5hDZxL62/p6c+AE5F7rB
	VaaGobNT6AoyUUBbb34IeCt2kszBmGWkcQj6iI4SXyqNVg8m5aA3EeaY
X-Gm-Gg: ASbGnct5Y3T1WTPPb2WF7nv85noOVAzgkqVyWF7ddJ8zmRNDFSAo67Mq/tKn558Pq2Y
	+yyouM//ugh1pqXBwClbXdUphqo9f+owzb3/0Y0cp6Hd3RF5dwIgMUcXBgIdTEbinYk16onIP4c
	dU8Y0VO//4rj/l33ixMmljADEyjs4dUKTtyRgSX/NIrUVGzqkGpH5IICdTiVYnxV9LIfrmP7xLV
	Ijw5nZTc/l0KXrIVQCLX963lJ65SwZtZ3wPOh4I1txf+gOTmRHrulvpDGZC6LvI/gIvmf0zja2k
	FUrw5kH6JGfuGX8P+lLrjMZShnDl9eYzKC3+p9C1t7pbTgNdKlPb44L3asv22t2Ip/hC5dvHS+h
	btCJ+XV1cI7BxZbLb01pIo0C32xcJ49OzT3wHkxM4wRY45EUOJAYGCj2nwqCgG8uV7UgoLEHH15
	GDtmHt09715MEYIBUs
X-Google-Smtp-Source: AGHT+IHSFATyH/pvqoLWDfUuQR+f8Hx0NgryuaxhpzBtpaYKgjM4VB/bvq8zZBEhr/Gx8I/1GLJeng==
X-Received: by 2002:a05:600c:3114:b0:471:1717:40f with SMTP id 5b1f17b1804b1-4778708e373mr56325895e9.22.1763030747572;
        Thu, 13 Nov 2025 02:45:47 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778f247821sm1444975e9.5.2025.11.13.02.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:45:47 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V3 1/6] staging: Remove gpib build from staging
Date: Thu, 13 Nov 2025 11:45:38 +0100
Message-ID: <20251113104543.5875-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113104543.5875-1-dpenkler@gmail.com>
References: <20251113104543.5875-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is no longer needed after the gpib drivers have been destaged.
Remove the gpib Kconfig menu and Makefile build rule.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/Kconfig  | 2 --
 drivers/staging/Makefile | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 075e775d3868..2f92cd698bef 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -48,6 +48,4 @@ source "drivers/staging/axis-fifo/Kconfig"
 
 source "drivers/staging/vme_user/Kconfig"
 
-source "drivers/staging/gpib/Kconfig"
-
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index e681e403509c..f5b8876aa536 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -13,4 +13,3 @@ obj-$(CONFIG_MOST)		+= most/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
-obj-$(CONFIG_GPIB)	 	+= gpib/
-- 
2.51.2


