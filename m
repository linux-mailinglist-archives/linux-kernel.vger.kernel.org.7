Return-Path: <linux-kernel+bounces-764150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55FB21EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB0C16931F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07983296BAC;
	Tue, 12 Aug 2025 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="XeckP9Xf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD15286420
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981727; cv=none; b=WfkprBnuk3JjShafbc8oT1qGlSwdv2SrRkL0BeSntempaw1uLcYRMp2dY20WX6xNFmBtJD9zXtlz2aagm+41HlBFZiFVAiMbtg30U5Uj45LKVktmXXpxAidSs3/hjRLeRlUdFH9HIM0/mYtUdpDg1kdNTkKo9hpw4EcporeCV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981727; c=relaxed/simple;
	bh=Qq3GhMo00yI2uzRUV+DNVA7NxtL2KHQifN6lauk0i7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=isDbb/Ydn1wVBMyhkVIpvaEiaHOU9Shtj4KCm0pG/iTL6pTuwcst8KUFO2WxgxKSWbtLtOU0iYpgRD/wNiEzHpNwJoc/c9Ewp6teyiAMusdJK9cjJML7zx7UBY+W4/04njpIGM45xB2W5Hx6CVvj9m1SXhZQWVwrMk5CJiufdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=XeckP9Xf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2406fe901fcso53668685ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1754981722; x=1755586522; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQpilYnt4FgOjs5+1tewTfyxrC4VggVjH4vFHfgXSYI=;
        b=XeckP9XfDSrin566nY/BfUn6Toqkw6tbpKGV4J/W/ASULFUd6GtCZlpSZV9y5EMJFZ
         acPxZk7cMRjW/p7yPh4Arj0XAxbMa6dGtpWGFn6Ikms91CEz4BI28Ni47/VQ6Rsvt30L
         KSGv1qmnAWDYr4PXpQPeJde17xZOl41LKdvEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754981722; x=1755586522;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQpilYnt4FgOjs5+1tewTfyxrC4VggVjH4vFHfgXSYI=;
        b=Ld05XKV0SJndRYBQFNJud0jkhY3l8n9KPo/Sd4ZUwAtWMMjYTqSV4f8kSgNhMFx6VB
         +Ohj9WlZhjA5Jk6ozNi9jFi9BIXv1QZzgh+N/Q6tNRbX/fdEuZdaxG1bVvYDSulwwyVB
         dKmHzBQztdmw6M8eN69ofCPJaJAvkgmX1WwSYEAVN1Dxyi2t4J88EvjMYbqCcjqjo8gq
         YZEKKOaSrIPqLiTfZjj7GlO6hADsNlCZoRjnJUMyRKpOP2iJQtEk+J9Lnw15YygkJtG3
         jVO5LsjI5s3kRRVY5FUex/2cCbExrUetz9Q5PkgecymF+GY2blA4TwiZuquKePPRbXRH
         cQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVhiM0y3SohEmaunYzAjzaolQ9kjZoe82RoJ6VK9+0pvxOCr1cEnhgFFc1l/LKNgetb5xSQlS3CItz4ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGqON0HjdFozbAO5Gqdgyl4UUwJoF1J8/G3U3DCVK/dYQLo7kJ
	ODqatOAKMDUi8Z9sbEH433NAwz3nQNn9LSVz0htotBUOa0G27o4WbCRIP18U32aQn4Y=
X-Gm-Gg: ASbGncvbaXCGcBSYvu765X3WKIv5mukLYQCxjS8M6n+0UOnF0eJlB+Kfd0lzEF65695
	aByW8E/eTNM2rYY/E0ppxHKjhBp/gwHD2W1DwK8hITeZ9yLyFa1MQMKm602dQg2ylBHIKGrb6zE
	N0JXnS+aSHj63f1VMoCO5jF9PWeOVM0MurCw55KcDFeHWfbWCwC2xZ9gHqx8CkXuomTPXo6P9cX
	34T8a9+FA0ClnKJvoO/u7z8/OYJvv6fAlspSoztFltGgt6MRtnDhCvn2b3zgO4SE3LXD9pfRGlR
	gJ7VrSHVUDEWecP8y/aFNt+TeypFQjXiCL2hrQPLPS6ZNhiY25P5W8ROOnyS1MYkF5E/es1buLI
	P8uplqH7HnhLv+opNYHmBzmbxqnamZLhkhgWZhkz+7fA8/UB5IgLhabA=
X-Google-Smtp-Source: AGHT+IGZE5ejnVJXLy+u8D+y8H3N4C4rUcjtSocvHp94fOPiHgfZuivNo0dcelQy8UmjKn8/qCY+Yg==
X-Received: by 2002:a17:903:124b:b0:240:11cd:8502 with SMTP id d9443c01a7336-242c203d160mr209522875ad.13.1754981722075;
        Mon, 11 Aug 2025 23:55:22 -0700 (PDT)
Received: from 8eba3d7b3083 (122-199-11-121.ip4.superloop.au. [122.199.11.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24300f8ca2asm7538825ad.141.2025.08.11.23.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 23:55:21 -0700 (PDT)
Date: Tue, 12 Aug 2025 06:55:15 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: rudi@heitbaum.com
Subject: [PATCH] drm/rockchip: cdn-dp: select bridge for cdp-dp
Message-ID: <aJrlUzV1u4i65NRe@8eba3d7b3083>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Select drm bridge connector when building cdp-dp.
This was missed in previous commit causing build failure.

Fixes: Commit afbbca25d06e ("drm/rockchip: cdn-dp: Convert to drm bridge")
Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/gpu/drm/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index ab525668939a..faf50d872be3 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -53,6 +53,7 @@ config ROCKCHIP_CDN_DP
 	bool "Rockchip cdn DP"
 	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
 	select DRM_DISPLAY_HELPER
+	select DRM_BRIDGE_CONNECTOR
 	select DRM_DISPLAY_DP_HELPER
 	help
 	  This selects support for Rockchip SoC specific extensions
-- 
2.43.0


