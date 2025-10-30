Return-Path: <linux-kernel+bounces-879249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AE6C22A41
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAAD42493C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44B33BBC2;
	Thu, 30 Oct 2025 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFe85QEO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D095331A6F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865486; cv=none; b=gkC6v+mTBo7WR4SxfgYsvVbtdO4PFN8aTqGc9U02OH/x0xrV32cLQdlPPjqC2s3lILWrt9OHlnM217ycWZa1v6QsGKYcdtH+cuKpL/Y5WomSUEkC6spNQb0crLWwc5NFODDPHCSbx9nw9zOmHUtW8g60UKHKFw1E4bpKf07ZFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865486; c=relaxed/simple;
	bh=TcMYHxAFSNQU8rzO3HWwSoxbbFQbT4iycTi1gAH8IEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ockGbMe30giP9iUyo9Ze1ndTqTQg4ghVOHzthnsOzNXMDQdrIE2lniovdEg/vzFj5La3MzYGZSApPTWU4Rd80R42vQeZwn6S7HqQ9DeXMpIOWZUG1Eu5jGThFFv0YoUOic4lz7CnBUwkoAlOOx2YYckPNm9LqreO3oPTjMTrfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFe85QEO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so13152575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761865482; x=1762470282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dA6vbryG5FJTzOnmpJ+a7K24uQqVYeU0GUEiTTytsg=;
        b=dFe85QEOSl3jtD3G7PswmMfTRB2yrzqMTqWNikM0M6wJQMF91pl6Z6zPShcpA2JLYk
         g4W7EhlUJfGLSexdIgJz19loNHRBzETU/PzPCDnkLopIvqOmY3ptXFd7LxdjlVGpBOUu
         vQJKaYN449gs5Lmm2tqFvTfLQadWn4AlQopsmN51oOPrkCkU3EwWPfpEaxp5HlCNx9cl
         PXtBo9ysilbe19vL3EwH/YrfSQouDJ7yB3w4CAiTD6Dz7g0HepQOLq+6zkGOlquT8hKa
         z699BKnK/H5ekeg2pPN6j7zUEX7nM8E3rsVCZFpbPJX3kpyq8si3P9/4QELeYc9idSk4
         1o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761865482; x=1762470282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dA6vbryG5FJTzOnmpJ+a7K24uQqVYeU0GUEiTTytsg=;
        b=o9kLYn7Lj2HMJD/3NkeE0HpUAlTLzICa8MVJOIK4Og8kR/ZR51QeOzQdsHLpPhLXTQ
         ESSpfz0ujokbqxNYK7wUPmDQVeRaeWrvKs+niYtk7+BalQXfd/6Owm4In1Wi1bdVVJJD
         YNgVMaEKz66wMJnfuOBLMs0iNNDid6nxTOk+oPHCivIXWleGfhgThC7DAkVtdUF2uTms
         LF0256Zq2a1LkpY2uFw7gkFHVRjVWP0HKqefs6kuGgxT2ZawkHFvKadG9nrUcU1wiZdM
         t1/jsKSFc/BuYNQJrrv5e1Oe5PT5BtYWWraMyjNWN/pDLRkdyMZD9QgcflhILFMKYUeF
         8qtw==
X-Gm-Message-State: AOJu0YzrxbEm97OkWillFkT2GBHoZEmy3EKZ8zsCBKk6C3kl+ltK7oYs
	q8eJr/o72AJRMCti9n+2ziMGjHWBRGrrbY6/87nuplksD8DmW5OzJypsXgaKb5v8
X-Gm-Gg: ASbGncvf8XUB9rwiURpy2vHNR+k1C3ieBCEZdKSzzuFVEoh+K+GM3v2fJDyTKyx5UoK
	FJHDkk6XbhkaH+XSmApdCT4Qd5hgSo8Sj2yfEFjLo0iEl1o6YR6NWX3ARRT1ODsPWOYozkBUdI2
	QC6W5uGzoqQ7cl0gwDLQOPgeZaP7+OXI/r70Q09XON2wPshdD7QRHfDqIFjg9XChOpL22+MTX8j
	3nSxLl+ne+Ckz4zRCE6Yf9jpzteD9dM+ToUybCdC/J0X+78uXlTS2TxmqGOP0ZoDng/61K9pmyN
	gkw1VuihHkiiEfDUaRb8h2SRn4M12ClApKZGG5jQT/DLLVV/jSeAV62sOKFPe32DYtB7SPIS0kO
	+5P0AL61C8zLkQ442WOYw/Pl1zDvdi8VO7ecLp5as9NrFkQcNSybPz+uTeGJkZtLdxpuav3iLwo
	kTDDSEERLKbSxaBuvg2nW4KA==
X-Google-Smtp-Source: AGHT+IGyCOmFhRjPi1dA9EmPXnKmiW9faJgiGLkzd27O/GNIxvB0MswqzLd3bUuGjgqJLB4E+1ldgQ==
X-Received: by 2002:a05:600c:1c1d:b0:46e:39e1:fc27 with SMTP id 5b1f17b1804b1-477307d740cmr11913775e9.5.1761865481989;
        Thu, 30 Oct 2025 16:04:41 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff8235sm2227025e9.14.2025.10.30.16.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:04:39 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v3 5/5] drm/nouveau/drm: Bump the driver version to 1.4.1 to report new features
Date: Fri, 31 Oct 2025 01:03:57 +0200
Message-ID: <20251030230357.45070-6-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com>
References: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW can only do compression on large and huge pages, and enabling it on
4K pages leads to a MMU fault. Compression also needs kernel support for
handling the compressed kinds and managing the compression tags.

This increments the nouveau version number which allows NVK to enable it
only when the kernel actually supports both features and avoid breaking
the system if a newer mesa version is paired with an older kernel version.

For the associated userspace MR, please see !36450:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 55abc510067b..e5de4367e2cc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -10,7 +10,7 @@
 
 #define DRIVER_MAJOR		1
 #define DRIVER_MINOR		4
-#define DRIVER_PATCHLEVEL	0
+#define DRIVER_PATCHLEVEL	1
 
 /*
  * 1.1.1:
@@ -35,6 +35,8 @@
  *        programs that get directly linked with NVKM.
  * 1.3.1:
  *      - implemented limited ABI16/NVIF interop
+ * 1.4.1:
+ *      - add variable page sizes and compression for Turing+
  */
 
 #include <linux/notifier.h>
-- 
2.51.1


