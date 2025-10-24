Return-Path: <linux-kernel+bounces-868358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D19D8C0508C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2980E4FDE41
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6F9305056;
	Fri, 24 Oct 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbX5OGka"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B24304968;
	Fri, 24 Oct 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294318; cv=none; b=P4jqpuBTYYffsB4y60wsgBL5e2mWoK2CPkE9yJgh8iy4r2oAETxTXrAt5t6JYV1SW+u+wsAgH0iM82hsuBavCG5XhdKQbqPSkam5SqJg3hcnW3mygOgvKShcFxvcHNFj/jWg99DTAoHo0ng2NXncF5m6u5nlHKcdUBfOQ3vu0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294318; c=relaxed/simple;
	bh=Su77VAXqOYKI/uPo+vnRq2iX0IBZ8Qp0155copD2Rp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlaFXo3bpSRLhdeRbsBQVvtVUS7ZWfDdBS7S59IkzDw4Nb3nUlIvwRFLrb2bUJmc8fkUeYfl3zbSnwXlP80MJ+kPfDtf7TF0KZZDQWKS310zl/hn9Uc02cT1gh96V4pMUJ3rczvnhs92MNl/BZdWTpIshgDu/cjQNZfMf6sJ+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbX5OGka; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761294317; x=1792830317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Su77VAXqOYKI/uPo+vnRq2iX0IBZ8Qp0155copD2Rp0=;
  b=TbX5OGkapoyLFrWpaSD5BOwfhK7Ysq0PW0alQcx6E/VpsurS0fFAud3D
   TP2Jrijkt/5f8q/d1xKkrqJS0hodbJuwY/ep8EpFOqvobzuTUxRSrq8mp
   v7lGPJOkC7DypgEcNkue8bbc3NlYZ+M8iVPI/Hv/aKXnct4b0re3XFLnh
   ZboqGo/wS3MeWy8N8Bt1eUM89RP+yk1hRaFT+uKn/E6TxlSoQPa6udqS9
   avE/NDJrsCISJqKq4wLV5+RBpl7XgoFxGRfdryRPm/sSBa01eQX1AzFd6
   PBVRxLKF1imR47lrDTZjP+UL030jyyiVclD67dZaPE6dt1rvwsRzkgcW7
   Q==;
X-CSE-ConnectionGUID: jBndhUaKQOS/in/+fqpRfQ==
X-CSE-MsgGUID: u3zBr7+wSjKS7va9UeEXWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88941818"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="88941818"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:25:16 -0700
X-CSE-ConnectionGUID: zSEWs0AsRK2pZW8DgxM5Gg==
X-CSE-MsgGUID: 7AQ1HnpnQ3CYhcbzXYq0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="188669001"
Received: from mjruhl-desk.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.255])
  by orviesa004.jf.intel.com with SMTP; 24 Oct 2025 01:25:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 24 Oct 2025 11:25:04 +0300
Date: Fri, 24 Oct 2025 11:25:04 +0300
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
Message-ID: <aPs34Co-8UoQWuim@kuha.fi.intel.com>
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-3-kernel@airkyi.com>
 <aPnrKFWTvpuRTyhI@kuha.fi.intel.com>
 <14b8ac71-489b-4192-92d6-5f228ff3881d@rock-chips.com>
 <aPoZhBdc1M6Qgfae@kuha.fi.intel.com>
 <6f769567-b383-4c79-b441-3dd84f21cdae@rock-chips.com>
 <aPsse5qVL84XOj8w@kuha.fi.intel.com>
 <9ec2189e-ec36-4cd8-9713-beb490b8297c@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ec2189e-ec36-4cd8-9713-beb490b8297c@rock-chips.com>

On Fri, Oct 24, 2025 at 04:12:47PM +0800, Chaoyi Chen wrote:
> On 10/24/2025 3:36 PM, Heikki Krogerus wrote:
> 
> > > Another thing is that CONFIG_DRM_AUX_HPD_BRIDGE originally needed to be
> > > selected by other modules. With this change, we also need to expose it in
> > > Kconfig.
> > Sorry, I don't understand the problem here? What do you need to expose
> > in Kconfig?
> 
> config DRM_AUX_HPD_BRIDGE
>     tristate
>     depends on DRM_BRIDGE && OF
>     select AUXILIARY_BUS
>     help
>       Simple bridge that terminates the bridge chain and provides HPD
>       support.
> 
> The tristate here is empty, so now it can only be selected by some TypeC
> controller drivers. I think it's not a big deal, just expose this item.

Ah, got it.

thanks,

-- 
heikki

