Return-Path: <linux-kernel+bounces-743452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65AB0FED9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CE63A6855
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63721A38F9;
	Thu, 24 Jul 2025 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzOFBzA1"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527E19CC3E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324607; cv=none; b=iMZbx8xd5lwPI6eV5e+xcp4m+sdQ0p7nrWo17GsgulmELX5iayzREsMlJJwCnGbtoYe1lZNMh2HSaJlh1i1ecTtJhcIrNbi9mLm7mUMSc2pEQnDXKoBQdLIxEnj1/AQn49hxPP3UbZNCMAYJcadYri+ZCOdOzjsbBowGB8b1Cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324607; c=relaxed/simple;
	bh=F3SZu0w3hanjP1bIvzcHBk81Jwayj6SyiYpy4nS0ffs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cTTUwsCxf8t9Gkz4pw9xEAesnjKWWFDdfgDDx2HuEOvY3iZ+upRw8yxwA+n3zFcWWhvzUFEwbdV9wHZkPmZieufjKgmIm6Fz35ur5zIJPHJvJqjj3rNPpQdD8O29eVS7y2vhfsHXHbeJYnQxWkw0YyZ/dmHjlqQwCDYpudtw4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzOFBzA1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70707bafbe0so1170406d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753324604; x=1753929404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpafgB7TM97IiAPA4skXOQOxYZsSA7fW1d8osuC8fBc=;
        b=AzOFBzA1ISHoEqckpECEoaIUg7uOldiuRX9Y9e35t52WdNDO16D+e05SLc3g6FTuf8
         jq9dleaMzCtY+HodQx91AlFiEpSm2IlzBn5xDTnfHikh6B/PIDsmrVsLZ+j5rdp1NI3b
         Sn2oiPbk9DGUUry2dNvRu9vyToSkp9MJe7o3+uNF4ff3J+1IA5JyDSqfMrLrszXx70RP
         1sFeYQeCFEUxPBn4OytYDpoZ1xfb9tQjkixDj6I6+LMEjHAlhFYYugV2FIRTWfygtRcz
         pzGBGTTIR7Xb2ujoulA1VEBQfaSfC1FMilQ9xSptYIHfJzEyuyh4f2uxRKPLwZl8vlMR
         6YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753324604; x=1753929404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpafgB7TM97IiAPA4skXOQOxYZsSA7fW1d8osuC8fBc=;
        b=S3k/AtvqdUO/XfqbqELiwuqjvPOk7ROcJxE986MuRbTMdeohDHeFbltzV15+2JZt2c
         k5/E7W1GPvaoTt7ZTOIX4htAtg89jruXVeT613UJ8+oNjGtt4Ekfyv18qz7aQgxTI6bz
         /+4Zd7V/Wav/WEErOrg4DQ9pjZIP+njFKMys1CifG/2cUwmysoR73Ny7uibWwfp763jO
         zERklcEMChPlXnCMXvGQ0XFWGntWzAg8wfHnMvD04TByIhX6yAqcc2iHjjsZSlL1omb5
         lLjYaqWvb+WkS4PnENRHgoYsu1ww2YLMU1uRC3T1ERejRranuRDdiw9hDHexv2Bx590a
         /2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy0I0QZSdqmyalg8SGUsF8ZpDUPN4j44TtAPdG3coPLp52rPtURevr42Bi3/2yY2+X5hkwHe7/04vkF6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdZOuwwHFc7W27H8BvCe8D6Rk+u2HAQHsb5eHr2NosMf9xEQ7
	F6mbdonMAonqyc3ozpyRlraDXl5pXZqTM//hjTEvPh7n1lV7Wp2/ZzY=
X-Gm-Gg: ASbGncuCZddNKC4/rYe9gFU+/NU71GwXHYIzpnudyFuZdvI/69g9CPr4m96gXk90FmR
	ob7rOborDbB4TUhVOmc5MmR4L+hYUFyNq69rbfkqjkEDE3UWTBkW/geKgxhIOzvhNptyc2BJzzd
	qKrfv34Do4zQZrL1UE/M5KPZINFRmA6jSy2XJbIrPZ/g/P8B2/ymaKYDsQ5ZGsx768LiUXcgoFk
	vzC7XkSYoknqa/RdW2MC++DwG9rNeYPhajR7DS2e/bN2eOOcuS+CSnGEUbFOfAGpQAGtleCNA4w
	mXzwagFzAAFZJ93aer+RwJSjUmNnQzyRFk3WV1r1w3fwf06aUUYddwXZDkcPjmNln+1QO+JCkXD
	Ipj3JhvJYgNMl3YHnh64=
X-Google-Smtp-Source: AGHT+IH+P0BUAZebqc5VI30I/89y9eCXqsFCURy/3jl+T3nPNtyKbqO+NJxSPIfO3MLZIv+k6oDqOg==
X-Received: by 2002:ac8:5ac9:0:b0:4a9:e326:277a with SMTP id d75a77b69052e-4ae6de519c0mr32351221cf.5.1753324604423;
        Wed, 23 Jul 2025 19:36:44 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae7e355017sm4641551cf.27.2025.07.23.19.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 19:36:44 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	vulab@iscas.ac.cn,
	Wenjing.Liu@amd.com,
	isabel.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] drm/amd/display: Add null pointer check in mod_hdcp_hdcp1_create_session()
Date: Wed, 23 Jul 2025 21:36:41 -0500
Message-Id: <20250724023641.1258831-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function mod_hdcp_hdcp1_create_session() calls the function
get_first_active_display(), but does not check its return value.
The return value is a null pointer if the display list is empty.
This will lead to a null pointer dereference.

Add a null pointer check for get_first_active_display() and return
MOD_HDCP_STATUS_DISPLAY_NOT_FOUND if the function return null.

This is similar to the commit c3e9826a2202
("drm/amd/display: Add null pointer check for get_first_active_display()").

Fixes: 2deade5ede56 ("drm/amd/display: Remove hdcp display state with mst fix")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index e58e7b93810b..6b7db8ec9a53 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -260,6 +260,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
 		return MOD_HDCP_STATUS_FAILURE;
 	}
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-- 
2.34.1


