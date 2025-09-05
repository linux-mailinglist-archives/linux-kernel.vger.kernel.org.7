Return-Path: <linux-kernel+bounces-802737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A23B45632
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDC3167D3B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E4E342CAF;
	Fri,  5 Sep 2025 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXwa8n18"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB272C158F;
	Fri,  5 Sep 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071235; cv=none; b=B8seYhPjK+q9C4OMiFnbba1KDsKsXq42aG0wZik6n/5VMcwhyC1zj8Q5XJVmZgv4kyTXLtaJiKHr/KOs06QxRdI3OSW6q/AcaW+edTji3ar1nCFPme2QuB4nCES6cxebP7LqCwgQ/m5KI1+nMS7Y9HB3DyF5dS1431jNNFZNe54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071235; c=relaxed/simple;
	bh=OGmWrJpLcXWxy4kOfWzDwFhNHI5GSrj775waIjsWVsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxwurExQJocprc8sgZmwcZ0orBqIBjQzKQbAcNgUnv4F1jVzqDY9rcmda7VgeAcNeXuVhpXHkN3Jqsy5ZU4htU8PT/li/BjbN2AmrqXsm/tDaj0wYk+TvkvooR8D9m5CHE7H2qMLqfQTHs27IFKUWApvz33gCJccEtgSktQlW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXwa8n18; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757071234; x=1788607234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OGmWrJpLcXWxy4kOfWzDwFhNHI5GSrj775waIjsWVsQ=;
  b=YXwa8n18lwQKIkjp28cdnWEEqMbWgheVcRLsc8fpRzdHt6pDYYjBk4Mc
   xFeX2i1IlcaWiRTkYKch0V+yopcNEHz61JACiW6Um6S7ZqgJsmHTsQdzV
   bufz9g1M3vofuUOe/f5aEJFNN6rSz7Y+KKE+lvkfa5ZTvQ7svhug/s1wf
   1uRWI0AlAHgsXa939m0nGe4IajXvjYxfZxgIsoYNOMJfBawVsjKiKsCO0
   swJQb2RMGolPv6EFUfjGGIBuxOpUbpZ43ARPGnx555PDyb51ASbvwKk0T
   LyiOMTgv/z9zjwRRj+ZrN45TB9E5rC3Q3isPTshmfIsy6JeVC4R0icbtC
   Q==;
X-CSE-ConnectionGUID: tmq9lQyWQa256oVE4LKvqw==
X-CSE-MsgGUID: rgAIsa9qQNmzWXkubt/kXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58633161"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="58633161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 04:20:33 -0700
X-CSE-ConnectionGUID: cvFrgh+1Q/O8gYdxESH4AA==
X-CSE-MsgGUID: EfmsnKDwRvajVzhRnqz99Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="177380651"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa005.jf.intel.com with SMTP; 05 Sep 2025 04:20:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 14:20:26 +0300
Date: Fri, 5 Sep 2025 14:20:26 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC 14/22] usb: typec: tipd: Register DisplayPort and
 Thunderbolt altmodes for cd321x
Message-ID: <aLrHemVPCTjwI8dk@kuha.fi.intel.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-14-172beda182b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-atcphy-6-17-v1-14-172beda182b8@kernel.org>

> +static void
> +cd321x_unregister_port(struct tps6598x *tps)
> +{
> +	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
> +
> +	if (cd321x->port_altmode_dp)
> +		typec_unregister_altmode(cd321x->port_altmode_dp);
> +	if (cd321x->port_altmode_tbt)
> +		typec_unregister_altmode(cd321x->port_altmode_tbt);

You can call typec_unregister_altmode() unconditionally here - it's
NULL safe.

thanks,

> +	cd321x->port_altmode_dp = NULL;
> +	cd321x->port_altmode_tbt = NULL;
> +	typec_unregister_port(tps->port);
> +}

-- 
heikki

