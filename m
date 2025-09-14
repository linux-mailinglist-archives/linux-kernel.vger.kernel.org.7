Return-Path: <linux-kernel+bounces-815571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F4BB56858
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3F717677E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8731B259C83;
	Sun, 14 Sep 2025 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrRxzcue"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC9263C7F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851723; cv=none; b=NfLW6+lt9e4imdxXNin4GfypTIN63GXVojo0beZbb0/j4mXkrIe49JtAhN9tmOkwSZfNFV2fWYYPamJCNLSaA5tgcj2VE170G2MvdXbUMQtcngFYQ/UU3uLPzEf+5wKAfiRcRsIaPVjyzCPi6GEcd8EuuJhPcPDMk/dpX1Ur2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851723; c=relaxed/simple;
	bh=/vAVhu/ngR4yHd05XqGLRzyRf/JzOKMB5L/10fK0Kk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuX8dH6dvQeJrpvzquuFuPc2Cn0/jOvxu+lRL/PEQLZSv50ruFOlv0sxcOtQwU7JojUHDi4I8EVQ5D+oKDhCxK8wB/xN9NyzcabKHhaqjo0sP2tITfw78aJzEnlrI5v4oCXIxuh+QmqxFETZ12qrDSNW2oR1wiJcHU3o/TrdJLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrRxzcue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757851721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGC4WoAJlpX9tdCXckzAZr5W3saj1ZSsINit3PsYuzA=;
	b=IrRxzcuerKGkmLHs1PqOA8Tuu7OQdErUFgfGpcaHnHFMNG6w+IzbVpTPwMNbUwW5KWl33h
	uD8CnDHIkQRa2umaNxUJz4meuJ1jWKdx45k/79curpZvGJfaiWnWCSbapbUj69ex4Jxu4j
	YOvRxO12959gyiQXtDaoh5RJJpeOqrY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-q9O9FHEVNsyQVh1MWHyfyA-1; Sun, 14 Sep 2025 08:08:38 -0400
X-MC-Unique: q9O9FHEVNsyQVh1MWHyfyA-1
X-Mimecast-MFC-AGG-ID: q9O9FHEVNsyQVh1MWHyfyA_1757851718
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-827061b4ca9so198346685a.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851718; x=1758456518;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGC4WoAJlpX9tdCXckzAZr5W3saj1ZSsINit3PsYuzA=;
        b=AC1AP7Szypaaf2YuyalAE7yW34uB6+3Wqn4WDWBMjuW/s2T9M9jDY9XBAtiNP9W9oo
         Mu1Uz7i70DgApnjTByj1JQOUR6WYzCxqU17JvMUxpO7BvKwEhkJhn0PCDz+zCW5yQK+7
         zBQPwff4XOMBKAQPEJNhRhK9n042e/laj/lMheJmW87LvLiMsRe8dKpG8AQdxnsYcdai
         wXoR7LvwNUQ139AetaBf+zVn1lIpoT8PjYPiRMM9ANrMzJiBnbCuo0nENJSQCK667W/D
         yoksjqb6uxZD+tpF1Gt3sRs+m7q66+Wkxq4KCW+170z6HicffnjvXYX1ehQY8JcYd3sv
         w2zw==
X-Forwarded-Encrypted: i=1; AJvYcCWyx5du8Zlp0l06kZ1PNbXcDIb5dYDIxu8iiAQ0aoLnC8+uPhvbBrntmRVdq31mUTbNyHSKOya0G8iJ5b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdT9HVD9XggrhuH/bJwh4RcGR9zYuKukEh/BkGKqJ8RXbe9J0
	mGMky6UVaHGAvYdrkYbNMu0iIXekN+hV88L6zfnHlOXD1ZQ9b2x96RKkdktPgiJEddZcLtYEWGj
	Tu+QE9dHUiXAVG+lG7Pgc0NfYmuS6YGFCNhaZIEFwol+oSrEbq4jbaamYqwW5Pusekg==
X-Gm-Gg: ASbGncswNoQV+pbtZmtbgR4QAsvbwYiuf/8LF8RDWWHCxNWGa6k2aKxXYclqnVwWvPh
	dET5lMleHUyeG+S6W/YJ46hS1zszOBu8nXdGRYTteMxmiQWyNSIhG+R8RvX7mFcgp21gd8ts3Q9
	RPwpaU08GfpNV8XoHRE7EDc1IiiFOanKV8TC4Y6l1hV1CZaMyXfRD7XZnOweDGsQ4cUXOwOCpX0
	bun4DhoxdaC/EOJZ+H5oxkrZsOAmI7HmuvSM4xOjaaDevNWOUa05Pu1QZSwhBlvuOExkBq5dG3K
	CHzi1DCQ64pmmUGGI/wB3U3TMGxTII7W7RXBVgrM+9zz43uplrq38FwxEUkYSY050VngeBseGKn
	9D7owxoJf+zYa5Vl++O2WEVzik5Jddgw=
X-Received: by 2002:a05:620a:c4f:b0:815:9bd3:72a4 with SMTP id af79cd13be357-82401a95c9bmr1036168385a.69.1757851718237;
        Sun, 14 Sep 2025 05:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRdCKGXPgtbhvJpUCdDwCaaC2B0DLna/CzbBAvfkLzYJU98qL9IvUSFcqawGBto49lPMPxgQ==
X-Received: by 2002:a05:620a:c4f:b0:815:9bd3:72a4 with SMTP id af79cd13be357-82401a95c9bmr1036164085a.69.1757851717778;
        Sun, 14 Sep 2025 05:08:37 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cfcaca15sm580413985a.71.2025.09.14.05.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:08:37 -0700 (PDT)
Date: Sun, 14 Sep 2025 08:08:33 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/9] drm: convert from clk round_rate() to
 determine_rate()
Message-ID: <aMawQYUIjPw9m4IO@redhat.com>
References: <20250811-drm-clk-round-rate-v2-0-4a91ccf239cf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-drm-clk-round-rate-v2-0-4a91ccf239cf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi all,

On Mon, Aug 11, 2025 at 06:56:04AM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops, so let's go ahead and convert the
> drivers in the drm subsystem using the Coccinelle semantic patch
> posted below. I did a few minor cosmetic cleanups of the code in a
> few cases.
> 
> Changes since v1:
> - Drop space after the cast (Maxime)
> - Added various Acked-by and Reviewed-by tags

Would it be possible to get this picked up for v6.18? I'd like to remove
this API from drivers/clk in v6.19.

I'm not sure which tree(s) this should go through. All of the patches
except patch 1 have at least one Acked-by or Reviewed-by.

Thanks,

Brian


