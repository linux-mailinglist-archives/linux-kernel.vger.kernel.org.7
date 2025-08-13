Return-Path: <linux-kernel+bounces-767098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD852B24F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B119A2333
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1933286417;
	Wed, 13 Aug 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="GdfsDXKR"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8023ABB0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100968; cv=none; b=GXqXucKOtYCPlamoVkWADuhfphphk+VGkFmC9YIGeR4Rn2bOWI0Y+lLdeul1DTMoh7eoh61YMHI16NPCm2pQzfN1GZVEqWQn1m/zI018u58N8KJEvaQ3vw8Szq+ahtBw5BqJVIyn2kCg/qZnPMTIGZdElt6tz6Itt7p2UAC3deI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100968; c=relaxed/simple;
	bh=zkeMszwcEY2/Nw1AqB8rOo2CFjNX+nyhvu/+Et85Vww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E1JFUWforfzER+r3ooQYmVJKm7Z8kFMsHQYHYtkmOpaTtOoiWjCM753sswEJBnmkSV56HH34AmEl+3QTkp2YDsVA0rk5SHhpa3kwfsWWJCYxBu3vYYChq48ZSD1obFT/2BBgW6ED9a5Jcy2RVq5ICZFUyTc7hHg3EappeFFygvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=GdfsDXKR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2401b855635so52857635ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1755100965; x=1755705765; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vU1iojt0gD3FI1ZhQ2ngoLEMSZI8uX8uMw4yAJKUm0w=;
        b=GdfsDXKRKQ8pEF/5R6IY33yr3SreRHUlK9p/PP/3I3VCquinPi/L/DgLm3u1QtTec2
         Ynl1NBGDFgMXVt44bv9ZRohefan4DlxKguAGi4W8C1IwYWrDg5euAof24Pes8QC8RRru
         deld/AfbzeWycjBqZeVdUfZqh35vWFxVAtppre193CDfviqX4zbHXrZY2naTxODUOoUv
         TDJHVdF1RhGOzYByvpE3KhfeBquqGeAuhn8SzoQKJg6dz61X4WyvKEn8lM0CsHMGTcHK
         wApnkFTtq5qddLqPcGbntw9ICcHxeZTfX96QQkpK8iLf/47NDMiQKZRL3GJ9WPTLOxRz
         Pt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100965; x=1755705765;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vU1iojt0gD3FI1ZhQ2ngoLEMSZI8uX8uMw4yAJKUm0w=;
        b=YlZfvyJHna1P3UiIeqEGviKv/QPuyAB46uIcZT9uyLBdleuZOiRQdiPmkKOisJHTXV
         RGMgX+xAumw6RliFiThEBg0hnVrjoLuUBUf8y2wLJp4rEJUtPjhwr4h9sj7gT06YXCR4
         /kQc7S1/d3+gRDS8aUOEtkco+N/lcn/nkmVGoyqCz5zpYWLzkX7SxANCsD6RIJnL/veG
         USdHZNquw8iqStetHfVH5Q5mH1R5f/7RZccQwYcFOYGUOatW3efhcZk4fyGcK68OcULx
         RiqBXqDapxZr31PTpAJeENXCd7/9zWVaIgnf7w3+89e3qqdcSVTK/dzZDm6vKYP5Om2O
         A80Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC2+8pOdtBF9MIJAST+m/Ewj5MNRZKt+p60FZtGAsxAbfn7rxomqRg0zcLG5r9rhWTwC+Ni1VK7UHDtYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7b3S/tFHh3MOMtm0vLeKejQC4pO82mqBrGKDYKSdPhTCKjf/A
	dxfGYe1nwM+8ml1qm1Tcq0N3ot2kT7RkX3f0d+tLBvxJ7UNYgxyyaxwlrMdnaQaEUX1Ku4zBiun
	82dA/
X-Gm-Gg: ASbGncvD4+i7FsC7W87rMOtHdjGPLjVwFxLnvfPLvyF9cSzppGB6jBb38Skmn5LjK0Q
	bzXdUxK61aSV8hi6YcEljwRJK90S3FvUOXaoiuM3cNG7+5D36WJHMmy0qCKJhMyCriXJbntE6Fz
	eUtOXngKu9E3UWabcfZYlcBMfRC9KcoXSJKSe0jFHwuSO+pPLrP4hpUGeKem7iuDCwFix6rcRhj
	md2nijw9l91DoXe8DKhERaYsLvXV8ghpqi2b/aansC1ywH6v6ho5Cw+e6eCsx73kTPK/Ls63hGF
	wKo9uH/rElhRaw6+bLPBIJA8/Vs4i+UPa11O4HB56kWJPDq/8Jvl4PcU9af/U179K/Z0wyozWde
	M1UegwVFTsRMIFxEn9433u9SYpAJDheWJENHdkBGIPA==
X-Google-Smtp-Source: AGHT+IHckUEfl6Sm+2L9KD4HithUZ+Iig/EWOybXb8wce/skeyx454O7qL/9XNBxODe4Za4Yq2h7OQ==
X-Received: by 2002:a17:903:2d1:b0:242:fc4f:9fe3 with SMTP id d9443c01a7336-2430d2243d0mr56569415ad.37.1755100965055;
        Wed, 13 Aug 2025 09:02:45 -0700 (PDT)
Received: from [192.168.1.100] ([2605:fb40:0:c09:323a:5679:3782:80b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a06sm329750985ad.81.2025.08.13.09.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:02:44 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Wed, 13 Aug 2025 10:02:37 -0600
Subject: [PATCH] accel/rocket: Fix usages of kfree() and sizeof()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-rocket-free-fix-v1-1-51f00a7a1271@brighamcampbell.com>
X-B4-Tracking: v=1; b=H4sIAB23nGgC/x2MWwqAIBAArxL73YIp9rpK9CG21hJUrBGBePekz
 xmYSRBJmCKMVQKhhyOfR4GmrsBv7lgJeSkMWmmr+sagnH6nG4MQYeAXjXet6+zg9KCgVJdQ0f9
 xmnP+AEYAqHFhAAAA
X-Change-ID: 20250813-rocket-free-fix-3ca6a759a290
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2090;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=zkeMszwcEY2/Nw1AqB8rOo2CFjNX+nyhvu/+Et85Vww=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ8ac7crzGIQYNx/WXxTx4oKswQm3/zJrfZfPmv4w3cj2M
 YOyeZxyRykLgxgXg6yYIovKrVnqFydbPzoYwT8BZg4rE8gQBi5OAZiI7klGhs4lqezaUk/enbv0
 p9rwWWNAKSNr9oKHjnvMYrNXnClwM2H4K7jwFa9erMPXAqNZmffbvLr85/82Oada9r3TO9ZhToY
 GIwA=
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Replace usages of kfree() with kvfree() for pointers which were
allocated using kvmalloc(), as required by the kernel memory management
API.

Use sizeof() on the type that a pointer references instead of the
pointer itself. In this case, scheds and *scheds both happen to be
pointers, so sizeof() will expand to the same value in either case, but
using *scheds is more technically correct since scheds is an array of
drm_gpu_scheduler *.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202508120730.PLbjlKbI-lkp@intel.com/
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/accel/rocket/rocket_job.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 5d4afd69230623215e3105da7153d2d010636d52..f6fe1a6d9264b7508a3adc03248e5a704c68c4f0 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -222,7 +222,7 @@ static int rocket_job_push(struct rocket_job *job)
 err_unlock:
 	drm_gem_unlock_reservations(bos, job->in_bo_count + job->out_bo_count, &acquire_ctx);
 err:
-	kfree(bos);
+	kvfree(bos);
 
 	return ret;
 }
@@ -496,7 +496,8 @@ void rocket_job_fini(struct rocket_core *core)
 int rocket_job_open(struct rocket_file_priv *rocket_priv)
 {
 	struct rocket_device *rdev = rocket_priv->rdev;
-	struct drm_gpu_scheduler **scheds = kmalloc_array(rdev->num_cores, sizeof(scheds),
+	struct drm_gpu_scheduler **scheds = kmalloc_array(rdev->num_cores,
+							  sizeof(*scheds),
 							  GFP_KERNEL);
 	unsigned int core;
 	int ret;
@@ -630,7 +631,7 @@ int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
 		rocket_ioctl_submit_job(dev, file, &jobs[i]);
 
 exit:
-	kfree(jobs);
+	kvfree(jobs);
 
 	return ret;
 }

---
base-commit: a3daf184bd85d7c08ce948a79bb0e4cac2203923
change-id: 20250813-rocket-free-fix-3ca6a759a290

Thanks!
Brigham Campbell <me@brighamcampbell.com>


