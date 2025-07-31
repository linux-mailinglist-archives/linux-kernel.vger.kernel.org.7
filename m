Return-Path: <linux-kernel+bounces-751626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CF1B16B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C763ADD52
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7CE242D60;
	Thu, 31 Jul 2025 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELH+/pxY"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76571531E3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940208; cv=none; b=CGvxBKMfSjNKDvBbBaa4amBA9D3c6Y5GlobIUaLqSOGTUwHU+cT6U4LLyU9m96nEAvQI0k0z1tq4h4+VHxTlVgpNe3RaRRWqOjYkZF1IAJuM/Zk712mqWF61oq4tBgGDErTD/oXreOnWw5Q8U1qfiz2hOTCVbDzEBE5eoUvo2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940208; c=relaxed/simple;
	bh=uiDe3EZE8VVdRtDer1s/9EkBTNCfHbICAi+aridXu6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOWmjwbh8optnhm/oCiqJp8T1znTmt/9iN6+ToKaxRlj2PPNYTpcy/MWskpzexGWOVzwJ/NccHhZkBgu9OPEP0WcNkGlowOTLDygNqznUMET9qMF92AsBad+vdyeKVh+9wRYvOO0bXdhdC43QArIgvhaVQ7TtGBGkYd+Uv32vuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELH+/pxY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7825e2775so415035f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753940205; x=1754545005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciDcGD9tQuLy73W2iFAgqEh2yygZMEmdyq/oIgQDGc8=;
        b=ELH+/pxYs25c7syZWVLIy6f2w/3InR8GuR6KqmudQ+f0Bm7UUik3L3TrMvqwN7cl43
         S28fICd+zJD0LLHdKCVPzsD/2851om3KyHyml7wfnhyEui4dyDA7t1TaYKuL2fsl2Vlt
         fQnBoROqoWpE758bFbZFCS638B1KO0whpZ0TEJOKAVl0XUr7gR9i3EClseuuAXfxxVa9
         sGNAaWRUhTpfVpchTImZGiiDyQJvvq3osW2GmLO40i/7eqSuopVvkaCdg7jucOIqY0ww
         UEIlifnIaSKVBp2ICCnvWhOCTP7GGdmv7GkxPbfLnnLT2zWbxJoOFc0jFUfTPd+3wRcn
         Y0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753940205; x=1754545005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciDcGD9tQuLy73W2iFAgqEh2yygZMEmdyq/oIgQDGc8=;
        b=cT4aapUoQ5AQjTiSxD5rnuDMGFfZqozSC0XAxgA81entwpkt8h6W0T5boG2o3BjV5O
         FVs3y26ZT8/yCBkpvMzAlGMbbcp8JhaNe/p1J5wJO1dUmP1Pzxy/PyLn6SLFqf+JgkMi
         JIIqK/vB6TreszWm3lDoF6epGVAmaMt+QrzSPwrgI5ldjt/BGEncLz72NUgaww15LZn+
         lnguQnovjuq08LdW5hx8OzMaa+dDDXOeExiWDxuL5dYNf+U0Rxxdcat8mH9awWKAbW5r
         owpbiYG+9mdJ2Puia44cVzeW5z8ToQ9LuESyXd8bIy0bYjE1qwtlIYK4VK+RFAMzWGLz
         vGjg==
X-Forwarded-Encrypted: i=1; AJvYcCWyOQshaK4mO+9yXqghfJVc4AUyi6PtHz9J6c9KuDEbpprGyKZlBk6cfIG/DwKfLhl2ZJ2/GuLy1bTt8u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxSRm+sCtysDVoBy7nrOCjEP41nP1Qd46m62mb1nFogj1AlqJh
	WJJ7pZQj5ArB8ghHnKbRmoh/KUJOpwmdOSslsXv13GefdxKyqHAMvfvk
X-Gm-Gg: ASbGncs9iCCopM4R2tAh5UsxxQOm/Gs+NEuwyF6MS0so321SJibdC5zgGFV2LpmNDUk
	odBtp+pqtSCJvbtNwYbRDNCrfu9dUhrRRC0WnTRrUp4tg7RP6KDgBThowcGMjfuu/rjY4Cc2DfQ
	I5gxxmQcm22X5YVA8ZMnAV5gF7mrm+CZfrTKLpnK8+3sgcIOamSWiReLUmz7dKVgqeIAHNAaBm8
	mScW1qCAYuWtKrntRW9TC5QfgxsETqQKgdH/tWth2a90uYl5QyRo16MMIhi39fztRFpfOFi8FX3
	QBNfNMkBzTdbm6e9C6q8Hh0VZAEnzuW/s3+1Ca5Ogfeh99VHes7qtgxUeNMrrmawbf68Ch/rp8l
	+NHfi1d9Ao+VbYlSxoCDhuR+AUdf//qiH5PFssUbVfWwU29dLdfRcYd9aflNx
X-Google-Smtp-Source: AGHT+IFQg3GjgMIShqv9r+GrnPQh0001v5pGFRp3EPBPGnnFSydrqIzNSmvTsnfK9s5diM+fkCt51Q==
X-Received: by 2002:a05:6000:230a:b0:3b7:6205:25c7 with SMTP id ffacd0b85a97d-3b794fed24amr4608870f8f.13.1753940204915;
        Wed, 30 Jul 2025 22:36:44 -0700 (PDT)
Received: from [192.168.1.205] (dynamic-176-005-138-071.176.5.pool.telefonica.de. [176.5.138.71])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm1149137f8f.9.2025.07.30.22.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 22:36:44 -0700 (PDT)
From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Thu, 31 Jul 2025 07:36:34 +0200
Subject: [PATCH RFC 1/6] drm/amdgpu: don't wake up the GPU for some IOCTLs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-b4-dont-wake-next-v1-1-e51bdc347fa3@gmail.com>
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
In-Reply-To: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Philipp Zabel <philipp.zabel@gmail.com>
X-Mailer: b4 0.15-dev-a9b2a

From: Alex Deucher <alexander.deucher@amd.com>

Don't wake the GPU if the IOCTL doesn't need to power
up the GPU.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2295
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 60 ++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3bb9b25cd1219..34b9d63a86227 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2926,23 +2926,73 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 	return drm_release(inode, filp);
 }
 
+static const unsigned int no_wake_ioctl_list[] = {
+	DRM_IOCTL_VERSION,
+	DRM_IOCTL_GET_UNIQUE,
+	DRM_IOCTL_GET_MAGIC,
+	DRM_IOCTL_GET_CLIENT,
+	DRM_IOCTL_GET_STATS,
+	DRM_IOCTL_GET_CAP,
+	DRM_IOCTL_SET_CLIENT_CAP,
+	DRM_IOCTL_SET_VERSION,
+	DRM_IOCTL_SET_UNIQUE,
+	DRM_IOCTL_BLOCK,
+	DRM_IOCTL_UNBLOCK,
+	DRM_IOCTL_AUTH_MAGIC,
+	DRM_IOCTL_SET_MASTER,
+	DRM_IOCTL_ADD_DRAW,
+	DRM_IOCTL_RM_DRAW,
+	DRM_IOCTL_FINISH,
+	DRM_IOCTL_UPDATE_DRAW,
+	DRM_IOCTL_MODE_GETRESOURCES,
+	DRM_IOCTL_MODE_GETPLANERESOURCES,
+	DRM_IOCTL_MODE_GETCRTC,
+	DRM_IOCTL_MODE_GETPLANE,
+	DRM_IOCTL_MODE_GETGAMMA,
+	DRM_IOCTL_MODE_GETENCODER,
+	DRM_IOCTL_MODE_ATTACHMODE,
+	DRM_IOCTL_MODE_DETACHMODE,
+	DRM_IOCTL_MODE_GETPROPERTY,
+	DRM_IOCTL_MODE_GETPROPBLOB,
+	DRM_IOCTL_MODE_OBJ_GETPROPERTIES,
+	DRM_IOCTL_MODE_CREATEPROPBLOB,
+	DRM_IOCTL_MODE_DESTROYPROPBLOB,
+	DRM_IOCTL_MODE_CREATE_LEASE,
+	DRM_IOCTL_MODE_LIST_LESSEES,
+	DRM_IOCTL_MODE_GET_LEASE,
+	DRM_IOCTL_MODE_REVOKE_LEASE,
+};
+
 long amdgpu_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg)
 {
 	struct drm_file *file_priv = filp->private_data;
 	struct drm_device *dev;
 	long ret;
+	bool wake = true;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(no_wake_ioctl_list); i++) {
+		if (cmd == no_wake_ioctl_list[i]) {
+			wake = false;
+			break;
+		}
+	}
 
 	dev = file_priv->minor->dev;
-	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
-		goto out;
+	if (wake) {
+		ret = pm_runtime_get_sync(dev->dev);
+		if (ret < 0)
+			goto out;
+	}
 
 	ret = drm_ioctl(filp, cmd, arg);
 
-	pm_runtime_mark_last_busy(dev->dev);
+	if (wake)
+		pm_runtime_mark_last_busy(dev->dev);
 out:
-	pm_runtime_put_autosuspend(dev->dev);
+	if (wake)
+		pm_runtime_put_autosuspend(dev->dev);
 	return ret;
 }
 

-- 
2.50.1


