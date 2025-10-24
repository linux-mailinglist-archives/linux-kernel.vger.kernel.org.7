Return-Path: <linux-kernel+bounces-868296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267CEC04D03
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DD51AA1BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F302F5304;
	Fri, 24 Oct 2025 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYVxx0a2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4E2EBBAD;
	Fri, 24 Oct 2025 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291834; cv=none; b=C8cJrCzn10tpfT7VX3BjQ42uXzFIKWTuLd608kdtZMZ2aqFtFekIkDzpkM29T9jkbnB1mO9Kr+sm7/O0vChs25p/K5yjf732kevclQ0fN2pJHGwh/bV66XP+l55Fm+OedlwMm58sM5ItDre0nZp8hpy8NRHmNWYE6RA9SO0GqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291834; c=relaxed/simple;
	bh=7zI+yHusBy8iTPtjWgljU0yIp25yZuoATyi6HBS0Rz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS5DtIj0Ij7Uh3SZ0wUNW5fy37E5QrmLj37seC8nXs+sEuJr4v1ZBUwnuJXX0JHV/afjAilRs0FuxgmjKMn1VyI93sipEv0+wQNOSJdPAx7x+apxaszyfBmP52clLAh+MboBMlD3PeIFOqYr1A0OKpTnil0N0zZVI6B9r8J98A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYVxx0a2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761291834; x=1792827834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7zI+yHusBy8iTPtjWgljU0yIp25yZuoATyi6HBS0Rz0=;
  b=MYVxx0a2OQpZWdBgpo9e4Cef7zbGfhKHW/ahkUajssE8TrJaNZxvLMsz
   iYFLWZBwiMCS5IQK24S9kX0fuxK4grlriS5k4oh/YvGlMfvSZeVniHfCm
   WGBrkeGyTRFKz/iXpJCKJWbzapyEMy9Q72lb/+AvlHVJwOAeTBlpsy+E2
   uzGo0XJNeyokcxfa3c0PEEPbSyqdGckAh3KHorzIr+zfhumOYqG474YEe
   Qhg75s9elFXKSVjFg/jws3bCtfrtDm7yTGTNGojhuxHOT1wcDIpgqnu0e
   8UfkqJ8W0uicwU6cj9c6F6cumcAiTvUnbOXcWpwW4r6PWOaRpw3pnuPFa
   Q==;
X-CSE-ConnectionGUID: 0b45EmyKSsGExL3d20I2mA==
X-CSE-MsgGUID: x48DdNPRSxqXNJTYsegM6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63618993"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="63618993"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 00:43:53 -0700
X-CSE-ConnectionGUID: u3ao3ZWfTCKvdTwCgNOZbQ==
X-CSE-MsgGUID: i6w9uVJtSDy1AqasQ83mFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="188756837"
Received: from mjruhl-desk.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.255])
  by fmviesa005.fm.intel.com with SMTP; 24 Oct 2025 00:43:42 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 24 Oct 2025 10:43:41 +0300
Date: Fri, 24 Oct 2025 10:43:41 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Chaoyi Chen <kernel@airkyi.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v7 1/9] usb: typec: Add notifier functions
Message-ID: <aPsuLREPS_FEV3DS@kuha.fi.intel.com>
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-2-kernel@airkyi.com>
 <aPni4AeDaem_rfZH@kuha.fi.intel.com>
 <aPnvoSRJefwDlpNO@kuha.fi.intel.com>
 <aPn4-S7upPOOtenr@kuha.fi.intel.com>
 <3a24bd7f-c247-4541-8cf5-c1e66e2af5a0@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a24bd7f-c247-4541-8cf5-c1e66e2af5a0@rock-chips.com>

> I noticed the following statement in typec_register_altmode():
> 
> ```
> 
>     /* The partners are bind to drivers */
>     if (is_typec_partner(parent))
>         alt->adev.dev.bus = &typec_bus;
> 
> ```
> 
> If the condition is not met, the bus will not be set, which means bus_notify()
> won't be able to take effect. Did I miss something?

Right, that would be the condition that I was talking about. Only
partner altmodes are used in the bus.

Hold on! Do you need the port altmode instead of the partner altmode?
If that's the case, then we can't use the bus notifier. So we'll need
the separate notifier chain after all.

Let me take a closer look at patch 2/9. Sorry about the hassle.

-- 
heikki

