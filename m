Return-Path: <linux-kernel+bounces-834973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84641BA5F14
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F504A7165
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4E2E0B5D;
	Sat, 27 Sep 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGu+TwSL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003A279DD3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976002; cv=none; b=Cqdel3cX3p+8u48JGgmokffsXKEy4+oityYBpV485renQoB4lgHIu9y+tg5Rmfm67ldHhvh9CWHoLoHHuQlmmzeraI8M84+idrleRoModo5vJ3EEFuWTPrKBSsHSbVdH/SBhCMNBR/SQR82u7sX9djlrY+gl4k8aT2VjwjrlWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976002; c=relaxed/simple;
	bh=rEfNw/hjnn2toGEkd2B+EFMnUNcZZBiV2AONtSPpb+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JTaG+ilOqbOwHY+t87E8ZnIUa1VzoCQdCXv+P+iM36lqacjFB/EnOWFtjrFxt5O7jkbnTlzed7SAmuv4kKAd42mGHB9ucJkopOP2mX1GgtBEmENxLjGdnvFBtDvEnvhmFeLpCtlOJoh6xrJmXOhTe84T1cDITw77rswuVjDTMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mGu+TwSL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so1908455e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758975998; x=1759580798; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBLrdqiq83IjriqT+j/rod7j6tvQbgPiriXKTGAmd18=;
        b=mGu+TwSLQzam783tObyDcH2rLIFuVGYxNVre9MwoFMsGm0AhR2pZsgD95vGQM2KNwu
         dApDvVTuvreP1qHmXeHzNJTCapqbjEStu9D5k4cBt73HU1+c8COExHZ8dbYVwMpdTEEO
         1K+ZUqFXi9XFq5pBpdkRNPqKpZSvw17B66Qn41yT9M99sUpxsb+GeTiHyE/GQ3F78TmN
         k69Hxq6JsVnpYJHfKkH7NOJaS8KWBUIQJUBfOYQG/2jA5uEQUknDUFtkN7f+t8etLAUD
         YRTm3Mc4F5nph/YwuA0bTRYs7O7tXbUV8b0kk3FuJd4x1XaEjp3Q+k/5XIrzJxfu0qoW
         smSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975998; x=1759580798;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBLrdqiq83IjriqT+j/rod7j6tvQbgPiriXKTGAmd18=;
        b=AaXiSjYstAh+26U1aHUAGRgYujmhL8c4m4sAufGic3dtwVV8gM7lkg+Rn9C/VJ5zQC
         ak8kZXYPv1PASAqmR7CCZ9qrVM35NKdZYw6o3Qb4Hfpa0rpVnDBxmwD4Cpjwria15q+V
         38rkaFCG6nvTqtTCLzMiYQc94GUJUBBOOa7CHlp9tN9dAdV6Ia0EMhVoC3SCrxkg5xzw
         8ZG3Ub289HKkvTd2I878Aw+ptJH78GiMnvcSTEd118XjIW/mm5MyiG0DedWdWJgxi/3c
         XBeIRK2QJz2soqhkxMZnoSGaEwEVvA088ciSPSIkcMk2b/xsaXIKnJdV9kpfQi8bJPLl
         5Snw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ/qzZmZM9MJHy5zm2GBiLspOKaR4O2koIPblY4Haj7M8iIZsVafmdHcOCq999GC07ZRYCWwbv8mFlcmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iH1PFTwHrEupDDZ+gfK0TNRdrY19HXa9ss+hQtK23NESFaU1
	iGAhO3KOoepNGwnFamvktL1wir1ncbEBPRI046KblhjkCTXvFgBF6p+V2hBBf8bgW83hB4DTIax
	4Ojt7
X-Gm-Gg: ASbGncs4yyPpBztsz9pYgL4ZI5l4TP68R+LEKFTlsXj+Dbq6rxqjox5CnfrcPErE9/U
	O2iD9bZjRthD6SCe85h9eROQLwtWXqAADi82vQEFl1iDYWWwalOB+TQC8IF6h2t5MRmD75018vp
	8L1+HmAn9ipzZIHH0ZXbuIjIj27OnIExSKfcbF2G6K+5Yl6mfOVzgxPI7VjV7XPx6Fy5oS6DKB6
	L5cV+E7cLl4g0+jgrqN3vy/BrVHIuKLGnESQh2rKp77pRcJPKqzdc7THtOgrN5ClZRS3VPVMEWB
	5oFIgbffqqynWJLDjos5S7+IRiqwngsriHxpkRn8jPKGKBUZixPEC9k3moXAYRoaqvmTwitv0ui
	29ZLsjFlUNL1aV3Siqpx5CZKKGJqo
X-Google-Smtp-Source: AGHT+IHAvRpOQmkSxSm6b3328/ZthZojPK7yroebvNA9zjeMtFoBw69S2yXMKcVzb6TG7S93dUplFw==
X-Received: by 2002:a05:600c:c172:b0:46e:37af:f90e with SMTP id 5b1f17b1804b1-46e37affcc8mr86360625e9.6.1758975997952;
        Sat, 27 Sep 2025 05:26:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33b9e8aesm109617595e9.4.2025.09.27.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:26:37 -0700 (PDT)
Date: Sat, 27 Sep 2025 15:26:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] EDAC/versalnet: Fix off by one in handle_error()
Message-ID: <aNfX-qj_KpCrnCUy@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The priv->mci[] array has NUM_CONTROLLERS so this > comparison needs to
be >= to prevent an out of bounds access.

Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/edac/versalnet_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 7c5db8bf0595..1ded4c3f0213 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -433,7 +433,7 @@ static void handle_error(struct mc_priv  *priv, struct ecc_status *stat,
 	phys_addr_t pfn;
 	int err;
 
-	if (WARN_ON_ONCE(ctl_num > NUM_CONTROLLERS))
+	if (WARN_ON_ONCE(ctl_num >= NUM_CONTROLLERS))
 		return;
 
 	mci = priv->mci[ctl_num];
-- 
2.51.0


