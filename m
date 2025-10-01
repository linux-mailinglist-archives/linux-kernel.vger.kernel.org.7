Return-Path: <linux-kernel+bounces-838528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05BBAF65A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21571921FA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA44273800;
	Wed,  1 Oct 2025 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLD4xT+Q"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802CB2309AA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303470; cv=none; b=srdRFFD7aEaBDmGXDFAc6LfFHJ1g+FMkUu6sWJp59weekm6mbqJthCw/62UkTvP6xL4yfa3Z/BvhENGTLq2dz0l5VLVezxiu9+4f7bWzCCe5+LeoTnOXoYtgCKsy/X0WoQVKr7N0sXdJNqtyqNJXqUwXfHEAogaqWxf/gcXjsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303470; c=relaxed/simple;
	bh=99waboYNJsgUn5GTMgbiFGdFWHm0pdppWzrt3+nNXUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cI1HB0cpMsC0ukzu0oqhTzv9/9R9NX5j7Vrc1pNTOU+uu/p0uWbbOYVhBs4x04ltP7ZzZ/bx+KpNyZlXwdAPwfJYbfhU0Nw94JsNK++LsEwzXjFMKkkU8NQsp0vslN1AyvotVeuI5glFFMXdbxwVLF3jbM6K/gujD+UqARPvock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLD4xT+Q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso42213705e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759303465; x=1759908265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeCJ3SwyftHMw0airnJwEwlrbv4c6ebfFx7pe6MtVRo=;
        b=pLD4xT+Q0fnV0jcWD8eCth4ZVhP0p2udMvKlZBxfEqBu8AewNPMIsCOx0So2F7l0ZP
         5taZdXSnV/dImzIPU5eBxiEpG1l3Pek5WpnqYHVfelB9mJmmAcnhic3vKuGia5yksTLK
         NLL5RIQGaML6aWfejjchga+Ggf5xxVANl4bAcEONpm5cMObMtW3IVHPWQx6bVgY7dGhx
         oZUECuyTdaQgVA25VHIIfteDjMIFWzgMwwFqQj8laEKWztkp6bWkL6cwzVu8RkGupPqv
         zyK+UpxJ7H3PdfDFYRXeRAL3zVMwZDPJn9vYxeWp0GrXVo7NNA5yUgoiI1Pu+ylXnVQQ
         xy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759303465; x=1759908265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeCJ3SwyftHMw0airnJwEwlrbv4c6ebfFx7pe6MtVRo=;
        b=tWj+2AUFGCltysrqINOoLuVwgu1+guwvgm4rDj7tGNnaxLN0VOnis0A7Fm9v+1oDUf
         aVXhrThM6wEuU9U7PNkIZlfASZGwYAsjtzFmGomG6t2Qv0UJhVlZnSbP9IpQYjkRCvxZ
         sPPOgGP7r2cVFXqKXa3YYI0rS54DHt4287E7m72c9xq9Lstjr1nyVNIdQweM+aSPM5e6
         QDG4tpxqjgBodoI+9mWnvrHFkuXEJfBLia1hP2i5UG5TWGBfAywTp28MJJBkz84jh1W5
         6y2BCR1P/70L9oapT0CV5RnXAcrR4xQw5VL0LtEBsyXXTrwkAqh1p3gQaJd+leLd68/+
         fprw==
X-Forwarded-Encrypted: i=1; AJvYcCVfXlhWwtgdGuIcVXGvyTyF/g8sH4/lzI4Spl9RpWe90BVH/zdLrtJT30KinEZzZKywrTZDzVVkfhIapoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7D036bHdUwzDwhE34fWiOZGv3GQ2odDvT9QhX/Gp4Mgcl+H9R
	r/O8YSDDPpXqiIYua6/OR14yC9QN927X/VC0HLyXZDSeJOoSwsGsx2GCv72Q6gZP4lueeisd7OW
	yxnqh
X-Gm-Gg: ASbGnctME5R2HAMLger+fW284wrgAVVaIHWdAQU8/Oegzgh67OANVDOC5Qu5Gd5y6DQ
	pUAsVih9gtl4aBJlQ8DqbQxGiu6ka6veEkmeHkZPIp8WTAqELWtNAHN+Y2KTcDjmgriY0p57RpO
	CvVZILCXSU5NsYjDy0hzD93EkO2Sb1Yg89ZdiViEv373Ix/4k4L+QTHKG6DlLZfMEGxxomJFQbz
	7uUvK8RNgqnDowWE5y8eyyfSKG+Aalqy+aMG4Q3lW0jAIDvTDb+KPeDn7apL/he/zcGNMmayvgP
	f35CyOuQ2xkqa7zRuvKmu3n4+Izux+ViygQgQoJH9FPFYxQeXVOKgiJf/z00wINB2bMITzgeKZH
	4hBvorbWLEYCJ1B8CWfgU56V45UaoBD1zx7CgCb/vEfZBs1leGMa1Dre8lcGrMPv5Pis=
X-Google-Smtp-Source: AGHT+IEdl4XsbaJCInDt4HTeuo5oUgfE1ebcq3HCf1e90j8pjuSWVWqbjVTfAuHDD3TOxEbAqeiTMg==
X-Received: by 2002:a05:600c:3543:b0:45d:d68c:2a36 with SMTP id 5b1f17b1804b1-46e61281448mr18833445e9.27.1759303464618;
        Wed, 01 Oct 2025 00:24:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-410f2007372sm25047153f8f.16.2025.10.01.00.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:24:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250912064253.26346-1-clamor95@gmail.com>
References: <20250912064253.26346-1-clamor95@gmail.com>
Subject: Re: (subset) [PATCH v2 0/2] DRM: panel: add support for Sharp
 LQ079L1SX01 panel
Message-Id: <175930346392.470940.890356781501046012.b4-ty@linaro.org>
Date: Wed, 01 Oct 2025 09:24:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Fri, 12 Sep 2025 09:42:51 +0300, Svyatoslav Ryhel wrote:
> Sharp LQ079L1SX01 panel is a LCD panel working in dual video mode found in
> Xiaomi Mi Pad (A0101).
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[2/2] gpu/drm: panel: Add Sharp LQ079L1SX01 panel support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/306e6407ed96ca3dcae5e3dbec8cf207ea33fbee

-- 
Neil


