Return-Path: <linux-kernel+bounces-843960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A9BC0B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFCC3C8B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043502DFF13;
	Tue,  7 Oct 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSxdFQog"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB32DF71F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826004; cv=none; b=ha3SpXHxOfM2UwajY7sxsJEpCKcsjoDaWqY9WdXPU0539xtxQKW6whgGyhvlOtrV0xQEGfWedDqS2YczfYal5i1YXnZTK4e6YVTZdTpw7z2F7bdnJTbnpzMsO6SkAZBMN937xOT42QTWaKV0vAib+XZeY5yBAxEt4oBK3oV96Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826004; c=relaxed/simple;
	bh=XfnN1y8TR9d0kJhrONqUSjYTGcbs0xeo8/JSjdx4LAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8jrmi0fC5ev268fibJXjxDf5dswh07bpSdYwMNP7hNLDrudrAtbYirPZbm4Grgnf9VXcaCapGe5p9wpiWqjySqYEEQKFPLrs8Y9XiNNVJqD5wRP97KqpeDR4qRFaLkUKBKREUqkqXkGMiiqRObOoRSCVnJWNNnMaqvKR3vw1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSxdFQog; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e34b0841aso8937105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826000; x=1760430800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/5lpEHR2FrKfoBetfp+01yqZYBFD8BaIlepSwlcmXqE=;
        b=nSxdFQogB+sz2bETobgIuXbGgjg3HoWLBXUBdu8IXeedExYOnlZGKk6cM0EIdLQ034
         gcERC3vYwj5VYc97W+MGYtr3uMewRtx+Tjclf2nX08VZZwweSHjVXa62TucgY8giXHOm
         RZ3yJnoh4IyNpJw1GGXQDzdhc0rFclk7f9Wl8abQ2MeFoNpn+LKDAsfHy7eEKMq9CX53
         yAfcm2081OYzREWPfnY6N5lcDbFRoIyhVwH7ROFCUW3g0uOAgW5xzcek9r5zi99Hd6bK
         h2FP5Tk2/WKiUQMQl69PNnIH8VIVLkZoFQ3sQdhqQ/E3pZ0WQ/m1FI+1UzVvJMgcLbZn
         gg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826000; x=1760430800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5lpEHR2FrKfoBetfp+01yqZYBFD8BaIlepSwlcmXqE=;
        b=MwPpkJ52AoYwdVaym96cWhJ8fJzpQvQ80RKZvUnsG4T+zY0/jqSZQzgeAzU5dZn6qU
         seXCotRFKk8UYud1aLRSGXA2MTcco+/xqQjXWKbgS4EfLWRjOLeg2m1OBEET8h5PlGpK
         GX3qxTMwP4rNoGDWM/oW8gut/r46/n4+V/YC+O0yp8MCoiBZMzDqz4DP6sFF4Ml+/QPb
         c04gNGCVrYm7tscyy/uA34lpbU0aPEaoiH2irxDn7L2vj/KCz6rRZP548ayp+K+VLRpB
         rXWJ0IDhVnXrgHxGEdMK7+wS9GMGERpjhFIHc61whZXbbviW8Z8cW5Md1kFkILmRgsz0
         QpXw==
X-Forwarded-Encrypted: i=1; AJvYcCUCRWhehekzJtYP4HEL1mma6ya8AKyH5+dppdf9zpojArEWiwxInR6dPssTJ356ov6Et30Nmadi9gxSFsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIezZjxK6NMkdbWrEQZ0rFgUtJR0+QHdezyin9TKG01aVhcwG6
	0Oh6/H3DHLa9fXwTI9lf1+cAvFmGLj/LYj9Akwn6GA9vfS1dZbxcFL6H
X-Gm-Gg: ASbGnctmK3vvFjzZymWGEOz7lDzGtDvc39bHYoWUVT5GO90xS5RC7bt18boCXgkudew
	436SkQ6wjqgMTFFYMNIpONw/cLj4A0XjwsEE/+Lmy5AC6qHN/468tCVefyhxxv+HhI9qLi8WE7s
	VXqmuhbpbsspF45Y9Mvrztnb3hCzxSFUlZYHRxucIg7gEX0zKJX3OMhscLPN+fQaq+1NH3O8IgP
	Nn3/0qNmhF3Qdp8xH919++yeWh0xbSdmkfn29evVFouu/eXDavBxMNbN1JPnWThS4SOEHfvYWZI
	NF5LiqEFf2fATgox8JdQTAMg9rc2QN2/P50AKXna4iOJONXRPhoW0oQfjMDlavW0C0mWswvbiZB
	TQg+WkLnZuOUozqNvKjW6o8W9LdZxgo/iWOlWAxv/onC1wmlmM6kFtkVc
X-Google-Smtp-Source: AGHT+IHfsj3QYJwF3EIm/+ncIkc3TJT6L6wdnZ1V99H9OeKwvXsmjTC5NTDVxYdVGhOUR7h94+1oiA==
X-Received: by 2002:a05:600c:1993:b0:46e:477c:e4ff with SMTP id 5b1f17b1804b1-46e711549admr58886835e9.7.1759825999419;
        Tue, 07 Oct 2025 01:33:19 -0700 (PDT)
Received: from bhk ([102.155.185.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723437d8sm197395365e9.3.2025.10.07.01.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:33:18 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	mingo@kernel.org,
	tglx@linutronix.de,
	jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	rubenru09@aol.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3] drm/gud: Use kmalloc_array() instead of kmalloc()
Date: Tue,  7 Oct 2025 09:32:40 +0100
Message-ID: <20251007083320.29018-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc with kmalloc array in drm/gud/gud_pipe.c since the
calculation inside kmalloc is dynamic 'width * height'

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes since v2:
-Reversed width and height in parameter order.
Link:https://lore.kernel.org/all/20250923085144.22582-1-mehdi.benhadjkhelifa@gmail.com/
Changes since v1:
- Use of width as element count and height as size of element to
eliminate the mentionned calculation and overflow issues.
Link:https://lore.kernel.org/all/20250922174416.226203-1-mehdi.benhadjkhelifa@gmail.com/
 drivers/gpu/drm/gud/gud_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 8d548d08f127..c32a798ccadf 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -70,7 +70,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const struct drm_format_info *format
 	height = drm_rect_height(rect);
 	len = drm_format_info_min_pitch(format, 0, width) * height;
 
-	buf = kmalloc(width * height, GFP_KERNEL);
+	buf = kmalloc_array(height, width, GFP_KERNEL);
 	if (!buf)
 		return 0;
 
-- 
2.51.0


