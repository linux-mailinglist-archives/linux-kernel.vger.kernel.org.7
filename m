Return-Path: <linux-kernel+bounces-775297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E08B2BD97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A416835AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDAE317718;
	Tue, 19 Aug 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blORjQY7"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA82311962
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596299; cv=none; b=T9TL9kT4CbZeOt6i05ObEcq2ZYgpsYDi/ubJv+/3zukpOiy/dfbGwJeit4vi/hBqTD0iW3hbVrzpsihaBtxbhCWV9DcmsuoCsdubVNfE/O6ZJft//pbsTm2pQc8fb3NIvhN8hlm/XvS2ncSRTWQ5z9ikHqIx8HXC89xWnC2om0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596299; c=relaxed/simple;
	bh=zht4X6LhFA6Wk4fQhC81d8Zh6H/jmZAwOPkW16px3SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gjUaGUl/ipJjCP445/jh86RZJ4liKqXZAPS+ipmHYClG3K4+KBprbL6EG8wzmB7JnFBclfHUwuCnUjv0lzXxRPtQUzA0nDX/F9YxeUEYeBonVLLJUJhXonn3TAaM0a7q5bAlVh7wwzRWDbocsFrYljeLq3Idb0pShZX0TUtXvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blORjQY7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9e7437908so4927782f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596296; x=1756201096; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLBxZ2XFo8q0Rxn5F959lMnUzEFlfrmKWedQTzD7m/w=;
        b=blORjQY7MXuRW/A8wmdHjA8n4o3icDJiSSlyo7PaL0jfjtNXfmdPkGU406AW7DSirl
         Bwnfsods6Zrg/9lfyBJeWLCfZuravZCNOt10LdbDgh/qoP4S38AKl3Wn1TMxyQ/Gdd/G
         4V4LZf9rUVSOdveJPdYZfdWdp4wgKItRhOkIX881XlidQ0OTbmZPFJ0pPTXLTVVDGeTW
         BBKplQeLC/PuatRAF3bI4TuwspjAU7iErJ6FFnHcWwnO/YKCAdElEd/fxJTjrSvEBgYM
         Y+E/UyyGgC5ta2c28jhjqZCWYUHb+k3NrcfTpAdRYG0A24h9mza5Ys22b2fqCnj+rH2T
         tTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596296; x=1756201096;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLBxZ2XFo8q0Rxn5F959lMnUzEFlfrmKWedQTzD7m/w=;
        b=GV24SlPEw8m5TAN+6ia9MYse8vhqiDyvLFed+NyjGMqu1kT+7VyrbzUVSGusLObF5p
         bV+jjWx7uRIfLcgfUqHNU/Z7x9fJi0bz8SG6KgugUR9YvmOedvpb4hFCxrPCFAcWHw5Y
         NzK/76qzWbBoUFnZ4tJgx3cD60ryPamqJz2VQ617AkUx97FteLBuFSNrPKLbPXGv5OQF
         vxxAOpNjszG7uXgTddQgx82IAcvu+T211kBMXx6oDExzag63ijc4O6huqADsFt0HnuVy
         gsPXwG4l4lPfkrfiwInJXq0cZBpYI779ABvpIHnICoZ3W2eYQZ+0CSnt+9biKNMkXCQX
         h55w==
X-Forwarded-Encrypted: i=1; AJvYcCVLZdE9K5n8Pra3nlkchcZ34NZ7Rvdl0R7jdvMNtRK1bV2bEFBkLIT8iXGnu3CI6wI55tRJknhdM5tIL3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26oOMz/xXxti/CD6UJBA8JNp6+mo6JEGAFDXls4iQsXj2S/8w
	rzpq0K83ucfysM5qBFkFSUu6AyybcASLbHKLuAlomhOsWKZ2xSd2XRBVH4yyamKoXMI=
X-Gm-Gg: ASbGncuvIFdX9gNNWJBJOEPqUPt6k0CPvGa+aQN1rH8/nn9qX9VM+RGPH1xVh2ravcT
	9ArMB84KqtZNm9FX3wgKcSFpC0Pp7w91Pl2UomwaickzdtafCcrFAxv5oKnOIqivGKdxtuSkT3x
	mKMLWfWkUJfxsSF1HnvCBhk5MfZht4tcVxfJ3UTjvXyhIr/qMhaBkDqk0iv+tufBi2AN0peb2Jk
	tWZ/pUOx4r5w22zFA9zbJCUXdPlY0KP0PRs8DUQGHShimW0UnZEAcb0AdQM44VjEJiZsedc1ML4
	OGeOIXKKLDxcyUNQnLgj81yGYusxpTlUHSrKxYLEA43Za8Lz0vZBgA+AxfD4dQKrBzubCzTj1Mm
	yIlEBS3abV9d2rFRrkHR0c76/xba+PukmbRcb3xIeFZE=
X-Google-Smtp-Source: AGHT+IHaXceFYqPqRKvPcN0LOYanA0xMBHQBhtMGDdnYq7Gnkt0uyvBK/Afn6hD4lEvXnVat0epI+A==
X-Received: by 2002:a05:6000:26ce:b0:3b7:9b58:5b53 with SMTP id ffacd0b85a97d-3c0ec660768mr1387363f8f.45.1755596296412;
        Tue, 19 Aug 2025 02:38:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077c57aa0sm2974446f8f.66.2025.08.19.02.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:38:16 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:38:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arun R Murthy <arun.r.murthy@intel.com>
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Harry Wentland <harry.wentland@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Xaver Hugl <xaver.hugl@kde.org>,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH 0/3] drm/plane: Fix a couple NULL vs error pointer bugs
Message-ID: <cover.1755591666.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These are a couple fixes for NULL vs error pointer mixups.  I had sent
the one earlier, and it was Acked but we forgot to apply it.

Dan Carpenter (3):
  drm/plane: Clean up 0 vs NULL issue
  drm/plane: Fix IS_ERR() vs NULL checks in
    drm_plane_create_hotspot_properties()
  drm/plane: Fix IS_ERR() vs NULL bugs in __drm_universal_plane_init()

 drivers/gpu/drm/drm_plane.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.47.2


