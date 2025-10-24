Return-Path: <linux-kernel+bounces-868273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E084BC04C05
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20E774F1D28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4E2E7BC2;
	Fri, 24 Oct 2025 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWjnR8sy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4502E6CCC;
	Fri, 24 Oct 2025 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291403; cv=none; b=DLpQH2LGs2pOdiad0hFkgkveCQepHcHFREf/Rg5fOx236rWvSfRza7gl3kCDJ1tIYAHKtawn78S1tljQLvvdzH0XdZxU/JQ+BXpK0fLJvjZMrsWsH2yV2BqA2Xmtt4R51YB/nDBGBlpt/VuxWb5e/qXXN4EMLBMm08orAeGPVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291403; c=relaxed/simple;
	bh=mWjj9l8sR4AQPWA6ugbC691Ckn2QjoC60AB1xOLd+C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maS4eDz4lZ2AM84R/nDOBcr10Zz2Cq5A3fAqhmjjyUbjDfFZwSXRHkvr9IyaPFbCKRoaeKAfmI6XXqy1v8nYrUlTn9WhFdjBuxhNExQvvjPMlou7HWcq4/TZi9/cl/B2X3JAWHdYT8c+TM/M5xOVsH1yObcvq0h6aTyDJXYRFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWjnR8sy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761291402; x=1792827402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mWjj9l8sR4AQPWA6ugbC691Ckn2QjoC60AB1xOLd+C4=;
  b=EWjnR8sydiQsP8Ml/gaOBWOx4BSRBDli/J+bvofRoTcyU96GorEHvbt7
   c7eIBhY19WHbPriPvOHn5lvp7ZgxEp5P4lA42ARFrlBsoJf/EKDmeLQMU
   vi40gm4BqMMnKg48hFhB1qYBS98pCfhFOMNydKCLxuHpQTe6L/eG7Ya6M
   zYzykQ8p54FvJt7ENiOwV9HRfjNeL1hRyhAyw3fyAWLn9AQS6q5EV05Vy
   JzPSnAZ2PDwk7xigYpu+npGVGSe5gN+A03OyXKQi76AduLucXRT8qPGXc
   Z+vlprgUEjO7ROmev6GggfFRkfwiUbig0gR/vyqBIfaYGob26IrLqSeFY
   Q==;
X-CSE-ConnectionGUID: jkBigyTwRxCyR20mJXmFIQ==
X-CSE-MsgGUID: gfsSofeITKCemhLmU3liow==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51048302"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="51048302"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 00:36:41 -0700
X-CSE-ConnectionGUID: +9H14C/KT3KpDNAQIA8LpQ==
X-CSE-MsgGUID: DcV1UYgvS0+g8hqqTwa8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="221566635"
Received: from mjruhl-desk.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.255])
  by orviesa001.jf.intel.com with SMTP; 24 Oct 2025 00:36:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 24 Oct 2025 10:36:27 +0300
Date: Fri, 24 Oct 2025 10:36:27 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 2/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <aPsse5qVL84XOj8w@kuha.fi.intel.com>
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-3-kernel@airkyi.com>
 <aPnrKFWTvpuRTyhI@kuha.fi.intel.com>
 <14b8ac71-489b-4192-92d6-5f228ff3881d@rock-chips.com>
 <aPoZhBdc1M6Qgfae@kuha.fi.intel.com>
 <6f769567-b383-4c79-b441-3dd84f21cdae@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f769567-b383-4c79-b441-3dd84f21cdae@rock-chips.com>

> Another thing is that CONFIG_DRM_AUX_HPD_BRIDGE originally needed to be
> selected by other modules. With this change, we also need to expose it in
> Kconfig.

Sorry, I don't understand the problem here? What do you need to expose
in Kconfig?

thanks,

-- 
heikki

