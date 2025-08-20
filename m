Return-Path: <linux-kernel+bounces-777516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F55BB2DA62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD52C7AD17D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D602E2EE7;
	Wed, 20 Aug 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1am0LC2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60227265631;
	Wed, 20 Aug 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687244; cv=none; b=GdhWZ6OBhl39S6QQ5dI5/2m70u+9cDIw3gC2KZkefke4bolru3jIkmvqGU7DgeDWYoWBbR+xeVMt4J0r+2N6SaUSvnhSRZ8UKDVQM4Sz8pvdWoVA5fg1hycJF9f1bdBrWg++dQ8739Pi9Eiz7rdIfyylByL0LX7Bcj89Hd28oBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687244; c=relaxed/simple;
	bh=VTdYg98izYIB/sDNHQJ4qik2q3ViQAr0trBBkchcbs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lO2cEDMDfjXWk374NXArEmM84mDylXibOc7bEf736REAHmYYa+1EvFkeMVglf8NdLIS20VwRLPP2JgoG5z1Wlhcyb0fhh9fMeMrTQvG4K6M/oblufjmGDj+R0YWXuMwdGk6bD9uCfe7uYm4tElzyCdKIJ8gctfrIrXafVd1wBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1am0LC2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755687243; x=1787223243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VTdYg98izYIB/sDNHQJ4qik2q3ViQAr0trBBkchcbs4=;
  b=T1am0LC2MTJBGiYjjbs5V5fDF3UZ9ngZ7mGeL1DyUaFzE6Nt47uUANK9
   vRufL4YTWO8349eRsAPvFqar6NnGQmwu6ijtSligNXSEend0KVyvAgGQq
   /3YwecwV9c/WJYiIsSxqE2Yg5Cd7k02MsdE0z0LgLXftwB53sN/stcAZY
   WK2MPtMoaKRUIpxsA3y2vY4I7mtj110oaW+GFQPrYsUx5ISNfAjq+YC3k
   UzfG2Z6H4QbmykEmoI0LMvBlpntQ2UYsL9RwGZKcDq1Om8jKz75IOqDud
   fiJ+Wb9r1qXBRy1Jl9VhXXcF8if8hMamzIR/9AyC01vqPIC+U5U307hlf
   A==;
X-CSE-ConnectionGUID: j87m131MTQq1Dmyc6/9KQg==
X-CSE-MsgGUID: yP9/NQTBQ4WlxPq4phYTWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68657229"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="68657229"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 03:54:03 -0700
X-CSE-ConnectionGUID: PqPrIc1PQVCcBQb5MV/E8A==
X-CSE-MsgGUID: FzDqB6J+RuK/+ZRvgHoTpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168445580"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa008.fm.intel.com with SMTP; 20 Aug 2025 03:53:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 20 Aug 2025 13:53:57 +0300
Date: Wed, 20 Aug 2025 13:53:57 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] usb: typec: ucsi: Set alt_mode_override flag
Message-ID: <aKWpRUODDNG6xE4f@kuha.fi.intel.com>
References: <20250814184455.723170-1-akuchynski@chromium.org>
 <20250814184455.723170-4-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184455.723170-4-akuchynski@chromium.org>

On Thu, Aug 14, 2025 at 06:44:53PM +0000, Andrei Kuchynski wrote:
> This flag indicates that the PPM allows the OPM to change the currently
> negotiated alternate mode using the SET_NEW_CAM command.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 5739ea2abdd1..5ba8b1bc874b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1616,6 +1616,8 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  
>  	cap->driver_data = con;
>  	cap->ops = &ucsi_ops;
> +	cap->alt_mode_override =
> +		!!(con->ucsi->cap.features & UCSI_CAP_ALT_MODE_OVERRIDE);

One line is enough.

>  	if (ucsi->ops->update_connector)
>  		ucsi->ops->update_connector(con);
> -- 
> 2.51.0.rc0.215.g125493bb4a-goog

thanks,

-- 
heikki

