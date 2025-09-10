Return-Path: <linux-kernel+bounces-809607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0EAB50FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95796484AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BC730C34C;
	Wed, 10 Sep 2025 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rs7U6Hao"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1BF30C375
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490101; cv=none; b=GribkOC+MqXiVE79JjbeLJpjFaV36u0YdcviWH2sU6mCB1pdwdCe12Qt/9Dr94SMzHf7Wbs6JPHg58p+2MC7cjUFnLodpAiZP4sNaTB0QjGbmaDE9H9agfK4dvZx8GlGBc3HVwH43vnWnfcxmuMvuKXHBpExuE69FXUdfeCu5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490101; c=relaxed/simple;
	bh=JmH9GT72LpyZXx2oO4ESoVlCeKOrOShfdIfkBTVS06s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N+XEdsvDpT3ei0Bq470LP71l+tj1y4vD2hP6z/mS9R9TbFfLHeF96ftwiaNNGR95CAIbPy78ynA7QnFx1+gvi4nOQmVHt1QaZV9H8eaowgXVZE5oyMGZbhD16U6UZ5xz+GtxAaC0UHzHATmzFLcEHW/y+DTcNXxnKvF+66R6tbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rs7U6Hao; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so4175422f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757490098; x=1758094898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtBMCZXPDe/L1Aera+ZphaSp5CFgLXQkaXld4/92fyk=;
        b=rs7U6HaoV3jfB1aCrlqZLKlRWAqr4lh7l+a3+HTzB61LAXqtNnQhoSGJZLckamq9o+
         Aa1s4RksghyHXCKOff+GU9A4rhhW2DAnPxoTlnGbuavnugVfmiOWDWrnNxtWHGXb2WAS
         XjX+ybl2UjRDYaWWcVxxOHn9y6PMzNlDBhLoxDjDaaVE40ZGd9Px5yIYpwreaNfoK3Ns
         UTESQutGehF2/uro/7ybe1eCwHN9zIqSMcVtAzjQJPXX4r18PHYWOE+/dHjVRlnQFndb
         DNxp1jJ4iTFJ2xo5gj+Gvsaz/RLeLO3blre0k1F9pq6XgCxpT/dkONPAftmDZUX0x/A8
         NeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757490098; x=1758094898;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtBMCZXPDe/L1Aera+ZphaSp5CFgLXQkaXld4/92fyk=;
        b=ihpgBhssBA/R0U7NvT9VRiwyGNi0nEBwXY+2+VHf7l+k17Jz35k7GpjPx+bxcIgVoo
         JBNnGMVeP7yD/CgMN+/a8AJNYdpmXS42RB07BVcAQWYvHhrMIKZov+hGwmasJDF6+3x3
         no5SLGUhB4IViBl/nqcy7amTHGkCHiVEVxK8D3v6TS+IZJyym1Pdke+bghgmdbZhJuv/
         WcjETl8b7ub6ZyL4XjRNT9eOsxZKmUChZGgv4CZa8E1So1+yDb4lP40fQhulSpOEGLEA
         T5QKT9s82UnLz5vFEmGcnqED/KX7/ZYewGJzy/sssNi3hbfjPhEHmWAaD6Hi19qpd3xd
         n2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVIOCUQtO0MoyHqw7zHp+85F+uM9x9bScSy368x4l8iosVx2NVjyojGfvBiMgqY/9YBCrZc8N1BOS5J1vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFeUyO0yQT6nuyd74fAyWydiWzwWSRrV1DZcyTysGfNR2JQKgS
	plj413ihWAR9bzoJ6ceUO507YswFysHNAGJzWFyentsSfZLdsNtjBE7f1rxiHIMQNGM=
X-Gm-Gg: ASbGncu+LCmr1dfGm5U6CoQr9yINZO+ZYNuvPKv1lh/ojfLj+cloRl8n8AzCWoqward
	me2l6f5wgdj2wMTFPWyay7fPreRAVT5ay320B/+Am0zvmmJZvd9eMtQuDo+aHOL4KjOgpY0AYpN
	3W+9qggBOqoYR8/Zeuzz6ShNWAb7tvxZGrkbrvwcPemV/VFhJSlNxT1RemTDywmtxje3cnzHlvm
	Gv8kxCgPSMzOukf3+PFiF9IFSDsCBXuNgxqSN43xG1eTU78HcHQuG1Zr566hD9hGRt0ILuZ9aZ1
	PDsnxoReUzu+ZHAcfg4ePsrz8Ae2gBRY3SA2XajFitDWvod7E10h+2N2BIcafzxlXLOSLgM3ee5
	oRJhcowGe9U/EoxNwOlwUOXBdTXK/eiOYAwIu6NHZDPpVUHt7hWI+iRqkeIbGbHcd
X-Google-Smtp-Source: AGHT+IH3qq2tDxg+cTZMTeDKbmE+EV30unSE7cfrGi83s7nwsGI6zF0cGpJrbn+Kkyr1dX1PgI5lYQ==
X-Received: by 2002:a5d:584a:0:b0:3e0:152a:87b8 with SMTP id ffacd0b85a97d-3e636d8fe92mr9774755f8f.8.1757490098349;
        Wed, 10 Sep 2025 00:41:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bf7ebsm5995264f8f.3.2025.09.10.00.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:41:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Carlo Caione <ccaione@baylibre.com>, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250725075429.10056-1-johan@kernel.org>
References: <20250725075429.10056-1-johan@kernel.org>
Subject: Re: [PATCH] firmware: firmware: meson-sm: fix compile-test default
Message-Id: <175749009786.1189544.12133292014969519792.b4-ty@linaro.org>
Date: Wed, 10 Sep 2025 09:41:37 +0200
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

On Fri, 25 Jul 2025 09:54:29 +0200, Johan Hovold wrote:
> Enabling compile testing should not enable every individual driver (we
> have "allyesconfig" for that).
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.18/drivers)

[1/1] firmware: firmware: meson-sm: fix compile-test default
      https://git.kernel.org/amlogic/c/0454346d1c5f7fccb3ef6e3103985de8ab3469f3

These changes has been applied on the intermediate git tree [1].

The v6.18/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


