Return-Path: <linux-kernel+bounces-757146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269EB1BE4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740934E2F13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2915746E;
	Wed,  6 Aug 2025 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbIX6CXU"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61D1114
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443681; cv=none; b=UHJkEKcUvmcS6lLS2iegDqr1V5kHxXYzov/ZW+5I0q7K/cN3rfqZ8+Wv2r6OJB2kZNPZuioebPjrKFjGiAEvBoKJIiwIzFfIkpukXsN3WkZXjzki7UjTBZksoYIq8He6J5fBVoj5tZ2R/aKpfPRpQccVRe8kGIvaGlJOWqwzijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443681; c=relaxed/simple;
	bh=BcI1Wf9z0QT7JNthUDR/DWOYzSMGQZ+4xzZePLsYLwU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SjU4mdzobKHr/9ZehIR8jpvAMbjTaQ5JHox4sRfuRWzF5n1hPnJTPwW7XUHGMyuxv9QxIQLybzkchwqBtbpUv5hgUrvwkESjNvzVo1P1QDjZOKe1377LKSbgaXEvMuvdVYbaPvVkpfxRKLvP9iOnKwYWzLD5kwmwJ5BxqdU0Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbIX6CXU; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-742f798bb20so1258852a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 18:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754443679; x=1755048479; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8m6WQ7WFJFpA+OwxDVX3v2vixZ4KhoNYzGWzjB/pRgk=;
        b=LbIX6CXUE8uCM6Mch8kWBW+3AfoJguRTZBfEF4YG7a77xulhXuQ4IaASsHaOA8szA1
         0A6AUPMi89w2HKZeSLT6az/ZWRBsq8ulUbBBgInG8N4MSzkVGJex/N+dj1iKngGBykg8
         kjEket04fYXX7Qx2TbGdCrs+jfg4GXAGGPuNujwcKI86pOkBDPeEuq2U+0WaeQWNfKv4
         mWNaMugaU634YahucuKXOmcX784vXl6hZF8qTj9XKbyp/gIu+UFX50vI77PfWLViG1EO
         n/hj4E6XAiHjmYZuZEcSZZDOvECNfqyPcIv74t7ZHPMkNc/yNDiZw5URG1JKswdBqC8Q
         0Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754443679; x=1755048479;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8m6WQ7WFJFpA+OwxDVX3v2vixZ4KhoNYzGWzjB/pRgk=;
        b=do6XJf4ZKZHturW4fGrTm5AzQKEAdaT03PysitMTNZib2ianEnYTCW+3bsp0tFLgiY
         jFiXxtxvQYUL4wztHZLWY+bMsy4nt+Tv54CyXYwOS+G8O+xNDAT2gOEZLwFnCloDG99o
         RZqO03bQNPnHaO8HryHgIvSf9J5XA6NCkrZSfaYwfTGspw5igZPtAbKhEVil1Y8uRTVA
         vuSWpdUBQsJHy1doFzHaIfe/D5OSNgiH8G0qzZ9GkTlZ0JtaQXt3YmuVmcFYaL9GTCP/
         7DXnlaHoaEwQKyemegXHMAMsysqD97mNpLqlj4bX/Ab3bYnKE8qG+mv7fyU7N/F/bf4e
         K/bA==
X-Forwarded-Encrypted: i=1; AJvYcCWBksbRxwC/zuDFfaWXlkLkp76G2LfPO0QTIGeGTG9BSeLN5t4FFR7Kf+sYcKwZ/z5d/1l8mMQ6J/772r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMP7bYJ1TSw43sXCdlwL9JYnE9nCS07Q+Fu0r8pWtNol/+pAS
	CI79xHuKTf4vrfi30XepcxMWvR3Fg4OeQ8NWhm+E/jax7su2Wj0mWGk3
X-Gm-Gg: ASbGnctIs7sVE3qBHM154b30wv+NifKTsQwGT9ZJfpCVpCn6jLVOx7ymLuiZvL82tVz
	Q2XwHaEiqD6NXynxvyNEqDl+xok0LTHQnq07Q286BLQ2s/ZZbrdgJpOomRMYay7NnWZz4VzjU7S
	dQayA6fKZBGBDUQrLRSrB5hCxBA+dNVUibj4YvFPUg8kOPWmlaqcB2yzIwdGziyGaGLU1ZSYrz8
	WRIsCgAKwzEkxTC6uPFsuQ4kj1C18dAclZw2wXmkH4asfsnJAQ+PfpKoV+T8hMu8HVzNPgkxUkG
	LkEbcBCsAdBZAilq1UnZNlDhds4tprHQJ5tDikA43VC0TIcgeDw4OWtckGFY3SQe6gpLB5TQs2A
	GnOST7C2uubxBqY1hWutNb4fybY6AYg==
X-Google-Smtp-Source: AGHT+IHxxgfkjj5PlfPmUdlrNom9hvpdAQlX5GMiE3tvTipTbehMR7S6TcXRs1HyiWQGr82rD1N+pg==
X-Received: by 2002:a05:6830:2115:b0:742:fb8a:d2d8 with SMTP id 46e09a7af769-74308e97a82mr1257902a34.21.1754443679368;
        Tue, 05 Aug 2025 18:27:59 -0700 (PDT)
Received: from jander ([2600:382:6a2d:38ad:3f8d:6104:aa7f:a5d3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74186d912e6sm3054294a34.29.2025.08.05.18.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 18:27:59 -0700 (PDT)
Date: Tue, 5 Aug 2025 21:27:55 -0400
From: Christopher Orr <chris.orr@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Add SHP LQ134Z1 panel for Dell XPS 9345
Message-ID: <aJKvm3SlhLGHW4qn@jander>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Introduce high-res OLED panel for the Dell XPS 9345

These timings were selected based on Alex Vinarkskis' commit,
(6b3815c6815f07acc7eeffa8ae734d1a1c0ee817) for the LQ134N1
and seem to work fine for the high-res OLED panel on the 9345.

The raw edid for this SHP panel is:

00 ff ff ff ff ff ff 00 4d 10 8f 15 00 00 00 00
2e 21 01 04 b5 1d 12 78 03 0f 95 ae 52 43 b0 26
0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 fd d7 00 a0 a0 40 fc 66 30 20
36 00 20 b4 10 00 00 18 00 00 00 fd 00 1e 78 cc
cc 38 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
37 31 4d 31 81 4c 51 31 33 34 5a 31 00 00 00 00
00 02 41 0c 32 01 01 00 00 0b 41 0a 20 20 01 ea

70 20 79 02 00 20 00 13 8c 52 19 8f 15 00 00 00
00 2e 17 07 4c 51 31 33 34 5a 31 21 00 1d 40 0b
08 07 00 0a 40 06 88 e1 fa 51 3d a4 b0 66 62 0f
02 45 54 d0 5f d0 5f 00 34 13 78 26 00 09 06 00
00 00 00 00 41 00 00 22 00 14 d9 6f 08 05 ff 09
9f 00 2f 00 1f 00 3f 06 5d 00 02 00 05 00 25 01
09 d9 6f 08 d9 6f 08 1e 78 80 81 00 0b e3 05 80
00 e6 06 05 01 6a 6a 39 00 00 00 00 00 00 58 90

Signed-off-by: Christopher Orr <chris.orr@gmail.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9a56e208cbdd..e491b84d0ae0 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2027,6 +2027,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
+	EDP_PANEL_ENTRY('S', 'H', 'P', 0x158f, &delay_200_500_p2e100, "LQ134Z1"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1593, &delay_200_500_p2e100, "LQ134N1"),
 
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0004, &delay_200_500_e200, "116KHD024006"),
-- 
2.50.1


