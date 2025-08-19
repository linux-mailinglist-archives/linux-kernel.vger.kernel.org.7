Return-Path: <linux-kernel+bounces-775300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14486B2BDA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B783B18973BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C031AF36;
	Tue, 19 Aug 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERSuohNr"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8B3115A1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596322; cv=none; b=FwLJSZb61XCgbKR3Uwr6Xac41rLusy8oMYLj5uZVQqxFinfMIqqkHuhFWWo1BuRwa/DnweThxCotd8AIzbDRl0zOVDx4aM8+Q/pk5EWrtXeTYiBqINkHibnfg2Boajmdl6kt6GuF3A8knZs0WbHeU89nH7Tvb6lwVBsNvCVxT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596322; c=relaxed/simple;
	bh=BNBYTrkKh+r61QPjXesr09akZIgnL2UxuB3fmlO0oaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNPOQXS/DS1Asngq8FDJo7HjLJdl3hegLBZ8/yKKHiAU0NKA1+7vymgwPHVgZGLMPYx8/kyBqpiGL40VoPR0P97arKH1eJ0CoJe7zK2h04lA4J91VL5c7E4A5a6XayRflKL1aWkxeUcTw/+M08biw9AijQVYZtjkKwSpbKNN9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ERSuohNr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9d41c1964so3402588f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596319; x=1756201119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=at/5eKe3PrrAbraNpLb6KoExLUDoe69Dgy/Mvb40QeY=;
        b=ERSuohNrCDyjY/Je7UnqxtAnuR1lFeZpQi8z0aeOCFe+Ws1MYxELdwSYR8XWcW9Hcq
         yc9wg/MCc9pb+7Pulg6fn15ye5xk7M2YfRlpDuFKM5YEPjA2mPwbKCOEdgF8MH5a3McL
         PYNbAMKXOwVa9St479M9Ot1MbeZ40ahlLkmJZc6qMyD+mvrFLL6vDOFt6KCg3uDrF/xB
         IWkHQi5bQtk8s3wxo7RZX9nz/ZJzvCCtQo5nC50z7agNynHKtOsJL7sD4EqkJq+Cy57U
         +Ouphy1Y98+T9ZUQJnsySdSNEhrM7b3VhtcLSMeNUyrvlo6BGfWqlvfi9i6ho0QUbCnX
         3ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596319; x=1756201119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=at/5eKe3PrrAbraNpLb6KoExLUDoe69Dgy/Mvb40QeY=;
        b=EDMor1C6NfF94hlbw02RSk2pZpmt5fyWsX/K+/kophT7LIg7MYg5cTBeRLdbki1tCF
         evA3tGUbM+3Q5Tt0qLMYS1OPOvgLTk4LBfVwRJqkLCF/e/U8jDH24aZfF5tA6zUzL4Cx
         O1kt2Ej+aNXahyTmKajPIk3FNS0YPMNgaWxw+fPys3Anzoqx++AXhvJYPl697kpktsmD
         m/M3/oc6eqE70YR93fWWW0isLGh+VaztHMRdv/GCfYFn3oSP2iyEA8mxcJn2C4VFKIhM
         TH8rsqHYkNixAwhCdjkOm+t7I/GX4Mtc1RtzU9WCuyPcWc/PwI3h6XaRLaevdOoWQpvN
         b7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUd19w1uCMhezkuLvG2BmqqGuw/pMmHz1f2YEOhN3wGF7I3HdsxMdUCbWEZIgi4rB85IIU2Ll/SDwIk+q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNsjMlSVg/vG4xysZELHRGgh74GxkUMboocoG0jUK7t9nbOcnD
	AxBc6JUQ8N6ma2M9N1WkvEVBiEfWEpMUu+49mif9+2OzLaVQT5uaei3L1Dg67tguIf0=
X-Gm-Gg: ASbGncumNkBBv87IKz0ji7p/hwtnF2MDkAA0M3HrIcwaiwzGTSNhszi3yqx3Q8JABHv
	7IKyjwOFOjyJtPTZqhfVIFDqfV1BmgYFusYJbzzPKT5UNtH4eW5sBsQag8beRLarSi27ek0Ipql
	JBBA6wm1DcGK1AiencU3BgSmAW7K8Qc6SxptkAu64qwOPZmmRAVqzamJTjwIEUai9GVyVP1QyCN
	uFPokT7uVZxD+vHH0lDj151yH44AmLoxWjAZn+cB7EoB0D1vZPRoSzJFaHylM3b071YHASvP/v9
	rRcX1YM7hjIC7sf/BSabAW3hvSUOmmmCJ/vjPxKzBK/0FgG0mPaP8Lnr0jT7WCjUwKXFnJcs9f7
	YyN2P3IjW4gk51ApKOrZVDgnB404=
X-Google-Smtp-Source: AGHT+IFkB5hfOSqRO9ucIKbwVALsj+nCtLLW02xqPar2YbcIy4HqcpvqEUmAihdf079LhDp9jt6P0g==
X-Received: by 2002:a05:6000:4028:b0:3b7:7749:aa92 with SMTP id ffacd0b85a97d-3c0ed6c4b1cmr1345276f8f.58.1755596319074;
        Tue, 19 Aug 2025 02:38:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c6bd172sm220059075e9.6.2025.08.19.02.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:38:38 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:38:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arun R Murthy <arun.r.murthy@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Xaver Hugl <xaver.hugl@kde.org>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/plane: Fix IS_ERR() vs NULL bugs in
 __drm_universal_plane_init()
Message-ID: <6f9fc3889e0c79d7ac2833f3a2a6ff8b047c2b11.1755591666.git.dan.carpenter@linaro.org>
References: <cover.1755591666.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755591666.git.dan.carpenter@linaro.org>

The create_in_format_blob() function returns NULL on error.  It never
returns error pointers.  Update the check to match.

Fixes: 0d6dcd741c26 ("drm/plane: modify create_in_formats to acommodate async")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/drm_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index beef2a06bc75..2f5a95bc0528 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -483,7 +483,7 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 	if (format_modifier_count) {
 		blob = create_in_format_blob(dev, plane,
 					     plane->funcs->format_mod_supported);
-		if (!IS_ERR(blob))
+		if (blob)
 			drm_object_attach_property(&plane->base,
 						   config->modifiers_property,
 						   blob->base.id);
@@ -492,7 +492,7 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 	if (plane->funcs->format_mod_supported_async) {
 		blob = create_in_format_blob(dev, plane,
 					     plane->funcs->format_mod_supported_async);
-		if (!IS_ERR(blob))
+		if (blob)
 			drm_object_attach_property(&plane->base,
 						   config->async_modifiers_property,
 						   blob->base.id);
-- 
2.47.2


