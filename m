Return-Path: <linux-kernel+bounces-755425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0845EB1A621
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2823BFC68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64321B9C3;
	Mon,  4 Aug 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFGGKYjO"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A62BB17
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321680; cv=none; b=nfccxQIogNmb+6T2NGUzmJWe/vRSZMQmvnbo8J/l0dJ5UmZHcMvcYApOzQU0NCv9Hmq0FOzaHdyaCGUDIktwK651vrBDdpVcUaI1snOLKs8zsIeHMfpvuJu+xZ7euLsL/oX9IB2DvRnmGKlFubAG16BafKoaISQFNNwW/JuE+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321680; c=relaxed/simple;
	bh=YXfq8eSdlJuxwFCJRwIx5eZG8veqNiNTYrvSf9opzdI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d2otZMCD8uLphIhcTR3U0Pl5KMvw+sEPbH0IuxFmnQe9CL0EKpGQ44oJTC9UX0stVDSk7d7jN1EJ7ls3mDOeg3KVWBfdm+g1FT0lHEIlbZSTaS8+Cb4ix0VCaK6jBp+mO+noC8XQff4QXKl+AvlYYBJGDqGzFpGIJvVTR3kXRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OFGGKYjO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78315ff04so3644497f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321676; x=1754926476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP/vyVyUPS8WNIUqsnkkJp8JWYjpnaKX98zCW9jQC04=;
        b=OFGGKYjOth38h0+g6g/7U3JemlEEC/8LvtvOHpV8Gmw6IVEfPh0zQui8phnNgCmaH6
         L6g7VY7mI+l82wacd1lxCXi6N+BMRzNmBl7lJ6Xodnb9EpwcmtDthOdQDySFinbP/RB6
         Ec3oofHD9yycOjZs39U306zy08R2iC+DnCQo2lFQ8xA6ko/MXzqVHrR5mpUW9Yii5RnW
         L/Qd0DDJ6x08a9Rv1gNlwIL1Zli6Oh9phnuOyPMrj56oiUXUw2dIa+i4BwxRfxs9FQX8
         /ra5WnMIKlpDMoyZkB76Eybjc0VAGLGw/m+lw+duzy0i1moKQsvUiQosWqm3QIJjl/Hi
         8vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321676; x=1754926476;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP/vyVyUPS8WNIUqsnkkJp8JWYjpnaKX98zCW9jQC04=;
        b=bI5YJ/M2fR6yLa82wabYK/tc++htKuW53xxeiExHvMRObU3K5c2Nst6pnsR4UKdpDV
         fYnh9/djSH2yDT0yDuTV+Q20j06elKqrGIXfgTcJRadvvX5YiNa/03ppt6qJRPhb2Xn0
         xssr5/4KGdYZyoTVK62HFvOZuVXt/lXAW5pthz61NTnqOsAsjY3iO0m5NiTmWufo3wQo
         6gpc3evhTxq0ut2yjXW/U093rQ1GUl5aTuQx0zOkeJivxtHiR9fRWbBWgqal9ePpNjMV
         RIQyRBPUYTtpbGNkKt5uxz9clrjj/3UfZiefyAbaKEjPw/YbMSyDTLALJqqf7y3vJIh2
         L2wA==
X-Forwarded-Encrypted: i=1; AJvYcCX1HuB0Unbg5ECiiEfhb/Y0swRfWPhoMNlWjgkak2niItt1ChA7sSztRjIKZf3Fnw9IDiLCfmsF+61JXoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bVmcRn8/4aP+o9H+67c/sMvb9KHZW5dATLX8NIZ0C3+d/TRc
	MYhV/fC9fOlF/vuSVS/s8d/HiPplZOKiDYFKWxZdiVxvTSnR5LCZCIZBry27Rj6NZNg=
X-Gm-Gg: ASbGnctMvzfRT8Jl835QlaOHXVAM0LukOmfijit0iBrN2ZCRO5t+SQUazKvl1NvlldC
	VdsnEXnpVxso8dnw6j087WqcREZA7gO7+wdgclVORfibttwvy8MD6s9tXi7iUtsiI7xcmuJa1zl
	nsdE82xa6dOaBYGZdLwf/EdFq7XsOCpYzxRQcw+BK/1JVh4iggZ5gOOgp/nB15jyCcC+s6Ci9vb
	w/yq9e2WTM7H40d9vbSJBq1fdxBqiVSzIPTHgvNRTAPt8J5cwYYkWjP1+sMuOPztNCzzXtP3WsS
	tnqtb4Al6+iot1t+bwOuDs58EC1vhr48jkQnP2RxJoPYN5wa2mNHhqdbMz0CYk7BI+8FlWrzQUJ
	SqKNaE2wkHA0/6WSPKB/9nPAFv1j2L1CLzHpaXC8qK/s=
X-Google-Smtp-Source: AGHT+IHacVKTZRSz25+eAotKNDY4IU6kgNCfyI03oFOmR+EnMi/3U/A2JXjBCEeT22ax+koIXvlpeg==
X-Received: by 2002:a05:6000:310c:b0:3b8:d22d:a8ad with SMTP id ffacd0b85a97d-3b8d946ad3dmr6701130f8f.3.1754321676272;
        Mon, 04 Aug 2025 08:34:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf956sm16206459f8f.24.2025.08.04.08.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:34:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250721152818.1891212-1-hugo@hugovil.com>
References: <20250721152818.1891212-1-hugo@hugovil.com>
Subject: Re: [PATCH] drm/panel: sitronix-st7703: fix typo in comments
Message-Id: <175432167542.3675907.15086744789768610853.b4-ty@linaro.org>
Date: Mon, 04 Aug 2025 17:34:35 +0200
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

On Mon, 21 Jul 2025 11:28:15 -0400, Hugo Villeneuve wrote:
> Fix typo in comments:
>     souch -> such.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: sitronix-st7703: fix typo in comments
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/cf9710a0a2ed490bd3c6933ecfc22556894a1df4

-- 
Neil


