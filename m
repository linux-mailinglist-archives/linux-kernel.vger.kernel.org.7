Return-Path: <linux-kernel+bounces-739011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E30DB0C094
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08993BFCE5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8337F21D5B3;
	Mon, 21 Jul 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7ODmCEU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C4134CF;
	Mon, 21 Jul 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091180; cv=none; b=oajuHQsxGmjfSg4skuulf3AZiYSzK2CPwHCZVLGeMvTCAR6ZGYxTAvc5ktBkL9yn7p2o9l3lskqgsKD+zFbOyMnGa+z70IXnwto+jsD7WGOk5aNBowrg/TOrvAzVAgVipE8vvsYJaHbNN+eaqck5HA86wjdDxcvDN1z43T9nsuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091180; c=relaxed/simple;
	bh=kv77tXXi2oNOZ1a11xCcUva7ccdHhV1ThDD30CGrvow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH99vOPAbu3QuFf+E8s49oRvgTxJk/9jShrMB3k5eUW9R050Mjlg82SxgHTovk4YzaOvD1YeRvUbt4AldzYB3VGnJHYzLdAlzxrvwu0ZKfJbfroEEbGAGqXWddFUjloaiwEZUSURDZBVN5T/D+3gJiEo5ALqcHGuC33LF7rc+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7ODmCEU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753091178; x=1784627178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kv77tXXi2oNOZ1a11xCcUva7ccdHhV1ThDD30CGrvow=;
  b=k7ODmCEUp0WlOFYDUkLcoNc3yZBfYUC2HW/ebQqcB9W3B1Pz9h2rc5kS
   KSa1pLiac6tjce8YGwXsTojauvjOc8M26NcsVMbDiXC2yclib3NE2rt8I
   PkE5zYAl8XPAzAGkYEm9UifuPA+nKAzVNkzsEnHspiYOaMUqG+GUU5jPh
   cfREEVqhM13AeJkEiDsuSfMxVIuCLGJfzTpdBBr2sknlBiOKYH4y0RQ8D
   SpNu/TdYg2IIJvPyeaqJ3fO4bH2Z0EfGg6loo6T0FJMKqYHLNvCvFdVer
   bwu92C2o+0lGEMJvDRNudNZuYQSC/7GYn4ED3w4S3Ev/3Oe9C4R5Jr1No
   A==;
X-CSE-ConnectionGUID: 84r1XseoRWOgNfO8c3r++Q==
X-CSE-MsgGUID: Lnqd7mUIRZKPrZJU6FtKAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55258503"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55258503"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 02:46:18 -0700
X-CSE-ConnectionGUID: 8Y6zBTzpStO4romvjdPg6Q==
X-CSE-MsgGUID: beb0iTACTrOfKY+ZeBnrbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="164271395"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa004.fm.intel.com with SMTP; 21 Jul 2025 02:46:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Jul 2025 12:46:12 +0300
Date: Mon, 21 Jul 2025 12:46:12 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Benson Leung <bleung@chromium.org>
Cc: jthies@google.com, gregkh@linuxfoundation.org, hansg@kernel.org,
	sebastian.reichel@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
	madhu.m@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, bleung@google.com
Subject: Re: [PATCH] usb: typec: ucsi: psy: Set current max to 100mA for BC
 1.2 and Default
Message-ID: <aH4MZHvgg1V6u_Bv@kuha.fi.intel.com>
References: <20250717200805.3710473-1-bleung@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717200805.3710473-1-bleung@chromium.org>

On Thu, Jul 17, 2025 at 08:08:05PM +0000, Benson Leung wrote:
> ucsi_psy_get_current_max would return 0mA as the maximum current if
> UCSI detected a BC or a Default USB Power sporce.
> 
> The comment in this function is true that we can't tell the difference
> between DCP/CDP or SDP chargers, but we can guarantee that at least 1-unit
> of USB 1.1/2.0 power is available, which is 100mA, which is a better
> fallback value than 0, which causes some userspaces, including the ChromeOS
> power manager, to regard this as a power source that is not providing
> any power.
> 
> In reality, 100mA is guaranteed from all sources in these classes.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/psy.c  | 2 +-
>  drivers/usb/typec/ucsi/ucsi.h | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 62ac69730405..62a9d68bb66d 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -164,7 +164,7 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
>  	case UCSI_CONSTAT_PWR_OPMODE_DEFAULT:
>  	/* UCSI can't tell b/w DCP/CDP or USB2/3x1/3x2 SDP chargers */
>  	default:
> -		val->intval = 0;
> +		val->intval = UCSI_TYPEC_DEFAULT_CURRENT * 1000;
>  		break;
>  	}
>  	return 0;
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index b711e1ecc378..ebd7c27c2cc7 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -483,9 +483,10 @@ struct ucsi {
>  #define UCSI_MAX_SVID		5
>  #define UCSI_MAX_ALTMODES	(UCSI_MAX_SVID * 6)
>  
> -#define UCSI_TYPEC_VSAFE5V	5000
> -#define UCSI_TYPEC_1_5_CURRENT	1500
> -#define UCSI_TYPEC_3_0_CURRENT	3000
> +#define UCSI_TYPEC_VSAFE5V		5000
> +#define UCSI_TYPEC_DEFAULT_CURRENT	 100
> +#define UCSI_TYPEC_1_5_CURRENT		1500
> +#define UCSI_TYPEC_3_0_CURRENT		3000
>  
>  struct ucsi_connector {
>  	int num;
> -- 
> 2.50.0.727.gbf7dc18ff4-goog

-- 
heikki

