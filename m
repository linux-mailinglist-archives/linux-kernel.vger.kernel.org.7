Return-Path: <linux-kernel+bounces-866306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5210ABFF6D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD573A2979
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC7F29C33F;
	Thu, 23 Oct 2025 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lycZeao9"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F21EB193
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202598; cv=none; b=OU04p8AebxgLKxheBKd2VajhaxQg1StAIfPTU2X7prZeEtxxD01ljhtvaQ3NsXeWyVu6oxh8dRTM4YcD9kf59oRl5kmmwcRJX6bCl5ftKnXQaoMfyIs70q60kZpY3rR5bFg7GbE2I9okNVnFP1XbaT2KRSfDJg9JH3DgI/d3j8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202598; c=relaxed/simple;
	bh=OjQdk0BZdnyHlEpPWBMKC7iucCp4Zd2OGCyrXtd6FSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IThmVByyudZHCRY9DUDJU6LmDO8xGYh094FzDIdMEfqrU3pVshdDIwyu/qJkubuYNItaZ4W303g3tWbIf/pO4BptFbEkQiBnSqlvWb+VZqXeNoTaOuDSNIoS8eAqEjIg1F4kr6kq+27DEydjlWHOj2KMFfgRV3Zw7Yylj9MB9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lycZeao9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711b95226dso4361205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761202595; x=1761807395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBL9lupI6VldWKtWDKOusMstyfxtbMzxrKyxN/4ZaQY=;
        b=lycZeao9B1bsp0FXzKmSTLA98BVRs9Jq5UdLb1Mfozz5B8w244BuA1NxxThuAGBBdR
         OtGpcEbPL3XQuzRZd/0sakwtQJeyNoZqPh4k4XndjKDivJS39DklABYBaHWa6rS/SZLT
         ZAaeyP/D8vBeUuvUh5AEGXRX1CqgezWH+t8BjOsKF4Vc8tvejHmnifKnEiY/saaN7j38
         OIzUDnW0lvvkFayHer2stqr6HFm35ooIm5kcmp2xsOdlxTOtOymAEXjLoP2Q+zkkPBeH
         p9xRu3Y+9eUfLUvl6FozFrhyj9bs2Kr6Wd2nK6eFOH8gzGSvVaebCQKNPVEhEGsFAJYk
         Uvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761202595; x=1761807395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBL9lupI6VldWKtWDKOusMstyfxtbMzxrKyxN/4ZaQY=;
        b=H38kPlbEfBd0A8KRRb89YtqIzlleIRmZTIUKCMYFVukz0rIWajPmqLZvxWpadsihcV
         IRUKdbW8YeL340V3G0YH/jI6ddvDyvgMPciXbjsRGhwJTalIuUzxRUWo1zQbENQruCvQ
         COGkyqYQlrLjztuZn3PUaUbuT7P0cp+Ulic+/qSq/FBOFRlK6ijyFqAmTF8f713Xo3+6
         sjr4+EX0hOU3dBvtrPmlzThBXhX/Q+2r81Tn6d91o/CR9BuWo4XFTyUmLRs+fHiZZtAe
         Thzr2XsgCKJb+MHN6Ax4eTT2bixxl1TR0FoRP0mPl0ncQFFYC980J7+if6CIZQY4wEyi
         5Xpg==
X-Forwarded-Encrypted: i=1; AJvYcCUhAJpERO4iDqWeNJlBSMnK/t9AJL5mHjNfk/wP40RjJUB1FHSUjE2pdR87taDRDoL/0B2G+rL0UB5muGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtxntVAgJyWoxjRefhNxzHIOFXqHKNnLkjz5PqbcvoCpOKqNx
	P/MphLhnGNF8t1AjJCG/3A8+LTSSxn5FM3RxYvy9mCI76cPGHjxEpbrXBZdmbV/+5BI=
X-Gm-Gg: ASbGncsjBkRZgXp/+7f2C4n85/rbcjtJ0tBBl65pMcv+4LrDC6CQiMErp4i/x17GXWY
	3i7u3IaaOcYvBMweL53zUWGPgh8ArX45Xywpeh2kQOVqjHE5vnSdccYKHJ8ZOq31maeFcJbbUJP
	9MoDgMt89yH6f6RLjLkxBNGPyMXptApfZikJlU8CnHS4WZG4eAh598HpF2LNKCi3tihrL0uMpWF
	A2KvnG+RMDnTMUMK3CzL4wqVfb4xwkPijQtePUkkHqWkZc+m2EydM8rhBjNF2rltgjDVZtramqa
	EgZTVHsLp1N90lFgQ9oPK1RQVB7DZ9mThTmqty3wrHRjDty1kWITD2VoLpw3hOwS3/e5dpxLUBm
	X/K3UM8pdoL/hO7ELkqY0B1T6JHuQW3cw5MZjFG4tvwUBTXnR8gY82+JTTBHGkSkbumf+MqUFIu
	NmQN29J+Y=
X-Google-Smtp-Source: AGHT+IGpQD/mtL5CvJA6o/mUd4UXTKshusdC3K11xj2LRMgyz3ANFxCnibnxcRJODpBqSTGDyYLPBA==
X-Received: by 2002:a05:600c:1493:b0:471:1c48:7c5a with SMTP id 5b1f17b1804b1-4711c487d74mr115681885e9.9.1761202594902;
        Wed, 22 Oct 2025 23:56:34 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ac30b4sm52576665e9.2.2025.10.22.23.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 23:56:34 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:56:31 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, linux-clk@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: imx8mp-audiomix: Use the auxiliary device
 creation helper
Message-ID: <4skca2rmh7pfasmptplp24uucst264idevjbjhid4uj3fbxelg@ap2mzqkmbqtl>
References: <20251023-auxiliary-v1-1-0a16fa4c3cdd@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-auxiliary-v1-1-0a16fa4c3cdd@nxp.com>

On 25-10-23 09:49:32, Peng Fan wrote:
> Use the auxiliary device creation helper to remove some boilerplate code.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

With Frank's suggestion in place, LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

