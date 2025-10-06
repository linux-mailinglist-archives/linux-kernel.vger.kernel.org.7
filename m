Return-Path: <linux-kernel+bounces-843388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237AFBBF14A
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87E0189AA23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E4253355;
	Mon,  6 Oct 2025 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS5rdk6C"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB42DF12E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778071; cv=none; b=MQoP42susQSF2V9NH+lEeGE9Kkm9BDzTnhbxX2yETLkIOv7rAnMPVBvCMtW0PjWynoxy26uzOM+aJu1UNBwsHROGIVMmvYXqwYmhSBi2Yri40I4gS35jkOw77VgIReK7kM0TsMhiplTkg45ypna/0PIu75xDv10m+na6ubOgRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778071; c=relaxed/simple;
	bh=drAafvzz1pDZDG8f4ieZYxlF0QAwe5Jk7b+PINMyv8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0gD5saBDBEU1MR2x6s0Ib2nx1SJMDOnmIuuHnr1XobVwCu45oA9k3afglKaHncyMf87yfgFBuGFmSI52Aces7z1M4VD1S/oOJB+Ts1ENyNjFI+snGD8jHDPMI+CRf309w0ZMseWu77AW8aZYD5RyFPp7wZIyf7rlSNo/H59zVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS5rdk6C; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42420c7de22so2986273f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759778067; x=1760382867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMtkl73qHUTB2Otzy8qJpuGWoZM+8mVXxqiE2cfrzu8=;
        b=TS5rdk6CL2Ly+KN2AmI2KwS/sciwWsgldDADj5vFD4ljHoZbeu0LJAcWsVug6g7/q+
         1+Y6zZSpUTurhcUBs0vnN2xKWEb0LM8gfcm63VZHvT4yvmOa8xWETflijTXcGtkzXIIg
         5cmFuRR0TSojrKUARZE1P6NZC01vBpr6PojHyLyHBZhTUbS3knFvlXdyK6c8Iq1cWPgI
         DDR3CSiFQ8HXxqESzIBnT/FFu2JjzMg5e874920OlDtwAbjuRrxASPOmB2f0UkrF+Yz7
         CWWPmESL8sXRUt/A9Rvp3eorqHMpEtuAcN6GFoOk81n7+yIXeOWolF+VWh/8PEL3A5Qe
         kiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778067; x=1760382867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMtkl73qHUTB2Otzy8qJpuGWoZM+8mVXxqiE2cfrzu8=;
        b=c/tU+7fMQPyR+21yGaj0VI72XE0NXrHif9mmWJwkAZA7ixmT17T5cE2tcAe5up8QVO
         joGdrsj+6BthdTZ09TauW+oeNlbNZU5VtiVDN538KyPnih5qTpS3dSLA/JQphHPh1LFV
         nvs7knYsznSqHMNUPwzRujMBXIYKehUoh7Rk98yWwEBa26R3CScF4h0x7nxFE8HsO9e4
         uAmBXc4FIhEDU/6jNWbhi/F6z7lzzm+4WENbJEz4Q0Fr1GyGR00Wvp4x6iqhxPE7G5sW
         eY3lUcp1Us9nOgqdMOSsfWffz4fC5JqgfZmBqSRPAEOuXLwGbfIj/8r7gXtpv8Gdi8fa
         9y+g==
X-Gm-Message-State: AOJu0YwI2gqKyynUGuWEX+DUh1s4p5mceg10TU5NKYTlOmjbK5IwbA1i
	ZAPHalpSTUdn8CWvBGpjORmAecPJN5W4PFyrp00+FczXmqJpGTC70tnm0WwTcQ==
X-Gm-Gg: ASbGncsT7w63yV2zyBjuEjiddJqrjEkOIHUU4x0ryEzejoYUz5hQtwKfqtMY6F3Bfoj
	ONNkSZA0+ZBCBvkqq/tt5tyCek72UqQ9799rDCRND4zfzlivX7CHm6fyMGdx5kOsE4pq+fT355Y
	mEfUIP2CCygPb8+1tqXdAuKbOda6fFqGsNviLl8c2xxPVactHTlV38G9FF07LlxU4pYRVKvfvMe
	PpHu7Yo0udLt+TZZ09mzsOkCZkZR8YOCj/612OMtiH1dLHz1z4roo05bv97wyJT79OPI7nzrbKe
	GASEb7/EBmSs5vIfwoDr3IgBeQe70A3VcwRiSOUzNULP3bTYz1JLEnXfwi8tp4XA13CpmgqdaRe
	7cL0Vq8bA0mNz71DI7HK6fT6R2fzeRWJVvEpwu7XWgKoQw2WTaUCulrhV2w==
X-Google-Smtp-Source: AGHT+IHibl08k4JzpelLWXkVQvkZeAeMW83AzZ6iy5srSLOqcaI281FxHivtIMxMcy0ldDFLMpiz0Q==
X-Received: by 2002:a05:6000:2dc3:b0:3ec:b899:bc39 with SMTP id ffacd0b85a97d-425671aaf41mr8629761f8f.58.1759778067482;
        Mon, 06 Oct 2025 12:14:27 -0700 (PDT)
Received: from fedora ([154.182.208.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4256866060fsm16646435f8f.14.2025.10.06.12.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:14:27 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org
Subject: [PATCH 5/5] drm/nouveau/drm: Bump the driver version to 1.4.1 to report new features
Date: Mon,  6 Oct 2025 22:13:28 +0300
Message-ID: <20251006191329.277485-6-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
References: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is so that NVK can enable compression for kernels that support it and
avoid cases where an older kernel would MMU fault when a newer mesa would
try to use compression.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 55abc510067b..9983dc57efc5 100644
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
+ *		- add variable page sizes and compression for Turing+
  */
 
 #include <linux/notifier.h>
-- 
2.51.0


